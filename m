Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3FF432C00D5
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2014 19:34:07 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 3 Mar 2014 14:04:04 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5BDA53940049
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2014 14:04:02 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s238XxPk9372022
 for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2014 14:03:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s238Y0AZ016660
 for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2014 14:04:02 +0530
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 3/4] powernv:cpufreq: Create a powernv_cpu_to_core_mask()
 helper.
Date: Mon,  3 Mar 2014 14:03:44 +0530
Message-Id: <1393835625-25102-4-git-send-email-ego@linux.vnet.ibm.com>
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

Move the code that computes the cpumask corresponding to the
thread-siblings of a cpu to a new method named
powernv_cpu_to_core_mask() so that it can be used by other places in
the code.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index c59eb26..f0dae6f 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -166,6 +166,23 @@ static struct freq_attr *powernv_cpu_freq_attr[] = {
 
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
@@ -231,13 +248,10 @@ static int powernv_set_freq(cpumask_var_t cpus, unsigned int new_index)
 
 static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	int base, i;
+	int i;
 
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
