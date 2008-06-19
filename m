Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04103DE39D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 01:20:13 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m5JFK8cN008515
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 10:20:08 -0500
Date: Thu, 19 Jun 2008 10:20:08 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: add DOZE/NAP support for e500 core
Message-ID: <Pine.LNX.4.64.0806191018590.26128@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The e500 core enter DOZE/NAP power-saving modes when the core go to
cpu_idle routine.

The power management default running mode is DOZE, If the user

echo 1 > /proc/sys/kernel/powersave-nap

the system will change to NAP running mode.

Signed-off-by: Dave Liu <daveliu@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/Makefile         |    1 +
 arch/powerpc/kernel/cputable.c       |    3 -
 arch/powerpc/kernel/entry_32.S       |    8 ++--
 arch/powerpc/kernel/head_fsl_booke.S |   47 +++++++++++++++++++
 arch/powerpc/kernel/idle_6xx.S       |    2 +-
 arch/powerpc/kernel/idle_e500.S      |   84 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/setup_32.c       |    5 ++
 include/asm-powerpc/cputable.h       |   11 ++--
 include/asm-powerpc/machdep.h        |    1 +
 include/asm-powerpc/reg.h            |    2 +-
 include/asm-powerpc/reg_booke.h      |    2 +
 11 files changed, 152 insertions(+), 14 deletions(-)
 create mode 100644 arch/powerpc/kernel/idle_e500.S

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2346d27..0e8f928 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_IBMVIO)		+= vio.o
 obj-$(CONFIG_IBMEBUS)           += ibmebus.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
+obj-$(CONFIG_E500)		+= idle_e500.o
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o \
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index aa421f5..c5397c1 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1491,7 +1491,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80200000,
 		.cpu_name		= "e500",
-		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
 		.cpu_features		= CPU_FTRS_E500,
 		.cpu_user_features	= COMMON_USER_BOOKE |
 			PPC_FEATURE_HAS_SPE_COMP |
@@ -1508,7 +1507,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80210000,
 		.cpu_name		= "e500v2",
-		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
 		.cpu_features		= CPU_FTRS_E500_2,
 		.cpu_user_features	= COMMON_USER_BOOKE |
 			PPC_FEATURE_HAS_SPE_COMP |
@@ -1526,7 +1524,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80230000,
 		.cpu_name		= "e500mc",
-		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
 		.cpu_features		= CPU_FTRS_E500MC,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 64,
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index fe21674..ab2d62f 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -176,14 +176,14 @@ transfer_to_handler:
 	cmplw	r1,r9			/* if r1 <= ksp_limit */
 	ble-	stack_ovf		/* then the kernel stack overflowed */
 5:
-#ifdef CONFIG_6xx
+#if defined(CONFIG_6xx) || defined(CONFIG_E500)
 	rlwinm	r9,r1,0,0,31-THREAD_SHIFT
 	tophys(r9,r9)			/* check local flags */
 	lwz	r12,TI_LOCAL_FLAGS(r9)
 	mtcrf	0x01,r12
 	bt-	31-TLF_NAPPING,4f
 	bt-	31-TLF_SLEEPING,7f
-#endif /* CONFIG_6xx */
+#endif /* CONFIG_6xx || CONFIG_E500 */
 	.globl transfer_to_handler_cont
 transfer_to_handler_cont:
 3:
@@ -196,10 +196,10 @@ transfer_to_handler_cont:
 	SYNC
 	RFI				/* jump to handler, enable MMU */

-#ifdef CONFIG_6xx
+#if defined (CONFIG_6xx) || defined(CONFIG_E500)
 4:	rlwinm	r12,r12,0,~_TLF_NAPPING
 	stw	r12,TI_LOCAL_FLAGS(r9)
-	b	power_save_6xx_restore
+	b	power_save_ppc32_restore

 7:	rlwinm	r12,r12,0,~_TLF_SLEEPING
 	stw	r12,TI_LOCAL_FLAGS(r9)
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 7c2b653..c426850 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -39,6 +39,7 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/cache.h>
 #include "head_booke.h"

 /* As with the other PowerPC ports, it is expected that when code
@@ -1071,6 +1072,52 @@ _GLOBAL(set_context)
 	isync			/* Force context change */
 	blr

