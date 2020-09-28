//
//  ViewController.m
//  17.collectionView+VC
//
//  Created by apple on 2020/9/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ViewController.h"

#import "CustomViewController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray * childVCs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childVCs.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    
    for (UIView * subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    CustomViewController * vc = self.childVCs[row];
    vc.index = row;
    [self addChildViewController:vc];
    [cell.contentView addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height);
    
    
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = YES;
        if (@available(iOS 10.0, *)) {
            _collectionView.prefetchingEnabled = NO;    // 不预加载下一页
        }
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}

- (NSMutableArray *)childVCs{
    if (_childVCs == nil) {
        NSArray * array = @[[CustomViewController new], [CustomViewController new], [CustomViewController new], [CustomViewController new]];
        _childVCs = [NSMutableArray arrayWithArray:array];
    }
    return _childVCs;
}

@end
