Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9EE382C0142
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2014 19:34:08 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 3 Mar 2014 14:04:04 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 808B9E0057
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2014 14:07:40 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s238Y4t65177758
 for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2014 14:04:04 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s238Xxwc016643
 for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2014 14:04:00 +0530
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 1/4] powernv:cpufreq: Create pstate_id_to_freq() helper
Date: Mon,  3 Mar 2014 14:03:42 +0530
Message-Id: <1393835625-25102-2-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1393835625-25102-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1393835625-25102-1-git-send-email-ego@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Create a helper routine that can return the cpu-frequency for the
corresponding pstate_id.

Also, cache the values of the pstate_max, pstate_min and
pstate_nominal and nr_pstates in a static structure so that they can
be reused in the future to perform any validations.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 345501e..d0a8dee 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -37,6 +37,15 @@ static DEFINE_PER_CPU(struct mutex, freq_switch_lock);
 #define POWERNV_MAX_PSTATES	256
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
+struct powernv_pstate_info {
+	int pstate_min_id;
+	int pstate_max_id;
+	int pstate_nominal_id;
+	int nr_pstates;
+};
+
+static struct powernv_pstate_info powernv_pstate_info;
+
 
 /*
  * Initialize the freq table based on data obtained
@@ -106,9 +115,28 @@ static int init_powernv_pstates(void)
 	powernv_freqs[i].driver_data = 0;
 	powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
 
+	powernv_pstate_info.pstate_min_id = pstate_min;
+	powernv_pstate_info.pstate_max_id = pstate_max;
+	powernv_pstate_info.pstate_nominal_id = pstate_nominal;
+	powernv_pstate_info.nr_pstates = nr_pstates;
+
 	return 0;
 }
 
+/**
+ * Returns the cpu frequency corresponding to the pstate_id.
+ */
+static unsigned int pstate_id_to_freq(int pstate_id)
+{
+	int i;
+
+	i = powernv_pstate_info.pstate_max_id - pstate_id;
+
+	BUG_ON(i >= powernv_pstate_info.nr_pstates || i < 0);
+	WARN_ON(powernv_freqs[i].driver_data != pstate_id);
+	return powernv_freqs[i].frequency;
+}
+
 static struct freq_attr *powernv_cpu_freq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	NULL,
-- 
1.8.3.1
