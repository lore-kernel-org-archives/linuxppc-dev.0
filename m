Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 05 Dec 2006 17:52:38 +1100
Subject: [PATCH 3/5] Move the rest of the hotplug cpu code into
	platforms/pseries/hotplug-cpu.c
In-Reply-To: <1165301556.843426.760217571714.qpush@cradle>
Message-Id: <20061205065236.21BEC67B6C@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move the rest of the hotplug cpu code from platforms/pseries/smp.c into
platforms/pseries/hotplug-cpu.c.

Wire up the smp_ops callbacks and the notifier in the hotplug cpu initcall,
rather than in smp_init_pseries(). No change in behaviour.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/hotplug-cpu.c |  201 ++++++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/smp.c         |  200 --------------------------
 2 files changed, 199 insertions(+), 202 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -1,11 +1,14 @@
 /*
  * pseries CPU Hotplug infrastructure.
  *
- * Split out from arch/powerpc/platforms/pseries/setup.c and
- *  arch/powerpc/kernel/rtas.c
+ * Split out from arch/powerpc/platforms/pseries/setup.c
+ *  arch/powerpc/kernel/rtas.c, and arch/powerpc/platforms/pseries/smp.c
  *
  * Peter Bergner, IBM	March 2001.
  * Copyright (C) 2001 IBM.
+ * Dave Engebretsen, Peter Bergner, and
+ * Mike Corrigan {engebret|bergner|mikec}@us.ibm.com
+ * Plus various changes from other IBM teams...
  *
  * Copyright (C) 2006 Michael Ellerman, IBM Corporation
  *
@@ -61,12 +64,206 @@ static void pSeries_mach_cpu_die(void)
 	for(;;);
 }
 
+/* Get state of physical CPU.
+ * Return codes:
+ *	0	- The processor is in the RTAS stopped state
+ *	1	- stop-self is in progress
+ *	2	- The processor is not in the RTAS stopped state
+ *	-1	- Hardware Error
+ *	-2	- Hardware Busy, Try again later.
+ */
+static int query_cpu_stopped(unsigned int pcpu)
+{
+	int cpu_status;
+	int status, qcss_tok;
+
+	qcss_tok = rtas_token("query-cpu-stopped-state");
+	if (qcss_tok == RTAS_UNKNOWN_SERVICE)
+		return -1;
+	status = rtas_call(qcss_tok, 1, 2, &cpu_status, pcpu);
+	if (status != 0) {
+		printk(KERN_ERR
+		       "RTAS query-cpu-stopped-state failed: %i\n", status);
+		return status;
+	}
+
+	return cpu_status;
+}
+
+static int pSeries_cpu_disable(void)
+{
+	int cpu = smp_processor_id();
+
+	cpu_clear(cpu, cpu_online_map);
+	vdso_data->processorCount--;
+
+	/*fix boot_cpuid here*/
+	if (cpu == boot_cpuid)
+		boot_cpuid = any_online_cpu(cpu_online_map);
+
+	/* FIXME: abstract this to not be platform specific later on */
+	xics_migrate_irqs_away();
+	return 0;
+}
+
+static void pSeries_cpu_die(unsigned int cpu)
+{
+	int tries;
+	int cpu_status;
+	unsigned int pcpu = get_hard_smp_processor_id(cpu);
+
+	for (tries = 0; tries < 25; tries++) {
+		cpu_status = query_cpu_stopped(pcpu);
+		if (cpu_status == 0 || cpu_status == -1)
+			break;
+		msleep(200);
+	}
+	if (cpu_status != 0) {
+		printk("Querying DEAD? cpu %i (%i) shows %i\n",
+		       cpu, pcpu, cpu_status);
+	}
+
+	/* Isolation and deallocation are definatly done by
+	 * drslot_chrp_cpu.  If they were not they would be
+	 * done here.  Change isolate state to Isolate and
+	 * change allocation-state to Unusable.
+	 */
+	paca[cpu].cpu_start = 0;
+}
+
+/*
+ * Update cpu_present_map and paca(s) for a new cpu node.  The wrinkle
+ * here is that a cpu device node may represent up to two logical cpus
+ * in the SMT case.  We must honor the assumption in other code that
+ * the logical ids for sibling SMT threads x and y are adjacent, such
+ * that x^1 == y and y^1 == x.
+ */
+static int pSeries_add_processor(struct device_node *np)
+{
+	unsigned int cpu;
+	cpumask_t candidate_map, tmp = CPU_MASK_NONE;
+	int err = -ENOSPC, len, nthreads, i;
+	const u32 *intserv;
+
+	intserv = get_property(np, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv)
+		return 0;
+
+	nthreads = len / sizeof(u32);
+	for (i = 0; i < nthreads; i++)
+		cpu_set(i, tmp);
+
+	lock_cpu_hotplug();
+
+	BUG_ON(!cpus_subset(cpu_present_map, cpu_possible_map));
+
+	/* Get a bitmap of unoccupied slots. */
+	cpus_xor(candidate_map, cpu_possible_map, cpu_present_map);
+	if (cpus_empty(candidate_map)) {
+		/* If we get here, it most likely means that NR_CPUS is
+		 * less than the partition's max processors setting.
+		 */
+		printk(KERN_ERR "Cannot add cpu %s; this system configuration"
+		       " supports %d logical cpus.\n", np->full_name,
+		       cpus_weight(cpu_possible_map));
+		goto out_unlock;
+	}
+
+	while (!cpus_empty(tmp))
+		if (cpus_subset(tmp, candidate_map))
+			/* Found a range where we can insert the new cpu(s) */
+			break;
+		else
+			cpus_shift_left(tmp, tmp, nthreads);
+
+	if (cpus_empty(tmp)) {
+		printk(KERN_ERR "Unable to find space in cpu_present_map for"
+		       " processor %s with %d thread(s)\n", np->name,
+		       nthreads);
+		goto out_unlock;
+	}
+
+	for_each_cpu_mask(cpu, tmp) {
+		BUG_ON(cpu_isset(cpu, cpu_present_map));
+		cpu_set(cpu, cpu_present_map);
+		set_hard_smp_processor_id(cpu, *intserv++);
+	}
+	err = 0;
+out_unlock:
+	unlock_cpu_hotplug();
+	return err;
+}
+
+/*
+ * Update the present map for a cpu node which is going away, and set
+ * the hard id in the paca(s) to -1 to be consistent with boot time
+ * convention for non-present cpus.
+ */
+static void pSeries_remove_processor(struct device_node *np)
+{
+	unsigned int cpu;
+	int len, nthreads, i;
+	const u32 *intserv;
+
+	intserv = get_property(np, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv)
+		return;
+
+	nthreads = len / sizeof(u32);
+
+	lock_cpu_hotplug();
+	for (i = 0; i < nthreads; i++) {
+		for_each_present_cpu(cpu) {
+			if (get_hard_smp_processor_id(cpu) != intserv[i])
+				continue;
+			BUG_ON(cpu_online(cpu));
+			cpu_clear(cpu, cpu_present_map);
+			set_hard_smp_processor_id(cpu, -1);
+			break;
+		}
+		if (cpu == NR_CPUS)
+			printk(KERN_WARNING "Could not find cpu to remove "
+			       "with physical id 0x%x\n", intserv[i]);
+	}
+	unlock_cpu_hotplug();
+}
+
+static int pSeries_smp_notifier(struct notifier_block *nb, unsigned long action, void *node)
+{
+	int err = NOTIFY_OK;
+
+	switch (action) {
+	case PSERIES_RECONFIG_ADD:
+		if (pSeries_add_processor(node))
+			err = NOTIFY_BAD;
+		break;
+	case PSERIES_RECONFIG_REMOVE:
+		pSeries_remove_processor(node);
+		break;
+	default:
+		err = NOTIFY_DONE;
+		break;
+	}
+	return err;
+}
+
+static struct notifier_block pSeries_smp_nb = {
+	.notifier_call = pSeries_smp_notifier,
+};
+
 static int __init pseries_cpu_hotplug_init(void)
 {
 	rtas_stop_self_args.token = rtas_token("stop-self");
 
 	ppc_md.cpu_die = pSeries_mach_cpu_die;
 
+	smp_ops->cpu_disable = pSeries_cpu_disable;
+	smp_ops->cpu_die = pSeries_cpu_die;
+
+	/* Processors can be added/removed only on LPAR */
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		pSeries_reconfig_notifier_register(&pSeries_smp_nb);
+
 	return 0;
 }
 arch_initcall(pseries_cpu_hotplug_init);
