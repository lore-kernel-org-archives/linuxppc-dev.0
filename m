Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F15B4DDF0F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 00:01:44 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m5HE1dsk002477
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 09:01:40 -0500
Date: Tue, 17 Jun 2008 09:01:39 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/booke: Add support for new e500mc core
Message-ID: <Pine.LNX.4.64.0806170901140.15775@blarg.am.freescale.net>
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

The new e500mc core from Freescale is based on the e500v2 but with the
following changes:

* Supports only the Enhanced Debug Architecture (DSRR0/1, etc)
* Floating Point
* No SPE
* Supports lwsync
* Doorbell Exceptions
* Hypervisor

---
* Dropped the SMP changes to Kconfig
* Changed plaform to ppce500mc

- k

 arch/powerpc/kernel/cputable.c         |   15 +++++++++++++++
 arch/powerpc/kernel/head_booke.h       |    6 +++++-
 arch/powerpc/kernel/head_fsl_booke.S   |   10 ++++++++--
 arch/powerpc/platforms/Kconfig.cputype |    7 ++++++-
 include/asm-powerpc/cache.h            |    3 +++
 include/asm-powerpc/cputable.h         |    6 ++++--
 include/asm-powerpc/synch.h            |    2 +-
 7 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e44d553..aa421f5 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1522,6 +1522,21 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_e500,
 		.platform		= "ppc8548",
 	},
+	{	/* e500mc */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x80230000,
+		.cpu_name		= "e500mc",
+		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
+		.cpu_features		= CPU_FTRS_E500MC,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.icache_bsize		= 64,
+		.dcache_bsize		= 64,
+		.num_pmcs		= 4,
+		.oprofile_cpu_type	= "ppc/e500", /* xxx - galak, e500mc? */
+		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
+		.machine_check		= machine_check_e500,
+		.platform		= "ppce500mc",
+	},
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 9501c58..505494f 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -68,9 +68,13 @@
 #define MCHECK_STACK_BASE	mcheckirq_ctx
 #define CRIT_STACK_BASE		critirq_ctx

-/* only on e200 for now */
+/* only on e500mc/e200 */
 #define DEBUG_STACK_BASE	dbgirq_ctx
+#ifdef CONFIG_PPC_E500MC
+#define DEBUG_SPRG		SPRN_SPRG9
+#else
 #define DEBUG_SPRG		SPRN_SPRG6W
+#endif

 #define EXC_LVL_FRAME_OVERHEAD	(THREAD_SIZE - INT_FRAME_SIZE - EXC_LVL_SIZE)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 503f860..7c2b653 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -304,7 +304,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	SET_IVOR(13, DataTLBError);
 	SET_IVOR(14, InstructionTLBError);
 	SET_IVOR(15, DebugDebug);
-#if defined(CONFIG_E500)
+#if defined(CONFIG_E500) && !defined(CONFIG_PPC_E500MC)
 	SET_IVOR(15, DebugCrit);
 #endif
 	SET_IVOR(32, SPEUnavailable);
@@ -313,6 +313,9 @@ skpinv:	addi	r6,r6,1				/* Increment */
 #ifndef CONFIG_E200
 	SET_IVOR(35, PerformanceMonitor);
 #endif
+#ifdef CONFIG_PPC_E500MC
+	SET_IVOR(36, Doorbell);
+#endif

 	/* Establish the interrupt vector base */
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
@@ -750,10 +753,13 @@ interrupt_base:
 	/* Performance Monitor */
 	EXCEPTION(0x2060, PerformanceMonitor, performance_monitor_exception, EXC_XFER_STD)

+#ifdef CONFIG_PPC_E500MC
+	EXCEPTION(0x2070, Doorbell, unknown_exception, EXC_XFER_EE)
+#endif

 	/* Debug Interrupt */
 	DEBUG_DEBUG_EXCEPTION
-#if defined(CONFIG_E500)
+#if defined(CONFIG_E500) && !defined(CONFIG_PPC_E500MC)
 	DEBUG_CRIT_EXCEPTION
 #endif

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f7efaa9..1a1ccfb 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -95,6 +95,11 @@ config E500
 	select FSL_EMB_PERFMON
 	bool

+config PPC_E500MC
+	bool "e500mc Support"
+	select PPC_FPU
+	depends on E500
+
 config PPC_FPU
 	bool
 	default y if PPC64
@@ -157,7 +162,7 @@ config ALTIVEC

 config SPE
 	bool "SPE Support"
-	depends on E200 || E500
+	depends on E200 || (E500 && !PPC_E500MC)
 	default y
 	---help---
 	  This option enables kernel support for the Signal Processing
diff --git a/include/asm-powerpc/cache.h b/include/asm-powerpc/cache.h
index 5350704..81de6eb 100644
--- a/include/asm-powerpc/cache.h
+++ b/include/asm-powerpc/cache.h
@@ -8,6 +8,9 @@
 #if defined(CONFIG_8xx) || defined(CONFIG_403GCX)
 #define L1_CACHE_SHIFT		4
 #define MAX_COPY_PREFETCH	1
+#elif defined(CONFIG_PPC_E500MC)
+#define L1_CACHE_SHIFT		6
+#define MAX_COPY_PREFETCH	4
 #elif defined(CONFIG_PPC32)
 #define L1_CACHE_SHIFT		5
 #define MAX_COPY_PREFETCH	4
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 1e79673..a3dce17 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -351,6 +351,8 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 	    CPU_FTR_NODSISRALIGN)
 #define CPU_FTRS_E500_2	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
 	    CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN)
+#define CPU_FTRS_E500MC	(CPU_FTR_USE_TB | CPU_FTR_BIG_PHYS | \
+	    CPU_FTR_NODSISRALIGN)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)

 /* 64-bit CPUs */
@@ -421,7 +423,7 @@ enum {
 	    CPU_FTRS_E200 |
 #endif
 #ifdef CONFIG_E500
-	    CPU_FTRS_E500 | CPU_FTRS_E500_2 |
+	    CPU_FTRS_E500 | CPU_FTRS_E500_2 | CPU_FTRS_E500MC |
 #endif
 	    0,
 };
@@ -461,7 +463,7 @@ enum {
 	    CPU_FTRS_E200 &
 #endif
 #ifdef CONFIG_E500
-	    CPU_FTRS_E500 & CPU_FTRS_E500_2 &
+	    CPU_FTRS_E500 & CPU_FTRS_E500_2 & CPU_FTRS_E500MC &
 #endif
 	    CPU_FTRS_POSSIBLE,
 };
diff --git a/include/asm-powerpc/synch.h b/include/asm-powerpc/synch.h
index 2cda3c3..42a1ef5 100644
--- a/include/asm-powerpc/synch.h
+++ b/include/asm-powerpc/synch.h
@@ -4,7 +4,7 @@

 #include <linux/stringify.h>

-#ifdef __powerpc64__
+#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
 #define __SUBARCH_HAS_LWSYNC
 #endif

-- 
1.5.5.1
