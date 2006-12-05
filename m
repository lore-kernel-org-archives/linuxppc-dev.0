Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 05 Dec 2006 17:52:39 +1100
Subject: [PATCH 5/5] Cleanup pass over platforms/pseries/hotplug-cpu.c
In-Reply-To: <1165301556.843426.760217571714.qpush@cradle>
Message-Id: <20061205065237.9F25C67C01@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Purely cosmetic. Change pSeries to pseries inline with other parts of the
kernel, and fix an overly long line.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/hotplug-cpu.c |   29 +++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -53,7 +53,7 @@ static void rtas_stop_self(void)
 	panic("Alas, I survived.\n");
 }
 
-static void pSeries_mach_cpu_die(void)
+static void pseries_mach_cpu_die(void)
 {
 	local_irq_disable();
 	idle_task_exit();
@@ -88,7 +88,7 @@ static int query_cpu_stopped(unsigned in
 	return cpu_status;
 }
 
-static int pSeries_cpu_disable(void)
+static int pseries_cpu_disable(void)
 {
 	int cpu = smp_processor_id();
 
@@ -104,7 +104,7 @@ static int pSeries_cpu_disable(void)
 	return 0;
 }
 
-static void pSeries_cpu_die(unsigned int cpu)
+static void pseries_cpu_die(unsigned int cpu)
 {
 	int tries;
 	int cpu_status;
@@ -136,7 +136,7 @@ static void pSeries_cpu_die(unsigned int
  * the logical ids for sibling SMT threads x and y are adjacent, such
  * that x^1 == y and y^1 == x.
  */
-static int pSeries_add_processor(struct device_node *np)
+static int pseries_add_processor(struct device_node *np)
 {
 	unsigned int cpu;
 	cpumask_t candidate_map, tmp = CPU_MASK_NONE;
@@ -197,7 +197,7 @@ out_unlock:
  * the hard id in the paca(s) to -1 to be consistent with boot time
  * convention for non-present cpus.
  */
-static void pSeries_remove_processor(struct device_node *np)
+static void pseries_remove_processor(struct device_node *np)
 {
 	unsigned int cpu;
 	int len, nthreads, i;
@@ -226,17 +226,18 @@ static void pSeries_remove_processor(str
 	unlock_cpu_hotplug();
 }
 
-static int pSeries_smp_notifier(struct notifier_block *nb, unsigned long action, void *node)
+static int pseries_smp_notifier(struct notifier_block *nb,
+				unsigned long action, void *node)
 {
 	int err = NOTIFY_OK;
 
 	switch (action) {
 	case PSERIES_RECONFIG_ADD:
-		if (pSeries_add_processor(node))
+		if (pseries_add_processor(node))
 			err = NOTIFY_BAD;
 		break;
 	case PSERIES_RECONFIG_REMOVE:
-		pSeries_remove_processor(node);
+		pseries_remove_processor(node);
 		break;
 	default:
 		err = NOTIFY_DONE;
@@ -245,8 +246,8 @@ static int pSeries_smp_notifier(struct n
 	return err;
 }
 
-static struct notifier_block pSeries_smp_nb = {
-	.notifier_call = pSeries_smp_notifier,
+static struct notifier_block pseries_smp_nb = {
+	.notifier_call = pseries_smp_notifier,
 };
 
 static int __init pseries_cpu_hotplug_init(void)
@@ -261,13 +262,13 @@ static int __init pseries_cpu_hotplug_in
 		return 0;
 	}
 
-	ppc_md.cpu_die = pSeries_mach_cpu_die;
-	smp_ops->cpu_disable = pSeries_cpu_disable;
-	smp_ops->cpu_die = pSeries_cpu_die;
+	ppc_md.cpu_die = pseries_mach_cpu_die;
+	smp_ops->cpu_disable = pseries_cpu_disable;
+	smp_ops->cpu_die = pseries_cpu_die;
 
 	/* Processors can be added/removed only on LPAR */
 	if (firmware_has_feature(FW_FEATURE_LPAR))
-		pSeries_reconfig_notifier_register(&pSeries_smp_nb);
+		pSeries_reconfig_notifier_register(&pseries_smp_nb);
 
 	return 0;
 }