+_GLOBAL(flush_dcache_L1)
+	mfspr	r3,SPRN_L1CFG0
+
+	rlwinm	r5,r3,9,3	/* Extract cache block size */
+	twlgti	r5,1		/* Only 32 and 64 byte cache blocks
+				 * are currently defined.
+				 */
+	li	r4,32
+	subfic	r6,r5,2		/* r6 = log2(1KiB / cache block size) -
+				 *      log2(number of ways)
+				 */
+	slw	r5,r4,r5	/* r5 = cache block size */
+
+	rlwinm	r7,r3,0,0xff	/* Extract number of KiB in the cache */
+	mulli	r7,r7,13	/* An 8-way cache will require 13
+				 * loads per set.
+				 */
+	slw	r7,r7,r6
+
+	/* save off HID0 and set DCFA */
+	mfspr	r8,SPRN_HID0
+	ori	r9,r8,HID0_DCFA@l
+	mtspr	SPRN_HID0,r9
+	isync
+
+	lis	r4,KERNELBASE@h
+	mtctr	r7
+
+1:	lwz	r3,0(r4)	/* Load... */
+	add	r4,r4,r5
+	bdnz	1b
+
+	msync
+	lis	r4,KERNELBASE@h
+	mtctr	r7
+
+1:	dcbf	0,r4		/* ...and flush. */
+	add	r4,r4,r5
+	bdnz	1b
+
+	/* restore HID0 */
+	mtspr	SPRN_HID0,r8
+	isync
+
+	blr
+
 /*
  * We put a few things here that have to be page-aligned. This stuff
  * goes at the beginning of the data segment, which is page-aligned.
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 01bcd52..019b02d 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -153,7 +153,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
  * address of current.  R11 points to the exception frame (physical
  * address).  We have to preserve r10.
  */
-_GLOBAL(power_save_6xx_restore)
+_GLOBAL(power_save_ppc32_restore)
 	lwz	r9,_LINK(r11)		/* interrupted in ppc6xx_idle: */
 	stw	r9,_NIP(r11)		/* make it do a blr */

diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
new file mode 100644
index 0000000..267adec
--- /dev/null
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2008 Freescale Semiconductor, Inc. All rights reserved.
+ * Dave Liu <daveliu@freescale.com>
+ * copy from idle_6xx.S and modify for e500 based processor,
+ * implement the power_save function in idle.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/threads.h>
+#include <asm/reg.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+
+	.text
+
+_GLOBAL(e500_idle)
+	rlwinm	r3,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
+	lwz	r4,TI_LOCAL_FLAGS(r3)	/* set napping bit */
+	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
+	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
+
+	/* Check if we can nap or doze, put HID0 mask in r3 */
+	lis	r3,0
+BEGIN_FTR_SECTION
+	lis	r3,HID0_DOZE@h
+END_FTR_SECTION_IFSET(CPU_FTR_CAN_DOZE)
+
+BEGIN_FTR_SECTION
+	/* Now check if user enabled NAP mode */
+	lis	r4,powersave_nap@ha
+	lwz	r4,powersave_nap@l(r4)
+	cmpwi	0,r4,0
+	beq	1f
+	stwu	r1,-16(r1)
+	mflr	r0
+	stw	r0,20(r1)
+	bl	flush_dcache_L1
+	lwz	r0,20(r1)
+	addi	r1,r1,16
+	mtlr	r0
+	lis	r3,HID0_NAP@h
+END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
+1:
+	/* Go to NAP or DOZE now */
+	mfspr	r4,SPRN_HID0
+	rlwinm	r4,r4,0,~(HID0_DOZE|HID0_NAP|HID0_SLEEP)
+	or	r4,r4,r3
+	isync
+	mtspr	SPRN_HID0,r4
+	isync
+
+	mfmsr	r7
+	oris	r7,r7,MSR_WE@h
+	ori	r7,r7,MSR_EE
+	msync
+	mtmsr	r7
+	isync
+2:	b	2b
+
+/*
+ * Return from NAP/DOZE mode, restore some CPU specific registers,
+ * r2 containing physical address of current.
+ * r11 points to the exception frame (physical address).
+ * We have to preserve r10.
+ */
+_GLOBAL(power_save_ppc32_restore)
+	lwz	r9,_LINK(r11)		/* interrupted in e500_idle */
+	stw	r9,_NIP(r11)		/* make it do a blr */
+
+#ifdef CONFIG_SMP
+	mfspr	r12,SPRN_SPRG3
+	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
+	slwi	r11,r11,2
+#else
+	li	r11,0
+#endif
+	b	transfer_to_handler_cont
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index bef0be3..9e83add 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -127,6 +127,11 @@ void __init machine_init(unsigned long dt_ptr, unsigned long phys)
 		ppc_md.power_save = ppc6xx_idle;
 #endif

