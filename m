Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkH0W0q8RzDqNy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 06:22:34 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v58KKY73052147
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 16:22:33 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aybve44q7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 16:22:32 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 9 Jun 2017 06:22:30 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v58KMR3l8978886
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 06:22:27 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v58KMIhW026165
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 06:22:19 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com, eranian@google.com,
 benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, mikey@neuling.org, dja@axtens.net,
 anton@samba.org, tglx@linutronix.de,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug support
Date: Fri,  9 Jun 2017 01:52:09 +0530
Message-Id: <1496953329-16480-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>

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
 arch/powerpc/include/asm/opal-api.h            |  14 +-
 arch/powerpc/include/asm/opal.h                |   4 +
 arch/powerpc/perf/imc-pmu.c                    | 211 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   3 +
 include/linux/cpuhotplug.h                     |   1 +
 5 files changed, 229 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index aa150f03a2d7..ebe9d6bd3f06 100644
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
 
@@ -1005,8 +1008,13 @@ enum {
 
 /* In-Memory Collection Counters Type */
 enum {
-	IMC_COUNTER_PER_CHIP            = 0x10,
-	IMC_COUNTER_PER_SOCKET          = 0x20,
+	IMC_COUNTER_PER_CHIP		= 0x10,
+	IMC_COUNTER_PER_SOCKET		= 0x20,
+};
+
+/* Argument to OPAL_IMC_COUNTERS_*  */
+enum {
+	OPAL_IMC_COUNTERS_NEST = 1,
 };
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 588fb1c23af9..cdf78b6a9245 100644
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
index e410788af10f..d3691d4d5f4b 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -21,6 +21,15 @@
 /* Needed for sanity check */
 extern u64 nest_max_offset;
 struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+static cpumask_t nest_imc_cpumask;
+static int nest_imc_cpumask_initialized;
+
+static atomic_t nest_events;
+/* Used to avoid races in calling enable/disable nest-pmu units */
+static DEFINE_MUTEX(imc_nest_reserve);
+
+static struct cpumask imc_result_mask;
+static DEFINE_MUTEX(imc_control_mutex);
 
 struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
 {
@@ -38,9 +47,181 @@ static struct attribute_group imc_format_group = {
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
+ * opal_imc_stop : Does OPAL call to stop imc engine.
+ */
+static void opal_imc_stop(void *type)
+{
+	if (opal_imc_counters_stop((unsigned long) type))
+		cpumask_set_cpu(smp_processor_id(), &imc_result_mask);
+}
+
+/* opal_imc_start: Does the OPAL call to start imc engine */
+static void opal_imc_start(void *type)
+{
+	if (opal_imc_counters_start((unsigned long) type))
+		cpumask_set_cpu(smp_processor_id(), &imc_result_mask);
+}
+
+/*
+ * imc_control: Function to start and stop imc engine.
+ * The function is called from event init, event destroy and
+ * device shutdown.
+ */
+int imc_control(unsigned long type, bool operation)
+{
+	smp_call_func_t fn;
+	int res;
+	cpumask_t *imc_domain_mask;
+
+	mutex_lock(&imc_control_mutex);
+	memset(&imc_result_mask, 0, sizeof(imc_result_mask));
+
+	switch (type) {
+	case OPAL_IMC_COUNTERS_NEST:
+		imc_domain_mask = &nest_imc_cpumask;
+		break;
+	default:
+		res = -EINVAL;
+		goto out;
+
+	}
+	fn = operation ? opal_imc_start : opal_imc_stop;
+
+	on_each_cpu_mask(imc_domain_mask, fn, (void *) type, 1);
+
+	res = cpumask_empty(&imc_result_mask) ? 0 : -ENODEV;
+out:
+	mutex_unlock(&imc_control_mutex);
+	return res;
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
+		opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST);
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
+		rc = imc_control(OPAL_IMC_COUNTERS_NEST, false);
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
@@ -87,6 +268,23 @@ static int nest_imc_event_init(struct perf_event *event)
 	 * "chip_id" and add "config" to it".
 	 */
 	event->hw.event_base = (u64)pcni->vbase[config/PAGE_SIZE] + (config & ~PAGE_MASK);
+	/*
+	 * Nest pmu units are enabled only when it is used.
+	 * See if this is triggered for the first time.
+	 * If yes, take the mutex lock and enable the nest counters.
+	 * If not, just increment the count in nest_events.
+	 */
+	if (atomic_inc_return(&nest_events) == 1) {
+		mutex_lock(&imc_nest_reserve);
+		rc = imc_control(OPAL_IMC_COUNTERS_NEST, true);
+		mutex_unlock(&imc_nest_reserve);
+		if (rc) {
+			atomic_dec_return(&nest_events);
+			pr_err("IMC: Unable to start the counters\n");
+			return -ENODEV;
+		}
+	}
+	event->destroy = nest_imc_counters_release;
 	return 0;
 }
 
@@ -164,6 +362,7 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 	pmu->pmu.start = imc_event_start;
 	pmu->pmu.stop = imc_event_stop;
 	pmu->pmu.read = imc_perf_event_update;
+	pmu->attr_groups[IMC_CPUMASK_ATTR] = &imc_pmu_cpumask_attr_group;
 	pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
 	pmu->pmu.attr_groups = pmu->attr_groups;
 
@@ -233,12 +432,22 @@ static int update_events_in_group(struct imc_events *events,
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
2.7.4
