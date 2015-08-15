Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0136.outbound.protection.outlook.com [157.56.110.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE0561A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 16:42:04 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: Mike Turquette <mturquette@linaro.org>, Tang Yuantian
 <Yuantian.Tang@freescale.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liberman Igal-B31950
 <Igal.Liberman@freescale.com>, Bucur Madalin-Cristian-B32716
 <madalin.bucur@freescale.com>, <linux-clk@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 1/5] cpufreq: qoriq: Don't look at clock implementation
 details
Date: Sat, 15 Aug 2015 01:41:18 -0500
Message-ID: <1439620882-20449-2-git-send-email-scottwood@freescale.com>
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

Get the CPU clock's potential parent clocks from the clock interface
itself, rather than manually parsing the clocks property to find a
phandle, looking at the clock-names property of that, and assuming that
those are valid parent clocks for the cpu clock.

This is necessary for cpufreq to continue working once the clocks
are generated based on the clock driver's knowledge of the chip
rather than a fragile device-tree description of the mux options.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: non-RFC

 drivers/cpufreq/qoriq-cpufreq.c | 47 ++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 358f075..32ab99e 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/cpufreq.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -99,9 +100,10 @@ static u32 get_bus_freq(void)
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
@@ -110,37 +112,32 @@ static struct device_node *cpu_to_clk_node(int cpu)
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
+	const char *ourname, *theirname;
 	int i;
 
-	np = cpu_to_clk_node(policy->cpu);
-	if (!np)
-		return;
+	ourname = __clk_get_name(policy->clk);
 
 	for_each_present_cpu(i) {
-		clk_np = cpu_to_clk_node(i);
-		if (!clk_np)
+		clk = cpu_to_clk(i);
+		if (IS_ERR(clk)) {
+			pr_err("%s: no clock for cpu %d\n", __func__, i);
 			continue;
+		}
 
-		if (clk_np == np)
+		theirname = __clk_get_name(clk);
+		if (!strcmp(ourname, theirname))
 			cpumask_set_cpu(i, dstp);
-
-		of_node_put(clk_np);
 	}
-	of_node_put(np);
 }
 
 /* reduce the duplicated frequencies in frequency table */
@@ -219,17 +216,12 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto err_nomem2;
 	}
 
-	pnode = of_parse_phandle(np, "clocks", 0);
-	if (!pnode) {
-		pr_err("%s: could not get clock information\n", __func__);
-		goto err_nomem2;
-	}
+	count = __clk_get_num_parents(policy->clk);
 
-	count = of_property_count_strings(pnode, "clock-names");
 	data->pclk = kcalloc(count, sizeof(struct clk *), GFP_KERNEL);
 	if (!data->pclk) {
 		pr_err("%s: no memory\n", __func__);
-		goto err_node;
+		goto err_nomem2;
 	}
 
 	table = kcalloc(count + 1, sizeof(*table), GFP_KERNEL);
@@ -244,7 +236,7 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		mask = 0x0;
 
 	for (i = 0; i < count; i++) {
-		clk = of_clk_get(pnode, i);
+		clk = clk_get_parent_by_index(policy->clk, i);
 		data->pclk[i] = clk;
 		freq = clk_get_rate(clk);
 		/*
@@ -288,10 +280,7 @@ err_nomem1:
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
-- 
2.1.4
