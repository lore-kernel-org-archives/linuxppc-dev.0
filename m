Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 3274F2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Dec 2004 04:08:34 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id iB1HACgE020987
	for <linuxppc-embedded@ozlabs.org>; Wed, 1 Dec 2004 19:10:14 +0200 (EET)
Message-ID: <41ADF8E3.3070805@intracom.gr>
Date: Wed, 01 Dec 2004 19:01:23 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>,
	Conn Clark <clark@esteem.com>, Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="------------020103070007060904050302"
Subject: [PATCH] MPC8xx Idle support for 2.4.28
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020103070007060904050302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi there

The following patch implements idling support for the 8xx.

The patch works on the DUET family and the Normal Low mode
but could also work on other 8xxs easily; I just don't have
access to any other boards.

It's 2.4 for now since most people with 8xx's are on 2.4 still.

By using it on a 870 I see a power savings of ~400mW on a
133MHz/66MHz.

Regards

Pantelis

P.S. Many thanks to Mr. Conn Clark a.k.a. Obscene_CNN,
for it's only patch on an attempt.

P.S #2. There are alot of errata regarding PLPRCR for 8xx,
on older revisions of 8xx. Make sure you read them...

Signed-off-by: Pantelis Antoniou <panto@intracom.gr>

--------------020103070007060904050302
Content-Type: text/plain;
 name="8xx-idle.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8xx-idle.patch"

diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4/arch/ppc/8xx_io/Config.in linux-2.4-intracom/arch/ppc/8xx_io/Config.in
--- linux-2.4/arch/ppc/8xx_io/Config.in	2004-09-02 16:17:52 +03:00
+++ linux-2.4-intracom/arch/ppc/8xx_io/Config.in	2004-10-19 12:57:51 +03:00
@@ -4,10 +4,17 @@
 mainmenu_option next_comment
 comment 'MPC8xx Options'
 
+if [ "$CONFIG_8xx_SMC1" = "y" -o "$CONFIG_8xx_SMC2" = "y" -o \
+	"$CONFIG_8xx_SCC1" = "y" -o "$CONFIG_8xx_SCC2" = "y" -o \
+	"$CONFIG_8xx_SCC3" = "y" -o "$CONFIG_8xx_SCC4" = "y" ]; then
+	define_bool CONFIG_8xx_STD_SERIAL y
+fi
+
 comment 'Generic MPC8xx Options'
 bool 'Copy-Back Data Cache (else Writethrough)' CONFIG_8xx_COPYBACK
 bool 'CPU6 Silicon Errata (860 Pre Rev. C)' CONFIG_8xx_CPU6
 bool 'I2C/SPI Microcode Patch' CONFIG_UCODE_PATCH
+bool 'DUET support (87x/88x)' CONFIG_DUET
 
 comment 'MPC8xx CPM Options'
 if [ "$CONFIG_NET_ETHERNET" = "y" ]; then
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4/arch/ppc/config.in linux-2.4-intracom/arch/ppc/config.in
--- linux-2.4/arch/ppc/config.in	2004-09-02 16:17:52 +03:00
+++ linux-2.4-intracom/arch/ppc/config.in	2004-12-01 17:06:52 +02:00
@@ -55,6 +55,21 @@
   define_bool CONFIG_PPC_STD_MMU y
 fi
 
+if [ "$CONFIG_8xx" = "y" ]; then
+  bool 'MPC8xx CPU Idle Support' CONFIG_8xx_IDLE
+  if [ "$CONFIG_8xx_IDLE" = "y" ]; then
+    if [ "$CONFIG_DUET" != "y" ]; then
+      choice 'Idle method' \
+	  "Normal-Low	CONFIG_8xx_IDLE_NORMAL_LOW	\
+	   Doze-High	CONFIG_8xx_IDLE_DOZE_HIGH	\
+	   Doze-Low	CONFIG_8xx_IDLE_DOZE_LOW"	CONFIG_8xx_IDLE_NORMAL_LOW
+    else
+      # DUET only supports NORMAL_LOW mode
+      define_bool CONFIG_8xx_IDLE_NORMAL_LOW y
+    fi
+  fi
+fi
+
 if [ "$CONFIG_8260" = "y" ]; then
   define_bool CONFIG_SERIAL_CONSOLE y
   define_bool CONFIG_CPM2 y
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4/arch/ppc/kernel/Makefile linux-2.4-intracom/arch/ppc/kernel/Makefile
--- linux-2.4/arch/ppc/kernel/Makefile	2004-09-02 16:17:53 +03:00
+++ linux-2.4-intracom/arch/ppc/kernel/Makefile	2004-11-19 11:12:59 +02:00
@@ -40,7 +40,11 @@
 					semaphore.o syscalls.o setup.o \
 					cputable.o ppc_htab.o
 ifneq ($(CONFIG_6xx),y)
