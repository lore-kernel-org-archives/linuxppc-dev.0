Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013432.086808247@samba.org>
Date: Tue, 27 Apr 2010 11:32:37 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 06/15] powerpc: cpumask: Convert pseries SMP code to new
	cpumask API
References: <20100427013231.510168034@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use new cpumask functions in pseries SMP startup code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/pseries/smp.c	2010-04-08 19:46:04.089198328 +1000
+++ linux-cpumask/arch/powerpc/platforms/pseries/smp.c	2010-04-22 13:03:17.517946041 +1000
@@ -55,7 +55,7 @@
  * The Primary thread of each non-boot processor was started from the OF client
  * interface by prom_hold_cpus and is spinning on secondary_hold_spinloop.
  */
-static cpumask_t of_spin_map;
+static cpumask_var_t of_spin_mask;
 
 /**
  * smp_startup_cpu() - start the given cpu
@@ -76,7 +76,7 @@ static inline int __devinit smp_startup_
 	unsigned int pcpu;
 	int start_cpu;
 
-	if (cpu_isset(lcpu, of_spin_map))
+	if (cpumask_test_cpu(lcpu, of_spin_mask))
 		/* Already started by OF and sitting in spin loop */
 		return 1;
 
@@ -115,7 +115,7 @@ static void __devinit smp_xics_setup_cpu
 	if (firmware_has_feature(FW_FEATURE_SPLPAR))
 		vpa_init(cpu);
 
-	cpu_clear(cpu, of_spin_map);
+	cpumask_clear_cpu(cpu, of_spin_mask);
 	set_cpu_current_state(cpu, CPU_STATE_ONLINE);
 	set_default_offline_state(cpu);
 
@@ -186,17 +186,19 @@ static void __init smp_init_pseries(void
 
 	pr_debug(" -> smp_init_pSeries()\n");
 
+	alloc_bootmem_cpumask_var(&of_spin_mask);
+
 	/* Mark threads which are still spinning in hold loops. */
 	if (cpu_has_feature(CPU_FTR_SMT)) {
 		for_each_present_cpu(i) { 
 			if (cpu_thread_in_core(i) == 0)
-				cpu_set(i, of_spin_map);
+				cpumask_set_cpu(i, of_spin_mask);
 		}
 	} else {
-		of_spin_map = cpu_present_map;
+		cpumask_copy(of_spin_mask, cpu_present_mask);
 	}
 
-	cpu_clear(boot_cpuid, of_spin_map);
+	cpumask_clear_cpu(boot_cpuid, of_spin_mask);
 
 	/* Non-lpar has additional take/give timebase */
 	if (rtas_token("freeze-time-base") != RTAS_UNKNOWN_SERVICE) {
