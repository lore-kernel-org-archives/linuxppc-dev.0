Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynPv60x49zDrp4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 15:44:17 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAU4his3105259
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 23:44:14 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ej8ygcdcj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 23:44:14 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 30 Nov 2017 04:44:11 -0000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, viresh.kumar@linaro.org, svaidy@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Define methods to parse positive & negative
 pstates
Date: Thu, 30 Nov 2017 10:13:38 +0530
Message-Id: <1512017018-4857-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Pstates are 8bit values but on POWER8 they are negative and on POWER9
they are positive. This patch adds helper routines to differentiate
the sign to read the correct pstate value.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 43 ++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index b6d7c4c..bb7586e 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -41,11 +41,14 @@
 #define POWERNV_MAX_PSTATES	256
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
 #define PMSR_SPR_EM_DISABLE	(1UL << 31)
-#define PMSR_MAX(x)		((x >> 32) & 0xFF)
+#define EXTRACT_BYTE(x, shift)	(((x) >> shift) & 0xFF)
+#define MAX_SHIFT		32
 #define LPSTATE_SHIFT		48
 #define GPSTATE_SHIFT		56
-#define GET_LPSTATE(x)		(((x) >> LPSTATE_SHIFT) & 0xFF)
-#define GET_GPSTATE(x)		(((x) >> GPSTATE_SHIFT) & 0xFF)
+#define GET_PMSR_MAX(x)		EXTRACT_BYTE(x, MAX_SHIFT)
+#define GET_LPSTATE(x)		EXTRACT_BYTE(x, LPSTATE_SHIFT)
+#define GET_GPSTATE(x)		EXTRACT_BYTE(x, GPSTATE_SHIFT)
+
 
 #define MAX_RAMP_DOWN_TIME				5120
 /*
@@ -64,6 +67,12 @@
 
 /* Interval after which the timer is queued to bring down global pstate */
 #define GPSTATE_TIMER_INTERVAL				2000
+/*
+ * On POWER8 the pstates are negatively numbered. On POWER9, they are
+ * positively numbered.  Use this flag to track whether we have
+ * positive or negative numbered pstates.
+ */
+static bool pos_pstates;
 
 /**
  * struct global_pstate_info -	Per policy data structure to maintain history of
@@ -164,7 +173,7 @@ static inline unsigned int pstate_to_idx(int pstate)
 	int min = powernv_freqs[powernv_pstate_info.min].driver_data;
 	int max = powernv_freqs[powernv_pstate_info.max].driver_data;
 
-	if (min > 0) {
+	if (pos_pstates) {
 		if (unlikely((pstate < max) || (pstate > min))) {
 			pr_warn_once("pstate %d is out of bound\n", pstate);
 			return powernv_pstate_info.nominal;
@@ -301,6 +310,9 @@ static int init_powernv_pstates(void)
 		}
 	}
 
+	if ((int)pstate_min > 0)
+		pos_pstates = true;
+
 	/* End of list marker entry */
 	powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
 	return 0;
@@ -438,7 +450,6 @@ struct powernv_smp_call_data {
 static void powernv_read_cpu_freq(void *arg)
 {
 	unsigned long pmspr_val;
-	s8 local_pstate_id;
 	struct powernv_smp_call_data *freq_data = arg;
 
 	pmspr_val = get_pmspr(SPRN_PMSR);
@@ -447,8 +458,11 @@ static void powernv_read_cpu_freq(void *arg)
 	 * The local pstate id corresponds bits 48..55 in the PMSR.
 	 * Note: Watch out for the sign!
 	 */
-	local_pstate_id = (pmspr_val >> 48) & 0xFF;
-	freq_data->pstate_id = local_pstate_id;
+	if (pos_pstates)
+		freq_data->pstate_id = (u8)GET_LPSTATE(pmspr_val);
+	else
+		freq_data->pstate_id = (s8)GET_LPSTATE(pmspr_val);
+
 	freq_data->freq = pstate_id_to_freq(freq_data->pstate_id);
 
 	pr_debug("cpu %d pmsr %016lX pstate_id %d frequency %d kHz\n",
@@ -522,7 +536,10 @@ static void powernv_cpufreq_throttle_check(void *data)
 	chip = this_cpu_read(chip_info);
 
 	/* Check for Pmax Capping */
-	pmsr_pmax = (s8)PMSR_MAX(pmsr);
+	if (pos_pstates)
+		pmsr_pmax = (u8)GET_PMSR_MAX(pmsr);
+	else
+		pmsr_pmax = (s8)GET_PMSR_MAX(pmsr);
 	pmsr_pmax_idx = pstate_to_idx(pmsr_pmax);
 	if (pmsr_pmax_idx != powernv_pstate_info.max) {
 		if (chip->throttled)
@@ -645,8 +662,14 @@ void gpstate_timer_handler(struct timer_list *t)
 	 * value. Hence, read from PMCR to get correct data.
 	 */
 	val = get_pmspr(SPRN_PMCR);
-	freq_data.gpstate_id = (s8)GET_GPSTATE(val);
-	freq_data.pstate_id = (s8)GET_LPSTATE(val);
+	if (pos_pstates) {
+		freq_data.gpstate_id = (u8)GET_GPSTATE(val);
+		freq_data.pstate_id = (u8)GET_LPSTATE(val);
+	} else {
+		freq_data.gpstate_id = (s8)GET_GPSTATE(val);
+		freq_data.pstate_id = (s8)GET_LPSTATE(val);
+	}
+
 	if (freq_data.gpstate_id  == freq_data.pstate_id) {
 		reset_gpstates(policy);
 		spin_unlock(&gpstates->gpstate_lock);
-- 
1.8.3.1
