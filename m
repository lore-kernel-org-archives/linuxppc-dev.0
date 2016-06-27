Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRbL26DSzDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:31:26 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 38/38] powerpc: Merge 32-bit and 64-bit setup_arch()
Date: Mon, 27 Jun 2016 21:29:36 +1000
Message-Id: <1467026976-7974-39-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is little enough differences now. Use a few __weak stubs
for functions that may not be around in order to avoid too many
ifdefs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/setup.h   |   4 +
 arch/powerpc/kernel/setup-common.c | 202 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/setup_32.c     |  65 +-----------
 arch/powerpc/kernel/setup_64.c     | 178 ++------------------------------
 4 files changed, 218 insertions(+), 231 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index fa0687e..a98f497 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -19,6 +19,10 @@ extern unsigned long reloc_offset(void);
 extern unsigned long add_reloc_offset(unsigned long);
 extern void reloc_got2(unsigned long);
 
+extern void initialize_cache_info(void);
+extern void irqstack_early_init(void);
+extern void emergency_stack_init(void);
+
 #ifdef CONFIG_PPC32
 #define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
 #else
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index d0256a3..12e3f5e 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -35,6 +35,7 @@
 #include <linux/percpu.h>
 #include <linux/memblock.h>
 #include <linux/of_platform.h>
+#include <linux/hugetlb.h>
 #include <asm/io.h>
 #include <asm/paca.h>
 #include <asm/prom.h>
@@ -61,6 +62,11 @@
 #include <asm/cputhreads.h>
 #include <mm/mmu_decl.h>
 #include <asm/fadump.h>
+#include <asm/udbg.h>
+#include <asm/kvm_ppc.h>
+#include <asm/hugetlb.h>
+#include <asm/livepatch.h>
+#include <asm/mmu_context.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
@@ -757,3 +763,199 @@ void arch_setup_pdev_archdata(struct platform_device *pdev)
 	pdev->dev.dma_mask = &pdev->archdata.dma_mask;
  	set_dma_ops(&pdev->dev, &dma_direct_ops);
 }
