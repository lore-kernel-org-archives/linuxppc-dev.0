Return-Path: <hongtao.jia@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0081.outbound.protection.outlook.com [207.46.100.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpLlw35WhzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 18:24:27 +1000 (AEST)
From: Jia Hongtao <hongtao.jia@nxp.com>
To: <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <scott.wood@nxp.com>,
 <yuantian.tang@nxp.com>, <hongtao.jia@nxp.com>
Subject: [PATCH 2/2] cpufreq: qoriq: Don't show cooling device messages if
 THERMAL_OF undefined
Date: Mon, 18 Apr 2016 15:59:32 +0800
Message-ID: <1460966372-4877-2-git-send-email-hongtao.jia@nxp.com>
In-Reply-To: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com>
References: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com>
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

When THERMAL_OF is undefined the cooling device messages should not be
shown. -ENOSYS is returned from of_cpufreq_cooling_register() when
THERMAL_OF is undefined.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
 drivers/cpufreq/qoriq-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 1c2fdc1..ff8da83 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -340,8 +340,8 @@ static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
 		cpud->cdev = of_cpufreq_cooling_register(np,
 							 policy->related_cpus);
 
-		if (IS_ERR(cpud->cdev)) {
-			pr_err("Failed to register cooling device cpu%d: %ld\n",
+		if (IS_ERR(cpud->cdev) && PTR_ERR(cpud->cdev) != -ENOSYS) {
+			pr_err("cpu%d is not running as cooling device: %ld\n",
 					policy->cpu, PTR_ERR(cpud->cdev));
 
 			cpud->cdev = NULL;
-- 
2.1.0.27.g96db324
