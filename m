Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 505121A0A3A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:30 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 23:08:29 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 19BD63578047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:28 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2BD8JD140632530
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:28 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2BD7rRk011652
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:07:54 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 3/7] powerpc/powernv: uncore cpumask and CPU hotplug
Date: Wed, 11 Mar 2015 18:37:09 +0530
Message-Id: <1426079233-16720-4-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1426079233-16720-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1426079233-16720-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: ak@linux.intel.com, srivatsa@mit.edu, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch to add cpumask attribute for the Nest pmu to
control per-chip counter values to be read by cpus.
Also adds support of cpu hotplug.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/uncore_pmu.c | 152 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/arch/powerpc/perf/uncore_pmu.c b/arch/powerpc/perf/uncore_pmu.c
index cc544d3..67ab6c0 100644
--- a/arch/powerpc/perf/uncore_pmu.c
+++ b/arch/powerpc/perf/uncore_pmu.c
@@ -19,6 +19,32 @@
 struct ppc64_uncore_type *empty_uncore[] = { NULL, };
 struct ppc64_uncore_type **ppc64_uncore = empty_uncore;
 
+/* mask of cpus that collect uncore events */
+static cpumask_t uncore_cpu_mask;
+
+static ssize_t uncore_get_attr_cpumask(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &uncore_cpu_mask);
+}
+
+/*
+ * cpumask attr used by perf userspace to pick the cpus to execute
+ * in case of -a option. User can still specify -C option to override.
+ * Since these Nest Counters are per-chip, make only one cpu from chip
+ * to read.
+ */
+static DEVICE_ATTR(cpumask, S_IRUGO, uncore_get_attr_cpumask, NULL);
+
+static struct attribute *uncore_pmu_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static struct attribute_group uncore_pmu_attr_group = {
+	.attrs = uncore_pmu_attrs,
+};
+
 struct ppc64_uncore_pmu *uncore_event_to_pmu(struct perf_event *event)
 {
 	return container_of(event->pmu, struct ppc64_uncore_pmu, pmu);
@@ -43,6 +69,7 @@ int __init uncore_type_init(struct ppc64_uncore_type *type)
 				type->name, (int)i);
 	}
 
+	type->pmu_group = &uncore_pmu_attr_group;
 	return 0;
 }
 
@@ -82,6 +109,130 @@ static int __init uncore_pmus_register(void)
 	return 0;
 }
 
+static void
+uncore_change_context(struct ppc64_uncore_type **uncores,
+				int old_cpu, int new_cpu)
+{
+	struct ppc64_uncore_type *type;
+	struct ppc64_uncore_pmu *pmu;
+	int i, j;
+
+	for (i = 0; uncores[i]; i++) {
+		type = uncores[i];
+		for (j = 0; j < type->num_boxes; j++) {
+			pmu = &type->pmus[j];
+			if (old_cpu < 0)
+				continue;
+			if (new_cpu >= 0) {
+				perf_pmu_migrate_context(&pmu->pmu,
+					old_cpu, new_cpu);
+			}
+		}
+	}
+}
+
+static void uncore_event_init_cpu(int cpu)
+{
+	int i, phys_id;
+
+	phys_id = topology_physical_package_id(cpu);
+	for_each_cpu(i, &uncore_cpu_mask) {
+		if (phys_id == topology_physical_package_id(i))
+			return;
+	}
+
+	cpumask_set_cpu(cpu, &uncore_cpu_mask);
+
+	uncore_change_context(ppc64_uncore, -1, cpu);
+}
+
+static void uncore_event_exit_cpu(int cpu)
+{
+	int i, phys_id, target;
+
+	/* if exiting cpu is used for collecting uncore events */
+	if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask))
+		return;
+
+	/* find a new cpu to collect uncore events */
+	phys_id = topology_physical_package_id(cpu);
+	target = -1;
+	for_each_online_cpu(i) {
+		if (i == cpu)
+			continue;
+		if (phys_id == topology_physical_package_id(i)) {
+			target = i;
+			break;
+		}
+	}
+
+	/* migrate uncore events to the new cpu */
+	if (target >= 0)
+		cpumask_set_cpu(target, &uncore_cpu_mask);
+
+	uncore_change_context(ppc64_uncore, cpu, target);
+}
+
+static int uncore_cpu_notifier(struct notifier_block *self,
+				unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (long)hcpu;
+
+	/* select the cpu that collects uncore events */
+	switch (action & ~CPU_TASKS_FROZEN) {
+	case CPU_DOWN_FAILED:
+	case CPU_STARTING:
+		uncore_event_init_cpu(cpu);
+		break;
+	case CPU_DOWN_PREPARE:
+		uncore_event_exit_cpu(cpu);
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block uncore_cpu_nb = {
+	.notifier_call  = uncore_cpu_notifier,
+	/*
+	 * to migrate uncore events, our notifier should be executed
+	 * before perf core's notifier.
+	 */
+	.priority	= CPU_PRI_PERF + 1,
+};
+
+static void __init cpumask_per_chip_init(void)
+{
+	int cpu;
+
+	if (!cpumask_empty(&uncore_cpu_mask))
+		return;
+
+	cpu_notifier_register_begin();
+
+	for_each_online_cpu(cpu) {
+		int i, phys_id = topology_physical_package_id(cpu);
+
+		for_each_cpu(i, &uncore_cpu_mask) {
+			if (phys_id == topology_physical_package_id(i)) {
+				phys_id = -1;
+				break;
+			}
+		}
+		if (phys_id < 0)
+			continue;
+
+		uncore_event_init_cpu(cpu);
+	}
+
+	__register_cpu_notifier(&uncore_cpu_nb);
+
+	cpu_notifier_register_done();
+}
+
+
 static int __init uncore_init(void)
 {
 	int ret = 0;
@@ -95,6 +246,7 @@ static int __init uncore_init(void)
 	if (ret)
 		return ret;
 
+	cpumask_per_chip_init();
 	uncore_pmus_register();
 
 	return ret;
-- 
1.9.1
