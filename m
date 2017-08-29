Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xh8kJ0mRvzDqJ9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 10:33:11 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7T0TC31112326
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 20:33:10 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cmurndf2g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 20:33:09 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 28 Aug 2017 18:33:08 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 John Allen <jallen@linux.vnet.ibm.com>
In-Reply-To: <27ed5a3a-e2d5-fc6d-9a3b-735430faa9da@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V11 3/3] powerpc/vphn: Better integrate vphn source code
Date: Mon, 28 Aug 2017 19:33:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <b631b666-91c9-863e-9b74-26cc0c39986e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


powerpc/vphn: Reorganize source code in order to better distinguish the
VPHN code from the NUMA code better, by moving relevant functions to
appropriate files.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h    |    6 
 arch/powerpc/mm/numa.c                 |  550 +------------------------------
 arch/powerpc/mm/vphn.c                 |  574 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/dlpar.c |    2 
 4 files changed, 583 insertions(+), 549 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 85d6428..600e1c6 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -106,12 +106,6 @@ static inline int prrn_is_enabled(void)
 #endif /* CONFIG_PPC_SPLPAR */
 #endif /* CONFIG_HOTPLUG_CPU || CONFIG_NEED_MULTIPLE_NODES */
 
-#if defined(CONFIG_PPC_SPLPAR)
-extern void shared_topology_update(void);
-#else
-#define	shared_topology_update()	0
-#endif /* CONFIG_PPC_SPLPAR */
-
 #include <asm-generic/topology.h>
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 2e8258a..a66f0da 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -42,8 +42,12 @@
 #include <asm/setup.h>
 #include <asm/vdso.h>
 
+#include "vphn.h"
+
 static int numa_enabled = 1;
 
+bool topology_updates_enabled = true;
+
 static char *cmdline __initdata;
 
 static int numa_debug;
@@ -61,8 +65,7 @@
 static int n_mem_addr_cells, n_mem_size_cells;
 static int form1_affinity;
 
-#define MAX_DISTANCE_REF_POINTS 4
-static int distance_ref_points_depth;
+int distance_ref_points_depth;
 static const __be32 *distance_ref_points;
 static int distance_lookup_table[MAX_NUMNODES][MAX_DISTANCE_REF_POINTS];
 
@@ -143,12 +146,12 @@ static void reset_numa_cpu_lookup_table(void)
 		numa_cpu_lookup_table[cpu] = -1;
 }
 
-static void update_numa_cpu_lookup_table(unsigned int cpu, int node)
+void update_numa_cpu_lookup_table(unsigned int cpu, int node)
 {
 	numa_cpu_lookup_table[cpu] = node;
 }
 
