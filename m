Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whDkH3yhnzDqLX
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 22:33:11 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v55CUIKc010817
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 08:33:09 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2aw6ar2fyc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 08:33:08 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 5 Jun 2017 22:33:05 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v55CWsjm59768896
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 22:33:02 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v55CWSkG020215
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 22:32:29 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, tglx@linutronix.de
Subject: [PATCH v9 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug support
Date: Mon,  5 Jun 2017 18:02:00 +0530
Message-Id: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/imc-pmu.h             |   3 +
 arch/powerpc/include/asm/opal-api.h            |  12 +-
 arch/powerpc/include/asm/opal.h                |   4 +
 arch/powerpc/perf/imc-pmu.c                    | 224 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   3 +
 include/linux/cpuhotplug.h                     |   1 +
 6 files changed, 245 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 303faa8..6b1d887 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -96,6 +96,9 @@ struct imc_pmu {
  */
 #define IMC_DOMAIN_NEST		1
 
+#define IMC_COUNTER_ENABLE     1
+#define IMC_COUNTER_DISABLE    0
+
 extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 extern int __init init_imc_pmu(struct imc_events *events, int idx, struct imc_pmu *pmu_ptr);
 #endif /* PPC_POWERNV_IMC_PMU_DEF_H */
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index aa150f0..e0c5c66 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -190,7 +190,10 @@
 #define OPAL_NPU_INIT_CONTEXT			146
 #define OPAL_NPU_DESTROY_CONTEXT		147
 #define OPAL_NPU_MAP_LPAR			148
-#define OPAL_LAST				148
+#define OPAL_IMC_COUNTERS_INIT                 	149
+#define OPAL_IMC_COUNTERS_START                	150
+#define OPAL_IMC_COUNTERS_STOP                 	151
+#define OPAL_LAST                              	151
 
 /* Device tree flags */
 
@@ -1009,6 +1012,13 @@ enum {
 	IMC_COUNTER_PER_SOCKET          = 0x20,
 };
 
+/* Argument to OPAL_IMC_COUNTERS_*  */
+enum {
+	OPAL_IMC_COUNTERS_NEST = 1,
+	OPAL_IMC_COUNTERS_CORE = 2,
+	OPAL_IMC_COUNTERS_THREAD = 3,
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 588fb1c..cdf78b6 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -268,6 +268,10 @@ int64_t opal_xive_free_irq(uint32_t girq);
 int64_t opal_xive_sync(uint32_t type, uint32_t id);
 int64_t opal_xive_dump(uint32_t type, uint32_t id);
 
+int64_t opal_imc_counters_init(uint32_t type, uint64_t address, uint64_t cpu);
+int64_t opal_imc_counters_start(uint32_t type);
+int64_t opal_imc_counters_stop(uint32_t type);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 242328ee..976ba31 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -21,6 +21,12 @@
 /* Needed for sanity check */
 extern u64 nest_max_offset;
 struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+static cpumask_t nest_imc_cpumask;
+static int nest_imc_cpumask_initialized;
+
+static atomic_t nest_events;
+/* Used to avoid races in calling enable/disable nest-pmu units */
+static DEFINE_MUTEX(imc_nest_reserve);
 
 struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
 {
@@ -38,9 +44,200 @@ static struct attribute_group imc_format_group = {
 	.attrs = imc_format_attrs,
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
+/*
+ * nest_imc_stop : Does OPAL call to stop nest engine.
+ */
+static void nest_imc_stop(int *cpu_opal_rc)
+{
+	int rc;
+
+	rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST);
+	if (rc)
+		cpu_opal_rc[smp_processor_id()] = 1;
+}
+
+/* nest_imc_start: Does the OPAL call to enable nest counters. */
+static void nest_imc_start(int *cpu_opal_rc)
+{
+	int rc;
+
+	rc = opal_imc_counters_start(OPAL_IMC_COUNTERS_NEST);
+	if (rc)
+		cpu_opal_rc[smp_processor_id()] = 1;
+}
+
+/*
+ * nest_imc_control: Function to start and stop nest imc engine.
+ *		     The function is primarily called from event init
+ * 		     and event destroy.
+ */
+static int nest_imc_control(int operation)
+{
+	int *cpus_opal_rc, cpu;
+
+	/*
+	 * Memory for OPAL call return value.
+	 */
+	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
+	if (!cpus_opal_rc)
+		return -ENOMEM;
+	switch (operation) {
+	case IMC_COUNTER_ENABLE:
+			/* Initialize Nest PMUs in each node using designated cpus */
+			on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_imc_start,
+						cpus_opal_rc, 1);
+			break;
+	case IMC_COUNTER_DISABLE:
+			/* Disable the counters */
+			on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_imc_stop,
+						cpus_opal_rc, 1);
+			break;
+	default:
+		kfree(cpus_opal_rc);
+		return -EINVAL;
+
+	}
+
+	/* Check return value array for any OPAL call failure */
+	for_each_cpu(cpu, &nest_imc_cpumask) {
+		if (cpus_opal_rc[cpu]) {
+			kfree(cpus_opal_rc);
+			return -ENODEV;
+		}
+	}
+	kfree(cpus_opal_rc);
+	return 0;
+}
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
+
+}
+
+static int ppc_nest_imc_cpu_offline(unsigned int cpu)
+{
+	int nid, target = -1;
+	const struct cpumask *l_cpumask;
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
+	target = cpumask_next(cpu, l_cpumask);
+
+	/*
+	 * Update the cpumask with the target cpu and
+	 * migrate the context if needed
+	 */
+	if (target >= 0 && target < nr_cpu_ids) {
+		cpumask_set_cpu(target, &nest_imc_cpumask);
+		nest_change_cpu_context(cpu, target);
+	} else {
+		target = -1;
+		opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST);
+		nest_change_cpu_context(cpu, target);
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
+	res = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST);
+	if (res)
+		return res;
+
+	/* Make this CPU the designated target for counter collection */
+	cpumask_set_cpu(cpu, &nest_imc_cpumask);
+	nest_change_cpu_context(-1, cpu);
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
+	int rc;
+	/*
+	 * See if we need to disable the nest PMU.
+	 * If no events are currently in use, then we have to take a
+	 * mutex to ensure that we don't race with another task doing
+	 * enable or disable the nest counters.
+	 */
+	if (atomic_dec_return(&nest_events) == 0) {
+		mutex_lock(&imc_nest_reserve);
+		rc = nest_imc_control(IMC_COUNTER_DISABLE);
+		mutex_unlock(&imc_nest_reserve);
+		if (rc)
+			pr_err("IMC: Disable counters failed\n");
+	}
+}
+
 static int nest_imc_event_init(struct perf_event *event)
 {
-	int chip_id;
+	int chip_id, rc;
 	u32 config = event->attr.config;
 	struct imc_mem_info *pcni;
 	struct imc_pmu *pmu;
@@ -80,6 +277,20 @@ static int nest_imc_event_init(struct perf_event *event)
 	 * "chip_id" and add "config" to it".
 	 */
 	event->hw.event_base = pcni->vbase[config/PAGE_SIZE] + (config & ~PAGE_MASK);
+	/*
+	 * Nest pmu units are enabled only when it is used.
+	 * See if this is triggered for the first time.
+	 * If yes, take the mutex lock and enable the nest counters.
+	 * If not, just increment the count in nest_events.
+	 */
+	if (atomic_inc_return(&nest_events) == 1) {
+		mutex_lock(&imc_nest_reserve);
+		rc = nest_imc_control(IMC_COUNTER_ENABLE);
+		mutex_unlock(&imc_nest_reserve);
+		if (rc)
+			pr_err("IMC: Unable to start the counters\n");
+	}
+	event->destroy = nest_imc_counters_release;
 	return 0;
 }
 
