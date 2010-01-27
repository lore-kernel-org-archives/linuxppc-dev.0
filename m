Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <c22a0fd3d76675813ce5f1596d80614aee80ed24.1264568410.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Dynamically allocate pacas
Date: Wed, 27 Jan 2010 16:00:53 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 64-bit kernels we currently have a 512 byte struct paca_struct for
each cpu (usually just called "the paca"). Currently they are statically
allocated, which means a kernel built for a large number of cpus will
waste a lot of space if it's booted on a machine with few cpus.

We can avoid that by only allocating the number of pacas we need at
boot. However this is complicated by the fact that we need to access
the paca before we know how many cpus there are in the system.

The solution is to dynamically allocate enough space for NR_CPUS pacas,
but then later in boot when we know how many cpus we have, we free any
unused pacas.

Lightly booted on Legacy iSeries & pSeries LPAR.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/paca.h            |   18 +++++-
 arch/powerpc/kernel/head_64.S              |    6 +-
 arch/powerpc/kernel/paca.c                 |   93 +++++++++++++++++++++-------
 arch/powerpc/kernel/prom.c                 |    3 +
 arch/powerpc/kernel/setup-common.c         |    2 +
 arch/powerpc/kernel/setup_64.c             |   12 ++--
 arch/powerpc/platforms/iseries/exception.S |   25 +++++---
 7 files changed, 117 insertions(+), 42 deletions(-)


v2: Fix 32-bit build by adding nop routines in paca.h

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 5e9b4ef..fbcd003 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -14,6 +14,9 @@
 #define _ASM_POWERPC_PACA_H
 #ifdef __KERNEL__
 
+#ifdef CONFIG_PPC64
+
+#include <linux/init.h>
 #include <asm/types.h>
 #include <asm/lppaca.h>
 #include <asm/mmu.h>
@@ -140,8 +143,19 @@ struct paca_struct {
 #endif
 };
 
-extern struct paca_struct paca[];
-extern void initialise_pacas(void);
+extern struct paca_struct *paca;
+extern __initdata struct paca_struct boot_paca;
+extern void initialise_paca(struct paca_struct *new_paca, int cpu);
+
+extern void allocate_pacas(void);
+extern void free_unused_pacas(void);
+
+#else /* CONFIG_PPC64 */
+
+static inline void allocate_pacas(void) { };
+static inline void free_unused_pacas(void) { };
+
+#endif /* CONFIG_PPC64 */
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_PACA_H */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 9258074..b24b700 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -219,7 +219,8 @@ generic_secondary_common_init:
 	 * physical cpu id in r24, we need to search the pacas to find
 	 * which logical id maps to our physical one.
 	 */
-	LOAD_REG_ADDR(r13, paca)	/* Get base vaddr of paca array	 */
+	LOAD_REG_ADDR(r13, paca)	/* Load paca pointer		 */
+	ld	r13,0(r13)		/* Get base vaddr of paca array	 */
 	li	r5,0			/* logical cpu id                */
 1:	lhz	r6,PACAHWCPUID(r13)	/* Load HW procid from paca      */
 	cmpw	r6,r24			/* Compare to our id             */
@@ -536,7 +537,8 @@ _GLOBAL(pmac_secondary_start)
 	mtmsrd	r3			/* RI on */
 
 	/* Set up a paca value for this processor. */
-	LOAD_REG_ADDR(r4,paca)		/* Get base vaddr of paca array	*/
+	LOAD_REG_ADDR(r4,paca)		/* Load paca pointer		*/
+	ld	r4,0(r4)		/* Get base vaddr of paca array	*/
 	mulli	r13,r24,PACA_SIZE	/* Calculate vaddr of right paca */
 	add	r13,r13,r4		/* for this processor.		*/
 	mtspr	SPRN_SPRG_PACA,r13	/* Save vaddr of paca in an SPRG*/
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index d16b1ea..0c40c6f 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -9,11 +9,15 @@
 
 #include <linux/threads.h>
 #include <linux/module.h>
+#include <linux/lmb.h>
 
+#include <asm/firmware.h>
 #include <asm/lppaca.h>
 #include <asm/paca.h>
 #include <asm/sections.h>
 #include <asm/pgtable.h>
+#include <asm/iseries/lpar_map.h>
+#include <asm/iseries/hv_types.h>
 
 /* This symbol is provided by the linker - let it fill in the paca
  * field correctly */
