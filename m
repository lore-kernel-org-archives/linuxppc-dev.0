Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DC6767A2C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2005 12:32:59 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 12:32:37 +1100
Message-Id: <1106011958.4533.25.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ppc32: pmac sleep support update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch updates the PowerMac sleep support. The ability to sleep is now broken
into 2 different flags, one, "may sleep" is set for all motherboards that we know
how to put to sleep and wakeup. It gets turned into "can sleep" upon a call from
the video driver indicating the ability to wakeup the video card. This doesn't
deal with head-less machines, but this can be improved later. It also adds better
cache flush code, which improves stability with cpufreq as well as sleep.

This patch actually breaks sleep support until the video drivers for the affected
machines have been updated. This will come as separate patches.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/platforms/pmac_cache.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc/platforms/pmac_cache.S	2005-01-18 12:01:49.000000000 +1100
@@ -0,0 +1,325 @@
+/*
+ * This file contains low-level cache management functions
+ * used for sleep and CPU speed changes on Apple machines.
+ * (In fact the only thing that is Apple-specific is that we assume
+ * that we can read from ROM at physical address 0xfff00000.)
+ *
+ *    Copyright (C) 2004 Paul Mackerras (paulus@samba.org) and
+ *                       Benjamin Herrenschmidt (benh@kernel.crashing.org)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/cputable.h>
+
+/*
+ * Flush and disable all data caches (dL1, L2, L3). This is used
+ * when going to sleep, when doing a PMU based cpufreq transition,
+ * or when "offlining" a CPU on SMP machines. This code is over
+ * paranoid, but I've had enough issues with various CPU revs and
+ * bugs that I decided it was worth beeing over cautious
+ */
+
+_GLOBAL(flush_disable_caches)
+BEGIN_FTR_SECTION
+	b	flush_disable_745x
+END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
+BEGIN_FTR_SECTION
+	b	flush_disable_75x
+END_FTR_SECTION_IFSET(CPU_FTR_L2CR)
+	b	__flush_disable_L1
+
+/* This is the code for G3 and 74[01]0 */
+flush_disable_75x:
+	mflr	r10
+
+	/* Turn off EE and DR in MSR */
+	mfmsr	r11
+	rlwinm	r0,r11,0,~MSR_EE
+	rlwinm	r0,r0,0,~MSR_DR
+	sync
+	mtmsr	r0
+	isync
+
+	/* Stop DST streams */
+BEGIN_FTR_SECTION
+	DSSALL
+	sync
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+
+	/* Stop DPM */
+	mfspr	r8,SPRN_HID0		/* Save HID0 in r8 */
+	rlwinm	r4,r8,0,12,10		/* Turn off HID0[DPM] */
+	sync
+	mtspr	SPRN_HID0,r4		/* Disable DPM */
+	sync
+
+	/* disp-flush L1 */
+	li	r4,0x4000
+	mtctr	r4
+	lis	r4,0xfff0
+1:	lwzx	r0,r0,r4
+	addi	r4,r4,32
+	bdnz	1b
+	sync
+	isync
+	
+	/* disable / invalidate / enable L1 data */
+	mfspr	r3,SPRN_HID0
+	rlwinm	r0,r0,0,~HID0_DCE
+	mtspr	SPRN_HID0,r3
+	sync
+	isync
+	ori	r3,r3,HID0_DCE|HID0_DCI
+	sync
+	isync
+	mtspr	SPRN_HID0,r3
+	xori	r3,r3,HID0_DCI
+	mtspr	SPRN_HID0,r3
+	sync
+
+	/* Get the current enable bit of the L2CR into r4 */
+	mfspr	r5,L2CR
+	/* Set to data-only (pre-745x bit) */
+	oris	r3,r5,L2CR_L2DO@h
+	b	2f
+	/* When disabling L2, code must be in L1 */
+	.balign 32
+1:	mtspr	L2CR,r3
+3:	sync
+	isync
+	b	1f
+2:	b	3f
+3:	sync
+	isync
+	b	1b
+1:	/* disp-flush L2. The interesting thing here is that the L2 can be
+	 * up to 2Mb ... so using the ROM, we'll end up wrapping back to memory
+	 * but that is probbaly fine. We disp-flush over 4Mb to be safe
+	 */
+	lis	r4,2
+	mtctr	r4
+	lis	r4,0xfff0
+1:	lwzx	r0,r0,r4
+	addi	r4,r4,32
+	bdnz	1b
+	sync
+	isync
+	/* now disable L2 */	
+	rlwinm	r5,r5,0,~L2CR_L2E
+	b	2f
+	/* When disabling L2, code must be in L1 */
+	.balign 32
+1:	mtspr	L2CR,r5
+3:	sync
+	isync
+	b	1f
+2:	b	3f
+3:	sync
+	isync
+	b	1b
+1:	sync
+	isync
+	/* Invalidate L2. This is pre-745x, we clear the L2I bit ourselves */
+	oris	r4,r5,L2CR_L2I@h
+	mtspr	L2CR,r4
+	sync
+	isync
+	xoris	r4,r4,L2CR_L2I@h
+	sync
+	mtspr	L2CR,r4
+	sync
+	
+	/* now disable the L1 data cache */
+	mfspr	r0,HID0
+	rlwinm	r0,r0,0,~HID0_DCE
+	mtspr	HID0,r0
+	sync
+	isync
+
+	/* Restore HID0[DPM] to whatever it was before */
+	sync
+	mtspr	SPRN_HID0,r8
+	sync
+
+	/* restore DR and EE */
+	sync
+	mtmsr	r11
+	isync
+
+	mtlr	r10
+	blr
+
+/* This code is for 745x processors */
+flush_disable_745x:
+	/* Turn off EE and DR in MSR */
+	mfmsr	r11
+	rlwinm	r0,r11,0,~MSR_EE
+	rlwinm	r0,r0,0,~MSR_DR
+	sync
+	mtmsr	r0
+	isync
+
+	/* Stop prefetch streams */
+	DSSALL
+	sync
+
+	/* Disable L2 prefetching */
+	mfspr	r0,SPRN_MSSCR0
+	rlwinm	r0,r0,0,0,29
+	mtspr	SPRN_MSSCR0,r0
+	sync
+	isync
+	lis	r4,0
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+
+	/* Due to a bug with the HW flush on some CPU revs, we occasionally
+	 * experience data corruption. I'm adding a displacement flush along
+	 * with a dcbf loop over a few Mb to "help". The problem isn't totally
+	 * fixed by this in theory, but at least, in practice, I couldn't reproduce
+	 * it even with a big hammer...
+	 */
+	 
+        lis     r4,0x0002
+        mtctr   r4
+ 	li      r4,0
+1:
+        lwzx    r0,r0,r4
+        addi    r4,r4,32                /* Go to start of next cache line */
+        bdnz    1b
+        isync
+
+        /* Now, flush the first 4MB of memory */
+        lis     r4,0x0002
+        mtctr   r4
+	li      r4,0
+        sync
+1:
+        dcbf    0,r4
+        addi    r4,r4,32                /* Go to start of next cache line */
+        bdnz    1b
+
+	/* Flush and disable the L1 data cache */
+	mfspr	r6,SPRN_LDSTCR
+	lis	r3,0xfff0	/* read from ROM for displacement flush */
+	li	r4,0xfe		/* start with only way 0 unlocked */
+	li	r5,128		/* 128 lines in each way */
+1:	mtctr	r5
+	rlwimi	r6,r4,0,24,31
+	mtspr	SPRN_LDSTCR,r6
+	sync
+	isync
+2:	lwz	r0,0(r3)	/* touch each cache line */
+	addi	r3,r3,32
+	bdnz	2b
+	rlwinm	r4,r4,1,24,30	/* move on to the next way */
+	ori	r4,r4,1
+	cmpwi	r4,0xff		/* all done? */
+	bne	1b
+	/* now unlock the L1 data cache */
+	li	r4,0
+	rlwimi	r6,r4,0,24,31
+	sync
+	mtspr	SPRN_LDSTCR,r6
+	sync
+	isync
+
+	/* Flush the L2 cache using the hardware assist */
+	mfspr	r3,L2CR
+	cmpwi	r3,0		/* check if it is enabled first */
+	bge	4f
+	oris	r0,r3,(L2CR_L2IO_745x|L2CR_L2DO_745x)@h
+	b	2f
+	/* When disabling/locking L2, code must be in L1 */
+	.balign 32
+1:	mtspr	L2CR,r0		/* lock the L2 cache */
+3:	sync
+	isync
+	b	1f
+2:	b	3f
+3:	sync
+	isync
+	b	1b
+1:	sync
+	isync
+	ori	r0,r3,L2CR_L2HWF_745x
+	sync
+	mtspr	L2CR,r0		/* set the hardware flush bit */
+3:	mfspr	r0,L2CR		/* wait for it to go to 0 */
+	andi.	r0,r0,L2CR_L2HWF_745x
+	bne	3b
+	sync
+	rlwinm	r3,r3,0,~L2CR_L2E
+	b	2f
+	/* When disabling L2, code must be in L1 */
+	.balign 32
+1:	mtspr	L2CR,r3		/* disable the L2 cache */
+3:	sync
+	isync
+	b	1f
+2:	b	3f
+3:	sync
+	isync
+	b	1b
+1:	sync
+	isync
+	oris	r4,r3,L2CR_L2I@h
+	mtspr	L2CR,r4
+	sync
+	isync
+1:	mfspr	r4,L2CR
+	andis.	r0,r4,L2CR_L2I@h
+	bne	1b
+	sync
+
+BEGIN_FTR_SECTION
+	/* Flush the L3 cache using the hardware assist */
+4:	mfspr	r3,L3CR
+	cmpwi	r3,0		/* check if it is enabled */
+	bge	6f
+	oris	r0,r3,L3CR_L3IO@h
+	ori	r0,r0,L3CR_L3DO
+	sync
+	mtspr	L3CR,r0		/* lock the L3 cache */
+	sync
+	isync
+	ori	r0,r0,L3CR_L3HWF
+	sync
+	mtspr	L3CR,r0		/* set the hardware flush bit */
+5:	mfspr	r0,L3CR		/* wait for it to go to zero */
+	andi.	r0,r0,L3CR_L3HWF
+	bne	5b
+	rlwinm	r3,r3,0,~L3CR_L3E
+	sync
+	mtspr	L3CR,r3		/* disable the L3 cache */
+	sync
+	ori	r4,r3,L3CR_L3I
+	mtspr	SPRN_L3CR,r4
+1:	mfspr	r4,SPRN_L3CR
+	andi.	r0,r4,L3CR_L3I
+	bne	1b
+	sync
+END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
+
+6:	mfspr	r0,HID0		/* now disable the L1 data cache */
+	rlwinm	r0,r0,0,~HID0_DCE
+	mtspr	HID0,r0
+	sync
+	isync
+	mtmsr	r11		/* restore DR and EE */
+	isync
+	blr
Index: linux-work/include/asm-ppc/uninorth.h
===================================================================
--- linux-work.orig/include/asm-ppc/uninorth.h	2004-11-22 11:50:50.000000000 +1100
+++ linux-work/include/asm-ppc/uninorth.h	2005-01-17 13:49:07.000000000 +1100
@@ -148,6 +148,55 @@
 #define UNI_N_AACK_DELAY		0x0100
 #define UNI_N_AACK_DELAY_ENABLE		0x00000001
 