-obj-y				+= idle_gen.o
+ ifeq ($(CONFIG_8xx_IDLE),y)
+  obj-y				+= idle_8xx.o
+ else
+  obj-y				+= idle_gen.o
+ endif
 endif
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
@@ -102,6 +106,7 @@
 head_44x.o: head_44x.S ppc_defs.h
 head_8xx.o: head_8xx.S ppc_defs.h
 idle_6xx.o: idle_6xx.S ppc_defs.h
+idle_8xx.o: idle_8xx.S ppc_defs.h
 
 ppc_defs.h: mk_defs.c ppc_defs.head \
 		$(TOPDIR)/include/asm/mmu.h \
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4/arch/ppc/kernel/cputable.c linux-2.4-intracom/arch/ppc/kernel/cputable.c
--- linux-2.4/arch/ppc/kernel/cputable.c	2004-10-19 09:29:02 +03:00
+++ linux-2.4-intracom/arch/ppc/kernel/cputable.c	2004-12-01 18:24:13 +02:00
@@ -408,7 +408,11 @@
     {	/* 8xx */
     	0xffff0000, 0x00500000, "8xx",
 		/* CPU_FTR_CAN_DOZE is possible, if the 8xx code is there.... */
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB
+#ifdef CONFIG_8xx_IDLE
+		| CPU_FTR_CAN_DOZE
+#endif
+		,
     	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
  	16, 16,
 	__setup_cpu_8xx	/* Empty */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4/arch/ppc/kernel/head_8xx.S linux-2.4-intracom/arch/ppc/kernel/head_8xx.S
--- linux-2.4/arch/ppc/kernel/head_8xx.S	2004-09-02 16:17:53 +03:00
+++ linux-2.4-intracom/arch/ppc/kernel/head_8xx.S	2004-12-01 18:24:13 +02:00
@@ -667,11 +667,11 @@
 	SAVE_8GPRS(24, r21)
 	andi.	r23,r23,MSR_PR
 	mfspr	r23,SPRG3		/* if from user, fix up THREAD.regs */
-	beq	2f
+	addi	r2,r23,-THREAD		/* set r2 to current */
+	beq	0f
 	addi	r24,r1,STACK_FRAME_OVERHEAD
 	stw	r24,PT_REGS(r23)
-2:	addi	r2,r23,-THREAD		/* set r2 to current */
-	tovirt(r2,r2)
+0:	tovirt(r2,r2)
 	mflr	r23
 	andi.	r24,r23,0x3f00		/* get vector offset */
 	stw	r24,TRAP(r21)
@@ -683,7 +683,13 @@
 	cmplw	1,r1,r24
 	crand	1,1,4
 	bgt-	stack_ovf		/* if r2 < r1 < r2+TASK_STRUCT_SIZE */
+
 	lwz	r24,0(r23)		/* virtual address of handler */
+#ifdef CONFIG_8xx_IDLE
+	mtctr	r24			/* save to ctr */
+	lis	r24,power_save_8xx_restore@h
+	ori	r24,r24,power_save_8xx_restore@l
+#endif
 	lwz	r23,4(r23)		/* where to go when done */
 	mtspr	SRR0,r24
 	mtspr	SRR1,r20
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4/arch/ppc/kernel/idle_8xx.S linux-2.4-intracom/arch/ppc/kernel/idle_8xx.S
--- linux-2.4/arch/ppc/kernel/idle_8xx.S	1970-01-01 02:00:00 +02:00
+++ linux-2.4-intracom/arch/ppc/kernel/idle_8xx.S	2004-12-01 17:06:52 +02:00
@@ -0,0 +1,114 @@
+/*
+ *  This file contains the power_save function for 8xx CPUs
+ *  rewritten in assembler
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/ppc_asm.h>
+#include "ppc_defs.h"
+
+	.text
+
+#define CSRC		21
+#define LPM1		22
+#define LPM0		23
+
+#define CSRCM		(1 << (31 - CSRC))
+#define LPM1M		(1 << (31 - LPM1))
+#define LPM0M		(1 << (31 - LPM0))
+
+#if defined(CONFIG_8xx_IDLE_NORMAL_LOW)
+#define SETMSK	CSRCM
+#elif defined(CONFIG_8xx_IDLE_DOZE_HIGH)
+#define SETMSK	LPM0M
+#elif defined(CONFIG_8xx_IDLE_DOZE_LOW)
+#define SETMSK	(LPM0M | CSRCM)
+#else
+#error Not supported mode.
+#endif
+
+#define PLPRCRK	0x0384
+#define PLPRCR	0x0284
+
+/*
+ * Here is the power_save function. This could eventually be
+ * split into several functions & changing the function pointer
+ * depending on the various features.
+ */
+	.globl	power_save
+power_save:
+	mfspr   r5, IMMR
+	rlwinm  r5, r5,0,0,15	/* only high 16 bits count */
+
+	/* Clear MSR:EE */
+	mfmsr	r7
+	rlwinm	r0,r7,0,17,15
+2:	mtmsr	r0
+
+	/* Check current->need_resched */
+	lwz	r4,NEED_RESCHED(r2)
+	cmpi	0,r4,0
+	bne-	1f
+
+	/* enter low power */
+	lwz	r4,PLPRCR(r5)	/* load PLPRCR		   */
+	andi.	r4,r4,SETMSK
+	bne	0f
+	lis	r4,0x55cc	/* load key                */
+	ori	r4,r4,0xaa33
+	stw	r4,PLPRCRK(r5)	/* unlock PLPRCR register  */
+	lwz	r4,PLPRCR(r5)	/* load PLPRCR             */
+	rlwinm  r24,r24,0,23+1,16-1
+	ori	r4,r4,SETMSK	/* set these bits          */
+	stw	r4,PLPRCR(r5)	/* store PLPRCR            */
+	li	r4,0
+	stw	r4,PLPRCRK(r5)	/* lock PLPRCR register    */
+
+0:	mtmsr	r7		/* enable interrupts       */
+	b	2b		/* and test again	   */
+
+	/* leave low power */
+1:	lwz	r4,PLPRCR(r5)	/* load PLPRCR             */
+	andi.	r4,r4,SETMSK	/* test if already out	   */
+	beq	0f
+	lis	r4,0x55cc	/* load key                */
+	ori	r4,r4,0xaa33
+	stw	r4,PLPRCRK(r5)	/* unlock PLPRCR register  */
+	lwz	r4,PLPRCR(r5)	/* load PLPRCR             */
+	rlwinm  r24,r24,0,23+1,16-1
+	stw	r4,PLPRCR(r5)	/* store PLPRCR            */
+	li	r4,0
+	stw	r4,PLPRCRK(r5)	/* lock PLPRCR register    */
+
+	/* and we're out */
+0:	mtmsr	r7
+	blr
+
+	/**************************************/
+
+	.globl	power_save_8xx_restore
+power_save_8xx_restore:
+	mfspr	r20,IMMR
+	rlwinm	r20,r20,0,0,15	/* only high 16 bits count */
+	lwz	r24,PLPRCR(r20)	/* load PLPRCR		   */
+	andi.	r24,r24,SETMSK
+	beqctr			/* jump if not low power  */
+	lis	r24,0x55cc	/* load key                */
+	ori	r24,r24,0xaa33
+	stw	r24,PLPRCRK(r20)/* unlock PLPRCR register  */
+	lwz	r24,PLPRCR(r20)	/* load PLPRCR             */
+	rlwinm  r24,r24,0,23+1,16-1
+	stw	r24,PLPRCR(r20)	/* store PLPRCR            */
+	li	r24,0
+	stw	r24,PLPRCRK(r20)/* lock PLPRCR register    */
+	bctr			/* jump to handler */
+
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4/arch/ppc/kernel/m8xx_setup.c linux-2.4-intracom/arch/ppc/kernel/m8xx_setup.c
--- linux-2.4/arch/ppc/kernel/m8xx_setup.c	2004-09-02 16:17:53 +03:00
+++ linux-2.4-intracom/arch/ppc/kernel/m8xx_setup.c	2004-12-01 18:24:13 +02:00
@@ -118,6 +118,73 @@
 	printk ("timebase_interrupt()\n");
 }
 
