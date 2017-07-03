Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1Mb90v60zDrCM
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 19:41:24 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v639dPdJ077859
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 05:41:21 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2beytt3eyc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 05:41:20 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 3 Jul 2017 19:41:16 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v639dibv5701952
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 19:39:52 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v639dJFB025288
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 19:39:19 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, tglx@linutronix.de
Subject: [PATCH v12 07/10] powerpc/perf: PMU functions for Core IMC and
 hotplugging
Date: Mon,  3 Jul 2017 15:08:47 +0530
In-Reply-To: <1499074728-30680-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1499074728-30680-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1499074728-30680-2-git-send-email-anju@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/opal-api.h       |   1 +
 arch/powerpc/perf/imc-pmu.c               | 371 +++++++++++++++++++++++++++---
 arch/powerpc/platforms/powernv/opal-imc.c |  25 ++
 include/linux/cpuhotplug.h                |   1 +
 4 files changed, 371 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index fdacb030cd77..0d83427b7467 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -1009,6 +1009,7 @@ enum {
 /* Argument to OPAL_IMC_COUNTERS_*  */
 enum {
 	OPAL_IMC_COUNTERS_NEST = 1,
+	OPAL_IMC_COUNTERS_CORE = 2,
 };
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 041d3097d42a..c1a275ed2510 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1,5 +1,5 @@
 /*
- * Nest Performance Monitor counter support.
+ * IMC Performance Monitor counter support.
  *
  * Copyright (C) 2017 Madhavan Srinivasan, IBM Corporation.
  *           (C) 2017 Anju T Sudhakar, IBM Corporation.
@@ -21,6 +21,7 @@
 /* Needed for sanity check */
 struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 static cpumask_t nest_imc_cpumask;
+static cpumask_t core_imc_cpumask;
 static int nest_imc_cpumask_initialized;
 static int nest_pmus;
 /*
@@ -30,7 +31,7 @@ static int nest_pmus;
 static DEFINE_MUTEX(imc_nest_inited_reserve);
 
 struct imc_pmu_ref *nest_imc_refc;
-
+struct imc_pmu_ref *core_imc_refc;
 struct imc_pmu *core_imc_pmu;
 
 struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
@@ -55,14 +56,32 @@ static struct attribute_group imc_format_group = {
 	.attrs = nest_imc_format_attrs,
 };
 
+static struct attribute *core_imc_format_attrs[] = {
+	&format_attr_event.attr,
+	&format_attr_offset.attr,
+	&format_attr_rvalue.attr,
+	NULL,
+};
+
+static struct attribute_group core_imc_format_group = {
+	.name = "format",
+	.attrs = core_imc_format_attrs,
+};
+
 /* Get the cpumask printed to a buffer "buf" */
 static ssize_t imc_pmu_cpumask_get_attr(struct device *dev,
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
 
@@ -313,6 +332,242 @@ static int nest_imc_event_init(struct perf_event *event)
 	return 0;
 }
 
+/*
+ * core_imc_mem_init : Initializes memory for the current core.
+ *
+ * Uses alloc_pages_node() and uses the returned address as an argument to
+ * an opal call to configure the pdbar. The address sent as an argument is
+ * converted to physical address before the opal call is made. This is the
+ * base address at which the core imc counters are populated.
+ */
+static int core_imc_mem_init(int cpu, int size)
+{
+	int phys_id, rc = 0, core_id = (cpu / threads_per_core);
+	struct imc_mem_info *mem_info;
+
+	/*
+	 * alloc_pages_node() will allocate memory for core in the
+	 * local node only.
+	 */
+	phys_id = topology_physical_package_id(cpu);
+	mem_info = &core_imc_pmu->mem_info[core_id];
+	mem_info->id = core_id;
+
+	/* We need only vbase[0] for core counters */
+	mem_info->vbase[0] = page_address(alloc_pages_node(phys_id,
+					  GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
+					  get_order(size)));
+	if (!mem_info->vbase[0])
+		return -ENOMEM;
+
+	/* Init the mutex */
+	core_imc_refc[core_id].id = core_id;
+	mutex_init(&core_imc_refc[core_id].lock);
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
+static bool is_core_imc_mem_inited(int cpu)
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
+		opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE,
+				       get_hard_smp_processor_id(cpu));
+	}
+
+	/* set the cpu in the mask, and change the context */
+	cpumask_set_cpu(cpu, &core_imc_cpumask);
+	return 0;
+}
+
+static int ppc_core_imc_cpu_offline(unsigned int cpu)
+{
+	unsigned int ncpu, core_id;
+	struct imc_pmu_ref *ref;
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
+		/*
+		 * If this is the last cpu in this core then, skip the lock and
+		 * make the reference count for this core zero.
+		 */
+		opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE,
+				       get_hard_smp_processor_id(cpu));
+		core_id = cpu / threads_per_core;
+		ref = &core_imc_refc[core_id];
+		if (!ref)
+			return -EINVAL;
+
+		ref->refc = 0;
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
+static void core_imc_counters_release(struct perf_event *event)
+{
+	int rc, core_id;
+	struct imc_pmu_ref *ref;
+
+	if (event->cpu < 0)
+		return;
+	/*
+	 * See if we need to disable the IMC PMU.
+	 * If no events are currently in use, then we have to take a
+	 * mutex to ensure that we don't race with another task doing
+	 * enable or disable the core counters.
+	 */
+	core_id = event->cpu / threads_per_core;
+
+	/* Take the mutex lock and decrement the refernce count for this core */
+	ref = &core_imc_refc[core_id];
+	if (!ref)
+		return;
+
+	mutex_lock(&ref->lock);
+	ref->refc--;
+	if (ref->refc == 0) {
+		rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE,
+					    get_hard_smp_processor_id(event->cpu));
+		if (rc) {
+			mutex_unlock(&ref->lock);
+			pr_err("IMC: Unable to stop the counters for core %d\n", core_id);
+			return;
+		}
+	} else if (ref->refc < 0) {
+		WARN(1, "core-imc: Invalid event reference count\n");
+		ref->refc = 0;
+	}
+	mutex_unlock(&ref->lock);
+}
+
+static int core_imc_event_init(struct perf_event *event)
+{
+	int core_id, rc;
+	u64 config = event->attr.config;
+	struct imc_mem_info *pcmi;
+	struct imc_pmu *pmu;
+	struct imc_pmu_ref *ref;
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
+	pmu = imc_event_to_pmu(event);
+
+	/* Sanity check for config (event offset and rvalue) */
+	if (((config & IMC_EVENT_OFFSET_MASK) > pmu->counter_mem_size) ||
+	    ((config & IMC_EVENT_RVALUE_MASK) != 0))
+		return -EINVAL;
+
+	if (!is_core_imc_mem_inited(event->cpu))
+		return -ENODEV;
+
+	core_id = event->cpu / threads_per_core;
+	pcmi = &pmu->mem_info[core_id];
+	if ((pcmi->id != core_id) || (!pcmi->vbase[0]))
+		return -ENODEV;
+
+	event->hw.event_base = (u64)pcmi->vbase[0] + (config & IMC_EVENT_OFFSET_MASK);
+
+	/*
+	 * Core pmu units are enabled only when it is used.
+	 * See if this is triggered for the first time.
+	 * If yes, take the mutex lock and enable the core counters.
+	 * If not, just increment the count in core_imc_refc struct.
+	 */
+	ref = &core_imc_refc[core_id];
+	if (!ref)
+		return -EINVAL;
+
+	mutex_lock(&ref->lock);
+	if (ref->refc == 0) {
+		rc = opal_imc_counters_start(OPAL_IMC_COUNTERS_CORE,
+					     get_hard_smp_processor_id(event->cpu));
+		if (rc) {
+			mutex_unlock(&ref->lock);
+			pr_err("IMC: Unable to start the counters for core %d\n", core_id);
+			return rc;
+		}
+	}
+	++ref->refc;
+	mutex_unlock(&ref->lock);
+
+	event->destroy = core_imc_counters_release;
+	return 0;
+}
+
 static void imc_read_counter(struct perf_event *event)
 {
 	u64 *addr, data;
@@ -381,14 +636,19 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 		return -EINVAL;
 
 	pmu->pmu.task_ctx_nr = perf_invalid_context;
-	pmu->pmu.event_init = nest_imc_event_init;
+	if (pmu->domain == IMC_DOMAIN_NEST) {
+		pmu->pmu.event_init = nest_imc_event_init;
+		pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
+	} else if (pmu->domain == IMC_DOMAIN_CORE) {
+		pmu->pmu.event_init = core_imc_event_init;
+		pmu->attr_groups[IMC_FORMAT_ATTR] = &core_imc_format_group;
+	}
 	pmu->pmu.add = imc_event_add;
 	pmu->pmu.del = imc_event_stop;
 	pmu->pmu.start = imc_event_start;
 	pmu->pmu.stop = imc_event_stop;
 	pmu->pmu.read = imc_perf_event_update;
 	pmu->attr_groups[IMC_CPUMASK_ATTR] = &imc_pmu_cpumask_attr_group;
-	pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
 	pmu->pmu.attr_groups = pmu->attr_groups;
 
 	return 0;
@@ -474,6 +734,42 @@ static int init_nest_pmu_ref(void)
 	return 0;
 }
 