+/* Clock status for Intrepid */
+#define UNI_N_CLOCK_STOP_STATUS0	0x0150
+#define UNI_N_CLOCK_STOPPED_EXTAGP	0x00200000
+#define UNI_N_CLOCK_STOPPED_AGPDEL	0x00100000
+#define UNI_N_CLOCK_STOPPED_I2S0_45_49	0x00080000
+#define UNI_N_CLOCK_STOPPED_I2S0_18	0x00040000
+#define UNI_N_CLOCK_STOPPED_I2S1_45_49	0x00020000
+#define UNI_N_CLOCK_STOPPED_I2S1_18	0x00010000
+#define UNI_N_CLOCK_STOPPED_TIMER	0x00008000
+#define UNI_N_CLOCK_STOPPED_SCC_RTCLK18	0x00004000
+#define UNI_N_CLOCK_STOPPED_SCC_RTCLK32	0x00002000
+#define UNI_N_CLOCK_STOPPED_SCC_VIA32	0x00001000
+#define UNI_N_CLOCK_STOPPED_SCC_SLOT0	0x00000800
+#define UNI_N_CLOCK_STOPPED_SCC_SLOT1	0x00000400
+#define UNI_N_CLOCK_STOPPED_SCC_SLOT2	0x00000200
+#define UNI_N_CLOCK_STOPPED_PCI_FBCLKO	0x00000100
+#define UNI_N_CLOCK_STOPPED_VEO0	0x00000080
+#define UNI_N_CLOCK_STOPPED_VEO1	0x00000040
+#define UNI_N_CLOCK_STOPPED_USB0	0x00000020
+#define UNI_N_CLOCK_STOPPED_USB1	0x00000010
+#define UNI_N_CLOCK_STOPPED_USB2	0x00000008
+#define UNI_N_CLOCK_STOPPED_32		0x00000004
+#define UNI_N_CLOCK_STOPPED_45		0x00000002
+#define UNI_N_CLOCK_STOPPED_49		0x00000001
+
+#define UNI_N_CLOCK_STOP_STATUS1	0x0160
+#define UNI_N_CLOCK_STOPPED_PLL4REF	0x00080000
+#define UNI_N_CLOCK_STOPPED_CPUDEL	0x00040000
+#define UNI_N_CLOCK_STOPPED_CPU		0x00020000
+#define UNI_N_CLOCK_STOPPED_BUF_REFCKO	0x00010000
+#define UNI_N_CLOCK_STOPPED_PCI2	0x00008000
+#define UNI_N_CLOCK_STOPPED_FW		0x00004000
+#define UNI_N_CLOCK_STOPPED_GB		0x00002000
+#define UNI_N_CLOCK_STOPPED_ATA66	0x00001000
+#define UNI_N_CLOCK_STOPPED_ATA100	0x00000800
+#define UNI_N_CLOCK_STOPPED_MAX		0x00000400
+#define UNI_N_CLOCK_STOPPED_PCI1	0x00000200
+#define UNI_N_CLOCK_STOPPED_KLPCI	0x00000100
+#define UNI_N_CLOCK_STOPPED_USB0PCI	0x00000080
+#define UNI_N_CLOCK_STOPPED_USB1PCI	0x00000040
+#define UNI_N_CLOCK_STOPPED_USB2PCI	0x00000020
+#define UNI_N_CLOCK_STOPPED_7PCI1	0x00000008
+#define UNI_N_CLOCK_STOPPED_AGP		0x00000004
+#define UNI_N_CLOCK_STOPPED_PCI0	0x00000002
+#define UNI_N_CLOCK_STOPPED_18		0x00000001
+
+/* Intrepid registe to OF do-platform-clockspreading */
+#define UNI_N_CLOCK_SPREADING		0x190
+
 /* Uninorth 1.5 rev. has additional perf. monitor registers at 0xf00-0xf50 */
 
 
