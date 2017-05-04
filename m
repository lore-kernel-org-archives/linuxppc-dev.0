Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJcf945m2zDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 00:21:37 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v44EJHZU061054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 10:21:25 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7tk2eas6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 10:21:24 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Fri, 5 May 2017 00:21:21 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v44ELBxR50921614
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 00:21:19 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v44EKeu0013122
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 00:20:41 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v8 07/10] powerpc/perf: PMU functions for Core IMC and
 hotplugging
Date: Thu,  4 May 2017 19:49:53 +0530
In-Reply-To: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1493907596-11425-8-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hemant Kumar <hemant@linux.vnet.ibm.com>

This patch adds the PMU function to initialize a core IMC event. It also
adds cpumask initialization function for core IMC PMU. For
initialization, a 8KB of memory is allocated per core where the data
for core IMC counters will be accumulated. The base address for this
page is sent to OPAL via an OPAL call which initializes various SCOMs
related to Core IMC initialization. Upon any errors, the pages are
free'ed and core IMC counters are disabled using the same OPAL call.

For CPU hotplugging, a cpumask is initialized which contains an online
CPU from each core. If a cpu goes offline, we check whether that cpu
belongs to the core imc cpumask, if yes, then, we migrate the PMU
context to any other online cpu (if available) in that core. If a cpu
comes back online, then this cpu will be added to the core imc cpumask
only if there was no other cpu from that core in the previous cpumask.

To register the hotplug functions for core_imc, a new state
CPUHP_AP_PERF_POWERPC_COREIMC_ONLINE is added to the list of existing
states.

Patch also adds OPAL device shutdown callback. Needed to disable the
IMC core engine to handle kexec.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        |   7 +
 arch/powerpc/perf/imc-pmu.c               | 380 +++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-imc.c |   7 +
 include/linux/cpuhotplug.h                |   1 +
 4 files changed, 384 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 37fdd79..bf5fb7c 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -24,6 +24,7 @@
  */
 #define IMC_MAX_CHIPS			32
 #define IMC_MAX_PMUS			32
+#define IMC_MAX_CORES			32
 
 /*
  * This macro is used for memory buffer allocation of
@@ -38,6 +39,11 @@
 #define IMC_NEST_MAX_PAGES		64
 
 /*
+ * IMC Core engine expects 8K bytes of memory for counter collection.
+ */
+#define IMC_CORE_COUNTER_MEM		8192
+
+/*
  *Compatbility macros for IMC devices
  */
 #define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
@@ -101,4 +107,5 @@ extern struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
 extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 extern struct imc_pmu *core_imc_pmu;
 extern int __init init_imc_pmu(struct imc_events *events,int idx, struct imc_pmu *pmu_ptr);
+void core_imc_disable(void);
 #endif /* PPC_POWERNV_IMC_PMU_DEF_H */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index c132df2..fb71825 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1,5 +1,5 @@
 /*
- * Nest Performance Monitor counter support.
+ * IMC Performance Monitor counter support.
  *
  * Copyright (C) 2017 Madhavan Srinivasan, IBM Corporation.
  *           (C) 2017 Anju T Sudhakar, IBM Corporation.
@@ -21,9 +21,21 @@ struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 static cpumask_t nest_imc_cpumask;
 
 static atomic_t nest_events;
+static atomic_t core_events;
 /* Used to avoid races in calling enable/disable nest-pmu units*/
 static DEFINE_MUTEX(imc_nest_reserve);
+/* Used to avoid races in calling enable/disable core-pmu units */
+static DEFINE_MUTEX(imc_core_reserve);
 
+/*
+ * Maintains base addresses for all the cores.
+ * MAX chip and core are defined as 32. So we
+ * statically allocate 8K for this structure.
+ *
+ * TODO -- Could be made dynamic
+ */
+static u64 per_core_pdbar_add[IMC_MAX_CHIPS][IMC_MAX_CORES];
+static cpumask_t core_imc_cpumask;
 struct imc_pmu *core_imc_pmu;
 
 /* Needed for sanity check */
@@ -46,9 +58,15 @@ static ssize_t imc_pmu_cpumask_get_attr(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
+	struct pmu *pmu = dev_get_drvdata(dev);
 	cpumask_t *active_mask;
 
-	active_mask = &nest_imc_cpumask;
+	if (!strncmp(pmu->name, "nest_", strlen("nest_")))
+		active_mask = &nest_imc_cpumask;
+	else if (!strncmp(pmu->name, "core_", strlen("core_")))
+		active_mask = &core_imc_cpumask;
+	else
+		return 0;
 	return cpumap_print_to_pagebuf(true, buf, active_mask);
 }
 
