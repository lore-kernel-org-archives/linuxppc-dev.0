Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF2751A0A51
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 15:18:22 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 10:48:20 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3F28DE004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 10:51:42 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B5IHC042991710
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 10:48:17 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B5IEB8001920
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 10:48:16 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: rusty@rustcorp.com.au, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 7/7]powerpc/powernv: nest pmu cpumask and cpu hotplug
 support
Date: Thu, 11 Jun 2015 10:47:54 +0530
Message-Id: <1433999874-2043-8-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1433999874-2043-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433999874-2043-1-git-send-email-maddy@linux.vnet.ibm.com>
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
designated cpus, if yes, next online cpu from the same node/chip is designated
as new cpu to read counters.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.c | 153 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index a662c14..95f8ecc 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -12,6 +12,155 @@
 
 static struct perchip_nest_info p8_perchip_nest_info[P8_MAX_CHIP];
 static struct nest_pmu *per_nest_pmu_arr[P8_MAX_NEST_PMUS];
+static cpumask_t cpu_mask_nest_pmu;
+
+static ssize_t cpumask_nest_pmu_get_attr(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &cpu_mask_nest_pmu);
+}
+
+static DEVICE_ATTR(cpumask, S_IRUGO, cpumask_nest_pmu_get_attr, NULL);
+
+static struct attribute *cpumask_nest_pmu_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static struct attribute_group cpumask_nest_pmu_attr_group = {
+	.attrs = cpumask_nest_pmu_attrs,
+};
+
+static void nest_init(void *dummy)
+{
+	opal_nest_ima_control(P8_NEST_ENGINE_START);
+}
+
+static void nest_change_cpu_context(int old_cpu, int new_cpu)
+{
+	int i;
+
+	if (new_cpu >= 0) {
+		for (i = 0; per_nest_pmu_arr[i] != NULL; i++)
+			perf_pmu_migrate_context(&per_nest_pmu_arr[i]->pmu,
+							old_cpu, new_cpu);
+	}
+}
+
+static void nest_exit_cpu(int cpu)
+{
+	int i, nid, target = -1;
+	const struct cpumask *l_cpumask;
+	int src_chipid;
+
+	/*
+	 * Check in the designated list for this cpu. Dont bother
+	 * if not one of them.
+	 */
+	if (!cpumask_test_and_clear_cpu(cpu, &cpu_mask_nest_pmu))
+		return;
+
+	/*
+	 * Now that this cpu is one of the designated,
+	 * find a new cpu a) which is not dying and
+	 * b) is in same node/chip.
+	 */
+	nid = cpu_to_node(cpu);
+	src_chipid = topology_physical_package_id(cpu);
+	l_cpumask = cpumask_of_node(nid);
+	for_each_cpu(i, l_cpumask) {
+		if (i == cpu)
+			continue;
+		if (src_chipid == topology_physical_package_id(i)) {
+			target = i;
+			break;
+		}
+	}
+
+	/*
+	 * Update the cpumask with the target cpu and
+	 * migrate the context if needed
+	 */
+	if (target >= 0) {
+		cpumask_set_cpu(target, &cpu_mask_nest_pmu);
+		nest_change_cpu_context (cpu, target);
+	}
+}
+
+static void nest_init_cpu(int cpu)
+{
+	int i, src_chipid;
+
+	/*
+	 * Search for any existing designated thread from
+	 * the incoming cpu's node/chip. If found, do nothing.
+	 */
+	src_chipid = topology_physical_package_id(cpu);
+	for_each_cpu(i, &cpu_mask_nest_pmu)
+		if (src_chipid == topology_physical_package_id(i))
+			return;
+
+	/*
+	 * Make incoming cpu as a designated thread for
+	 * this node/chip
+	 */
+	cpumask_set_cpu(cpu, &cpu_mask_nest_pmu);
+}
+
+static int nest_cpu_notifier(struct notifier_block *self,
+				unsigned long action, void *hcpu)
+{
+	long cpu = (long)hcpu;
+
+	switch (action & ~CPU_TASKS_FROZEN) {
+	case CPU_DOWN_FAILED:
+	case CPU_STARTING:
+		nest_init_cpu(cpu);
+		break;
+	case CPU_DOWN_PREPARE:
+		nest_exit_cpu(cpu);
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block nest_cpu_nb = {
+	.notifier_call  = nest_cpu_notifier,
+	.priority       = CPU_PRI_PERF + 1,
+};
+
+void cpumask_chip(void)
+{
+	const struct cpumask *l_cpumask;
+	int cpu, nid;
+
+	if (!cpumask_empty(&cpu_mask_nest_pmu))
+		return;
+
+	cpu_notifier_register_begin();
+
+	/*
+	 * Nest PMUs are per-chip counters. So designate a cpu
+	 * from each node/chip for counter collection.
+	 */
+	for_each_online_node(nid) {
+		l_cpumask = cpumask_of_node(nid);
+
+		/* designate first online cpu in this node */
+		cpu = cpumask_first(l_cpumask);
+		cpumask_set_cpu(cpu, &cpu_mask_nest_pmu);
+	}
+
+	/* Initialize Nest PMUs in each node using designated cpus */
+	on_each_cpu_mask(&cpu_mask_nest_pmu, (smp_call_func_t)nest_init, NULL, 1);
+
+	__register_cpu_notifier(&nest_cpu_nb);
+
+	cpu_notifier_register_done();
+}
 
 PMU_FORMAT_ATTR(event, "config:0-20");
 struct attribute *p8_nest_format_attrs[] = {
@@ -209,6 +358,7 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
 			sprintf(buf, "Nest_%s", (char *)pp->value);
 			pmu_ptr->pmu.name = (char *)buf;
 			pmu_ptr->attr_groups[1] = &p8_nest_format_group;
+			pmu_ptr->attr_groups[2] = &cpumask_nest_pmu_attr_group;
 		}
 
 		/* Skip these, we dont need it */
@@ -362,6 +512,9 @@ static int __init nest_pmu_init(void)
 	if (ret)
 		return ret;
 
+	/* Add cpumask and register for hotplug notification */
+	cpumask_chip();
+
 	return 0;
 }
 device_initcall(nest_pmu_init);
-- 
1.9.1
