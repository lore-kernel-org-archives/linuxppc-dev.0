Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: kingseft@samsung.co.kr
Date: Wed, 7 Nov 2001 15:03:56 +0900
Message-Id: <H00002af054f0701@MHS>
Subject: Question about Interrupt on MPC8xx
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain; charset=US-ASCII
To: @popmail.space.net (No recipients specified)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi,

 I have a question about interrupt on MPC8xx.
 I conneted Dip switch to IRQ1 on MPC860. When I push down the button, Interrupt occurred and interrupt service routine worked.
 But, I didn't understand that I set falling edge interrupt detection via SIEL on MPC8xx.
 when I push up Dip switch, my interrupt routein also worked.
 Why this happend in spite of setting falling edge??
 Could anyone help me with this problem? Any comments will help me.
 Thanks.

 Below is a test program that I tested.

--------- myirq1.c -------------------------------------------------
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
#include <linux/time.h>
#include "commproc.h"


static unsigned int count;

static void my_isr1(int irq, void * dev_id, struct pt_regs * regs)
{

	unsigned long immr; /* Internal Memory Map Register */


       	/*
    	* Get Pointer to Internal Memory Map
    	* XXX - could be global symbol for all kernel files
    	*/
   	asm( "mfspr %0,638": "=r" (immr) : );
   	immr &= 0xFFFF0000;

	// SIPEND
	((immap_t *)immr)->im_siu_conf.sc_sipend |= 0x20000000;

	printk(".\n");

}

int __init myirq_init(void)
{

	unsigned long immr;		/* Internal Memory Map Register		*/

       /*
   	* Get Pointer to Internal Memory Map
   	* XXX - could be global symbol for all kernel files
   	*/
  	asm( "mfspr %0,638": "=r"(immr) : );
  	immr &= 0xFFFF0000;

	/*  Make IRQ1 edge sensitive.  */
	//  Detect IRQ1 at falling Edge.
        ((immap_t *)immr)->im_siu_conf.sc_siel |= 0x20000000;


	// set SIMASK for IRQ1
	((immap_t *)immr)->im_siu_conf.sc_simask |= 0x20000000;

	//  wjluv comments!
	//  my_irq_init is excuted only once!
	//  IRQ1 related execution flow moves to my_isr!

	// SIPEND
	((immap_t *)immr)->im_siu_conf.sc_sipend |= 0x20000000;

        if(request_8xxirq(SIU_IRQ1, my_isr1,SA_INTERRUPT, "myirq1",NULL) != 0)
                printk("Could not allocate tpanel IRQ\n");

	return 0;
}

#ifdef MODULE
int init_module(void)
{
	return myirq_init();
}

void cleanup_module(void)
{
	free_irq(SIU_IRQ1, NULL);

}
#endif

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
