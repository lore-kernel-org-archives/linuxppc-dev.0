Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 83003DDFF9
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:46:54 +1000 (EST)
Message-Id: <20070423193912.714569082@arndb.de>
References: <20070423193538.576702568@arndb.de>
Date: Mon, 23 Apr 2007 21:35:42 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 04/10] cell: use pmi in cpufreq driver
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Krafft <krafft@de.ibm.com>

The new PMI driver was added in order to support
cpufreq on blades that require the frequency to
be controlled by the service processor, so use it
on those.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linux-2.6/arch/powerpc/platforms/cell/cbe_cpufreq.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -28,6 +28,8 @@
 #include <asm/processor.h>
 #include <asm/prom.h>
 #include <asm/time.h>
+#include <asm/pmi.h>
+#include <asm/of_platform.h>
 
 #include "cbe_regs.h"
 
@@ -68,6 +70,38 @@ static u64 MIC_Slow_Next_Timer_table[] =
  * hardware specific functions
  */
 
+static struct of_device *pmi_dev;
+
+static int set_pmode_pmi(int cpu, unsigned int pmode)
+{
+	int ret;
+	pmi_message_t pmi_msg;
+#ifdef DEBUG
+	u64 time;
+#endif
+
+	pmi_msg.type = PMI_TYPE_FREQ_CHANGE;
+	pmi_msg.data1 =	cbe_cpu_to_node(cpu);
+	pmi_msg.data2 = pmode;
+
+#ifdef DEBUG
+	time = (u64) get_cycles();
+#endif
+
+	pmi_send_message(pmi_dev, pmi_msg);
+	ret = pmi_msg.data2;
+
+	pr_debug("PMI returned slow mode %d\n", ret);
+
+#ifdef DEBUG
+	time = (u64) get_cycles() - time; /* actual cycles (not cpu cycles!) */
+	time = 1000000000 * time / CLOCK_TICK_RATE; /* time in ns (10^-9) */
+	pr_debug("had to wait %lu ns for a transition\n", time);
+#endif
+	return ret;
+}
+
+
 static int get_pmode(int cpu)
 {
 	int ret;
@@ -79,7 +113,7 @@ static int get_pmode(int cpu)
 	return ret;
 }
 
-static int set_pmode(int cpu, unsigned int pmode)
+static int set_pmode_reg(int cpu, unsigned int pmode)
 {
 	struct cbe_pmd_regs __iomem *pmd_regs;
 	struct cbe_mic_tm_regs __iomem *mic_tm_regs;
@@ -120,6 +154,39 @@ static int set_pmode(int cpu, unsigned i
 	return 0;
 }
 
+static int set_pmode(int cpu, unsigned int slow_mode) {
+	if(pmi_dev)
+		return set_pmode_pmi(cpu, slow_mode);
+	else
+		return set_pmode_reg(cpu, slow_mode);
+}
+
+static void cbe_cpufreq_handle_pmi(struct of_device *dev, pmi_message_t pmi_msg)
+{
+	struct cpufreq_policy policy;
+	u8 cpu;
+	u8 cbe_pmode_new;
+
+	BUG_ON (pmi_msg.type != PMI_TYPE_FREQ_CHANGE);
+
+	cpu = cbe_node_to_cpu(pmi_msg.data1);
+	cbe_pmode_new = pmi_msg.data2;
+
+	cpufreq_get_policy(&policy, cpu);
+
+	policy.max = min(policy.max, cbe_freqs[cbe_pmode_new].frequency);
+	policy.min = min(policy.min, policy.max);
+
+	pr_debug("cbe_handle_pmi: new policy.min=%d policy.max=%d\n", policy.min, policy.max);
+	cpufreq_set_policy(&policy);
+}
+
+static struct pmi_handler cbe_pmi_handler = {
+	.type			= PMI_TYPE_FREQ_CHANGE,
+	.handle_pmi_message	= cbe_cpufreq_handle_pmi,
+};
+
+
 /*
  * cpufreq functions
  */
@@ -234,11 +301,23 @@ static struct cpufreq_driver cbe_cpufreq
 
 static int __init cbe_cpufreq_init(void)
 {
+	struct device_node *np;
+
+	np = of_find_node_by_type(NULL, "ibm,pmi");
+
+	pmi_dev = of_find_device_by_node(np);
+
+	if (pmi_dev)
+		pmi_register_handler(pmi_dev, &cbe_pmi_handler);
+
 	return cpufreq_register_driver(&cbe_cpufreq_driver);
 }
 
 static void __exit cbe_cpufreq_exit(void)
 {
+	if(pmi_dev)
+		pmi_unregister_handler(pmi_dev, &cbe_pmi_handler);
+
 	cpufreq_unregister_driver(&cbe_cpufreq_driver);
 }
 

--