Index: linux-work/arch/ppc/platforms/pmac_feature.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_feature.c	2004-12-01 16:06:14.000000000 +1100
+++ linux-work/arch/ppc/platforms/pmac_feature.c	2005-01-17 13:49:07.000000000 +1100
@@ -1177,6 +1177,39 @@
 			(void)MACIO_IN32(KEYLARGO_FCR3);
 			udelay(10);
 		}
+		if (macio->type == macio_intrepid) {
+			/* wait for clock stopped bits to clear */
+			u32 test0 = 0, test1 = 0;
+			u32 status0, status1;
+			int timeout = 1000;
+
+			UNLOCK(flags);
+			switch (number) {
+			case 0:
+				test0 = UNI_N_CLOCK_STOPPED_USB0;
+				test1 = UNI_N_CLOCK_STOPPED_USB0PCI;
+				break;
+			case 2:
+				test0 = UNI_N_CLOCK_STOPPED_USB1;
+				test1 = UNI_N_CLOCK_STOPPED_USB1PCI;
+				break;
+			case 4:
+				test0 = UNI_N_CLOCK_STOPPED_USB2;
+				test1 = UNI_N_CLOCK_STOPPED_USB2PCI;
+				break;
+			}
+			do {
+				if (--timeout <= 0) {
+					printk(KERN_ERR "core99_usb_enable: "
+					       "Timeout waiting for clocks\n");
+					break;
+				}
+				mdelay(1);
+				status0 = UN_IN(UNI_N_CLOCK_STOP_STATUS0);
+				status1 = UN_IN(UNI_N_CLOCK_STOP_STATUS1);
+			} while ((status0 & test0) | (status1 & test1));
+			LOCK(flags);
+		}
 	} else {
 		/* Turn OFF */
 		if (number < 4) {
@@ -1199,20 +1232,20 @@
 			udelay(1);
 		}
 		if (number == 0) {
-			MACIO_BIC(KEYLARGO_FCR0, KL0_USB0_CELL_ENABLE);
+			if (macio->type != macio_intrepid)
+				MACIO_BIC(KEYLARGO_FCR0, KL0_USB0_CELL_ENABLE);
 			(void)MACIO_IN32(KEYLARGO_FCR0);
 			udelay(1);
 			MACIO_BIS(KEYLARGO_FCR0, (KL0_USB0_PAD_SUSPEND0 | KL0_USB0_PAD_SUSPEND1));
 			(void)MACIO_IN32(KEYLARGO_FCR0);
 		} else if (number == 2) {
-			MACIO_BIC(KEYLARGO_FCR0, KL0_USB1_CELL_ENABLE);
+			if (macio->type != macio_intrepid)
+				MACIO_BIC(KEYLARGO_FCR0, KL0_USB1_CELL_ENABLE);
 			(void)MACIO_IN32(KEYLARGO_FCR0);
 			udelay(1);
 			MACIO_BIS(KEYLARGO_FCR0, (KL0_USB1_PAD_SUSPEND0 | KL0_USB1_PAD_SUSPEND1));
 			(void)MACIO_IN32(KEYLARGO_FCR0);
 		} else if (number == 4) {
-			MACIO_BIC(KEYLARGO_FCR1, KL1_USB2_CELL_ENABLE);
-			(void)MACIO_IN32(KEYLARGO_FCR1);
 			udelay(1);
 			MACIO_BIS(KEYLARGO_FCR1, (KL1_USB2_PAD_SUSPEND0 | KL1_USB2_PAD_SUSPEND1));
 			(void)MACIO_IN32(KEYLARGO_FCR1);
@@ -1554,22 +1587,17 @@
 	u32 temp;
 
 	MACIO_BIC(KEYLARGO_FCR0,KL0_SCCA_ENABLE | KL0_SCCB_ENABLE |
-				KL0_SCC_CELL_ENABLE |
-				KL0_USB0_CELL_ENABLE | KL0_USB1_CELL_ENABLE);
+		  KL0_SCC_CELL_ENABLE);
 
 	MACIO_BIC(KEYLARGO_FCR1,
-		KL1_USB2_CELL_ENABLE |
+		  /*KL1_USB2_CELL_ENABLE |*/
 		KL1_I2S0_CELL_ENABLE | KL1_I2S0_CLK_ENABLE_BIT |
 		KL1_I2S0_ENABLE | KL1_I2S1_CELL_ENABLE |
 		KL1_I2S1_CLK_ENABLE_BIT | KL1_I2S1_ENABLE);
 	if (pmac_mb.board_flags & PMAC_MB_MOBILE)
 		MACIO_BIC(KEYLARGO_FCR1, KL1_UIDE_RESET_N);
 
-	MACIO_BIS(KEYLARGO_FCR2, KL2_ALT_DATA_OUT);
-
 	temp = MACIO_IN32(KEYLARGO_FCR3);
-	temp |= KL3_IT_SHUTDOWN_PLL1 | KL3_IT_SHUTDOWN_PLL2 |
-		KL3_IT_SHUTDOWN_PLL3;
 	temp &= ~(KL3_CLK49_ENABLE | KL3_CLK45_ENABLE |
 		  KL3_I2S1_CLK18_ENABLE | KL3_I2S0_CLK18_ENABLE);
 	if (sleep_mode)
@@ -1577,7 +1605,8 @@
 	MACIO_OUT32(KEYLARGO_FCR3, temp);
 
 	/* Flush posted writes & wait a bit */
-	(void)MACIO_IN32(KEYLARGO_FCR0); mdelay(1);
+	(void)MACIO_IN32(KEYLARGO_FCR0);
+	mdelay(10);
 }
 
 static int __pmac
