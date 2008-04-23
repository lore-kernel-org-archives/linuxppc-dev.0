Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 63EA2DDF5A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 14:06:15 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <d54206d25b690c9160401f65a583f586004dcd5d.1208923391.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 1/3 v3] Raise the upper limit of NR_CPUS.
Date: Wed, 23 Apr 2008 14:06:14 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As the pacas are statically initialised increasing NR_CPUS beyond 128,
means that any additional pacas will be empty  ... which is bad.

This patch adds the required functionality to fill in any excess pacas
at runtime.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
Changes since v1:
 - Addressed thinko pointed out by sfr.
 - Addeed nicely worded comment about paca->kernel_toc from Segher
Changes since v2:
 - none

Paul, please consider before -rc1

 arch/powerpc/kernel/paca.c             |   61 +++++++++++++++++++++-----------
 arch/powerpc/kernel/setup_64.c         |    3 ++
 arch/powerpc/platforms/Kconfig.cputype |    4 +-
 include/asm-powerpc/paca.h             |   20 ++++++++++
 4 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index ac163bd..4c7db2e 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -18,6 +18,15 @@
 #include <asm/paca.h>
 #include <asm/mmu.h>
 
+/*
+ * In order to handle "strange" values of NR_CPUS, Make sure we use
+ * max(NR_CPUS, NR_STATIC_PACAS) for array sizes below
+ */
+#if NR_CPUS > NR_STATIC_PACAS
+#define MAX_CPUS	NR_CPUS
+#else
+#define MAX_CPUS	NR_STATIC_PACAS
+#endif
 
 /* This symbol is provided by the linker - let it fill in the paca
  * field correctly */
