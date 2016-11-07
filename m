Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC49z4b1pzDvdX
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 18:40:55 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA77eNen092193
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 02:40:53 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26jb76v824-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 02:40:53 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 17:39:20 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D5EBA2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 18:39:17 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA77dHFV16056530
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 18:39:17 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA77dHts030709
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 18:39:17 +1100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, shilpa.bhat@linux.vnet.ibm.com,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] cpufreq: powernv: Adding fast_switch for schedutil
Date: Mon,  7 Nov 2016 13:09:08 +0530
Message-Id: <1478504349-14796-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding fast_switch which does light weight operation to set the desired
pstate. Both global and local pstates are set to the same desired pstate.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
Changes from v1 :
- Removed unnecessary check for index out of bound.

 drivers/cpufreq/powernv-cpufreq.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index d3ffde8..4a4380d 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -752,9 +752,12 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	spin_lock_init(&gpstates->gpstate_lock);
 	ret = cpufreq_table_validate_and_show(policy, powernv_freqs);
 
-	if (ret < 0)
+	if (ret < 0) {
 		kfree(policy->driver_data);
+		return ret;
+	}
 
+	policy->fast_switch_possible = true;
 	return ret;
 }
 
@@ -897,6 +900,20 @@ static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 	del_timer_sync(&gpstates->timer);
 }
 
+static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
+					unsigned int target_freq)
+{
+	int index;
+	struct powernv_smp_call_data freq_data;
+
+	index = cpufreq_table_find_index_dl(policy, target_freq);
+	freq_data.pstate_id = powernv_freqs[index].driver_data;
+	freq_data.gpstate_id = powernv_freqs[index].driver_data;
+	set_pstate(&freq_data);
+
+	return powernv_freqs[index].frequency;
+}
+
 static struct cpufreq_driver powernv_cpufreq_driver = {
 	.name		= "powernv-cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
@@ -904,6 +921,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
 	.exit		= powernv_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= powernv_cpufreq_target_index,
+	.fast_switch	= powernv_fast_switch,
 	.get		= powernv_cpufreq_get,
 	.stop_cpu	= powernv_cpufreq_stop_cpu,
 	.attr		= powernv_cpu_freq_attr,
-- 
2.5.5