@@ -1591,6 +1620,12 @@
 	    macio->type != macio_intrepid)
 		return -ENODEV;
 
+	/* The device-tree contains that in the hwclock node */
+	if (macio->type == macio_intrepid) {
+		UN_OUT(UNI_N_CLOCK_SPREADING, 0);
+		mdelay(40);
+	}
+
 	/* We power off the wireless slot in case it was not done
 	 * by the driver. We don't power it on automatically however
 	 */
@@ -1653,11 +1688,15 @@
 	 */
 
 	save_unin_clock_ctl = UN_IN(UNI_N_CLOCK_CNTL);
+	/* Note: do not switch GMAC off, driver does it when necessary, WOL must keep it
+	 * enabled !
+	 */
 	UN_OUT(UNI_N_CLOCK_CNTL, save_unin_clock_ctl &
-		~(UNI_N_CLOCK_CNTL_GMAC|UNI_N_CLOCK_CNTL_FW/*|UNI_N_CLOCK_CNTL_PCI*/));
+	       ~(/*UNI_N_CLOCK_CNTL_GMAC|*/UNI_N_CLOCK_CNTL_FW/*|UNI_N_CLOCK_CNTL_PCI*/));
 	udelay(100);
 	UN_OUT(UNI_N_HWINIT_STATE, UNI_N_HWINIT_STATE_SLEEPING);
 	UN_OUT(UNI_N_POWER_MGT, UNI_N_POWER_MGT_SLEEP);
+	mdelay(10);
 
 	/*
 	 * FIXME: A bit of black magic with OpenPIC (don't ask me why)
@@ -1729,6 +1768,12 @@
 	UN_OUT(UNI_N_CLOCK_CNTL, save_unin_clock_ctl);
 	udelay(100);
 
+	/* Restore clock spreading */
+	if (macio->type == macio_intrepid) {
+		UN_OUT(UNI_N_CLOCK_SPREADING, 2);
+		mdelay(40);
+	}
+
 	return 0;
 }
 
@@ -1752,6 +1797,33 @@
 	}
 	if ((pmac_mb.board_flags & PMAC_MB_CAN_SLEEP) == 0)
 		return -EPERM;
+
+#ifdef CONFIG_CPU_FREQ_PMAC
+	/* XXX should be elsewhere */
+	if (machine_is_compatible("PowerBook6,5") ||
+	    machine_is_compatible("PowerBook6,4") ||
+	    machine_is_compatible("PowerBook5,5") ||
+	    machine_is_compatible("PowerBook5,4")) {
+		struct device_node *volt_gpio_np;
+		u32 *reg = NULL;
+
+		volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
+		if (volt_gpio_np != NULL)
+			reg = (u32 *)get_property(volt_gpio_np, "reg", NULL);
+		if (reg != NULL) {
+			/* Set the CPU voltage high if sleeping */
+			if (value == 1) {
+				pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL,
+						  *reg, 0x05);
+			} else if (value == 0 && (mfspr(HID1) & HID1_DFS)) {
+				pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL,
+						  *reg, 0x04);
+			}
+			mdelay(2);
+		}
+	}
+#endif /* CONFIG_CPU_FREQ_PMAC */
+
 	if (value == 1)
 		return core99_sleep();
 	else if (value == 0)
@@ -1762,6 +1834,18 @@
 #endif /* CONFIG_POWER4 */
 
 static long __pmac
