Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkCFd0HWHzDshs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:32:37 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkCFb6PCGz9ryQ
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:32:35 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/41] powerpc/dart: Use a cachable DART
Date: Tue,  5 Jul 2016 15:03:47 +1000
Message-Id: <1467695057-12431-12-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of punching a hole in the linear mapping, just use normal
cachable memory, and apply the flush sequence documented in the
CPC625 (aka U3) user manual.

This allows us to remove quite a bit of code related to the early
allocation of the DART and the hole in the linear mapping. We can
also get rid of the copy of the DART for suspend/resume as the
original memory can just be saved/restored now, as long as we
properly sync the caches.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/iommu.h        |   1 -
 arch/powerpc/mm/hash_utils_64.c         |  32 ------
 arch/powerpc/platforms/maple/setup.c    |   7 --
 arch/powerpc/platforms/powermac/setup.c |   8 --
 arch/powerpc/sysdev/dart_iommu.c        | 180 +++++++++++++++-----------------
 5 files changed, 84 insertions(+), 144 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 7b87bab..f49a72a 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -273,7 +273,6 @@ extern void iommu_init_early_pSeries(void);
 extern void iommu_init_early_dart(struct pci_controller_ops *controller_ops);
 extern void iommu_init_early_pasemi(void);
 
-extern void alloc_dart_table(void);
 #if defined(CONFIG_PPC64) && defined(CONFIG_PM)
 static inline void iommu_save(void)
 {
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index b2740c6..2bea864 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -87,10 +87,6 @@
  *
  */
 
-#ifdef CONFIG_U3_DART
-extern unsigned long dart_tablebase;
-#endif /* CONFIG_U3_DART */
-
 static unsigned long _SDR1;
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 EXPORT_SYMBOL_GPL(mmu_psize_defs);
@@ -828,34 +824,6 @@ static void __init htab_initialize(void)
 		DBG("creating mapping for region: %lx..%lx (prot: %lx)\n",
 		    base, size, prot);
 
-#ifdef CONFIG_U3_DART
-		/* Do not map the DART space. Fortunately, it will be aligned
-		 * in such a way that it will not cross two memblock regions and
-		 * will fit within a single 16Mb page.
-		 * The DART space is assumed to be a full 16Mb region even if
-		 * we only use 2Mb of that space. We will use more of it later
-		 * for AGP GART. We have to use a full 16Mb large page.
-		 */
-		DBG("DART base: %lx\n", dart_tablebase);
-
-		if (dart_tablebase != 0 && dart_tablebase >= base
-		    && dart_tablebase < (base + size)) {
-			unsigned long dart_table_end = dart_tablebase + 16 * MB;
-			if (base != dart_tablebase)
-				BUG_ON(htab_bolt_mapping(base, dart_tablebase,
-							__pa(base), prot,
-							mmu_linear_psize,
-							mmu_kernel_ssize));
-			if ((base + size) > dart_table_end)
-				BUG_ON(htab_bolt_mapping(dart_tablebase+16*MB,
-							base + size,
-							__pa(dart_table_end),
-							 prot,
-							 mmu_linear_psize,
-							 mmu_kernel_ssize));
-			continue;
-		}
-#endif /* CONFIG_U3_DART */
 		BUG_ON(htab_bolt_mapping(base, base + size, __pa(base),
 				prot, mmu_linear_psize, mmu_kernel_ssize));
 	}
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index a837188..3cd625d 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -303,13 +303,6 @@ static int __init maple_probe(void)
 	if (!of_flat_dt_is_compatible(root, "Momentum,Maple") &&
 	    !of_flat_dt_is_compatible(root, "Momentum,Apache"))
 		return 0;
-	/*
-	 * On U3, the DART (iommu) must be allocated now since it
-	 * has an impact on htab_initialize (due to the large page it
-	 * occupies having to be broken up so the DART itself is not
-	 * part of the cacheable linar mapping
-	 */
-	alloc_dart_table();
 
 	hpte_init_native();
 	pm_power_off = maple_power_off;
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 8dd78f4..19de197 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -605,14 +605,6 @@ static int __init pmac_probe(void)
 		return 0;
 
 #ifdef CONFIG_PPC64
-	/*
-	 * On U3, the DART (iommu) must be allocated now since it
-	 * has an impact on htab_initialize (due to the large page it
-	 * occupies having to be broken up so the DART itself is not
-	 * part of the cacheable linar mapping
-	 */
-	alloc_dart_table();
-
 	hpte_init_native();
 #endif
 
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index b734863..53f862e 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -48,16 +48,10 @@
 
 #include "dart.h"
 
-/* Physical base address and size of the DART table */
-unsigned long dart_tablebase; /* exported to htab_initialize */
+/* DART table address and size */
+static u32 *dart_tablebase;
 static unsigned long dart_tablesize;
 
-/* Virtual base address of the DART table */
-static u32 *dart_vbase;
-#ifdef CONFIG_PM
-static u32 *dart_copy;
-#endif
-
 /* Mapped base address for the dart */
 static unsigned int __iomem *dart;
 
