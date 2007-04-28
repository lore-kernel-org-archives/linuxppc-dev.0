Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 63CF4DE1BC
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 12:49:11 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] cell: cbe_cpufreq cleanup and crash fix
Date: Sat, 28 Apr 2007 04:49:03 +0200
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
In-Reply-To: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704280449.04126.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, Christian Krafft <krafft@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Olof Johansson <olof@lixom.net>
cbe_cpufreq cleanups:

* comment format
* whitespace
* don't init on non-cell platforms

Signed-off-by: Olof Johansson <olof@lixom.net>
Acked-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linux-2.6/arch/powerpc/platforms/cell/cbe_cpufreq.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -25,6 +25,7 @@
 
 #include <asm/hw_irq.h>
 #include <asm/io.h>
+#include <asm/machdep.h>
 #include <asm/processor.h>
 #include <asm/prom.h>
 #include <asm/time.h>
@@ -155,7 +156,7 @@ static int set_pmode_reg(int cpu, unsign
 }
 
 static int set_pmode(int cpu, unsigned int slow_mode) {
-	if(pmi_dev)
+	if (pmi_dev)
 		return set_pmode_pmi(cpu, slow_mode);
 	else
 		return set_pmode_reg(cpu, slow_mode);
@@ -167,7 +168,7 @@ static void cbe_cpufreq_handle_pmi(struc
 	u8 cpu;
 	u8 cbe_pmode_new;
 
-	BUG_ON (pmi_msg.type != PMI_TYPE_FREQ_CHANGE);
+	BUG_ON(pmi_msg.type != PMI_TYPE_FREQ_CHANGE);
 
 	cpu = cbe_node_to_cpu(pmi_msg.data1);
 	cbe_pmode_new = pmi_msg.data2;
@@ -191,7 +192,7 @@ static struct pmi_handler cbe_pmi_handle
  * cpufreq functions
  */
 
-static int cbe_cpufreq_cpu_init (struct cpufreq_policy *policy)
+static int cbe_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	const u32 *max_freqp;
 	u32 max_freq;
@@ -200,7 +201,7 @@ static int cbe_cpufreq_cpu_init (struct 
 
 	cpu = of_get_cpu_node(policy->cpu, NULL);
 
-	if(!cpu)
+	if (!cpu)
 		return -ENODEV;
 
 	pr_debug("init cpufreq on CPU %d\n", policy->cpu);
@@ -210,13 +211,13 @@ static int cbe_cpufreq_cpu_init (struct 
 	if (!max_freqp)
 		return -EINVAL;
 
-	// we need the freq in kHz
+	/* we need the freq in kHz */
 	max_freq = *max_freqp / 1000;
 
 	pr_debug("max clock-frequency is at %u kHz\n", max_freq);
 	pr_debug("initializing frequency table\n");
 
-	// initialize frequency table
+	/* initialize frequency table */
 	for (i=0; cbe_freqs[i].frequency!=CPUFREQ_TABLE_END; i++) {
 		cbe_freqs[i].frequency = max_freq / cbe_freqs[i].index;
 		pr_debug("%d: %d\n", i, cbe_freqs[i].frequency);
@@ -235,10 +236,10 @@ static int cbe_cpufreq_cpu_init (struct 
 	policy->cpus = cpu_sibling_map[policy->cpu];
 #endif
 
-	cpufreq_frequency_table_get_attr (cbe_freqs, policy->cpu);
+	cpufreq_frequency_table_get_attr(cbe_freqs, policy->cpu);
 
 	/* this ensures that policy->cpuinfo_min and policy->cpuinfo_max are set correctly */
-	return cpufreq_frequency_table_cpuinfo (policy, cbe_freqs);
+	return cpufreq_frequency_table_cpuinfo(policy, cbe_freqs);
 }
 
 static int cbe_cpufreq_cpu_exit(struct cpufreq_policy *policy)
@@ -270,7 +271,7 @@ static int cbe_cpufreq_target(struct cpu
 	freqs.new = cbe_freqs[cbe_pmode_new].frequency;
 	freqs.cpu = policy->cpu;
 
-	mutex_lock (&cbe_switch_mutex);
+	mutex_lock(&cbe_switch_mutex);
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
 	pr_debug("setting frequency for cpu %d to %d kHz, 1/%d of max frequency\n",
@@ -303,6 +304,9 @@ static int __init cbe_cpufreq_init(void)
 {
 	struct device_node *np;
 
+	if (!machine_is(cell))
+		return -ENODEV;
+
 	np = of_find_node_by_type(NULL, "ibm,pmi");
 
 	pmi_dev = of_find_device_by_node(np);
@@ -315,7 +319,7 @@ static int __init cbe_cpufreq_init(void)
 
 static void __exit cbe_cpufreq_exit(void)
 {
-	if(pmi_dev)
+	if (pmi_dev)
 		pmi_unregister_handler(pmi_dev, &cbe_pmi_handler);
 
 	cpufreq_unregister_driver(&cbe_cpufreq_driver);