+
+static __init void print_system_info(void)
+{
+	pr_info("-----------------------------------------------------\n");
+#ifdef CONFIG_PPC_STD_MMU_64
+	pr_info("ppc64_pft_size    = 0x%llx\n", ppc64_pft_size);
+#endif
+#ifdef CONFIG_PPC_STD_MMU_32
+	pr_info("Hash_size         = 0x%lx\n", Hash_size);
+#endif
+	pr_info("phys_mem_size     = 0x%llx\n",
+		(unsigned long long)memblock_phys_mem_size());
+
+	pr_info("dcache_bsize      = 0x%x\n", dcache_bsize);
+	pr_info("icache_bsize      = 0x%x\n", icache_bsize);
+	if (ucache_bsize != 0)
+		pr_info("ucache_bsize      = 0x%x\n", ucache_bsize);
+
+	pr_info("cpu_features      = 0x%016lx\n", cur_cpu_spec->cpu_features);
+	pr_info("  possible        = 0x%016lx\n",
+		(unsigned long)CPU_FTRS_POSSIBLE);
+	pr_info("  always          = 0x%016lx\n",
+		(unsigned long)CPU_FTRS_ALWAYS);
+	pr_info("cpu_user_features = 0x%08x 0x%08x\n",
+		cur_cpu_spec->cpu_user_features,
+		cur_cpu_spec->cpu_user_features2);
+	pr_info("mmu_features      = 0x%08x\n", cur_cpu_spec->mmu_features);
+#ifdef CONFIG_PPC64
+	pr_info("firmware_features = 0x%016lx\n", powerpc_firmware_features);
+#endif
+
+#ifdef CONFIG_PPC_STD_MMU_64
+	if (htab_address)
+		pr_info("htab_address      = 0x%p\n", htab_address);
+	if (htab_hash_mask)
+		pr_info("htab_hash_mask    = 0x%lx\n", htab_hash_mask);
+#endif
+#ifdef CONFIG_PPC_STD_MMU_32
+	if (Hash)
+		pr_info("Hash              = 0x%p\n", Hash);
+	if (Hash_mask)
+		pr_info("Hash_mask         = 0x%lx\n", Hash_mask);
+#endif
+
+	if (PHYSICAL_START > 0)
+		pr_info("physical_start    = 0x%llx\n",
+		       (unsigned long long)PHYSICAL_START);
+	pr_info("-----------------------------------------------------\n");
+}
+
+/*
+ * Here are a bunch of weak stubs for initialization functions
+ * that may or may not be present in the current configuration
+ */
+void __init __weak setup_power_save(void)
+{
+}
+
+void __init __weak check_smt_enabled(void)
+{
+}
+
+void __init __weak setup_tlb_core_data(void)
+{
+}
+
+void __init __weak exc_lvl_early_init(void)
+{
+}
+
+void __init __weak emergency_stack_init(void)
+{
+}
+
+void __init __weak rtas_initialize(void)
+{
+}
+
+void __weak smp_release_cpus(void)
+{
+}
+
+/*
+ * Called into from start_kernel this initializes memblock, which is used
+ * to manage page allocation until mem_init is called.
+ */
+void __init setup_arch(char **cmdline_p)
+{
+	*cmdline_p = boot_command_line;
+
+	/* Set a half-reasonable default so udelay does something sensible */
+	loops_per_jiffy = 500000000 / HZ;
+
+	/* Unflatten the device-tree passed by prom_init or kexec */
+	unflatten_device_tree();
+
+	/* Initialize cache line/block info from device-tree (on ppc64) or
+	 * just cputable (on ppc32).
+	 */
+	initialize_cache_info();
+
+	/* Initialize RTAS if available */
+	rtas_initialize();
+
+	/* Check if we have an initrd provided via the device-tree */
+	check_for_initrd();
+
+	/* Probe the machine type, establish ppc_md */
+	probe_machine();
+
+	/* Setup panic notifier if requested by the platform */
+	setup_panic();
+
+	/*
+	 * Configure ppc_md.power_save (ppc32 only, 64-bit machines do
+	 * it from their respective probe() function
+	 */
+	setup_power_save();
+
+	/* Discover standard serial ports */
+	find_legacy_serial_ports();
+
+	/* Register early console with the printk subsystem */
+	register_early_udbg_console();
+
+	/* Setup the various CPU maps based on the device-tree */
+	smp_setup_cpu_maps();
+
+	/* Initialize xmon */
+	xmon_setup();
+
+	/* Check the SMT related command line arguments (ppc64) */
+	check_smt_enabled();
+
+	/* On BookE, setup per-core TLB data structures */
+	setup_tlb_core_data();
+
+	/* Release secondary cpus out of their spinloops at 0x60 now that
+	 * we can map physical -> logical CPU ids
+	 *
+	 * Freescale Book3e parts spin in a loop provided by firmware,
+	 * so smp_release_cpus() does nothing for them
+	 */
+	smp_release_cpus();
+
+	/* Print various info about the machine that gave been gathered
+	 * so far
+	 */
+	print_system_info();
+
+	/* Reserve large chunks of memory for use by CMA for KVM */
+	kvm_cma_reserve();
+
+	/*
+	 * Reserve any gigantic pages requested on the command line.
+	 * memblock needs to have been initialized by the time this is
+	 * called since this will reserve memory.
+	 */
+	reserve_hugetlb_gpages();
+
+	klp_init_thread_info(&init_thread_info);
+
+	init_mm.start_code = (unsigned long)_stext;
+	init_mm.end_code = (unsigned long) _etext;
+	init_mm.end_data = (unsigned long) _edata;
+	init_mm.brk = klimit;
+#ifdef CONFIG_PPC_64K_PAGES
+	init_mm.context.pte_frag = NULL;
+#endif
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+	mm_iommu_init(&init_mm.context);
+#endif
+	irqstack_early_init();
+	exc_lvl_early_init();
+	emergency_stack_init();
+
+	initmem_init();
+
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+	if (ppc_md.setup_arch)
+		ppc_md.setup_arch();
+
+	paging_init();
+
+	/* Initialize the MMU context management stuff */
+	mmu_context_init();
+
+#ifdef CONFIG_PPC64
+	/* Interrupt code needs to be 64K-aligned */
+	if ((unsigned long)_stext & 0xffff)
+		panic("Kernelbase not 64K-aligned (0x%lx)!\n",
+		      (unsigned long)_stext);
+#endif
+}
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 6247a3a..00f5775 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -36,7 +36,6 @@
 #include <asm/time.h>
 #include <asm/serial.h>
 #include <asm/udbg.h>