+generic_dev_can_wake(struct device_node* node, long param, long value)
+{
+	/* Todo: eventually check we are really dealing with on-board
+	 * video device ...
+	 */
+
+	if (pmac_mb.board_flags & PMAC_MB_MAY_SLEEP)
+		pmac_mb.board_flags |= PMAC_MB_CAN_SLEEP;
+	return 0;
+}
+
+static long __pmac
 generic_get_mb_info(struct device_node* node, long param, long value)
 {
 	switch(param) {
@@ -1786,6 +1870,7 @@
  */
 static struct feature_table_entry any_features[]  __pmacdata = {
 	{ PMAC_FTR_GET_MB_INFO,		generic_get_mb_info },
+	{ PMAC_FTR_DEVICE_CAN_WAKE,	generic_dev_can_wake },
 	{ 0, NULL }
 };
 
@@ -2014,7 +2099,7 @@
 	},
 	{	"PowerBook1,1",			"PowerBook 101 (Lombard)",
 		PMAC_TYPE_101_PBOOK,		paddington_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_MOBILE
 	},
 	{	"iMac,1",			"iMac (first generation)",
 		PMAC_TYPE_ORIG_IMAC,		paddington_features,
@@ -2022,23 +2107,23 @@
 	},
 	{	"PowerMac4,1",			"iMac \"Flower Power\"",
 		PMAC_TYPE_PANGEA_IMAC,		pangea_features,
-		PMAC_MB_CAN_SLEEP
+		PMAC_MB_MAY_SLEEP
 	},
 	{	"PowerBook4,3",			"iBook 2 rev. 2",
 		PMAC_TYPE_IBOOK2,		pangea_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerBook4,2",			"iBook 2",
 		PMAC_TYPE_IBOOK2,		pangea_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerBook4,1",			"iBook 2",
 		PMAC_TYPE_IBOOK2,		pangea_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerMac4,4",			"eMac",
 		PMAC_TYPE_EMAC,			core99_features,
-		PMAC_MB_CAN_SLEEP
+		PMAC_MB_MAY_SLEEP
 	},
 	{	"PowerMac4,2",			"Flat panel iMac",
 		PMAC_TYPE_FLAT_PANEL_IMAC,	pangea_features,
@@ -2062,55 +2147,57 @@
 	},
 	{	"PowerMac3,2",			"PowerMac G4 AGP Graphics",
 		PMAC_TYPE_SAWTOOTH,		core99_features,
-		PMAC_MB_OLD_CORE99
+		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
 	{	"PowerMac3,3",			"PowerMac G4 AGP Graphics",
 		PMAC_TYPE_SAWTOOTH,		core99_features,
-		PMAC_MB_OLD_CORE99
+		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
 	{	"PowerMac2,1",			"iMac FireWire",
 		PMAC_TYPE_FW_IMAC,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_OLD_CORE99
+		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
 	{	"PowerMac2,2",			"iMac FireWire",
 		PMAC_TYPE_FW_IMAC,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_OLD_CORE99
+		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
 	{	"PowerBook2,2",			"iBook FireWire",
 		PMAC_TYPE_FW_IBOOK,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_OLD_CORE99 | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER |
+		PMAC_MB_OLD_CORE99 | PMAC_MB_MOBILE
 	},
 	{	"PowerMac5,1",			"PowerMac G4 Cube",
 		PMAC_TYPE_CUBE,			core99_features,
-		PMAC_MB_OLD_CORE99
+		PMAC_MB_MAY_SLEEP | PMAC_MB_OLD_CORE99
 	},
 	{	"PowerMac3,4",			"PowerMac G4 Silver",
 		PMAC_TYPE_QUICKSILVER,		core99_features,
-		0
+		PMAC_MB_MAY_SLEEP
 	},
 	{	"PowerMac3,5",			"PowerMac G4 Silver",
 		PMAC_TYPE_QUICKSILVER,		core99_features,
-		0
+		PMAC_MB_MAY_SLEEP
 	},
 	{	"PowerBook3,1",			"PowerBook Pismo",
 		PMAC_TYPE_PISMO,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_OLD_CORE99 | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER |
+		PMAC_MB_OLD_CORE99 | PMAC_MB_MOBILE
 	},
 	{	"PowerBook3,2",			"PowerBook Titanium",
 		PMAC_TYPE_TITANIUM,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerBook3,3",			"PowerBook Titanium II",
 		PMAC_TYPE_TITANIUM2,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerBook3,4",			"PowerBook Titanium III",
 		PMAC_TYPE_TITANIUM3,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"PowerBook3,5",			"PowerBook Titanium IV",
 		PMAC_TYPE_TITANIUM4,		core99_features,
-		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
 	},
 	{	"RackMac1,1",			"XServe",
 		PMAC_TYPE_RACKMAC,		rackmac_features,
@@ -2122,7 +2209,7 @@
 	},
 	{	"PowerMac3,6",			"PowerMac G4 Windtunnel",
 		PMAC_TYPE_WINDTUNNEL,		core99_features,
-		0,
+		PMAC_MB_MAY_SLEEP,
 	},
 	{	"PowerBook5,1",			"PowerBook G4 17\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
@@ -2130,39 +2217,39 @@
 	},
 	{	"PowerBook5,2",			"PowerBook G4 15\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook5,3",			"PowerBook G4 17\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook5,4",			"PowerBook G4 15\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook5,5",			"PowerBook G4 17\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook6,1",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook6,2",			"PowerBook G4",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook6,3",			"iBook G4",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook6,4",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook6,5",			"iBook G4",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
 #else /* CONFIG_POWER4 */
 	{	"PowerMac7,2",			"PowerMac G5",
@@ -2839,3 +2926,27 @@
 }
 
 #endif /* CONFIG_POWER4 */
+
+/*
+ * Early video resume hook
+ */
+
+static void (*pmac_early_vresume_proc)(void *data) __pmacdata;
+static void *pmac_early_vresume_data __pmacdata;
+
+void pmac_set_early_video_resume(void (*proc)(void *data), void *data)
+{
+	if (_machine != _MACH_Pmac)
+		return;
+	preempt_disable();
+	pmac_early_vresume_proc = proc;
+	pmac_early_vresume_data = data;
+	preempt_enable();
+}
+EXPORT_SYMBOL(pmac_set_early_video_resume);
+
+void __pmac pmac_call_early_video_resume(void)
+{
+	if (pmac_early_vresume_proc)
+		pmac_early_vresume_proc(pmac_early_vresume_data);
+}
Index: linux-work/arch/ppc/platforms/pmac_cpufreq.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_cpufreq.c	2004-11-27 11:59:52.000000000 +1100
+++ linux-work/arch/ppc/platforms/pmac_cpufreq.c	2005-01-17 13:49:07.000000000 +1100
@@ -154,6 +154,14 @@
 	return 0;
 }
 
+static unsigned int __pmac dfs_get_cpu_speed(unsigned int cpu)
+{
+	if (mfspr(HID1) & HID1_DFS)
+		return low_freq;
+	else
+		return hi_freq;
+}
+
 
 /* Switch CPU speed using slewing GPIOs
  */
@@ -229,10 +237,6 @@
 	/* Save & disable L2 and L3 caches */
 	save_l3cr = _get_L3CR();	/* (returns -1 if not available) */
 	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
-	if (save_l3cr != 0xffffffff && (save_l3cr & L3CR_L3E) != 0)
-		_set_L3CR(save_l3cr & 0x7fffffff);
-	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
-		_set_L2CR(save_l2cr & 0x7fffffff);
 
 	/* Send the new speed command. My assumption is that this command
 	 * will cause PLL_CFG[0..3] to be changed next time CPU goes to sleep
@@ -458,14 +462,13 @@
 {
 	struct device_node *volt_gpio_np;
 	u32 *reg;
+	struct cpufreq_driver *driver = &pmac_cpufreq_driver;
 
 	/* OF only reports the high frequency */
 	hi_freq = cur_freq;
 	low_freq = cur_freq/2;
-	if (mfspr(HID1) & HID1_DFS)
-		cur_freq = low_freq;
-	else
-		cur_freq = hi_freq;
+	driver->get = dfs_get_cpu_speed;
+	cur_freq = driver->get(0);
 
 	volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
 	if (!volt_gpio_np){
Index: linux-work/arch/ppc/platforms/pmac_sleep.S
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_sleep.S	2004-11-22 11:49:20.000000000 +1100
+++ linux-work/arch/ppc/platforms/pmac_sleep.S	2005-01-17 13:49:07.000000000 +1100
@@ -161,12 +161,8 @@
 	addi r3,r3,sleep_storage@l
 	stw r5,0(r3)
 
-	/* Disable DPM during cache flush */
-	mfspr	r3, SPRN_HID0
-	rlwinm	r3,r3,0,12,10
-	sync
-	mtspr	SPRN_HID0,r3
-	sync
+	/* Flush & disable all caches */
+	bl	flush_disable_caches
 
 	/* Turn off data relocation. */
 	mfmsr	r3		/* Save MSR in r7 */
@@ -175,8 +171,13 @@
 	mtmsr	r3
 	isync
 
-	/* Flush & disable L1 cache */
-	bl	__flush_disable_L1
+BEGIN_FTR_SECTION
+	/* Flush any pending L2 data prefetches to work around HW bug */
+	sync
+	lis	r3,0xfff0
+	lwz	r0,0(r3)	/* perform cache-inhibited load to ROM */
+	sync			/* (caches are disabled at this point) */
+END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
 
 /*
  * Set the HID0 and MSR for sleep.
@@ -212,17 +213,16 @@
  * r4 has the physical address of SL_PC(sp) (unused)
  */
 _GLOBAL(core99_wake_up)
-	/* Make sure HID0 no longer contains any sleep bit */
+	/* Make sure HID0 no longer contains any sleep bit and that data cache
+	 * is disabled
+	 */
 	mfspr	r3,HID0
 	rlwinm	r3,r3,0,11,7		/* clear SLEEP, NAP, DOZE bits */
+	rlwinm	3,r3,0,18,15		/* clear DCE, ICE */
 	mtspr	HID0,r3
 	sync
 	isync
 
-	/* Won't that cause problems on CPU that doesn't support it ? */
-	lis	r3, 0
-	mtspr	SPRN_MMCR0, r3
-
 	/* sanitize MSR */
 	mfmsr	r3
 	ori	r3,r3,MSR_EE|MSR_IP
@@ -246,10 +246,6 @@
  */
 
 grackle_wake_up:
-	/* Invalidate & enable L1 cache, we don't care about
-	 * whatever the ROM may have tried to write to memory
-	 */
-	bl	__inval_enable_L1
 
 	/* Restore the kernel's segment registers before
 	 * we do any r1 memory access as we are not sure they
@@ -271,6 +267,11 @@
 	/* Restore various CPU config stuffs */
 	bl	__restore_cpu_setup
 
+	/* Invalidate & enable L1 cache, we don't care about
+	 * whatever the ROM may have tried to write to memory
+	 */
+	bl	__inval_enable_L1
+
 	/* Restore the BATs, and SDR1.  Then we can turn on the MMU. */
 	lwz	r4,SL_SDR1(r1)
 	mtsdr1	r4
Index: linux-work/arch/ppc/kernel/l2cr.S
===================================================================
--- linux-work.orig/arch/ppc/kernel/l2cr.S	2004-11-22 11:49:18.000000000 +1100
+++ linux-work/arch/ppc/kernel/l2cr.S	2005-01-17 13:49:07.000000000 +1100
@@ -45,6 +45,7 @@
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
 #include <asm/cache.h>
+#include <asm/page.h>
 
 /* Usage:
 
@@ -284,7 +285,7 @@
 	/* Tweak some bits */
 	rlwinm	r5,r3,0,0,0		/* r5 contains the new enable bit */
 	rlwinm	r3,r3,0,22,20		/* Turn off the invalidate bit */
-	rlwinm	r3,r3,0,1,31		/* Turn off the enable bit */
+	rlwinm	r3,r3,0,2,31		/* Turn off the enable & PE bits */
 	rlwinm	r3,r3,0,5,3		/* Turn off the clken bit */
 	/* Check to see if we need to flush */
 	rlwinm.	r4,r4,0,0,0
@@ -379,7 +380,7 @@
 /* flush_disable_L1()	- Flush and disable L1 cache
  *
  * clobbers r0, r3, ctr, cr0
- *
+ * Must be called with interrupts disabled and MMU enabled.
  */
 _GLOBAL(__flush_disable_L1)
 	/* Stop pending alitvec streams and memory accesses */
@@ -393,7 +394,7 @@
 	 */
 	li	r3,0x4000	/* 512kB / 32B */
 	mtctr	r3
-	li	r3, 0
+	lis	r3,KERNELBASE@h
 1:
 	lwz	r0,0(r3)
 	addi	r3,r3,0x0020	/* Go to start of next cache line */
@@ -404,7 +405,7 @@
 	/* Now flush those cache lines */
 	li	r3,0x4000	/* 512kB / 32B */
 	mtctr	r3
-	li	r3, 0
+	lis	r3,KERNELBASE@h
 1:
 	dcbf	0,r3
 	addi	r3,r3,0x0020	/* Go to start of next cache line */
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2005-01-14 08:17:13.000000000 +1100
+++ linux-work/drivers/macintosh/via-pmu.c	2005-01-17 13:49:08.000000000 +1100
@@ -45,6 +45,7 @@
 #include <linux/device.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
+#include <linux/cpu.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -152,7 +153,6 @@
 #ifdef CONFIG_PMAC_PBOOK
 static int option_lid_wakeup = 1;
 static int sleep_in_progress;
-static int can_sleep;
 #endif /* CONFIG_PMAC_PBOOK */
 static unsigned long async_req_locks;
 static unsigned int pmu_irq_stats[11];
@@ -406,8 +406,6 @@
 	bright_req_2.complete = 1;
 #ifdef CONFIG_PMAC_PBOOK
 	batt_req.complete = 1;
-	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
-		can_sleep = 1;
 #endif
 
 	if (request_irq(vias->intrs[0].line, via_pmu_interrupt, 0, "VIA-PMU",
@@ -885,7 +883,8 @@
 	char *p = page;
 
 #ifdef CONFIG_PMAC_PBOOK
-	if (pmu_kind == PMU_KEYLARGO_BASED && can_sleep)
+	if (pmu_kind == PMU_KEYLARGO_BASED &&
+	    pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
 		p += sprintf(p, "lid_wakeup=%d\n", option_lid_wakeup);
 #endif /* CONFIG_PMAC_PBOOK */
 	if (pmu_kind == PMU_KEYLARGO_BASED)
@@ -925,7 +924,8 @@
 	while(*val == ' ')
 		val++;
 #ifdef CONFIG_PMAC_PBOOK
-	if (pmu_kind == PMU_KEYLARGO_BASED && can_sleep)
+	if (pmu_kind == PMU_KEYLARGO_BASED && 
+	    pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
 		if (!strcmp(label, "lid_wakeup"))
 			option_lid_wakeup = ((*val) == '1');
 #endif /* CONFIG_PMAC_PBOOK */
@@ -2313,7 +2313,7 @@
 pmac_suspend_devices(void)
 {
 	int ret;
-	
+
 	pm_prepare_console();
 	
 	/* Notify old-style device drivers & userland */
@@ -2341,13 +2341,13 @@
 	/* Send suspend call to devices, hold the device core's dpm_sem */
 	ret = device_suspend(PM_SUSPEND_MEM);
 	if (ret) {
-		printk(KERN_ERR "Driver sleep failed\n");
 		broadcast_wake();
+		printk(KERN_ERR "Driver sleep failed\n");
 		return -EBUSY;
 	}
-	
+
 	preempt_disable();
-	
+
 	/* Make sure the decrementer won't interrupt us */
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
 	/* Make sure any pending DEC interrupt occurring while we did
@@ -2404,8 +2404,6 @@
 	/* Power back up system devices (including the PIC) */
 	device_power_up();
 
-	pmu_blink(1);
-
 	/* Force a poll of ADB interrupts */
 	adb_int_pending = 1;
 	via_pmu_interrupt(0, NULL, NULL);
@@ -2416,7 +2414,7 @@
 	/* Re-enable local CPU interrupts */
 	local_irq_enable();
 
-	pmu_blink(1);
+	mdelay(100);
 
 	preempt_enable();
 
@@ -2464,8 +2462,6 @@
 
 	/* For 750, save backside cache setting and disable it */
 	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
-	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
-		_set_L2CR(save_l2cr & 0x7fffffff);
 
 	if (!__fake_sleep) {
 		/* Ask the PMU to put us to sleep */
@@ -2530,17 +2526,22 @@
 	struct adb_request req;
 	int ret;
 	
-	if (!can_sleep) {
+	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0) {
 		printk(KERN_ERR "Sleep mode not supported on this machine\n");
 		return -ENOSYS;
 	}
-	
+
+	if (num_online_cpus() > 1 || cpu_is_offline(0))
+		return -EAGAIN;
+
 	ret = pmac_suspend_devices();
 	if (ret) {
 		printk(KERN_ERR "Sleep rejected by devices\n");
 		return ret;
 	}
-	
+
+	printk(KERN_DEBUG "HID1, before: %x\n", mfspr(SPRN_HID1));
+
 	/* Tell PMU what events will wake us up */
 	pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_CLR_WAKEUP_EVENTS,
 		0xff, 0xff);
@@ -2550,16 +2551,9 @@
 		(option_lid_wakeup ? PMU_PWR_WAKEUP_LID_OPEN : 0));
 	pmu_wait_complete(&req);
 
-	/* Save & disable L2 and L3 caches*/
+	/* Save the state of the L2 and L3 caches */
 	save_l3cr = _get_L3CR();	/* (returns -1 if not available) */
 	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
-	if (save_l3cr != 0xffffffff && (save_l3cr & L3CR_L3E) != 0)
-		_set_L3CR(save_l3cr & 0x7fffffff);
-	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
-		_set_L2CR(save_l2cr & 0x7fffffff);
-
-	/* Save the state of PCI config space for some slots */
-	//pbook_pci_save();
 
 	if (!__fake_sleep) {
 		/* Ask the PMU to put us to sleep */
@@ -2574,7 +2568,7 @@
 	 * talk to the PMU after this, so I moved it to _after_ sending the
 	 * sleep command to it. Still need to be checked.
 	 */
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,1);
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 1);
 
 	/* Call low-level ASM sleep handler */
 	if (__fake_sleep)
@@ -2583,18 +2577,13 @@
 		low_sleep_handler();
 
 	/* Restore Apple core ASICs state */
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,0);
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 0);
 
 	/* Restore VIA */
 	restore_via_state();
 
-	/* Restore PCI config space. This should be overridable by PCI device
-	 * drivers as some of them may need special restore code. That's yet
-	 * another issue that should be handled by the common code properly,
-	 * maybe one day ?
-	 */
-	/* Don't restore PCI for now, it crashes. Maybe unnecessary on pbook */
-	//pbook_pci_restore();
+	/* Restore video */
+	pmac_call_early_video_resume();
 
 	/* Restore L2 cache */
 	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
@@ -2613,7 +2602,7 @@
 	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
 	pmu_wait_complete(&req);
 
-	pmu_blink(1);
+	printk(KERN_DEBUG "HID1, after: %x\n", mfspr(SPRN_HID1));
 
 	pmac_wakeup_devices();
 
@@ -2909,7 +2898,10 @@
 		sleep_in_progress = 0;
 		return error;
 	case PMU_IOC_CAN_SLEEP:
-		return put_user((u32)can_sleep, argp);
+		if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0)
+			return put_user(0, argp);
+		else
+			return put_user(1, argp);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	/* Backlight should have its own device or go via
Index: linux-work/arch/ppc/platforms/Makefile
===================================================================
--- linux-work.orig/arch/ppc/platforms/Makefile	2005-01-14 08:17:11.000000000 +1100
+++ linux-work/arch/ppc/platforms/Makefile	2005-01-17 13:49:08.000000000 +1100
@@ -11,7 +11,7 @@
 endif
 obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
 					pmac_feature.o pmac_pci.o pmac_sleep.o \
-					pmac_low_i2c.o
+					pmac_low_i2c.o pmac_cache.o
 obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o
 obj-$(CONFIG_PPC_PREP)		+= prep_pci.o prep_setup.o
 ifeq ($(CONFIG_PPC_PMAC),y)
Index: linux-work/include/asm-ppc/reg.h
===================================================================
--- linux-work.orig/include/asm-ppc/reg.h	2005-01-14 08:17:21.000000000 +1100
+++ linux-work/include/asm-ppc/reg.h	2005-01-17 13:49:08.000000000 +1100
@@ -244,6 +244,10 @@
 #define L2CR_L2DF		0x00004000	/* L2 differential clock */
 #define L2CR_L2BYP		0x00002000	/* L2 DLL bypass */
 #define L2CR_L2IP		0x00000001	/* L2 GI in progress */
+#define L2CR_L2IO_745x		0x00100000	/* L2 instr. only (745x) */
+#define L2CR_L2DO_745x		0x00010000	/* L2 data only (745x) */
+#define L2CR_L2REP_745x		0x00001000	/* L2 repl. algorithm (745x) */
+#define L2CR_L2HWF_745x		0x00000800	/* L2 hardware flush (745x) */
 #define SPRN_L3CR		0x3FA	/* Level 3 Cache Control Regsiter */
 #define L3CR_L3E		0x80000000	/* L3 enable */
 #define L3CR_L3PE		0x40000000	/* L3 data parity enable */
Index: linux-work/include/asm-ppc/pmac_feature.h
===================================================================
--- linux-work.orig/include/asm-ppc/pmac_feature.h	2004-12-01 16:06:15.000000000 +1100
+++ linux-work/include/asm-ppc/pmac_feature.h	2005-01-17 13:49:08.000000000 +1100
@@ -125,6 +125,7 @@
 #define PMAC_MB_HAS_FW_POWER		0x00000002
 #define PMAC_MB_OLD_CORE99		0x00000004
 #define PMAC_MB_MOBILE			0x00000008
+#define PMAC_MB_MAY_SLEEP		0x00000010
 
 /*
  * Feature calls supported on pmac
@@ -238,7 +239,10 @@
 
 /* PMAC_FTR_SLEEP_STATE		(struct device_node* node, 0, int value)
  * set the sleep state of the motherboard.
+ * 
  * Pass -1 as value to query for sleep capability
+ * Pass 1 to set IOs to sleep
+ * Pass 0 to set IOs to wake
  */
 #define PMAC_FTR_SLEEP_STATE		PMAC_FTR_DEF(15)
 
@@ -279,11 +283,22 @@
  */
 #define PMAC_FTR_AACK_DELAY_ENABLE     	PMAC_FTR_DEF(20)
 
+/* PMAC_FTR_DEVICE_CAN_WAKE
+ *
+ * Used by video drivers to inform system that they can actually perform
+ * wakeup from sleep
+ */
+#define PMAC_FTR_DEVICE_CAN_WAKE	PMAC_FTR_DEF(22)
+
 
 /* Don't use those directly, they are for the sake of pmac_setup.c */
 extern long pmac_do_feature_call(unsigned int selector, ...);
 extern void pmac_feature_init(void);
 
+/* Video suspend tweak */
+extern void pmac_set_early_video_resume(void (*proc)(void *data), void *data);
+extern void pmac_call_early_video_resume(void);
+
 #define PMAC_FTR_DEF(x) ((_MACH_Pmac << 16) | (x))
 
 
Index: linux-work/arch/ppc/platforms/pmac_pci.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_pci.c	2005-01-14 08:17:11.000000000 +1100
+++ linux-work/arch/ppc/platforms/pmac_pci.c	2005-01-17 13:49:08.000000000 +1100
@@ -915,8 +915,12 @@
 	 * (iBook second controller)
 	 */
 	if (dev->vendor == PCI_VENDOR_ID_APPLE
-	    && dev->device == PCI_DEVICE_ID_APPLE_KL_USB && !node)
+	    && (dev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x10))
+	    && !node) {
+		printk(KERN_INFO "Apple USB OHCI %s disabled by firmware\n",
+		       pci_name(dev));
 		return -EINVAL;
+	}
 
 	if (!node)
 		return 0;
Index: linux-work/drivers/serial/pmac_zilog.c
===================================================================
--- linux-work.orig/drivers/serial/pmac_zilog.c	2004-12-01 16:06:14.000000000 +1100
+++ linux-work/drivers/serial/pmac_zilog.c	2005-01-17 13:49:08.000000000 +1100
@@ -1946,6 +1946,8 @@
 	unsigned long flags;
 	int i;
 
+	if (ZS_IS_ASLEEP(uap))
+		return;
 	spin_lock_irqsave(&uap->port.lock, flags);
 
 	/* Turn of interrupts and enable the transmitter. */