+#ifdef CONFIG_8xx_IDLE
+
+/* these are the DUET defines */
+#define PLPRCR_MFN_MSK  0xF8000000      /* Multiplication factor numerator bits */
+#define PLPRCR_MFN_SHIFT        27      /* Multiplication factor numerator shift*/
+#define PLPRCR_MFD_MSK  0x07C00000      /* Multiplication factor denominator bits */
+#define PLPRCR_MFD_SHIFT        22      /* Multiplication factor denominator shift*/
+#define PLPRCR_S_MSK    0x00300000      /* Multiplication factor integer bits   */
+#define PLPRCR_S_SHIFT          20      /* Multiplication factor integer shift  */
+#define PLPRCR_MFI_MSK  0x000F0000      /* Multiplication factor integer bits   */
+#define PLPRCR_MFI_SHIFT        16      /* Multiplication factor integer shift  */
+                                                                                                                                                                                 
+#define PLPRCR_PDF_MSK  0x0000001E      /* Predivision Factor bits              */
+#define PLPRCR_PDF_SHIFT         1      /* Predivision Factor shift value       */
+
+#define PLPRCR_val(a) ((((volatile immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr & \
+				PLPRCR_ ## a ## _MSK) >> PLPRCR_ ## a ## _SHIFT)
+
+/* max GCLK as of this writing */
+#define MAX_GCLK	133333333
+#define MAX_MULT	(((unsigned int)-1) / MAX_GCLK)
+#define RPREC		2	/* bits of rounding precision */
+#define RPRECHALF	(1 << (RPREC - 1))
+
+#ifdef CONFIG_DUET
+
+/* XXX it could overflow; be sure to check */
+int get_tbclk(int gclk)
+{
+	unsigned int xin, mfi, mfd, mfn, s, pdf, mult;
+	unsigned int num, denum;
+
+	mfi = PLPRCR_val(MFI);
+	mfd = PLPRCR_val(MFD);
+	mfn = PLPRCR_val(MFN);
+	s   = PLPRCR_val(S);
+	pdf = PLPRCR_val(PDF);
+
+	if (mfn == 0) {
+		mult  = (pdf + 1) << s;
+		denum = mfi;
+	} else {
+		mult  = ((mfd + 1) * (pdf + 1)) << s;
+		denum = (mfi * mfd + mfi + mfn);
+	}
+
+	/* printk(KERN_INFO "gclk = %u, pdf=%u, mfi=%u, mfd=%u, mfn=%u, s=%u\n",
+			gclk, pdf, mfi, mfd, mfn, s); */
+
+	num  = gclk * mult;
+	xin = (((num << RPREC) / denum) + RPRECHALF) >> RPREC;
+
+	printk(KERN_INFO "Calculated XIN %u\n", xin);
+
+	if (gclk >= 66666666)
+		return xin / 4;
+	return xin / 16;
+}
+
+#else
+
+#error Supply the get_tbclk clock function
+
+#endif
+
+#endif
+
 /* The decrementer counts at the system (internal) clock frequency divided by
  * sixteen, or external oscillator divided by four.  We force the processor
  * to use system clock divided by sixteen.
@@ -125,22 +192,30 @@
 void __init m8xx_calibrate_decr(void)
 {
 	bd_t	*binfo = (bd_t *)__res;
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
 	int freq, fp, divisor;
 
 	/* Unlock the SCCR. */