-static void map_cpu_to_node(int cpu, int node)
+void map_cpu_to_node(int cpu, int node)
 {
 	update_numa_cpu_lookup_table(cpu, node);
 
@@ -159,7 +162,7 @@ static void map_cpu_to_node(int cpu, int node)
 }
 
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PPC_SPLPAR)
-static void unmap_cpu_from_node(unsigned long cpu)
+void unmap_cpu_from_node(unsigned long cpu)
 {
 	int node = numa_cpu_lookup_table[cpu];
 
@@ -234,7 +237,7 @@ static void initialize_distance_lookup_table(int nid,
 /* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
  * info is found.
  */
-static int associativity_to_nid(const __be32 *associativity)
+int associativity_to_nid(const __be32 *associativity)
 {
 	int nid = -1;
 
@@ -1001,8 +1004,6 @@ static int __init early_numa(char *p)
 }
 early_param("numa", early_numa);
 
-static bool topology_updates_enabled = true;
-
 static int __init early_topology_updates(char *p)
 {
 	if (!p)
@@ -1179,536 +1180,3 @@ u64 memory_hotplug_max(void)
         return max(hot_add_drconf_memory_max(), memblock_end_of_DRAM());
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
-
-/* Virtual Processor Home Node (VPHN) support */
-#ifdef CONFIG_PPC_SPLPAR
-
-#include "vphn.h"
-
-struct topology_update_data {
-	struct topology_update_data *next;
-	unsigned int cpu;
-	int old_nid;
-	int new_nid;
-};
-
-#define	TOPOLOGY_DEF_TIMER_SECS		60
-
-static u8 vphn_cpu_change_counts[NR_CPUS][MAX_DISTANCE_REF_POINTS];
-static cpumask_t cpu_associativity_changes_mask;
-static int vphn_enabled;
-static int prrn_enabled;
-static void reset_topology_timer(void);
-static int topology_timer_secs = TOPOLOGY_DEF_TIMER_SECS;
-static int topology_inited;
-static int topology_update_needed;
-
-/*
- * Change polling interval for associativity changes.
- */
-int timed_topology_update(int nsecs)
-{
-	if (nsecs > 0)
-		topology_timer_secs = nsecs;
-	else
-		topology_timer_secs = TOPOLOGY_DEF_TIMER_SECS;
-
-	if (vphn_enabled)
-		reset_topology_timer();
-
-	return 0;
-}
-
-/*
- * Store the current values of the associativity change counters in the
- * hypervisor.
- */
-static void setup_cpu_associativity_change_counters(void)
-{
-	int cpu;
-
-	/* The VPHN feature supports a maximum of 8 reference points */
-	BUILD_BUG_ON(MAX_DISTANCE_REF_POINTS > 8);
-
-	for_each_possible_cpu(cpu) {
-		int i;
-		u8 *counts = vphn_cpu_change_counts[cpu];
-		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
-
-		for (i = 0; i < distance_ref_points_depth; i++)
-			counts[i] = hypervisor_counts[i];
-	}
-}
-
-/*
- * The hypervisor maintains a set of 8 associativity change counters in
- * the VPA of each cpu that correspond to the associativity levels in the
- * ibm,associativity-reference-points property. When an associativity
- * level changes, the corresponding counter is incremented.
- *
- * Set a bit in cpu_associativity_changes_mask for each cpu whose home
- * node associativity levels have changed.
- *
- * Returns the number of cpus with unhandled associativity changes.
- */
-static int update_cpu_associativity_changes_mask(void)
-{
-	int cpu;
-	cpumask_t *changes = &cpu_associativity_changes_mask;
-
-	for_each_possible_cpu(cpu) {
-		int i, changed = 0;
-		u8 *counts = vphn_cpu_change_counts[cpu];
-		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
-
-		for (i = 0; i < distance_ref_points_depth; i++) {
-			if (hypervisor_counts[i] != counts[i]) {
-				counts[i] = hypervisor_counts[i];
-				changed = 1;
-			}
-		}
-		if (changed) {
-			cpumask_or(changes, changes, cpu_sibling_mask(cpu));
-			cpu = cpu_last_thread_sibling(cpu);
-		}
-	}
-
-	return cpumask_weight(changes);
-}
-
-/*
- * Retrieve the new associativity information for a virtual processor's
- * home node.
- */
-static long hcall_vphn(unsigned long cpu, __be32 *associativity)
-{
-	long rc;
-	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
-	u64 flags = 1;
-	int hwcpu = get_hard_smp_processor_id(cpu);
-
-	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
-	vphn_unpack_associativity(retbuf, associativity);
-
-	return rc;
-}
-
-static long vphn_get_associativity(unsigned long cpu,
-					__be32 *associativity)
-{
-	long rc;
-
-	rc = hcall_vphn(cpu, associativity);
-
-	switch (rc) {
-	case H_FUNCTION:
-		printk(KERN_INFO
-			"VPHN is not supported. Disabling polling...\n");
-		stop_topology_update();
-		break;
-	case H_HARDWARE:
-		printk(KERN_ERR
-			"hcall_vphn() experienced a hardware fault "
-			"preventing VPHN. Disabling polling...\n");
-		stop_topology_update();
-		break;
-	case H_SUCCESS:
-		printk(KERN_INFO
-			"VPHN hcall succeeded. Reset polling...\n");
-		timed_topology_update(0);
-		break;
-	}
-
-	return rc;
-}
-
-/*
- * Update the CPU maps and sysfs entries for a single CPU when its NUMA
- * characteristics change. This function doesn't perform any locking and is
- * only safe to call from stop_machine().
- */
-static int update_cpu_topology(void *data)
-{
-	struct topology_update_data *update;
-	unsigned long cpu;
-
-	if (!data)
-		return -EINVAL;
-
-	cpu = smp_processor_id();
-
-	for (update = data; update; update = update->next) {
-		int new_nid = update->new_nid;
-		if (cpu != update->cpu)
-			continue;
-
-		unmap_cpu_from_node(cpu);
-		map_cpu_to_node(cpu, new_nid);
-		set_cpu_numa_node(cpu, new_nid);
-		set_cpu_numa_mem(cpu, local_memory_node(new_nid));
-		vdso_getcpu_init();
-	}
-
-	return 0;
-}
-
-static int update_lookup_table(void *data)
-{
-	struct topology_update_data *update;
-
-	if (!data)
-		return -EINVAL;
-
-	/*
-	 * Upon topology update, the numa-cpu lookup table needs to be updated
-	 * for all threads in the core, including offline CPUs, to ensure that
-	 * future hotplug operations respect the cpu-to-node associativity
-	 * properly.
-	 */
-	for (update = data; update; update = update->next) {
-		int nid, base, j;
-
-		nid = update->new_nid;
-		base = cpu_first_thread_sibling(update->cpu);
-
-		for (j = 0; j < threads_per_core; j++) {
-			update_numa_cpu_lookup_table(base + j, nid);
-		}
-	}
-
-	return 0;
-}
-
-/*
- * Update the node maps and sysfs entries for each cpu whose home node
- * has changed. Returns 1 when the topology has changed, and 0 otherwise.
- *
- * cpus_locked says whether we already hold cpu_hotplug_lock.
- */
-int numa_update_cpu_topology(bool cpus_locked)
-{
-	unsigned int cpu, sibling, changed = 0;
-	struct topology_update_data *updates, *ud;
-	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
-	cpumask_t updated_cpus;
-	struct device *dev;
-	int weight, new_nid, i = 0;
-
-	if (!prrn_enabled && !vphn_enabled) {
-		if (!topology_inited)
-			topology_update_needed = 1;
-		return 0;
-	}
-
-	weight = cpumask_weight(&cpu_associativity_changes_mask);
-	if (!weight)
-		return 0;
-
-	updates = kzalloc(weight * (sizeof(*updates)), GFP_KERNEL);
-	if (!updates)
-		return 0;
-
-	cpumask_clear(&updated_cpus);
-
-	for_each_cpu(cpu, &cpu_associativity_changes_mask) {
-		/*
-		 * If siblings aren't flagged for changes, updates list
-		 * will be too short. Skip on this update and set for next
-		 * update.
-		 */
-		if (!cpumask_subset(cpu_sibling_mask(cpu),
-					&cpu_associativity_changes_mask)) {
-			pr_info("Sibling bits not set for associativity "
-					"change, cpu%d\n", cpu);
-			cpumask_or(&cpu_associativity_changes_mask,
-					&cpu_associativity_changes_mask,
-					cpu_sibling_mask(cpu));
-			cpu = cpu_last_thread_sibling(cpu);
-			continue;
-		}
-
-		/* Use associativity from first thread for all siblings */
-		vphn_get_associativity(cpu, associativity);
-		new_nid = associativity_to_nid(associativity);
-		if (new_nid < 0 || !node_online(new_nid))
-			new_nid = first_online_node;
-
-		if (new_nid == numa_cpu_lookup_table[cpu]) {
-			cpumask_andnot(&cpu_associativity_changes_mask,
-					&cpu_associativity_changes_mask,
-					cpu_sibling_mask(cpu));
-			pr_info("Assoc chg gives same node %d for cpu%d\n",
-					new_nid, cpu);
-			cpu = cpu_last_thread_sibling(cpu);
-			continue;
-		}
-
-		for_each_cpu(sibling, cpu_sibling_mask(cpu)) {
-			ud = &updates[i++];
-			ud->cpu = sibling;
-			ud->new_nid = new_nid;
-			ud->old_nid = numa_cpu_lookup_table[sibling];
-			cpumask_set_cpu(sibling, &updated_cpus);
-			if (i < weight)
-				ud->next = &updates[i];
-			else
-				ud->next = NULL;
-		}
-		cpu = cpu_last_thread_sibling(cpu);
-	}
-
-	pr_debug("Topology update for the following CPUs:\n");
-	if (cpumask_weight(&updated_cpus)) {
-		for (ud = &updates[0]; ud; ud = ud->next) {
-			pr_debug("cpu %d moving from node %d "
-					  "to %d\n", ud->cpu,
-					  ud->old_nid, ud->new_nid);
-		}
-	}
-
-	/*
-	 * In cases where we have nothing to update (because the updates list
-	 * is too short or because the new topology is same as the old one),
-	 * skip invoking update_cpu_topology() via stop-machine(). This is
-	 * necessary (and not just a fast-path optimization) since stop-machine
-	 * can end up electing a random CPU to run update_cpu_topology(), and
-	 * thus trick us into setting up incorrect cpu-node mappings (since
-	 * 'updates' is kzalloc()'ed).
-	 *
-	 * And for the similar reason, we will skip all the following updating.
-	 */
-	if (!cpumask_weight(&updated_cpus))
-		goto out;
-
-	if (cpus_locked)
-		stop_machine_cpuslocked(update_cpu_topology, &updates[0],
-					&updated_cpus);
-	else
-		stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
-
-	/*
-	 * Update the numa-cpu lookup table with the new mappings, even for
-	 * offline CPUs. It is best to perform this update from the stop-
-	 * machine context.
-	 */
-	if (cpus_locked)
-		stop_machine_cpuslocked(update_lookup_table, &updates[0],
-					cpumask_of(raw_smp_processor_id()));
-	else
-		stop_machine(update_lookup_table, &updates[0],
-			     cpumask_of(raw_smp_processor_id()));
-
-	for (ud = &updates[0]; ud; ud = ud->next) {
-		unregister_cpu_under_node(ud->cpu, ud->old_nid);
-		register_cpu_under_node(ud->cpu, ud->new_nid);
-
-		dev = get_cpu_device(ud->cpu);
-		if (dev)
-			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
-		cpumask_clear_cpu(ud->cpu, &cpu_associativity_changes_mask);
-		changed = 1;
-	}
-
-out:
-	kfree(updates);
-	topology_update_needed = 0;
-	return changed;
-}
-
-int arch_update_cpu_topology(void)
-{
-	lockdep_assert_cpus_held();
-	return numa_update_cpu_topology(true);
-}
-
-static void topology_work_fn(struct work_struct *work)
-{
-	rebuild_sched_domains();
-}
-static DECLARE_WORK(topology_work, topology_work_fn);
-
-static void topology_schedule_update(void)
-{
-	schedule_work(&topology_work);
-}
-
-void shared_topology_update(void)
-{
-	if (firmware_has_feature(FW_FEATURE_VPHN) &&
-		   lppaca_shared_proc(get_lppaca()))
-		topology_schedule_update();
-}
-EXPORT_SYMBOL(shared_topology_update);
-
-static void topology_timer_fn(unsigned long ignored)
-{
-	if (prrn_enabled && cpumask_weight(&cpu_associativity_changes_mask))
-		topology_schedule_update();
-	else if (vphn_enabled) {
-		if (update_cpu_associativity_changes_mask() > 0)
-			topology_schedule_update();
-		reset_topology_timer();
-	}
-}
-static struct timer_list topology_timer =
-	TIMER_INITIALIZER(topology_timer_fn, 0, 0);
-
-static void reset_topology_timer(void)
-{
-	topology_timer.data = 0;
-	topology_timer.expires = jiffies + topology_timer_secs * HZ;
-	mod_timer(&topology_timer, topology_timer.expires);
-}
-
-#ifdef CONFIG_SMP
-
-static void stage_topology_update(int core_id)
-{
-	cpumask_or(&cpu_associativity_changes_mask,
-		&cpu_associativity_changes_mask, cpu_sibling_mask(core_id));
-	reset_topology_timer();
-}
-
-static int dt_update_callback(struct notifier_block *nb,
-				unsigned long action, void *data)
-{
-	struct of_reconfig_data *update = data;
-	int rc = NOTIFY_DONE;
-
-	switch (action) {
-	case OF_RECONFIG_UPDATE_PROPERTY:
-		if (!of_prop_cmp(update->dn->type, "cpu") &&
-		    !of_prop_cmp(update->prop->name, "ibm,associativity")) {
-			u32 core_id;
-			of_property_read_u32(update->dn, "reg", &core_id);
-			stage_topology_update(core_id);
-			rc = NOTIFY_OK;
-		}
-		break;
-	}
-
-	return rc;
-}
-
-static struct notifier_block dt_update_nb = {
-	.notifier_call = dt_update_callback,
-};
-
-#endif
-
-/*
- * Start polling for associativity changes.
- */
-int start_topology_update(void)
-{
-	int rc = 0;
-
-	if (firmware_has_feature(FW_FEATURE_PRRN)) {
-		if (!prrn_enabled) {
-			prrn_enabled = 1;
-#ifdef CONFIG_SMP
-			rc = of_reconfig_notifier_register(&dt_update_nb);
-#endif
-		}
-	}
-	if (firmware_has_feature(FW_FEATURE_VPHN) &&
-		   lppaca_shared_proc(get_lppaca())) {
-		if (!vphn_enabled) {
-			vphn_enabled = 1;
-			setup_cpu_associativity_change_counters();
-			init_timer_deferrable(&topology_timer);
-			reset_topology_timer();
-		}
-	}
-
-	return rc;
-}
-
-/*
- * Disable polling for VPHN associativity changes.
- */
-int stop_topology_update(void)
-{
-	int rc = 0;
-
-	if (prrn_enabled) {
-		prrn_enabled = 0;
-#ifdef CONFIG_SMP
-		rc = of_reconfig_notifier_unregister(&dt_update_nb);
-#endif
-	}
-	if (vphn_enabled) {
-		vphn_enabled = 0;
-		rc = del_timer_sync(&topology_timer);
-	}
-
-	return rc;
-}
-
-int prrn_is_enabled(void)
-{
-	return prrn_enabled;
-}
-
-static int topology_read(struct seq_file *file, void *v)
-{
-	if (vphn_enabled || prrn_enabled)
-		seq_puts(file, "on\n");
-	else
-		seq_puts(file, "off\n");
-
-	return 0;
-}
-
-static int topology_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, topology_read, NULL);
-}
-
-static ssize_t topology_write(struct file *file, const char __user *buf,
-			      size_t count, loff_t *off)
-{
-	char kbuf[4]; /* "on" or "off" plus null. */
-	int read_len;
-
-	read_len = count < 3 ? count : 3;
-	if (copy_from_user(kbuf, buf, read_len))
-		return -EINVAL;
-
-	kbuf[read_len] = '\0';
-
-	if (!strncmp(kbuf, "on", 2))
-		start_topology_update();
-	else if (!strncmp(kbuf, "off", 3))
-		stop_topology_update();
-	else
-		return -EINVAL;
-
-	return count;
-}
-
-static const struct file_operations topology_ops = {
-	.read = seq_read,
-	.write = topology_write,
-	.open = topology_open,
-	.release = single_release
-};
-
-static int topology_update_init(void)
-{
-	/* Do not poll for changes if disabled at boot */
-	if (topology_updates_enabled)
-		start_topology_update();
-
-	if (!proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops))
-		return -ENOMEM;
-
-	topology_inited = 1;
-	if (topology_update_needed)
-		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
-					nr_cpumask_bits);
-
-	return 0;
-}
-device_initcall(topology_update_init);
-#endif /* CONFIG_PPC_SPLPAR */
diff --git a/arch/powerpc/mm/vphn.c b/arch/powerpc/mm/vphn.c
index 5f8ef50..3859c9c 100644
--- a/arch/powerpc/mm/vphn.c
+++ b/arch/powerpc/mm/vphn.c
@@ -1,6 +1,70 @@
+/*
+ * pSeries VPHN support
+ *
+ * Copyright (C) 2015 Greg Kurz <gkurz@linux.vnet.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#define pr_fmt(fmt) "vphn: " fmt
+
+#include <linux/threads.h>
+#include <linux/bootmem.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/mmzone.h>
+#include <linux/export.h>
+#include <linux/nodemask.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
+#include <linux/memblock.h>
+#include <linux/of.h>
+#include <linux/pfn.h>
+#include <linux/cpuset.h>
+#include <linux/node.h>
+#include <linux/stop_machine.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <asm/cputhreads.h>
+#include <asm/sparsemem.h>
+#include <asm/prom.h>
+#include <asm/smp.h>
+#include <asm/cputhreads.h>
+#include <asm/topology.h>
+#include <asm/firmware.h>
+#include <asm/paca.h>
+#include <asm/hvcall.h>
+#include <asm/setup.h>
+#include <asm/vdso.h>
 #include <asm/byteorder.h>
+
+/* Virtual Processor Home Node (VPHN) support */
+
 #include "vphn.h"
 
