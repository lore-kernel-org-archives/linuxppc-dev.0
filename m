Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <af31e2bed38ab29c4a242cd3209a985d550271ef.1302594536.git.michael@ellerman.id.au>
Subject: [PATCH] powerpc: smp_ops->kick_cpu() should be able to fail
Date: Tue, 12 Apr 2011 17:46:19 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we start a cpu we use smp_ops->kick_cpu(), which currently
returns void, it should be able to fail. Convert it to return
int, and update all uses.

Convert all the current error cases to return -ENOENT, which is
what would eventually be returned by __cpu_up() currently when
it doesn't detect the cpu as coming up in time.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/machdep.h        |    2 +-
 arch/powerpc/include/asm/smp.h            |    2 +-
 arch/powerpc/kernel/smp.c                 |   10 ++++++++--
 arch/powerpc/platforms/44x/iss4xx.c       |    6 ++++--
 arch/powerpc/platforms/85xx/smp.c         |    6 ++++--
 arch/powerpc/platforms/86xx/mpc86xx_smp.c |    6 ++++--
 arch/powerpc/platforms/cell/beat_smp.c    |    5 ++---
 arch/powerpc/platforms/cell/smp.c         |    6 ++++--
 arch/powerpc/platforms/chrp/smp.c         |    4 +++-
 arch/powerpc/platforms/iseries/smp.c      |    6 ++++--
 arch/powerpc/platforms/powermac/smp.c     |   10 +++++++---
 arch/powerpc/platforms/pseries/smp.c      |    6 ++++--
 12 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 493dbb3..c6345ac 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -33,7 +33,7 @@ struct kimage;
 struct smp_ops_t {
 	void  (*message_pass)(int target, int msg);
 	int   (*probe)(void);
-	void  (*kick_cpu)(int nr);
+	int   (*kick_cpu)(int nr);
 	void  (*setup_cpu)(int nr);
 	void  (*bringup_done)(void);
 	void  (*take_timebase)(void);
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index bb4c033..5087349 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -150,7 +150,7 @@ extern int smt_enabled_at_boot;
 
 extern int smp_mpic_probe(void);
 extern void smp_mpic_setup_cpu(int cpu);
-extern void smp_generic_kick_cpu(int nr);
+extern int smp_generic_kick_cpu(int nr);
 
 extern void smp_generic_give_timebase(void);
 extern void smp_generic_take_timebase(void);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index cbdbb14..b6083f4 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -95,7 +95,7 @@ int smt_enabled_at_boot = 1;
 static void (*crash_ipi_function_ptr)(struct pt_regs *) = NULL;
 
 #ifdef CONFIG_PPC64
-void __devinit smp_generic_kick_cpu(int nr)
+int __devinit smp_generic_kick_cpu(int nr)
 {
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
@@ -106,6 +106,8 @@ void __devinit smp_generic_kick_cpu(int nr)
 	 */
 	paca[nr].cpu_start = 1;
 	smp_mb();
+
+	return 0;
 }
 #endif
 
@@ -434,7 +436,11 @@ int __cpuinit __cpu_up(unsigned int cpu)
 
 	/* wake up cpus */
 	DBG("smp: kicking cpu %d\n", cpu);
-	smp_ops->kick_cpu(cpu);
+	rc = smp_ops->kick_cpu(cpu);
+	if (rc) {
+		pr_err("smp: failed starting cpu %d (rc %d)\n", cpu, rc);
+		return rc;
+	}
 
 	/*
 	 * wait to see if the cpu made a callin (is actually up).
diff --git a/arch/powerpc/platforms/44x/iss4xx.c b/arch/powerpc/platforms/44x/iss4xx.c
index aa46e9d..19395f1 100644
--- a/arch/powerpc/platforms/44x/iss4xx.c
+++ b/arch/powerpc/platforms/44x/iss4xx.c
@@ -87,7 +87,7 @@ static void __cpuinit smp_iss4xx_setup_cpu(int cpu)
 	mpic_setup_this_cpu();
 }
 
-static void __cpuinit smp_iss4xx_kick_cpu(int cpu)
+static int __cpuinit smp_iss4xx_kick_cpu(int cpu)
 {
 	struct device_node *cpunode = of_get_cpu_node(cpu, NULL);
 	const u64 *spin_table_addr_prop;
@@ -104,7 +104,7 @@ static void __cpuinit smp_iss4xx_kick_cpu(int cpu)
 					       NULL);
 	if (spin_table_addr_prop == NULL) {
 		pr_err("CPU%d: Can't start, missing cpu-release-addr !\n", cpu);
-		return;
+		return -ENOENT;
 	}
 
 	/* Assume it's mapped as part of the linear mapping. This is a bit
@@ -117,6 +117,8 @@ static void __cpuinit smp_iss4xx_kick_cpu(int cpu)
 	smp_wmb();
 	spin_table[1] = __pa(start_secondary_47x);
 	mb();
+
+	return 0;
 }
 
 static struct smp_ops_t iss_smp_ops = {
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 0d00ff9..fe3f6a3 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -41,7 +41,7 @@ extern void __early_start(void);
 #define NUM_BOOT_ENTRY		8
 #define SIZE_BOOT_ENTRY		(NUM_BOOT_ENTRY * sizeof(u32))
 
-static void __init
+static int __init
 smp_85xx_kick_cpu(int nr)
 {
 	unsigned long flags;
@@ -60,7 +60,7 @@ smp_85xx_kick_cpu(int nr)
 
 	if (cpu_rel_addr == NULL) {
 		printk(KERN_ERR "No cpu-release-addr for cpu %d\n", nr);
-		return;
+		return -ENOENT;
 	}
 
 	/*
@@ -107,6 +107,8 @@ smp_85xx_kick_cpu(int nr)
 		iounmap(bptr_vaddr);
 
 	pr_debug("waited %d msecs for CPU #%d.\n", n, nr);
+
+	return 0;
 }
 
 static void __init
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
index eacea0e..af09bae 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
@@ -56,7 +56,7 @@ smp_86xx_release_core(int nr)
 }
 
 
-static void __init
+static int __init
 smp_86xx_kick_cpu(int nr)
 {
 	unsigned int save_vector;
@@ -65,7 +65,7 @@ smp_86xx_kick_cpu(int nr)
 	unsigned int *vector = (unsigned int *)(KERNELBASE + 0x100);
 
 	if (nr < 0 || nr >= NR_CPUS)
-		return;
+		return -ENOENT;
 
 	pr_debug("smp_86xx_kick_cpu: kick CPU #%d\n", nr);
 
@@ -92,6 +92,8 @@ smp_86xx_kick_cpu(int nr)
 	local_irq_restore(flags);
 
 	pr_debug("wait CPU #%d for %d msecs.\n", nr, n);
+
+	return 0;
 }
 
 
diff --git a/arch/powerpc/platforms/cell/beat_smp.c b/arch/powerpc/platforms/cell/beat_smp.c
index 26efc20..996df33 100644
--- a/arch/powerpc/platforms/cell/beat_smp.c
+++ b/arch/powerpc/platforms/cell/beat_smp.c
@@ -93,12 +93,11 @@ static void __devinit smp_beatic_setup_cpu(int cpu)
 	beatic_setup_cpu(cpu);
 }
 
-static void __devinit smp_celleb_kick_cpu(int nr)
+static int __devinit smp_celleb_kick_cpu(int nr)
 {
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
-	if (!smp_startup_cpu(nr))
-		return;
+	return smp_startup_cpu(nr);
 }
 
 static int smp_celleb_cpu_bootable(unsigned int nr)
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index f774530..03d638e 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -137,12 +137,12 @@ static void __devinit smp_cell_setup_cpu(int cpu)
 	mtspr(SPRN_DABRX, DABRX_KERNEL | DABRX_USER);
 }
 
-static void __devinit smp_cell_kick_cpu(int nr)
+static int __devinit smp_cell_kick_cpu(int nr)
 {
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
 	if (!smp_startup_cpu(nr))
-		return;
+		return -ENOENT;
 
 	/*
 	 * The processor is currently spinning, waiting for the
@@ -150,6 +150,8 @@ static void __devinit smp_cell_kick_cpu(int nr)
 	 * the processor will continue on to secondary_start
 	 */
 	paca[nr].cpu_start = 1;
+
+	return 0;
 }
 
 static int smp_cell_cpu_bootable(unsigned int nr)
