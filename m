Return-Path: <hongtao.jia@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0089.outbound.protection.outlook.com [207.46.100.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpLmX1GfHzDqFb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 18:24:59 +1000 (AEST)
From: Jia Hongtao <hongtao.jia@nxp.com>
To: <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <scott.wood@nxp.com>,
 <yuantian.tang@nxp.com>, <hongtao.jia@nxp.com>
Subject: [PATCH 1/2] cpufreq: qoriq: Fix cooling device registration issue
 during suspend
Date: Mon, 18 Apr 2016 15:59:31 +0800
Message-ID: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com>
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

Cooling device is registered by ready callback. It's also invoked while
system resuming from sleep (Enabling non-boot cpus). Thus cooling device
may be multiple registered. Stop_cpu callback is invoked during suspend
(Disabling non-boot cpus). So matchable unregistration is added to fix
this issue.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
 drivers/cpufreq/qoriq-cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index b23e525..1c2fdc1 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -305,6 +305,7 @@ static int __exit qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cpu_data *data = policy->driver_data;
 
+	cpufreq_cooling_unregister(data->cdev);
 	kfree(data->pclk);
 	kfree(data->table);
 	kfree(data);
@@ -323,6 +324,12 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
 	return clk_set_parent(policy->clk, parent);
 }
 
+static void qoriq_cpufreq_stop_cpu(struct cpufreq_policy *policy)
+{
+	struct cpu_data *cpud = policy->driver_data;
+
+	cpufreq_cooling_unregister(cpud->cdev);
+}
 
 static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
 {
@@ -352,6 +359,7 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qoriq_cpufreq_target,
 	.get		= cpufreq_generic_get,
+	.stop_cpu	= qoriq_cpufreq_stop_cpu,
 	.ready		= qoriq_cpufreq_ready,
 	.attr		= cpufreq_generic_attr,
 };
-- 
2.1.0.27.g96db324
