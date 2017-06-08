Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkH2t6kBvzDqVF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 06:24:38 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v58KNlX5140120
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 16:24:35 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2axxd7hn4n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 16:24:35 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 9 Jun 2017 06:24:32 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v58KOL3E56164414
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 06:24:29 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v58KNt3r029639
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 06:23:57 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com, eranian@google.com,
 benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, mikey@neuling.org, dja@axtens.net,
 anton@samba.org, tglx@linutronix.de,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: [PATCH v10 07/10] powerpc/perf: PMU functions for Core IMC and
 hotplugging
Date: Fri,  9 Jun 2017 01:53:20 +0530
Message-Id: <1496953400-16739-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Code to add PMU function to initialize a core IMC event. It also
adds cpumask initialization function for core IMC PMU. For
initialization, memory is allocated per core where the data
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
CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE is added to the list of existing
states.

Patch also adds OPAL device shutdown callback. Needed to disable the
IMC core engine to handle kexec.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        |   1 +
 arch/powerpc/include/asm/opal-api.h       |   1 +
 arch/powerpc/perf/imc-pmu.c               | 265 +++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-imc.c |   7 +
 include/linux/cpuhotplug.h                |   1 +
 5 files changed, 269 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 0f018b6510c0..88bc7ef6cc1e 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -99,5 +99,6 @@ struct imc_pmu {
 
 extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 extern struct imc_pmu *core_imc_pmu;
+extern int imc_control(unsigned long type, bool operation);
 extern int __init init_imc_pmu(struct imc_events *events, int idx, struct imc_pmu *pmu_ptr);
 #endif /* PPC_POWERNV_IMC_PMU_DEF_H */
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 7056b977df53..7a58617490cf 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -1018,6 +1018,7 @@ enum {
 /* Argument to OPAL_IMC_COUNTERS_*  */
 enum {
 	OPAL_IMC_COUNTERS_NEST = 1,
+	OPAL_IMC_COUNTERS_CORE = 2,
 };
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 08b363ac35ac..cdee29b92945 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1,5 +1,5 @@
 /*
- * Nest Performance Monitor counter support.
+ * IMC Performance Monitor counter support.
  *
  * Copyright (C) 2017 Madhavan Srinivasan, IBM Corporation.
  *           (C) 2017 Anju T Sudhakar, IBM Corporation.
@@ -24,11 +24,15 @@ extern u64 core_max_offset;
 
 struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 static cpumask_t nest_imc_cpumask;
+static cpumask_t core_imc_cpumask;
 static int nest_imc_cpumask_initialized;
 
 static atomic_t nest_events;
+static atomic_t core_events;
 /* Used to avoid races in calling enable/disable nest-pmu units */
 static DEFINE_MUTEX(imc_nest_reserve);
+/* Used to avoid races in calling enable/disable nest-pmu units */
+static DEFINE_MUTEX(imc_core_reserve);
 
 static struct cpumask imc_result_mask;
 static DEFINE_MUTEX(imc_control_mutex);
@@ -56,9 +60,15 @@ static ssize_t imc_pmu_cpumask_get_attr(struct device *dev,
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
 
@@ -107,6 +117,9 @@ int imc_control(unsigned long type, bool operation)
 	case OPAL_IMC_COUNTERS_NEST:
 		imc_domain_mask = &nest_imc_cpumask;
 		break;
+	case OPAL_IMC_COUNTERS_CORE:
+		imc_domain_mask = &core_imc_cpumask;
+		break;
 	default:
 		res = -EINVAL;
 		goto out;
@@ -223,6 +236,160 @@ static void nest_imc_counters_release(struct perf_event *event)
 	}
 }
 
+static void cleanup_all_core_imc_memory(struct imc_pmu *pmu_ptr)
+{
+	struct imc_mem_info *ptr;
+
+	for (ptr = pmu_ptr->mem_info; ptr; ptr++) {
+		if (ptr->vbase[0])
+			free_pages((u64)ptr->vbase[0], 0);
+	}
+
+	kfree(pmu_ptr->mem_info);
+}
+
+static void core_imc_counters_release(struct perf_event *event)
+{
+	int rc;
+	/*
+	 * See if we need to disable the IMC PMU.
+	 * If no events are currently in use, then we have to take a
+	 * mutex to ensure that we don't race with another task doing
+	 * enable or disable the core counters.
+	 */
+	if (atomic_dec_return(&core_events) == 0) {
+		mutex_lock(&imc_core_reserve);
+		rc = imc_control(OPAL_IMC_COUNTERS_CORE, false);
+		mutex_unlock(&imc_core_reserve);
+		if (rc)
+			pr_err("IMC: Disable counters failed\n");
+	}
+}
+
+/*
+ * core_imc_mem_init : Initializes memory for the current core.
+ *
+ * Uses alloc_pages_exact_nid() and uses the returned address as an argument to
+ * an opal call to configure the pdbar. The address sent as an argument is
+ * converted to physical address before the opal call is made. This is the
+ * base address at which the core imc counters are populated.
+ */
+static int  __meminit core_imc_mem_init(int cpu, int size)
+{
+	int phys_id, rc = 0, core_id = (cpu / threads_per_core);
+	struct imc_mem_info *mem_info;
+
+	/*
+	 * alloc_pages_exact_nid() will allocate memory for core in the
+	 * local node only.
+	 */
+	phys_id = topology_physical_package_id(cpu);
+	mem_info = &core_imc_pmu->mem_info[core_id];
+	mem_info->id = core_id;
+	mem_info->vbase[0] = alloc_pages_exact_nid(phys_id,
+				(size_t)size, GFP_KERNEL | __GFP_ZERO);
+
+	if (!mem_info->vbase[0])
+		return -ENOMEM;
+
+	rc = opal_imc_counters_init(OPAL_IMC_COUNTERS_CORE,
+				(u64)virt_to_phys((void *)mem_info->vbase[0]),
+				get_hard_smp_processor_id(cpu));
+	if (rc) {
+		free_pages((u64)mem_info->vbase[0], get_order(size));
+		mem_info->vbase[0] = NULL;
+	}
+
+	return rc;
+}
+
+bool is_core_imc_mem_inited(int cpu)
+{
+	struct imc_mem_info *mem_info;
+	int core_id = (cpu / threads_per_core);
+
+	mem_info = &core_imc_pmu->mem_info[core_id];
+	if ((mem_info->id == core_id) && (mem_info->vbase[0] != NULL))
+		return true;
+
+	return false;
+}
+
+/*
+ * imc_mem_init : Function to support memory allocation for core imc.
+ */
+static int imc_mem_init(struct imc_pmu *pmu_ptr)
+{
+	int nr_cores;
+
+	if (pmu_ptr->imc_counter_mmaped)
+		return 0;
+	nr_cores = num_present_cpus() / threads_per_core;
+	pmu_ptr->mem_info = kzalloc((sizeof(struct imc_mem_info) * nr_cores), GFP_KERNEL);
+	if (!pmu_ptr->mem_info)
+		return -ENOMEM;
+	return 0;
+}
+
+static int ppc_core_imc_cpu_online(unsigned int cpu)
+{
+	const struct cpumask *l_cpumask;
+	static struct cpumask tmp_mask;
+	int ret = 0;
+
+	/* Get the cpumask for this core */
+	l_cpumask = cpu_sibling_mask(cpu);
+
+	/* If a cpu for this core is already set, then, don't do anything */
+	if (cpumask_and(&tmp_mask, l_cpumask, &core_imc_cpumask))
+		return 0;
+
+	if (!is_core_imc_mem_inited(cpu)) {
+		ret = core_imc_mem_init(cpu, core_imc_pmu->counter_mem_size);
+		if (ret) {
+			pr_info("core_imc memory allocation for cpu %d failed\n", cpu);
+			return ret;
+		}
+	} else {
+		opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE);
+	}
+
+	/* set the cpu in the mask, and change the context */
+	cpumask_set_cpu(cpu, &core_imc_cpumask);
+	return 0;
+}
+
+static int ppc_core_imc_cpu_offline(unsigned int cpu)
+{
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
+	if (ncpu >= 0 && ncpu < nr_cpu_ids) {
+		cpumask_set_cpu(ncpu, &core_imc_cpumask);
+		perf_pmu_migrate_context(&core_imc_pmu->pmu, cpu, ncpu);
+	} else {
+		opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE);
+	}
+	return 0;
+}
+
+static int core_imc_pmu_cpumask_init(void)
+{
+	return cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
+				 "perf/powerpc/imc_core:online",
+				 ppc_core_imc_cpu_online,
+				 ppc_core_imc_cpu_offline);
+}
+
 static int nest_imc_event_init(struct perf_event *event)
 {
 	int chip_id, rc;
@@ -292,6 +459,68 @@ static int nest_imc_event_init(struct perf_event *event)
 	return 0;
 }
 