diff --git a/arch/powerpc/platforms/chrp/smp.c b/arch/powerpc/platforms/chrp/smp.c
index 02cafec..a800122 100644
--- a/arch/powerpc/platforms/chrp/smp.c
+++ b/arch/powerpc/platforms/chrp/smp.c
@@ -30,10 +30,12 @@
 #include <asm/mpic.h>
 #include <asm/rtas.h>
 
-static void __devinit smp_chrp_kick_cpu(int nr)
+static int __devinit smp_chrp_kick_cpu(int nr)
 {
 	*(unsigned long *)KERNELBASE = nr;
 	asm volatile("dcbf 0,%0"::"r"(KERNELBASE):"memory");
+
+	return 0;
 }
 
 static void __devinit smp_chrp_setup_cpu(int cpu_nr)
diff --git a/arch/powerpc/platforms/iseries/smp.c b/arch/powerpc/platforms/iseries/smp.c
index 6c60299..02a677a 100644
--- a/arch/powerpc/platforms/iseries/smp.c
+++ b/arch/powerpc/platforms/iseries/smp.c
@@ -86,13 +86,13 @@ static int smp_iSeries_probe(void)
 	return cpumask_weight(cpu_possible_mask);
 }
 
-static void smp_iSeries_kick_cpu(int nr)
+static int smp_iSeries_kick_cpu(int nr)
 {
 	BUG_ON((nr < 0) || (nr >= NR_CPUS));
 
 	/* Verify that our partition has a processor nr */
 	if (lppaca_of(nr).dyn_proc_status >= 2)
-		return;
+		return -ENOENT;
 
 	/* The processor is currently spinning, waiting
 	 * for the cpu_start field to become non-zero
@@ -100,6 +100,8 @@ static void smp_iSeries_kick_cpu(int nr)
 	 * continue on to secondary_start in iSeries_head.S
 	 */
 	paca[nr].cpu_start = 1;
+
+	return 0;
 }
 
 static void __devinit smp_iSeries_setup_cpu(int nr)
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index dd4ffab..5ab874d 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -329,7 +329,7 @@ static int __init smp_psurge_probe(void)
 	return ncpus;
 }
 
