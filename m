Return-Path: <hongtao.jia@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0137.outbound.protection.outlook.com [65.55.169.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18F631A2AB1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 18:17:06 +1100 (AEDT)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <edubezval@gmail.com>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, <scottwood@freescale.com>,
 <hongtao.jia@freescale.com>
Subject: [PATCH] cpufreq: qoriq: Register cooling device based on device tree
Date: Tue, 24 Nov 2015 14:55:29 +0800
Message-ID: <1448348129-46675-1-git-send-email-hongtao.jia@freescale.com>
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
Reviewed-by: Scott Wood <scottwood@freescale.com>
---
This patch depends on following patches from Scott Wood:
http://patchwork.ozlabs.org/patch/519803/
http://patchwork.ozlabs.org/patch/519804/

 drivers/cpufreq/qoriq-cpufreq.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 4f53fa2..cb1bc3c 100644
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
@@ -292,7 +294,11 @@ static const struct of_device_id node_matches[] __initconst = {
 static int __init qoriq_cpufreq_init(void)
 {
 	int ret;
-	struct device_node  *np;
+	struct device_node *np;
+	struct device_node *cpu_np;
+	unsigned int cpu_id;
+	struct cpufreq_policy cpu_policy;
+	struct cpu_data *cpud;
 	const struct of_device_id *match;
 	const struct soc_data *data;
 
@@ -309,6 +315,22 @@ static int __init qoriq_cpufreq_init(void)
 		return -ENODEV;
 
 	ret = cpufreq_register_driver(&qoriq_cpufreq_driver);
+
+	/* Register CPU cooling device for QorIQ platform */
+	for_each_node_with_property(cpu_np, "#cooling-cells") {
+		of_property_read_u32(cpu_np, "reg", &cpu_id);
+		cpufreq_get_policy(&cpu_policy, cpu_id);
+
+		cpud = cpu_policy.driver_data;
+		cpud->cdev = of_cpufreq_cooling_register(cpu_np,
+						cpu_policy.related_cpus);
+		if (IS_ERR(cpud->cdev) && ERR_PTR(cpud->cdev) != -ENOSYS)
+			pr_err("Failed to register cooling device cpu%d: %ld\n",
+			       cpu_id, PTR_ERR(cpud->cdev));
+	}
+
+	of_node_put(cpu_np);
+
 	if (!ret)
 		pr_info("Freescale QorIQ CPU frequency scaling driver\n");
 
-- 
2.1.0.27.g96db324
