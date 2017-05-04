Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJcf04MNBzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 00:21:28 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v44EJAFb026928
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 10:21:17 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7ufb4d0y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 10:21:17 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Fri, 5 May 2017 00:21:14 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v44EL4gF1507722
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 00:21:12 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v44EKX7s012729
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 00:20:34 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v8 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug support
Date: Thu,  4 May 2017 19:49:51 +0530
In-Reply-To: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1493907596-11425-6-git-send-email-anju@linux.vnet.ibm.com>
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
introduce a new state : CPUHP_AP_PERF_POWERPC_NEST_ONLINE.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h             |   4 +
 arch/powerpc/include/asm/opal-api.h            |  12 +-
 arch/powerpc/include/asm/opal.h                |   4 +
 arch/powerpc/perf/imc-pmu.c                    | 248 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   3 +
 include/linux/cpuhotplug.h                     |   1 +
 6 files changed, 266 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 6bbe184..1478d0f 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -92,6 +92,10 @@ struct imc_pmu {
 #define IMC_DOMAIN_NEST		1
 #define IMC_DOMAIN_UNKNOWN	-1
 
+#define IMC_COUNTER_ENABLE	1
+#define IMC_COUNTER_DISABLE	0
+
+
 extern struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
 extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 extern int __init init_imc_pmu(struct imc_events *events,int idx, struct imc_pmu *pmu_ptr);
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index a0aa285..ce863d9 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -168,7 +168,10 @@
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
 #define OPAL_NMMU_SET_PTCR			127
-#define OPAL_LAST				127
+#define OPAL_IMC_COUNTERS_INIT			149
+#define OPAL_IMC_COUNTERS_START			150
+#define OPAL_IMC_COUNTERS_STOP			151
+#define OPAL_LAST				151
 
 /* Device tree flags */
 
@@ -928,6 +931,13 @@ enum {
 	OPAL_PCI_TCE_KILL_ALL,
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
index 1ff03a6..9c16ec6 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -227,6 +227,10 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			  uint64_t dma_addr, uint32_t npages);
 int64_t opal_nmmu_set_ptcr(uint64_t chip_id, uint64_t ptcr);
 
+int64_t opal_imc_counters_init(uint32_t type, uint64_t address);
+int64_t opal_imc_counters_start(uint32_t type);
+int64_t opal_imc_counters_stop(uint32_t type);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index f09a37a..40792424 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -18,6 +18,11 @@
 
 struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
 struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+static cpumask_t nest_imc_cpumask;
+
+static atomic_t nest_events;
+/* Used to avoid races in calling enable/disable nest-pmu units*/
+static DEFINE_MUTEX(imc_nest_reserve);
 
 /* Needed for sanity check */
 extern u64 nest_max_offset;
@@ -33,6 +38,160 @@ static struct attribute_group imc_format_group = {
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
+ * nest_init : Initializes the nest imc engine for the current chip.
+ * by default the nest engine is disabled.
+ */
+static void nest_init(int *cpu_opal_rc)
+{
+	int rc;
+
+	/*
+	 * OPAL figures out which CPU to start based on the CPU that is
+	 * currently running when we call into OPAL
+	 */
+	rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST);
+	if (rc)
+		cpu_opal_rc[smp_processor_id()] = 1;
+}
+
+static void nest_change_cpu_context(int old_cpu, int new_cpu)
+{
+	int i;
+
+	for (i = 0;
+	     (per_nest_pmu_arr[i] != NULL) && (i < IMC_MAX_PMUS); i++)
+		perf_pmu_migrate_context(&per_nest_pmu_arr[i]->pmu,
+							old_cpu, new_cpu);
+}
+
+static int ppc_nest_imc_cpu_online(unsigned int cpu)
+{
+	int nid;
+	const struct cpumask *l_cpumask;
+	struct cpumask tmp_mask;
+
+	/* Find the cpumask of this node */
+	nid = cpu_to_node(cpu);
+	l_cpumask = cpumask_of_node(nid);
+
+	/*
+	 * If any of the cpu from this node is already present in the mask,
+	 * just return, if not, then set this cpu in the mask.
+	 */
+	if (!cpumask_and(&tmp_mask, l_cpumask, &nest_imc_cpumask)) {
+		cpumask_set_cpu(cpu, &nest_imc_cpumask);
+		nest_change_cpu_context(-1, cpu);
+		return 0;
+	}
+
+	return 0;
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
+	if (target >= 0 && target <= nr_cpu_ids) {
+		cpumask_set_cpu(target, &nest_imc_cpumask);
+		nest_change_cpu_context(cpu, target);
+	}
+	return 0;
+}
+
+static int nest_pmu_cpumask_init(void)
+{
+	const struct cpumask *l_cpumask;
+	int cpu, nid;
+	int *cpus_opal_rc;
+
+	if (!cpumask_empty(&nest_imc_cpumask))
+		return 0;
+
+	/*
+	 * Memory for OPAL call return value.
+	 */
+	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
+	if (!cpus_opal_rc)
+		goto fail;
+
+	/*
+	 * Nest PMUs are per-chip counters. So designate a cpu
+	 * from each chip for counter collection.
+	 */
+	for_each_online_node(nid) {
+		l_cpumask = cpumask_of_node(nid);
+
+		/* designate first online cpu in this node */
+		cpu = cpumask_first(l_cpumask);
+		cpumask_set_cpu(cpu, &nest_imc_cpumask);
+	}
+
+	/* Initialize Nest PMUs in each node using designated cpus */
+	on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_init,
+						(void *)cpus_opal_rc, 1);
+
+	/* Check return value array for any OPAL call failure */
+	for_each_cpu(cpu, &nest_imc_cpumask) {
+		if (cpus_opal_rc[cpu])
+			goto fail;
+	}
+
+	cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
+			  "POWER_NEST_IMC_ONLINE",
+			  ppc_nest_imc_cpu_online,
+			  ppc_nest_imc_cpu_offline);
+
+	return 0;
+
+fail:
+	if (cpus_opal_rc)
+		kfree(cpus_opal_rc);
+	return -ENODEV;
+}
+
 static int nest_imc_event_init(struct perf_event *event)
 {
 	int chip_id;
@@ -109,6 +268,51 @@ static void imc_perf_event_update(struct perf_event *event)
 	local64_add(final_count, &event->count);
 }
 