-static void __init smp_psurge_kick_cpu(int nr)
+static int __init smp_psurge_kick_cpu(int nr)
 {
 	unsigned long start = __pa(__secondary_start_pmac_0) + nr * 8;
 	unsigned long a, flags;
@@ -394,6 +394,8 @@ static void __init smp_psurge_kick_cpu(int nr)
 		psurge_set_ipi(1);
 
 	if (ppc_md.progress) ppc_md.progress("smp_psurge_kick_cpu - done", 0x354);
+
+	return 0;
 }
 
 static struct irqaction psurge_irqaction = {
@@ -791,14 +793,14 @@ static int __init smp_core99_probe(void)
 	return ncpus;
 }
 
-static void __devinit smp_core99_kick_cpu(int nr)
+static int __devinit smp_core99_kick_cpu(int nr)
 {
 	unsigned int save_vector;
 	unsigned long target, flags;
 	unsigned int *vector = (unsigned int *)(PAGE_OFFSET+0x100);
 
 	if (nr < 0 || nr > 3)
-		return;
+		return -ENOENT;
 
 	if (ppc_md.progress)
 		ppc_md.progress("smp_core99_kick_cpu", 0x346);
@@ -830,6 +832,8 @@ static void __devinit smp_core99_kick_cpu(int nr)
 
 	local_irq_restore(flags);
 	if (ppc_md.progress) ppc_md.progress("smp_core99_kick_cpu done", 0x347);
+
+	return 0;
 }
 
 static void __devinit smp_core99_setup_cpu(int cpu_nr)
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 97de014..0ccae9a 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -149,14 +149,14 @@ static void __devinit smp_xics_setup_cpu(int cpu)
 
 }
 
-static void __devinit smp_pSeries_kick_cpu(int nr)
+static int __devinit smp_pSeries_kick_cpu(int nr)
 {
 	long rc;
 	unsigned long hcpuid;
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
 	if (!smp_startup_cpu(nr))
-		return;
+		return -ENOENT;
 
 	/*
 	 * The processor is currently spinning, waiting for the
@@ -174,6 +174,8 @@ static void __devinit smp_pSeries_kick_cpu(int nr)
 			printk(KERN_ERR "Error: Prod to wake up processor %d "
 						"Ret= %ld\n", nr, rc);
 	}
+
+	return 0;
 }
 
 static int smp_pSeries_cpu_bootable(unsigned int nr)
-- 
1.7.1
