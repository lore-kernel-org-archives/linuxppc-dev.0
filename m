Return-Path: <Yuantian.Tang@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 13CDD1A1271
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 18:29:29 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0143.outbound.protection.outlook.com [157.56.111.143])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2736E14017A
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 18:29:26 +1100 (AEDT)
From: Tang Yuantian <Yuantian.Tang@freescale.com>
To: <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>
Subject: [PATCH v2 1/2] cpufreq: qoriq: Make the driver usable on all QorIQ
 platforms
Date: Fri, 21 Nov 2014 15:28:01 +0800
Message-ID: <1416554882-16566-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r64188@freescale.com, linuxppc-dev@ozlabs.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Freescale introduced new ARM core-based SoCs which support dynamic
frequency switch feature. DFS on new SoCs are compatible with current
PowerPC CoreNet platforms. In order to support those new platforms,
this driver needs to be updated. The main changes include:

1. Changed the names of functions in driver.
2. Added two new functions get_cpu_physical_id() and get_bus_freq().
3. Used a new way to get the CPU mask which share clock wire.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
v2:
	- split the name change into a separete patch
	- use policy->driver_data instead of per_cpu variable

 drivers/cpufreq/Kconfig.arm           |   8 ++
 drivers/cpufreq/Kconfig.powerpc       |  11 ++-
 drivers/cpufreq/ppc-corenet-cpufreq.c | 160 +++++++++++++++++++++-------------
 3 files changed, 112 insertions(+), 67 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 83a75dc..1925ae94 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -247,3 +247,11 @@ config ARM_TEGRA_CPUFREQ
 	default y
 	help
 	  This adds the CPUFreq driver support for TEGRA SOCs.
+
+config QORIQ_CPUFREQ
+	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
+	depends on OF && COMMON_CLK
+	select CLK_PPC_CORENET
+	help
+	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
+	  which are capable of changing the CPU's frequency dynamically.
diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
index 72564b7..3a34248 100644
--- a/drivers/cpufreq/Kconfig.powerpc
+++ b/drivers/cpufreq/Kconfig.powerpc
@@ -23,14 +23,13 @@ config CPU_FREQ_MAPLE
 	  This adds support for frequency switching on Maple 970FX
 	  Evaluation Board and compatible boards (IBM JS2x blades).
 
-config PPC_CORENET_CPUFREQ
-	tristate "CPU frequency scaling driver for Freescale E500MC SoCs"
-	depends on PPC_E500MC && OF && COMMON_CLK
+config QORIQ_CPUFREQ
+	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
+	depends on OF && COMMON_CLK
 	select CLK_PPC_CORENET
 	help
-	  This adds the CPUFreq driver support for Freescale e500mc,
-	  e5500 and e6500 series SoCs which are capable of changing
-	  the CPU's frequency dynamically.
+	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
+	  which are capable of changing the CPU's frequency dynamically.
 
 config CPU_FREQ_PMAC
 	bool "Support for Apple PowerBooks"
diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index bee5df7..949d992 100644
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
@@ -20,10 +20,9 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
-#include <sysdev/fsl_soc.h>
 
 /**
- * struct cpu_data - per CPU data struct
+ * struct cpu_data
  * @parent: the parent node of cpu clock
  * @table: frequency table
  */
@@ -67,17 +66,78 @@ static const struct soc_data sdata[] = {
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
 
-/* cpumask in a cluster */
-static DEFINE_PER_CPU(cpumask_var_t, cpu_mask);
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
+
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
@@ -105,6 +165,7 @@ static void freq_table_sort(struct cpufreq_frequency_table *freq_table,
 	int i, j, ind;
 	unsigned int freq, max_freq;
 	struct cpufreq_frequency_table table;
+
 	for (i = 0; i < count - 1; i++) {
 		max_freq = freq_table[i].frequency;
 		ind = i;
@@ -129,7 +190,7 @@ static void freq_table_sort(struct cpufreq_frequency_table *freq_table,
 	}
 }
 
-static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
+static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct device_node *np;
 	int i, count, ret;
@@ -145,10 +206,8 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		pr_err("%s: no memory\n", __func__);
+	if (!data)
 		goto err_np;
-	}
 
 	policy->clk = of_clk_get(np, 0);
 	if (IS_ERR(policy->clk)) {
@@ -170,7 +229,7 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	if (fmask)
-		mask = fmask[get_hard_smp_processor_id(cpu)];
+		mask = fmask[get_cpu_physical_id(cpu)];
 	else
 		mask = 0x0;
 
@@ -201,13 +260,12 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
@@ -219,7 +277,7 @@ err_nomem1:
 err_node:
 	of_node_put(data->parent);
 err_nomem2:
-	per_cpu(cpu_data, cpu) = NULL;
+	policy->driver_data = NULL;
 	kfree(data);
 err_np:
 	of_node_put(np);
@@ -227,43 +285,41 @@ err_np:
 	return -ENODEV;
 }
 
-static int __exit corenet_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+static int __exit qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
-	struct cpu_data *data = per_cpu(cpu_data, policy->cpu);
+	struct cpu_data *data = policy->driver_data;
 	unsigned int cpu;
 
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
@@ -273,61 +329,43 @@ static const struct of_device_id node_matches[] __initdata = {
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
