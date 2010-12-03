Return-Path: <r58472@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C0250B73A2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 22:41:25 +1100 (EST)
Received: from mail39-db3 (localhost.localdomain [127.0.0.1])	by
	mail39-db3-R.bigfish.com (Postfix) with ESMTP id 7C44A1A1837E	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  3 Dec 2010 11:41:18 +0000 (UTC)
Received: from DB3EHSMHS005.bigfish.com (unknown [10.3.81.251])	by
	mail39-db3.bigfish.com (Postfix) with ESMTP id 7C8AD1970062	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  3 Dec 2010 11:41:15 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB3BfCh9023343	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 04:41:13 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oB3BxAdd018881	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 3 Dec 2010 05:59:15 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/7] powerpc/85xx: add the deep sleep support
Date: Fri, 3 Dec 2010 20:34:07 +0800
Message-ID: <1291379651-8822-3-git-send-email-leoli@freescale.com>
In-Reply-To: <1291379651-8822-2-git-send-email-leoli@freescale.com>
References: <1291379651-8822-1-git-send-email-leoli@freescale.com>
	<1291379651-8822-2-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some Freescale chips like MPC8536 and P1022 has deep sleep PM mode
in addtion to the sleep PM mode.

In sleep power management mode, the clock of e500 core
is turned off, the clocks of most IP blocks are shut off,
only the modules clocks which allows to wake up the
processor are still running.

While in deep sleep PM mode, additionally, the power supply is
removed for e500 core and most devices. Only the blocks needed
to detect wakeup and sequence the chip out of deep sleep are ON.

Also add APIs for setting wakeup source and lossless Ethernet in
low power modes.

The deep sleep mode is equal to the Suspend-to-RAM state of Linux
Power Management.

echo mem > /sys/power/state

to enter deep sleep mode.

Signed-off-by: Dave Liu <daveliu@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jin Qing <b24347@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/l2cr_85xx.S           |   53 +++
 arch/powerpc/platforms/85xx/suspend-asm.S |  625 +++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pmc.c             |  153 ++++++-
 arch/powerpc/sysdev/fsl_soc.h             |   11 +
 4 files changed, 823 insertions(+), 19 deletions(-)
 create mode 100644 arch/powerpc/kernel/l2cr_85xx.S
 create mode 100644 arch/powerpc/platforms/85xx/suspend-asm.S

