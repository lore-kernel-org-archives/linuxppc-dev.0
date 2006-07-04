Return-Path: <jagannathanjay@aim.com>
Received: from imo-d06.mx.aol.com (imo-d06.mx.aol.com [205.188.157.38])
	by ozlabs.org (Postfix) with ESMTP id 038F567B8C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jul 2006 15:29:42 +1000 (EST)
Received: from jagannathanjay@aim.com
	by imo-d06.mx.aol.com (mail_out_v38_r7.5.) id 5.3b9.4bea0ea (57876)
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Jul 2006 01:24:25 -0400 (EDT)
Date: Tue, 04 Jul 2006 01:24:25 -0400
From: jagannathanjay@aim.com
Message-Id: <8C86D413FBE91BB-1070-1C62@FWM-D44.sysops.aol.com>
Subject: Reg. RISC Timers in MPC8260
Content-Type: text/plain; charset="us-ascii"; format=flowed
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

Sorry this a repost , as in the earlier post I had wrongly mentioned 
the Target OS as Monta Vista Linux.

We have a requirement of starting a 5 millisecond periodic timer . The 
target OS is Embedded Linux from Embedded Planet for MPC 8260 processor.

when i did a insmod of the module in the Target (MPC8260) it hangs 
while  enabling timer 1?

Can anyone tell me what's wrong with the code?

-------------------------------------------------------------------------
-------------------------------------------------------------------------
----------------

#include <asm/cpm_8260.h>



typedef struct risc_timer_pram {
    unsigned short  tm_base;    /* RISC Timer Table Base Address    */
    unsigned short  tm_ptr;     /* RISC Timer Table Pointer (internal)  */
    unsigned short  r_tmr;      /* RISC Timer Mode Register     */
    unsigned short  r_tmv;      /* RISC Timer Valid Register        */
    unsigned long   tm_cmd;     /* RISC Timer Command Register      */
    unsigned long   tm_cnt;     /* RISC Timer Internal Count        */
} rt_pram_t;


volatile immap_t *immap = (immap_t *)IMAP_ADDR;

void my_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{

 unsigned int i, rter;

 printk("*********** \n");
 /*read RTER to see which timers have caused interrupts.
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

   volatile cpm8260_t   *cp;


  /*
    * Write the TIMEP bits of the RCCR with 111111 to generate the 
slowest
    * clock, This value generates a tick every 65,536 clocks, which is 
every
   * 2.6 milliseconds at 25 MHz.
   */

   immap->im_cpm.cp_rccr = ( 0x3f << 8 );

   /*
     * Configure the TM_BASE in the RISC timer table parameter RAM to 
point to a location in the
    * dual-port RAM with 4 bytes available.
    */


   rt_pram_t *rtt_pramp = (rt_pram_t *)&immap->im_dpram1;

   /*
   * Assuming the beginning of dual-port RAM is available,
   * write 0x0000 to TM_BASE.
   */



    rtt_pramp->tm_base = 0x0000;



   /*Write 0x0000 to the TM_CNT field in the RISC timer table
    *parameter RAM to see how many ticks elapsed since the RISC
    *internal timer was enabled.
   */
   rtt_pramp->tm_cnt  = 0x0;

   /*Write 0xFFFF to the RTER to clear any previous events.
    */

   immap->im_cpm.cp_rter = 0xffff;

   /* Write 0x0001 to the RTMR to enable RISC timer 0
    *  and timer 1 to generate an interrupt.
    */
   immap->im_cpm.cp_rtmr |= 0x1 ;

   /* Write 0x0002_0000 to the SIU interrupt mask register (SIMR_L)
    * to allow the RISC timers to generate a system interrupt.
    */

   immap->im_intctl.ic_simrl = 0x00020000;

   /* Initialize the SIU interrupt configuration register */


   immap->im_intctl.ic_sicr = 0;



   if( request_irq(SIU_INT_RISC,my_timer_interrupt,0,0,0) < 0)
   {
     printk("\n unable to register the RISC timer \n");
   }

  /*Write 0xC000_080D to the TM_CMD field of the RISC timer table
     parameter RAM. This enables RISC timer 0 to timeout after 
2,061(decimal)
     ticks of the timer. The timer automatically restarts after it times 
out.    
  */

  rtt_pramp->tm_cmd = 0xC000080D ;

  /* Enter Command:  SET TIMER */

  while (immap->im_cpm.cp_cpcr & CPM_CR_FLG);
         immap->im_cpm.cp_cpcr = 
mk_cr_cmd(CPM_CR_TIMER_PAGE,CPM_CR_TIMER_SBLOCK,0,CPM_CR_SET_GADDR)|CPM_C
R_FLG;
  while (immap->im_cpm.cp_cpcr & CPM_CR_FLG);


  /* Set RCCR[TIME] to enable the RISC timer to
   * begin operation.
   */

  printk(KERN_INFO "enabling timer 1  ");
  immap->im_cpm.cp_rccr = ( 1 << 15 );


  return 0;
}



                                                                         

void cleanup_device(void)
{

  request_irq(SIU_INT_RISC, NULL, 0, 0,
        0);
                                                                         

  printk(KERN_INFO "cleaned up \n");
}
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------

Regards
Jagan
________________________________________________________________________
Check Out the new free AIM(R) Mail -- 2 GB of storage and 
industry-leading spam and email virus protection.
