Return-Path: <arnd@arndb.de>
Message-Id: <20070604181739.503060562@arndb.de>
References: <20070604181438.569356702@arndb.de>
Date: Mon, 04 Jun 2007 20:14:40 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [patch 2/3] cbe_cpufreq: limit frequency via cpufreq notifier chain
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Christian Krafft <krafft@de.ibm.com>, cbe-oss-dev@ozlabs.org,
	Thomas Renninger <trenn@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Thomas Renninger <trenn@suse.de>
and get rid of cpufreq_set_policy call that caused a build
failure due interfering commits

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
 arch/powerpc/platforms/cell/cbe_cpufreq.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/cell/cbe_cpufreq.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -67,6 +67,7 @@ static u64 MIC_Slow_Next_Timer_table[] =
 	0x00003FC000000000ull,
 };
 
+static unsigned int pmi_frequency_limit = 0;
 /*
  * hardware specific functions
  */
@@ -164,7 +165,6 @@ static int set_pmode(int cpu, unsigned i
 
 static void cbe_cpufreq_handle_pmi(struct of_device *dev, pmi_message_t pmi_msg)
 {
-	struct cpufreq_policy policy;
 	u8 cpu;
 	u8 cbe_pmode_new;
 
@@ -173,15 +173,27 @@ static void cbe_cpufreq_handle_pmi(struc
 	cpu = cbe_node_to_cpu(pmi_msg.data1);
 	cbe_pmode_new = pmi_msg.data2;
 
-	cpufreq_get_policy(&policy, cpu);
+	pmi_frequency_limit = cbe_freqs[cbe_pmode_new].frequency;
 
-	policy.max = min(policy.max, cbe_freqs[cbe_pmode_new].frequency);
-	policy.min = min(policy.min, policy.max);
+	pr_debug("cbe_handle_pmi: max freq=%d\n", pmi_frequency_limit);
+}
+
+static int pmi_notifier(struct notifier_block *nb,
+				       unsigned long event, void *data)
+{
+	struct cpufreq_policy *policy = data;
 
-	pr_debug("cbe_handle_pmi: new policy.min=%d policy.max=%d\n", policy.min, policy.max);
-	cpufreq_set_policy(&policy);
+	if (event != CPUFREQ_INCOMPATIBLE)
+		return 0;
+
+	cpufreq_verify_within_limits(policy, 0, pmi_frequency_limit);
+	return 0;
 }
 
+static struct notifier_block pmi_notifier_block = {
+	.notifier_call = pmi_notifier,
+};
+
 static struct pmi_handler cbe_pmi_handler = {
 	.type			= PMI_TYPE_FREQ_CHANGE,
 	.handle_pmi_message	= cbe_cpufreq_handle_pmi,
@@ -238,12 +250,21 @@ static int cbe_cpufreq_cpu_init(struct c
 
 	cpufreq_frequency_table_get_attr(cbe_freqs, policy->cpu);
 
+	if (pmi_dev) {
+		/* frequency might get limited later, initialize limit with max_freq */
+		pmi_frequency_limit = max_freq;
+		cpufreq_register_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER);
+	}
+
 	/* this ensures that policy->cpuinfo_min and policy->cpuinfo_max are set correctly */
 	return cpufreq_frequency_table_cpuinfo(policy, cbe_freqs);
 }
 
 static int cbe_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
+	if (pmi_dev)
+		cpufreq_unregister_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER);
+
 	cpufreq_frequency_table_put_attr(policy->cpu);
 	return 0;
 }

--
