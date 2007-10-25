Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 25 Oct 2007 15:27:44 +1000
Subject: [RFC/PATCH] powerpc: Cleanup SMT thread handling
Message-Id: <20071025052756.1CE72DDE9C@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch cleans up the SMT thread handling, removing hard coded
bits here or there and providing a set of helpers to convert between
linux cpu numbers, thread numbers and cores.

This implementation requires the number of threads per core to be a
power of 2 and identical on all cores in the system, but it's an
implementation detail, not an API requirement and so this limitation
can be lifted in the future if anybody ever needs it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I had that taking dust in a pile for some time (I hated all those
hard coded ^ 1 etc...), please comment on the approach.

I haven't scrubbed for all bits of code that may still be doing
old style hard coded assumptions.

  
 arch/powerpc/kernel/setup-common.c   |   78 +++++++++++++++++++++++++++++------
 arch/powerpc/platforms/cell/smp.c    |    3 -
 arch/powerpc/platforms/pseries/smp.c |    3 -
 include/asm-powerpc/cputhreads.h     |   71 +++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+), 15 deletions(-)

Index: linux-work/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup-common.c	2007-10-25 13:48:31.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup-common.c	2007-10-25 13:53:23.000000000 +1000
@@ -33,6 +33,7 @@
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
 #include <linux/debugfs.h>
+#include <linux/percpu.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
@@ -57,6 +58,7 @@
 #include <asm/mmu.h>
 #include <asm/lmb.h>
 #include <asm/xmon.h>
+#include <asm/cputhreads.h>
 
 #include "setup.h"
 
@@ -327,6 +329,31 @@ void __init check_for_initrd(void)
 
 #ifdef CONFIG_SMP
 
+int threads_per_core, threads_shift;
+cpumask_t threads_core_mask;
+
+static void __init cpu_init_thread_core_maps(int tpc)
+{
+	int i;
+
+	threads_per_core = tpc;
+	threads_core_mask = CPU_MASK_NONE;
+
+	/* This implementation only supports power of 2 number of threads
+	 * for simplicity/performances
+	 */
+	threads_shift = ilog2(tpc);
+	BUG_ON(tpc != (1 << threads_shift));
+
+	for (i = 0; i < tpc; i++)
+		cpu_set(i, threads_core_mask);
+
+	printk(KERN_INFO "CPU maps initialized for %d thread%s per core\n",
+	       tpc, tpc > 1 ? "s" : "");
+	printk(KERN_DEBUG " (thread shift is %d)\n", threads_shift);
+}
+
+
 /**
  * setup_cpu_maps - initialize the following cpu maps:
  *                  cpu_possible_map
@@ -350,22 +377,32 @@ void __init smp_setup_cpu_maps(void)
 {
 	struct device_node *dn = NULL;
 	int cpu = 0;
+	int nthreads = 1;
+
+	DBG("smp_setup_cpu_maps()\n");
 
 	while ((dn = of_find_node_by_type(dn, "cpu")) && cpu < NR_CPUS) {
 		const int *intserv;
-		int j, len = sizeof(u32), nthreads = 1;
+		int j, len;
+
+		DBG("  * %s...\n", dn->full_name);
 
 		intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s",
 				&len);
-		if (intserv)
+		if (intserv) {
 			nthreads = len / sizeof(int);
-		else {
+			DBG("    ibm,ppc-interrupt-server#s -> %d threads\n",
+			    nthreads);
+		} else {
+			DBG("    no ibm,ppc-interrupt-server#s -> 1 thread\n");
 			intserv = of_get_property(dn, "reg", NULL);
 			if (!intserv)
 				intserv = &cpu;	/* assume logical == phys */
 		}
 
 		for (j = 0; j < nthreads && cpu < NR_CPUS; j++) {
+			DBG("    thread %d -> cpu %d (hard id %d)\n",
+			    j, cpu, intserv[j]);
 			cpu_set(cpu, cpu_present_map);
 			set_hard_smp_processor_id(cpu, intserv[j]);
 			cpu_set(cpu, cpu_possible_map);
@@ -373,6 +410,12 @@ void __init smp_setup_cpu_maps(void)
 		}
 	}
 
+	/* If no SMT supported, nthreads is forced to 1 */
+	if (!cpu_has_feature(CPU_FTR_SMT)) {
+		DBG("  SMT disabled ! nthreads forced to 1\n");
+		nthreads = 1;
+	}
+
 #ifdef CONFIG_PPC64
 	/*
 	 * On pSeries LPAR, we need to know how many cpus
@@ -395,7 +438,7 @@ void __init smp_setup_cpu_maps(void)
 
 		/* Double maxcpus for processors which have SMT capability */
 		if (cpu_has_feature(CPU_FTR_SMT))