@@ -33,7 +42,7 @@ extern unsigned long __toc_start;
  * will suffice to ensure that it doesn't cross a page boundary.
  */
 struct lppaca lppaca[] = {
-	[0 ... (NR_CPUS-1)] = {
+	[0 ... (MAX_CPUS-1)] = {
 		.desc = 0xd397d781,	/* "LpPa" */
 		.size = sizeof(struct lppaca),
 		.dyn_proc_status = 2,
@@ -50,7 +59,7 @@ struct lppaca lppaca[] = {
  * initially, hence will all be invaild until we actually write them.
  */
 struct slb_shadow slb_shadow[] __cacheline_aligned = {
-	[0 ... (NR_CPUS-1)] = {
+	[0 ... (MAX_CPUS-1)] = {
 		.persistent = SLB_NUM_BOLTED,
 		.buffer_length = sizeof(struct slb_shadow),
 	},
@@ -76,7 +85,7 @@ struct slb_shadow slb_shadow[] __cacheline_aligned = {
 	.__current = &init_task,					    \
 }
 
-struct paca_struct paca[] = {
+struct paca_struct paca[MAX_CPUS] = {
 	PACA_INIT(0),
 #if NR_CPUS > 1
 	PACA_INIT(  1), PACA_INIT(  2), PACA_INIT(  3),
@@ -98,27 +107,37 @@ struct paca_struct paca[] = {
 	PACA_INIT( 52), PACA_INIT( 53), PACA_INIT( 54), PACA_INIT( 55),
 	PACA_INIT( 56), PACA_INIT( 57), PACA_INIT( 58), PACA_INIT( 59),
 	PACA_INIT( 60), PACA_INIT( 61), PACA_INIT( 62), PACA_INIT( 63),
-#if NR_CPUS > 64
-	PACA_INIT( 64), PACA_INIT( 65), PACA_INIT( 66), PACA_INIT( 67),
-	PACA_INIT( 68), PACA_INIT( 69), PACA_INIT( 70), PACA_INIT( 71),
-	PACA_INIT( 72), PACA_INIT( 73), PACA_INIT( 74), PACA_INIT( 75),
-	PACA_INIT( 76), PACA_INIT( 77), PACA_INIT( 78), PACA_INIT( 79),
-	PACA_INIT( 80), PACA_INIT( 81), PACA_INIT( 82), PACA_INIT( 83),
-	PACA_INIT( 84), PACA_INIT( 85), PACA_INIT( 86), PACA_INIT( 87),
-	PACA_INIT( 88), PACA_INIT( 89), PACA_INIT( 90), PACA_INIT( 91),
-	PACA_INIT( 92), PACA_INIT( 93), PACA_INIT( 94), PACA_INIT( 95),
-	PACA_INIT( 96), PACA_INIT( 97), PACA_INIT( 98), PACA_INIT( 99),
-	PACA_INIT(100), PACA_INIT(101), PACA_INIT(102), PACA_INIT(103),
-	PACA_INIT(104), PACA_INIT(105), PACA_INIT(106), PACA_INIT(107),
-	PACA_INIT(108), PACA_INIT(109), PACA_INIT(110), PACA_INIT(111),
-	PACA_INIT(112), PACA_INIT(113), PACA_INIT(114), PACA_INIT(115),
-	PACA_INIT(116), PACA_INIT(117), PACA_INIT(118), PACA_INIT(119),
-	PACA_INIT(120), PACA_INIT(121), PACA_INIT(122), PACA_INIT(123),
-	PACA_INIT(124), PACA_INIT(125), PACA_INIT(126), PACA_INIT(127),
-#endif
 #endif
 #endif
 #endif
 #endif
 };
 EXPORT_SYMBOL(paca);
+
+/*
+ * The first few (NR_STATIC_PACAS) paca entires are initiialised
+ * statically. populate the rest.
+ */
+void __init initialise_pacas(void)
+{
+	int cpu;
+
+	/* The TOC register (GPR2) points 32kB into the TOC, so that 64kB
+	 * of the TOC can be addressed using a single machine instruction.
+	 */
+	unsigned long kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL;
+
+	/* Can't use for_each_*_cpu, as they aren't functional yet */
+	for (cpu = NR_STATIC_PACAS; cpu < NR_CPUS; cpu++) {
+		struct paca_struct *new_paca = &paca[cpu];
+
+		new_paca->lppaca_ptr = &lppaca[cpu];
+		new_paca->lock_token = 0x8000;
+		new_paca->paca_index = cpu;
+		new_paca->kernel_toc = kernel_toc;
+		new_paca->hw_cpu_id = 0xffff;
+		new_paca->slb_shadow_ptr = &slb_shadow[cpu];
+		new_paca->__current = &init_task;
+
+	}
+}
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 31ada9f..5e382ac 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -170,6 +170,9 @@ void __init setup_paca(int cpu)
 
 void __init early_setup(unsigned long dt_ptr)
 {
+	/* Fill in any unititialised pacas */
+	initialise_pacas();
+
 	/* Identify CPU type */
 	identify_cpu(0, mfspr(SPRN_PVR));
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 5fc7fac..f7efaa9 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -220,8 +220,8 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-128)"
-	range 2 128
+	int "Maximum number of CPUs (2-1024)"
+	range 2 1024
 	depends on SMP
 	default "32" if PPC64
 	default "4"
diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
index eb61b9c..2a05cc0 100644
--- a/include/asm-powerpc/paca.h
+++ b/include/asm-powerpc/paca.h
@@ -16,10 +16,29 @@
 #define _ASM_POWERPC_PACA_H
 #ifdef __KERNEL__
 
+#include <linux/threads.h>
+
 #include	<asm/types.h>
 #include	<asm/lppaca.h>
 #include	<asm/mmu.h>
 
+/*
+ * iSeries needs the paca to be statically allocated and initialised.
+ * We will allocated this many, based on NR_CPUS.
+ */
+#if   NR_CPUS > 32
+#define NR_STATIC_PACAS	64
+#elif NR_CPUS > 8
+#define NR_STATIC_PACAS	32
+#elif NR_CPUS > 4
+#define NR_STATIC_PACAS	8
+#elif NR_CPUS > 1
+#define NR_STATIC_PACAS	4
+#else
+#define NR_STATIC_PACAS	1
+#endif
+
+
 register struct paca_struct *local_paca asm("r13");
 
 #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
@@ -108,6 +127,7 @@ struct paca_struct {
 };
 
 extern struct paca_struct paca[];
+extern void initialise_pacas(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_PACA_H */
-- 
1.5.5.1
