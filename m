Return-Path: <anna-maria@linutronix.de>
Received: from Galois.linutronix.de (linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp56x4mHCzDqyL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 23:10:17 +1000 (AEST)
Message-Id: <20160711122533.069789292@linutronix.de>
Date: Mon, 11 Jul 2016 12:28:43 -0000
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [patch 29/66] powerpc: numa: Convert to hotplug state machine
References: <20160711122450.923603742@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/powerpc/mm/numa.c     |   46 +++++++++++++++------------------------------
 include/linux/cpuhotplug.h |    1 
 2 files changed, 17 insertions(+), 30 deletions(-)

--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -581,30 +581,22 @@ static void verify_cpu_node_mapping(int
 	}
 }
 
-static int cpu_numa_callback(struct notifier_block *nfb, unsigned long action,
-			     void *hcpu)
+/* Must run before sched domains notifier. */
+static int ppc_numa_cpu_prepare(unsigned int cpu)
 {
-	unsigned long lcpu = (unsigned long)hcpu;
-	int ret = NOTIFY_DONE, nid;
+	int nid;
+
+	nid = numa_setup_cpu(cpu);
+	verify_cpu_node_mapping(cpu, nid);
+	return 0;
+}
 
-	switch (action) {
-	case CPU_UP_PREPARE:
-	case CPU_UP_PREPARE_FROZEN:
-		nid = numa_setup_cpu(lcpu);
-		verify_cpu_node_mapping((int)lcpu, nid);
-		ret = NOTIFY_OK;
-		break;
+static int ppc_numa_cpu_dead(unsigned int cpu)
+{
 #ifdef CONFIG_HOTPLUG_CPU
-	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
-	case CPU_UP_CANCELED:
-	case CPU_UP_CANCELED_FROZEN:
-		unmap_cpu_from_node(lcpu);
-		ret = NOTIFY_OK;
-		break;
+	unmap_cpu_from_node(cpu);
 #endif
-	}
-	return ret;
+	return 0;
 }
 
 /*
@@ -913,11 +905,6 @@ static void __init dump_numa_memory_topo
 	}
 }
 
-static struct notifier_block ppc64_numa_nb = {
-	.notifier_call = cpu_numa_callback,
-	.priority = 1 /* Must run before sched domains notifier. */
-};
-
 /* Initialize NODE_DATA for a node on the local memory */
 static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 {
@@ -953,7 +940,7 @@ static void __init setup_node_data(int n
 
 void __init initmem_init(void)
 {
-	int nid, cpu;
+	int nid;
 
 	max_low_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
 	max_pfn = max_low_pfn;
@@ -985,15 +972,14 @@ void __init initmem_init(void)
 	setup_node_to_cpumask_map();
 
 	reset_numa_cpu_lookup_table();
-	register_cpu_notifier(&ppc64_numa_nb);
+
 	/*
 	 * We need the numa_cpu_lookup_table to be accurate for all CPUs,
 	 * even before we online them, so that we can use cpu_to_{node,mem}
 	 * early in boot, cf. smp_prepare_cpus().
 	 */
-	for_each_present_cpu(cpu) {
-		numa_setup_cpu((unsigned long)cpu);
-	}
+	cpuhp_setup_state(CPUHP_POWER_NUMA_PREPARE, "POWER_NUMA_PREPARE",
+			  ppc_numa_cpu_prepare, ppc_numa_cpu_dead);
 }
 
 static int __init early_numa(char *p)
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -14,6 +14,7 @@ enum cpuhp_state {
 	CPUHP_PERF_SUPERH,
 	CPUHP_X86_HPET_DEAD,
 	CPUHP_WORKQUEUE_PREP,
+	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_NOTIFY_PREPARE,
 	CPUHP_BRINGUP_CPU,
 	CPUHP_AP_IDLE_DEAD,
