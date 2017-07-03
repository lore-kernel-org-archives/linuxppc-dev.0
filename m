Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1MYV4w61zDr8t
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 19:39:58 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v639dNnf089833
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 05:39:56 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bfc02ygg0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 05:39:56 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 3 Jul 2017 19:39:53 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v639dg9F8519994
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 19:39:50 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v639dGt9025172
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 19:39:17 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, tglx@linutronix.de
Subject: [PATCH v12 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug support
Date: Mon,  3 Jul 2017 15:08:46 +0530
Message-Id: <1499074728-30680-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds cpumask attribute to be used by each IMC pmu. Only one cpu (any            
online CPU) from each chip for nest PMUs is designated to read counters.        
                                                                                
On CPU hotplug, dying CPU is checked to see whether it is one of the            
designated cpus, if yes, next online cpu from the same chip (for nest           
units) is designated as new cpu to read counters. For this purpose, we          
introduce a new state : CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE.                  
                                                                                
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>                        
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>                         
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com> 
---
 arch/powerpc/include/asm/imc-pmu.h             |  11 +
 arch/powerpc/include/asm/opal-api.h            |  10 +-
 arch/powerpc/include/asm/opal.h                |   4 +
 arch/powerpc/perf/imc-pmu.c                    | 280 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-imc.c      |  21 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   3 +
 include/linux/cpuhotplug.h                     |   1 +
 7 files changed, 324 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 25d0c57d14fe..aeed903b2a79 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -24,6 +24,7 @@
  * For static allocation of some of the structures.
  */
 #define IMC_MAX_PMUS			32
+#define IMC_MAX_CHIPS			32
 
 /*
  * This macro is used for memory buffer allocation of
@@ -94,6 +95,16 @@ struct imc_pmu {
 	const struct attribute_group *attr_groups[4];
 };
 
+/*
+ * Structure to hold id, lock and reference count for the imc events which
+ * are inited.
+ */
+struct imc_pmu_ref {
+       unsigned int id;
+       struct mutex lock;
+       int refc;
+};
+
 /* In-Memory Collection Counters Type */
 enum {
 	IMC_COUNTER_PER_CHIP            = 0x10,
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index cb3e6242a78c..fdacb030cd77 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -190,7 +190,10 @@
 #define OPAL_NPU_INIT_CONTEXT			146
 #define OPAL_NPU_DESTROY_CONTEXT		147
 #define OPAL_NPU_MAP_LPAR			148
-#define OPAL_LAST				148
+#define OPAL_IMC_COUNTERS_INIT			149
+#define OPAL_IMC_COUNTERS_START			150
+#define OPAL_IMC_COUNTERS_STOP			151
+#define OPAL_LAST				151
 
 /* Device tree flags */
 
@@ -1003,6 +1006,11 @@ enum {
 	XIVE_DUMP_EMU_STATE	= 5,
 };
 
+/* Argument to OPAL_IMC_COUNTERS_*  */
+enum {
+	OPAL_IMC_COUNTERS_NEST = 1,
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 588fb1c23af9..48842d2d465c 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -268,6 +268,10 @@ int64_t opal_xive_free_irq(uint32_t girq);
 int64_t opal_xive_sync(uint32_t type, uint32_t id);
 int64_t opal_xive_dump(uint32_t type, uint32_t id);
 
+int64_t opal_imc_counters_init(uint32_t type, uint64_t address, uint64_t cpu);
+int64_t opal_imc_counters_start(uint32_t type, uint64_t cpu_pir);
+int64_t opal_imc_counters_stop(uint32_t type, uint64_t cpu_pir);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 4e2f837b8bb7..ca9662bea7d6 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -20,6 +20,16 @@
 
 /* Needed for sanity check */
 struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+static cpumask_t nest_imc_cpumask;
+static int nest_imc_cpumask_initialized;
+static int nest_pmus;
+/*
+ * Used to avoid races in counting the nest-pmu units during hotplug
+ * register and unregister
+ */
+static DEFINE_MUTEX(imc_nest_inited_reserve);
+
+struct imc_pmu_ref *nest_imc_refc;
 
 struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
 {
@@ -43,12 +53,183 @@ static struct attribute_group imc_format_group = {
 	.attrs = nest_imc_format_attrs,
 };
 
+/* Get the cpumask printed to a buffer "buf" */
+static ssize_t imc_pmu_cpumask_get_attr(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	cpumask_t *active_mask;
+
+	active_mask = &nest_imc_cpumask;
+	return cpumap_print_to_pagebuf(true, buf, active_mask);
+}
+
+static DEVICE_ATTR(cpumask, S_IRUGO, imc_pmu_cpumask_get_attr, NULL);
+
+static struct attribute *imc_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static struct attribute_group imc_pmu_cpumask_attr_group = {
+	.attrs = imc_pmu_cpumask_attrs,
+};
+
+static void nest_change_cpu_context(int old_cpu, int new_cpu)
+{
+	struct imc_pmu **pn = per_nest_pmu_arr;
+	int i;
+
+	if (old_cpu < 0 || new_cpu < 0)
+		return;
+
+	for (i = 0; *pn && i < IMC_MAX_PMUS; i++, pn++)
+		perf_pmu_migrate_context(&(*pn)->pmu, old_cpu, new_cpu);
+}
+
+/* get_nest_pmu_ref: Return the imc_pmu_ref struct for the given node */
+static struct imc_pmu_ref *get_nest_pmu_ref(unsigned int node_id)
+{
+	int nid, i = 0;
+
+	if (!nest_imc_refc)
+		return NULL;
+
+	for_each_online_node(nid) {
+		if (nest_imc_refc[i].id == node_id)
+			return &nest_imc_refc[i];
+		i++;
+	}
+	return NULL;
+}
+
+static int ppc_nest_imc_cpu_offline(unsigned int cpu)
+{
+	int nid, target = -1;
+	const struct cpumask *l_cpumask;
+	struct imc_pmu_ref *ref;
+
+	/*
+	 * Check in the designated list for this cpu. Dont bother
+	 * if not one of them.
+	 */
+	if (!cpumask_test_and_clear_cpu(cpu, &nest_imc_cpumask))
+		return 0;
+
+	/*
+	 * Now that this cpu is one of the designated,
+	 * find a next cpu a) which is online and b) in same chip.
+	 */
+	nid = cpu_to_node(cpu);
+	l_cpumask = cpumask_of_node(nid);
+	target = cpumask_any_but(l_cpumask, cpu);
+
+	/*
+	 * Update the cpumask with the target cpu and
+	 * migrate the context if needed
+	 */
+	if (target >= 0 && target < nr_cpu_ids) {
+		cpumask_set_cpu(target, &nest_imc_cpumask);
+		nest_change_cpu_context(cpu, target);
+	} else {
+		opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST,
+				       get_hard_smp_processor_id(cpu));
+		/*
+		 * If this is the last cpu in this chip then, skip the lock and
+		 * make the reference count on this chip zero.
+		 */
+		ref = get_nest_pmu_ref(nid);
+		if (!ref)
+			return -EINVAL;
+
+		ref->refc = 0;
+	}
+	return 0;
+}
+
+static int ppc_nest_imc_cpu_online(unsigned int cpu)
+{
+	const struct cpumask *l_cpumask;
+	static struct cpumask tmp_mask;
+	int res;
+
+	/* Get the cpumask of this node */
+	l_cpumask = cpumask_of_node(cpu_to_node(cpu));
+
+	/*
+	 * If this is not the first online CPU on this node, then
+	 * just return.
+	 */
+	if (cpumask_and(&tmp_mask, l_cpumask, &nest_imc_cpumask))
+		return 0;
+
+	/*
+	 * If this is the first online cpu on this node
+	 * disable the nest counters by making an OPAL call.
+	 */
+	res = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST,
+				     get_hard_smp_processor_id(cpu));
+	if (res)
+		return res;
+
+	/* Make this CPU the designated target for counter collection */
+	cpumask_set_cpu(cpu, &nest_imc_cpumask);
+	return 0;
+}
+
+static int nest_pmu_cpumask_init(void)
+{
+	return cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
+				 "perf/powerpc/imc:online",
+				 ppc_nest_imc_cpu_online,
+				 ppc_nest_imc_cpu_offline);
+}
+
+static void nest_imc_counters_release(struct perf_event *event)
+{
+	int rc, node_id;
+	struct imc_pmu_ref *ref;
+
+	if (event->cpu < 0)
+		return;
+
+	node_id = cpu_to_node(event->cpu);
+
+	/*
+	 * See if we need to disable the nest PMU.
+	 * If no events are currently in use, then we have to take a
+	 * mutex to ensure that we don't race with another task doing
+	 * enable or disable the nest counters.
+	 */
+	ref = get_nest_pmu_ref(node_id);
+	if (!ref)
+		return;
+
+	/* Take the mutex lock for this node and then decrement the reference count */
+	mutex_lock(&ref->lock);
+	ref->refc--;
+	if (ref->refc == 0) {
+		rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST,
+					    get_hard_smp_processor_id(event->cpu));
+		if (rc) {
+			mutex_unlock(&nest_imc_refc[node_id].lock);
+			pr_err("IMC: Unable to stop the counters for core %d\n", node_id);
+			return;
+		}
+	} else if (ref->refc < 0) {
+		WARN(1, "nest-imc: Invalid event reference count\n");
+		ref->refc = 0;
+	}
+	mutex_unlock(&ref->lock);
+}
+
 static int nest_imc_event_init(struct perf_event *event)
 {
-	int chip_id;
+	int chip_id, rc, node_id;
 	u32 l_config, config = event->attr.config;
 	struct imc_mem_info *pcni;
 	struct imc_pmu *pmu;
+	struct imc_pmu_ref *ref;
 	bool flag = false;
 
 	if (event->attr.type != event->pmu->type)
@@ -102,6 +283,31 @@ static int nest_imc_event_init(struct perf_event *event)
 	l_config = config & IMC_EVENT_OFFSET_MASK;
 	event->hw.event_base = (u64)pcni->vbase[l_config/PAGE_SIZE] +
 			       (l_config & ~PAGE_MASK);
+	node_id = cpu_to_node(event->cpu);
+
+	/*
+	 * Get the imc_pmu_ref struct for this node.
+	 * Take the mutex lock and then increment the count of nest pmu events
+	 * inited.
+	 */
+	ref = get_nest_pmu_ref(node_id);
+	if (!ref)
+		return -EINVAL;
+
+	mutex_lock(&ref->lock);
+	if (ref->refc == 0) {
+		rc = opal_imc_counters_start(OPAL_IMC_COUNTERS_NEST,
+					     get_hard_smp_processor_id(event->cpu));
+		if (rc) {
+			mutex_unlock(&nest_imc_refc[node_id].lock);
+			pr_err("IMC: Unable to start the counters for node %d\n", node_id);
+			return rc;
+		}
+	}
+	++ref->refc;
+	mutex_unlock(&ref->lock);
+
+	event->destroy = nest_imc_counters_release;
 	return 0;
 }
 
