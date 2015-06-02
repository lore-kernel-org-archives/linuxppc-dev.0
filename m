Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FD5F1A074E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:01:07 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 02:01:07 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4BD722BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:01:05 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52G0vcZ43647170
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:01:05 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52G0VMo019008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:00:32 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v1 3/9]powerpc/powernv: Add cpu hotplug support
Date: Tue,  2 Jun 2015 21:29:32 +0530
Message-Id: <1433260778-26497-4-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch adds cpu hotplug support. First online cpu in a node is picked as
designated thread to read the Nest pmu counter data, and at the time of
hotplug, next online cpu from the same node is picked up.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index d4413bb..3e7010e 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -30,6 +30,86 @@ static struct attribute_group cpumask_nest_pmu_attr_group = {
 	.attrs = cpumask_nest_pmu_attrs,
 };
 
+static void nest_init(void *dummy)
+{
+	opal_nest_ima_control(P8_NEST_ENGINE_START);
+}
+
+static void nest_change_cpu_context(int old_cpu, int new_cpu)
+{
+	int i;
+
+	for (i=0; per_nestpmu_arr[i] != NULL; i++)
+		perf_pmu_migrate_context(&per_nestpmu_arr[i]->pmu,
+						old_cpu, new_cpu);
+	return;
+}
+
+static void nest_exit_cpu(int cpu)
+{
+	int i, nid, target = -1;
+	const struct cpumask *l_cpumask;
+	int src_chipid;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &cpu_mask_nest_pmu))
+		return;
+
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
+	cpumask_set_cpu(target, &cpu_mask_nest_pmu);
+	nest_change_cpu_context (cpu, target);
+	return;
+}
+
+static void nest_init_cpu(int cpu)
+{
+	int i, src_chipid;
+
+	src_chipid = topology_physical_package_id(cpu);
+	for_each_cpu(i, &cpu_mask_nest_pmu)
+		if (src_chipid == topology_physical_package_id(i))
+			return;
+
+	cpumask_set_cpu(cpu, &cpu_mask_nest_pmu);
+	nest_change_cpu_context ( -1, cpu);
+	return;
+}
+
+static int nest_cpu_notifier(struct notifier_block *self,
+				unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (long)hcpu;
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
+}
+
 void cpumask_chip(void)
 {
 	const struct cpumask *l_cpumask;
@@ -47,6 +127,10 @@ void cpumask_chip(void)
 		cpumask_set_cpu(cpu, &cpu_mask_nest_pmu);
 	}
 
+	on_each_cpu_mask(&cpu_mask_nest_pmu, (smp_call_func_t)nest_init, NULL, 1);
+
+	__register_cpu_notifier(&nest_cpu_nb);
+
 	cpu_notifier_register_done();
 }
 
-- 
1.9.1