+#ifdef CONFIG_E500
+	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
+	    cpu_has_feature(CPU_FTR_CAN_NAP))
+		ppc_md.power_save = e500_idle;
+#endif
 	if (ppc_md.progress)
 		ppc_md.progress("id mach(): done", 0x200);
 }
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index a3dce17..18feb63 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -347,12 +347,13 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
 	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
 	    CPU_FTR_UNIFIED_ID_CACHE)
-#define CPU_FTRS_E500	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
-	    CPU_FTR_NODSISRALIGN)
-#define CPU_FTRS_E500_2	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
-	    CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN)
-#define CPU_FTRS_E500MC	(CPU_FTR_USE_TB | CPU_FTR_BIG_PHYS | \
+#define CPU_FTRS_E500	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
+	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN)
+#define CPU_FTRS_E500_2	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
+	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | \
 	    CPU_FTR_NODSISRALIGN)
+#define CPU_FTRS_E500MC	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
+	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)

 /* 64-bit CPUs */
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 54ed64d..9899226 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -262,6 +262,7 @@ struct machdep_calls {
 #endif
 };

+extern void e500_idle(void);
 extern void power4_idle(void);
 extern void power4_cpu_offline_powersave(void);
 extern void ppc6xx_idle(void);
diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
index edc0cfd..079999b 100644
--- a/include/asm-powerpc/reg.h
+++ b/include/asm-powerpc/reg.h
@@ -240,7 +240,7 @@
 #define HID0_DAPUEN	(1<<8)		/* Debug APU enable */
 #define HID0_SGE	(1<<7)		/* Store Gathering Enable */
 #define HID0_SIED	(1<<7)		/* Serial Instr. Execution [Disable] */
-#define HID0_DFCA	(1<<6)		/* Data Cache Flush Assist */
+#define HID0_DCFA	(1<<6)		/* Data Cache Flush Assist */
 #define HID0_LRSTK	(1<<4)		/* Link register stack - 745x */
 #define HID0_BTIC	(1<<5)		/* Branch Target Instr Cache Enable */
 #define HID0_ABE	(1<<3)		/* Address Broadcast Enable */
diff --git a/include/asm-powerpc/reg_booke.h b/include/asm-powerpc/reg_booke.h
index a1ab2ba..bf638e7 100644
--- a/include/asm-powerpc/reg_booke.h
+++ b/include/asm-powerpc/reg_booke.h
@@ -61,6 +61,8 @@
 #define SPRN_SPEFSCR	0x200	/* SPE & Embedded FP Status & Control */
 #define SPRN_BBEAR	0x201	/* Branch Buffer Entry Address Register */
 #define SPRN_BBTAR	0x202	/* Branch Buffer Target Address Register */
+#define SPRN_L1CFG0	0x203	/* L1 Cache Configure Register 0 */
+#define SPRN_L1CFG1	0x203	/* L1 Cache Configure Register 1 */
 #define SPRN_ATB	0x20E	/* Alternate Time Base */
 #define SPRN_ATBL	0x20E	/* Alternate Time Base Lower */
 #define SPRN_ATBU	0x20F	/* Alternate Time Base Upper */
-- 
1.5.5.1