-#include <asm/mmu_context.h>
 #include <asm/code-patching.h>
 
 #define DBG(fmt...)
@@ -191,7 +190,7 @@ int __init ppc_init(void)
 
 arch_initcall(ppc_init);
 
-static void __init irqstack_early_init(void)
+void __init irqstack_early_init(void)
 {
 	unsigned int i;
 
@@ -206,7 +205,7 @@ static void __init irqstack_early_init(void)
 }
 
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
-static void __init exc_lvl_early_init(void)
+void __init exc_lvl_early_init(void)
 {
 	unsigned int i, hw_cpu;
 
@@ -229,11 +228,9 @@ static void __init exc_lvl_early_init(void)
 #endif
 	}
 }
-#else
-#define exc_lvl_early_init()
 #endif
 
-static void setup_power_save(void)
+void __init setup_power_save(void)
 {
 #ifdef CONFIG_6xx
 	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
@@ -248,7 +245,7 @@ static void setup_power_save(void)
 #endif
 }
 
-static __init void initialize_cache_info(void)
+__init void initialize_cache_info(void)
 {
 	/*
 	 * Set cache line size based on type of cpu as a default.
@@ -261,57 +258,3 @@ static __init void initialize_cache_info(void)
 	if (cpu_has_feature(CPU_FTR_UNIFIED_ID_CACHE))
 		ucache_bsize = icache_bsize = dcache_bsize;
 }
-
-
-/* Warning, IO base is not yet inited */
-void __init setup_arch(char **cmdline_p)
-{
-	*cmdline_p = boot_command_line;
-
-	/* so udelay does something sensible, assume <= 1000 bogomips */
-	loops_per_jiffy = 500000000 / HZ;
-
-	unflatten_device_tree();
-	initialize_cache_info();
-	check_for_initrd();
-
-	probe_machine();
-
-	setup_panic();
-
-	setup_power_save();
-
-	find_legacy_serial_ports();
-
-	/* Register early console */
-	register_early_udbg_console();
-
-	smp_setup_cpu_maps();
-
-	xmon_setup();
-
-	init_mm.start_code = (unsigned long)_stext;
-	init_mm.end_code = (unsigned long) _etext;
-	init_mm.end_data = (unsigned long) _edata;
-	init_mm.brk = klimit;
-
-	exc_lvl_early_init();
-
-	irqstack_early_init();
-
-	initmem_init();
-	if ( ppc_md.progress ) ppc_md.progress("setup_arch: initmem", 0x3eab);
-
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
-	if (ppc_md.setup_arch)
-		ppc_md.setup_arch();
-	if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);
-
-	paging_init();
-
-	/* Initialize the MMU context management stuff */
-	mmu_context_init();
-}
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 9ca2df9..132f32e 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -35,7 +35,6 @@
 #include <linux/pci.h>
 #include <linux/lockdep.h>
 #include <linux/memblock.h>
-#include <linux/hugetlb.h>
 #include <linux/memory.h>
 #include <linux/nmi.h>
 
@@ -64,12 +63,10 @@
 #include <asm/xmon.h>
 #include <asm/udbg.h>
 #include <asm/kexec.h>
-#include <asm/mmu_context.h>
 #include <asm/code-patching.h>
-#include <asm/kvm_ppc.h>
-#include <asm/hugetlb.h>
-#include <asm/livepatch.h>
 #include <asm/opal.h>
+#include <asm/cputhreads.h>
+#include <asm/livepatch.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -100,7 +97,7 @@ int icache_bsize;
 int ucache_bsize;
 
 #if defined(CONFIG_PPC_BOOK3E) && defined(CONFIG_SMP)
