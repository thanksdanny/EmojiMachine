//
//  ViewController.m
//  EmojiMachine
//
//  Created by Danny Ho on 3/7/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *emojiPickerView;
@property (weak, nonatomic) IBOutlet UIButton *goBtn;
@property (weak, nonatomic) IBOutlet UILabel *bingoLabel;
@property (nonatomic) CGRect bounds;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSMutableArray *dataArray1;
@property (nonatomic, strong) NSMutableArray *dataArray2;
@property (nonatomic, strong) NSMutableArray *dataArray3;


@end

@implementation ViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArray = @[@"👻",@"👸",@"💩",@"😘",@"🍔",@"🤖",@"🍟",@"🐼",@"🚖",@"🐷"];

    self.emojiPickerView.delegate = self;
    self.emojiPickerView.dataSource = self;
    self.bounds = CGRectZero;
    
    self.dataArray1 = [[NSMutableArray alloc] init];
    self.dataArray2 = [[NSMutableArray alloc] init];
    self.dataArray3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 100; i++) {
        [self.dataArray1 addObject:@(arc4random() % 10)];
        [self.dataArray2 addObject:@(arc4random() % 10)];
        [self.dataArray3 addObject:@(arc4random() % 10)];
    }
    
    self.goBtn.layer.cornerRadius = 6;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - goAction

- (IBAction)goBtnDidTouch {
    [self.emojiPickerView selectRow:arc4random() % 90 + 3 inComponent:0 animated:YES];
    [self.emojiPickerView selectRow:arc4random() % 90 + 3 inComponent:1 animated:YES];
    [self.emojiPickerView selectRow:arc4random() % 90 + 3 inComponent:2 animated:YES];
    
    NSLog(@"%@", self.dataArray1[[self.emojiPickerView selectedRowInComponent:0]]);
    if (self.dataArray1[[self.emojiPickerView selectedRowInComponent:0]] == self.dataArray2[[self.emojiPickerView selectedRowInComponent:1]] &&
        self.dataArray2[[self.emojiPickerView selectedRowInComponent:1]] == self.dataArray3[[self.emojiPickerView selectedRowInComponent:2]]) {
        self.bingoLabel.text = @"Bingo!";
    } else {
        self.bingoLabel.text = @"💔";
    }
    
    // animate
//    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.1 initialSpringVelocity:5 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.goBtn.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width + 20, self.bounds.size.height);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            self.goBtn.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
//        } completion:nil];
//    }];
}

#pragma mark - pickerDelegate & dataSource

// 每列个数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 100;
}

// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100.0;
}

//
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 100.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = [[UILabel alloc] init];
    if (component == 0) {
        pickerLabel.text = self.imageArray[[self.dataArray1[row] integerValue]];
//        pickerLabel.text = self.imageArray[(int)self.dataArray3[row]]; // 错误写法 应该number转回数字，之前一直被这里坑了
    } else if (component == 1) {
        pickerLabel.text = self.imageArray[[self.dataArray2[row] integerValue]];
    } else {
        pickerLabel.text = self.imageArray[[self.dataArray3[row] integerValue]];
    }
    
    pickerLabel.font = [UIFont fontWithName:@"Apple Color Emoji" size:80];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    
    return pickerLabel;
}


@end
