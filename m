Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 04 Apr 2006 13:24:49 +0200
Subject: [RFC/PATCH] powerpc: Use rtas query-cpu-stopped-state in smp spinup
Message-Id: <20060404112459.C9170679EB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently we use a cpumask called of_spin_map to keep track of which threads
have been spun up. We basically guess that OF has spun up all even numbered
threads, and so all the odd numbered threads need to be brought up.

That's a bit of a dicey assumption at best, and is totally incorrect for
kexec. Luckily we have an rtas call which can tell us whether a cpu is up
or not, so let's use it?

I notice this code is duplicated in platforms/cell, do we want to move it into
kernel/rtas_smp.c or something?

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/smp.c |   48 +++++++----------------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

Index: to-merge/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/smp.c
+++ to-merge/arch/powerpc/platforms/pseries/smp.c
@@ -57,16 +57,6 @@
 #define DBG(fmt...)
 #endif
 
-/*
- * The primary thread of each non-boot processor is recorded here before
- * smp init.
- */
-static cpumask_t of_spin_map;
-
-extern void pSeries_secondary_smp_init(unsigned long);
-
-#ifdef CONFIG_HOTPLUG_CPU
-
 /* Get state of physical CPU.
  * Return codes:
  *	0	- The processor is in the RTAS stopped state
@@ -93,6 +83,8 @@ static int query_cpu_stopped(unsigned in
 	return cpu_status;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+
 static int pSeries_cpu_disable(void)
 {
 	int cpu = smp_processor_id();
@@ -269,22 +261,23 @@ static struct notifier_block pSeries_smp
  */
 static inline int __devinit smp_startup_cpu(unsigned int lcpu)
 {
-	int status;
+	extern void pSeries_secondary_smp_init(unsigned long);
 	unsigned long start_here = __pa((u32)*((unsigned long *)
 					       pSeries_secondary_smp_init));
 	unsigned int pcpu;
-	int start_cpu;
-
-	if (cpu_isset(lcpu, of_spin_map))
-		/* Already started by OF and sitting in spin loop */
-		return 1;
+	int start_cpu, status;
 
 	pcpu = get_hard_smp_processor_id(lcpu);
 
+	if (query_cpu_stopped(pcpu) == 0) {
+		DBG("CPU %d (%d) already running.\n", lcpu, pcpu);
+		return 1;
+	}
+
 	/* Fixup atomic count: it exited inside IRQ handler. */
 	task_thread_info(paca[lcpu].__current)->preempt_count	= 0;
 
-	/* 
+	/*
 	 * If the RTAS start-cpu token does not exist then presume the
 	 * cpu is already spinning.
 	 */
@@ -339,9 +332,6 @@ static void __devinit smp_xics_setup_cpu
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR))
 		vpa_init(cpu);
-
-	cpu_clear(cpu, of_spin_map);
-
 }
 #endif /* CONFIG_XICS */
 
@@ -419,8 +409,6 @@ static struct smp_ops_t pSeries_xics_smp
 /* This is called very early */
 void __init smp_init_pSeries(void)
 {
-	int i;
-
 	DBG(" -> smp_init_pSeries()\n");
 
 	switch (ppc64_interrupt_controller) {
@@ -447,22 +435,6 @@ void __init smp_init_pSeries(void)
 		pSeries_reconfig_notifier_register(&pSeries_smp_nb);
 #endif
 
-	/* Mark threads which are still spinning in hold loops. */
-	if (cpu_has_feature(CPU_FTR_SMT)) {
-		for_each_present_cpu(i) { 
-			if (i % 2 == 0)
-				/*
-				 * Even-numbered logical cpus correspond to
-				 * primary threads.
-				 */
-				cpu_set(i, of_spin_map);
-		}
-	} else {
-		of_spin_map = cpu_present_map;
-	}
-
-	cpu_clear(boot_cpuid, of_spin_map);
-
 	/* Non-lpar has additional take/give timebase */
 	if (rtas_token("freeze-time-base") != RTAS_UNKNOWN_SERVICE) {
 		smp_ops->give_timebase = pSeries_give_timebase;
