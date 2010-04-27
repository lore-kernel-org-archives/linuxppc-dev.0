Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013432.189850808@samba.org>
Date: Tue, 27 Apr 2010 11:32:38 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 07/15] powerpc: cpumask: Convert xics driver to new cpumask API
References: <20100427013231.510168034@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the new cpumask API and add some comments to clarify how get_irq_server
works.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/pseries/xics.c	2010-04-08 19:46:04.039197077 +1000
+++ linux-cpumask/arch/powerpc/platforms/pseries/xics.c	2010-04-22 13:03:18.825447113 +1000
@@ -163,29 +163,37 @@ static inline void lpar_qirr_info(int n_
 /* Interface to generic irq subsystem */
 
 #ifdef CONFIG_SMP
-static int get_irq_server(unsigned int virq, cpumask_t cpumask,
+/*
+ * For the moment we only implement delivery to all cpus or one cpu.
+ *
+ * If the requested affinity is cpu_all_mask, we set global affinity.
+ * If not we set it to the first cpu in the mask, even if multiple cpus
+ * are set. This is so things like irqbalance (which set core and package
+ * wide affinities) do the right thing.
+ */
+static int get_irq_server(unsigned int virq, const struct cpumask *cpumask,
 			  unsigned int strict_check)
 {
-	int server;
-	/* For the moment only implement delivery to all cpus or one cpu */
-	cpumask_t tmp = CPU_MASK_NONE;
 
 	if (!distribute_irqs)
 		return default_server;
 
-	if (!cpus_equal(cpumask, CPU_MASK_ALL)) {
-		cpus_and(tmp, cpu_online_map, cpumask);
-
-		server = first_cpu(tmp);
+	if (!cpumask_equal(cpumask, cpu_all_mask)) {
+		int server = cpumask_first_and(cpu_online_mask, cpumask);
 
-		if (server < NR_CPUS)
+		if (server < nr_cpu_ids)
 			return get_hard_smp_processor_id(server);
 
 		if (strict_check)
 			return -1;
 	}
 
-	if (cpus_equal(cpu_online_map, cpu_present_map))
+	/*
+	 * Workaround issue with some versions of JS20 firmware that
+	 * deliver interrupts to cpus which haven't been started. This
+	 * happens when using the maxcpus= boot option.
+	 */
+	if (cpumask_equal(cpu_online_mask, cpu_present_mask))
 		return default_distrib_server;
 
 	return default_server;
@@ -207,7 +215,7 @@ static void xics_unmask_irq(unsigned int
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = get_irq_server(virq, *(irq_to_desc(virq)->affinity), 0);
+	server = get_irq_server(virq, irq_to_desc(virq)->affinity, 0);
 
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
 				DEFAULT_PRIORITY);
@@ -398,11 +406,7 @@ static int xics_set_affinity(unsigned in
 		return -1;
 	}
 
-	/*
-	 * For the moment only implement delivery to all cpus or one cpu.
-	 * Get current irq_server for the given irq
-	 */
-	irq_server = get_irq_server(virq, *cpumask, 1);
+	irq_server = get_irq_server(virq, cpumask, 1);
 	if (irq_server == -1) {
 		char cpulist[128];
 		cpumask_scnprintf(cpulist, sizeof(cpulist), cpumask);
@@ -611,7 +615,7 @@ int __init smp_xics_probe(void)
 {
 	xics_request_ipi();
 
-	return cpus_weight(cpu_possible_map);
+	return cpumask_weight(cpu_possible_mask);
 }
 
 #endif /* CONFIG_SMP */
