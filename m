From: kingseft@samsung.co.kr
Date: Thu, 1 Nov 2001 08:15:02 +0900
Message-Id: <H00002af054a63a1@MHS>
Subject: Question about Timer interrupt
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I have one problem about timer interrupt in MPC860.
I got simple timer interrupt routine. I think it prints out the messages when mpc8xx accept timer2 interrupt.
But It didn't work. Is there any error or missing??

Any comments will help me.

Thanks,

Jason Lee
kingseft@samsung.co.kr


[mytimer.c]
-------------------------------------------------------------------
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/signal.h>
#include <linux/errno.h>
#include <linux/mm.h>
#include <linux/poll.h>
#include <linux/miscdevice.h>
#include <linux/random.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <asm/uaccess.h>
#include <asm/system.h>
#include <asm/irq.h>
#include <asm/mpc8xx.h>
#include <asm/io.h>
#include <asm/delay.h>
#include "commproc.h"

/*
 * Timer commands
 */
#define TIMER_TGCR_EN1  0x0001
#define TIMER_TGCR_STP1 0x0002
#define TIMER_TGCR_EN2  0x0010
#define TIMER_TGCR_STP2 0x0020

static void my_isr(void *dev_id)
{
	volatile immap_t	*immap;
	volatile cpmtimer8xx_t 	*timers;

	immap = (immap_t *)IMAP_ADDR;
	timers = (cpmtimer8xx_t *)&(immap->im_cpmtimer);

	timers->cpmt_ter2 = 0xffff;
	timers->cpmt_tcn2 = 0;

	printk("catch...\n");

}

int __init mytimer_init(void)
{
	volatile immap_t	*immap;
	volatile cpmtimer8xx_t 	*timers;

	immap = (immap_t *)IMAP_ADDR;
	timers = (cpmtimer8xx_t *)&(immap->im_cpmtimer);

	timers->cpmt_tgcr = 0x0000;
	timers->cpmt_tmr2 = 0x0018;
	timers->cpmt_tcn2 = 0;
	timers->cpmt_trr2 = 62;
	timers->cpmt_ter2 = 0xffff;

	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr |= 0x00040000;	// enable timer 2 interrupts in the CPIC
	timers->cpmt_tgcr |= TIMER_TGCR_EN2;


	cpm_install_handler(CPMVEC_TIMER2, my_isr,NULL);
	return 0;
}

#ifdef MODULE
int init_module(void)
{
	printk("Installing Timer module by kingseft\n");
	return mytimer_init();
}

void cleanup_module(void)
{

	cpm_free_handler(CPMVEC_TIMER2);

	printk("Timer Module cleanup\n");
}
#endif


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
