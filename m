Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 17 Nov 2006 14:36:35 +1100
Subject: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
In-Reply-To: <20061116154051.GB2008@localdomain>
Message-Id: <20061117033638.0E24B67BCE@ozlabs.org>
Cc: ego@in.ibm.com, ntl@pobox.com, Anton Blanchard <anton@samba.org>,
	srinivasa@in.ibm.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The pseries cpu hotplug code is currently spread between ./kernel/rtas.c,
./platforms/pseries/smp.c and ./platforms/pseries/setup.c. Some of it is
not #ifdef CONFIG_HOTPLUG_CPU, but it should be.

So move all the cpu hotplug code into platforms/pseries/hotplug-cpu.c
While we're moving, rename studly caps functions to normal caps, they're
all static so no harm done. Fixup some long lines also, and make things
static that can be, now we're all in the same file.

Currently we unconditionally hookup pSeries_mach_cpu_die to ppc_md.cpu_die,
even if we don't have CONFIG_HOTPLUG_CPU enabled. This is wrong, as it
signals the sysfs code to create the online attribute for cpu nodes,
allowing the user to attempt an offline when it's not actually supported.

There is also a problem on systems that don't have the correct RTAS tokens
available to do RTAS-based cpu hotplug, we still indicate via sysfs that
we support cpu hotplug - and then attempt to do so with missing RTAS tokens.

Both problems are solved by conditionally registering the cpu hotplug
callbacks, only when CONFIG_HOTPLUG_CPU is enabled, and only after we've
found the requisite RTAS tokens.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

OK, what do people think of this? I think it solves the problems we've
seen lately. This supersedes Linas patch to wrap the pSeries bits in
CONFIG_HOTPLUG_CPU.

I haven't tested this - if someone can that'd be great - otherwise I'll
have a go on Monday.

---
 arch/powerpc/kernel/rtas.c                   |   28 --
 arch/powerpc/platforms/pseries/Makefile      |    2 
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  272 +++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c       |   12 -
 arch/powerpc/platforms/pseries/smp.c         |  199 -------------------
 include/asm-powerpc/rtas.h                   |    4 
 6 files changed, 274 insertions(+), 243 deletions(-)

Index: powerpc/arch/powerpc/kernel/rtas.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/rtas.c
+++ powerpc/arch/powerpc/kernel/rtas.c
@@ -810,31 +810,6 @@ asmlinkage int ppc_rtas(struct rtas_args
 	return 0;
 }
 
-/* This version can't take the spinlock, because it never returns */
-
-struct rtas_args rtas_stop_self_args = {
-	/* The token is initialized for real in setup_system() */
-	.token = RTAS_UNKNOWN_SERVICE,
-	.nargs = 0,
-	.nret = 1,
-	.rets = &rtas_stop_self_args.args[0],
-};
-
-void rtas_stop_self(void)
-{
-	struct rtas_args *rtas_args = &rtas_stop_self_args;
-
-	local_irq_disable();
-
-	BUG_ON(rtas_args->token == RTAS_UNKNOWN_SERVICE);
-
-	printk("cpu %u (hwid %u) Ready to die...\n",
-	       smp_processor_id(), hard_smp_processor_id());
-	enter_rtas(__pa(rtas_args));
-
-	panic("Alas, I survived.\n");
-}
-
 /*
  * Call early during boot, before mem init or bootmem, to retrieve the RTAS
  * informations from the device-tree and allocate the RMO buffer for userland
@@ -879,9 +854,6 @@ void __init rtas_initialize(void)
 #endif
 	rtas_rmo_buf = lmb_alloc_base(RTAS_RMOBUF_MAX, PAGE_SIZE, rtas_region);
 
-#ifdef CONFIG_HOTPLUG_CPU
-	rtas_stop_self_args.token = rtas_token("stop-self");
-#endif /* CONFIG_HOTPLUG_CPU */
 #ifdef CONFIG_RTAS_ERROR_LOGGING
 	rtas_last_error_token = rtas_token("rtas-last-error");
 #endif
Index: powerpc/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/Makefile
+++ powerpc/arch/powerpc/platforms/pseries/Makefile
@@ -10,6 +10,8 @@ obj-$(CONFIG_XICS)	+= xics.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o
 
+obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
+
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
 obj-$(CONFIG_HCALL_STATS)	+= hvCall_inst.o
