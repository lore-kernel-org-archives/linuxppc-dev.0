Return-Path: <anna-maria@linutronix.de>
Received: from Galois.linutronix.de (linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp56q1yRdzDqyL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 23:10:11 +1000 (AEST)
Message-Id: <20160711122532.038000340@linutronix.de>
Date: Mon, 11 Jul 2016 12:28:35 -0000
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [patch 17/66] powerpc: perf: Convert book3s notifier to state machine
 callbacks
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

From: Thomas Gleixner <tglx@linutronix.de>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/powerpc/perf/core-book3s.c |   30 +++++++-----------------------
 include/linux/cpuhotplug.h      |    1 +
 2 files changed, 8 insertions(+), 23 deletions(-)

--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2158,31 +2158,15 @@ static void perf_event_interrupt(struct
 		irq_exit();
 }
 
-static void power_pmu_setup(int cpu)
+int power_pmu_prepare_cpu(unsigned int cpu)
 {
 	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
 
-	if (!ppmu)
-		return;
-	memset(cpuhw, 0, sizeof(*cpuhw));
-	cpuhw->mmcr[0] = MMCR0_FC;
-}
-
-static int
-power_pmu_notifier(struct notifier_block *self, unsigned long action, void *hcpu)
-{
-	unsigned int cpu = (long)hcpu;
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_UP_PREPARE:
-		power_pmu_setup(cpu);
-		break;
-
-	default:
-		break;
+	if (ppmu) {
+		memset(cpuhw, 0, sizeof(*cpuhw));
+		cpuhw->mmcr[0] = MMCR0_FC;
 	}
-
-	return NOTIFY_OK;
+	return 0;
 }
 
 int register_power_pmu(struct power_pmu *pmu)
@@ -2205,7 +2189,7 @@ int register_power_pmu(struct power_pmu
 #endif /* CONFIG_PPC64 */
 
 	perf_pmu_register(&power_pmu, "cpu", PERF_TYPE_RAW);
-	perf_cpu_notifier(power_pmu_notifier);
-
+	cpuhp_setup_state(CPUHP_PERF_POWER, "PERF_POWER",
+			  power_pmu_prepare_cpu, NULL);
 	return 0;
 }
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -10,6 +10,7 @@ enum cpuhp_state {
 	CPUHP_PERF_X86_AMD_UNCORE_PREP,
 	CPUHP_PERF_X86_RAPL_PREP,
 	CPUHP_PERF_BFIN,
+	CPUHP_PERF_POWER,
 	CPUHP_NOTIFY_PREPARE,
 	CPUHP_BRINGUP_CPU,
 	CPUHP_AP_IDLE_DEAD,
