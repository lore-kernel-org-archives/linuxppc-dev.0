Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0142.outbound.protection.outlook.com [207.46.100.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A22C11A2CA4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2015 14:30:31 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar
 <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>
CC: <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 "Tang Yuantian" <Yuantian.Tang@freescale.com>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH v3 5/5] cpufreq: qoriq: Don't look at clock implementation
 details
Date: Sat, 19 Sep 2015 23:29:57 -0500
Message-ID: <1442723397-26329-6-git-send-email-scottwood@freescale.com>
In-Reply-To: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
References: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Get the CPU clock's potential parent clocks from the clock interface
itself, rather than manually parsing the clocks property to find a
phandle, looking at the clock-names property of that, and assuming that
those are valid parent clocks for the cpu clock.

This is necessary now that the clocks are generated based on the clock
driver's knowledge of the chip rather than a fragile device-tree
description of the mux options.

We can now rely on the clock driver to ensure that the mux only exposes
options that are valid.  The cpufreq driver was currently being overly
conservative in some cases -- for example, the "min_cpufreq =
get_bus_freq()" restriction only applies to chips with erratum
A-004510, and whether the freq_mask used on p5020 is needed depends on
the actual frequencies of the PLLs (FWIW, p5040 has a similar
limitation but its .freq_mask was zero) -- and the frequency mask
mechanism made assumptions about particular parent clock indices that
are no longer valid.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v3: was patch 1/5 and patch 4/5, plus blacklist e6500 and changes
to clk api usage

 drivers/cpufreq/qoriq-cpufreq.c | 137 ++++++++++++----------------------------
 1 file changed, 40 insertions(+), 97 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 358f075..4f53fa2 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -35,53 +35,20 @@ struct cpu_data {
 	struct cpufreq_frequency_table *table;
 };
 
+/*
+ * Don't use cpufreq on this SoC -- used when the SoC would have otherwise
+ * matched a more generic compatible.
+ */
+#define SOC_BLACKLIST		1
+
 /**
  * struct soc_data - SoC specific data
- * @freq_mask: mask the disallowed frequencies
- * @flag: unique flags
+ * @flags: SOC_xxx
  */
 struct soc_data {
-	u32 freq_mask[4];
-	u32 flag;
-};
-
-#define FREQ_MASK	1
-/* see hardware specification for the allowed frqeuencies */
-static const struct soc_data sdata[] = {
-	{ /* used by p2041 and p3041 */
-		.freq_mask = {0x8, 0x8, 0x2, 0x2},
-		.flag = FREQ_MASK,
-	},
-	{ /* used by p5020 */
-		.freq_mask = {0x8, 0x2},
-		.flag = FREQ_MASK,
-	},
-	{ /* used by p4080, p5040 */
-		.freq_mask = {0},
-		.flag = 0,
-	},
+	u32 flags;
 };
 
-/*
- * the minimum allowed core frequency, in Hz
- * for chassis v1.0, >= platform frequency
- * for chassis v2.0, >= platform frequency / 2
- */
-static u32 min_cpufreq;
-static const u32 *fmask;
-
-#if defined(CONFIG_ARM)
-static int get_cpu_physical_id(int cpu)
-{
-	return topology_core_id(cpu);
-}
-#else
-static int get_cpu_physical_id(int cpu)
-{
-	return get_hard_smp_processor_id(cpu);
-}
-#endif
-
 static u32 get_bus_freq(void)
 {
 	struct device_node *soc;
@@ -99,9 +66,10 @@ static u32 get_bus_freq(void)
 	return sysfreq;
 }
 
-static struct device_node *cpu_to_clk_node(int cpu)
+static struct clk *cpu_to_clk(int cpu)
 {
-	struct device_node *np, *clk_np;
+	struct device_node *np;
+	struct clk *clk;
 
 	if (!cpu_present(cpu))
 		return NULL;
@@ -110,37 +78,28 @@ static struct device_node *cpu_to_clk_node(int cpu)
 	if (!np)
 		return NULL;
 
-	clk_np = of_parse_phandle(np, "clocks", 0);
-	if (!clk_np)
-		return NULL;
-
+	clk = of_clk_get(np, 0);
 	of_node_put(np);
-
-	return clk_np;
+	return clk;
 }
 
 /* traverse cpu nodes to get cpu mask of sharing clock wire */
 static void set_affected_cpus(struct cpufreq_policy *policy)
 {
-	struct device_node *np, *clk_np;
 	struct cpumask *dstp = policy->cpus;
+	struct clk *clk;
 	int i;
 
-	np = cpu_to_clk_node(policy->cpu);
-	if (!np)
-		return;
-
 	for_each_present_cpu(i) {
-		clk_np = cpu_to_clk_node(i);
-		if (!clk_np)
+		clk = cpu_to_clk(i);
+		if (IS_ERR(clk)) {
+			pr_err("%s: no clock for cpu %d\n", __func__, i);
 			continue;
+		}
 
-		if (clk_np == np)
+		if (clk_is_match(policy->clk, clk))
 			cpumask_set_cpu(i, dstp);
-
-		of_node_put(clk_np);
 	}
-	of_node_put(np);
 }
 
 /* reduce the duplicated frequencies in frequency table */
