Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D752DE312
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 04:36:11 +1100 (EST)
Date: Wed, 12 Dec 2007 11:36:03 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 5/8] mpc83xx: Power Management support
Message-ID: <20071212173603.GD5596@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071212173519.GA5577@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Basic PM support for 83xx.  Standby is implemented as sleep.
Suspend-to-RAM is implemented as "deep sleep" (with the processor
turned off) on 831x.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/83xx/Kconfig       |    5 +
 arch/powerpc/platforms/83xx/Makefile      |    1 +
 arch/powerpc/platforms/83xx/suspend-asm.S |  531 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/suspend.c     |  423 +++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.c             |   33 ++
 arch/powerpc/sysdev/fsl_soc.h             |   10 +
 arch/powerpc/sysdev/ipic.c                |   71 ++++
 include/asm-powerpc/reg.h                 |    4 +
 include/linux/fsl_devices.h               |   24 ++
 9 files changed, 1102 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/83xx/suspend-asm.S
 create mode 100644 arch/powerpc/platforms/83xx/suspend.c

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index ec305f1..901dbaf 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -75,3 +75,8 @@ config PPC_MPC836x
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
 	default y if MPC836x_MDS
+
+config PPC_83xx_SUSPEND
+	bool
+	default y
+	depends on PPC_83xx && SUSPEND
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index 5a98f88..944369e 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -3,6 +3,7 @@
 #
 obj-y				:= misc.o usb.o
 obj-$(CONFIG_PCI)		+= pci.o
+obj-$(CONFIG_SUSPEND)		+= suspend.o suspend-asm.o
 obj-$(CONFIG_MPC8313_RDB)	+= mpc8313_rdb.o
 obj-$(CONFIG_MPC832x_RDB)	+= mpc832x_rdb.o
 obj-$(CONFIG_MPC834x_MDS)	+= mpc834x_mds.o
