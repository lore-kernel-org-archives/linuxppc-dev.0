Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0889F1A1996
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 21:13:55 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 16:43:54 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D4F1BE0056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:47:43 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6GBDcoC44237020
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:43:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6GBDbbR000740
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:43:38 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>,
 Preeti U Murthy <preetium@andrew.cmu.edu>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 7/7] powerpc/powernv: nest pmu cpumask and cpu hotplug
 support
Date: Thu, 16 Jul 2015 16:43:26 +0530
Message-Id: <1437045206-7491-8-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds cpumask attribute to be used by each nest pmu since nest
units are per-chip. Only one cpu (first online cpu) from each node/chip
is designated to read counters.

On cpu hotplug, dying cpu is checked to see whether it is one of the
designated cpus, if yes, next online cpu from the same node/chip is
designated as new cpu to read counters.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Preeti U Murthy <preetium@andrew.cmu.edu>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.c | 172 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index 2ebd0508e9b3..d3a2fd746cf9 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -12,6 +12,7 @@
 
 static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
 static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
+static cpumask_t nest_pmu_cpu_mask;
 
 PMU_FORMAT_ATTR(event, "config:0-20");
 static struct attribute *p8_nest_format_attrs[] = {
@@ -24,6 +25,172 @@ static struct attribute_group p8_nest_format_group = {
 	.attrs = p8_nest_format_attrs,
 };
 
+static ssize_t nest_pmu_cpumask_get_attr(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &nest_pmu_cpu_mask);
+}
+
+static DEVICE_ATTR(cpumask, S_IRUGO, nest_pmu_cpumask_get_attr, NULL);
+
+static struct attribute *nest_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static struct attribute_group nest_pmu_cpumask_attr_group = {
+	.attrs = nest_pmu_cpumask_attrs,
+};
+
+static void nest_init(int *loc)
+{
+	int rc;
+
+	rc = opal_nest_ima_control(
+				P8_NEST_MODE_PRODUCTION, P8_NEST_ENGINE_START);
+	if (rc)
+		loc[smp_processor_id()] = 1;
+}
+
+static void nest_change_cpu_context(int old_cpu, int new_cpu)
+{
+	int i;
+
+	for (i = 0; per_nest_pmu_arr[i] != NULL; i++)
+		perf_pmu_migrate_context(&per_nest_pmu_arr[i]->pmu,
+						old_cpu, new_cpu);
+}
+
+static void nest_exit_cpu(int cpu)
+{
+	int nid, target = -1;
+	struct cpumask *l_cpumask;
+
+	/*
+	 * Check in the designated list for this cpu. Dont bother
+	 * if not one of them.
+	 */
+	if (!cpumask_test_and_clear_cpu(cpu, &nest_pmu_cpu_mask))
+		return;
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
+		cpumask_set_cpu(target, &nest_pmu_cpu_mask);
+		nest_change_cpu_context(cpu, target);
+	}
+}
+
+static void nest_init_cpu(int cpu)
+{
+	int nid, fcpu, ncpu;
+	struct cpumask *l_cpumask, tmp_mask;
+
+	nid = cpu_to_node(cpu);
+	l_cpumask = cpumask_of_node(nid);
+
+	/*
+	 * if empty cpumask, just add incoming cpu and move on.
+	 */
+	if (!cpumask_and(&tmp_mask, l_cpumask, &nest_pmu_cpu_mask)) {
+		cpumask_set_cpu(cpu, &nest_pmu_cpu_mask);
+		return;
+	}
+
+	/*
+	 * Alway have the first online cpu of a chip as designated one.
+	 */
+	fcpu = cpumask_first(l_cpumask);
+	ncpu = cpumask_next(cpu, l_cpumask);
+	if (cpu == fcpu) {
+		if (cpumask_test_and_clear_cpu(ncpu, &nest_pmu_cpu_mask)) {
+			cpumask_set_cpu(cpu, &nest_pmu_cpu_mask);
+			nest_change_cpu_context(ncpu, cpu);
+		}
+	}
+}
+
+static int nest_pmu_cpu_notifier(struct notifier_block *self,
+				unsigned long action, void *hcpu)
+{
+	long cpu = (long)hcpu;
+
+	switch (action & ~CPU_TASKS_FROZEN) {
+	case CPU_ONLINE:
+		nest_init_cpu(cpu);
+		break;
+	case CPU_DOWN_PREPARE:
+	       nest_exit_cpu(cpu);
+	       break;
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block nest_pmu_cpu_nb = {
+	.notifier_call  = nest_pmu_cpu_notifier,
+	.priority       = CPU_PRI_PERF + 1,
+};
+
+static int nest_pmu_cpumask_init(void)
+{
+	const struct cpumask *l_cpumask;
+	int cpu, nid;
+	int *cpus_opal_rc;
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
+		cpumask_set_cpu(cpu, &nest_pmu_cpu_mask);
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
+	on_each_cpu_mask(&nest_pmu_cpu_mask, (smp_call_func_t)nest_init,
+						(void *)cpus_opal_rc, 1);
+
+	/* Check return value array for any OPAL call failure */
+	for_each_cpu(cpu, &nest_pmu_cpu_mask) {
+		if (cpus_opal_rc[cpu])
+			goto fail;
+	}
+
+	__register_cpu_notifier(&nest_pmu_cpu_nb);
+
+	cpu_notifier_register_done();
+	return 0;
+
+fail:
+	cpu_notifier_register_done();
+	return -ENODEV;
+}
+
 static int p8_nest_event_init(struct perf_event *event)
 {
 	int chip_id;
@@ -250,6 +417,7 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
 			sprintf(buf, "Nest_%s", (char *)pp->value);
 			pmu_ptr->pmu.name = (char *)buf;
 			pmu_ptr->attr_groups[1] = &p8_nest_format_group;
+			pmu_ptr->attr_groups[2] = &nest_pmu_cpumask_attr_group;
 			continue;
 		}
 
@@ -359,6 +527,10 @@ static int __init nest_pmu_init(void)
 	    !cpu_has_feature(CPU_FTR_HVMODE))
 		return ret;
 
+	/* Add cpumask and register for hotplug notification */
+	if (nest_pmu_cpumask_init())
+		return ret;
+
 	/*
 	 * Nest PMU information is grouped under "nest-ima" node
 	 * of the top-level device-tree directory. Detect Nest PMU
-- 
1.9.1