@@ -64,6 +82,100 @@ static struct attribute_group imc_pmu_cpumask_attr_group = {
 };
 
 /*
+ * core_imc_mem_init : Initializes memory for the current core.
+ *
+ * Uses alloc_pages_exact_nid() and uses the returned address as an argument to
+ * an opal call to configure the pdbar. The address sent as an argument is
+ * converted to physical address before the opal call is made. This is the
+ * base address at which the core imc counters are populated.
+ */
+static int __meminit core_imc_mem_init(void)
+{
+	int core_id, phys_id;
+	int rc = -1;
+
+	phys_id = topology_physical_package_id(smp_processor_id());
+	core_id = smp_processor_id() / threads_per_core;
+
+	/*
+	 * alloc_pages_exact_nid() will allocate memory for core in the
+	 * local node only.
+	 */
+	per_core_pdbar_add[phys_id][core_id] = (u64) alloc_pages_exact_nid(phys_id,
+			(size_t) IMC_CORE_COUNTER_MEM, GFP_KERNEL | __GFP_ZERO);
+	rc = opal_imc_counters_init(OPAL_IMC_COUNTERS_CORE,
+				       (u64)virt_to_phys((void *)per_core_pdbar_add[phys_id][core_id]));
+
+	return rc;
+}
+
+/*
+ * Calls core_imc_mem_init and checks the return value.
+ */
+static void core_imc_init(int *cpu_opal_rc)
+{
+	int rc = 0;
+
+	rc = core_imc_mem_init();
+	if (rc)
+		cpu_opal_rc[smp_processor_id()] = 1;
+}
+
+static void core_imc_change_cpu_context(int old_cpu, int new_cpu)
+{
+	if (!core_imc_pmu)
+		return;
+	perf_pmu_migrate_context(&core_imc_pmu->pmu, old_cpu, new_cpu);
+}
+
+
+static int ppc_core_imc_cpu_online(unsigned int cpu)
+{
+	int ret;
+
+	/* If a cpu for this core is already set, then, don't do anything */
+	ret = cpumask_any_and(&core_imc_cpumask,
+				 cpu_sibling_mask(cpu));
+	if (ret < nr_cpu_ids)
+		return 0;
+
+	/* Else, set the cpu in the mask, and change the context */
+	cpumask_set_cpu(cpu, &core_imc_cpumask);
+	opal_imc_counters_start(OPAL_IMC_COUNTERS_CORE);
+	core_imc_change_cpu_context(-1, cpu);
+	return 0;
+}
+
+static int ppc_core_imc_cpu_offline(unsigned int cpu)
+{
+	int target;
+	unsigned int ncpu;
+
+	/*
+	 * clear this cpu out of the mask, if not present in the mask,
+	 * don't bother doing anything.
+	 */
+	if (!cpumask_test_and_clear_cpu(cpu, &core_imc_cpumask))
+		return 0;
+
+	/* Find any online cpu in that core except the current "cpu" */
+	ncpu = cpumask_any_but(cpu_sibling_mask(cpu), cpu);
+
+	if (ncpu < nr_cpu_ids) {
+		target = ncpu;
+		cpumask_set_cpu(target, &core_imc_cpumask);
+	} else {
+		opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE);
+		target = -1;
+	}
+
+	/* migrate the context */
+	core_imc_change_cpu_context(cpu, target);
+
+	return 0;
+}
+
+/*
  * nest_init : Initializes the nest imc engine for the current chip.
  * by default the nest engine is disabled.
  */
@@ -195,6 +307,97 @@ static int nest_pmu_cpumask_init(void)
 	return -ENODEV;
 }
 