+static void cleanup_all_core_imc_memory(struct imc_pmu *pmu_ptr)
+{
+	int i, nr_cores = num_present_cpus() / threads_per_core;
+	struct imc_mem_info *ptr = pmu_ptr->mem_info;
+
+	for (i = 0; i < nr_cores; i++) {
+		if (&ptr[i] && ptr[i].vbase[0])
+			free_pages((u64)ptr->vbase[0], 0);
+	}
+	kfree(pmu_ptr->mem_info);
+	kfree(core_imc_refc);
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
+
+	nr_cores = num_present_cpus() / threads_per_core;
+	pmu_ptr->mem_info = kzalloc((sizeof(struct imc_mem_info) * nr_cores), GFP_KERNEL);
+	if (!pmu_ptr->mem_info)
+		return -ENOMEM;
+
+	core_imc_refc = kzalloc((sizeof(struct imc_pmu_ref) * nr_cores),
+				 GFP_KERNEL);
+	if (!core_imc_refc)
+		return -ENOMEM;
+
+	return 0;
+}
+
 /*
  * init_imc_pmu : Setup and register the IMC pmu device.
  *
@@ -489,32 +785,48 @@ int init_imc_pmu(struct imc_events *events, int idx,
 {
 	int ret;
 
-	/*
-	 * Register for cpu hotplug notification.
-	 *
-	 * Nest imc pmu need only one cpu per chip, we initialize the cpumask
-	 * for the first nest imc pmu and use the same for the rest.
-	 * To handle the cpuhotplug callback unregister, we track the number of
-	 * nest pmus in "nest_pmus".
-	 * "nest_imc_cpumask_initialized" is set to zero during cpuhotplug
-	 * callback unregister.
-	 */
-	mutex_lock(&imc_nest_inited_reserve);
-	if (nest_pmus == 0) {
-		ret = init_nest_pmu_ref();
-		if (ret) {
-			mutex_unlock(&imc_nest_inited_reserve);
-			goto err_free;
+	ret = imc_mem_init(pmu_ptr);
+	if (ret)
+		goto err_free;
+
+	/* Register for cpu hotplug notification. */
+	switch (pmu_ptr->domain) {
+	case IMC_DOMAIN_NEST:
+		/*
+		* Nest imc pmu need only one cpu per chip, we initialize the
+		* cpumask for the first nest imc pmu and use the same for the
+		* rest. To handle the cpuhotplug callback unregister, we track
+		* the number of nest pmus in "nest_pmus".
+		* "nest_imc_cpumask_initialized" is set to zero during cpuhotplug
+		* callback unregister.
+		*/
+		mutex_lock(&imc_nest_inited_reserve);
+		if (nest_pmus == 0) {
+			ret = init_nest_pmu_ref();
+			if (ret) {
+				mutex_unlock(&imc_nest_inited_reserve);
+				goto err_free;
+			}
+			ret = nest_pmu_cpumask_init();
+			if (ret) {
+				mutex_unlock(&imc_nest_inited_reserve);
+				goto err_free;
+			}
+			nest_imc_cpumask_initialized = 1;
 		}
-		ret = nest_pmu_cpumask_init();
+		nest_pmus++;
+		mutex_unlock(&imc_nest_inited_reserve);
+		break;
+	case IMC_DOMAIN_CORE:
+		ret = core_imc_pmu_cpumask_init();
 		if (ret) {
-			mutex_unlock(&imc_nest_inited_reserve);
-			goto err_free;
+			cleanup_all_core_imc_memory(pmu_ptr);
+			return ret;
 		}
-		nest_imc_cpumask_initialized = 1;
+		break;
+	default:
+		return  -1;	/* Unknown domain */
 	}
-	nest_pmus++;
-	mutex_unlock(&imc_nest_inited_reserve);
 
 	ret = update_events_in_group(events, idx, pmu_ptr);
 	if (ret)
@@ -557,5 +869,10 @@ int init_imc_pmu(struct imc_events *events, int idx,
 		}
 		mutex_unlock(&imc_nest_inited_reserve);
 	}
+	/* For core_imc, we have allocated memory, we need to free it */
+	if (pmu_ptr->domain == IMC_DOMAIN_CORE) {
+		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE);
+		cleanup_all_core_imc_memory(pmu_ptr);
+	}
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index aeef59b66420..91b8dd8d7619 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -33,6 +33,7 @@
 #include <asm/uaccess.h>
 #include <asm/cputable.h>
 #include <asm/imc-pmu.h>