@@ -70,37 +74,82 @@ struct slb_shadow slb_shadow[] __cacheline_aligned = {
  * processors.  The processor VPD array needs one entry per physical
  * processor (not thread).
  */
-struct paca_struct paca[NR_CPUS];
+struct paca_struct *paca;
 EXPORT_SYMBOL(paca);
 
-void __init initialise_pacas(void)
-{
-	int cpu;
+struct paca_struct boot_paca;
 
-	/* The TOC register (GPR2) points 32kB into the TOC, so that 64kB
-	 * of the TOC can be addressed using a single machine instruction.
-	 */
+void __init initialise_paca(struct paca_struct *new_paca, int cpu)
+{
+       /* The TOC register (GPR2) points 32kB into the TOC, so that 64kB
+	* of the TOC can be addressed using a single machine instruction.
+	*/
 	unsigned long kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL;
 
-	/* Can't use for_each_*_cpu, as they aren't functional yet */
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		struct paca_struct *new_paca = &paca[cpu];
-
 #ifdef CONFIG_PPC_BOOK3S
-		new_paca->lppaca_ptr = &lppaca[cpu];
+	new_paca->lppaca_ptr = &lppaca[cpu];
 #else
-		new_paca->kernel_pgd = swapper_pg_dir;
+	new_paca->kernel_pgd = swapper_pg_dir;
 #endif
-		new_paca->lock_token = 0x8000;
-		new_paca->paca_index = cpu;
-		new_paca->kernel_toc = kernel_toc;
-		new_paca->kernelbase = (unsigned long) _stext;
-		new_paca->kernel_msr = MSR_KERNEL;
-		new_paca->hw_cpu_id = 0xffff;
-		new_paca->__current = &init_task;
+	new_paca->lock_token = 0x8000;
+	new_paca->paca_index = cpu;
+	new_paca->kernel_toc = kernel_toc;
+	new_paca->kernelbase = (unsigned long) _stext;
+	new_paca->kernel_msr = MSR_KERNEL;
+	new_paca->hw_cpu_id = 0xffff;
+	new_paca->__current = &init_task;
 #ifdef CONFIG_PPC_STD_MMU_64
-		new_paca->slb_shadow_ptr = &slb_shadow[cpu];
+	new_paca->slb_shadow_ptr = &slb_shadow[cpu];
 #endif /* CONFIG_PPC_STD_MMU_64 */
+}
+
+static int __initdata paca_size;
+
+void __init allocate_pacas(void)
+{
+	int nr_cpus, cpu, limit;
+
+	/*
+	 * We can't take SLB misses on the paca, and we want to access them
+	 * in real mode, so allocate them within the RMA and also within
+	 * the first segment. On iSeries they must be within the area mapped
+	 * by the HV, which is HvPagesToMap * HVPAGESIZE bytes.
+	 */
+	limit = min(0x10000000ULL, lmb.rmo_size);
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		limit = min(limit, HvPagesToMap * HVPAGESIZE);
+
+	nr_cpus = NR_CPUS;
+	/* On iSeries we know we can never have more than 64 cpus */
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		nr_cpus = min(64, nr_cpus);
+
+	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpus);
+
+	paca = __va(lmb_alloc_base(paca_size, PAGE_SIZE, limit));
+	memset(paca, 0, paca_size);
+
+	printk(KERN_DEBUG "Allocated %u bytes for %d pacas at %p\n",
+		paca_size, nr_cpus, paca);
+
+	/* Can't use for_each_*_cpu, as they aren't functional yet */
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		initialise_paca(&paca[cpu], cpu);
+}
+
+void __init free_unused_pacas(void)
+{
+	int new_size;
+
+	new_size = PAGE_ALIGN(sizeof(struct paca_struct) * num_possible_cpus());
+
+	if (new_size >= paca_size)
+		return;
+
+	lmb_free(__pa(paca) + new_size, paca_size - new_size);
+
+	printk(KERN_DEBUG "Freed %u bytes for unused pacas\n",
+		paca_size - new_size);
 
-	}
+	paca_size = new_size;
 }
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4ec3008..6e0cab0 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -43,6 +43,7 @@
 #include <asm/smp.h>
 #include <asm/system.h>
 #include <asm/mmu.h>
+#include <asm/paca.h>
 #include <asm/pgtable.h>
 #include <asm/pci.h>
 #include <asm/iommu.h>