+static void cleanup_core_imc_memory(void)
+{
+	int phys_id, core_id;
+	u64 addr;
+
+	phys_id = topology_physical_package_id(smp_processor_id());
+	core_id = smp_processor_id() / threads_per_core;
+
+	addr = per_core_pdbar_add[phys_id][core_id];
+
+	/* Only if the address is non-zero shall, we free it */
+	if (addr)
+		free_pages(addr, 0);
+}
+
+static void cleanup_all_core_imc_memory(void)
+{
+	on_each_cpu_mask(&core_imc_cpumask,
+			 (smp_call_func_t)cleanup_core_imc_memory, NULL, 1);
+}
+
+/* Enabling of Core Engine needs a scom operation */
+static void core_imc_control_enable(void)
+{
+	opal_imc_counters_start(OPAL_IMC_COUNTERS_CORE);
+}
+
+
+/*
+ * Disabling of IMC Core Engine needs a scom operation
+ */
+static void core_imc_control_disable(void)
+{
+	opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE);
+}
+
+/*
+ * Function to diable the IMC Core engine using core imc cpumask
+ */
+void core_imc_disable(void)
+{
+	on_each_cpu_mask(&core_imc_cpumask,
+			 (smp_call_func_t)core_imc_control_disable, NULL, 1);
+}
+
+static int core_imc_pmu_cpumask_init(void)
+{
+	int cpu, *cpus_opal_rc;
+
+	/*
+	 * Get the mask of first online cpus for every core.
+	 */
+	core_imc_cpumask = cpu_online_cores_map();
+
+	/*
+	 * Memory for OPAL call return value.
+	 */
+	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
+	if (!cpus_opal_rc)
+		goto fail;
+
+	/*
+	 * Initialize the core IMC PMU on each core using the
+	 * core_imc_cpumask by calling core_imc_init().
+	 */
+	on_each_cpu_mask(&core_imc_cpumask, (smp_call_func_t)core_imc_init,
+						(void *)cpus_opal_rc, 1);
+
+	/* Check return value array for any OPAL call failure */
+	for_each_cpu(cpu, &core_imc_cpumask) {
+		if (cpus_opal_rc[cpu]) {
+			kfree(cpus_opal_rc);
+			goto fail;
+		}
+	}
+
+	kfree(cpus_opal_rc);
+
+	cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_COREIMC_ONLINE,
+			  "POWER_CORE_IMC_ONLINE",
+			  ppc_core_imc_cpu_online,
+			  ppc_core_imc_cpu_offline);
+
+	return 0;
+
+fail:
+	/* Free up the allocated pages */
+	cleanup_all_core_imc_memory();
+	return -ENODEV;
+}
+
 static int nest_imc_event_init(struct perf_event *event)
 {
 	int chip_id;
@@ -238,6 +441,44 @@ static int nest_imc_event_init(struct perf_event *event)
 	return 0;
 }
 
+static int core_imc_event_init(struct perf_event *event)
+{
+	int core_id, phys_id;
+	u64 config = event->attr.config;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* Sampling not supported */
+	if (event->hw.sample_period)
+		return -EINVAL;
+
+	/* unsupported modes and filters */
+	if (event->attr.exclude_user   ||
+	    event->attr.exclude_kernel ||
+	    event->attr.exclude_hv     ||
+	    event->attr.exclude_idle   ||
+	    event->attr.exclude_host   ||
+	    event->attr.exclude_guest)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	event->hw.idx = -1;
+
+	/* Sanity check for config (event offset) */
+	if (config > core_max_offset)
+		return -EINVAL;
+
+	core_id = event->cpu / threads_per_core;
+	phys_id = topology_physical_package_id(event->cpu);
+	event->hw.event_base =
+		per_core_pdbar_add[phys_id][core_id] + config;
+
+	return 0;
+}
+
 static void imc_read_counter(struct perf_event *event)
 {
 	u64 *addr, data;
@@ -384,6 +625,100 @@ static int nest_imc_event_add(struct perf_event *event, int flags)
 	return 0;
 }
 