@@ -151,6 +145,32 @@ wait_more:
 	spin_unlock_irqrestore(&invalidate_lock, flags);
 }
 
+static void dart_cache_sync(unsigned int *base, unsigned int count)
+{
+	/* We add 1 to the number of entries to flush, following a
+	 * comment in Darwin indicating that the memory controller
+	 * can prefetch unmapped memory under some circumstances
+	 */
+	unsigned long start = (unsigned long)base;
+	unsigned long end = start + (count + 1) * sizeof(unsigned int);
+	unsigned int tmp;
+
+	/* Perform a standard cache flush */
+	flush_inval_dcache_range(start, end);
+
+	/* Perform the sequence described in the CPC925 manual to
+	 * ensure all the data gets to a point the cache incoherent
+	 * DART hardware will see
+	 */
+	asm volatile(" sync;"
+		     " isync;"
+		     " dcbf 0,%1;"
+		     " sync;"
+		     " isync;"
+		     " lwz %0,0(%1);"
+		     " isync" : "=r" (tmp) : "r" (end) : "memory");
+}
+
 static void dart_flush(struct iommu_table *tbl)
 {
 	mb();
@@ -165,13 +185,13 @@ static int dart_build(struct iommu_table *tbl, long index,
 		       enum dma_data_direction direction,
 		       struct dma_attrs *attrs)
 {
-	unsigned int *dp;
+	unsigned int *dp, *orig_dp;
 	unsigned int rpn;
 	long l;
 
 	DBG("dart: build at: %lx, %lx, addr: %x\n", index, npages, uaddr);
 
-	dp = ((unsigned int*)tbl->it_base) + index;
+	orig_dp = dp = ((unsigned int*)tbl->it_base) + index;
 
 	/* On U3, all memory is contiguous, so we can move this
 	 * out of the loop.
@@ -184,11 +204,7 @@ static int dart_build(struct iommu_table *tbl, long index,
 
 		uaddr += DART_PAGE_SIZE;
 	}
-
-	/* make sure all updates have reached memory */
-	mb();
-	in_be32((unsigned __iomem *)dp);
-	mb();
+	dart_cache_sync(orig_dp, npages);
 
 	if (dart_is_u4) {
 		rpn = index;
@@ -203,7 +219,8 @@ static int dart_build(struct iommu_table *tbl, long index,
 
 static void dart_free(struct iommu_table *tbl, long index, long npages)
 {
-	unsigned int *dp;
+	unsigned int *dp, *orig_dp;
+	long orig_npages = npages;
 
 	/* We don't worry about flushing the TLB cache. The only drawback of
 	 * not doing it is that we won't catch buggy device drivers doing
@@ -212,34 +229,29 @@ static void dart_free(struct iommu_table *tbl, long index, long npages)
 
 	DBG("dart: free at: %lx, %lx\n", index, npages);
 
-	dp  = ((unsigned int *)tbl->it_base) + index;
+	orig_dp = dp  = ((unsigned int *)tbl->it_base) + index;
 
 	while (npages--)
 		*(dp++) = dart_emptyval;
-}
 
+	dart_cache_sync(orig_dp, orig_npages);
+}
 
-static int __init dart_init(struct device_node *dart_node)
+static void allocate_dart(void)
 {
-	unsigned int i;
-	unsigned long tmp, base, size;
-	struct resource r;
+	unsigned long tmp;
 
-	if (dart_tablebase == 0 || dart_tablesize == 0) {
-		printk(KERN_INFO "DART: table not allocated, using "
-		       "direct DMA\n");
-		return -ENODEV;
-	}
-
-	if (of_address_to_resource(dart_node, 0, &r))
-		panic("DART: can't get register base ! ");
+	/* 512 pages (2MB) is max DART tablesize. */
+	dart_tablesize = 1UL << 21;
 
-	/* Make sure nothing from the DART range remains in the CPU cache
-	 * from a previous mapping that existed before the kernel took
-	 * over
+	/* 16MB (1 << 24) alignment. We allocate a full 16Mb chuck since we
+	 * will blow up an entire large page anyway in the kernel mapping
 	 */
-	flush_dcache_phys_range(dart_tablebase,
-				dart_tablebase + dart_tablesize);
+	dart_tablebase = __va(memblock_alloc_base(1UL<<24,
+						  1UL<<24, 0x80000000L));
+
+	/* There is no point scanning the DART space for leaks*/
+	kmemleak_no_scan((void *)dart_tablebase);
 
 	/* Allocate a spare page to map all invalid DART pages. We need to do
 	 * that to work around what looks like a problem with the HT bridge
@@ -249,20 +261,50 @@ static int __init dart_init(struct device_node *dart_node)
 	dart_emptyval = DARTMAP_VALID | ((tmp >> DART_PAGE_SHIFT) &
 					 DARTMAP_RPNMASK);
 
+	printk(KERN_INFO "DART table allocated at: %p\n", dart_tablebase);
+}
+
+static int __init dart_init(struct device_node *dart_node)
+{
+	unsigned int i;
+	unsigned long base, size;
+	struct resource r;
+
+	/* IOMMU disabled by the user ? bail out */
+	if (iommu_is_off)
+		return 0;
+
+	/* Only use the DART if the machine has more than 1GB of RAM
+	 * or if requested with iommu=on on cmdline.
+	 *
+	 * 1GB of RAM is picked as limit because some default devices
+	 * (i.e. Airport Extreme) have 30 bit address range limits.
+	 */
+
+	if (!iommu_force_on && memblock_end_of_DRAM() <= 0x40000000ull)
+		return 0;
+
+	/* Get DART registers */
+	if (of_address_to_resource(dart_node, 0, &r))
+		panic("DART: can't get register base ! ");
+
 	/* Map in DART registers */
 	dart = ioremap(r.start, resource_size(&r));
 	if (dart == NULL)
 		panic("DART: Cannot map registers!");
 
-	/* Map in DART table */
-	dart_vbase = ioremap(__pa(dart_tablebase), dart_tablesize);
+	/* Allocate the DART and dummy page */
+	allocate_dart();
 
 	/* Fill initial table */
 	for (i = 0; i < dart_tablesize/4; i++)
-		dart_vbase[i] = dart_emptyval;
+		dart_tablebase[i] = dart_emptyval;
+
+	/* Push to memory */
+	dart_cache_sync(dart_tablebase, dart_tablesize / sizeof(u32));
 
 	/* Initialize DART with table base and enable it. */
-	base = dart_tablebase >> DART_PAGE_SHIFT;
+	base = ((unsigned long)dart_tablebase) >> DART_PAGE_SHIFT;
 	size = dart_tablesize >> DART_PAGE_SHIFT;
 	if (dart_is_u4) {
 		size &= DART_SIZE_U4_SIZE_MASK;
@@ -301,7 +343,7 @@ static void iommu_table_dart_setup(void)
 	iommu_table_dart.it_page_shift = IOMMU_PAGE_SHIFT_4K;
 
 	/* Initialize the common IOMMU code */
-	iommu_table_dart.it_base = (unsigned long)dart_vbase;
+	iommu_table_dart.it_base = (unsigned long)dart_tablebase;
 	iommu_table_dart.it_index = 0;
 	iommu_table_dart.it_blocksize = 1;
 	iommu_table_dart.it_ops = &iommu_dart_ops;
@@ -404,75 +446,21 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 }
 
 #ifdef CONFIG_PM
-static void iommu_dart_save(void)
-{
-	memcpy(dart_copy, dart_vbase, 2*1024*1024);
-}
-
 static void iommu_dart_restore(void)
 {
-	memcpy(dart_vbase, dart_copy, 2*1024*1024);
+	dart_cache_sync(dart_tablebase, dart_tablesize / sizeof(u32));
 	dart_tlb_invalidate_all();
 }
 
 static int __init iommu_init_late_dart(void)
 {
-	unsigned long tbasepfn;
-	struct page *p;
-
-	/* if no dart table exists then we won't need to save it
-	 * and the area has also not been reserved */
 	if (!dart_tablebase)
 		return 0;
 
-	tbasepfn = __pa(dart_tablebase) >> PAGE_SHIFT;
-	register_nosave_region_late(tbasepfn,
-				    tbasepfn + ((1<<24) >> PAGE_SHIFT));
-
-	/* For suspend we need to copy the dart contents because
-	 * it is not part of the regular mapping (see above) and
-	 * thus not saved automatically. The memory for this copy
-	 * must be allocated early because we need 2 MB. */
-	p = alloc_pages(GFP_KERNEL, 21 - PAGE_SHIFT);
-	BUG_ON(!p);
-	dart_copy = page_address(p);
-
-	ppc_md.iommu_save = iommu_dart_save;
 	ppc_md.iommu_restore = iommu_dart_restore;
 
 	return 0;
 }
 
 late_initcall(iommu_init_late_dart);
-#endif
-
-void __init alloc_dart_table(void)
-{
-	/* Only reserve DART space if machine has more than 1GB of RAM
-	 * or if requested with iommu=on on cmdline.
-	 *
-	 * 1GB of RAM is picked as limit because some default devices
-	 * (i.e. Airport Extreme) have 30 bit address range limits.
-	 */
-
-	if (iommu_is_off)
-		return;
-
-	if (!iommu_force_on && memblock_end_of_DRAM() <= 0x40000000ull)
-		return;
-
-	/* 512 pages (2MB) is max DART tablesize. */
-	dart_tablesize = 1UL << 21;
-	/* 16MB (1 << 24) alignment. We allocate a full 16Mb chuck since we
-	 * will blow up an entire large page anyway in the kernel mapping
-	 */
-	dart_tablebase = (unsigned long)
-		__va(memblock_alloc_base(1UL<<24, 1UL<<24, 0x80000000L));
-	/*
-	 * The DART space is later unmapped from the kernel linear mapping and
-	 * accessing dart_tablebase during kmemleak scanning will fault.
-	 */
-	kmemleak_no_scan((void *)dart_tablebase);
-
-	printk(KERN_INFO "DART table allocated at: %lx\n", dart_tablebase);
-}
+#endif /* CONFIG_PM */
-- 
2.7.4