+static int core_imc_event_init(struct perf_event *event)
+{
+	int core_id, rc;
+	u64 config = event->attr.config;
+	struct imc_mem_info *pcmi;
+	struct imc_pmu *pmu;
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
+	if (!is_core_imc_mem_inited(event->cpu))
+		return -ENODEV;
+
+	pmu = imc_event_to_pmu(event);
+	core_id = event->cpu / threads_per_core;
+	pcmi = &pmu->mem_info[core_id];
+	if ((pcmi->id != core_id) || (!pcmi->vbase[0]))
+		return -ENODEV;
+
+	event->hw.event_base = (u64)pcmi->vbase[0] + config;
+	/*
+	 * Core pmu units are enabled only when it is used.
+	 * See if this is triggered for the first time.
+	 * If yes, take the mutex lock and enable the core counters.
+	 * If not, just increment the count in core_events.
+	 */
+	if (atomic_inc_return(&core_events) == 1) {
+		mutex_lock(&imc_core_reserve);
+		rc = imc_control(OPAL_IMC_COUNTERS_CORE, true);
+		mutex_unlock(&imc_core_reserve);
+		if (rc) {
+			atomic_dec_return(&core_events);
+			pr_err("IMC: Unable to start the counters\n");
+			return -ENODEV;
+		}
+	}
+	event->destroy = core_imc_counters_release;
+	return 0;
+}
+
 static void imc_read_counter(struct perf_event *event)
 {
 	u64 *addr, data;
@@ -360,7 +589,11 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 		return -EINVAL;
 
 	pmu->pmu.task_ctx_nr = perf_invalid_context;
-	pmu->pmu.event_init = nest_imc_event_init;
+	if (pmu->domain == IMC_DOMAIN_NEST) {
+		pmu->pmu.event_init = nest_imc_event_init;
+	} else if (pmu->domain == IMC_DOMAIN_CORE) {
+		pmu->pmu.event_init = core_imc_event_init;
+	}
 	pmu->pmu.add = imc_event_add;
 	pmu->pmu.del = imc_event_stop;
 	pmu->pmu.start = imc_event_start;
@@ -445,12 +678,27 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
 {
 	int ret = -ENODEV;
 
+	ret = imc_mem_init(pmu_ptr);
+	if (ret)
+		goto err_free;
+
 	/* Add cpumask and register for hotplug notification */
-	if (!nest_imc_cpumask_initialized) {
-		ret = nest_pmu_cpumask_init();
+	switch (pmu_ptr->domain) {
+	case IMC_DOMAIN_NEST:
+		if (!nest_imc_cpumask_initialized) {
+			ret = nest_pmu_cpumask_init();
+			if (ret)
+				return ret;
+			nest_imc_cpumask_initialized = 1;
+		}
+		break;
+	case IMC_DOMAIN_CORE:
+		ret = core_imc_pmu_cpumask_init();
 		if (ret)
 			return ret;
-		nest_imc_cpumask_initialized = 1;
+		break;
+	default:
+		return -1;  /* Unknown domain */
 	}
 	ret = update_events_in_group(events, idx, pmu_ptr);
 	if (ret)
@@ -476,6 +724,11 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
 			kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
 		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
 	}
+	/* For core_imc, we have allocated memory, we need to free it */
+	if (pmu_ptr->domain == IMC_DOMAIN_CORE) {
+		cleanup_all_core_imc_memory(pmu_ptr);
+		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE);
+	}
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index be6158a098dd..a3f48866ec12 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -531,6 +531,12 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void opal_imc_counters_shutdown(struct platform_device *pdev)
+{
+	/* Disable the IMC Core functions */
+	imc_control(OPAL_IMC_COUNTERS_CORE, false);
+}
+
 static const struct of_device_id opal_imc_match[] = {
 	{ .compatible = IMC_DTB_COMPAT },
 	{},
@@ -542,6 +548,7 @@ static struct platform_driver opal_imc_driver = {
 		.of_match_table = opal_imc_match,
 	},
 	.probe = opal_imc_counters_probe,
+	.shutdown = opal_imc_counters_shutdown,
 };
 
 MODULE_DEVICE_TABLE(of, opal_imc_match);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index dca7f2b07f93..e145fffec093 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -140,6 +140,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
+	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
-- 
2.7.4
