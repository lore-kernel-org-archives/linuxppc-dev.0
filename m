Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whDkK2fThzDqNx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 22:33:13 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v55CTJ12145734
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 08:33:11 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aw3p494d9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 08:33:11 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 5 Jun 2017 22:33:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v55CWwvc63111206
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 22:33:06 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v55CWV5B020337
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 22:32:32 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, tglx@linutronix.de
Subject: [PATCH v9 07/10] powerpc/perf: PMU functions for Core IMC and
 hotplugging
Date: Mon,  5 Jun 2017 18:02:01 +0530
In-Reply-To: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1496665922-702-2-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>                            
                                                                                
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
 arch/powerpc/perf/imc-pmu.c               | 327 +++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-imc.c |   7 +
 include/linux/cpuhotplug.h                |   1 +
 4 files changed, 330 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 54784a5..5227660 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -102,5 +102,6 @@ struct imc_pmu {
 
 extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 extern struct imc_pmu *core_imc_pmu;
+extern int core_imc_control(int operation);
 extern int __init init_imc_pmu(struct imc_events *events, int idx, struct imc_pmu *pmu_ptr);
 #endif /* PPC_POWERNV_IMC_PMU_DEF_H */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 463425c..6d32c3f 100644
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
 
 struct imc_pmu *core_imc_pmu;
 
@@ -53,9 +57,15 @@ static ssize_t imc_pmu_cpumask_get_attr(struct device *dev,
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
 
@@ -239,6 +249,232 @@ static void nest_imc_counters_release(struct perf_event *event)
 	}
 }
 
+static void cleanup_all_core_imc_memory(struct imc_pmu *pmu_ptr)
+{
+	struct imc_mem_info *ptr = pmu_ptr->mem_info;
+
+	if (!ptr)
+		return;
+	for (; ptr; ptr++) {
+		if (ptr->vbase[0] != 0)
+			free_pages(ptr->vbase[0], 0);
+	}
+	kfree(pmu_ptr->mem_info);
+}
+
+/* Enabling of Core Engine needs a scom operation */
+static void core_imc_control_enable(int *cpu_opal_rc)
+{
+	int rc;
+
+	rc = opal_imc_counters_start(OPAL_IMC_COUNTERS_CORE);
+	if (rc)
+		cpu_opal_rc[smp_processor_id()] = 1;
+}
+
+/*
+ * Disabling of IMC Core Engine needs a scom operation
+ */
+static void core_imc_control_disable(int *cpu_opal_rc)
+{
+	int rc;
+
+	rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE);
+	if (rc)
+		cpu_opal_rc[smp_processor_id()] = 1;
+}
+
+int core_imc_control(int operation)
+{
+	int cpu, *cpus_opal_rc;
+
+	/* Memory for OPAL call return value. */
+	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
+	if (!cpus_opal_rc)
+		return -ENOMEM;
+
+	/*
+	 * Enable or disable the core IMC PMU on each core using the
+	 * core_imc_cpumask.
+	 */
+	switch (operation) {
+
+	case IMC_COUNTER_DISABLE:
+		on_each_cpu_mask(&core_imc_cpumask,
+				(smp_call_func_t)core_imc_control_disable,
+				cpus_opal_rc, 1);
+		break;
+	case IMC_COUNTER_ENABLE:
+		on_each_cpu_mask(&core_imc_cpumask,
+				(smp_call_func_t)core_imc_control_enable,
+				cpus_opal_rc, 1);
+		break;
+	default:
+		goto fail;
+	}
+	/* Check return value array for any OPAL call failure */
+	for_each_cpu(cpu, &core_imc_cpumask) {
+		if (cpus_opal_rc[cpu])
+			goto fail;
+	}
+	return 0;
+fail:
+	if (cpus_opal_rc)
+		kfree(cpus_opal_rc);
+		return -EINVAL;
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
+		rc = core_imc_control(IMC_COUNTER_DISABLE);
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
+	struct imc_mem_info *mem_info = NULL;
+
+	phys_id = topology_physical_package_id(cpu);
+	/*
+	 * alloc_pages_exact_nid() will allocate memory for core in the
+	 * local node only.
+	 */
+	mem_info = &core_imc_pmu->mem_info[core_id];
+	mem_info->id = core_id;
+	mem_info->vbase[0] = (u64) alloc_pages_exact_nid(phys_id,
+				(size_t)size, GFP_KERNEL | __GFP_ZERO);
+	rc = opal_imc_counters_init(OPAL_IMC_COUNTERS_CORE,
+				(u64)virt_to_phys((void *)mem_info->vbase[0]),
+				get_hard_smp_processor_id(cpu));
+	if (rc) {
+		kfree(&mem_info->vbase[0]);
+		mem_info->vbase[0] = 0;
+	}
+	return rc;
+}
+
+bool is_core_imc_mem_inited(int cpu)
+{
+	struct imc_mem_info *mem_info = NULL;
+	int core_id = (cpu / threads_per_core);
+
+	mem_info = &core_imc_pmu->mem_info[core_id];
+	if ((mem_info->id == core_id) && (mem_info->vbase[0] != 0))
+		return true;
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
+static void core_imc_change_cpu_context(int old_cpu, int new_cpu)
+{
+	if (!core_imc_pmu)
+		return;
+	if (old_cpu < 0 || new_cpu < 0)
+		return;
+	perf_pmu_migrate_context(&core_imc_pmu->pmu, old_cpu, new_cpu);
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
+	} else
+		opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE);
+
+	/* set the cpu in the mask, and change the context */
+	cpumask_set_cpu(cpu, &core_imc_cpumask);
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
+	if (ncpu >= 0 && ncpu < nr_cpu_ids) {
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
@@ -298,6 +534,63 @@ static int nest_imc_event_init(struct perf_event *event)
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
+	pmu = imc_event_to_pmu(event);
+	if (!is_core_imc_mem_inited(event->cpu))
+		return -ENODEV;
+	core_id = event->cpu / threads_per_core;
+	pcmi = &pmu->mem_info[core_id];
+	if ((pcmi->id != core_id) || (pcmi->vbase[0] == 0))
+		return -ENODEV;
+	event->hw.event_base = pcmi->vbase[0] + config;
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
+			pr_err("IMC: Unable to start the counters\n");
+	}
+	event->destroy = core_imc_counters_release;
+	return 0;
+}
+
 static void imc_read_counter(struct perf_event *event)
 {
 	u64 *addr, data;
@@ -366,7 +659,11 @@ static int update_pmu_ops(struct imc_pmu *pmu)
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
@@ -451,12 +748,27 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
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
@@ -482,6 +794,9 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
 			kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
 		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
 	}
+	/* For core_imc, we have allocated memory, we need to free it */
+	if (pmu_ptr->domain == IMC_DOMAIN_CORE)
+		cleanup_all_core_imc_memory(pmu_ptr);
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index a997f83..d0d26dd 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -532,6 +532,12 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void opal_imc_counters_shutdown(struct platform_device *pdev)
+{
+	/* Disable the IMC Core functions */
+	core_imc_control(IMC_COUNTER_DISABLE);
+}
+
 static const struct of_device_id opal_imc_match[] = {
 	{ .compatible = IMC_DTB_COMPAT },
 	{},
@@ -543,6 +549,7 @@ static struct platform_driver opal_imc_driver = {
 		.of_match_table = opal_imc_match,
 	},
 	.probe = opal_imc_counters_probe,
+	.shutdown = opal_imc_counters_shutdown,
 };
 
 MODULE_DEVICE_TABLE(of, opal_imc_match);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index dca7f2b..e145fff 100644
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
