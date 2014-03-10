Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45C3C2C00B9
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 22:11:33 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 10 Mar 2014 16:41:27 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 90B523940049
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:19 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2ABBNso000392
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:23 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2ABBIcY002925
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:18 +0530
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 2/6] powernv:cpufreq: Create a powernv_cpu_to_core_mask()
 helper.
Date: Mon, 10 Mar 2014 16:40:57 +0530
Message-Id: <1394449861-8688-3-git-send-email-ego@linux.vnet.ibm.com>
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

From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

Create a helper method that computes the cpumask corresponding to the
thread-siblings of a cpu. Use this for initializing the policy->cpus
mask for a given cpu.

(Original code written by Srivatsa S. Bhat. Gautham moved this to a
helper function!)

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index ab1551f..4cad727 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -115,6 +115,23 @@ static struct freq_attr *powernv_cpu_freq_attr[] = {
 
 /* Helper routines */
 
+/**
+ * Sets the bits corresponding to the thread-siblings of cpu in its core
+ * in 'cpus'.
+ */
+static void powernv_cpu_to_core_mask(unsigned int cpu, cpumask_var_t cpus)
+{
+	int base, i;
+
+	base = cpu_first_thread_sibling(cpu);
+
+	for (i = 0; i < threads_per_core; i++) {
+		cpumask_set_cpu(base + i, cpus);
+	}
+
+	return;
+}
+
 /* Access helpers to power mgt SPR */
 
 static inline unsigned long get_pmspr(unsigned long sprn)
@@ -180,13 +197,8 @@ static int powernv_set_freq(cpumask_var_t cpus, unsigned int new_index)
 
 static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	int base, i;
-
 #ifdef CONFIG_SMP
-	base = cpu_first_thread_sibling(policy->cpu);
-
-	for (i = 0; i < threads_per_core; i++)
-		cpumask_set_cpu(base + i, policy->cpus);
+	powernv_cpu_to_core_mask(policy->cpu, policy->cpus);
 #endif
 	policy->cpuinfo.transition_latency = 25000;
 
-- 
1.8.3.1