-	((volatile immap_t *)IMAP_ADDR)->im_clkrstk.cark_sccrk = ~KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_clkrstk.cark_sccrk = KAPWR_KEY;
+	imap->im_clkrstk.cark_sccrk = ~KAPWR_KEY;
+	imap->im_clkrstk.cark_sccrk = KAPWR_KEY;
 
+#ifndef CONFIG_8xx_IDLE
 	/* Force all 8xx processors to use divide by 16 processor clock. */
-	((volatile immap_t *)IMAP_ADDR)->im_clkrst.car_sccr |= 0x02000000;
+	imap->im_clkrst.car_sccr |= 0x02000000;
 
 	/* Processor frequency is MHz.
 	 * The value 'fp' is the number of decrementer ticks per second.
 	 */
 	fp = binfo->bi_intfreq / 16;
-	freq = fp*60;	/* try to make freq/1e6 an integer */
+#else
+	/* we must use the XIN freq as base */
+	imap->im_clkrst.car_sccr = (imap->im_clkrst.car_sccr & ~0x02000000) | 0x00800000;
+	fp = get_tbclk(binfo->bi_intfreq);
+#endif
+
+	freq = fp * 60;	/* try to make freq/1e6 an integer */
         divisor = 60;
-        printk("Decrementer Frequency = %d/%d\n", freq, divisor);
+        printk(KERN_INFO "Decrementer Frequency = %d/%d\n", freq, divisor);
         tb_ticks_per_jiffy = freq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
 
