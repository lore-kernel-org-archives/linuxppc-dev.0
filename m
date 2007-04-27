Return-Path: <olof@lixom.net>
Date: Fri, 27 Apr 2007 00:33:47 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] cell: cbe_cpufreq cleanup and crash fix
Message-ID: <20070427053347.GA7755@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<200704260147.35878.arnd@arndb.de>
	<20070426065644.GA24799@lixom.net>
	<20070426230754.GB30000@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070426230754.GB30000@lixom.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cbe_cpufreq cleanups:

* comment format
* whitespace
* don't init on non-cell platforms

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: powerpc/arch/powerpc/platforms/cell/cbe_cpufreq.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ powerpc/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -155,7 +155,7 @@ static int set_pmode_reg(int cpu, unsign
 }
 
 static int set_pmode(int cpu, unsigned int slow_mode) {
-	if(pmi_dev)
+	if (pmi_dev)
 		return set_pmode_pmi(cpu, slow_mode);
 	else
 		return set_pmode_reg(cpu, slow_mode);
@@ -167,7 +167,7 @@ static void cbe_cpufreq_handle_pmi(struc
 	u8 cpu;
 	u8 cbe_pmode_new;
 
-	BUG_ON (pmi_msg.type != PMI_TYPE_FREQ_CHANGE);
+	BUG_ON(pmi_msg.type != PMI_TYPE_FREQ_CHANGE);
 
 	cpu = cbe_node_to_cpu(pmi_msg.data1);
 	cbe_pmode_new = pmi_msg.data2;
@@ -191,7 +191,7 @@ static struct pmi_handler cbe_pmi_handle
  * cpufreq functions
  */
 
-static int cbe_cpufreq_cpu_init (struct cpufreq_policy *policy)
+static int cbe_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	const u32 *max_freqp;
 	u32 max_freq;
@@ -200,7 +200,7 @@ static int cbe_cpufreq_cpu_init (struct 
 
 	cpu = of_get_cpu_node(policy->cpu, NULL);
 
-	if(!cpu)
+	if (!cpu)
 		return -ENODEV;
 
 	pr_debug("init cpufreq on CPU %d\n", policy->cpu);
@@ -210,13 +210,13 @@ static int cbe_cpufreq_cpu_init (struct 
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
@@ -235,10 +235,10 @@ static int cbe_cpufreq_cpu_init (struct 
 	policy->cpus = cpu_sibling_map[policy->cpu];
 #endif
 
-	cpufreq_frequency_table_get_attr (cbe_freqs, policy->cpu);
+	cpufreq_frequency_table_get_attr(cbe_freqs, policy->cpu);
 
 	/* this ensures that policy->cpuinfo_min and policy->cpuinfo_max are set correctly */
-	return cpufreq_frequency_table_cpuinfo (policy, cbe_freqs);
+	return cpufreq_frequency_table_cpuinfo(policy, cbe_freqs);
 }
 
 static int cbe_cpufreq_cpu_exit(struct cpufreq_policy *policy)
@@ -270,7 +270,7 @@ static int cbe_cpufreq_target(struct cpu
 	freqs.new = cbe_freqs[cbe_pmode_new].frequency;
 	freqs.cpu = policy->cpu;
 
-	mutex_lock (&cbe_switch_mutex);
+	mutex_lock(&cbe_switch_mutex);
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
 	pr_debug("setting frequency for cpu %d to %d kHz, 1/%d of max frequency\n",
@@ -303,6 +303,9 @@ static int __init cbe_cpufreq_init(void)
 {
 	struct device_node *np;
 
+	if (!machine_is(cell))
+		return -ENODEV;
+
 	np = of_find_node_by_type(NULL, "ibm,pmi");
 
 	pmi_dev = of_find_device_by_node(np);
@@ -315,7 +318,7 @@ static int __init cbe_cpufreq_init(void)
 
 static void __exit cbe_cpufreq_exit(void)
 {
-	if(pmi_dev)
+	if (pmi_dev)
 		pmi_unregister_handler(pmi_dev, &cbe_pmi_handler);
 
 	cpufreq_unregister_driver(&cbe_cpufreq_driver);
