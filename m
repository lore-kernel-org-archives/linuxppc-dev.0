Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0136.outbound.protection.outlook.com [157.56.110.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CF651A19D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 16:42:08 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: Mike Turquette <mturquette@linaro.org>, Tang Yuantian
 <Yuantian.Tang@freescale.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liberman Igal-B31950
 <Igal.Liberman@freescale.com>, Bucur Madalin-Cristian-B32716
 <madalin.bucur@freescale.com>, <linux-clk@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 4/5] cpufreq: qoriq: Remove frequency masking and minimum
Date: Sat, 15 Aug 2015 01:41:21 -0500
Message-ID: <1439620882-20449-5-git-send-email-scottwood@freescale.com>
In-Reply-To: <1439620882-20449-1-git-send-email-scottwood@freescale.com>
References: <1439620882-20449-1-git-send-email-scottwood@freescale.com>
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

The clock driver now takes care of ensuring that the mux only
exposes options that are valid.  The driver was currently being overly
conservative in some cases -- for example, the "min_cpufreq =
get_bus_freq()" restriction only applies to chips with erratum
A-004510, and whether the freq_mask used on p5020 is needed depends on
the actual frequencies of the PLLs (FWIW, p5040 has a similar
limitation but its .freq_mask was zero).

Further, the freq_mask mechanism makes assumptions about the number and
order of the clock parents.  The new driver does not adhere to those
assumptions (in particular, it removes invalid options).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: non-RFC

 drivers/cpufreq/qoriq-cpufreq.c | 92 +----------------------------------------
 1 file changed, 2 insertions(+), 90 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 32ab99e..514395f 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -36,53 +36,6 @@ struct cpu_data {
 	struct cpufreq_frequency_table *table;
 };
 
-/**
- * struct soc_data - SoC specific data
- * @freq_mask: mask the disallowed frequencies
- * @flag: unique flags
- */
-struct soc_data {
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
-};
-
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
@@ -195,7 +148,7 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct device_node *np, *pnode;
 	int i, count, ret;
-	u32 freq, mask;
+	u32 freq;
 	struct clk *clk;
 	struct cpufreq_frequency_table *table;
 	struct cpu_data *data;
@@ -230,23 +183,11 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto err_pclk;
 	}
 
-	if (fmask)
-		mask = fmask[get_cpu_physical_id(cpu)];
-	else
-		mask = 0x0;
-
 	for (i = 0; i < count; i++) {
 		clk = clk_get_parent_by_index(policy->clk, i);
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
@@ -321,38 +262,9 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
 	.attr		= cpufreq_generic_attr,
 };
 
-static const struct of_device_id node_matches[] __initconst = {
-	{ .compatible = "fsl,p2041-clockgen", .data = &sdata[0], },
-	{ .compatible = "fsl,p3041-clockgen", .data = &sdata[0], },
-	{ .compatible = "fsl,p5020-clockgen", .data = &sdata[1], },
-	{ .compatible = "fsl,p4080-clockgen", .data = &sdata[2], },
-	{ .compatible = "fsl,p5040-clockgen", .data = &sdata[2], },
-	{ .compatible = "fsl,qoriq-clockgen-2.0", },
-	{}
-};
-
 static int __init qoriq_cpufreq_init(void)
 {
 	int ret;
-	struct device_node  *np;
-	const struct of_device_id *match;
-	const struct soc_data *data;
-
-	np = of_find_matching_node(NULL, node_matches);
-	if (!np)
-		return -ENODEV;
-
-	match = of_match_node(node_matches, np);
-	data = match->data;
-	if (data) {
-		if (data->flag)
-			fmask = data->freq_mask;
-		min_cpufreq = get_bus_freq();
-	} else {
-		min_cpufreq = get_bus_freq() / 2;
-	}
-
-	of_node_put(np);
 
 	ret = cpufreq_register_driver(&qoriq_cpufreq_driver);
 	if (!ret)
-- 
2.1.4