-			maxcpus *= 2;
+			maxcpus *= nthreads;
 
 		if (maxcpus > NR_CPUS) {
 			printk(KERN_WARNING
@@ -412,9 +455,16 @@ void __init smp_setup_cpu_maps(void)
 	out:
 		of_node_put(dn);
 	}
-
 	vdso_data->processorCount = num_present_cpus();
 #endif /* CONFIG_PPC64 */
+
+        /* Initialize CPU <=> thread mapping/
+	 *
+	 * WARNING: We assume that the number of threads is the same for
+	 * every CPU in the system. If that is not the case, then some code
+	 * here will have to be reworked
+	 */
+	cpu_init_thread_core_maps(nthreads);
 }
 
 /*
@@ -424,17 +474,19 @@ void __init smp_setup_cpu_maps(void)
  */
 void __init smp_setup_cpu_sibling_map(void)
 {
-#if defined(CONFIG_PPC64)
-	int cpu;
+#ifdef CONFIG_PPC64
+	int i, cpu, base;
 
-	/*
-	 * Do the sibling map; assume only two threads per processor.
-	 */
 	for_each_possible_cpu(cpu) {
-		cpu_set(cpu, per_cpu(cpu_sibling_map, cpu));
-		if (cpu_has_feature(CPU_FTR_SMT))
-			cpu_set(cpu ^ 0x1, per_cpu(cpu_sibling_map, cpu));
+		DBG("Sibling map for CPU %d:", cpu);
+		base = cpu_first_thread_in_core(cpu);
+		for (i = 0; i < threads_per_core; i++) {
+			cpu_set(base + i, per_cpu(cpu_sibling_map, cpu));
+			DBG(" %d", base + i);
+		}
+		DBG("\n");
 	}
+
 #endif /* CONFIG_PPC64 */
 }
 #endif /* CONFIG_SMP */
Index: linux-work/include/asm-powerpc/cputhreads.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/include/asm-powerpc/cputhreads.h	2007-10-25 13:49:49.000000000 +1000
@@ -0,0 +1,71 @@
+#ifndef _ASM_POWERPC_CPUTHREADS_H
+#define _ASM_POWERPC_CPUTHREADS_H
+
+#include <linux/cpumask.h>
+
+/*
+ * Mapping of threads to cores
+ */
+
+#ifdef CONFIG_SMP
+extern int threads_per_core;
+extern int threads_shift;
+extern cpumask_t threads_core_mask;
+#else
+#define threads_per_core	1
+#define threads_shift		0
+#define threads_core_mask	(CPU_MASK_CPU0)
+#endif
+
+/* cpu_thread_mask_to_cores - Return a cpumask of one per cores
+ *                            hit by the argument
+ *
+ * @threads:	a cpumask of threads
+ *
+ * This function returns a cpumask which will have one "cpu" (or thread)
+ * bit set for each core that has at least one thread set in the argument.
+ *
+ * This can typically be used for things like IPI for tlb invalidations
+ * since those need to be done only once per core/TLB
+ */
+static inline cpumask_t cpu_thread_mask_to_cores(cpumask_t threads)
+{
+	cpumask_t	tmp, res;
+	int		i;
+
+	res = CPU_MASK_NONE;
+	for (i = 0; i < NR_CPUS; i += threads_per_core) {
+		cpus_shift_right(tmp, threads_core_mask, i);
+		if (cpus_intersects(threads, tmp))
+			cpu_set(i, res);
+	}
+	return res;
+}
+
+static inline int cpu_nr_cores(void)
+{
+	return NR_CPUS >> threads_shift;
+}
+
+static inline cpumask_t cpu_online_cores_map(void)
+{
+	return cpu_thread_mask_to_cores(cpu_online_map);
+}
+
+static inline int cpu_thread_to_core(int cpu)
+{
+	return cpu >> threads_shift;
+}
+
+static inline int cpu_thread_in_core(int cpu)
+{
+	return cpu & (threads_per_core - 1);
+}
+
+static inline int cpu_first_thread_in_core(int cpu)
+{
+	return cpu & ~(threads_per_core - 1);
+}
+
+#endif /* _ASM_POWERPC_CPUTHREADS_H */
+
Index: linux-work/arch/powerpc/platforms/cell/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/smp.c	2007-10-25 13:48:31.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/smp.c	2007-10-25 13:50:56.000000000 +1000
@@ -42,6 +42,7 @@
 #include <asm/firmware.h>
 #include <asm/system.h>
 #include <asm/rtas.h>
+#include <asm/cputhreads.h>
 
 #include "interrupt.h"
 
@@ -181,7 +182,7 @@ static int smp_cell_cpu_bootable(unsigne
 	 */
 	if (system_state < SYSTEM_RUNNING &&
 	    cpu_has_feature(CPU_FTR_SMT) &&
-	    !smt_enabled_at_boot && nr % 2 != 0)
+	    !smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
 		return 0;
 
 	return 1;
Index: linux-work/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/smp.c	2007-10-25 13:48:31.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pseries/smp.c	2007-10-25 13:50:40.000000000 +1000
@@ -46,6 +46,7 @@
 #include <asm/pSeries_reconfig.h>
 #include <asm/mpic.h>
 #include <asm/vdso_datapage.h>
+#include <asm/cputhreads.h>
 
 #include "plpar_wrappers.h"
 #include "pseries.h"
@@ -202,7 +203,7 @@ static int smp_pSeries_cpu_bootable(unsi
 	 */
 	if (system_state < SYSTEM_RUNNING &&
 	    cpu_has_feature(CPU_FTR_SMT) &&
-	    !smt_enabled_at_boot && nr % 2 != 0)
+	    !smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
 		return 0;
 
 	return 1;
