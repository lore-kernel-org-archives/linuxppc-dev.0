Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BC2E8B7105
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 19:30:08 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 19 Jun 2009 19:30:07 +1000
Subject: [PATCH] powerpc/pmac: Fix issues with PowerMac "PowerSurge" SMP
Message-Id: <20090619093008.AAFADDDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The old PowerSurge SMP (ie, dual or quad 604 machines) code has
numerous issues in modern world.

One is cpu_possible_map is set too late (the device-tree is bogus)
so we fail to allocate the interrupt stacks and crash. Another
problem is the fact the timebase is frozen by the bringup of the
second CPU so the delays in the generic code will hang, we need
to move some of the calling procedure to inside the powermac code.

This makes it boot again for me

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/smp.c               |    3 
 arch/powerpc/platforms/powermac/setup.c |   41 +------
 arch/powerpc/platforms/powermac/smp.c   |  166 +++++++++++++++++++-------------
 3 files changed, 112 insertions(+), 98 deletions(-)

--- linux-work.orig/arch/powerpc/platforms/powermac/setup.c	2009-06-19 17:11:28.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/setup.c	2009-06-19 17:12:28.000000000 +1000
@@ -103,11 +103,6 @@ unsigned long smu_cmdbuf_abs;
 EXPORT_SYMBOL(smu_cmdbuf_abs);
 #endif
 
-#ifdef CONFIG_SMP
-extern struct smp_ops_t psurge_smp_ops;
-extern struct smp_ops_t core99_smp_ops;
-#endif /* CONFIG_SMP */
-
 static void pmac_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *np;
@@ -341,34 +336,6 @@ static void __init pmac_setup_arch(void)
 		ROOT_DEV = DEFAULT_ROOT_DEVICE;
 #endif
 
-#ifdef CONFIG_SMP
-	/* Check for Core99 */
-	ic = of_find_node_by_name(NULL, "uni-n");
-	if (!ic)
-		ic = of_find_node_by_name(NULL, "u3");
-	if (!ic)
-		ic = of_find_node_by_name(NULL, "u4");
-	if (ic) {
-		of_node_put(ic);
-		smp_ops = &core99_smp_ops;
-	}
-#ifdef CONFIG_PPC32
-	else {
-		/*
-		 * We have to set bits in cpu_possible_map here since the
-		 * secondary CPU(s) aren't in the device tree, and
-		 * setup_per_cpu_areas only allocates per-cpu data for
-		 * CPUs in the cpu_possible_map.
-		 */
-		int cpu;
-
-		for (cpu = 1; cpu < 4 && cpu < NR_CPUS; ++cpu)
-			cpu_set(cpu, cpu_possible_map);
-		smp_ops = &psurge_smp_ops;
-	}
-#endif
-#endif /* CONFIG_SMP */
-
 #ifdef CONFIG_ADB
 	if (strstr(cmd_line, "adb_sync")) {
 		extern int __adb_probe_sync;
@@ -512,6 +479,14 @@ static void __init pmac_init_early(void)
 #ifdef CONFIG_PPC64
 	iommu_init_early_dart();
 #endif
+
+	/* SMP Init has to be done early as we need to patch up
+	 * cpu_possible_map before interrupt stacks are allocated
+	 * or kaboom...
+	 */
+#ifdef CONFIG_SMP
+	pmac_setup_smp();
+#endif
 }
 
 static int __init pmac_declare_of_platform_devices(void)
Index: linux-work/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/smp.c	2009-06-19 17:11:28.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/smp.c	2009-06-19 19:27:33.000000000 +1000
@@ -64,10 +64,11 @@
 extern void __secondary_start_pmac_0(void);
 extern int pmac_pfunc_base_install(void);
 
-#ifdef CONFIG_PPC32
+static void (*pmac_tb_freeze)(int freeze);
+static u64 timebase;
+static int tb_req;
 
-/* Sync flag for HW tb sync */
-static volatile int sec_tb_reset = 0;
+#ifdef CONFIG_PPC32
 
 /*
  * Powersurge (old powermac SMP) support.
@@ -294,6 +295,9 @@ static int __init smp_psurge_probe(void)
 		psurge_quad_init();
 		/* All released cards using this HW design have 4 CPUs */
 		ncpus = 4;
