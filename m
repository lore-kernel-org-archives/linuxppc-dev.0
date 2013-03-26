Return-Path: <B29983@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE65D2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 14:13:00 +1100 (EST)
From: <Yuantian.Tang@freescale.com>
To: <rjw@sisk.pl>
Subject: [PATCH 3/3] cpufreq: Add cpufreq driver for Freescale e500mc SOCs
Date: Tue, 26 Mar 2013 10:36:31 +0800
Message-ID: <1364265391-26077-3-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1364265391-26077-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1364265391-26077-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <yuantian.tang@freescale.com>

Add cpufreq driver for Freescale e500mc, e5500 and e6500 SOCs
which are capable of changing the frequency of CPU dynamically

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/cpufreq/Kconfig.powerpc       |  10 ++
 drivers/cpufreq/Makefile              |   1 +
 drivers/cpufreq/ppc-corenet-cpufreq.c | 237 ++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/cpufreq/ppc-corenet-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
index e76992f..6339db4 100644
--- a/drivers/cpufreq/Kconfig.powerpc
+++ b/drivers/cpufreq/Kconfig.powerpc
@@ -5,3 +5,13 @@ config CPU_FREQ_MAPLE
 	help
 	  This adds support for frequency switching on Maple 970FX
 	  Evaluation Board and compatible boards (IBM JS2x blades).
+
+config PPC_CORENET_CPUFREQ
+	tristate "CPU frequency scaling driver for Freescale E500MC SoCs"
+	depends on PPC_E500MC
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
index 0000000..ad359d4
--- /dev/null
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -0,0 +1,237 @@
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
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/cpufreq.h>
+#include <linux/init.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/clk-provider.h>
+#include <linux/cpu.h>
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
+ * @np: the node of CPU
+ * @parent: the parent node of np
+ * @table: frequency table point
+ */
+struct cpu_data {
+	struct device_node  *np;
+	struct device_node  *parent;
+	struct cpufreq_frequency_table *table;
+};
+
+static DEFINE_PER_CPU(struct cpu_data, cpu_data);
+static struct cpufreq_data freq_data;
+
+static unsigned int corenet_cpufreq_get_speed(unsigned int cpu)
+{
+	struct clk *clk;
+	struct cpu_data *data = &per_cpu(cpu_data, cpu);
+
+	clk = of_clk_get(data->np, 0);
+
+	return clk_get_rate(clk) / 1000;
+}
+
+/* reduce the duplicated frequency in frequency table */
+static int freq_table_redup(struct cpufreq_frequency_table *freq_table,
+		int cur)
+{
+	int i;
+
+	for (i = 0; i < cur; i++) {
+		if (freq_table[i].frequency == CPUFREQ_ENTRY_INVALID ||
+			freq_table[i].frequency != freq_table[cur].frequency)
+			continue;
+
+		freq_table[cur].index = -1;
+		freq_table[cur].frequency = CPUFREQ_ENTRY_INVALID;
+		break;
+	}
+
+	return (i == cur) ? 0 : 1;
+}
+
+static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	unsigned int cpu = policy->cpu;
+	int i, count;
+	struct clk *clk;
+	struct cpufreq_frequency_table *table;
+	struct cpu_data *data;
+
+	data = &per_cpu(cpu_data, cpu);
+	data->np = of_get_cpu_node(cpu, NULL);
+	if (!data->np)
+		return -ENODEV;
+
+	data->parent = of_parse_phandle(data->np, "clocks", 0);
+	if (!data->parent)
+		return -ENODEV;
+
+	count = of_property_count_strings(data->parent, "clock-names");
+
+	table = kcalloc(count + 1,
+			sizeof(struct cpufreq_frequency_table), GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	for (i = cpu; i < freq_data.cpus_per_cluster + cpu; i++)
+		cpumask_set_cpu(i, policy->cpus);
+
+	for (i = 0; i < count; i++) {
+		table[i].index = i;
+		clk = of_clk_get(data->parent, i);
+		table[i].frequency = clk_get_rate(clk) / 1000;
+		freq_table_redup(table, i);
+	}
+	table[i].index = -1;
+	table[i].frequency = CPUFREQ_TABLE_END;
+
+	data->table = table;
+	cpufreq_frequency_table_get_attr(table, cpu);
+
+	/* FIXME: what's the actual transition time? in ns */
+	policy->cpuinfo.transition_latency = 2000;
+
+	policy->cur = corenet_cpufreq_get_speed(policy->cpu);
+
+	/* set the min and max frequency properly */
+	return cpufreq_frequency_table_cpuinfo(policy, table);
+}
+
+static int __exit corenet_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+
+	return 0;
+}
+
+static int corenet_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *table;
+
+	table = (&per_cpu(cpu_data, policy->cpu))->table;
+	if (!table)
+		return -EINVAL;
+
+	return cpufreq_frequency_table_verify(policy, table);
+}
+
+static int corenet_cpufreq_target(struct cpufreq_policy *policy,
+		unsigned int target_freq, unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	unsigned int new;
+	struct clk *clk, *parent;
+	int ret;
+	struct cpu_data *data = &per_cpu(cpu_data, policy->cpu);
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
+	clk = of_clk_get(data->np, 0);
+	parent = of_clk_get(data->parent, new);
+	ret = clk_set_parent(clk, parent);
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
+	freq_data.cpus_per_cluster = (long)match->data;
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
+
+static void __exit ppc_corenet_cpufreq_exit(void)
+{
+	cpufreq_unregister_driver(&ppc_corenet_cpufreq_driver);
+}
+
+module_init(ppc_corenet_cpufreq_init);
+module_exit(ppc_corenet_cpufreq_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tang Yuantian <Yuantian.Tang@freescale.com>");
+MODULE_DESCRIPTION("cpufreq driver for Freescale e500mc series SOCs");
-- 
1.8.0
