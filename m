Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxZvT2DVrzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 00:57:08 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v33EsDCS092929
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Apr 2017 10:57:07 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29kqbkdag7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 10:57:07 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 00:57:04 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v33EurYx51708112
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:57:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v33EuPPd026511
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:56:26 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v6 08/11] powerpc/perf: PMU functions for Core IMC and
 hotplugging
Date: Mon,  3 Apr 2017 20:25:05 +0530
In-Reply-To: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1491231308-15282-9-git-send-email-maddy@linux.vnet.ibm.com>
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
[Anju: Changed the condition for setting cpumask for core
in imc_pmu_cpumask_get_attr() ]
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h             |   3 +
 arch/powerpc/include/asm/opal-api.h            |  10 +-
 arch/powerpc/include/asm/opal.h                |   2 +
 arch/powerpc/perf/imc-pmu.c                    | 267 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-imc.c      |  13 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 include/linux/cpuhotplug.h                     |   1 +
 7 files changed, 287 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 2c39603ff3e7..4aa63191456a 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -21,8 +21,10 @@
 #define IMC_MAX_CHIPS			32
 #define IMC_MAX_PMUS			32
 #define IMC_MAX_PMU_NAME_LEN		256
+#define IMC_MAX_CORES			32
 
 #define IMC_NEST_MAX_PAGES		16
+#define IMC_CORE_COUNTER_MEM		8192
 
 #define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
 #define IMC_DTB_NEST_COMPAT		"ibm,imc-counters-nest"
@@ -68,4 +70,5 @@ struct imc_pmu {
 #define IMC_DOMAIN_UNKNOWN	-1
 
 int imc_get_domain(struct device_node *pmu_dev);
+void core_imc_disable(void);
 #endif /* PPC_POWERNV_IMC_PMU_DEF_H */
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 23fc51e9d71d..971918deb793 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -169,7 +169,8 @@
 #define OPAL_PCI_TCE_KILL			126
 #define OPAL_NMMU_SET_PTCR			127
 #define OPAL_NEST_IMC_COUNTERS_CONTROL		149
-#define OPAL_LAST				149
+#define OPAL_CORE_IMC_COUNTERS_CONTROL		150
+#define OPAL_LAST				150
 
 /* Device tree flags */
 
@@ -939,6 +940,13 @@ enum {
 	OPAL_NEST_IMC_START,
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
index 728c67e139e0..45f9b35142a7 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1,5 +1,5 @@
 /*
- * Nest Performance Monitor counter support.
+ * IMC Performance Monitor counter support.
  *
  * Copyright (C) 2016 Madhavan Srinivasan, IBM Corporation.
  *	     (C) 2016 Hemant K Shaw, IBM Corporation.
@@ -19,6 +19,15 @@ struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
 struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 static cpumask_t nest_imc_cpumask;
 
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
@@ -38,11 +47,18 @@ static struct attribute_group imc_format_group = {
 
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
 
@@ -58,6 +74,101 @@ static struct attribute_group imc_pmu_cpumask_attr_group = {
 };
 
 /*
+ * core_imc_mem_init : Initializes memory for the current core.
+ *
+ * Uses alloc_pages_exact_nid() and uses the returned address as an argument to
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
+	per_core_pdbar_add[phys_id][core_id] = (u64) alloc_pages_exact_nid(phys_id,
+			(size_t) IMC_CORE_COUNTER_MEM, GFP_KERNEL | __GFP_ZERO);
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
+	/* Sanity check before we migrate */
+	if (!core_imc_pmu)
+		return;
+
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
+	/*
+	 * else, first cpu in this core, so set the cpu in the mask
+	 * and enable Core imc.
+	 */
+	cpumask_set_cpu(cpu, &core_imc_cpumask);
+	opal_core_imc_counters_control(OPAL_CORE_IMC_ENABLE, 0, 0, 0);
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
+
+		/* migrate the context */
+		core_imc_change_cpu_context(cpu, target);
+	} else {
+		/* No online cpus in this core, disable core imc and return */
+		opal_core_imc_counters_control(OPAL_CORE_IMC_DISABLE, 0, 0, 0);
+	}
+
+	return 0;
+}
+
+/*
  * nest_init : Initializes the nest imc engine for the current chip.
  */
 static void nest_init(int *loc)
@@ -182,6 +293,92 @@ static int nest_pmu_cpumask_init(void)
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
+/*
+ * Disabling of IMC Core Engine needs a scom operation
+ */
+static void core_imc_control_disable(void)
+{
+	opal_core_imc_counters_control(OPAL_CORE_IMC_DISABLE, 0, 0, 0);
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
@@ -225,6 +422,44 @@ static int nest_imc_event_init(struct perf_event *event)
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
@@ -282,7 +517,11 @@ static int update_pmu_ops(struct imc_pmu *pmu)
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
@@ -358,9 +597,20 @@ int init_imc_pmu(struct imc_events *events, int idx,
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
@@ -385,6 +635,9 @@ int init_imc_pmu(struct imc_events *events, int idx,
 		kfree(pmu_ptr->attr_groups[0]->attrs);
 		kfree(pmu_ptr->attr_groups[0]);
 	}
+	/* For core_imc, we have allocated memory, we need to free it */
+	if (pmu_ptr->domain == IMC_DOMAIN_CORE)
+		cleanup_all_core_imc_memory();
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index f6f63399ab06..f261fc933959 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -192,12 +192,12 @@ static int imc_events_node_parser(struct device_node *dev,
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
@@ -211,8 +211,8 @@ static int imc_events_node_parser(struct device_node *dev,
 							 ev_name);
 				if (ret)
 					continue;
+				idx++;
 			}
-			idx++;
 		} else if (strncmp(pp->name, "unit", 4) == 0) {
 			ret = set_event_property(pp, "unit", &events[idx],
 						 ev_name);
@@ -537,6 +537,14 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 	return -ENODEV;
 }
 
+static void opal_imc_counters_shutdown(struct platform_device *pdev)
+{
+#ifdef CONFIG_PERF_EVENTS
+	/* Disable the IMC Core functions */
+	core_imc_disable();
+#endif
+}
+
 static const struct of_device_id opal_imc_match[] = {
 	{ .compatible = IMC_DTB_COMPAT },
 	{},
@@ -548,6 +556,7 @@ static struct platform_driver opal_imc_driver = {
 		.of_match_table = opal_imc_match,
 	},
 	.probe = opal_imc_counters_probe,
+	.shutdown = opal_imc_counters_shutdown,
 };
 
 MODULE_DEVICE_TABLE(of, opal_imc_match);
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
