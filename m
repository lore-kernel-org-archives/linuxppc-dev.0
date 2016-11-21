Return-Path: <hemant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMdWR4N2lzDvgS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:43 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAL68XNj028175
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 01:10:41 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26us3bcveh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 01:10:41 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 16:10:37 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 165552CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:36 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAL6AawB3604954
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:36 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAL6AYnf030995
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:35 +1100
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 stewart@linux.vnet.ibm.com, dja@axtens.net, mikey@neuling.org,
 maddy@linux.vnet.ibm.com, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v2 6/6] powerpc/perf: IMA pmu cpumask and cpu hotplug support
Date: Mon, 21 Nov 2016 11:40:05 +0530
In-Reply-To: <1479708605-10238-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1479708605-10238-1-git-send-email-hemant@linux.vnet.ibm.com>
Message-Id: <1479708605-10238-7-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds cpumask attribute to be used by each IMA pmu. Only one cpu (any
online CPU) from each chip for nest PMUs is designated to read counters.

On CPU hotplug, dying CPU is checked to see whether it is one of the
designated cpus, if yes, next online cpu from the same chip (for nest
units) is designated as new cpu to read counters.

Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            |   3 +-
 arch/powerpc/include/asm/opal.h                |   2 +
 arch/powerpc/perf/ima-pmu.c                    | 167 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 4 files changed, 171 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0e2e57b..116c155 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -167,7 +167,8 @@
 #define OPAL_INT_EOI				124
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
-#define OPAL_LAST				126
+#define OPAL_NEST_IMA_COUNTERS_CONTROL          128
+#define OPAL_LAST				128
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index e958b70..bc31251 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -229,6 +229,8 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			     uint32_t pe_num, uint32_t tce_size,
 			     uint64_t dma_addr, uint32_t npages);
+int64_t opal_nest_ima_counters_control(uint64_t mode, uint64_t value1,
+				  uint64_t value2, uint64_t value3);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/perf/ima-pmu.c b/arch/powerpc/perf/ima-pmu.c
index 9948636..2b1bfc1 100644
--- a/arch/powerpc/perf/ima-pmu.c
+++ b/arch/powerpc/perf/ima-pmu.c
@@ -16,6 +16,7 @@
 
 struct perchip_nest_info nest_perchip_info[IMA_MAX_CHIPS];
 struct ima_pmu *per_nest_pmu_arr[IMA_MAX_PMUS];
+static cpumask_t nest_ima_cpumask;
 
 /* Needed for sanity check */
 extern u64 nest_max_offset;
@@ -31,6 +32,164 @@ static struct attribute_group ima_format_group = {
 	.attrs = ima_format_attrs,
 };
 