@@ -179,6 +385,7 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 	pmu->pmu.start = imc_event_start;
 	pmu->pmu.stop = imc_event_stop;
 	pmu->pmu.read = imc_perf_event_update;
+	pmu->attr_groups[IMC_CPUMASK_ATTR] = &imc_pmu_cpumask_attr_group;
 	pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
 	pmu->pmu.attr_groups = pmu->attr_groups;
 
@@ -242,18 +449,71 @@ static int update_events_in_group(struct imc_events *events,
 	return 0;
 }
 
+/* init_nest_pmu_ref: Initialize the imc_pmu_ref struct for all the nodes */
+static int init_nest_pmu_ref(void)
+{
+	int nid, i = 0;
+
+	nest_imc_refc = kzalloc((sizeof(struct imc_pmu_ref) *
+				 IMC_MAX_CHIPS), GFP_KERNEL);
+
+	if (!nest_imc_refc)
+		return -ENOMEM;
+
+	for_each_online_node(nid) {
+		nest_imc_refc[i].id = nid;
+		/*
+		 * Mutex lock to avoid races while tracking the number of
+		 * sessions using the chip's nest pmu units.
+		 */
+		mutex_init(&nest_imc_refc[i].lock);
+		i++;
+	}
+	return 0;
+}
+
 /*
  * init_imc_pmu : Setup and register the IMC pmu device.
  *
  * @events:	events memory for this pmu.
  * @idx:	number of event entries created.
  * @pmu_ptr:	memory allocated for this pmu.
+ *
+ * init_imc_pmu() setup the cpu mask information for these pmus and setup
+ * the state machine hotplug notifiers as well.
  */
 int init_imc_pmu(struct imc_events *events, int idx,
 		 struct imc_pmu *pmu_ptr)
 {
 	int ret;
 
+	/*
+	 * Register for cpu hotplug notification.
+	 *
+	 * Nest imc pmu need only one cpu per chip, we initialize the cpumask
+	 * for the first nest imc pmu and use the same for the rest.
+	 * To handle the cpuhotplug callback unregister, we track the number of
+	 * nest pmus in "nest_pmus".
+	 * "nest_imc_cpumask_initialized" is set to zero during cpuhotplug
+	 * callback unregister.
+	 */
+	mutex_lock(&imc_nest_inited_reserve);
+	if (nest_pmus == 0) {
+		ret = init_nest_pmu_ref();
+		if (ret) {
+			mutex_unlock(&imc_nest_inited_reserve);
+			goto err_free;
+		}
+		ret = nest_pmu_cpumask_init();
+		if (ret) {
+			mutex_unlock(&imc_nest_inited_reserve);
+			goto err_free;
+		}
+		nest_imc_cpumask_initialized = 1;
+	}
+	nest_pmus++;
+	mutex_unlock(&imc_nest_inited_reserve);
+
 	ret = update_events_in_group(events, idx, pmu_ptr);
 	if (ret)
 		goto err_free;
@@ -278,6 +538,22 @@ int init_imc_pmu(struct imc_events *events, int idx,
 			kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
 		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
 	}
-
+	if (pmu_ptr->domain == IMC_DOMAIN_NEST) {
+		/*
+		 * If no nest pmu units are registered, then obtain the mutex
+		 * lock and unregister the hotplug callback.
+		 */
+		mutex_lock(&imc_nest_inited_reserve);
+		--nest_pmus;
+		if (nest_pmus <= 0) {
+			if (nest_imc_cpumask_initialized == 1) {
+				cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE);
+				nest_imc_cpumask_initialized = 0;
+			}
+			kfree(nest_imc_refc);
+			nest_pmus = 0;
+		}
+		mutex_unlock(&imc_nest_inited_reserve);
+	}
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index a68d66d1ddb1..406f7c10850a 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -467,6 +467,19 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
 	return ret;
 }
 
