Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C31C1A2BD6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 04:49:29 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AACC2140784
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 04:49:28 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 15 Sep 2015 00:17:57 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 40C635E81A3
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 23:05:29 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8EHYaSh56164536
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 23:06:04 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8E8WNJe001336
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 14:02:24 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2] cpufreq : powernv: Report Pmax throttling if capped below
 nominal frequency
Date: Mon, 14 Sep 2015 14:01:47 +0530
Message-Id: <1442219507-6499-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1442207874-5016-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1442207874-5016-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Log a 'critical' message if the max frequency is reduced below nominal
frequency. We already log 'info' message if the max frequency is
capped below turbo frequency. CPU should guarantee atleast nominal
frequency, but not turbo frequency in all system configurations and
environments. So report the pmax throttling with severity when Pmax is
dipped below nominal frequency.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from v1:
- Modified the printk messages as per Viresh's suggestion.

 drivers/cpufreq/powernv-cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 64994e1..cb50138 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -327,8 +327,14 @@ static void powernv_cpufreq_throttle_check(void *data)
 		if (chips[i].throttled)
 			goto next;
 		chips[i].throttled = true;
-		pr_info("CPU %d on Chip %u has Pmax reduced to %d\n", cpu,
-			chips[i].id, pmsr_pmax);
+		if (pmsr_pmax < powernv_pstate_info.nominal)
+			pr_crit("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
+				cpu, chips[i].id, pmsr_pmax,
+				powernv_pstate_info.nominal);
+		else
+			pr_info("CPU %d on Chip %u has Pmax reduced below turbo frequency (%d < %d)\n",
+				cpu, chips[i].id, pmsr_pmax,
+				powernv_pstate_info.max);
 	} else if (chips[i].throttled) {
 		chips[i].throttled = false;
 		pr_info("CPU %d on Chip %u has Pmax restored to %d\n", cpu,
-- 
1.9.3