Index: powerpc/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/smp.c
+++ powerpc/arch/powerpc/platforms/pseries/smp.c
@@ -64,197 +64,6 @@ static cpumask_t of_spin_map;
 
 extern void generic_secondary_smp_init(unsigned long);
 
-#ifdef CONFIG_HOTPLUG_CPU
-
-/* Get state of physical CPU.
- * Return codes:
- *	0	- The processor is in the RTAS stopped state
- *	1	- stop-self is in progress
- *	2	- The processor is not in the RTAS stopped state
- *	-1	- Hardware Error
- *	-2	- Hardware Busy, Try again later.
- */
-static int query_cpu_stopped(unsigned int pcpu)
-{
-	int cpu_status;
-	int status, qcss_tok;
-
-	qcss_tok = rtas_token("query-cpu-stopped-state");
-	if (qcss_tok == RTAS_UNKNOWN_SERVICE)
-		return -1;
-	status = rtas_call(qcss_tok, 1, 2, &cpu_status, pcpu);
-	if (status != 0) {
-		printk(KERN_ERR
-		       "RTAS query-cpu-stopped-state failed: %i\n", status);
-		return status;
-	}
-
-	return cpu_status;
-}
-
-static int pSeries_cpu_disable(void)
-{
-	int cpu = smp_processor_id();
-
-	cpu_clear(cpu, cpu_online_map);
-	vdso_data->processorCount--;
-
-	/*fix boot_cpuid here*/
-	if (cpu == boot_cpuid)
-		boot_cpuid = any_online_cpu(cpu_online_map);
-
-	/* FIXME: abstract this to not be platform specific later on */
-	xics_migrate_irqs_away();
-	return 0;
-}
-
-static void pSeries_cpu_die(unsigned int cpu)
-{
-	int tries;
-	int cpu_status;
-	unsigned int pcpu = get_hard_smp_processor_id(cpu);
-
-	for (tries = 0; tries < 25; tries++) {
-		cpu_status = query_cpu_stopped(pcpu);
-		if (cpu_status == 0 || cpu_status == -1)
-			break;
-		msleep(200);
-	}
-	if (cpu_status != 0) {
-		printk("Querying DEAD? cpu %i (%i) shows %i\n",
-		       cpu, pcpu, cpu_status);
-	}
-
-	/* Isolation and deallocation are definatly done by
-	 * drslot_chrp_cpu.  If they were not they would be
-	 * done here.  Change isolate state to Isolate and
-	 * change allocation-state to Unusable.
-	 */
-	paca[cpu].cpu_start = 0;
-}
-
-/*
- * Update cpu_present_map and paca(s) for a new cpu node.  The wrinkle
- * here is that a cpu device node may represent up to two logical cpus
- * in the SMT case.  We must honor the assumption in other code that
- * the logical ids for sibling SMT threads x and y are adjacent, such
- * that x^1 == y and y^1 == x.
- */
-static int pSeries_add_processor(struct device_node *np)
-{
-	unsigned int cpu;
-	cpumask_t candidate_map, tmp = CPU_MASK_NONE;
-	int err = -ENOSPC, len, nthreads, i;
-	const u32 *intserv;
-
-	intserv = get_property(np, "ibm,ppc-interrupt-server#s", &len);
-	if (!intserv)
-		return 0;
-
-	nthreads = len / sizeof(u32);
-	for (i = 0; i < nthreads; i++)
-		cpu_set(i, tmp);
-
-	lock_cpu_hotplug();
-
-	BUG_ON(!cpus_subset(cpu_present_map, cpu_possible_map));
-
-	/* Get a bitmap of unoccupied slots. */
-	cpus_xor(candidate_map, cpu_possible_map, cpu_present_map);
-	if (cpus_empty(candidate_map)) {
-		/* If we get here, it most likely means that NR_CPUS is
-		 * less than the partition's max processors setting.
-		 */
-		printk(KERN_ERR "Cannot add cpu %s; this system configuration"
-		       " supports %d logical cpus.\n", np->full_name,
-		       cpus_weight(cpu_possible_map));
-		goto out_unlock;
-	}
-
-	while (!cpus_empty(tmp))
-		if (cpus_subset(tmp, candidate_map))
-			/* Found a range where we can insert the new cpu(s) */
-			break;
-		else
-			cpus_shift_left(tmp, tmp, nthreads);
-
-	if (cpus_empty(tmp)) {
-		printk(KERN_ERR "Unable to find space in cpu_present_map for"
-		       " processor %s with %d thread(s)\n", np->name,
-		       nthreads);
-		goto out_unlock;
-	}
-
-	for_each_cpu_mask(cpu, tmp) {
-		BUG_ON(cpu_isset(cpu, cpu_present_map));
-		cpu_set(cpu, cpu_present_map);
-		set_hard_smp_processor_id(cpu, *intserv++);
-	}
-	err = 0;
-out_unlock:
-	unlock_cpu_hotplug();
-	return err;
-}
-
-/*
- * Update the present map for a cpu node which is going away, and set
- * the hard id in the paca(s) to -1 to be consistent with boot time
- * convention for non-present cpus.
- */
-static void pSeries_remove_processor(struct device_node *np)
-{
-	unsigned int cpu;
-	int len, nthreads, i;
-	const u32 *intserv;
-
-	intserv = get_property(np, "ibm,ppc-interrupt-server#s", &len);
-	if (!intserv)
-		return;
-
-	nthreads = len / sizeof(u32);
-
-	lock_cpu_hotplug();
-	for (i = 0; i < nthreads; i++) {
-		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
-				continue;
-			BUG_ON(cpu_online(cpu));
-			cpu_clear(cpu, cpu_present_map);
-			set_hard_smp_processor_id(cpu, -1);
-			break;
-		}
-		if (cpu == NR_CPUS)
-			printk(KERN_WARNING "Could not find cpu to remove "
-			       "with physical id 0x%x\n", intserv[i]);
-	}
-	unlock_cpu_hotplug();
-}
-
-static int pSeries_smp_notifier(struct notifier_block *nb, unsigned long action, void *node)
-{
-	int err = NOTIFY_OK;
-
-	switch (action) {
-	case PSERIES_RECONFIG_ADD:
-		if (pSeries_add_processor(node))
-			err = NOTIFY_BAD;
-		break;
-	case PSERIES_RECONFIG_REMOVE:
-		pSeries_remove_processor(node);
-		break;
-	default:
-		err = NOTIFY_DONE;
-		break;
-	}
-	return err;
-}
-
-static struct notifier_block pSeries_smp_nb = {
-	.notifier_call = pSeries_smp_notifier,
-};
-
-#endif /* CONFIG_HOTPLUG_CPU */
-
 /**
  * smp_startup_cpu() - start the given cpu
  *
@@ -422,15 +231,6 @@ static void __init smp_init_pseries(void
 
 	DBG(" -> smp_init_pSeries()\n");
 
-#ifdef CONFIG_HOTPLUG_CPU
-	smp_ops->cpu_disable = pSeries_cpu_disable;
-	smp_ops->cpu_die = pSeries_cpu_die;
-
-	/* Processors can be added/removed only on LPAR */
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		pSeries_reconfig_notifier_register(&pSeries_smp_nb);
-#endif
-
 	/* Mark threads which are still spinning in hold loops. */
 	if (cpu_has_feature(CPU_FTR_SMT)) {
 		for_each_present_cpu(i) { 
