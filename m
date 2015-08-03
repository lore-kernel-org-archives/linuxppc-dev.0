Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B2F0D1A1A53
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 17:37:49 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 3 Aug 2015 13:07:47 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8CE141258017
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 13:10:52 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t737biu860817450
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2015 13:07:44 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t737aAVf008094
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2015 13:06:12 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Preeti U Murthy <preetium@andrew.cmu.edu>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v7 7/7] powerpc/powernv: nest pmu cpumask and cpu hotplug
 support
Date: Mon,  3 Aug 2015 13:05:59 +0530
Message-Id: <1438587359-6165-8-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1438587359-6165-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1438587359-6165-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds cpumask attribute to be used by each nest pmu since nest
units are per-chip. Only one cpu (first online cpu) from each chip
is designated to read counters.

On cpu hotplug, dying cpu is checked to see whether it is one of the
designated cpus, if yes, next online cpu from the same chip is
designated as new cpu to read counters.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Stephane Eranian <eranian@google.com>
Cc: Preeti U Murthy <preetium@andrew.cmu.edu>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.c | 173 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index f653a7ab6ed7..ec173b7c36e5 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -12,6 +12,7 @@
 
 static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
 static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
+static cpumask_t nest_pmu_cpu_mask;
 
 PMU_FORMAT_ATTR(event, "config:0-20");
 static struct attribute *p8_nest_format_attrs[] = {
@@ -24,6 +25,173 @@ static struct attribute_group p8_nest_format_group = {
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
+	for (i = 0;
+		(per_nest_pmu_arr[i] != NULL) && (i < P8_NEST_MAX_PMUS); i++)
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
@@ -255,6 +423,7 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
 			sprintf(buf, "Nest_%s", (char *)pp->value);
 			pmu_ptr->pmu.name = (char *)buf;
 			pmu_ptr->attr_groups[1] = &p8_nest_format_group;
+			pmu_ptr->attr_groups[2] = &nest_pmu_cpumask_attr_group;
 			continue;
 		}
 
@@ -359,6 +528,10 @@ static int __init nest_pmu_init(void)
 	if (!of_find_node_with_property(NULL, "ibm,ima-chip"))
 		return ret;
 
+	/* Add cpumask and register for hotplug notification */
+	if (nest_pmu_cpumask_init())
+		return ret;
+
 	/*
 	 * Parse device-tree for Nest PMU information
 	 */
-- 
1.9.1
