Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 90946DDFBC
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 15:33:50 +1000 (EST)
Date: Fri, 18 Apr 2008 15:33:49 +1000
To: Paul Mackerras <paulus@samba.org>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2.6.26?] Raise the upper limit of NR_CPUS.
Message-ID: <20080418053349.GE20457@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
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
I know it's late, but can this be considered for 2.6.26?

 arch/powerpc/kernel/paca.c             |   33 ++++++++++------------------
 arch/powerpc/kernel/prom_init.c        |   36 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |    4 +-
 include/asm-powerpc/paca.h             |   19 ++++++++++++++++
 4 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index ac163bd..29186eb 100644
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
@@ -98,24 +107,6 @@ struct paca_struct paca[] = {
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
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 6d6df1e..cf2a2db 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -37,6 +37,9 @@
 #include <asm/smp.h>
 #include <asm/system.h>
 #include <asm/mmu.h>
+#ifdef CONFIG_PPC64
+#include <asm/paca.h>
+#endif
 #include <asm/pgtable.h>
 #include <asm/pci.h>
 #include <asm/iommu.h>
@@ -49,6 +52,10 @@
 extern const struct linux_logo logo_linux_clut224;
 #endif
 
+/* This symbol is provided by the linker - let it fill in the paca
+ * field correctly */
+extern unsigned long __toc_start;
+
 /*
  * Properties whose value is longer than this get excluded from our
  * copy of the device tree. This value does need to be big enough to
@@ -2332,6 +2339,32 @@ static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
 }
 
 /*
+ * The first few (NR_STATIC_PACAS) paca entires are initiialised
+ * statically. populate the rest.
+ */
+static void __init prom_initialise_pacas(void)
+{
+#ifdef CONFIG_PPC64
+	int cpu;
+	unsigned long kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL;
+
+	/* Can't use for_each_*_cpu, as they aren't functional yet */
+	for (cpu = NR_STATIC_PACAS; cpu < NR_CPUS; cpu++) {
+		struct paca_struct *new_paca = &RELOC(paca[cpu]);
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
+#endif /* CONFIG_PPC64 */
+}
+
+/*
  * We enter here early on, when the Open Firmware prom is still
  * handling exceptions and the MMU hash table for us.
  */
@@ -2432,6 +2465,9 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 		prom_initialize_tce_table();
 #endif
 
+	/* We statically initialised /some/ of the paca's, lets do the rest. */
+	prom_initialise_pacas();
+
 	/*
 	 * On non-powermacs, try to instantiate RTAS and puts all CPUs
 	 * in spin-loops. PowerMacs don't have a working RTAS and use
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
index eb61b9c..511ebc9 100644
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
+#if   NR_CPUS >= 32
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
-- 
1.5.5



Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