@@ -157,6 +368,7 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 	pmu->pmu.start = imc_event_start;
 	pmu->pmu.stop = imc_event_stop;
 	pmu->pmu.read = imc_perf_event_update;
+	pmu->attr_groups[IMC_CPUMASK_ATTR] = &imc_pmu_cpumask_attr_group;
 	pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
 	pmu->pmu.attr_groups = pmu->attr_groups;
 
@@ -226,12 +438,22 @@ static int update_events_in_group(struct imc_events *events,
  * @events:	events memory for this pmu.
  * @idx:	number of event entries created.
  * @pmu_ptr:	memory allocated for this pmu.
+ *
+ * init_imc_pmu() setup the cpu mask information for these pmus and setup
+ * the state machine hotplug notifiers as well.
  */
 int __init init_imc_pmu(struct imc_events *events, int idx,
 		 struct imc_pmu *pmu_ptr)
 {
 	int ret = -ENODEV;
 
+	/* Add cpumask and register for hotplug notification */
+	if (!nest_imc_cpumask_initialized) {
+		ret = nest_pmu_cpumask_init();
+		if (ret)
+			return ret;
+		nest_imc_cpumask_initialized = 1;
+	}
 	ret = update_events_in_group(events, idx, pmu_ptr);
 	if (ret)
 		goto err_free;
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index f620572..1828b24f 100644
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
index 0f2a803..dca7f2b 100644
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
2.7.4
