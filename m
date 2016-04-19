Return-Path: <hongtao.jia@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0087.outbound.protection.outlook.com [157.56.110.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpwgg6Jk4zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 16:52:47 +1000 (AEST)
From: Jia Hongtao <hongtao.jia@nxp.com>
To: <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <scott.wood@nxp.com>,
 <yuantian.tang@nxp.com>, <hongtao.jia@nxp.com>
Subject: [PATCH V2] cpufreq: qoriq: Fix cooling device registration issue
 during suspend
Date: Tue, 19 Apr 2016 14:43:26 +0800
Message-ID: <1461048206-23567-1-git-send-email-hongtao.jia@nxp.com>
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
may be multiple registered. Matchable unregistration is added to exit
callback to fix this issue.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
Changes for V2:
* Using qoriq_cpufreq_cpu_exit() callback instead of adding stop_cpu().

 drivers/cpufreq/qoriq-cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index b23e525..0b85f90 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -301,10 +301,11 @@ err_np:
 	return -ENODEV;
 }
 
-static int __exit qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cpu_data *data = policy->driver_data;
 
+	cpufreq_cooling_unregister(data->cdev);
 	kfree(data->pclk);
 	kfree(data->table);
 	kfree(data);
@@ -348,7 +349,7 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
 	.name		= "qoriq_cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.init		= qoriq_cpufreq_cpu_init,
-	.exit		= __exit_p(qoriq_cpufreq_cpu_exit),
+	.exit		= qoriq_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qoriq_cpufreq_target,
 	.get		= cpufreq_generic_get,
-- 
2.1.0.27.g96db324
