Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A0AD42C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 14:06:17 +1000 (EST)
Message-ID: <1380081964.5443.79.camel@pasglop>
Subject: [PATCH] powerpc/pseries: Do not start secondaries in Open Firmware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 25 Sep 2013 14:06:04 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Starting secondary CPUs early on from Open Firmware and placing them
in a holding spin loop slows down the boot process significantly under
some hypervisors such as KVM.

This is also unnecessary when RTAS supports querying the CPU state

So let's not do it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c      | 21 +++++++++++++++++++++
 arch/powerpc/platforms/pseries/smp.c | 26 ++++++++++++++++----------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 12e656f..5fe2842 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -196,6 +196,8 @@ static int __initdata mem_reserve_cnt;
 
 static cell_t __initdata regbuf[1024];
 
+static bool rtas_has_query_cpu_stopped;
+
 
 /*
  * Error results ... some OF calls will return "-1" on error, some
@@ -1574,6 +1576,11 @@ static void __init prom_instantiate_rtas(void)
 	prom_setprop(rtas_node, "/rtas", "linux,rtas-entry",
 		     &val, sizeof(val));
 
+	/* Check if it supports "query-cpu-stopped-state" */
+	if (prom_getprop(rtas_node, "query-cpu-stopped-state",
+			 &val, sizeof(val)) != PROM_ERROR)
+		rtas_has_query_cpu_stopped = true;
+
 #if defined(CONFIG_PPC_POWERNV) && defined(__BIG_ENDIAN__)
 	/* PowerVN takeover hack */
 	prom_rtas_data = base;
@@ -1815,6 +1822,18 @@ static void __init prom_hold_cpus(void)
 		= (void *) LOW_ADDR(__secondary_hold_acknowledge);
 	unsigned long secondary_hold = LOW_ADDR(__secondary_hold);
 
+	/*
+	 * On pseries, if RTAS supports "query-cpu-stopped-state",
+	 * we skip this stage, the CPUs will be started by the
+	 * kernel using RTAS.
+	 */
+	if ((of_platform == PLATFORM_PSERIES ||
+	     of_platform == PLATFORM_PSERIES_LPAR) &&
+	    rtas_has_query_cpu_stopped) {
+		prom_printf("prom_hold_cpus: skipped\n");
+		return;
+	}
+
 	prom_debug("prom_hold_cpus: start...\n");
 	prom_debug("    1) spinloop       = 0x%x\n", (unsigned long)spinloop);
 	prom_debug("    1) *spinloop      = 0x%x\n", *spinloop);
@@ -3011,6 +3030,8 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 * On non-powermacs, put all CPUs in spin-loops.
 	 *
 	 * PowerMacs use a different mechanism to spin CPUs
+	 *
+	 * (This must be done after instanciating RTAS)
 	 */
 	if (of_platform != PLATFORM_POWERMAC &&
 	    of_platform != PLATFORM_OPAL)
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 1c1771a..24f58cb 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -233,18 +233,24 @@ static void __init smp_init_pseries(void)
 
 	alloc_bootmem_cpumask_var(&of_spin_mask);
 
-	/* Mark threads which are still spinning in hold loops. */
-	if (cpu_has_feature(CPU_FTR_SMT)) {
-		for_each_present_cpu(i) { 
-			if (cpu_thread_in_core(i) == 0)
-				cpumask_set_cpu(i, of_spin_mask);
-		}
-	} else {
-		cpumask_copy(of_spin_mask, cpu_present_mask);
+	/*
+	 * Mark threads which are still spinning in hold loops
+	 *
+	 * We know prom_init will not have started them if RTAS supports
+	 * query-cpu-stopped-state.
+	 */
+	if (rtas_token("query-cpu-stopped-state") == RTAS_UNKNOWN_SERVICE) {
+		if (cpu_has_feature(CPU_FTR_SMT)) {
+			for_each_present_cpu(i) {
+				if (cpu_thread_in_core(i) == 0)
+					cpumask_set_cpu(i, of_spin_mask);
+			}
+		} else
+			cpumask_copy(of_spin_mask, cpu_present_mask);
+
+		cpumask_clear_cpu(boot_cpuid, of_spin_mask);
 	}
 
-	cpumask_clear_cpu(boot_cpuid, of_spin_mask);
-
 	/* Non-lpar has additional take/give timebase */
 	if (rtas_token("freeze-time-base") != RTAS_UNKNOWN_SERVICE) {
 		smp_ops->give_timebase = rtas_give_timebase;
