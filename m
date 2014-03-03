Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43CBE2C00D5
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2014 19:34:09 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 3 Mar 2014 14:04:06 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 41A8DE005C
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2014 14:07:40 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s238Y6ZS63766588
 for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2014 14:04:06 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s238Y0cH016684
 for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2014 14:04:02 +0530
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 4/4] powernv:cpufreq: Implement the driver->get() method
Date: Mon,  3 Mar 2014 14:03:45 +0530
Message-Id: <1393835625-25102-5-git-send-email-ego@linux.vnet.ibm.com>
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

The current frequency of a cpu is reported through the sysfs file
cpuinfo_cur_freq. This requires the driver to implement a
"->get(unsigned int cpu)" method which will return the current
operating frequency.

Implement a function named powernv_cpufreq_get() which corresponds to
the required ->get() method.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index f0dae6f..5f43e4f 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -218,6 +218,46 @@ static inline void set_pmspr(unsigned long sprn, unsigned long val)
 	BUG();
 }
 
+/**
+ * Computes the current frequency on this cpu
+ * and stores the result in *ret_freq.
+ */
+static void powernv_get_cpu_freq(void *ret_freq)
+{
+	unsigned long pmspr_val;
+	long pstate_id;
+	int *cur_freq, freq;
+
+	cur_freq = (int *)ret_freq;
+	pmspr_val = get_pmspr(SPRN_PMSR);
+	pstate_id = pmspr_val;
+	pstate_id = pstate_id >> 56;
+	WARN_ON(pstate_id > 0);
+	freq = pstate_id_to_freq(pstate_id);
+	pr_debug("cpu %d pmsr %lx pstate_id %ld frequency %d \n",
+		smp_processor_id(), pmspr_val, pstate_id, freq);
+	*cur_freq = freq;
+}
+
+/**
+ * Returns the cpu frequency as reported by the firmware for 'cpu'.
+ * This value is reported through the sysfs file cpuinfo_cur_freq.
+ */
+unsigned int powernv_cpufreq_get(unsigned int cpu)
+{
+	int ret_freq;
+	cpumask_var_t sibling_mask;
+
+	if (!zalloc_cpumask_var(&sibling_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	powernv_cpu_to_core_mask(cpu, sibling_mask);
+	smp_call_function_any(sibling_mask, powernv_get_cpu_freq, &ret_freq, 1);
+
+	free_cpumask_var(sibling_mask);
+	return ret_freq;
+}
+
 static void set_pstate(void *pstate)
 {
 	unsigned long val;
@@ -310,6 +350,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
 static struct cpufreq_driver powernv_cpufreq_driver = {
 	.verify		= powernv_cpufreq_verify,
 	.target		= powernv_cpufreq_target,
+	.get		= powernv_cpufreq_get,
 	.init		= powernv_cpufreq_cpu_init,
 	.exit		= powernv_cpufreq_cpu_exit,
 	.name		= "powernv-cpufreq",
-- 
1.8.3.1