diff --git a/arch/powerpc/platforms/83xx/suspend-asm.S b/arch/powerpc/platforms/83xx/suspend-asm.S
new file mode 100644
index 0000000..bfff3bd
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/suspend-asm.S
@@ -0,0 +1,531 @@
+/*
+ * Enter and leave sleep state on MPC83xx
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2006 Freescale Semiconductor, Inc.
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
+#define SS_MEMSAVE	0x00
+#define SS_HID		0x08 /* 3 HIDs */
+#define SS_IABR		0x14 /* 2 IABRs */
+#define SS_IBCR		0x1c
+#define SS_DABR		0x20 /* 2 DABRs */
+#define SS_DBCR		0x28
+#define SS_SP		0x2c
+#define SS_SR		0x30 /* 16 segment registers */
+#define SS_CURRENT	0x70
+#define SS_MSR		0x74
+#define SS_SDR1		0x78
+#define SS_LR		0x7c
+#define SS_SPRG		0x80 /* 4 SPRGs */
+#define SS_DBAT		0x90 /* 8 DBATs */
+#define SS_IBAT		0xd0 /* 8 IBATs */
+#define SS_TB		0x110
+#define SS_CR		0x118
+#define SS_GPREG	0x11c /* r12-r31 */
+#define STATE_SAVE_SIZE 0x16c
+
+	.section .data
+	.align	5
+
+mpc83xx_sleep_save_area:
+	.space	STATE_SAVE_SIZE
+immrbase:
+	.long	0
+
+	.section .text
+	.align	5
+
+	/* r3 = physical address of IMMR */
+_GLOBAL(mpc83xx_enter_deep_sleep)
+	/* Re-use the state saving/restoring code in
+	 * arch/powerpc/kernel/swsusp_32.S, but have
+	 * it call us instead of swsusp_save.
+	 */
+
+	lis	r4, immrbase@ha
+	stw	r3, immrbase@l(r4)
+
+	/* The first 2 words of memory are used to communicate with the
+	 * bootloader, to tell it how to resume.
+	 *
+	 * The first word is the magic number 0xf5153ae5, and the second
+	 * is the pointer to mpc83xx_deep_resume.
+	 *
+	 * The original content of these two words is saved in the state
+	 * save area.
+	 */
+
+	lis	r3, mpc83xx_sleep_save_area@h
+	ori	r3, r3, mpc83xx_sleep_save_area@l
+
+	lis	r4, KERNELBASE@h
+	lwz	r5, 0(r4)
+	lwz	r6, 4(r4)
+
+	stw	r5, SS_MEMSAVE+0(r3)
+	stw	r6, SS_MEMSAVE+4(r3)
+
+	mfspr	r5, SPRN_HID0
+	mfspr	r6, SPRN_HID1
+	mfspr	r7, SPRN_HID2
+
+	stw	r5, SS_HID+0(r3)
+	stw	r6, SS_HID+4(r3)
+	stw	r7, SS_HID+8(r3)
+
+	mfspr	r4, SPRN_IABR
+	mfspr	r5, SPRN_IABR2
+	mfspr	r6, SPRN_IBCR
+	mfspr	r7, SPRN_DABR
+	mfspr	r8, SPRN_DABR2
+	mfspr	r9, SPRN_DBCR
+
+	stw	r4, SS_IABR+0(r3)
+	stw	r5, SS_IABR+4(r3)
+	stw	r6, SS_IBCR(r3)
+	stw	r7, SS_DABR+0(r3)
+	stw	r8, SS_DABR+4(r3)
+	stw	r9, SS_DBCR(r3)
+
+	mfspr	r4, SPRN_SPRG0
+	mfspr	r5, SPRN_SPRG1
+	mfspr	r6, SPRN_SPRG2
+	mfspr	r7, SPRN_SPRG3
+	mfsdr1	r8
+
+	stw	r4, SS_SPRG+0(r3)
+	stw	r5, SS_SPRG+4(r3)
+	stw	r6, SS_SPRG+8(r3)
+	stw	r7, SS_SPRG+12(r3)
+	stw	r8, SS_SDR1(r3)
+
+	mfspr	r4, SPRN_DBAT0U
+	mfspr	r5, SPRN_DBAT0L
+	mfspr	r6, SPRN_DBAT1U
+	mfspr	r7, SPRN_DBAT1L
+
+	stw	r4, SS_DBAT+0x00(r3)
+	stw	r5, SS_DBAT+0x04(r3)
+	stw	r6, SS_DBAT+0x08(r3)
+	stw	r7, SS_DBAT+0x0c(r3)
+
+	mfspr	r4, SPRN_DBAT2U
+	mfspr	r5, SPRN_DBAT2L
+	mfspr	r6, SPRN_DBAT3U
+	mfspr	r7, SPRN_DBAT3L
+
+	stw	r4, SS_DBAT+0x10(r3)
+	stw	r5, SS_DBAT+0x14(r3)
+	stw	r6, SS_DBAT+0x18(r3)
+	stw	r7, SS_DBAT+0x1c(r3)
+
+	mfspr	r4, SPRN_DBAT4U
+	mfspr	r5, SPRN_DBAT4L
+	mfspr	r6, SPRN_DBAT5U
+	mfspr	r7, SPRN_DBAT5L
+
+	stw	r4, SS_DBAT+0x20(r3)
+	stw	r5, SS_DBAT+0x24(r3)
+	stw	r6, SS_DBAT+0x28(r3)
+	stw	r7, SS_DBAT+0x2c(r3)
+
+	mfspr	r4, SPRN_DBAT6U
+	mfspr	r5, SPRN_DBAT6L
+	mfspr	r6, SPRN_DBAT7U
+	mfspr	r7, SPRN_DBAT7L
+
+	stw	r4, SS_DBAT+0x30(r3)
+	stw	r5, SS_DBAT+0x34(r3)
+	stw	r6, SS_DBAT+0x38(r3)
+	stw	r7, SS_DBAT+0x3c(r3)
+
+	mfspr	r4, SPRN_IBAT0U
+	mfspr	r5, SPRN_IBAT0L
+	mfspr	r6, SPRN_IBAT1U
+	mfspr	r7, SPRN_IBAT1L
+
+	stw	r4, SS_IBAT+0x00(r3)
+	stw	r5, SS_IBAT+0x04(r3)
+	stw	r6, SS_IBAT+0x08(r3)
+	stw	r7, SS_IBAT+0x0c(r3)
+
+	mfspr	r4, SPRN_IBAT2U
+	mfspr	r5, SPRN_IBAT2L
+	mfspr	r6, SPRN_IBAT3U
+	mfspr	r7, SPRN_IBAT3L
+
+	stw	r4, SS_IBAT+0x10(r3)
+	stw	r5, SS_IBAT+0x14(r3)
+	stw	r6, SS_IBAT+0x18(r3)
+	stw	r7, SS_IBAT+0x1c(r3)
+
+	mfspr	r4, SPRN_IBAT4U
+	mfspr	r5, SPRN_IBAT4L
+	mfspr	r6, SPRN_IBAT5U
+	mfspr	r7, SPRN_IBAT5L
+
+	stw	r4, SS_IBAT+0x20(r3)
+	stw	r5, SS_IBAT+0x24(r3)
+	stw	r6, SS_IBAT+0x28(r3)
+	stw	r7, SS_IBAT+0x2c(r3)
+
+	mfspr	r4, SPRN_IBAT6U
+	mfspr	r5, SPRN_IBAT6L
+	mfspr	r6, SPRN_IBAT7U
+	mfspr	r7, SPRN_IBAT7L
+
+	stw	r4, SS_IBAT+0x30(r3)
+	stw	r5, SS_IBAT+0x34(r3)
+	stw	r6, SS_IBAT+0x38(r3)
+	stw	r7, SS_IBAT+0x3c(r3)
+
+	mfmsr	r4
+	mflr	r5
+	mfcr	r6
+
+	stw	r4, SS_MSR(r3)
+	stw	r5, SS_LR(r3)
+	stw	r6, SS_CR(r3)
+	stw	r1, SS_SP(r3)
+	stw	r2, SS_CURRENT(r3)
+
+1:	mftbu	r4
+	mftb	r5
+	mftbu	r6
+	cmpw	r4, r6
+	bne	1b
+
+	stw	r4, SS_TB+0(r3)
+	stw	r5, SS_TB+4(r3)
+
+	stmw	r12, SS_GPREG(r3)
+
+	li	r4, 0
+	addi	r6, r3, SS_SR-4
+1:	mfsrin	r5, r4
+	stwu	r5, 4(r6)
+	addis	r4, r4, 0x1000
+	cmpwi	r4, 0
+	bne	1b
+
+	/* Disable machine checks and critical exceptions */
+	mfmsr	r4
+	rlwinm	r4, r4, 0, ~MSR_CE
+	rlwinm	r4, r4, 0, ~MSR_ME
+	mtmsr	r4
+	isync
+
+#define TMP_VIRT_IMMR		0xf0000000
+#define DEFAULT_IMMR_VALUE	0xff400000
+#define IMMRBAR_BASE		0x0000
+
+	lis	r4, immrbase@ha
+	lwz	r4, immrbase@l(r4)
+
+	/* Use DBAT0 to address the current IMMR space */
+
+	ori	r4, r4, 0x002a
+	mtspr	SPRN_DBAT0L, r4
+	lis	r8, TMP_VIRT_IMMR@h
+	ori	r4, r8, 0x001e	/* 1 MByte accessable from Kernel Space only */
+	mtspr	SPRN_DBAT0U, r4
+	isync
+
+	/* Use DBAT1 to address the original IMMR space */
+
+	lis	r4, DEFAULT_IMMR_VALUE@h
+	ori	r4, r4, 0x002a
+	mtspr	SPRN_DBAT1L, r4
+	lis	r9, (TMP_VIRT_IMMR + 0x01000000)@h
+	ori	r4, r9, 0x001e	/* 1 MByte accessable from Kernel Space only */
+	mtspr	SPRN_DBAT1U, r4
+	isync
+
+	/* Use DBAT2 to address the beginning of RAM.  This isn't done
+	 * using the normal virtual mapping, because with page debugging
+	 * enabled it will be read-only. */
+
+	li	r4, 0x0002
+	mtspr	SPRN_DBAT2L, r4
+	lis	r4, KERNELBASE@h
+	ori	r4, r4, 0x001e	/* 1 MByte accessable from Kernel Space only */
+	mtspr	SPRN_DBAT2U, r4
+	isync
+
+	/* Flush the cache with our BAT, as there will be TLB misses
+	 * otherwise if page debugging is enabled, and these misses
+	 * will disturb the PLRU algorithm.
+	 */
+
+	bl	__flush_disable_L1
+
+	lis	r6, 0xf515
+	ori	r6, r6, 0x3ae5
+
+	lis	r7, mpc83xx_deep_resume@h
+	ori	r7, r7, mpc83xx_deep_resume@l
+	tophys(r7, r7)
+
+	lis	r5, KERNELBASE@h
+	stw	r6, 0(r5)
+	stw	r7, 4(r5)
+
+	/* Reset BARs */
+
+	li	r4, 0
+	stw	r4, 0x0024(r8)
+	stw	r4, 0x002c(r8)
+	stw	r4, 0x0034(r8)
+	stw	r4, 0x003c(r8)
+	stw	r4, 0x0064(r8)
+	stw	r4, 0x006c(r8)
+
+	/* Rev 1 of the 8313 has problems with wakeup events that are
+	 * pending during the transition to deep sleep state (such as if
+	 * the PCI host sets the state to D3 and then D0 in rapid
+	 * succession).  This check shrinks the race window somewhat.
+	 *
+	 * See erratum PCI23, though the problem is not limited
+	 * to PCI.
+	 */
+
+	lwz	r3, 0x0b04(r8)
+	andi.	r3, r3, 1
+	bne-	mpc83xx_deep_resume
+
+	/* Move IMMR back to the default location, following the
+	 * procedure specified in the MPC8313 manual.
+	 */
+	lwz	r4, IMMRBAR_BASE(r8)
+	isync
+	lis	r4, DEFAULT_IMMR_VALUE@h
+	stw	r4, IMMRBAR_BASE(r8)
+	lis	r4, KERNELBASE@h
+	lwz	r4, 0(r4)
+	isync
+	lwz	r4, IMMRBAR_BASE(r9)
+	mr	r8, r9
+	isync
+
+	/* Check the Reset Configuration Word to see whether flash needs
+	 * to be mapped at a low address or a high address.
+	 */
+
+	lwz	r4, 0x0904(r8)
+	andis.	r4, r4, 0x0400
+	li	r4, 0
+	beq	boot_low
+	lis	r4, 0xff80
+boot_low:
+	stw	r4, 0x0020(r8)
+	lis	r7, 0x8000
+	ori	r7, r7, 0x0016
+
+	mfspr	r5, SPRN_HID0
+	rlwinm	r5, r5, 0, ~(HID0_DOZE | HID0_NAP)
+	oris	r5, r5, HID0_SLEEP@h
+	mtspr	SPRN_HID0, r5
+	isync
+
+	mfmsr	r5
+	oris	r5, r5, MSR_POW@h
+
+	/* Enable the flash mapping at the appropriate address.  This
+	 * mapping will override the RAM mapping, so there's no need to
+	 * disable the latter.  This must be done inside the same cache
+	 * line as setting MSR_POW, so that no instruction fetches from
+	 * RAM happen after the flash mapping is turned on.
+	 */
+
+	.align	5
+	stw	r7, 0x0024(r8)
+	sync
+	isync
+	mtmsr	r5
+	isync
+1:	b	1b
+
+mpc83xx_deep_resume:
+	lis	r4, 1f@h
+	ori	r4, r4, 1f@l
+	tophys(r4, r4)
+	mtsrr0	r4
+
+	mfmsr	r4
+	rlwinm	r4, r4, 0, ~(MSR_IR | MSR_DR)
+	mtsrr1	r4
+
+	rfi
+
+1:	tlbia
+	bl	__inval_enable_L1
+
+	lis	r3, mpc83xx_sleep_save_area@h
+	ori	r3, r3, mpc83xx_sleep_save_area@l
+	tophys(r3, r3)
+
+	lwz	r5, SS_MEMSAVE+0(r3)
+	lwz	r6, SS_MEMSAVE+4(r3)
+
+	stw	r5, 0(0)
+	stw	r6, 4(0)
+
+	lwz	r5, SS_HID+0(r3)
+	lwz	r6, SS_HID+4(r3)
+	lwz	r7, SS_HID+8(r3)
+
+	mtspr	SPRN_HID0, r5
+	mtspr	SPRN_HID1, r6
+	mtspr	SPRN_HID2, r7
+
+	lwz	r4, SS_IABR+0(r3)
+	lwz	r5, SS_IABR+4(r3)
+	lwz	r6, SS_IBCR(r3)
+	lwz	r7, SS_DABR+0(r3)
+	lwz	r8, SS_DABR+4(r3)
+	lwz	r9, SS_DBCR(r3)
+
+	mtspr	SPRN_IABR, r4
+	mtspr	SPRN_IABR2, r5
+	mtspr	SPRN_IBCR, r6
+	mtspr	SPRN_DABR, r7
+	mtspr	SPRN_DABR2, r8
+	mtspr	SPRN_DBCR, r9
+
+	li	r4, 0
+	addi	r6, r3, SS_SR-4
+1:	lwzu	r5, 4(r6)
+	mtsrin	r5, r4
+	addis	r4, r4, 0x1000
+	cmpwi	r4, 0
+	bne	1b
+
+	lwz	r4, SS_DBAT+0x00(r3)
+	lwz	r5, SS_DBAT+0x04(r3)
+	lwz	r6, SS_DBAT+0x08(r3)
+	lwz	r7, SS_DBAT+0x0c(r3)
+
+	mtspr	SPRN_DBAT0U, r4
+	mtspr	SPRN_DBAT0L, r5
+	mtspr	SPRN_DBAT1U, r6
+	mtspr	SPRN_DBAT1L, r7
+
+	lwz	r4, SS_DBAT+0x10(r3)
+	lwz	r5, SS_DBAT+0x14(r3)
+	lwz	r6, SS_DBAT+0x18(r3)
+	lwz	r7, SS_DBAT+0x1c(r3)
+
+	mtspr	SPRN_DBAT2U, r4
+	mtspr	SPRN_DBAT2L, r5
+	mtspr	SPRN_DBAT3U, r6
+	mtspr	SPRN_DBAT3L, r7
+
+	lwz	r4, SS_DBAT+0x20(r3)
+	lwz	r5, SS_DBAT+0x24(r3)
+	lwz	r6, SS_DBAT+0x28(r3)
+	lwz	r7, SS_DBAT+0x2c(r3)
+
+	mtspr	SPRN_DBAT4U, r4
+	mtspr	SPRN_DBAT4L, r5
+	mtspr	SPRN_DBAT5U, r6
+	mtspr	SPRN_DBAT5L, r7
+
+	lwz	r4, SS_DBAT+0x30(r3)
+	lwz	r5, SS_DBAT+0x34(r3)
+	lwz	r6, SS_DBAT+0x38(r3)
+	lwz	r7, SS_DBAT+0x3c(r3)
+
+	mtspr	SPRN_DBAT6U, r4
+	mtspr	SPRN_DBAT6L, r5
+	mtspr	SPRN_DBAT7U, r6
+	mtspr	SPRN_DBAT7L, r7
+
+	lwz	r4, SS_IBAT+0x00(r3)
+	lwz	r5, SS_IBAT+0x04(r3)
+	lwz	r6, SS_IBAT+0x08(r3)
+	lwz	r7, SS_IBAT+0x0c(r3)
+
+	mtspr	SPRN_IBAT0U, r4
+	mtspr	SPRN_IBAT0L, r5
+	mtspr	SPRN_IBAT1U, r6
+	mtspr	SPRN_IBAT1L, r7
+
+	lwz	r4, SS_IBAT+0x10(r3)
+	lwz	r5, SS_IBAT+0x14(r3)
+	lwz	r6, SS_IBAT+0x18(r3)
+	lwz	r7, SS_IBAT+0x1c(r3)
+
+	mtspr	SPRN_IBAT2U, r4
+	mtspr	SPRN_IBAT2L, r5
+	mtspr	SPRN_IBAT3U, r6
+	mtspr	SPRN_IBAT3L, r7
+
+	lwz	r4, SS_IBAT+0x20(r3)
+	lwz	r5, SS_IBAT+0x24(r3)
+	lwz	r6, SS_IBAT+0x28(r3)
+	lwz	r7, SS_IBAT+0x2c(r3)
+
+	mtspr	SPRN_IBAT4U, r4
+	mtspr	SPRN_IBAT4L, r5
+	mtspr	SPRN_IBAT5U, r6
+	mtspr	SPRN_IBAT5L, r7
+
+	lwz	r4, SS_IBAT+0x30(r3)
+	lwz	r5, SS_IBAT+0x34(r3)
+	lwz	r6, SS_IBAT+0x38(r3)
+	lwz	r7, SS_IBAT+0x3c(r3)
+
+	mtspr	SPRN_IBAT6U, r4
+	mtspr	SPRN_IBAT6L, r5
+	mtspr	SPRN_IBAT7U, r6
+	mtspr	SPRN_IBAT7L, r7
+
+	lwz	r4, SS_SPRG+0(r3)
+	lwz	r5, SS_SPRG+4(r3)
+	lwz	r6, SS_SPRG+8(r3)
+	lwz	r7, SS_SPRG+12(r3)
+	lwz	r8, SS_SDR1(r3)
+
+	mtspr	SPRN_SPRG0, r4
+	mtspr	SPRN_SPRG1, r5
+	mtspr	SPRN_SPRG2, r6
+	mtspr	SPRN_SPRG3, r7
+	mtsdr1	r8
+
+	lwz	r4, SS_MSR(r3)
+	lwz	r5, SS_LR(r3)
+	lwz	r6, SS_CR(r3)
+	lwz	r1, SS_SP(r3)
+	lwz	r2, SS_CURRENT(r3)
+
+	mtsrr1	r4
+	mtsrr0	r5
+	mtcr	r6
+
+	li	r4, 0
+	mtspr	SPRN_TBWL, r4
+
+	lwz	r4, SS_TB+0(r3)
+	lwz	r5, SS_TB+4(r3)
+
+	mtspr	SPRN_TBWU, r4
+	mtspr	SPRN_TBWL, r5
+
+	lmw	r12, SS_GPREG(r3)
+
+	/* Kick decrementer */
+	li	r0, 1
+	mtdec	r0
+
+	rfi
diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
new file mode 100644
index 0000000..61bca38
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -0,0 +1,423 @@
+/*
+ * MPC83xx suspend support
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2006-2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/types.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/wait.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
+#include <linux/suspend.h>
+#include <linux/fsl_devices.h>
+#include <linux/of_platform.h>
+
+#include <asm/reg.h>
+#include <asm/io.h>
+#include <asm/time.h>
+#include <asm/mpc6xx.h>
+
+#include <sysdev/fsl_soc.h>
+
+#define PMCCR1_NEXT_STATE       0x0C /* Next state for power management */
+#define PMCCR1_NEXT_STATE_SHIFT 2
+#define PMCCR1_CURR_STATE       0x03 /* Current state for power management*/
+#define IMMR_RCW_OFFSET         0x900
+#define RCW_PCI_HOST            0x80000000
+
+void mpc83xx_enter_deep_sleep(phys_addr_t immrbase);
+
+struct mpc83xx_pmc {
+	u32 config;
+#define PMCCR_DLPEN 2 /* DDR SDRAM low power enable */
+#define PMCCR_SLPEN 1 /* System low power enable */
+
+	u32 event;
+	u32 mask;
+/* All but PMCI are deep-sleep only */
+#define PMCER_GPIO   0x100
+#define PMCER_PCI    0x080
+#define PMCER_USB    0x040
+#define PMCER_ETSEC1 0x020
+#define PMCER_ETSEC2 0x010
+#define PMCER_TIMER  0x008
+#define PMCER_INT1   0x004
+#define PMCER_INT2   0x002
+#define PMCER_PMCI   0x001
+#define PMCER_ALL    0x1FF
+
+	/* deep-sleep only */
+	u32 config1;
+#define PMCCR1_USE_STATE  0x80000000
+#define PMCCR1_PME_EN     0x00000080
+#define PMCCR1_ASSERT_PME 0x00000040
+#define PMCCR1_POWER_OFF  0x00000020
+
+	/* deep-sleep only */
+	u32 config2;
+};
+
+struct mpc83xx_rcw {
+	u32 rcwlr;
+	u32 rcwhr;
+};
+
+struct mpc83xx_clock {
+	u32 spmr;
+	u32 occr;
+	u32 sccr;
+};
+
+struct pmc_type {
+	int has_deep_sleep;
+};
+
+static struct of_device *pmc_dev;
+static int has_deep_sleep, deep_sleeping;
+static int pmc_irq;
+static struct mpc83xx_pmc __iomem *pmc_regs;
+static struct mpc83xx_clock __iomem *clock_regs;
+static int is_pci_agent, wake_from_pci;
+static phys_addr_t immrbase;
+static int pci_pm_state;
+static DECLARE_WAIT_QUEUE_HEAD(agent_wq);
+
+static u32 saved_sccr;
+static DEFINE_SPINLOCK(device_sleep_lock);
+
+void fsl_sleep_device(struct fsl_sleep_platform_data *data)
+{
+	if (clock_regs && data->sccr_mask) {
+		unsigned long flags;
+		u32 sccr;
+
+		spin_lock_irqsave(&device_sleep_lock, flags);
+		sccr = in_be32(&clock_regs->sccr);
+
+		saved_sccr &= ~data->sccr_mask;
+		saved_sccr |= sccr & data->sccr_mask;
+
+		out_be32(&clock_regs->sccr, sccr & ~data->sccr_mask);
+		spin_unlock_irqrestore(&device_sleep_lock, flags);
+	}
+}
+EXPORT_SYMBOL(fsl_sleep_device);
+
+void fsl_wake_device(struct fsl_sleep_platform_data *data)
+{
+	if (clock_regs && data->sccr_mask) {
+		unsigned long flags;
+		u32 sccr;
+
+		spin_lock_irqsave(&device_sleep_lock, flags);
+
+		sccr = in_be32(&clock_regs->sccr);
+		sccr |= saved_sccr & data->sccr_mask;
+		out_be32(&clock_regs->sccr, sccr);
+
+		spin_unlock_irqrestore(&device_sleep_lock, flags);
+	}
+}
+EXPORT_SYMBOL(fsl_wake_device);
+
+int fsl_deep_sleep(void)
+{
+	return deep_sleeping;
+}
+
+static int mpc83xx_change_state(void)
+{
+	u32 curr_state;
+	u32 reg_cfg1 = in_be32(&pmc_regs->config1);
+
+	if (is_pci_agent) {
+		pci_pm_state = (reg_cfg1 & PMCCR1_NEXT_STATE) >>
+		               PMCCR1_NEXT_STATE_SHIFT;
+		curr_state = reg_cfg1 & PMCCR1_CURR_STATE;
+
+		if (curr_state != pci_pm_state) {
+			reg_cfg1 &= ~PMCCR1_CURR_STATE;
+			reg_cfg1 |= pci_pm_state;
+			out_be32(&pmc_regs->config1, reg_cfg1);
+
+			wake_up(&agent_wq);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t pmc_irq_handler(int irq, void *dev_id)
+{
+	u32 event = in_be32(&pmc_regs->event);
+	int ret = IRQ_NONE;
+
+	if (mpc83xx_change_state())
+		ret = IRQ_HANDLED;
+
+	if (event) {
+		out_be32(&pmc_regs->event, event);
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static int mpc83xx_suspend_enter(suspend_state_t state)
+{
+	int ret = -EAGAIN;
+
+	/* Don't go to sleep if there's a race where pci_pm_state changes
+	 * between the agent thread checking it and the PM code disabling
+	 * interrupts.
+	 */
+	if (wake_from_pci) {
+		if (pci_pm_state != (deep_sleeping ? 3 : 2))
+			goto out;
+
+		out_be32(&pmc_regs->config1,
+		         in_be32(&pmc_regs->config1) | PMCCR1_PME_EN);
+	}
+
+	/* Put the system into low-power mode and the RAM
+	 * into self-refresh mode once the core goes to
+	 * sleep.
+	 */
+
+	out_be32(&pmc_regs->config, PMCCR_SLPEN | PMCCR_DLPEN);
+
+	/* If it has deep sleep (i.e. it's an 831x or compatible),
+	 * disable power to the core upon entering sleep mode.  This will
+	 * require going through the boot firmware upon a wakeup event.
+	 */
+
+	if (deep_sleeping) {
+		out_be32(&pmc_regs->mask, PMCER_ALL);
+
+		out_be32(&pmc_regs->config1,
+		         in_be32(&pmc_regs->config1) | PMCCR1_POWER_OFF);
+
+		enable_kernel_fp();
+
+		mpc83xx_enter_deep_sleep(immrbase);
+
+		out_be32(&pmc_regs->config1,
+		         in_be32(&pmc_regs->config1) & ~PMCCR1_POWER_OFF);
+
+		out_be32(&pmc_regs->mask, PMCER_PMCI);
+	} else {
+		out_be32(&pmc_regs->mask, PMCER_PMCI);
+
+		mpc6xx_enter_standby();
+	}
+
+	ret = 0;
+
+out:
+	out_be32(&pmc_regs->config1,
+	         in_be32(&pmc_regs->config1) & ~PMCCR1_PME_EN);
+
+	return ret;
+}
+
+static void mpc83xx_suspend_finish(void)
+{
+	deep_sleeping = 0;
+}
+
+static int mpc83xx_suspend_valid(suspend_state_t state)
+{
+	return state == PM_SUSPEND_STANDBY || state == PM_SUSPEND_MEM;
+}
+
+static int mpc83xx_suspend_set_target(suspend_state_t state)
+{
+	switch (state) {
+		case PM_SUSPEND_STANDBY:
+			deep_sleeping = 0;
+			return 0;
+
+		case PM_SUSPEND_MEM:
+			if (has_deep_sleep)
+				deep_sleeping = 1;
+
+			return 0;
+
+		default:
+			return -EINVAL;
+	}
+}
+
+static int agent_thread_fn(void *data)
+{
+	while (1) {
+		wait_event_interruptible(agent_wq, pci_pm_state >= 2);
+		try_to_freeze();
+
+		if (signal_pending(current) || pci_pm_state < 2)
+			continue;
+
+		/* With a preemptible kernel (or SMP), this could race with a
+		 * userspace-driven suspend request.  It's probably best to
+		 * avoid mixing the two with such a configuration (or else fix
+		 * it by adding a mutex to state_store that we can synchronize
+		 * with).
+		 */
+
+		wake_from_pci = 1;
+
+		pm_suspend(pci_pm_state == 3 ? PM_SUSPEND_MEM :
+		                               PM_SUSPEND_STANDBY);
+
+		wake_from_pci = 0;
+	}
+
+	return 0;
+}
+
+void mpc83xx_set_agent(void)
+{
+	out_be32(&pmc_regs->config1, PMCCR1_USE_STATE);
+	out_be32(&pmc_regs->mask, PMCER_PMCI);
+
+	kthread_run(agent_thread_fn, NULL, "PCI power mgt");
+}
+
+static int mpc83xx_is_pci_agent(void)
+{
+	struct mpc83xx_rcw __iomem *rcw_regs;
+	int ret;
+
+	rcw_regs = ioremap(get_immrbase() + IMMR_RCW_OFFSET,
+	                   sizeof(struct mpc83xx_rcw));
+
+	if (!rcw_regs)
+		return -ENOMEM;
+
+	ret = !(in_be32(&rcw_regs->rcwhr) & RCW_PCI_HOST);
+
+	iounmap(rcw_regs);
+	return ret;
+}
+
+static struct platform_suspend_ops mpc83xx_suspend_ops = {
+	.valid = mpc83xx_suspend_valid,
+	.set_target = mpc83xx_suspend_set_target,
+	.enter = mpc83xx_suspend_enter,
+	.finish = mpc83xx_suspend_finish,
+};
+
+static int pmc_probe(struct of_device *ofdev,
+                     const struct of_device_id *match)
+{
+	struct device_node *np = ofdev->node;
+	struct resource res;
+	struct pmc_type *type = match->data;
+	int ret = 0;
+
+	has_deep_sleep = type->has_deep_sleep;
+	immrbase = get_immrbase();
+	pmc_dev = ofdev;
+
+	is_pci_agent = mpc83xx_is_pci_agent();
+	if (is_pci_agent < 0)
+		return is_pci_agent;
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return -ENODEV;
+
+	pmc_irq = irq_of_parse_and_map(np, 0);
+	if (pmc_irq != NO_IRQ) {
+		ret = request_irq(pmc_irq, pmc_irq_handler, IRQF_SHARED,
+		                  "pmc", ofdev);
+
+		if (ret)
+			return -EBUSY;
+	}
+
+	pmc_regs = ioremap(res.start, sizeof(struct mpc83xx_pmc));
+
+	if (!pmc_regs) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = of_address_to_resource(np, 1, &res);
+	if (ret) {
+		ret = -ENODEV;
+		goto out_pmc;
+	}
+
+	clock_regs = ioremap(res.start, sizeof(struct mpc83xx_pmc));
+
+	if (!clock_regs) {
+		ret = -ENOMEM;
+		goto out_pmc;
+	}
+
+	if (is_pci_agent)
+		mpc83xx_set_agent();
+
+	suspend_set_ops(&mpc83xx_suspend_ops);
+	return 0;
+
+out_pmc:
+	iounmap(pmc_regs);
+out:
+	if (pmc_irq != NO_IRQ)
+		free_irq(pmc_irq, ofdev);
+
+	return ret;
+}
+
+static int pmc_remove(struct of_device *ofdev)
+{
+	return -EPERM;
+};
+
+static struct pmc_type pmc_types[] = {
+	{
+		.has_deep_sleep = 1,
+	},
+	{
+		.has_deep_sleep = 0,
+	}
+};
+
+static struct of_device_id pmc_match[] = {
+	{
+		.compatible = "fsl,mpc8313-pmc",
+		.data = &pmc_types[0],
+	},
+	{
+		.compatible = "fsl,mpc8349-pmc",
+		.data = &pmc_types[1],
+	},
+	{}
+};
+
+static struct of_platform_driver pmc_driver = {
+	.name = "mpc83xx-pmc",
+	.match_table = pmc_match,
+	.probe = pmc_probe,
+	.remove = pmc_remove
+};
+
+static int pmc_init(void)
+{
+	return of_register_platform_driver(&pmc_driver);
+}
+
+module_init(pmc_init);
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index e1ba33c..d5fd916 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -151,6 +151,33 @@ u32 get_baudrate(void)
 EXPORT_SYMBOL(get_baudrate);
 #endif /* CONFIG_CPM2 */
 
+int fsl_sleep_init(struct fsl_sleep_platform_data *sleep,
+                   struct device_node *node)
+{
+	int proplen, ret = -ENODEV;
+	const u32 *sleepdata = of_get_property(node, "sleep", &proplen);
+	struct device_node *sleep_controller;
+
+	if (!sleepdata || proplen != 8)
+		return -ENODEV;
+
+	sleep_controller = of_find_node_by_phandle(sleepdata[0]);
+	if (!sleep_controller)
+		return -ENODEV;
+
+	/* There can only be one fsl,mpc83xx-pmc device in the system;
+	 * it is assumed that it is the one that the pmc driver matches.
+	 */
+	if (of_device_is_compatible(sleep_controller, "fsl,mpc83xx-pmc")) {
+		sleep->sccr_mask = sleepdata[1];
+		ret = 0;
+	}
+
+	of_node_put(sleep_controller);
+	return ret;
+}
+EXPORT_SYMBOL(fsl_sleep_init);
+
 static int __init gfar_mdio_of_init(void)
 {
 	struct device_node *np;
@@ -321,6 +348,8 @@ static int __init gfar_of_init(void)
 		of_node_put(phy);
 		of_node_put(mdio);
 
+		fsl_sleep_init(&gfar_data.sleep, np);
+
 		ret =
 		    platform_device_add_data(gfar_dev, &gfar_data,
 					     sizeof(struct
@@ -576,6 +605,8 @@ static int __init fsl_usb_of_init(void)
 		prop = of_get_property(np, "phy_type", NULL);
 		usb_data.phy_mode = determine_usb_phy(prop);
 
+		fsl_sleep_init(&usb_data.sleep, np);
+
 		ret =
 		    platform_device_add_data(usb_dev_mph, &usb_data,
 					     sizeof(struct
@@ -640,6 +671,8 @@ static int __init fsl_usb_of_init(void)
 		prop = of_get_property(np, "phy_type", NULL);
 		usb_data.phy_mode = determine_usb_phy(prop);
 
+		fsl_sleep_init(&usb_data.sleep, np);
+
 		if (usb_dev_dr_host) {
 			usb_dev_dr_host->dev.coherent_dma_mask = 0xffffffffUL;
 			usb_dev_dr_host->dev.dma_mask = &usb_dev_dr_host->
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 74c4a96..fb52d39 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -10,12 +10,22 @@ extern u32 get_baudrate(void);
 extern u32 fsl_get_sys_freq(void);
 
 struct spi_board_info;
+struct fsl_sleep_platform_data;
+struct device_node;
 
 extern int fsl_spi_init(struct spi_board_info *board_infos,
 			unsigned int num_board_infos,
 			void (*activate_cs)(u8 cs, u8 polarity),
 			void (*deactivate_cs)(u8 cs, u8 polarity));
 
+int fsl_sleep_init(struct fsl_sleep_platform_data *sleep,
+                   struct device_node *node);
+
+/* Calls to fsl_sleep_dev and fsl_wake_dev cannot be nested. */
+void fsl_sleep_dev(struct fsl_sleep_platform_data *sleep);
+void fsl_wake_dev(struct fsl_sleep_platform_data *sleep);
+
 extern void fsl_rstcr_restart(char *cmd);
+
 #endif
 #endif
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 05a56e5..e2388cf 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -22,6 +22,7 @@
 #include <linux/device.h>
 #include <linux/bootmem.h>
 #include <linux/spinlock.h>
+#include <linux/fsl_devices.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -724,8 +725,78 @@ unsigned int ipic_get_irq(void)
 	return irq_linear_revmap(primary_ipic->irqhost, irq);
 }
 
+#ifdef CONFIG_PM
+static struct {
+	u32 sicfr;
+	u32 siprr[2];
+	u32 simsr[2];
+	u32 sicnr;
+	u32 smprr[2];
+	u32 semsr;
+	u32 secnr;
+	u32 sermr;
+	u32 sercr;
+} ipic_saved_state;
+
+static int ipic_suspend(struct sys_device *sdev, pm_message_t state)
+{
+	struct ipic *ipic = primary_ipic;
+
+	ipic_saved_state.sicfr = ipic_read(ipic->regs, IPIC_SICFR);
+	ipic_saved_state.siprr[0] = ipic_read(ipic->regs, IPIC_SIPRR_A);
+	ipic_saved_state.siprr[1] = ipic_read(ipic->regs, IPIC_SIPRR_D);
+	ipic_saved_state.simsr[0] = ipic_read(ipic->regs, IPIC_SIMSR_H);
+	ipic_saved_state.simsr[1] = ipic_read(ipic->regs, IPIC_SIMSR_L);
+	ipic_saved_state.sicnr = ipic_read(ipic->regs, IPIC_SICNR);
+	ipic_saved_state.smprr[0] = ipic_read(ipic->regs, IPIC_SMPRR_A);
+	ipic_saved_state.smprr[1] = ipic_read(ipic->regs, IPIC_SMPRR_B);
+	ipic_saved_state.semsr = ipic_read(ipic->regs, IPIC_SEMSR);
+	ipic_saved_state.secnr = ipic_read(ipic->regs, IPIC_SECNR);
+	ipic_saved_state.sermr = ipic_read(ipic->regs, IPIC_SERMR);
+	ipic_saved_state.sercr = ipic_read(ipic->regs, IPIC_SERCR);
+
+	if (fsl_deep_sleep()) {
+		/* In deep sleep, make sure there can be no
+		 * pending interrupts, as this can cause
+		 * problems on 831x.
+		 */
+		ipic_write(ipic->regs, IPIC_SIMSR_H, 0);
+		ipic_write(ipic->regs, IPIC_SIMSR_L, 0);
+		ipic_write(ipic->regs, IPIC_SEMSR, 0);
+		ipic_write(ipic->regs, IPIC_SERMR, 0);
+	}
+
+	return 0;
+}
+
+static int ipic_resume(struct sys_device *sdev)
+{
+	struct ipic *ipic = primary_ipic;
+
+	ipic_write(ipic->regs, IPIC_SICFR, ipic_saved_state.sicfr);
+	ipic_write(ipic->regs, IPIC_SIPRR_A, ipic_saved_state.siprr[0]);
+	ipic_write(ipic->regs, IPIC_SIPRR_D, ipic_saved_state.siprr[1]);
+	ipic_write(ipic->regs, IPIC_SIMSR_H, ipic_saved_state.simsr[0]);
+	ipic_write(ipic->regs, IPIC_SIMSR_L, ipic_saved_state.simsr[1]);
+	ipic_write(ipic->regs, IPIC_SICNR, ipic_saved_state.sicnr);
+	ipic_write(ipic->regs, IPIC_SMPRR_A, ipic_saved_state.smprr[0]);
+	ipic_write(ipic->regs, IPIC_SMPRR_B, ipic_saved_state.smprr[1]);
+	ipic_write(ipic->regs, IPIC_SEMSR, ipic_saved_state.semsr);
+	ipic_write(ipic->regs, IPIC_SECNR, ipic_saved_state.secnr);
+	ipic_write(ipic->regs, IPIC_SERMR, ipic_saved_state.sermr);
+	ipic_write(ipic->regs, IPIC_SERCR, ipic_saved_state.sercr);
+
+	return 0;
+}
+#else
+#define ipic_suspend NULL
+#define ipic_resume NULL
+#endif
+
 static struct sysdev_class ipic_sysclass = {
 	set_kset_name("ipic"),
+	.suspend = ipic_suspend,
+	.resume = ipic_resume,
 };
 
 static struct sys_device device_ipic = {
diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
index 1f68504..68968c1 100644
--- a/include/asm-powerpc/reg.h
+++ b/include/asm-powerpc/reg.h
@@ -149,7 +149,9 @@
 #define   CTRL_RUNLATCH	0x1
 #define SPRN_DABR	0x3F5	/* Data Address Breakpoint Register */
 #define   DABR_TRANSLATION	(1UL << 2)
+#define SPRN_DABR2	0x13D	/* 83xx */
 #define SPRN_DAR	0x013	/* Data Address Register */
+#define SPRN_DBCR	0x136	/* 83xx Data Breakpoint Control Reg */
 #define SPRN_DSISR	0x012	/* Data Storage Interrupt Status Register */
 #define   DSISR_NOHPTE		0x40000000	/* no translation found */
 #define   DSISR_PROTFAULT	0x08000000	/* protection fault */
@@ -255,6 +257,8 @@
 #define HID1_PS		(1<<16)		/* 750FX PLL selection */
 #define SPRN_HID2	0x3F8		/* Hardware Implementation Register 2 */
 #define SPRN_IABR	0x3F2	/* Instruction Address Breakpoint Register */
+#define SPRN_IABR2	0x3FA		/* 83xx */
+#define SPRN_IBCR	0x135		/* 83xx Insn Breakpoint Control Reg */
 #define SPRN_HID4	0x3F4		/* 970 HID4 */
 #define SPRN_HID5	0x3F6		/* 970 HID5 */
 #define SPRN_HID6	0x3F9	/* BE HID 6 */
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 1831b19..5cec939 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -45,10 +45,27 @@
  *
  */
 
+struct fsl_sleep_platform_data {
+	/*
+	 * The bits set in this mask will be cleared in the SCCR
+	 * when put to sleep, and restored on wakeup.
+	 */
+	u32 sccr_mask;
+};
+
+/*
+ * Calls to fsl_sleep_device do not nest -- if you call
+ * sleep twice without an intervening wake, you will not
+ * be able to wake the device again.
+ */
+void fsl_sleep_device(struct fsl_sleep_platform_data *data);
+void fsl_wake_device(struct fsl_sleep_platform_data *data);
+
 struct gianfar_platform_data {
 	/* device specific information */
 	u32	device_flags;
 	/* board specific information */
+	struct fsl_sleep_platform_data sleep;
 	u32	board_flags;
 	u32	bus_id;
 	u32	phy_id;
@@ -104,6 +121,7 @@ struct fsl_usb2_platform_data {
 	enum fsl_usb2_operating_modes	operating_mode;
 	enum fsl_usb2_phy_modes		phy_mode;
 	unsigned int			port_enables;
+	struct fsl_sleep_platform_data sleep;
 };
 
 /* Flags in fsl_usb2_mph_platform_data */
@@ -126,5 +144,11 @@ struct mpc8xx_pcmcia_ops {
 	int(*voltage_set)(int slot, int vcc, int vpp);
 };
 
+/* Returns non-zero if the current suspend operation would
+ * lead to a deep sleep (i.e. power removed from the core,
+ * instead of just the clock).
+ */
+int fsl_deep_sleep(void);
+
 #endif /* _FSL_DEVICE_H_ */
 #endif /* __KERNEL__ */
-- 
1.5.3.7
