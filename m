Return-Path: <morphicsk@yahoo.com>
Received: from web36913.mail.mud.yahoo.com (web36913.mail.mud.yahoo.com
	[209.191.85.81]) by ozlabs.org (Postfix) with SMTP id DC3E767A5F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 21:38:18 +1000 (EST)
Message-ID: <20060627113137.2386.qmail@web36913.mail.mud.yahoo.com>
Date: Tue, 27 Jun 2006 04:31:37 -0700 (PDT)
From: Jagan <morphicsk@yahoo.com>
Subject: Reg RISC timers in MPC 8260
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all

We have a requirement of running a periodic timer for
5 millisecond using RISC timers in CPM module of
MPC8260. The OS is monta vista linux and target is
MPC8260 I have written a sample code to start a
periodic timer using MPC8260. 

But it hangs when SET TIMER command is issued to the
CPCR register. The cross compiler we r using is
ppc_82xx-gcc.
 
Can anyone pls help me in getting this right ?

I am pasting the code here 
------------------------------------------------------
/*Start of code snippet  ignoring the header files */
cpm8xx_t	*cpmp;

volatile immap_t *immap = (immap_t *)IMAP_ADDR;

#define CPCR_OPCODE ( 8 << 8 ) /* CPCR Opcode Field:
SET TIMER */
#define CPCR_CHNUM ( 5 << 4 ) /* CPCR Ch Num Field:
SPI/IDMA2/RISC Timers */
#define CPCR_FLAG ( 1 << 0 ) /* CPCR Flag Field:
Process Command */
#define PROFF_RISCTT	((uint)0x01B0)

void risc_timer_handler(int irq, void *dev_id, struct
pt_regs *regs)
{
 unsigned int i, rter;

 printk("Inside risc timer handler \n");
 /*read RTER to see which timers have caused
interrupts.
 */
 
 rter  = immap->im_cpm.cp_rter ;

 /*The RISC timer event bits are usually cleared
  *by this time
  */
 immap->im_cpm.cp_rter = 0xffff ; 

  
}

int  __init device_init(void)
{
   unsigned int ticks = 0;
   unsigned int interval  = 1000;
   unsigned short prescaler = 0; 
   volatile cpm8xx_t	*cp;


  /* 
   * Write the TIMEP bits of the RCCR with 111111 to
generate the slowest 
   * clock, This value generates a tick every 65,536
clocks, which is every 
   * 2.6 milliseconds at 25 MHz.
   */

   immap->im_cpm.cp_rccr = ( 0x3f << 8 );
   
   /*
    * Configure the TM_BASE in the RISC timer table
parameter RAM to point to a location in the
    * dual-port RAM with 4 bytes available.
    */ 
    


 //  rt_pram_t *rtt_pramp = (rt_pram_t
*)(&cpmp->cp_dparam[PROFF_RISCTT]);


   cp = (cpm8xx_t *)&(immap->im_cpm);

    
   
   rt_pram_t *rtt_pramp = (rt_pram_t *)&cp->cp_dparam;

   /*
   * Assuming the beginning of dual-port RAM is
available,
   * write 0x0000 to TM_BASE.
   */



    rtt_pramp->tm_base = 0x0000; 

 
//   rtt_pramp->tm_base = m8xx_cpm_dpalloc(16);      
logic 1

   /*Write 0x0000 to the TM_CNT field in the RISC
timer table 
    *parameter RAM to see how many ticks elapsed since
the RISC 
    *internal timer was enabled.
   */
   rtt_pramp->tm_cnt  = 0x0;

   /*Write 0xFFFF to the RTER to clear any previous
events.
    */

   immap->im_cpm.cp_rter = 0xffff;

   /* Write 0x0001 to the RTMR to enable RISC timer 0
    *  and timer 1 to generate an interrupt.
    */
   immap->im_cpm.cp_rtmr |= 0x1 ;



   if(
request_irq(SIU_INT_RISC,risc_timer_handler,0,0,0) <
0)
   {
     printk("\n unable to register the RISC timer
\n");
   }

  /*Write 0xC000_080D to the TM_CMD field of the RISC
timer table
    parameter RAM. This enables RISC timer 0 to
timeout after 2,061(decimal)
    ticks of the timer. The timer automatically
restarts after it times out. 	
  */ 

  rtt_pramp->tm_cmd = 0xC000080D ; 

  /* Enter Command:  SET TIMER */

  while (immap->im_cpm.cp_cpcr & CPM_CR_FLG);
         immap->im_cpm.cp_cpcr =
mk_cr_cmd(CPM_CR_CH_SPI, CPM_CR_SET_TIMER) |
CPM_CR_FLG;
  while (immap->im_cpm.cp_cpcr & CPM_CR_FLG);

 
  /* Set RCCR[TIME] to enable the RISC timer to
   * begin operation.  
   */

  immap->im_cpm.cp_rccr = ( 1 << 15 );


  return 0;
}



                                                      
                                                      
               
void cleanup_device(void)
{
 
 
  request_irq(SIU_INT_RISC, NULL, 0, 0,
		0);
                                                      
                                                      
               
  printk(KERN_INFO "cleaned up \n");
}
                                                      
                                                      
               
module_init(device_init);
module_exit(cleanup_device);
                                                      
                                                      
               
                                                      
                                                      
               
MODULE_LICENSE("GPL");
                                                      
                                                      
               
MODULE_AUTHOR("");
MODULE_DESCRIPTION("driver code");
                                                      
                                                      
               
EXPORT_NO_SYMBOLS;
/*End of code snippet  */
-------------------------------------------------------

Thanks in Advance 
Jagan

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
