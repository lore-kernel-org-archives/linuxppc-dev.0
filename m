Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkL0B48MzzDqbG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:14 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G7SarZ034907
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:37:05 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 296nfyewp2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:37:05 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 17:37:02 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G7aq5r38666410
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:00 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G7aRMf010405
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:28 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v5 08/13] powerpc/perf: PMU functions for Core IMC and
 hotplugging
Date: Thu, 16 Mar 2017 13:05:02 +0530
In-Reply-To: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1489649707-8021-9-git-send-email-maddy@linux.vnet.ibm.com>
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
initialization, a page of memory is allocated per core where the data
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

Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
[Anju: Changed the condition for setting cpumask for core
in imc_pmu_cpumask_get_attr() ]
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h             |   1 +
 arch/powerpc/include/asm/opal-api.h            |  10 +-
 arch/powerpc/include/asm/opal.h                |   2 +
 arch/powerpc/perf/imc-pmu.c                    | 248 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-imc.c      |   4 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 include/linux/cpuhotplug.h                     |   1 +
 7 files changed, 257 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 59de083ed6f3..5e76cd06d6d8 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -21,6 +21,7 @@
 #define IMC_MAX_CHIPS			32
 #define IMC_MAX_PMUS			32
 #define IMC_MAX_PMU_NAME_LEN		256
+#define IMC_MAX_CORES			256
 
 #define NEST_IMC_ENGINE_START		1
 #define NEST_IMC_ENGINE_STOP		0
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index e1c3d4837857..70313b13afc6 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -169,7 +169,8 @@
 #define OPAL_PCI_TCE_KILL			126
 #define OPAL_NMMU_SET_PTCR			127
 #define OPAL_NEST_IMC_COUNTERS_CONTROL		145
-#define OPAL_LAST				145
+#define OPAL_CORE_IMC_COUNTERS_CONTROL		146
+#define OPAL_LAST				146
 
 /* Device tree flags */
 
@@ -929,6 +930,13 @@ enum {
 	OPAL_PCI_TCE_KILL_ALL,
 };
 
+/* Operation argument to Core IMC */
+enum {
+	OPAL_CORE_IMC_DISABLE,
+	OPAL_CORE_IMC_ENABLE,
+	OPAL_CORE_IMC_INIT,
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index d93d08204243..c4baa6d32037 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -229,6 +229,8 @@ int64_t opal_nmmu_set_ptcr(uint64_t chip_id, uint64_t ptcr);
 
 int64_t opal_nest_imc_counters_control(uint64_t mode, uint64_t value1,
 				uint64_t value2, uint64_t value3);
+int64_t opal_core_imc_counters_control(uint64_t operation, uint64_t addr,
+				uint64_t value2, uint64_t value3);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 9a0e3bc932ef..6d5fda9279c0 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1,5 +1,5 @@
 /*
- * Nest Performance Monitor counter support.
+ * IMC Performance Monitor counter support.
  *
  * Copyright (C) 2016 Madhavan Srinivasan, IBM Corporation.
  *	     (C) 2016 Hemant K Shaw, IBM Corporation.
@@ -18,6 +18,9 @@ struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
 struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 static cpumask_t nest_imc_cpumask;
 
+/* Maintains base addresses for all the cores */
+static u64 per_core_pdbar_add[IMC_MAX_CHIPS][IMC_MAX_CORES];
+static cpumask_t core_imc_cpumask;
 struct imc_pmu *core_imc_pmu;
 
 /* Needed for sanity check */
@@ -37,11 +40,18 @@ static struct attribute_group imc_format_group = {
 
 /* Get the cpumask printed to a buffer "buf" */
 static ssize_t imc_pmu_cpumask_get_attr(struct device *dev,
-				struct device_attribute *attr, char *buf)
+					struct device_attribute *attr,
+					char *buf)
 {
+	struct pmu *pmu = dev_get_drvdata(dev);
 	cpumask_t *active_mask;
 
-	active_mask = &nest_imc_cpumask;
+	if (!strncmp(pmu->name, "nest_", strlen("nest_")))
+		active_mask = &nest_imc_cpumask;
+	 else if (!strncmp(pmu->name, "core_", strlen("core_")))
+		active_mask = &core_imc_cpumask;
+	else
+		return 0;
 	return cpumap_print_to_pagebuf(true, buf, active_mask);
 }
 
@@ -57,6 +67,94 @@ static struct attribute_group imc_pmu_cpumask_attr_group = {
 };
 
 /*
+ * core_imc_mem_init : Initializes memory for the current core.
+ *
+ * Uses __get_free_pages() and uses the returned address as an argument to
+ * an opal call to configure the pdbar. The address sent as an argument is
+ * converted to physical address before the opal call is made. This is the
+ * base address at which the core imc counters are populated.
+ */
+static int core_imc_mem_init(void)
+{
+	int core_id, phys_id;
+	int rc = -1;
+
+	phys_id = topology_physical_package_id(smp_processor_id());
+	core_id = smp_processor_id() / threads_per_core;
+
+	per_core_pdbar_add[phys_id][core_id] =
+		(u64)__get_free_pages(GFP_KERNEL |  __GFP_ZERO, 0);
+	rc = opal_core_imc_counters_control(OPAL_CORE_IMC_INIT,
+				       (u64)virt_to_phys((void *)per_core_pdbar_add[phys_id][core_id]),
+		 0, 0);
+
+	return rc;
+}
+
+/*
+ * Calls core_imc_mem_init and checks the return value.
+ */
+static void core_imc_init(int *loc)
+{
+	int rc = 0;
+
+	rc = core_imc_mem_init();
+	if (rc)
+		loc[smp_processor_id()] = 1;
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
+	} else
+		target = -1;
+
+	/* migrate the context */
+	core_imc_change_cpu_context(cpu, target);
+
+	return 0;
+}
+
+/*
  * nest_init : Initializes the nest imc engine for the current chip.
  */
 static void nest_init(int *loc)