@@ -159,28 +234,24 @@
 	 * we guarantee the registers are locked, then we unlock them
 	 * for our use.
 	 */
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_tbscrk = ~KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtcsck = ~KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_tbk    = ~KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_tbscrk =  KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtcsck =  KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_tbk    =  KAPWR_KEY;
+	imap->im_sitk.sitk_tbscrk = ~KAPWR_KEY;
+	imap->im_sitk.sitk_rtcsck = ~KAPWR_KEY;
+	imap->im_sitk.sitk_tbk    = ~KAPWR_KEY;
+	imap->im_sitk.sitk_tbscrk =  KAPWR_KEY;
+	imap->im_sitk.sitk_rtcsck =  KAPWR_KEY;
+	imap->im_sitk.sitk_tbk    =  KAPWR_KEY;
 
 	/* Disable the RTC one second and alarm interrupts. */
-	((volatile immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc &=
-						~(RTCSC_SIE | RTCSC_ALE);
+	imap->im_sit.sit_rtcsc &= ~(RTCSC_SIE | RTCSC_ALE);
 	/* Enable the RTC */
-	((volatile immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc |=
-						(RTCSC_RTF | RTCSC_RTE);
+	imap->im_sit.sit_rtcsc |= (RTCSC_RTF | RTCSC_RTE);
 
 	/* Enabling the decrementer also enables the timebase interrupts
 	 * (or from the other point of view, to get decrementer interrupts
 	 * we have to enable the timebase).  The decrementer interrupt
 	 * is wired into the vector table, nothing to do here for that.
 	 */
-	((volatile immap_t *)IMAP_ADDR)->im_sit.sit_tbscr =
-				((mk_int_int_mask(DEC_INTERRUPT) << 8) |
-					 (TBSCR_TBF | TBSCR_TBE));
+	imap->im_sit.sit_tbscr = ((mk_int_int_mask(DEC_INTERRUPT) << 8) | (TBSCR_TBF | TBSCR_TBE));
 
 	if (request_irq(DEC_INTERRUPT, timebase_interrupt, 0, "tbint",
 				NULL) != 0)
@@ -201,9 +272,11 @@
 static int
 m8xx_set_rtc_time(unsigned long time)
 {
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtck = KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_sit.sit_rtc = time;
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtck = ~KAPWR_KEY;
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+
+	imap->im_sitk.sitk_rtck = KAPWR_KEY;
+	imap->im_sit.sit_rtc = time;
+	imap->im_sitk.sitk_rtck = ~KAPWR_KEY;
 	return(0);
 }
 
@@ -218,10 +291,14 @@
 m8xx_restart(char *cmd)
 {
 	__volatile__ unsigned char dummy;
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
 	uint	msr;
 
 	cli();
-	((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr |= 0x00000080;
+
+	/* someone must unlock */
+	imap->im_clkrstk.cark_plprcrk = KAPWR_KEY;
+	imap->im_clkrst.car_plprcr |= 0x00000080;
 
 	/* Clear the ME bit in MSR to cause checkstop on machine check
 	*/
@@ -229,7 +306,7 @@
 	msr &= ~0x1000;
 	__asm__("mtmsr %0" : : "r" (msr) );
 
-	dummy = ((immap_t *)IMAP_ADDR)->im_clkrst.res[0];
+	dummy = imap->im_clkrst.res[0];
 	printk("Restart failed\n");
 	while(1);
 }
@@ -246,7 +323,6 @@
    m8xx_restart(NULL);
 }
 
-
 static int
 m8xx_show_percpuinfo(struct seq_file *m, int i)
 {
@@ -254,9 +330,16 @@
 
 	bp = (bd_t *)__res;
 
-	seq_printf(m, "clock\t\t: %dMHz\n"
-		   "bus clock\t: %dMHz\n",
+	seq_printf(m, "clock\t\t: %ldMHz\n"
+		   "bus clock\t: %ldMHz\n",
 		   bp->bi_intfreq / 1000000,
 		   bp->bi_busfreq / 1000000);
 
+	seq_printf(m, "features\t:");
+#ifdef CONFIG_8xx_IDLE
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_CAN_DOZE)
+		seq_printf(m, " CAN_DOZE");
+#endif
+	seq_printf(m, "\n");
+
 	return 0;
}


--------------020103070007060904050302--
