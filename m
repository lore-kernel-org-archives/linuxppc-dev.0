Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DB311A0E61
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 19:00:31 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1CCAD140157
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:31 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 4 May 2015 19:00:30 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 547EE357804F
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:29 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4490Ltb42402022
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 19:00:29 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t448xuGY023781
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 18:59:56 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] cpufreq: powernv: Report Psafe only if
 PMSR.psafe_mode_active bit is set
Date: Mon,  4 May 2015 14:24:11 +0530
Message-Id: <1430729652-14813-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: preeti@linux.vnet.ibm.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On a reset cycle of OCC, although the system retires from safe
frequency state the local pstate is not restored to Pmin or last
requested pstate. Now if the cpufreq governor initiates a pstate
change, the local pstate will be in Psafe and we will be reporting a
false positive when we are not throttled.

So in powernv_cpufreq_throttle_check() remove the condition which
checks if local pstate is less than Pmin while checking for Psafe
frequency. If the cpus are forced to Psafe then PMSR.psafe_mode_active
bit will be set. So, when OCCs become active this bit will be cleared.
Let us just rely on this bit for reporting throttling.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 9618813..0a59d5b 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -39,7 +39,6 @@
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
 #define PMSR_SPR_EM_DISABLE	(1UL << 31)
 #define PMSR_MAX(x)		((x >> 32) & 0xFF)
-#define PMSR_LP(x)		((x >> 48) & 0xFF)
 #define OCC_RESET		0
 #define OCC_LOAD		1
 #define OCC_THROTTLE		2
@@ -316,7 +315,7 @@ static void powernv_cpufreq_throttle_check(void *data)
 {
 	unsigned int cpu = smp_processor_id();
 	unsigned long pmsr;
-	int pmsr_pmax, pmsr_lp, i;
+	int pmsr_pmax, i;
 
 	pmsr = get_pmspr(SPRN_PMSR);
 
@@ -338,14 +337,9 @@ static void powernv_cpufreq_throttle_check(void *data)
 			chips[i].id, pmsr_pmax);
 	}
 
-	/*
-	 * Check for Psafe by reading LocalPstate
-	 * or check if Psafe_mode_active is set in PMSR.
-	 */
+	/* Check if Psafe_mode_active is set in PMSR. */
 next:
-	pmsr_lp = (s8)PMSR_LP(pmsr);
-	if ((pmsr_lp < powernv_pstate_info.min) ||
-				(pmsr & PMSR_PSAFE_ENABLE)) {
+	if (pmsr & PMSR_PSAFE_ENABLE) {
 		throttled = true;
 		pr_info("Pstate set to safe frequency\n");
 	}
-- 
1.9.3