+		/* No sure how timebase sync works on those, let's use SW */
+		smp_ops->give_timebase = smp_generic_give_timebase;
+		smp_ops->take_timebase = smp_generic_take_timebase;
 	} else {
 		iounmap(quad_base);
 		if ((in_8(hhead_base + HHEAD_CONFIG) & 0x02) == 0) {
@@ -308,18 +312,15 @@ static int __init smp_psurge_probe(void)
 	psurge_start = ioremap(PSURGE_START, 4);
 	psurge_pri_intr = ioremap(PSURGE_PRI_INTR, 4);
 
-	/*
-	 * This is necessary because OF doesn't know about the
+	/* This is necessary because OF doesn't know about the
 	 * secondary cpu(s), and thus there aren't nodes in the
 	 * device tree for them, and smp_setup_cpu_maps hasn't
-	 * set their bits in cpu_possible_map and cpu_present_map.
+	 * set their bits in cpu_present_map.
 	 */
 	if (ncpus > NR_CPUS)
 		ncpus = NR_CPUS;
-	for (i = 1; i < ncpus ; ++i) {
+	for (i = 1; i < ncpus ; ++i)
 		cpu_set(i, cpu_present_map);
-		set_hard_smp_processor_id(i, i);
-	}
 
 	if (ppc_md.progress) ppc_md.progress("smp_psurge_probe - done", 0x352);
 
@@ -329,8 +330,14 @@ static int __init smp_psurge_probe(void)
 static void __init smp_psurge_kick_cpu(int nr)
 {
 	unsigned long start = __pa(__secondary_start_pmac_0) + nr * 8;
-	unsigned long a;
-	int i;
+	unsigned long a, flags;
+	int i, j;
+
+	/* Defining this here is evil ... but I prefer hiding that
+	 * crap to avoid giving people ideas that they can do the
+	 * same.
+	 */
+	extern volatile unsigned int cpu_callin_map[NR_CPUS];
 
 	/* may need to flush here if secondary bats aren't setup */
 	for (a = KERNELBASE; a < KERNELBASE + 0x800000; a += 32)
@@ -339,47 +346,52 @@ static void __init smp_psurge_kick_cpu(i
 
 	if (ppc_md.progress) ppc_md.progress("smp_psurge_kick_cpu", 0x353);
 
+	/* This is going to freeze the timeebase, we disable interrupts */
+	local_irq_save(flags);
+
 	out_be32(psurge_start, start);
 	mb();
 
 	psurge_set_ipi(nr);
+
 	/*
 	 * We can't use udelay here because the timebase is now frozen.
 	 */
 	for (i = 0; i < 2000; ++i)
-		barrier();
+		asm volatile("nop" : : : "memory");
 	psurge_clr_ipi(nr);
 
-	if (ppc_md.progress) ppc_md.progress("smp_psurge_kick_cpu - done", 0x354);
-}
-
-/*
- * With the dual-cpu powersurge board, the decrementers and timebases
- * of both cpus are frozen after the secondary cpu is started up,
- * until we give the secondary cpu another interrupt.  This routine
- * uses this to get the timebases synchronized.
- *  -- paulus.
- */
-static void __init psurge_dual_sync_tb(int cpu_nr)
-{
-	int t;
-
-	set_dec(tb_ticks_per_jiffy);
-	/* XXX fixme */
-	set_tb(0, 0);
-
-	if (cpu_nr > 0) {
+	/*
+	 * Also, because the timebase is frozen, we must not return to the
+	 * caller which will try to do udelay's etc... Instead, we wait -here-
+	 * for the CPU to callin.
+	 */
+	for (i = 0; i < 100000 && !cpu_callin_map[nr]; ++i) {
+		for (j = 1; j < 10000; j++)
+			asm volatile("nop" : : : "memory");
+		asm volatile("sync" : : : "memory");
+	}
+	if (!cpu_callin_map[nr])
+		goto stuck;
+
+	/* And we do the TB sync here too for standard dual CPU cards */
+	if (psurge_type == PSURGE_DUAL) {
+		while(!tb_req)
+			barrier();
+		tb_req = 0;
+		mb();
+		timebase = get_tb();
+		mb();
+		while (timebase)
+			barrier();
 		mb();
-		sec_tb_reset = 1;
-		return;
 	}
+ stuck:
+	/* now interrupt the secondary, restarting both TBs */
+	if (psurge_type == PSURGE_DUAL)
+		psurge_set_ipi(1);
 
-	/* wait for the secondary to have reset its TB before proceeding */
-	for (t = 10000000; t > 0 && !sec_tb_reset; --t)
-		;
-
-	/* now interrupt the secondary, starting both TBs */
-	psurge_set_ipi(1);
+	if (ppc_md.progress) ppc_md.progress("smp_psurge_kick_cpu - done", 0x354);
 }
 
 static struct irqaction psurge_irqaction = {
@@ -390,36 +402,35 @@ static struct irqaction psurge_irqaction
 
 static void __init smp_psurge_setup_cpu(int cpu_nr)
 {
+	if (cpu_nr != 0)
+		return;
 
-	if (cpu_nr == 0) {
-		/* If we failed to start the second CPU, we should still
-		 * send it an IPI to start the timebase & DEC or we might
-		 * have them stuck.
-		 */
-		if (num_online_cpus() < 2) {
-			if (psurge_type == PSURGE_DUAL)
-				psurge_set_ipi(1);
-			return;
-		}
-		/* reset the entry point so if we get another intr we won't
-		 * try to startup again */
-		out_be32(psurge_start, 0x100);
-		if (setup_irq(30, &psurge_irqaction))
-			printk(KERN_ERR "Couldn't get primary IPI interrupt");
-	}
-
-	if (psurge_type == PSURGE_DUAL)
-		psurge_dual_sync_tb(cpu_nr);
+	/* reset the entry point so if we get another intr we won't
+	 * try to startup again */
+	out_be32(psurge_start, 0x100);
+	if (setup_irq(30, &psurge_irqaction))
+		printk(KERN_ERR "Couldn't get primary IPI interrupt");
 }
 
 void __init smp_psurge_take_timebase(void)
 {
-	/* Dummy implementation */
+	if (psurge_type != PSURGE_DUAL)
+		return;
+
+	tb_req = 1;
+	mb();
+	while (!timebase)
+		barrier();
+	mb();
+	set_tb(timebase >> 32, timebase & 0xffffffff);
+	timebase = 0;
+	mb();
+	set_dec(tb_ticks_per_jiffy/2);
 }
 
 void __init smp_psurge_give_timebase(void)
 {
-	/* Dummy implementation */
+	/* Nothing to do here */
 }
 
 /* PowerSurge-style Macs */
@@ -437,9 +448,6 @@ struct smp_ops_t psurge_smp_ops = {
  * Core 99 and later support
  */
 
-static void (*pmac_tb_freeze)(int freeze);
-static u64 timebase;
-static int tb_req;
 
 static void smp_core99_give_timebase(void)
 {
@@ -478,7 +486,6 @@ static void __devinit smp_core99_take_ti
 	set_tb(timebase >> 32, timebase & 0xffffffff);
 	timebase = 0;
 	mb();
-	set_dec(tb_ticks_per_jiffy/2);
 
 	local_irq_restore(flags);
 }
@@ -920,3 +927,34 @@ struct smp_ops_t core99_smp_ops = {
 # endif
 #endif
 };
+
+void __init pmac_setup_smp(void)
+{
+	struct device_node *np;
+
+	/* Check for Core99 */
+	np = of_find_node_by_name(NULL, "uni-n");
+	if (!np)
+		np = of_find_node_by_name(NULL, "u3");
+	if (!np)
+		np = of_find_node_by_name(NULL, "u4");
+	if (np) {
+		of_node_put(np);
+		smp_ops = &core99_smp_ops;
+	}
+#ifdef CONFIG_PPC32
+	else {
+		/* We have to set bits in cpu_possible_map here since the
+		 * secondary CPU(s) aren't in the device tree. Various
+		 * things won't be initialized for CPUs not in the possible
+		 * map, so we really need to fix it up here.
+		 */
+		int cpu;
+
+		for (cpu = 1; cpu < 4 && cpu < NR_CPUS; ++cpu)
+			cpu_set(cpu, cpu_possible_map);
+		smp_ops = &psurge_smp_ops;
+	}
+#endif /* CONFIG_PPC32 */
+}
+
Index: linux-work/arch/powerpc/kernel/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/smp.c	2009-06-19 17:11:28.000000000 +1000
+++ linux-work/arch/powerpc/kernel/smp.c	2009-06-19 19:27:44.000000000 +1000
@@ -68,7 +68,8 @@ EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 /* SMP operations for this machine */
 struct smp_ops_t *smp_ops;
 
-static volatile unsigned int cpu_callin_map[NR_CPUS];
+/* Can't be static due to PowerMac hackery */
+volatile unsigned int cpu_callin_map[NR_CPUS];
 
 int smt_enabled_at_boot = 1;
 
