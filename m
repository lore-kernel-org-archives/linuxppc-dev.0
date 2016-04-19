Return-Path: <hongtao.jia@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0065.outbound.protection.outlook.com [157.56.110.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq03V1rHGzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 19:25:09 +1000 (AEST)
From: Jia Hongtao <hongtao.jia@nxp.com>
To: <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <scott.wood@nxp.com>,
 <yuantian.tang@nxp.com>, <hongtao.jia@nxp.com>
Subject: [PATCH V3 2/2] cpufreq: qoriq: Fix cooling device registration issue
 during suspend
Date: Tue, 19 Apr 2016 17:00:07 +0800
Message-ID: <1461056407-22542-2-git-send-email-hongtao.jia@nxp.com>
In-Reply-To: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com>
References: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com>
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
 drivers/cpufreq/qoriq-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 3a3fe39..0b85f90 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -305,6 +305,7 @@ static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cpu_data *data = policy->driver_data;
 
+	cpufreq_cooling_unregister(data->cdev);
 	kfree(data->pclk);
 	kfree(data->table);
 	kfree(data);
-- 
2.1.0.27.g96db324