+#include <asm/cputhreads.h>
 
 static int imc_event_prop_update(char *name, struct imc_events *events)
 {
@@ -486,6 +487,22 @@ static void disable_nest_pmu_counters(void)
 	}
 }
 
+static void disable_core_pmu_counters(void)
+{
+	cpumask_t cores_map;
+	int cpu, rc;
+
+	/* Disable the IMC Core functions */
+	cores_map = cpu_online_cores_map();
+	for_each_cpu(cpu, &cores_map) {
+		rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE,
+					    get_hard_smp_processor_id(cpu));
+		if (rc)
+			pr_err("%s: Failed to stop Core (cpu = %d)\n",
+				__FUNCTION__, cpu);
+	}
+}
+
 static int opal_imc_counters_probe(struct platform_device *pdev)
 {
 	struct device_node *imc_dev = NULL;
@@ -501,6 +518,7 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 	 */
 	if (is_kdump_kernel()) {
 		disable_nest_pmu_counters();
+		disable_core_pmu_counters();
 		return -ENODEV;
 	}
 	imc_dev = pdev->dev.of_node;
@@ -521,6 +539,12 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void opal_imc_counters_shutdown(struct platform_device *pdev)
+{
+	/* Disable the IMC Core functions */
+	disable_core_pmu_counters();
+}
+
 static const struct of_device_id opal_imc_match[] = {
 	{ .compatible = IMC_DTB_COMPAT },
 	{},
@@ -532,6 +556,7 @@ static struct platform_driver opal_imc_driver = {
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
2.11.0
