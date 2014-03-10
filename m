Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DC9DB2C018E
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 22:11:35 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 10 Mar 2014 16:41:26 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2B89E3940061
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:24 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2ABBK3W23330944
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:21 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2ABBMZ8003264
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:22 +0530
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 4/6] powernv:cpufreq: Create pstate_id_to_freq() helper
Date: Mon, 10 Mar 2014 16:40:59 +0530
Message-Id: <1394449861-8688-5-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1394449861-8688-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1394449861-8688-1-git-send-email-ego@linux.vnet.ibm.com>
Cc: srivatsa.bhat@linux.vnet.ibm.com,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
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
 drivers/cpufreq/powernv-cpufreq.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 4c2e8ca..0ecd163 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -39,6 +39,14 @@ static DEFINE_PER_CPU(struct mutex, freq_switch_lock);
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 static int powernv_pstate_ids[POWERNV_MAX_PSTATES+1];
 
+struct powernv_pstate_info {
+	int pstate_min_id;
+	int pstate_max_id;
+	int pstate_nominal_id;
+	int nr_pstates;
+};
+static struct powernv_pstate_info powernv_pstate_info;
+
 /*
  * Initialize the freq table based on data obtained
  * from the firmware passed via device-tree
@@ -112,9 +120,28 @@ static int init_powernv_pstates(void)
 	for (i = 0; powernv_freqs[i].frequency != CPUFREQ_TABLE_END; i++)
 		pr_debug("%d: %d\n", i, powernv_freqs[i].frequency);
 
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
+	WARN_ON(powernv_pstate_ids[i] != pstate_id);
+	return powernv_freqs[i].frequency;
+}
+
 static struct freq_attr *powernv_cpu_freq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	NULL,
-- 
1.8.3.1