@@ -198,7 +157,7 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct device_node *np, *pnode;
 	int i, count, ret;
-	u32 freq, mask;
+	u32 freq;
 	struct clk *clk;
 	struct cpufreq_frequency_table *table;
 	struct cpu_data *data;
@@ -219,17 +178,12 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto err_nomem2;
 	}
 
-	pnode = of_parse_phandle(np, "clocks", 0);
-	if (!pnode) {
-		pr_err("%s: could not get clock information\n", __func__);
-		goto err_nomem2;
-	}
+	count = clk_get_num_parents(policy->clk);
 
-	count = of_property_count_strings(pnode, "clock-names");
 	data->pclk = kcalloc(count, sizeof(struct clk *), GFP_KERNEL);
 	if (!data->pclk) {
 		pr_err("%s: no memory\n", __func__);
-		goto err_node;
+		goto err_nomem2;
 	}
 
 	table = kcalloc(count + 1, sizeof(*table), GFP_KERNEL);
@@ -238,23 +192,11 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto err_pclk;
 	}
 
-	if (fmask)
-		mask = fmask[get_cpu_physical_id(cpu)];
-	else
-		mask = 0x0;
-
 	for (i = 0; i < count; i++) {
-		clk = of_clk_get(pnode, i);
+		clk = clk_get_parent_by_index(policy->clk, i);
 		data->pclk[i] = clk;
 		freq = clk_get_rate(clk);
-		/*
-		 * the clock is valid if its frequency is not masked
-		 * and large than minimum allowed frequency.
-		 */
-		if (freq < min_cpufreq || (mask & (1 << i)))
-			table[i].frequency = CPUFREQ_ENTRY_INVALID;
-		else
-			table[i].frequency = freq / 1000;
+		table[i].frequency = freq / 1000;
 		table[i].driver_data = i;
 	}
 	freq_table_redup(table, count);
@@ -288,10 +230,7 @@ err_nomem1:
 	kfree(table);
 err_pclk:
 	kfree(data->pclk);
-err_node:
-	of_node_put(pnode);
 err_nomem2:
-	policy->driver_data = NULL;
 	kfree(data);
 err_np:
 	of_node_put(np);
@@ -332,12 +271,20 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
 	.attr		= cpufreq_generic_attr,
 };
 
+static const struct soc_data blacklist = {
+	.flags = SOC_BLACKLIST,
+};
+
 static const struct of_device_id node_matches[] __initconst = {
-	{ .compatible = "fsl,p2041-clockgen", .data = &sdata[0], },
-	{ .compatible = "fsl,p3041-clockgen", .data = &sdata[0], },
-	{ .compatible = "fsl,p5020-clockgen", .data = &sdata[1], },
-	{ .compatible = "fsl,p4080-clockgen", .data = &sdata[2], },
-	{ .compatible = "fsl,p5040-clockgen", .data = &sdata[2], },
+	/* e6500 cannot use cpufreq due to erratum A-008083 */
+	{ .compatible = "fsl,b4420-clockgen", &blacklist },
+	{ .compatible = "fsl,b4860-clockgen", &blacklist },
+	{ .compatible = "fsl,t2080-clockgen", &blacklist },
+	{ .compatible = "fsl,t4240-clockgen", &blacklist },
+
+	{ .compatible = "fsl,ls1021a-clockgen", },
+	{ .compatible = "fsl,p4080-clockgen", },
+	{ .compatible = "fsl,qoriq-clockgen-1.0", },
 	{ .compatible = "fsl,qoriq-clockgen-2.0", },
 	{}
 };
@@ -355,16 +302,12 @@ static int __init qoriq_cpufreq_init(void)
 
 	match = of_match_node(node_matches, np);
 	data = match->data;
-	if (data) {
-		if (data->flag)
-			fmask = data->freq_mask;
-		min_cpufreq = get_bus_freq();
-	} else {
-		min_cpufreq = get_bus_freq() / 2;
-	}
 
 	of_node_put(np);
 
+	if (data && data->flags & SOC_BLACKLIST)
+		return -ENODEV;
+
 	ret = cpufreq_register_driver(&qoriq_cpufreq_driver);
 	if (!ret)
 		pr_info("Freescale QorIQ CPU frequency scaling driver\n");
-- 
2.1.4
