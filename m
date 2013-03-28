Return-Path: <B29983@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C45E2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 21:31:53 +1100 (EST)
From: <Yuantian.Tang@freescale.com>
To: <rjw@sisk.pl>
Subject: [PATCH 2/2 v2] cpufreq: Add cpufreq driver for Freescale e500mc SoCs
Date: Thu, 28 Mar 2013 17:55:08 +0800
Message-ID: <1364464508-25393-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, cpufreq@vger.kernel.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <yuantian.tang@freescale.com>

Add cpufreq driver for Freescale e500mc, e5500 and e6500 SoCs
which are capable of changing the frequency of CPU dynamically

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
v2:
	- change the per_cpu variable to point type
	- fixed other issues

 drivers/cpufreq/Kconfig.powerpc       |  10 ++
 drivers/cpufreq/Makefile              |   1 +
 drivers/cpufreq/ppc-corenet-cpufreq.c | 255 ++++++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 drivers/cpufreq/ppc-corenet-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
index e76992f..3a0d8d0 100644
--- a/drivers/cpufreq/Kconfig.powerpc
+++ b/drivers/cpufreq/Kconfig.powerpc
@@ -5,3 +5,13 @@ config CPU_FREQ_MAPLE
 	help
 	  This adds support for frequency switching on Maple 970FX
 	  Evaluation Board and compatible boards (IBM JS2x blades).
+
+config PPC_CORENET_CPUFREQ
+	tristate "CPU frequency scaling driver for Freescale E500MC SoCs"
+	depends on PPC_E500MC && OF && COMMON_CLK
+	select CPU_FREQ_TABLE
+	select CLK_PPC_CORENET
+	help
+	  This adds the CPUFreq driver support for Freescale e500mc,
+	  e5500 and e6500 series SoCs which are capable of changing
+	  the CPU's frequency dynamically.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 863fd18..2416559 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
 ##################################################################################
 # PowerPC platform drivers
 obj-$(CONFIG_CPU_FREQ_MAPLE)		+= maple-cpufreq.o