+static void nest_imc_start(int *cpu_opal_rc)
+{
+	int rc;
+
+	/* Enable nest engine */
+	rc = opal_imc_counters_start(OPAL_IMC_COUNTERS_NEST);
+	if (rc)
+		cpu_opal_rc[smp_processor_id()] = 1;
+
+}
+
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
+
+	case	IMC_COUNTER_ENABLE:
+			/* Initialize Nest PMUs in each node using designated cpus */
+			on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_imc_start,
+						(void *)cpus_opal_rc, 1);
+			break;
+	case	IMC_COUNTER_DISABLE:
+			/* Disable the counters */
+			on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_init,
+						(void *)cpus_opal_rc, 1);
+			break;
+	default: return -EINVAL;
+
+	}
+
+	/* Check return value array for any OPAL call failure */
+	for_each_cpu(cpu, &nest_imc_cpumask) {
+		if (cpus_opal_rc[cpu])
+			return -ENODEV;
+	}
+	return 0;
+}
+
 static void imc_event_start(struct perf_event *event, int flags)
 {
 	/*
@@ -129,19 +333,44 @@ static void imc_event_stop(struct perf_event *event, int flags)
 	imc_perf_event_update(event);
 }
 
-/*
- * The wrapper function is provided here, since we will have reserve
- * and release lock for imc_event_start() in the following patch.
- * Same in case of imc_event_stop().
- */
 static void nest_imc_event_start(struct perf_event *event, int flags)
 {
+	int rc;
+
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
+			pr_err("IMC: Unbale to start the counters\n");
+	}
 	imc_event_start(event, flags);
 }
 
 static void nest_imc_event_stop(struct perf_event *event, int flags)
 {
+	int rc;
+
 	imc_event_stop(event, flags);
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
 }
 
 static int nest_imc_event_add(struct perf_event *event, int flags)
@@ -165,6 +394,7 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 	pmu->pmu.start = nest_imc_event_start;
 	pmu->pmu.stop = nest_imc_event_stop;
 	pmu->pmu.read = imc_perf_event_update;
+	pmu->attr_groups[IMC_CPUMASK_ATTR] = &imc_pmu_cpumask_attr_group;
 	pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
 	pmu->pmu.attr_groups = pmu->attr_groups;
 
@@ -234,12 +464,20 @@ static int update_events_in_group(struct imc_events *events,
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
+	ret = nest_pmu_cpumask_init();
+	if (ret)
+		return ret;
+
 	ret = update_events_in_group(events, idx, pmu_ptr);
 	if (ret)
 		goto err_free;
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index da8a0f7..4ede687 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -301,3 +301,6 @@ OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
+OPAL_CALL(opal_imc_counters_init,		OPAL_IMC_COUNTERS_INIT);
+OPAL_CALL(opal_imc_counters_start,		OPAL_IMC_COUNTERS_START);
+OPAL_CALL(opal_imc_counters_stop,		OPAL_IMC_COUNTERS_STOP);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 62d240e..51dff54 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -137,6 +137,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_CCN_ONLINE,
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
+	CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
-- 
2.7.4