+/* Get the cpumask printed to a buffer "buf" */
+static ssize_t ima_pmu_cpumask_get_attr(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	cpumask_t *active_mask;
+
+	active_mask = &nest_ima_cpumask;
+	return cpumap_print_to_pagebuf(true, buf, active_mask);
+}
+
+static DEVICE_ATTR(cpumask, S_IRUGO, ima_pmu_cpumask_get_attr, NULL);
+
+static struct attribute *ima_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static struct attribute_group ima_pmu_cpumask_attr_group = {
+	.attrs = ima_pmu_cpumask_attrs,
+};
+
+/*
+ * nest_init : Initializes the nest ima engine for the current chip.
+ */
+static void nest_init(int *loc)
+{
+	int rc;
+
+	rc = opal_nest_ima_counters_control(NEST_IMA_PRODUCTION_MODE,
+					    NEST_IMA_ENGINE_START, 0, 0);
+	if (rc)
+		loc[smp_processor_id()] = 1;
+}
+
+static void nest_change_cpu_context(int old_cpu, int new_cpu)
+{
+	int i;
+
+	for (i = 0;
+	     (per_nest_pmu_arr[i] != NULL) && (i < IMA_MAX_PMUS); i++)
+		perf_pmu_migrate_context(&per_nest_pmu_arr[i]->pmu,
+							old_cpu, new_cpu);
+}
+
+static int ppc_nest_ima_cpu_online(unsigned int cpu)
+{
+	int nid, fcpu, ncpu;
+	struct cpumask *l_cpumask, tmp_mask;
+
+	/* Fint the cpumask of this node */
+	nid = cpu_to_node(cpu);
+	l_cpumask = cpumask_of_node(nid);
+
+	/*
+	 * If any of the cpu from this node is already present in the mask,
+	 * just return, if not, then set this cpu in the mask.
+	 */
+	if (!cpumask_and(&tmp_mask, l_cpumask, &nest_ima_cpumask)) {
+		cpumask_set_cpu(cpu, &nest_ima_cpumask);
+		return 0;
+	}
+
+	fcpu = cpumask_first(l_cpumask);
+	ncpu = cpumask_next(cpu, l_cpumask);
+	if (cpu == fcpu) {
+		if (cpumask_test_and_clear_cpu(ncpu, &nest_ima_cpumask)) {
+			cpumask_set_cpu(cpu, &nest_ima_cpumask);
+			nest_change_cpu_context(ncpu, cpu);
+		}
+	}
+
+	return 0;
+}
+
+static int ppc_nest_ima_cpu_offline(unsigned int cpu)
+{
+	int nid, target = -1;
+	struct cpumask *l_cpumask;
+
+	/*
+	 * Check in the designated list for this cpu. Dont bother
+	 * if not one of them.
+	 */
+	if (!cpumask_test_and_clear_cpu(cpu, &nest_ima_cpumask))
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
+		cpumask_set_cpu(target, &nest_ima_cpumask);
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
+	if (!cpumask_empty(&nest_ima_cpumask))
+		return 0;
+
+	cpu_notifier_register_begin();
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
+		cpumask_set_cpu(cpu, &nest_ima_cpumask);
+	}
+
+	/*
+	 * Memory for OPAL call return value.
+	 */
+	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
+	if (!cpus_opal_rc)
+		goto fail;
+
+	/* Initialize Nest PMUs in each node using designated cpus */
+	on_each_cpu_mask(&nest_ima_cpumask, (smp_call_func_t)nest_init,
+						(void *)cpus_opal_rc, 1);
+
+	/* Check return value array for any OPAL call failure */
+	for_each_cpu(cpu, &nest_ima_cpumask) {
+		if (cpus_opal_rc[cpu])
+			goto fail;
+	}
+
+	cpuhp_setup_state(CPUHP_AP_PERF_ONLINE,
+			  "POWER_NEST_IMA_ONLINE",
+			  ppc_nest_ima_cpu_online,
+			  ppc_nest_ima_cpu_offline);
+
+	cpu_notifier_register_done();
+	return 0;
+
+fail:
+	cpu_notifier_register_done();
+	return -ENODEV;
+}
+
 static int nest_ima_event_init(struct perf_event *event)
 {
 	int chip_id;
@@ -63,7 +222,7 @@ static int nest_ima_event_init(struct perf_event *event)
 	chip_id = topology_physical_package_id(event->cpu);
 	pcni = &nest_perchip_info[chip_id];
 	event->hw.event_base = pcni->vbase[config/PAGE_SIZE] +
-							(config & ~PAGE_MASK);
+		(config & ~PAGE_MASK);
 
 	return 0;
 }
@@ -123,6 +282,7 @@ static int update_pmu_ops(struct ima_pmu *pmu)
 	pmu->pmu.stop = ima_event_stop;
 	pmu->pmu.read = ima_perf_event_update;
 	pmu->attr_groups[1] = &ima_format_group;
+	pmu->attr_groups[2] = &ima_pmu_cpumask_attr_group;
 	pmu->pmu.attr_groups = pmu->attr_groups;
 
 	return 0;
@@ -190,6 +350,11 @@ int init_ima_pmu(struct ima_events *events, int idx,
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
index 44d2d84..0e541ca 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -309,3 +309,4 @@ OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
+OPAL_CALL(opal_nest_ima_counters_control,	OPAL_NEST_IMA_COUNTERS_CONTROL);
-- 
2.7.4