+obj-$(CONFIG_PPC_CORENET_CPUFREQ)   += ppc-corenet-cpufreq.o
diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
new file mode 100644
index 0000000..a50ab5a
--- /dev/null
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -0,0 +1,255 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * CPU Frequency Scaling driver for Freescale PowerPC corenet SoCs.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+/**
+ * struct cpufreq_data - cpufreq driver data
+ * @cpus_per_cluster: CPU numbers per cluster
+ * @cpufreq_lock: the mutex lock
+ */
+struct cpufreq_data {
+	int	cpus_per_cluster;
+	struct mutex cpufreq_lock;
+};
+
+/**
+ * struct cpu_data - per CPU data struct
+ * @clk: the clk data of CPU
+ * @parent: the parent node of clock of cpu
+ * @table: frequency table point
+ */
+struct cpu_data {
+	struct clk *clk;
+	struct device_node *parent;
+	struct cpufreq_frequency_table *table;
+};
+
+static DEFINE_PER_CPU(struct cpu_data *, cpu_data);
+static struct cpufreq_data freq_data;
+
+static unsigned int corenet_cpufreq_get_speed(unsigned int cpu)
+{
+	struct cpu_data *data = per_cpu(cpu_data, cpu);
+
+	return clk_get_rate(data->clk) / 1000;
+}
+
+/* reduce the duplicated frequency in frequency table */
+static void freq_table_redup(struct cpufreq_frequency_table *freq_table,
+		int count)
+{
+	int i, j;
+
+	for (i = 1; i < count; i++) {
+		for (j = 0; j < i; j++) {
+			if (freq_table[j].frequency == CPUFREQ_ENTRY_INVALID ||
+					freq_table[j].frequency !=
+					freq_table[i].frequency)
+				continue;
+
+			freq_table[i].frequency = CPUFREQ_ENTRY_INVALID;
+			break;
+		}
+	}
+}
+
+static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	unsigned int cpu = policy->cpu;
+	struct device_node *np;
+	int i, count;
+	struct clk *clk;
+	struct cpufreq_frequency_table *table;
+	struct cpu_data *data;
+
+	np = of_get_cpu_node(cpu, NULL);
+	if (!np)
+		return -ENODEV;
+
+	data = kzalloc(sizeof(struct cpu_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->clk = of_clk_get(np, 0);
+	data->parent = of_parse_phandle(np, "clocks", 0);
+	if (!data->parent) {
+		pr_err("%s: could not get clock information\n", __func__);
+		goto err_nomem2;
+	}
+
+	count = of_property_count_strings(data->parent, "clock-names");
+
+	table = kcalloc(count + 1,
+			sizeof(struct cpufreq_frequency_table), GFP_KERNEL);
+	if (!table) {
+		pr_err("%s: no memory\n", __func__);
+		goto err_nomem2;
+	}
+
+	for (i = cpu; i < freq_data.cpus_per_cluster + cpu; i++)
+		cpumask_set_cpu(i, policy->cpus);
+
+	for (i = 0; i < count; i++) {
+		table[i].index = i;
+		clk = of_clk_get(data->parent, i);
+		table[i].frequency = clk_get_rate(clk) / 1000;
+	}
+	freq_table_redup(table, count);
+	table[i].frequency = CPUFREQ_TABLE_END;
+
+	data->table = table;
+	per_cpu(cpu_data, cpu) = data;
+
+	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+	policy->cur = corenet_cpufreq_get_speed(policy->cpu);
+
+	/* set the min and max frequency properly */
+	i = cpufreq_frequency_table_cpuinfo(policy, table);
+	if (i) {
+		pr_err("invalid frequency table: %d\n", i);
+		goto err_nomem1;
+	}
+	cpufreq_frequency_table_get_attr(table, cpu);
+
+	return 0;
+
+err_nomem1:
+	kfree(table);
+err_nomem2:
+	per_cpu(cpu_data, cpu) = NULL;
+	kfree(data);
+
+	return -ENODEV;
+}
+
+static int __exit corenet_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct cpu_data *data = per_cpu(cpu_data, policy->cpu);
+
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	kfree(data->table);
+	kfree(data);
+
+	return 0;
+}
+
+static int corenet_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *table;
+
+	table = per_cpu(cpu_data, policy->cpu)->table;
+
+	return cpufreq_frequency_table_verify(policy, table);
+}
+
+static int corenet_cpufreq_target(struct cpufreq_policy *policy,
+		unsigned int target_freq, unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	unsigned int new;
+	struct clk *parent;
+	int ret;
+	struct cpu_data *data = per_cpu(cpu_data, policy->cpu);
+
+	cpufreq_frequency_table_target(policy, data->table,
+			target_freq, relation, &new);
+
+	if (policy->cur == data->table[new].frequency)
+		return 0;
+
+	freqs.old = policy->cur;
+	freqs.new = data->table[new].frequency;
+	freqs.cpu = policy->cpu;
+
+	mutex_lock(&freq_data.cpufreq_lock);
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	parent = of_clk_get(data->parent, new);
+	ret = clk_set_parent(data->clk, parent);
+	if (ret) {
+		mutex_unlock(&freq_data.cpufreq_lock);
+		return ret;
+	}
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	mutex_unlock(&freq_data.cpufreq_lock);
+
+	return 0;
+}
+
+static struct freq_attr *corenet_cpu_clks_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
+static struct cpufreq_driver ppc_corenet_cpufreq_driver = {
+	.name		= "ppc_cpufreq",
+	.owner		= THIS_MODULE,
+	.flags		= CPUFREQ_CONST_LOOPS,
+	.init		= corenet_cpufreq_cpu_init,
+	.exit		= __exit_p(corenet_cpufreq_cpu_exit),
+	.verify		= corenet_cpufreq_verify,
+	.target		= corenet_cpufreq_target,
+	.get		= corenet_cpufreq_get_speed,
+	.attr		= corenet_cpu_clks_attr,
+};
+
+static const struct of_device_id node_matches[] __initconst = {
+	{ .compatible = "fsl,qoriq-clockgen-1.0", .data = (void *)1, },
+	{ .compatible = "fsl,qoriq-clockgen-2", .data = (void *)8, },
+	{}
+};
+
+static int __init ppc_corenet_cpufreq_init(void)
+{
+	int ret = 0;
+	struct device_node  *np;
+	const struct of_device_id *match;
+
+	np = of_find_matching_node(NULL, node_matches);
+	if (!np)
+		return -ENODEV;
+
+	match = of_match_node(node_matches, np);
+	freq_data.cpus_per_cluster = (unsigned long)match->data;
+	mutex_init(&freq_data.cpufreq_lock);
+	of_node_put(np);
+
+	ret = cpufreq_register_driver(&ppc_corenet_cpufreq_driver);
+	if (ret)
+		return ret;
+
+	pr_info("Freescale PowerPC corenet CPU frequency scaling driver\n");
+
+	return ret;
+}
+module_init(ppc_corenet_cpufreq_init);
+
+static void __exit ppc_corenet_cpufreq_exit(void)
+{
+	cpufreq_unregister_driver(&ppc_corenet_cpufreq_driver);
+}
+module_exit(ppc_corenet_cpufreq_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tang Yuantian <Yuantian.Tang@freescale.com>");
+MODULE_DESCRIPTION("cpufreq driver for Freescale e500mc series SoCs");
-- 
1.8.0