-static void setup_tlb_core_data(void)
+void __init setup_tlb_core_data(void)
 {
 	int cpu;
 
@@ -133,10 +130,6 @@ static void setup_tlb_core_data(void)
 		}
 	}
 }
-#else
-static void setup_tlb_core_data(void)
-{
-}
 #endif
 
 #ifdef CONFIG_SMP
@@ -144,7 +137,7 @@ static void setup_tlb_core_data(void)
 static char *smt_enabled_cmdline;
 
 /* Look for ibm,smt-enabled OF option */
-static void check_smt_enabled(void)
+void __init check_smt_enabled(void)
 {
 	struct device_node *dn;
 	const char *smt_option;
@@ -193,8 +186,6 @@ static int __init early_smt_enabled(char *p)
 }
 early_param("smt-enabled", early_smt_enabled);
 
-#else
-#define check_smt_enabled()
 #endif /* CONFIG_SMP */
 
 /** Fix up paca fields required for the boot cpu */
@@ -419,7 +410,7 @@ void smp_release_cpus(void)
  * cache informations about the CPU that will be used by cache flush
  * routines and/or provided to userland
  */
-static void __init initialize_cache_info(void)
+void __init initialize_cache_info(void)
 {
 	struct device_node *np;
 	unsigned long num_cpus = 0;
@@ -491,38 +482,6 @@ static void __init initialize_cache_info(void)
 	DBG(" <- initialize_cache_info()\n");
 }
 
-static __init void print_system_info(void)
-{
-	pr_info("-----------------------------------------------------\n");
-	pr_info("ppc64_pft_size    = 0x%llx\n", ppc64_pft_size);
-	pr_info("phys_mem_size     = 0x%llx\n", memblock_phys_mem_size());
-
-	if (ppc64_caches.dline_size != 0x80)
-		pr_info("dcache_line_size  = 0x%x\n", ppc64_caches.dline_size);
-	if (ppc64_caches.iline_size != 0x80)
-		pr_info("icache_line_size  = 0x%x\n", ppc64_caches.iline_size);
-
-	pr_info("cpu_features      = 0x%016lx\n", cur_cpu_spec->cpu_features);
-	pr_info("  possible        = 0x%016lx\n", CPU_FTRS_POSSIBLE);
-	pr_info("  always          = 0x%016lx\n", CPU_FTRS_ALWAYS);
-	pr_info("cpu_user_features = 0x%08x 0x%08x\n", cur_cpu_spec->cpu_user_features,
-		cur_cpu_spec->cpu_user_features2);
-	pr_info("mmu_features      = 0x%08x\n", cur_cpu_spec->mmu_features);
-	pr_info("firmware_features = 0x%016lx\n", powerpc_firmware_features);
-
-#ifdef CONFIG_PPC_STD_MMU_64
-	if (htab_address)
-		pr_info("htab_address      = 0x%p\n", htab_address);
-
-	pr_info("htab_hash_mask    = 0x%lx\n", htab_hash_mask);
-#endif
-
-	if (PHYSICAL_START > 0)
-		pr_info("physical_start    = 0x%llx\n",
-		       (unsigned long long)PHYSICAL_START);
-	pr_info("-----------------------------------------------------\n");
-}
-
 /* This returns the limit below which memory accesses to the linear
  * mapping are guarnateed not to cause a TLB or SLB miss. This is
  * used to allocate interrupt or emergency stacks for which our
@@ -544,7 +503,7 @@ static __init u64 safe_stack_limit(void)
 #endif
 }
 
-static void __init irqstack_early_init(void)
+void __init irqstack_early_init(void)
 {
 	u64 limit = safe_stack_limit();
 	unsigned int i;
@@ -564,7 +523,7 @@ static void __init irqstack_early_init(void)
 }
 
 #ifdef CONFIG_PPC_BOOK3E
-static void __init exc_lvl_early_init(void)
+void __init exc_lvl_early_init(void)
 {
 	unsigned int i;
 	unsigned long sp;
@@ -586,8 +545,6 @@ static void __init exc_lvl_early_init(void)
 	if (cpu_has_feature(CPU_FTR_DEBUG_LVL_EXC))
 		patch_exception(0x040, exc_debug_debug_book3e);
 }
-#else
-#define exc_lvl_early_init()
 #endif
 
 /*
@@ -595,7 +552,7 @@ static void __init exc_lvl_early_init(void)
  * early in SMP boots before relocation is enabled. Exclusive emergency
  * stack for machine checks.
  */