@@ -1224,6 +1225,8 @@ void __init early_init_devtree(void *params)
 	 * FIXME .. and the initrd too? */
 	move_device_tree();
 
+	allocate_pacas();
+
 	DBG("Scanning CPUs ...\n");
 
 	/* Retreive CPU related informations from the flat tree
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 03dd6a2..5df0f6a 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -493,6 +493,8 @@ void __init smp_setup_cpu_maps(void)
 	 * here will have to be reworked
 	 */
 	cpu_init_thread_core_maps(nthreads);
+
+	free_unused_pacas();
 }
 #endif /* CONFIG_SMP */
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6568406..6354739 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -144,9 +144,9 @@ early_param("smt-enabled", early_smt_enabled);
 #endif /* CONFIG_SMP */
 
 /* Put the paca pointer into r13 and SPRG_PACA */
-void __init setup_paca(int cpu)
+static void __init setup_paca(struct paca_struct *new_paca)
 {
-	local_paca = &paca[cpu];
+	local_paca = new_paca;
 	mtspr(SPRN_SPRG_PACA, local_paca);
 #ifdef CONFIG_PPC_BOOK3E
 	mtspr(SPRN_SPRG_TLB_EXFRAME, local_paca->extlb);
@@ -176,14 +176,12 @@ void __init early_setup(unsigned long dt_ptr)
 {
 	/* -------- printk is _NOT_ safe to use here ! ------- */
 
-	/* Fill in any unititialised pacas */
-	initialise_pacas();
-
 	/* Identify CPU type */
 	identify_cpu(0, mfspr(SPRN_PVR));
 
 	/* Assume we're on cpu 0 for now. Don't write to the paca yet! */
-	setup_paca(0);
+	initialise_paca(&boot_paca, 0);
+	setup_paca(&boot_paca);
 
 	/* Initialize lockdep early or else spinlocks will blow */
 	lockdep_init();
@@ -203,7 +201,7 @@ void __init early_setup(unsigned long dt_ptr)
 	early_init_devtree(__va(dt_ptr));
 
 	/* Now we know the logical id of our boot cpu, setup the paca. */
-	setup_paca(boot_cpuid);
+	setup_paca(&paca[boot_cpuid]);
 
 	/* Fix up paca fields required for the boot cpu */
 	get_paca()->cpu_start = 1;
diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index 5369653..fba5bf9 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -43,17 +43,14 @@ system_reset_iSeries:
 	LOAD_REG_ADDR(r23, alpaca)
 	li	r0,ALPACA_SIZE
 	sub	r23,r13,r23
-	divdu	r23,r23,r0		/* r23 has cpu number */
-	LOAD_REG_ADDR(r13, paca)
-	mulli	r0,r23,PACA_SIZE
-	add	r13,r13,r0
-	mtspr	SPRN_SPRG_PACA,r13	/* Save it away for the future */
-	mfmsr	r24
-	ori	r24,r24,MSR_RI
-	mtmsrd	r24			/* RI on */
-	mr	r24,r23
+	divdu	r24,r23,r0		/* r24 has cpu number */
 	cmpwi	0,r24,0			/* Are we processor 0? */
 	bne	1f
+	LOAD_REG_ADDR(r13, boot_paca)
+	mtspr	SPRN_SPRG_PACA,r13	/* Save it away for the future */
+	mfmsr	r23
+	ori	r23,r23,MSR_RI
+	mtmsrd	r23			/* RI on */
 	b	.__start_initialization_iSeries	/* Start up the first processor */
 1:	mfspr	r4,SPRN_CTRLF
 	li	r5,CTRL_RUNLATCH	/* Turn off the run light */
@@ -86,6 +83,16 @@ system_reset_iSeries:
 #endif
 
 2:
+	/* Load our paca now that it's been allocated */
+	LOAD_REG_ADDR(r13, paca)
+	ld	r13,0(r13)
+	mulli	r0,r24,PACA_SIZE
+	add	r13,r13,r0
+	mtspr	SPRN_SPRG_PACA,r13	/* Save it away for the future */
+	mfmsr	r23
+	ori	r23,r23,MSR_RI
+	mtmsrd	r23			/* RI on */
+
 	HMT_LOW
 #ifdef CONFIG_SMP
 	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor
-- 
1.6.3.3