diff --git a/arch/powerpc/kernel/l2cr_85xx.S b/arch/powerpc/kernel/l2cr_85xx.S
new file mode 100644
index 0000000..5283d31
--- /dev/null
+++ b/arch/powerpc/kernel/l2cr_85xx.S
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All rights reserved.
+ *	Scott Wood <scottwood@freescale.com>
+ *	Dave Liu <daveliu@freescale.com>
+ * implement the L2 cache operations of e500 based L2 controller
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/reg.h>
+#include <asm/cputable.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+
+	.section .text
+
+	/* r3 = virtual address of L2 controller, WIMG = 01xx */
+_GLOBAL(flush_disable_L2)
+	/* It's a write-through cache, so only invalidation is needed. */
+	mbar
+	isync
+	lwz	r4, 0(r3)
+	li	r5, 1
+	rlwimi	r4, r5, 30, 0xc0000000
+	stw	r4, 0(r3)
+
+	/* Wait for the invalidate to finish */
+1:	lwz	r4, 0(r3)
+	andis.	r4, r4, 0x4000
+	bne	1b
+	mbar
+
+	blr
+
+	/* r3 = virtual address of L2 controller, WIMG = 01xx */
+_GLOBAL(invalidate_enable_L2)
+	mbar
+	isync
+	lwz	r4, 0(r3)
+	li	r5, 3
+	rlwimi	r4, r5, 30, 0xc0000000
+	stw	r4, 0(r3)
+
+	/* Wait for the invalidate to finish */
+1:	lwz	r4, 0(r3)
+	andis.	r4, r4, 0x4000
+	bne	1b
+	mbar
+
+	blr
diff --git a/arch/powerpc/platforms/85xx/suspend-asm.S b/arch/powerpc/platforms/85xx/suspend-asm.S
new file mode 100644
index 0000000..99de481
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/suspend-asm.S
@@ -0,0 +1,625 @@
+/*
+ * Enter and leave deep sleep/sleep state on MPC85xx
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (C) 2006-2010 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <asm/page.h>
+#include <asm/ppc_asm.h>
+#include <asm/reg.h>
+#include <asm/asm-offsets.h>
+
+#define SS_TB		0x00
+#define SS_HID		0x08 /* 2 HIDs */
+#define SS_IAC		0x10 /* 2 IACs */
+#define SS_DAC		0x18 /* 2 DACs */
+#define SS_DBCR		0x20 /* 3 DBCRs */
+#define SS_PID		0x2c /* 3 PIDs */
+#define SS_SPRG		0x38 /* 8 SPRGs */
+#define SS_IVOR		0x58 /* 20 interrupt vectors */
+#define SS_TCR		0xa8
+#define SS_BUCSR	0xac
+#define SS_L1CSR	0xb0 /* 2 L1CSRs */
+#define SS_MSR		0xb8
+#define SS_USPRG	0xbc
+#define SS_GPREG	0xc0 /* r12-r31 */
+#define SS_LR		0x110
+#define SS_CR		0x114
+#define SS_SP		0x118
+#define SS_CURRENT	0x11c
+#define SS_IVPR		0x120
+#define SS_BPTR		0x124
+
+#define STATE_SAVE_SIZE 0x128
+
+	.section .data
+	.align	5
+mpc85xx_sleep_save_area:
+	.space	STATE_SAVE_SIZE
+ccsrbase:
+	.long	0
+powmgtreq:
+	.long	0
+
+	.section .text
+	.align	12
+
+	/*
+	 * r3 = physical address of CCSR
+	 * r4 = JOG or deep sleep request
+	 *      JOG-0x00200000, deep sleep-0x00100000
+	 */
+_GLOBAL(mpc85xx_enter_deep_sleep)
+	lis	r5, ccsrbase@ha
+	stw	r3, ccsrbase@l(r5)
+
+	lis	r5, powmgtreq@ha
+	stw	r4, powmgtreq@l(r5)
+
+	lis	r10, mpc85xx_sleep_save_area@h
+	ori	r10, r10, mpc85xx_sleep_save_area@l
+
+	mfspr	r5, SPRN_HID0
+	mfspr	r6, SPRN_HID1
+
+	stw	r5, SS_HID+0(r10)
+	stw	r6, SS_HID+4(r10)
+
+	mfspr	r4, SPRN_IAC1
+	mfspr	r5, SPRN_IAC2
+	mfspr	r6, SPRN_DAC1
+	mfspr	r7, SPRN_DAC2
+
+	stw	r4, SS_IAC+0(r10)
+	stw	r5, SS_IAC+4(r10)
+	stw	r6, SS_DAC+0(r10)
+	stw	r7, SS_DAC+4(r10)
+
+	mfspr	r4, SPRN_DBCR0
+	mfspr	r5, SPRN_DBCR1
+	mfspr	r6, SPRN_DBCR2
+
+	stw	r4, SS_DBCR+0(r10)
+	stw	r5, SS_DBCR+4(r10)
+	stw	r6, SS_DBCR+8(r10)
+
+	mfspr	r4, SPRN_PID0
+	mfspr	r5, SPRN_PID1
+	mfspr	r6, SPRN_PID2
+
+	stw	r4, SS_PID+0(r10)
+	stw	r5, SS_PID+4(r10)
+	stw	r6, SS_PID+8(r10)
+
+	mfspr	r4, SPRN_SPRG0
+	mfspr	r5, SPRN_SPRG1
+	mfspr	r6, SPRN_SPRG2
+	mfspr	r7, SPRN_SPRG3
+
+	stw	r4, SS_SPRG+0x00(r10)
+	stw	r5, SS_SPRG+0x04(r10)
+	stw	r6, SS_SPRG+0x08(r10)
+	stw	r7, SS_SPRG+0x0c(r10)
+
+	mfspr	r4, SPRN_SPRG4
+	mfspr	r5, SPRN_SPRG5
+	mfspr	r6, SPRN_SPRG6
+	mfspr	r7, SPRN_SPRG7
+
+	stw	r4, SS_SPRG+0x10(r10)
+	stw	r5, SS_SPRG+0x14(r10)
+	stw	r6, SS_SPRG+0x18(r10)
+	stw	r7, SS_SPRG+0x1c(r10)
+
+	mfspr	r4, SPRN_IVPR
+	stw	r4, SS_IVPR(r10)
+
+	mfspr	r4, SPRN_IVOR0
+	mfspr	r5, SPRN_IVOR1
+	mfspr	r6, SPRN_IVOR2
+	mfspr	r7, SPRN_IVOR3
+
+	stw	r4, SS_IVOR+0x00(r10)
+	stw	r5, SS_IVOR+0x04(r10)
+	stw	r6, SS_IVOR+0x08(r10)
+	stw	r7, SS_IVOR+0x0c(r10)
+
+	mfspr	r4, SPRN_IVOR4
+	mfspr	r5, SPRN_IVOR5
+	mfspr	r6, SPRN_IVOR6
+	mfspr	r7, SPRN_IVOR7
+
+	stw	r4, SS_IVOR+0x10(r10)
+	stw	r5, SS_IVOR+0x14(r10)
+	stw	r6, SS_IVOR+0x18(r10)
+	stw	r7, SS_IVOR+0x1c(r10)
+
+	mfspr	r4, SPRN_IVOR8
+	mfspr	r5, SPRN_IVOR9
+	mfspr	r6, SPRN_IVOR10
+	mfspr	r7, SPRN_IVOR11
+
+	stw	r4, SS_IVOR+0x20(r10)
+	stw	r5, SS_IVOR+0x24(r10)
+	stw	r6, SS_IVOR+0x28(r10)
+	stw	r7, SS_IVOR+0x2c(r10)
+
+	mfspr	r4, SPRN_IVOR12
+	mfspr	r5, SPRN_IVOR13
+	mfspr	r6, SPRN_IVOR14
+	mfspr	r7, SPRN_IVOR15
+
+	stw	r4, SS_IVOR+0x30(r10)
+	stw	r5, SS_IVOR+0x34(r10)
+	stw	r6, SS_IVOR+0x38(r10)
+	stw	r7, SS_IVOR+0x3c(r10)
+
+	mfspr	r4, SPRN_IVOR32
+	mfspr	r5, SPRN_IVOR33
+	mfspr	r6, SPRN_IVOR34
+	mfspr	r7, SPRN_IVOR35
+
+	stw	r4, SS_IVOR+0x40(r10)
+	stw	r5, SS_IVOR+0x44(r10)
+	stw	r6, SS_IVOR+0x48(r10)
+	stw	r7, SS_IVOR+0x4c(r10)
+
+	mfspr	r4, SPRN_TCR
+	mfspr	r5, SPRN_BUCSR
+	mfspr	r6, SPRN_L1CSR0
+	mfspr	r7, SPRN_L1CSR1
+	mfspr	r8, SPRN_USPRG0
+
+	stw	r4, SS_TCR(r10)
+	stw	r5, SS_BUCSR(r10)
+	stw	r6, SS_L1CSR+0(r10)
+	stw	r7, SS_L1CSR+4(r10)
+	stw	r8, SS_USPRG+0(r10)
+
+	stmw	r12, SS_GPREG(r10)
+
+	mfmsr	r4
+	mflr	r5
+	mfcr	r6
+
+	stw	r4, SS_MSR(r10)
+	stw	r5, SS_LR(r10)
+	stw	r6, SS_CR(r10)
+	stw	r1, SS_SP(r10)
+	stw	r2, SS_CURRENT(r10)
+
+1:	mftbu	r4
+	mftb	r5
+	mftbu	r6
+	cmpw	r4, r6
+	bne	1b
+
+	stw	r4, SS_TB+0(r10)
+	stw	r5, SS_TB+4(r10)
+
+	lis	r4, ccsrbase@ha
+	lwz	r3, ccsrbase@l(r4)
+
+	/* Disable machine checks and critical exceptions */
+	mfmsr	r4
+	rlwinm	r4, r4, 0, ~MSR_CE
+	rlwinm	r4, r4, 0, ~MSR_ME
+	mtmsr	r4
+	isync
+
+	/* Use TLB1[15] to map the CCSR at 0xf0000000 */
+	lis	r4, 0x100f
+	mtspr	SPRN_MAS0, r4
+	lis	r4, 0xc000
+	ori	r4, r4, 0x0500
+	mtspr	SPRN_MAS1, r4
+	lis	r4, 0xf000
+	ori	r4, r4, 0x000a
+	mtspr	SPRN_MAS2, r4
+	rlwinm	r4, r3, 0, 0xfffff000
+	ori	r4, r4, 0x0005
+	mtspr	SPRN_MAS3, r4
+	li	r4, 0
+	mtspr	SPRN_MAS7, r4
+	isync
+	tlbwe
+	isync
+
+	lis	r3, 0xf000
+	lwz	r4, 0x20(r3)
+	stw	r4, SS_BPTR(r10)
+
+	lis	r3, 0xf002		/* L2 cache controller at CCSR+0x20000 */
+	bl	flush_disable_L2
+	bl	flush_disable_L1
+
+	/* Enable I-cache, so as not to upset the bus
+	 * with our loop.
+	 */
+
+	mfspr	r4, SPRN_L1CSR1
+	ori	r4, r4, 1
+	mtspr	SPRN_L1CSR1, r4
+	isync
+
+	/* Set boot page translation */
+	lis	r3, 0xf000
+	lis	r4, (mpc85xx_deep_resume - PAGE_OFFSET)@h
+	ori	r4, r4, (mpc85xx_deep_resume - PAGE_OFFSET)@l
+	rlwinm	r4, r4, 20, 0x000fffff
+	oris	r4, r4, 0x8000
+	stw	r4, 0x20(r3)
+	lwz	r4, 0x20(r3)		/* read-back to flush write */
+	twi	0, r4, 0
+	isync
+
+	/* Disable the decrementer */
+	mfspr	r4, SPRN_TCR
+	rlwinm	r4, r4, 0, ~TCR_DIE
+	mtspr	SPRN_TCR, r4
+
+	mfspr	r4, SPRN_TSR
+	oris	r4, r4, TSR_DIS@h
+	mtspr	SPRN_TSR, r4
+
+	/* set PMRCCR[VRCNT] to wait power stable for 40ms */
+	lis	r3, 0xf00e
+	lwz	r4, 0x84(r3)
+	clrlwi	r4, r4, 16
+	oris	r4, r4, 0x12a3
+	stw	r4, 0x84(r3)
+	lwz	r4, 0x84(r3)
+
+	/* set deep sleep bit in POWMGTSCR */
+	lis	r3, powmgtreq@ha
+	lwz	r8, powmgtreq@l(r3)
+
+	lis	r3, 0xf00e
+	mr	r4, r8
+	stw	r4, 0x80(r3)
+	lwz	r4, 0x80(r3)		/* read-back to flush write */
+	twi	0, r4, 0
+	isync
+
+	mftb	r5
+1:	/* spin until either we enter deep sleep, or the sleep process is
+	 * aborted due to a pending wakeup event.  Wait some time between
+	 * accesses, so we don't flood the bus and prevent the pmc from
+	 * detecting an idle system.
+	 */
+
+	mftb	r4
+	subf	r7, r5, r4
+	cmpwi	r7, 1000
+	blt	1b
+	mr	r5, r4
+
+	lwz	r6, 0x80(r3)
+	andis.	r6, r6, 0x0010
+	bne	1b
+	b	2f
+
+2:	mfspr	r4, SPRN_PIR
+	andi.	r4, r4, 1
+99:	bne	99b
+	/* Establish a temporary 64MB 0->0 mapping in TLB1[1]. */
+	lis	r4, 0x1001
+	mtspr	SPRN_MAS0, r4
+	lis	r4, 0xc000
+	ori	r4, r4, 0x0800
+	mtspr	SPRN_MAS1, r4
+	li	r4, 0
+	mtspr	SPRN_MAS2, r4
+	li	r4, 0x0015
+	mtspr	SPRN_MAS3, r4
+	li	r4, 0
+	mtspr	SPRN_MAS7, r4
+	isync
+	tlbwe
+	isync
+
+	lis	r3, (3f - PAGE_OFFSET)@h
+	ori	r3, r3, (3f - PAGE_OFFSET)@l
+	mtctr	r3
+	bctr
+
+	/* Locate the resume vector in the last word of the current page. */
+	. = mpc85xx_enter_deep_sleep + 0xffc
+mpc85xx_deep_resume:
+	b	2b
+
+3:
+	/* Restore the contents of TLB1[0].  It is assumed that it covers
+	 * the currently executing code and the sleep save area, and that
+	 * it does not alias our temporary mapping (which is at virtual zero).
+	 */
+	lis	r3, (TLBCAM - PAGE_OFFSET)@h
+	ori	r3, r3, (TLBCAM - PAGE_OFFSET)@l
+
+	lwz	r4, 0(r3)
+	lwz	r5, 4(r3)
+	lwz	r6, 8(r3)
+	lwz	r7, 12(r3)
+	lwz	r8, 16(r3)
+
+	mtspr	SPRN_MAS0, r4
+	mtspr	SPRN_MAS1, r5
+	mtspr	SPRN_MAS2, r6
+	mtspr	SPRN_MAS3, r7
+	mtspr	SPRN_MAS7, r8
+
+	isync
+	tlbwe
+	isync
+
+	/* Access the ccsrbase address with TLB1[0] */
+	lis	r4, ccsrbase@ha
+	lwz	r3, ccsrbase@l(r4)
+
+	/* Use TLB1[15] to map the CCSR at 0xf0000000 */
+	lis	r4, 0x100f
+	mtspr	SPRN_MAS0, r4
+	lis	r4, 0xc000
+	ori	r4, r4, 0x0500
+	mtspr	SPRN_MAS1, r4
+	lis	r4, 0xf000
+	ori	r4, r4, 0x000a
+	mtspr	SPRN_MAS2, r4
+	rlwinm	r4, r3, 0, 0xfffff000
+	ori	r4, r4, 0x0005
+	mtspr	SPRN_MAS3, r4
+	li	r4, 0
+	mtspr	SPRN_MAS7, r4
+	isync
+	tlbwe
+	isync
+
+	lis	r3, 0xf002		/* L2 cache controller at CCSR+0x20000 */
+	bl	invalidate_enable_L2
+
+	/* Access the MEM(r10) with TLB1[0] */
+	lis	r10, mpc85xx_sleep_save_area@h
+	ori	r10, r10, mpc85xx_sleep_save_area@l
+
+	lis	r3, 0xf000
+	lwz	r4, SS_BPTR(r10)
+	stw	r4, 0x20(r3)		/* restore BPTR */
+
+	/* Program shift running space to PAGE_OFFSET */
+	mfmsr	r3
+	lis	r4, 1f@h
+	ori	r4, r4, 1f@l
+
+	mtsrr1	r3
+	mtsrr0	r4
+	rfi
+
+1:	/* Restore the rest of TLB1, in ascending order so that
+	 * the TLB1[1] gets invalidated first.
+	 *
+	 * XXX: It's better to invalidate the temporary mapping
+	 * TLB1[15] for CCSR before restore any TLB1 entry include 0.
+	 */
+	lis	r4, 0x100f
+	mtspr	SPRN_MAS0, r4
+	lis	r4, 0
+	mtspr	SPRN_MAS1, r4
+	isync
+	tlbwe
+	isync
+
+	lis	r3, (TLBCAM + 5*4 - 4)@h
+	ori	r3, r3, (TLBCAM + 5*4 - 4)@l
+	li	r4, 15
+	mtctr	r4
+
+2:
+	lwz	r5, 4(r3)
+	lwz	r6, 8(r3)
+	lwz	r7, 12(r3)
+	lwz	r8, 16(r3)
+	lwzu	r9, 20(r3)
+
+	mtspr	SPRN_MAS0, r5
+	mtspr	SPRN_MAS1, r6
+	mtspr	SPRN_MAS2, r7
+	mtspr	SPRN_MAS3, r8
+	mtspr	SPRN_MAS7, r9
+
+	isync
+	tlbwe
+	isync
+	bdnz	2b
+
+	lis	r10, mpc85xx_sleep_save_area@h
+	ori	r10, r10, mpc85xx_sleep_save_area@l
+
+	lwz	r5, SS_HID+0(r10)
+	lwz	r6, SS_HID+4(r10)
+
+	isync
+	mtspr	SPRN_HID0, r5
+	isync
+
+	msync
+	mtspr	SPRN_HID1, r6
+	isync
+
+	lwz	r4, SS_IAC+0(r10)
+	lwz	r5, SS_IAC+4(r10)
+	lwz	r6, SS_DAC+0(r10)
+	lwz	r7, SS_DAC+4(r10)
+
+	mtspr	SPRN_IAC1, r4
+	mtspr	SPRN_IAC2, r5
+	mtspr	SPRN_DAC1, r6
+	mtspr	SPRN_DAC2, r7
+
+	lwz	r4, SS_DBCR+0(r10)
+	lwz	r5, SS_DBCR+4(r10)
+	lwz	r6, SS_DBCR+8(r10)
+
+	mtspr	SPRN_DBCR0, r4
+	mtspr	SPRN_DBCR1, r5
+	mtspr	SPRN_DBCR2, r6
+
+	lwz	r4, SS_PID+0(r10)
+	lwz	r5, SS_PID+4(r10)
+	lwz	r6, SS_PID+8(r10)
+
+	mtspr	SPRN_PID0, r4
+	mtspr	SPRN_PID1, r5
+	mtspr	SPRN_PID2, r6
+
+	lwz	r4, SS_SPRG+0x00(r10)
+	lwz	r5, SS_SPRG+0x04(r10)
+	lwz	r6, SS_SPRG+0x08(r10)
+	lwz	r7, SS_SPRG+0x0c(r10)
+
+	mtspr	SPRN_SPRG0, r4
+	mtspr	SPRN_SPRG1, r5
+	mtspr	SPRN_SPRG2, r6
+	mtspr	SPRN_SPRG3, r7
+
+	lwz	r4, SS_SPRG+0x10(r10)
+	lwz	r5, SS_SPRG+0x14(r10)
+	lwz	r6, SS_SPRG+0x18(r10)
+	lwz	r7, SS_SPRG+0x1c(r10)
+
+	mtspr	SPRN_SPRG4, r4
+	mtspr	SPRN_SPRG5, r5
+	mtspr	SPRN_SPRG6, r6
+	mtspr	SPRN_SPRG7, r7
+
+	lwz	r4, SS_IVPR(r10)
+	mtspr	SPRN_IVPR, r4
+
+	lwz	r4, SS_IVOR+0x00(r10)
+	lwz	r5, SS_IVOR+0x04(r10)
+	lwz	r6, SS_IVOR+0x08(r10)
+	lwz	r7, SS_IVOR+0x0c(r10)
+
+	mtspr	SPRN_IVOR0, r4
+	mtspr	SPRN_IVOR1, r5
+	mtspr	SPRN_IVOR2, r6
+	mtspr	SPRN_IVOR3, r7
+
+	lwz	r4, SS_IVOR+0x10(r10)
+	lwz	r5, SS_IVOR+0x14(r10)
+	lwz	r6, SS_IVOR+0x18(r10)
+	lwz	r7, SS_IVOR+0x1c(r10)
+
+	mtspr	SPRN_IVOR4, r4
+	mtspr	SPRN_IVOR5, r5
+	mtspr	SPRN_IVOR6, r6
+	mtspr	SPRN_IVOR7, r7
+
+	lwz	r4, SS_IVOR+0x20(r10)
+	lwz	r5, SS_IVOR+0x24(r10)
+	lwz	r6, SS_IVOR+0x28(r10)
+	lwz	r7, SS_IVOR+0x2c(r10)
+
+	mtspr	SPRN_IVOR8, r4
+	mtspr	SPRN_IVOR9, r5
+	mtspr	SPRN_IVOR10, r6
+	mtspr	SPRN_IVOR11, r7
+
+	lwz	r4, SS_IVOR+0x30(r10)
+	lwz	r5, SS_IVOR+0x34(r10)
+	lwz	r6, SS_IVOR+0x38(r10)
+	lwz	r7, SS_IVOR+0x3c(r10)
+
+	mtspr	SPRN_IVOR12, r4
+	mtspr	SPRN_IVOR13, r5
+	mtspr	SPRN_IVOR14, r6
+	mtspr	SPRN_IVOR15, r7
+
+	lwz	r4, SS_IVOR+0x40(r10)
+	lwz	r5, SS_IVOR+0x44(r10)
+	lwz	r6, SS_IVOR+0x48(r10)
+	lwz	r7, SS_IVOR+0x4c(r10)
+
+	mtspr	SPRN_IVOR32, r4
+	mtspr	SPRN_IVOR33, r5
+	mtspr	SPRN_IVOR34, r6
+	mtspr	SPRN_IVOR35, r7
+
+	lwz	r4, SS_TCR(r10)
+	lwz	r5, SS_BUCSR(r10)
+	lwz	r6, SS_L1CSR+0(r10)
+	lwz	r7, SS_L1CSR+4(r10)
+	lwz	r8, SS_USPRG+0(r10)
+
+	mtspr	SPRN_TCR, r4
+	mtspr	SPRN_BUCSR, r5
+
+	msync
+	isync
+	mtspr	SPRN_L1CSR0, r6
+	isync
+
+	mtspr	SPRN_L1CSR1, r7
+	isync
+
+	mtspr	SPRN_USPRG0, r8
+
+	lmw	r12, SS_GPREG(r10)
+
+	lwz	r1, SS_SP(r10)
+	lwz	r2, SS_CURRENT(r10)
+	lwz	r4, SS_MSR(r10)
+	lwz	r5, SS_LR(r10)
+	lwz	r6, SS_CR(r10)
+
+	msync
+	mtmsr	r4
+	isync
+
+	mtlr	r5
+	mtcr	r6
+
+	li	r4, 0
+	mtspr	SPRN_TBWL, r4
+
+	lwz	r4, SS_TB+0(r10)
+	lwz	r5, SS_TB+4(r10)
+
+	mtspr	SPRN_TBWU, r4
+	mtspr	SPRN_TBWL, r5
+
+	lis	r3, 1
+	mtdec	r3
+
+	blr
+
+
+_GLOBAL(mpc85xx_cpu_down)
+       stwu    r1,-16(r1)
+       mflr    r0
+       stw     r0,20(r1)
+       bl      flush_dcache_L1
+       lwz     r0,20(r1)
+       addi    r1,r1,16
+       mtlr    r0
+       lis     r3,HID0_NAP@h
+
+       /* Go to NAP or DOZE now */
+       mfspr   r4,SPRN_HID0
+       rlwinm  r4,r4,0,~(HID0_DOZE|HID0_NAP|HID0_SLEEP)
+       or      r4,r4,r3
+       isync
+       mtspr   SPRN_HID0,r4
+       isync
+
+       mfmsr   r7
+       oris    r7,r7,MSR_WE@h
+       msync
+       mtmsr   r7
+       isync
+99:    b       99b
diff --git a/arch/powerpc/sysdev/fsl_pmc.c b/arch/powerpc/sysdev/fsl_pmc.c
index 44de855..00014b5 100644
--- a/arch/powerpc/sysdev/fsl_pmc.c
+++ b/arch/powerpc/sysdev/fsl_pmc.c
@@ -2,6 +2,7 @@
  * Suspend/resume support
  *
  * Copyright 2009  MontaVista Software, Inc.