Index: powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- /dev/null
+++ powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -0,0 +1,272 @@
+/*
+ * pseries CPU Hotplug infrastructure.
+ *
+ * Split out from arch/powerpc/platforms/pseries/setup.c
+ *  arch/powerpc/kernel/rtas.c, and arch/powerpc/platforms/pseries/smp.c
+ *
+ * Peter Bergner, IBM	March 2001.
+ * Copyright (C) 2001 IBM.
+ * Dave Engebretsen, Peter Bergner, and
+ * Mike Corrigan {engebret|bergner|mikec}@us.ibm.com
+ * Plus various changes from other IBM teams...
+ *
+ * Copyright (C) 2006 Michael Ellerman, IBM Corporation
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/cpu.h>
+#include <asm/system.h>
+#include <asm/prom.h>
+#include <asm/rtas.h>
+#include <asm/firmware.h>
+#include <asm/machdep.h>
+#include <asm/vdso_datapage.h>
+#include <asm/pSeries_reconfig.h>
+#include "xics.h"
+
+/* This version can't take the spinlock, because it never returns */
+static struct rtas_args rtas_stop_self_args = {
+	.token = RTAS_UNKNOWN_SERVICE,
+	.nargs = 0,
+	.nret = 1,
+	.rets = &rtas_stop_self_args.args[0],
+};
+
+static void rtas_stop_self(void)
+{
+	struct rtas_args *args = &rtas_stop_self_args;
+
+	local_irq_disable();
+
+	BUG_ON(args->token == RTAS_UNKNOWN_SERVICE);
+
+	printk("cpu %u (hwid %u) Ready to die...\n",
+	       smp_processor_id(), hard_smp_processor_id());
+	enter_rtas(__pa(args));
+
+	panic("Alas, I survived.\n");
+}
+
+static void pseries_mach_cpu_die(void)
+{
+	local_irq_disable();
+	idle_task_exit();
+	xics_teardown_cpu(0);
+	rtas_stop_self();
+	/* Should never get here... */
+	BUG();
+	for(;;);
+}
+
+static int qcss_tok;	/* query-cpu-stopped-state token */
+
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
+	int cpu_status, status;
+
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
+static int pseries_cpu_disable(void)
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
+static void pseries_cpu_die(unsigned int cpu)
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
+static int pseries_add_processor(struct device_node *np)
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
+static void pseries_remove_processor(struct device_node *np)
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
+static int pseries_smp_notifier(struct notifier_block *nb,
+		unsigned long action, void *node)
+{
+	int err = NOTIFY_OK;
+
+	switch (action) {
+	case PSERIES_RECONFIG_ADD:
+		if (pseries_add_processor(node))
+			err = NOTIFY_BAD;
+		break;
+	case PSERIES_RECONFIG_REMOVE:
+		pseries_remove_processor(node);
+		break;
+	default:
+		err = NOTIFY_DONE;
+		break;
+	}
+	return err;
+}
+
+static struct notifier_block pseries_smp_nb = {
+	.notifier_call = pseries_smp_notifier,
+};
+
+static int __init pseries_cpu_hotplug_init(void)
+{
+	rtas_stop_self_args.token = rtas_token("stop-self");
+	qcss_tok = rtas_token("query-cpu-stopped-state");
+
+	if (rtas_stop_self_args.token == RTAS_UNKNOWN_SERVICE ||
+			qcss_tok == RTAS_UNKNOWN_SERVICE)
+		return 1;
+
+	ppc_md.cpu_die = pseries_mach_cpu_die;
+	smp_ops->cpu_disable = pseries_cpu_disable;
+	smp_ops->cpu_die = pseries_cpu_die;
+
+	/* Processors can be added/removed only on LPAR */
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		pSeries_reconfig_notifier_register(&pseries_smp_nb);
+
+	return 0;
+}
+arch_initcall(pseries_cpu_hotplug_init);
Index: powerpc/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/setup.c
+++ powerpc/arch/powerpc/platforms/pseries/setup.c
@@ -347,17 +347,6 @@ static int __init pSeries_init_panel(voi
 }
 arch_initcall(pSeries_init_panel);
 
-static void pSeries_mach_cpu_die(void)
-{
-	local_irq_disable();
-	idle_task_exit();
-	xics_teardown_cpu(0);
-	rtas_stop_self();
-	/* Should never get here... */
-	BUG();
-	for(;;);
-}
-
 static int pseries_set_dabr(unsigned long dabr)
 {
 	return plpar_hcall_norets(H_SET_DABR, dabr);
@@ -558,7 +547,6 @@ define_machine(pseries) {
 	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
 	.panic			= rtas_os_term,
-	.cpu_die		= pSeries_mach_cpu_die,
 	.get_boot_time		= rtas_get_boot_time,
 	.get_rtc_time		= rtas_get_rtc_time,
 	.set_rtc_time		= rtas_set_rtc_time,
Index: powerpc/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/smp.c
+++ powerpc/arch/powerpc/platforms/pseries/smp.c
@@ -64,196 +64,6 @@ static cpumask_t of_spin_map;
 
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
 
 /**
  * smp_startup_cpu() - start the given cpu
@@ -422,15 +232,6 @@ static void __init smp_init_pseries(void
 
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
Index: powerpc/include/asm-powerpc/rtas.h
===================================================================
--- powerpc.orig/include/asm-powerpc/rtas.h
+++ powerpc/include/asm-powerpc/rtas.h
@@ -54,8 +54,6 @@ struct rtas_args {
 	rtas_arg_t *rets;     /* Pointer to return values in args[]. */
 };  
 
-extern struct rtas_args rtas_stop_self_args;
-
 struct rtas_t {
 	unsigned long entry;		/* physical address pointer */
 	unsigned long base;		/* physical address pointer */
@@ -223,8 +221,6 @@ extern int rtas_get_error_log_max(void);
 extern spinlock_t rtas_data_buf_lock;
 extern char rtas_data_buf[RTAS_DATA_BUF_SIZE];
 
-extern void rtas_stop_self(void);
-
 /* RMO buffer reserved for user-space RTAS use */
 extern unsigned long rtas_rmo_buf;
 