-static void __init emergency_stack_init(void)
+void __init emergency_stack_init(void)
 {
 	u64 limit;
 	unsigned int i;
@@ -626,125 +583,6 @@ static void __init emergency_stack_init(void)
 	}
 }
 
-/*
- * Called into from start_kernel this initializes memblock, which is used
- * to manage page allocation until mem_init is called.
- */
-void __init setup_arch(char **cmdline_p)
-{
-	*cmdline_p = boot_command_line;
-
-	/*
-	 * Unflatten the device-tree passed by prom_init or kexec
-	 */
-	unflatten_device_tree();
-
-	/*
-	 * Fill the ppc64_caches & systemcfg structures with informations
- 	 * retrieved from the device-tree.
-	 */
-	initialize_cache_info();
-
-#ifdef CONFIG_PPC_RTAS
-	/*
-	 * Initialize RTAS if available
-	 */
-	rtas_initialize();
-#endif /* CONFIG_PPC_RTAS */
-
-	/*
-	 * Check if we have an initrd provided via the device-tree
-	 */
-	check_for_initrd();
-
-	/* Probe the machine type */
-	probe_machine();
-
-	setup_panic();
-
- 	/*
-	 * We can discover serial ports now since the above did setup the
-	 * hash table management for us, thus ioremap works. We do that early
-	 * so that further code can be debugged
-	 */
-	find_legacy_serial_ports();
-
-	/*
-	 * Register early console
-	 */
-	register_early_udbg_console();
-
-	smp_setup_cpu_maps();
-
-	/*
-	 * Initialize xmon
-	 */
-	xmon_setup();
-
-	check_smt_enabled();
-	setup_tlb_core_data();
-
-	/*
-	 * Freescale Book3e parts spin in a loop provided by firmware,
-	 * so smp_release_cpus() does nothing for them
-	 */
-#if defined(CONFIG_SMP)
-	/* Release secondary cpus out of their spinloops at 0x60 now that
-	 * we can map physical -> logical CPU ids
-	 */
-	smp_release_cpus();
-#endif
-
-	/* Print various info about the machine that gave been gathered
-	 * so far
-	 */
-	print_system_info();
-
-	/* Reserve large chunks of memory for use by CMA for KVM */
-	kvm_cma_reserve();
-
-	/*
-	 * Reserve any gigantic pages requested on the command line.
-	 * memblock needs to have been initialized by the time this is
-	 * called since this will reserve memory.
-	 */
-	reserve_hugetlb_gpages();
-
-	klp_init_thread_info(&init_thread_info);
-
-	init_mm.start_code = (unsigned long)_stext;
-	init_mm.end_code = (unsigned long) _etext;
-	init_mm.end_data = (unsigned long) _edata;
-	init_mm.brk = klimit;
-#ifdef CONFIG_PPC_64K_PAGES
-	init_mm.context.pte_frag = NULL;
-#endif
-#ifdef CONFIG_SPAPR_TCE_IOMMU
-	mm_iommu_init(&init_mm.context);
-#endif
-	irqstack_early_init();
-	exc_lvl_early_init();
-	emergency_stack_init();
-
-	initmem_init();
-
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-	if (ppc_md.setup_arch)
-		ppc_md.setup_arch();
-
-	paging_init();
-
-	/* Initialize the MMU context management stuff */
-	mmu_context_init();
-
-	/* Interrupt code needs to be 64K-aligned */
-	if ((unsigned long)_stext & 0xffff)
-		panic("Kernelbase not 64K-aligned (0x%lx)!\n",
-		      (unsigned long)_stext);
-}
-
 #ifdef CONFIG_SMP
 #define PCPU_DYN_SIZE		()
 
-- 
2.7.4
