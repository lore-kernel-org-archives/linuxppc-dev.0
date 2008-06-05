Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7545DDF39
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:08:21 +1000 (EST)
Date: Thu, 5 Jun 2008 10:08:02 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] powerpc/85xx: add DOZE/NAP support for e500 core
Message-ID: <Pine.LNX.4.64.0806051006420.9352@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: r63238@freescale.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dave Liu <r63238@freescale.com>

The e500 core enter DOZE/NAP power-saving modes when the core go to
cpu_idle routine.

The power management default running mode is DOZE, If the user

echo 1 > /proc/sys/kernel/powersave-nap

the system will change to NAP running mode.

---

I'm post this for review feedback.  The one thing we plan on changing is
the L1 cache flush code that is in idle_e500.S.

- k

 arch/powerpc/kernel/Makefile         |    1 +
 arch/powerpc/kernel/cputable.c       |    2 -
 arch/powerpc/kernel/entry_32.S       |    8 ++--
 arch/powerpc/kernel/head_fsl_booke.S |   35 +++++++++++++++
 arch/powerpc/kernel/idle_6xx.S       |    2 +-
 arch/powerpc/kernel/idle_e500.S      |   79 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/setup_32.c       |    5 ++
 include/asm-powerpc/cputable.h       |    7 ++-
 include/asm-powerpc/machdep.h        |    1 +
 9 files changed, 130 insertions(+), 10 deletions(-)
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
index e44d553..4a187e5 100644
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
index 503f860..b46744f 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -39,6 +39,7 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/cache.h>
 #include "head_booke.h"

 /* As with the other PowerPC ports, it is expected that when code
@@ -1066,6 +1067,40 @@ _GLOBAL(set_context)
 	blr

 /*
+ * Flush all of d-cache, assume the cache size is 32K Bytes
+ * with 8 ways and PLRU replacement policy.
+ * We have to do load/flush in n KB continued space to
+ * guarante all of d-cache evict.
+ * It is enough to set n = cache-size * 13 / 8,
+ */
+_GLOBAL(flush_dcache_L1)
+	sync
+
+	/* Load counter to 0x680 cache lines and
+	 * load cache with datas
+	 */
+	li	r3,0x680
+	mtctr	r3
+	lis	r3,KERNELBASE@h
+1:
+	lwz	r4,0(r3)
+	addi	r3,r3,L1_CACHE_BYTES	/* Go to start of next cache line */
+	bdnz	1b
+	sync
+
+	/* Now flush those cache lines */
+	li	r3,0x680
+	mtctr	r3
+	lis	r3,KERNELBASE@h
+2:
+	dcbf	0,r3
+	addi	r3,r3,L1_CACHE_BYTES	/* Go to start of next cache line */
+	bdnz	2b
+	sync
+	blr
+
+
+/*
  * We put a few things here that have to be page-aligned. This stuff
  * goes at the beginning of the data segment, which is page-aligned.
  */
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
index 0000000..32eb29d
--- /dev/null
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -0,0 +1,79 @@
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
+	mflr	r7
+	bl	flush_dcache_L1
+	mtlr	r7
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
+	rlwinm	r9,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
+	lwz	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
+	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
+	stw	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
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
index 1e79673..a710a53 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -347,10 +347,11 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
 	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
 	    CPU_FTR_UNIFIED_ID_CACHE)
-#define CPU_FTRS_E500	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
+#define CPU_FTRS_E500	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
+	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN)
+#define CPU_FTRS_E500_2	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
+	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | \
 	    CPU_FTR_NODSISRALIGN)
-#define CPU_FTRS_E500_2	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
-	    CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN)
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
-- 
1.5.5.1