+static int core_imc_control(int operation)
+{
+	int cpu, *cpus_opal_rc;
+
+	/*
+	 * Memory for OPAL call return value.
+	 */
+	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
+	if (!cpus_opal_rc)
+		goto fail;
+
+	/*
+	 * Initialize the core IMC PMU on each core using the
+	 * core_imc_cpumask by calling core_imc_init().
+	 */
+	switch (operation) {
+
+	case IMC_COUNTER_DISABLE:
+		on_each_cpu_mask(&core_imc_cpumask,
+				(smp_call_func_t)core_imc_control_disable,
+				(void *)cpus_opal_rc, 1);
+		break;
+	case IMC_COUNTER_ENABLE:
+		on_each_cpu_mask(&core_imc_cpumask,
+				(smp_call_func_t)core_imc_control_enable,
+				(void *)cpus_opal_rc, 1);
+		break;
+	default:
+		goto fail;
+	}
+
+	/* Check return value array for any OPAL call failure */
+	for_each_cpu(cpu, &core_imc_cpumask) {
+		if (cpus_opal_rc[cpu])
+			goto fail;
+	}
+
+	return 0;
+fail:
+	if (cpus_opal_rc)
+		kfree(cpus_opal_rc);
+	return -EINVAL;
+}
+
+
+static void core_imc_event_start(struct perf_event *event, int flags)
+{
+	int rc;
+
+	/*
+	 * Core pmu units are enabled only when it is used.
+	 * See if this is triggered for the first time.
+	 * If yes, take the mutex lock and enable the core counters.
+	 * If not, just increment the count in core_events.
+	 */
+	if (atomic_inc_return(&core_events) == 1) {
+		mutex_lock(&imc_core_reserve);
+		rc = core_imc_control(IMC_COUNTER_ENABLE);
+		mutex_unlock(&imc_core_reserve);
+		if (rc)
+			pr_err("IMC: Unbale to start the counters\n");
+	}
+	imc_event_start(event, flags);
+}
+
+static void core_imc_event_stop(struct perf_event *event, int flags)
+{
+	int rc;
+
+	imc_event_stop(event, flags);
+	/*
+	 * See if we need to disable the IMC PMU.
+	 * If no events are currently in use, then we have to take a
+	 * mutex to ensure that we don't race with another task doing
+	 * enable or disable the core counters.
+	 */
+	if (atomic_dec_return(&core_events) == 0) {
+		mutex_lock(&imc_core_reserve);
+		rc = core_imc_control(IMC_COUNTER_DISABLE);
+		mutex_unlock(&imc_core_reserve);
+		if (rc)
+			pr_err("IMC: Disable counters failed\n");
+	}
+}
+
+static int core_imc_event_add(struct perf_event *event, int flags)
+{
+	if (flags & PERF_EF_START)
+		core_imc_event_start(event, flags);
+
+	return 0;
+}
+
+
 /* update_pmu_ops : Populate the appropriate operations for "pmu" */
 static int update_pmu_ops(struct imc_pmu *pmu)
 {
@@ -391,13 +726,22 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 		return -EINVAL;
 
 	pmu->pmu.task_ctx_nr = perf_invalid_context;
-	pmu->pmu.event_init = nest_imc_event_init;
-	pmu->pmu.add = nest_imc_event_add;
-	pmu->pmu.del = nest_imc_event_stop;
-	pmu->pmu.start = nest_imc_event_start;
-	pmu->pmu.stop = nest_imc_event_stop;
+	if (pmu->domain == IMC_DOMAIN_NEST) {
+		pmu->pmu.event_init = nest_imc_event_init;
+		pmu->pmu.add = nest_imc_event_add;
+		pmu->pmu.del = nest_imc_event_stop;
+		pmu->pmu.start = nest_imc_event_start;
+		pmu->pmu.stop = nest_imc_event_stop;
+		pmu->attr_groups[IMC_CPUMASK_ATTR] = &imc_pmu_cpumask_attr_group;
+	} else if (pmu->domain == IMC_DOMAIN_CORE) {
+		pmu->pmu.event_init = core_imc_event_init;
+		pmu->pmu.add = core_imc_event_add;
+		pmu->pmu.del = core_imc_event_stop;
+		pmu->pmu.start = core_imc_event_start;
+		pmu->pmu.stop = core_imc_event_stop;
+		pmu->attr_groups[IMC_CPUMASK_ATTR] = &imc_pmu_cpumask_attr_group;
+	}
 	pmu->pmu.read = imc_perf_event_update;
-	pmu->attr_groups[IMC_CPUMASK_ATTR] = &imc_pmu_cpumask_attr_group;
 	pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
 	pmu->pmu.attr_groups = pmu->attr_groups;
 
@@ -477,9 +821,20 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
 	int ret = -ENODEV;
 
 	/* Add cpumask and register for hotplug notification */
-	ret = nest_pmu_cpumask_init();
-	if (ret)
-		return ret;
+	switch (pmu_ptr->domain) {
+	case IMC_DOMAIN_NEST:
+		ret = nest_pmu_cpumask_init();
+		if (ret)
+			return ret;
+		break;
+	case IMC_DOMAIN_CORE:
+		ret = core_imc_pmu_cpumask_init();
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -1;  /* Unknown domain */
+	}
 
 	ret = update_events_in_group(events, idx, pmu_ptr);
 	if (ret)
@@ -505,6 +860,9 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
 			kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
 		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
 	}
+	/* For core_imc, we have allocated memory, we need to free it */
+	if (pmu_ptr->domain == IMC_DOMAIN_CORE)
+		cleanup_all_core_imc_memory();
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index d712ef3..23507d7 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -562,6 +562,12 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 	return -ENODEV;
 }
 
+static void opal_imc_counters_shutdown(struct platform_device *pdev)
+{
+	/* Disable the IMC Core functions */
+	core_imc_disable();
+}
+
 static const struct of_device_id opal_imc_match[] = {
 	{ .compatible = IMC_DTB_COMPAT },
 	{},
@@ -573,6 +579,7 @@ static struct platform_driver opal_imc_driver = {
 		.of_match_table = opal_imc_match,
 	},
 	.probe = opal_imc_counters_probe,
+	.shutdown = opal_imc_counters_shutdown,
 };
 
 MODULE_DEVICE_TABLE(of, opal_imc_match);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 51dff54..e7b7712 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -138,6 +138,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
+	CPUHP_AP_PERF_POWERPC_COREIMC_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
-- 
2.7.4
