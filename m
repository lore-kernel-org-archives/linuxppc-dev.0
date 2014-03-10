Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3F24A2C0177
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 22:11:34 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 10 Mar 2014 16:41:28 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7F261125805D
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:43:38 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2ABBTmF2228598
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:29 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2ABBOEG003425
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2014 16:41:25 +0530
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 6/6] powernv:cpufreq: Implement the driver->get() method
Date: Mon, 10 Mar 2014 16:41:01 +0530
Message-Id: <1394449861-8688-7-git-send-email-ego@linux.vnet.ibm.com>
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

The current frequency of a cpu is reported through the sysfs file
cpuinfo_cur_freq. This requires the driver to implement a
"->get(unsigned int cpu)" method which will return the current
operating frequency.

Implement a function named powernv_cpufreq_get() which reads the local
pstate from the PMSR and returns the corresponding frequency.

Set the powernv_cpufreq_driver.get hook to powernv_cpufreq_get().

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 183bbc4..6f3b6e1 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -223,6 +223,53 @@ static inline void set_pmspr(unsigned long sprn, unsigned long val)
 	BUG();
 }
 
+/*
+ * Computes the current frequency on this cpu
+ * and stores the result in *ret_freq.
+ */
+static void powernv_read_cpu_freq(void *ret_freq)
+{
+	unsigned long pmspr_val;
+	s8 local_pstate_id;
+	int *cur_freq, freq, pstate_id;
+
+	cur_freq = (int *)ret_freq;
+	pmspr_val = get_pmspr(SPRN_PMSR);
+
+	/* The local pstate id corresponds bits 48..55 in the PMSR.
+         * Note: Watch out for the sign! */
+	local_pstate_id = (pmspr_val >> 48) & 0xFF;
+	pstate_id = local_pstate_id;
+
+	freq = pstate_id_to_freq(pstate_id);
+	pr_debug("cpu %d pmsr %lx pstate_id %d frequency %d \n",
+		smp_processor_id(), pmspr_val, pstate_id, freq);
+	*cur_freq = freq;
+}
+
+/*
+ * Returns the cpu frequency as reported by the firmware for 'cpu'.
+ * This value is reported through the sysfs file cpuinfo_cur_freq.
+ */
+unsigned int powernv_cpufreq_get(unsigned int cpu)
+{
+	int ret_freq;
+	cpumask_var_t sibling_mask;
+
+	if (unlikely(!zalloc_cpumask_var(&sibling_mask, GFP_KERNEL))) {
+		smp_call_function_single(cpu, powernv_read_cpu_freq,
+					&ret_freq, 1);
+		return ret_freq;
+	}
+
+	powernv_cpu_to_core_mask(cpu, sibling_mask);
+	smp_call_function_any(sibling_mask, powernv_read_cpu_freq,
+			&ret_freq, 1);
+
+	free_cpumask_var(sibling_mask);
+	return ret_freq;
+}
+
 static void set_pstate(void *pstate)
 {
 	unsigned long val;
@@ -309,6 +356,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
 static struct cpufreq_driver powernv_cpufreq_driver = {
 	.verify		= powernv_cpufreq_verify,
 	.target		= powernv_cpufreq_target,
+	.get		= powernv_cpufreq_get,
 	.init		= powernv_cpufreq_cpu_init,
 	.exit		= powernv_cpufreq_cpu_exit,
 	.name		= "powernv-cpufreq",
-- 
1.8.3.1
