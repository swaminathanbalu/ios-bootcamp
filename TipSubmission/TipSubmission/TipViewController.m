//
//  ViewController.m
//  TipSubmission
//
//  Created by Swaminathan Balu on 10/4/15.
//  Copyright (c) 2015 Swaminathan Balu. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (strong, nonatomic) IBOutlet UITextField *billAmount;
@property (strong, nonatomic) IBOutlet UILabel *tipAmount;
@property (strong, nonatomic) IBOutlet UILabel *totalAmount;
@property (strong, nonatomic) IBOutlet UISegmentedControl *tipSelector;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"Tip Calculator";
    [[self.billAmount viewWithTag:(0) ] becomeFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [defaults integerForKey:@"default_tip_percent"];
    self.tipSelector.selectedSegmentIndex=intValue;
    [self updateValues];
}


- (IBAction)onChange:(id)sender {
    [self updateValues];
}

- (IBAction)onValueChange:(id)sender {
    [self.view endEditing:(YES)];
    [self updateValues];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:(YES)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateValues{
    float billValue = [self.billAmount.text floatValue];
    NSArray *tips = @[@(.15),@(.2),@(.25)];
    
    float tipAmount = [tips[self.tipSelector.selectedSegmentIndex] floatValue]*billValue;
    float total = billValue+tipAmount;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *tip = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:tipAmount]];
    NSString *tot = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    
    self.tipAmount.text=[NSString stringWithFormat:@"%@", tip];
    self.totalAmount.text=[NSString stringWithFormat:@"%@", tot];
}

@end