+static void disable_nest_pmu_counters(void)
+{
+	int nid, cpu;
+	struct cpumask *l_cpumask;
+
+	for_each_online_node(nid) {
+		l_cpumask = cpumask_of_node(nid);
+		cpu = cpumask_first(l_cpumask);
+		opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST,
+				       get_hard_smp_processor_id(cpu));
+	}
+}
+
 static int opal_imc_counters_probe(struct platform_device *pdev)
 {
 	struct device_node *imc_dev = NULL;
@@ -477,11 +490,13 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/*
-	 * Check whether this is kdump kernel. If yes, just return.
+	 * Check whether this is kdump kernel. If yes, force the engines to
+	 * stop and return.
 	 */
-	if (is_kdump_kernel())
+	if (is_kdump_kernel()) {
+		disable_nest_pmu_counters();
 		return -ENODEV;
-
+	}
 	imc_dev = pdev->dev.of_node;
 	if (!imc_dev)
 		return -ENODEV;
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index f620572f891f..1828b24fbb53 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -310,3 +310,6 @@ OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
 OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
 OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
 OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
+OPAL_CALL(opal_imc_counters_init,              OPAL_IMC_COUNTERS_INIT);
+OPAL_CALL(opal_imc_counters_start,             OPAL_IMC_COUNTERS_START);
+OPAL_CALL(opal_imc_counters_stop,              OPAL_IMC_COUNTERS_STOP);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0f2a80377520..dca7f2b07f93 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -139,6 +139,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
+	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
-- 
2.11.0
