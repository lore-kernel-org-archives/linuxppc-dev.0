Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <200310201305.IAA20143@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Rakesh jagota <j.rakesh@gdatech.co.in>
Reply-To: j.rakesh@gdatech.co.in
To: linuxppc-embedded@lists.linuxppc.org
Subject: couldn't find the kernel version the module was compiled for
Date: Mon, 20 Oct 2003 18:35:34 +0530
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I am working on mpc8245 based board. I ahve compiled he rtc driver as a
seperate modules. I have 2 function in assembly file i2c2.S. Its getting
compiled but when I am inserting the module I am getting the above mentioned
error.

i2c2.o: couldn't find the kernel version the module was compiled for
x1226.o: Unresolved symbol load_runtime_reg
x1226.o: Unresolved symbol store_runtime_reg


The assembly file is like this:
/**************************************
 *
 * copyright @ Motorola, 1999
 *
 **************************************/

#include <linux/config.h>
#define CONFIG_HARD_I2C
#ifdef CONFIG_HARD_I2C
//#include <ppc_asm.tmpl>
#include <linux/ppc_asm.tmpl>

#include <asm/mmu.h>
/**********************************************************
 * function: load_runtime_reg
 *
 * input:  r3 - value of eumbbar
 *         r4 - register offset in embedded utility space
 *
 * output: r3 - register content
 **********************************************************/
      .text
      .align 2
      .globl load_runtime_reg
load_runtime_reg:
	      lwbrx r3,r4,r3
	      sync
 	      bclr 20, 0

/****************************************************************
 * function: store_runtime_reg
 *
 * input: r3 - value of eumbbar
 *        r4 - register offset in embedded utility space
 *        r5 - new value to be stored
 *
 ****************************************************************/
           .text
           .align 2
           .global store_runtime_reg
store_runtime_reg:
	      stwbrx r5,  r4, r3
	      sync
              bclr   20,0

/*
_GLOBAL(load_runtime_reg)
	      lwbrx r3,r4,r3
	      sync
 	      bclr 20, 0

_GLOBAL(store_runtime_reg)
	      stwbrx r5,  r4, r3
	      sync
              bclr   20,0
*/
#endif /* CONFIG_HARD_I2C */

How can I avoid this.

Thanks & Regards,

rakesh

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