+ * Copyright 2007-2010 Freescale Semiconductor Inc.
  *
  * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
  *
@@ -18,39 +19,137 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/of_platform.h>
+#include <linux/pm.h>
+#include <linux/interrupt.h>
+
+#include <sysdev/fsl_soc.h>
 
 struct pmc_regs {
 	__be32 devdisr;
-	__be32 devdisr2;
+	__be32 :32;
 	__be32 :32;
 	__be32 :32;
 	__be32 pmcsr;
-#define PMCSR_SLP	(1 << 17)
+	__be32 :32;
+	__be32 :32;
+	__be32 pmcdr;
 };
-
 static struct device *pmc_dev;
 static struct pmc_regs __iomem *pmc_regs;
 
+#define PMCSR_SLP	0x00020000
+#define PMCSR_LOSSLESS	0x00400000
+static int has_deep_sleep, has_lossless;
+
+void mpc85xx_enter_deep_sleep(phys_addr_t ccsrbar, u32 powmgtreq);
+
+/**
+ * pmc_enable_wake - enable OF device as wakeup event source
+ * @pdev: platform device affected
+ * @state: PM state from which device will issue wakeup events
+ * @enable: True to enable event generation; false to disable
+ *
+ * This enables the device as a wakeup event source, or disables it.
+ *
+ * RETURN VALUE:
+ * 0 is returned on success
+ * -EINVAL is returned if device is not supposed to wake up the system
+ * Error code depending on the platform is returned if both the platform and
+ * the native mechanism fail to enable the generation of wake-up events
+ */
+int pmc_enable_wake(struct platform_device *pdev, suspend_state_t state, bool enable)
+{
+	int ret = 0;
+	struct device_node *clk_np;
+	u32 *pmcdr_mask;
+
+	if (enable && !device_may_wakeup(&pdev->dev))
+		return -EINVAL;
+
+	clk_np = of_parse_phandle(pdev->dev.of_node, "clk-handle", 0);
+	if (!clk_np)
+		return -EINVAL;
+
+	pmcdr_mask = (u32 *)of_get_property(clk_np, "fsl,pmcdr-mask", NULL);
+	if (!pmcdr_mask) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* clear to enable clock in low power mode */
+	if (enable)
+		clrbits32(&pmc_regs->pmcdr, *pmcdr_mask);
+	else
+		setbits32(&pmc_regs->pmcdr, *pmcdr_mask);
+
+out:
+	of_node_put(clk_np);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pmc_enable_wake);
+
+/**
+ * pmc_enable_lossless - enable lossless ethernet in low power mode
+ * @enable: True to enable event generation; false to disable
+ */
+void pmc_enable_lossless(int enable)
+{
+	if (enable && has_lossless)
+		setbits32(&pmc_regs->pmcsr, PMCSR_LOSSLESS);
+	else
+		clrbits32(&pmc_regs->pmcsr, PMCSR_LOSSLESS);
+}
+EXPORT_SYMBOL_GPL(pmc_enable_lossless);
+
 static int pmc_suspend_enter(suspend_state_t state)
 {
 	int ret;
+	u32 powmgtreq = 0x00500000;
 
-	setbits32(&pmc_regs->pmcsr, PMCSR_SLP);
-	/* At this point, the CPU is asleep. */
+	switch (state) {
+	case PM_SUSPEND_MEM:
+#ifdef CONFIG_SPE
+		enable_kernel_spe();
+#endif
+		pr_debug("Entering deep sleep\n");
+
+		local_irq_disable();
+		mpc85xx_enter_deep_sleep(get_immrbase(),
+				powmgtreq);
+		pr_debug("Resumed from deep sleep\n");
+
+		return 0;
+
+	/* else fall-through */
+	case PM_SUSPEND_STANDBY:
+		local_irq_disable();
+
+		setbits32(&pmc_regs->pmcsr, PMCSR_SLP);
+
+		/* At this point, the CPU is asleep. */
+		/* Upon resume, wait for SLP bit to be clear. */
+		ret = spin_event_timeout((in_be32(&pmc_regs->pmcsr) & PMCSR_SLP)
+				== 0, 10000, 10) ? 0 : -ETIMEDOUT;
+		if (ret)
+			dev_err(pmc_dev,
+				"timeout waiting for SLP bit to be cleared\n");
+
+		return 0;
+
+	default:
+		return -EINVAL;
+
+	}
 
-	/* Upon resume, wait for SLP bit to be clear. */
-	ret = spin_event_timeout((in_be32(&pmc_regs->pmcsr) & PMCSR_SLP) == 0,
-				 10000, 10) ? 0 : -ETIMEDOUT;
-	if (ret)
-		dev_err(pmc_dev, "tired waiting for SLP bit to clear\n");
-	return ret;
 }
 
 static int pmc_suspend_valid(suspend_state_t state)
 {
-	if (state != PM_SUSPEND_STANDBY)
-		return 0;
-	return 1;
+	if (state == PM_SUSPEND_STANDBY)
+		return 1;
+	if (has_deep_sleep && (state == PM_SUSPEND_MEM))
+		return 1;
+	return 0;
 }
 
 static struct platform_suspend_ops pmc_suspend_ops = {
@@ -58,14 +157,30 @@ static struct platform_suspend_ops pmc_suspend_ops = {
 	.enter = pmc_suspend_enter,
 };
 
-static int pmc_probe(struct platform_device *ofdev,
+static int pmc_probe(struct platform_device *pdev,
 		     const struct of_device_id *id)
 {
-	pmc_regs = of_iomap(ofdev->dev.of_node, 0);
-	if (!pmc_regs)
-		return -ENOMEM;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "fsl,mpc8548-pmc");
+
+	if (node) {
+		pmc_regs = of_iomap(pdev->dev.of_node, 0);
+		if (!pmc_regs)
+			return -ENOMEM;
+
+		if (of_device_is_compatible(np, "fsl,mpc8536-pmc")) {
+			has_deep_sleep = 1;
+		}
+		if (of_device_is_compatible(np, "fsl,p1022-pmc")) {
+			has_lossless = 1;
+		}
+
+		of_node_put(node);
+	}
 
-	pmc_dev = &ofdev->dev;
+	pmc_dev = &pdev->dev;
 	suspend_set_ops(&pmc_suspend_ops);
 	return 0;
 }
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 5360948..5250539 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -3,6 +3,8 @@
 #ifdef __KERNEL__
 
 #include <asm/mmu.h>
+#include <linux/platform_device.h>
+#include <linux/suspend.h>
 
 struct spi_device;
 
@@ -21,6 +23,15 @@ struct device_node;
 
 extern void fsl_rstcr_restart(char *cmd);
 
+#ifdef CONFIG_FSL_PMC
+int pmc_enable_wake(struct platform_device *pdev, suspend_state_t state,
+		bool enable);
+void pmc_enable_lossless(int enable);
+#else
+#define pmc_enable_wake(pdev, state, enable)	(-EINVAL)
+#define pmc_enable_lossless(enable) do {} while (0);
+#endif
+
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 struct platform_diu_data_ops {
 	unsigned int (*get_pixel_format) (unsigned int bits_per_pixel,
-- 
1.6.6-rc1.GIT
