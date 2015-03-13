Return-Path: <Yuantian.Tang@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3A5E1A051E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 16:15:17 +1100 (AEDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0112.outbound.protection.outlook.com [65.55.169.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BDA821400B7
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2015 16:15:16 +1100 (AEDT)
From: <Yuantian.Tang@freescale.com>
To: <rjw@rjwysocki.net>
Subject: [PATCH 1/2 v5] cpufreq: qoriq: Make the driver usable on all QorIQ
 platforms
Date: Fri, 13 Mar 2015 12:39:01 +0800
Message-ID: <1426221542-41043-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, viresh.kumar@linaro.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

Freescale introduced new ARM core-based SoCs which support dynamic
frequency switch feature. DFS on new SoCs are compatible with current
PowerPC CoreNet platforms. In order to support those new platforms,
this driver needs to be updated. The main changes include:

1. Changed the names of functions in driver.
2. Added two new functions get_cpu_physical_id() and get_bus_freq().
3. Used a new way to get the CPU mask which share clock wire.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
v5:
	- rebased to 4.0.-rc3
	- put Kconfig and Makefile entry to the following rename patch
v4:
	- resolve "unmet direct dependencies" warning
v3:
	- put the menu entries into Kconfig
v2:
	- split the name change into a separete patch
	- use policy->driver_data instead of per_cpu variable

 drivers/cpufreq/ppc-corenet-cpufreq.c | 161 +++++++++++++++++++++-------------
 1 file changed, 99 insertions(+), 62 deletions(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index 7cb4b76..9fd51c8 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -1,7 +1,7 @@
 /*
  * Copyright 2013 Freescale Semiconductor, Inc.
  *
- * CPU Frequency Scaling driver for Freescale PowerPC corenet SoCs.
+ * CPU Frequency Scaling driver for Freescale QorIQ SoCs.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -20,12 +20,11 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
-#include <sysdev/fsl_soc.h>
 
 #include <asm/smp.h>	/* for get_hard_smp_processor_id() in UP configs */
 
 /**
- * struct cpu_data - per CPU data struct
+ * struct cpu_data
  * @parent: the parent node of cpu clock
  * @table: frequency table
  */
@@ -69,17 +68,78 @@ static const struct soc_data sdata[] = {
 static u32 min_cpufreq;
 static const u32 *fmask;
 
-static DEFINE_PER_CPU(struct cpu_data *, cpu_data);
+#if defined(CONFIG_ARM)
+static int get_cpu_physical_id(int cpu)
+{
+	return topology_core_id(cpu);
+}
+#else
+static int get_cpu_physical_id(int cpu)
+{
+	return get_hard_smp_processor_id(cpu);
+}
+#endif
+
+static u32 get_bus_freq(void)
+{
+	struct device_node *soc;
+	u32 sysfreq;
+
+	soc = of_find_node_by_type(NULL, "soc");
+	if (!soc)
+		return 0;
+
+	if (of_property_read_u32(soc, "bus-frequency", &sysfreq))
+		sysfreq = 0;
+
+	of_node_put(soc);
 
-/* cpumask in a cluster */
-static DEFINE_PER_CPU(cpumask_var_t, cpu_mask);
+	return sysfreq;
+}
 
-#ifndef CONFIG_SMP
-static inline const struct cpumask *cpu_core_mask(int cpu)
+static struct device_node *cpu_to_clk_node(int cpu)
 {
-	return cpumask_of(0);
+	struct device_node *np, *clk_np;
+
+	if (!cpu_present(cpu))
+		return NULL;
+
+	np = of_get_cpu_node(cpu, NULL);
+	if (!np)
+		return NULL;
+
+	clk_np = of_parse_phandle(np, "clocks", 0);
+	if (!clk_np)
+		return NULL;
+
+	of_node_put(np);
+
+	return clk_np;
+}
+
+/* traverse cpu nodes to get cpu mask of sharing clock wire */
+static void set_affected_cpus(struct cpufreq_policy *policy)
+{
+	struct device_node *np, *clk_np;
+	struct cpumask *dstp = policy->cpus;
+	int i;
+
+	np = cpu_to_clk_node(policy->cpu);
+	if (!np)
+		return;
+
+	for_each_present_cpu(i) {
+		clk_np = cpu_to_clk_node(i);
+		if (!clk_np)
+			continue;
+
+		if (clk_np == np)
+			cpumask_set_cpu(i, dstp);
+
+		of_node_put(clk_np);
+	}
+	of_node_put(np);
 }
-#endif
 
 /* reduce the duplicated frequencies in frequency table */
 static void freq_table_redup(struct cpufreq_frequency_table *freq_table,
@@ -107,6 +167,7 @@ static void freq_table_sort(struct cpufreq_frequency_table *freq_table,
 	int i, j, ind;
 	unsigned int freq, max_freq;
 	struct cpufreq_frequency_table table;
+
 	for (i = 0; i < count - 1; i++) {
 		max_freq = freq_table[i].frequency;
 		ind = i;
@@ -131,7 +192,7 @@ static void freq_table_sort(struct cpufreq_frequency_table *freq_table,
 	}
 }
 
-static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
+static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct device_node *np;
 	int i, count, ret;
@@ -147,10 +208,8 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		pr_err("%s: no memory\n", __func__);
+	if (!data)
 		goto err_np;
-	}
 
 	policy->clk = of_clk_get(np, 0);
 	if (IS_ERR(policy->clk)) {
@@ -172,7 +231,7 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	if (fmask)
-		mask = fmask[get_hard_smp_processor_id(cpu)];
+		mask = fmask[get_cpu_physical_id(cpu)];
 	else
 		mask = 0x0;
 
@@ -203,13 +262,12 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	data->table = table;
 
 	/* update ->cpus if we have cluster, no harm if not */
-	cpumask_copy(policy->cpus, per_cpu(cpu_mask, cpu));
-	for_each_cpu(i, per_cpu(cpu_mask, cpu))
-		per_cpu(cpu_data, i) = data;
+	set_affected_cpus(policy);
+	policy->driver_data = data;
 
 	/* Minimum transition latency is 12 platform clocks */
 	u64temp = 12ULL * NSEC_PER_SEC;
-	do_div(u64temp, fsl_get_sys_freq());
+	do_div(u64temp, get_bus_freq());
 	policy->cpuinfo.transition_latency = u64temp + 1;
 
 	of_node_put(np);
@@ -221,7 +279,7 @@ err_nomem1:
 err_node:
 	of_node_put(data->parent);
 err_nomem2:
-	per_cpu(cpu_data, cpu) = NULL;
+	policy->driver_data = NULL;
 	kfree(data);
 err_np:
 	of_node_put(np);
@@ -229,43 +287,40 @@ err_np:
 	return -ENODEV;
 }
 
-static int __exit corenet_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+static int __exit qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
-	struct cpu_data *data = per_cpu(cpu_data, policy->cpu);
-	unsigned int cpu;
+	struct cpu_data *data = policy->driver_data;
 
 	of_node_put(data->parent);
 	kfree(data->table);
 	kfree(data);
-
-	for_each_cpu(cpu, per_cpu(cpu_mask, policy->cpu))
-		per_cpu(cpu_data, cpu) = NULL;
+	policy->driver_data = NULL;
 
 	return 0;
 }
 
-static int corenet_cpufreq_target(struct cpufreq_policy *policy,
+static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
 		unsigned int index)
 {
 	struct clk *parent;
-	struct cpu_data *data = per_cpu(cpu_data, policy->cpu);
+	struct cpu_data *data = policy->driver_data;
 
 	parent = of_clk_get(data->parent, data->table[index].driver_data);
 	return clk_set_parent(policy->clk, parent);
 }
 
-static struct cpufreq_driver ppc_corenet_cpufreq_driver = {
-	.name		= "ppc_cpufreq",
+static struct cpufreq_driver qoriq_cpufreq_driver = {
+	.name		= "qoriq_cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
-	.init		= corenet_cpufreq_cpu_init,
-	.exit		= __exit_p(corenet_cpufreq_cpu_exit),
+	.init		= qoriq_cpufreq_cpu_init,
+	.exit		= __exit_p(qoriq_cpufreq_cpu_exit),
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target_index	= corenet_cpufreq_target,
+	.target_index	= qoriq_cpufreq_target,
 	.get		= cpufreq_generic_get,
 	.attr		= cpufreq_generic_attr,
 };
 
-static const struct of_device_id node_matches[] __initdata = {
+static const struct of_device_id node_matches[] __initconst = {
 	{ .compatible = "fsl,p2041-clockgen", .data = &sdata[0], },
 	{ .compatible = "fsl,p3041-clockgen", .data = &sdata[0], },
 	{ .compatible = "fsl,p5020-clockgen", .data = &sdata[1], },
@@ -275,61 +330,43 @@ static const struct of_device_id node_matches[] __initdata = {
 	{}
 };
 
-static int __init ppc_corenet_cpufreq_init(void)
+static int __init qoriq_cpufreq_init(void)
 {
 	int ret;
 	struct device_node  *np;
 	const struct of_device_id *match;
 	const struct soc_data *data;
-	unsigned int cpu;
 
 	np = of_find_matching_node(NULL, node_matches);
 	if (!np)
 		return -ENODEV;
 
-	for_each_possible_cpu(cpu) {
-		if (!alloc_cpumask_var(&per_cpu(cpu_mask, cpu), GFP_KERNEL))
-			goto err_mask;
-		cpumask_copy(per_cpu(cpu_mask, cpu), cpu_core_mask(cpu));
-	}
-
 	match = of_match_node(node_matches, np);
 	data = match->data;
 	if (data) {
 		if (data->flag)
 			fmask = data->freq_mask;
-		min_cpufreq = fsl_get_sys_freq();
+		min_cpufreq = get_bus_freq();
 	} else {
-		min_cpufreq = fsl_get_sys_freq() / 2;
+		min_cpufreq = get_bus_freq() / 2;
 	}
 
 	of_node_put(np);
 
-	ret = cpufreq_register_driver(&ppc_corenet_cpufreq_driver);
+	ret = cpufreq_register_driver(&qoriq_cpufreq_driver);
 	if (!ret)
-		pr_info("Freescale PowerPC corenet CPU frequency scaling driver\n");
+		pr_info("Freescale QorIQ CPU frequency scaling driver\n");
 
 	return ret;
-
-err_mask:
-	for_each_possible_cpu(cpu)
-		free_cpumask_var(per_cpu(cpu_mask, cpu));
-
-	return -ENOMEM;
 }
-module_init(ppc_corenet_cpufreq_init);
+module_init(qoriq_cpufreq_init);
 
-static void __exit ppc_corenet_cpufreq_exit(void)
+static void __exit qoriq_cpufreq_exit(void)
 {
-	unsigned int cpu;
-
-	for_each_possible_cpu(cpu)
-		free_cpumask_var(per_cpu(cpu_mask, cpu));
-
-	cpufreq_unregister_driver(&ppc_corenet_cpufreq_driver);
+	cpufreq_unregister_driver(&qoriq_cpufreq_driver);
 }
-module_exit(ppc_corenet_cpufreq_exit);
+module_exit(qoriq_cpufreq_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Tang Yuantian <Yuantian.Tang@freescale.com>");
-MODULE_DESCRIPTION("cpufreq driver for Freescale e500mc series SoCs");
+MODULE_DESCRIPTION("cpufreq driver for Freescale QorIQ series SoCs");
-- 
2.1.0.27.g96db324
