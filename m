Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zg1t56k0KzF0lN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 21:21:30 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1CAJVJT059216
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 05:21:28 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g338fku6w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 05:21:28 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 12 Feb 2018 10:21:25 -0000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Check negative value returned by
 cpufreq_table_find_index_dl()
Date: Mon, 12 Feb 2018 15:51:16 +0530
Message-Id: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes the below Coverity warning:

*** CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
/drivers/cpufreq/powernv-cpufreq.c: 1008 in powernv_fast_switch()
1002     					unsigned int target_freq)
1003     {
1004     	int index;
1005     	struct powernv_smp_call_data freq_data;
1006
1007     	index = cpufreq_table_find_index_dl(policy, target_freq);
>>>     CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>>>     Using variable "index" as an index to array "powernv_freqs".
1008     	freq_data.pstate_id = powernv_freqs[index].driver_data;
1009     	freq_data.gpstate_id = powernv_freqs[index].driver_data;
1010     	set_pstate(&freq_data);
1011
1012     	return powernv_freqs[index].frequency;
1013     }

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 29cdec1..69edfe9 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -1005,6 +1005,9 @@ static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
 	struct powernv_smp_call_data freq_data;
 
 	index = cpufreq_table_find_index_dl(policy, target_freq);
+	if (unlikely(index < 0))
+		index = get_nominal_index();
+
 	freq_data.pstate_id = powernv_freqs[index].driver_data;
 	freq_data.gpstate_id = powernv_freqs[index].driver_data;
 	set_pstate(&freq_data);
-- 
1.8.3.1