+struct topology_update_data {
+	struct topology_update_data *next;
+	unsigned int cpu;
+	int old_nid;
+	int new_nid;
+};
+
+#define	TOPOLOGY_DEF_TIMER_SECS		60
+
+static u8 vphn_cpu_change_counts[NR_CPUS][MAX_DISTANCE_REF_POINTS];
+static cpumask_t cpu_associativity_changes_mask;
+static int vphn_enabled;
+static int prrn_enabled;
+static void reset_topology_timer(void);
+static int topology_timer_secs = TOPOLOGY_DEF_TIMER_SECS;
+static int topology_inited;
+static int topology_update_needed;
+
 /*
  * The associativity domain numbers are returned from the hypervisor as a
  * stream of mixed 16-bit and 32-bit fields. The stream is terminated by the
@@ -68,3 +132,513 @@ int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
 
 	return nr_assoc_doms;
 }
+
+/*
+ * Change polling interval for associativity changes.
+ */
+int timed_topology_update(int nsecs)
+{
+	if (nsecs > 0)
+		topology_timer_secs = nsecs;
+	else
+		topology_timer_secs = TOPOLOGY_DEF_TIMER_SECS;
+
+	if (vphn_enabled)
+		reset_topology_timer();
+
+	return 0;
+}
+
+/*
+ * Store the current values of the associativity change counters in the
+ * hypervisor.
+ */
+static void setup_cpu_associativity_change_counters(void)
+{
+	int cpu;
+
+	/* The VPHN feature supports a maximum of 8 reference points */
+	BUILD_BUG_ON(MAX_DISTANCE_REF_POINTS > 8);
+
+	for_each_possible_cpu(cpu) {
+		int i;
+		u8 *counts = vphn_cpu_change_counts[cpu];
+		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
+
+		for (i = 0; i < distance_ref_points_depth; i++)
+			counts[i] = hypervisor_counts[i];
+	}
+}
+
+/*
+ * The hypervisor maintains a set of 8 associativity change counters in
+ * the VPA of each cpu that correspond to the associativity levels in the
+ * ibm,associativity-reference-points property. When an associativity
+ * level changes, the corresponding counter is incremented.
+ *
+ * Set a bit in cpu_associativity_changes_mask for each cpu whose home
+ * node associativity levels have changed.
+ *
+ * Returns the number of cpus with unhandled associativity changes.
+ */
+static int update_cpu_associativity_changes_mask(void)
+{
+	int cpu;
+	cpumask_t *changes = &cpu_associativity_changes_mask;
+
+	for_each_possible_cpu(cpu) {
+		int i, changed = 0;
+		u8 *counts = vphn_cpu_change_counts[cpu];
+		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
+
+		for (i = 0; i < distance_ref_points_depth; i++) {
+			if (hypervisor_counts[i] != counts[i]) {
+				counts[i] = hypervisor_counts[i];
+				changed = 1;
+			}
+		}
+		if (changed) {
+			cpumask_or(changes, changes, cpu_sibling_mask(cpu));
+			cpu = cpu_last_thread_sibling(cpu);
+		}
+	}
+
+	return cpumask_weight(changes);
+}
+
+/*
+ * Retrieve the new associativity information for a virtual processor's
+ * home node.
+ */
+static long hcall_vphn(unsigned long cpu, __be32 *associativity)
+{
+	long rc;
+	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
+	u64 flags = 1;
+	int hwcpu = get_hard_smp_processor_id(cpu);
+
+	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
+	vphn_unpack_associativity(retbuf, associativity);
+
+	return rc;
+}
+
+static long vphn_get_associativity(unsigned long cpu,
+					__be32 *associativity)
+{
+	long rc;
+
+	rc = hcall_vphn(cpu, associativity);
+
+	switch (rc) {
+	case H_FUNCTION:
+		printk(KERN_INFO
+			"VPHN is not supported. Disabling polling...\n");
+		stop_topology_update();
+		break;
+	case H_HARDWARE:
+		printk(KERN_ERR
+			"hcall_vphn() experienced a hardware fault "
+			"preventing VPHN. Disabling polling...\n");
+		stop_topology_update();
+		break;
+	case H_SUCCESS:
+		printk(KERN_INFO
+			"VPHN hcall succeeded. Reset polling...\n");
+		timed_topology_update(0);
+		break;
+	}
+
+	return rc;
+}
+
+/*
+ * Update the CPU maps and sysfs entries for a single CPU when its NUMA
+ * characteristics change. This function doesn't perform any locking and is
+ * only safe to call from stop_machine().
+ */
+static int update_cpu_topology(void *data)
+{
+	struct topology_update_data *update;
+	unsigned long cpu;
+
+	if (!data)
+		return -EINVAL;
+
+	cpu = smp_processor_id();
+
+	for (update = data; update; update = update->next) {
+		int new_nid = update->new_nid;
+		if (cpu != update->cpu)
+			continue;
+
+		unmap_cpu_from_node(cpu);
+		map_cpu_to_node(cpu, new_nid);
+		set_cpu_numa_node(cpu, new_nid);
+		set_cpu_numa_mem(cpu, local_memory_node(new_nid));
+		vdso_getcpu_init();
+	}
+
+	return 0;
+}
+
+static int update_lookup_table(void *data)
+{
+	struct topology_update_data *update;
+
+	if (!data)
+		return -EINVAL;
+
+	/*
+	 * Upon topology update, the numa-cpu lookup table needs to be updated
+	 * for all threads in the core, including offline CPUs, to ensure that
+	 * future hotplug operations respect the cpu-to-node associativity
+	 * properly.
+	 */
+	for (update = data; update; update = update->next) {
+		int nid, base, j;
+
+		nid = update->new_nid;
+		base = cpu_first_thread_sibling(update->cpu);
+
+		for (j = 0; j < threads_per_core; j++) {
+			update_numa_cpu_lookup_table(base + j, nid);
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Update the node maps and sysfs entries for each cpu whose home node
+ * has changed. Returns 1 when the topology has changed, and 0 otherwise.
+ *
+ * cpus_locked says whether we already hold cpu_hotplug_lock.
+ */
+int numa_update_cpu_topology(bool cpus_locked)
+{
+	unsigned int cpu, sibling, changed = 0;
+	struct topology_update_data *updates, *ud;
+	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	cpumask_t updated_cpus;
+	struct device *dev;
+	int weight, new_nid, i = 0;
+
+	if (!prrn_enabled && !vphn_enabled) {
+		if (!topology_inited)
+			topology_update_needed = 1;
+		return 0;
+	}
+
+	weight = cpumask_weight(&cpu_associativity_changes_mask);
+	if (!weight)
+		return 0;
+
+	updates = kzalloc(weight * (sizeof(*updates)), GFP_KERNEL);
+	if (!updates)
+		return 0;
+
+	cpumask_clear(&updated_cpus);
+
+	for_each_cpu(cpu, &cpu_associativity_changes_mask) {
+		/*
+		 * If siblings aren't flagged for changes, updates list
+		 * will be too short. Skip on this update and set for next
+		 * update.
+		 */
+		if (!cpumask_subset(cpu_sibling_mask(cpu),
+					&cpu_associativity_changes_mask)) {
+			pr_info("Sibling bits not set for associativity "
+					"change, cpu%d\n", cpu);
+			cpumask_or(&cpu_associativity_changes_mask,
+					&cpu_associativity_changes_mask,
+					cpu_sibling_mask(cpu));
+			cpu = cpu_last_thread_sibling(cpu);
+			continue;
+		}
+
+		/* Use associativity from first thread for all siblings */
+		vphn_get_associativity(cpu, associativity);
+		new_nid = associativity_to_nid(associativity);
+		if (new_nid < 0 || !node_online(new_nid))
+			new_nid = first_online_node;
+
+		if (new_nid == numa_cpu_lookup_table[cpu]) {
+			cpumask_andnot(&cpu_associativity_changes_mask,
+					&cpu_associativity_changes_mask,
+					cpu_sibling_mask(cpu));
+			pr_info("Assoc chg gives same node %d for cpu%d\n",
+					new_nid, cpu);
+			cpu = cpu_last_thread_sibling(cpu);
+			continue;
+		}
+
+		for_each_cpu(sibling, cpu_sibling_mask(cpu)) {
+			ud = &updates[i++];
+			ud->cpu = sibling;
+			ud->new_nid = new_nid;
+			ud->old_nid = numa_cpu_lookup_table[sibling];
+			cpumask_set_cpu(sibling, &updated_cpus);
+			if (i < weight)
+				ud->next = &updates[i];
+		}
+		cpu = cpu_last_thread_sibling(cpu);
+	}
+
+	if (i)
+		updates[i-1].next = NULL;
+
+	pr_debug("Topology update for the following CPUs:\n");
+	if (cpumask_weight(&updated_cpus)) {
+		for (ud = &updates[0]; ud; ud = ud->next) {
+			pr_debug("cpu %d moving from node %d "
+					  "to %d\n", ud->cpu,
+					  ud->old_nid, ud->new_nid);
+		}
+	}
+
+	/*
+	 * In cases where we have nothing to update (because the updates list
+	 * is too short or because the new topology is same as the old one),
+	 * skip invoking update_cpu_topology() via stop-machine(). This is
+	 * necessary (and not just a fast-path optimization) since stop-machine
+	 * can end up electing a random CPU to run update_cpu_topology(), and
+	 * thus trick us into setting up incorrect cpu-node mappings (since
+	 * 'updates' is kzalloc()'ed).
+	 *
+	 * And for the similar reason, we will skip all the following updating.
+	 */
+	if (!cpumask_weight(&updated_cpus))
+		goto out;
+
+	if (cpus_locked)
+		stop_machine_cpuslocked(update_cpu_topology, &updates[0],
+					&updated_cpus);
+	else
+		stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
+
+	/*
+	 * Update the numa-cpu lookup table with the new mappings, even for
+	 * offline CPUs. It is best to perform this update from the stop-
+	 * machine context.
+	 */
+	if (cpus_locked)
+		stop_machine_cpuslocked(update_lookup_table, &updates[0],
+					cpumask_of(raw_smp_processor_id()));
+	else
+		stop_machine(update_lookup_table, &updates[0],
+			     cpumask_of(raw_smp_processor_id()));
+
+	for (ud = &updates[0]; ud; ud = ud->next) {
+		unregister_cpu_under_node(ud->cpu, ud->old_nid);
+		register_cpu_under_node(ud->cpu, ud->new_nid);
+
+		dev = get_cpu_device(ud->cpu);
+		if (dev)
+			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+		cpumask_clear_cpu(ud->cpu, &cpu_associativity_changes_mask);
+		changed = 1;
+	}
+
+out:
+	kfree(updates);
+	topology_update_needed = 0;
+	return changed;
+}
+
+int arch_update_cpu_topology(void)
+{
+	lockdep_assert_cpus_held();
+	return numa_update_cpu_topology(true);
+}
+
+static void topology_work_fn(struct work_struct *work)
+{
+	rebuild_sched_domains();
+}
+static DECLARE_WORK(topology_work, topology_work_fn);
+
+static void topology_schedule_update(void)
+{
+	schedule_work(&topology_work);
+}
+
+static void shared_topology_update(void)
+{
+	if (firmware_has_feature(FW_FEATURE_VPHN) &&
+		   lppaca_shared_proc(get_lppaca()))
+		topology_schedule_update();
+}
+
+static void topology_timer_fn(unsigned long ignored)
+{
+	if (prrn_enabled && cpumask_weight(&cpu_associativity_changes_mask))
+		topology_schedule_update();
+	else if (vphn_enabled) {
+		if (update_cpu_associativity_changes_mask() > 0)
+			topology_schedule_update();
+		reset_topology_timer();
+	}
+}
+static struct timer_list topology_timer =
+	TIMER_INITIALIZER(topology_timer_fn, 0, 0);
+
+static void reset_topology_timer(void)
+{
+	topology_timer.data = 0;
+	topology_timer.expires = jiffies + topology_timer_secs * HZ;
+	mod_timer(&topology_timer, topology_timer.expires);
+}
+
+#ifdef CONFIG_SMP
+
+static void stage_topology_update(int core_id)
+{
+	cpumask_or(&cpu_associativity_changes_mask,
+		&cpu_associativity_changes_mask, cpu_sibling_mask(core_id));
+	reset_topology_timer();
+}
+
+static int dt_update_callback(struct notifier_block *nb,
+				unsigned long action, void *data)
+{
+	struct of_reconfig_data *update = data;
+	int rc = NOTIFY_DONE;
+
+	switch (action) {
+	case OF_RECONFIG_UPDATE_PROPERTY:
+		if (!of_prop_cmp(update->dn->type, "cpu") &&
+		    !of_prop_cmp(update->prop->name, "ibm,associativity")) {
+			u32 core_id;
+			of_property_read_u32(update->dn, "reg", &core_id);
+			stage_topology_update(core_id);
+			rc = NOTIFY_OK;
+		}
+		break;
+	}
+
+	return rc;
+}
+
+static struct notifier_block dt_update_nb = {
+	.notifier_call = dt_update_callback,
+};
+
+#endif
+
+/*
+ * Start polling for associativity changes.
+ */
+int start_topology_update(void)
+{
+	int rc = 0;
+
+	if (firmware_has_feature(FW_FEATURE_PRRN)) {
+		if (!prrn_enabled) {
+			prrn_enabled = 1;
+#ifdef CONFIG_SMP
+			rc = of_reconfig_notifier_register(&dt_update_nb);
+#endif
+		}
+	}
+	if (firmware_has_feature(FW_FEATURE_VPHN) &&
+		   lppaca_shared_proc(get_lppaca())) {
+		if (!vphn_enabled) {
+			vphn_enabled = 1;
+			setup_cpu_associativity_change_counters();
+			init_timer_deferrable(&topology_timer);
+			reset_topology_timer();
+		}
+	}
+
+	return rc;
+}
+
+/*
+ * Disable polling for VPHN associativity changes.
+ */
+int stop_topology_update(void)
+{
+	int rc = 0;
+
+	if (prrn_enabled) {
+		prrn_enabled = 0;
+#ifdef CONFIG_SMP
+		rc = of_reconfig_notifier_unregister(&dt_update_nb);
+#endif
+	}
+	if (vphn_enabled) {
+		vphn_enabled = 0;
+		rc = del_timer_sync(&topology_timer);
+	}
+
+	return rc;
+}
+
+int prrn_is_enabled(void)
+{
+	return prrn_enabled;
+}
+
+static int topology_read(struct seq_file *file, void *v)
+{
+	if (vphn_enabled || prrn_enabled)
+		seq_puts(file, "on\n");
+	else
+		seq_puts(file, "off\n");
+
+	return 0;
+}
+
+static int topology_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, topology_read, NULL);
+}
+
+static ssize_t topology_write(struct file *file, const char __user *buf,
+			      size_t count, loff_t *off)
+{
+	char kbuf[4]; /* "on" or "off" plus null. */
+	int read_len;
+
+	read_len = count < 3 ? count : 3;
+	if (copy_from_user(kbuf, buf, read_len))
+		return -EINVAL;
+
+	kbuf[read_len] = '\0';
+
+	if (!strncmp(kbuf, "on", 2))
+		start_topology_update();
+	else if (!strncmp(kbuf, "off", 3))
+		stop_topology_update();
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static const struct file_operations topology_ops = {
+	.read = seq_read,
+	.write = topology_write,
+	.open = topology_open,
+	.release = single_release
+};
+
+static int topology_update_init(void)
+{
+	/* Do not poll for changes if disabled at boot */
+	if (topology_updates_enabled)
+		start_topology_update();
+
+	if (!proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops))
+		return -ENOMEM;
+
+	topology_inited = 1;
+	if (topology_update_needed)
+		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
+					nr_cpumask_bits);
+
+	return 0;
+}
+device_initcall(topology_update_init);
+#endif /* CONFIG_PPC_SPLPAR */
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index ba9a4a0..3918769 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -592,8 +592,6 @@ static ssize_t dlpar_show(struct class *class, struct class_attribute *attr,
 
 static int __init pseries_dlpar_init(void)
 {
-	shared_topology_update();
-
 	pseries_hp_wq = alloc_workqueue("pseries hotplug workqueue",
 					WQ_UNBOUND, 1);
 	return sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
