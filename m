Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t99Mr1w8SzDvXS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 16:27:51 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA45NSFJ137664
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 01:27:49 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26gkhu9rdh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Nov 2016 01:27:49 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Fri, 4 Nov 2016 15:27:46 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 210FF2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 16:27:44 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA45RiNe5046752
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 16:27:44 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA45RhSf011526
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 16:27:43 +1100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH 2/2] cpufreq: powernv: Use PMSR to verify global and local
 pstate
Date: Fri,  4 Nov 2016 10:57:35 +0530
In-Reply-To: <1478237255-4258-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1478237255-4258-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Message-Id: <1478237255-4258-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As fast_switch may get called in interrupt disable mode, it does not
update the global_pstate_info data structure. Hence the global_pstate_info
has stale data whenever pstate is updated through fast_swtich().

So the gpstate_timer can fire after a fast_switch() call has update
the pstates to a different value. Hence the timer handler cannot rely
on the cached values of local and global pstate and needs to read it
from the PMSR. 

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

---
 drivers/cpufreq/powernv-cpufreq.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 09a0496..57713b5 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -592,7 +592,8 @@ void gpstate_timer_handler(unsigned long data)
 {
 	struct cpufreq_policy *policy = (struct cpufreq_policy *)data;
 	struct global_pstate_info *gpstates = policy->driver_data;
-	int gpstate_idx;
+	int gpstate_idx, lpstate_idx;
+	unsigned long val;
 	unsigned int time_diff = jiffies_to_msecs(jiffies)
 					- gpstates->last_sampled_time;
 	struct powernv_smp_call_data freq_data;
@@ -600,21 +601,36 @@ void gpstate_timer_handler(unsigned long data)
 	if (!spin_trylock(&gpstates->gpstate_lock))
 		return;
 
+	/*
+	 * If PMCR was last updated was using fast_swtich then
+	 * We may have wrong in gpstate->last_lpstate_idx
+	 * value. Hence, read from PMCR to get correct data.
+	 */
+	val = get_pmspr(SPRN_PMCR);
+	freq_data.gpstate_id = (val >> (56)) & 0xFF;
+	freq_data.pstate_id = (val >> (48)) & 0xFF;
+	if (freq_data.gpstate_id  == freq_data.pstate_id) {
+		reset_gpstates(policy);
+		spin_unlock(&gpstates->gpstate_lock);
+		return;
+	}
+
 	gpstates->last_sampled_time += time_diff;
 	gpstates->elapsed_time += time_diff;
-	freq_data.pstate_id = idx_to_pstate(gpstates->last_lpstate_idx);
 
-	if ((gpstates->last_gpstate_idx == gpstates->last_lpstate_idx) ||
-	    (gpstates->elapsed_time > MAX_RAMP_DOWN_TIME)) {
+	if (gpstates->elapsed_time > MAX_RAMP_DOWN_TIME) {
 		gpstate_idx = pstate_to_idx(freq_data.pstate_id);
 		reset_gpstates(policy);
 		gpstates->highest_lpstate_idx = gpstate_idx;
 	} else {
+		lpstate_idx = pstate_to_idx(freq_data.pstate_id);
 		gpstate_idx = calc_global_pstate(gpstates->elapsed_time,
 						 gpstates->highest_lpstate_idx,
-						 gpstates->last_lpstate_idx);
+						 lpstate_idx);
 	}
-
+	freq_data.gpstate_id = idx_to_pstate(gpstate_idx);
+	gpstates->last_gpstate_idx = gpstate_idx;
+	gpstates->last_lpstate_idx = lpstate_idx;
 	/*
 	 * If local pstate is equal to global pstate, rampdown is over
 	 * So timer is not required to be queued.
@@ -622,10 +638,6 @@ void gpstate_timer_handler(unsigned long data)
 	if (gpstate_idx != gpstates->last_lpstate_idx)
 		queue_gpstate_timer(gpstates);
 
-	freq_data.gpstate_id = idx_to_pstate(gpstate_idx);
-	gpstates->last_gpstate_idx = pstate_to_idx(freq_data.gpstate_id);
-	gpstates->last_lpstate_idx = pstate_to_idx(freq_data.pstate_id);
-
 	spin_unlock(&gpstates->gpstate_lock);
 
 	/* Timer may get migrated to a different cpu on cpu hot unplug */
-- 
2.7.4
