Return-Path: <hongtao.jia@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0119.outbound.protection.outlook.com [157.56.111.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E66871A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 20:28:26 +1100 (AEDT)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <edubezval@gmail.com>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, <scottwood@freescale.com>,
 <hongtao.jia@freescale.com>
Subject: [PATCH V3] cpufreq: qoriq: Register cooling device based on device
 tree
Date: Thu, 26 Nov 2015 17:21:11 +0800
Message-ID: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
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

Register the qoriq cpufreq driver as a cooling device, based on the
thermal device tree framework. When temperature crosses the passive trip
point cpufreq is used to throttle CPUs.

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changes for V3:
* Removed unnecessary cpu node NULL check.

Changes for V2:
* Using ->ready callback for cpu cooling device registering.

 drivers/cpufreq/qoriq-cpufreq.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 4f53fa2..cb6a62c 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_cooling.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -33,6 +34,7 @@
 struct cpu_data {
 	struct clk **pclk;
 	struct cpufreq_frequency_table *table;
+	struct thermal_cooling_device *cdev;
 };
 
 /*
@@ -260,6 +262,27 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
 	return clk_set_parent(policy->clk, parent);
 }
 
+
+static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	struct cpu_data *cpud = policy->driver_data;
+	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
+
+	if (of_find_property(np, "#cooling-cells", NULL)) {
+		cpud->cdev = of_cpufreq_cooling_register(np,
+							 policy->related_cpus);
+
+		if (IS_ERR(cpud->cdev)) {
+			pr_err("Failed to register cooling device cpu%d: %ld\n",
+					policy->cpu, PTR_ERR(cpud->cdev));
+
+			cpud->cdev = NULL;
+		}
+	}
+
+	of_node_put(np);
+}
+
 static struct cpufreq_driver qoriq_cpufreq_driver = {
 	.name		= "qoriq_cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
@@ -268,6 +291,7 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qoriq_cpufreq_target,
 	.get		= cpufreq_generic_get,
+	.ready		= qoriq_cpufreq_ready,
 	.attr		= cpufreq_generic_attr,
 };
 
-- 
2.1.0.27.g96db324