@@ -189,6 +287,86 @@ static int nest_pmu_cpumask_init(void)
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
+static void core_imc_control_disable(void)
+{
+	opal_core_imc_counters_control(OPAL_CORE_IMC_DISABLE, 0, 0, 0);
+}
+
+static void core_imc_disable(void)
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
+	/* First, disable the core imc engine */
+	core_imc_disable();
+	/* Then, free up the allocated pages */
+	cleanup_all_core_imc_memory();
+	return -ENODEV;
+}
+
 static int nest_imc_event_init(struct perf_event *event)
 {
 	int chip_id;
@@ -226,6 +404,44 @@ static int nest_imc_event_init(struct perf_event *event)
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
+	event->hw.event_base = per_core_pdbar_add[phys_id][core_id] +
+		(config & ~PAGE_MASK);
+
+	return 0;
+}
+
 static void imc_read_counter(struct perf_event *event)
 {
 	u64 *addr, data;
@@ -273,7 +489,11 @@ static int update_pmu_ops(struct imc_pmu *pmu)
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
@@ -349,9 +569,20 @@ int init_imc_pmu(struct imc_events *events, int idx,
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
@@ -376,6 +607,9 @@ int init_imc_pmu(struct imc_events *events, int idx,
 		kfree(pmu_ptr->attr_groups[0]->attrs);
 		kfree(pmu_ptr->attr_groups[0]);
 	}
+	/* For core_imc, we have allocated memory, we need to free it */
+	if (pmu_ptr->domain == IMC_DOMAIN_CORE)
+		cleanup_all_core_imc_memory();
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 8c52fffec9fe..3d60549d006f 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -191,12 +191,12 @@ static int imc_events_node_parser(struct device_node *dev,
 				kfree(events[idx].ev_value);
 				continue;
 			}
+			idx++;
 			/*
 			 * If the common scale and unit properties available,
 			 * then, assign them to this event
 			 */
 			if (event_scale) {
-				idx++;
 				ret = set_event_property(event_scale, "scale",
 							 &events[idx],
 							 ev_name);
@@ -210,8 +210,8 @@ static int imc_events_node_parser(struct device_node *dev,
 							 ev_name);
 				if (ret)
 					continue;
+				idx++;
 			}
-			idx++;
 		} else if (strncmp(pp->name, "unit", 4) == 0) {
 			ret = set_event_property(pp, "unit", &events[idx],
 						 ev_name);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index b7208d8e6cc0..672d26ba94b7 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -302,3 +302,4 @@ OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
 OPAL_CALL(opal_nest_imc_counters_control,	OPAL_NEST_IMC_COUNTERS_CONTROL);
+OPAL_CALL(opal_core_imc_counters_control,	OPAL_CORE_IMC_COUNTERS_CONTROL);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index cfb0cedc72af..abde85d9511a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -137,6 +137,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_CCN_ONLINE,
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
+	CPUHP_AP_PERF_POWERPC_COREIMC_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
-- 
2.7.4
