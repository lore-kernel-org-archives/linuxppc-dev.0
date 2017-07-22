Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDqX35HLPzDqyG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 11:18:27 +1000 (AEST)
Received: by mail-pf0-x22c.google.com with SMTP id q85so29461557pfq.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 18:18:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 11/11] powerpc/64s/radix: allocate kernel page tables
 node-local if possible
Date: Sat, 22 Jul 2017 11:17:41 +1000
Message-Id: <20170722011741.13942-12-npiggin@gmail.com>
In-Reply-To: <20170722011741.13942-1-npiggin@gmail.com>
References: <20170722011741.13942-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Try to allocate kernel page tables according to the node of
the memory they will map.
---
 arch/powerpc/include/asm/book3s/64/hash.h  |   2 +-
 arch/powerpc/include/asm/book3s/64/radix.h |   2 +-
 arch/powerpc/include/asm/sparsemem.h       |   2 +-
 arch/powerpc/kernel/setup_64.c             |   3 +
 arch/powerpc/mm/hash_utils_64.c            |   2 +-
 arch/powerpc/mm/mem.c                      |   4 +-
 arch/powerpc/mm/numa.c                     |   9 +-
 arch/powerpc/mm/pgtable-book3s64.c         |   6 +-
 arch/powerpc/mm/pgtable-radix.c            | 177 +++++++++++++++++++----------
 9 files changed, 136 insertions(+), 71 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 0ce513f2926f..99ca49b0a801 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -199,7 +199,7 @@ extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
 extern void hash__vmemmap_remove_mapping(unsigned long start,
 				     unsigned long page_size);
 
-int hash__create_section_mapping(unsigned long start, unsigned long end);
+int hash__create_section_mapping(unsigned long start, unsigned long end, int nid);
 int hash__remove_section_mapping(unsigned long start, unsigned long end);
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 487709ff6875..d9770ce79ebf 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -315,7 +315,7 @@ static inline unsigned long radix__get_tree_size(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int radix__create_section_mapping(unsigned long start, unsigned long end);
+int radix__create_section_mapping(unsigned long start, unsigned long end, int nid);
 int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #endif /* CONFIG_MEMORY_HOTPLUG */
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index c88930c9db7f..5411557d7c1f 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -16,7 +16,7 @@
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-extern int create_section_mapping(unsigned long start, unsigned long end);
+extern int create_section_mapping(unsigned long start, unsigned long end, int nid);
 extern int remove_section_mapping(unsigned long start, unsigned long end);
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 5c89b771ac81..5520fad59cf4 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -269,6 +269,7 @@ static void cpu_ready_for_interrupts(void)
  * device-tree is not accessible via normal means at this point.
  */
 
+void __init early_initmem_init(void);
 void __init early_setup(unsigned long dt_ptr)
 {
 	static __initdata struct paca_struct boot_paca;
@@ -313,6 +314,8 @@ void __init early_setup(unsigned long dt_ptr)
 	apply_feature_fixups();
 	setup_feature_keys();
 
+	early_initmem_init();
+
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu();
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index d3da19cc4867..97bfb356d91d 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -777,7 +777,7 @@ void resize_hpt_for_hotplug(unsigned long new_mem_size)
 	}
 }
 
-int hash__create_section_mapping(unsigned long start, unsigned long end)
+int hash__create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
 	int rc = htab_bolt_mapping(start, end, __pa(start),
 				   pgprot_val(PAGE_KERNEL), mmu_linear_psize,
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 8541f18694a4..0542b5f48123 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -117,7 +117,7 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 #endif
 
-int __weak create_section_mapping(unsigned long start, unsigned long end)
+int __weak create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
 	return -ENODEV;
 }
@@ -136,7 +136,7 @@ int arch_add_memory(int nid, u64 start, u64 size, bool want_memblock)
 	resize_hpt_for_hotplug(memblock_phys_mem_size());
 
 	start = (unsigned long)__va(start);
-	rc = create_section_mapping(start, start + size);
+	rc = create_section_mapping(start, start + size, nid);
 	if (rc) {
 		pr_warning(
 			"Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 55e3fa5fcfb0..4660cf5da6d3 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -892,6 +892,12 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
 }
 
+void __init early_initmem_init(void)
+{
+	if (parse_numa_properties())
+		setup_nonnuma();
+}
+
 void __init initmem_init(void)
 {
 	int nid, cpu;
@@ -899,9 +905,6 @@ void __init initmem_init(void)
 	max_low_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
 	max_pfn = max_low_pfn;
 
-	if (parse_numa_properties())
-		setup_nonnuma();
-
 	memblock_dump_all();
 
 	/*
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 31eed8fa8e99..390e378a0c57 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -130,12 +130,12 @@ void mmu_cleanup_all(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int create_section_mapping(unsigned long start, unsigned long end)
+int create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
 	if (radix_enabled())
-		return radix__create_section_mapping(start, end);
+		return radix__create_section_mapping(start, end, nid);
 
-	return hash__create_section_mapping(start, end);
+	return hash__create_section_mapping(start, end, nid);
 }
 
 int remove_section_mapping(unsigned long start, unsigned long end)
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 897655ed067e..97a3c9c4ea5b 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -34,79 +34,126 @@ static int native_register_process_table(unsigned long base, unsigned long pg_sz
 	return 0;
 }
 
-static __ref void *early_alloc_pgtable(unsigned long size)
+static __ref void *early_alloc_pgtable(unsigned long size, int nid)
 {
+	unsigned long pa = 0;
 	void *pt;
 
-	pt = __va(memblock_alloc_base(size, size, MEMBLOCK_ALLOC_ANYWHERE));
+	if (nid != -1) {
+		pa = memblock_alloc_base_nid(size, size,
+						MEMBLOCK_ALLOC_ANYWHERE,
+						nid, MEMBLOCK_NONE);
+	}
+
+	if (!pa)
+		pa = memblock_alloc_base(size, size, MEMBLOCK_ALLOC_ANYWHERE);
+
+	pt = __va(pa);
 	memset(pt, 0, size);
 
 	return pt;
 }
 
+static int early_map_kernel_page(unsigned long ea, unsigned long pa,
+			  pgprot_t flags,
+			  unsigned int map_page_size,
+			  int nid);
+
 int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 			  pgprot_t flags,
 			  unsigned int map_page_size)
 {
+	unsigned long pfn = pa >> PAGE_SHIFT;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
+
 	/*
 	 * Make sure task size is correct as per the max adddr
 	 */
 	BUILD_BUG_ON(TASK_SIZE_USER64 > RADIX_PGTABLE_RANGE);
-	if (slab_is_available()) {
-		pgdp = pgd_offset_k(ea);
-		pudp = pud_alloc(&init_mm, pgdp, ea);
-		if (!pudp)
-			return -ENOMEM;
-		if (map_page_size == PUD_SIZE) {
-			ptep = (pte_t *)pudp;
-			goto set_the_pte;
-		}
-		pmdp = pmd_alloc(&init_mm, pudp, ea);
-		if (!pmdp)
-			return -ENOMEM;
-		if (map_page_size == PMD_SIZE) {
-			ptep = pmdp_ptep(pmdp);
-			goto set_the_pte;
-		}
-		ptep = pte_alloc_kernel(pmdp, ea);
-		if (!ptep)
-			return -ENOMEM;
-	} else {
-		pgdp = pgd_offset_k(ea);
-		if (pgd_none(*pgdp)) {
-			pudp = early_alloc_pgtable(PUD_TABLE_SIZE);
-			BUG_ON(pudp == NULL);
-			pgd_populate(&init_mm, pgdp, pudp);
-		}
-		pudp = pud_offset(pgdp, ea);
-		if (map_page_size == PUD_SIZE) {
-			ptep = (pte_t *)pudp;
-			goto set_the_pte;
-		}
-		if (pud_none(*pudp)) {
-			pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
-			BUG_ON(pmdp == NULL);
-			pud_populate(&init_mm, pudp, pmdp);
-		}
-		pmdp = pmd_offset(pudp, ea);
-		if (map_page_size == PMD_SIZE) {
-			ptep = pmdp_ptep(pmdp);
-			goto set_the_pte;
-		}
-		if (!pmd_present(*pmdp)) {
-			ptep = early_alloc_pgtable(PAGE_SIZE);
-			BUG_ON(ptep == NULL);
-			pmd_populate_kernel(&init_mm, pmdp, ptep);
-		}
-		ptep = pte_offset_kernel(pmdp, ea);
+	if (unlikely(!slab_is_available()))
+		return early_map_kernel_page(ea, pa, flags, map_page_size, -1);
+
+	/*
+	 * Should make page table allocation functions be able to take a
+	 * node, so we can place kernel page tables on the right nodes after
+	 * boot.
+	 */
+	pgdp = pgd_offset_k(ea);
+	pudp = pud_alloc(&init_mm, pgdp, ea);
+	if (!pudp)
+		return -ENOMEM;
+	if (map_page_size == PUD_SIZE) {
+		ptep = (pte_t *)pudp;
+		goto set_the_pte;
+	}
+	pmdp = pmd_alloc(&init_mm, pudp, ea);
+	if (!pmdp)
+		return -ENOMEM;
+	if (map_page_size == PMD_SIZE) {
+		ptep = pmdp_ptep(pmdp);
+		goto set_the_pte;
 	}
+	ptep = pte_alloc_kernel(pmdp, ea);
+	if (!ptep)
+		return -ENOMEM;
 
 set_the_pte:
-	set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, flags));
+	set_pte_at(&init_mm, ea, ptep, pfn_pte(pfn, flags));
+	smp_wmb();
+	return 0;
+}
+
+static int early_map_kernel_page(unsigned long ea, unsigned long pa,
+			  pgprot_t flags,
+			  unsigned int map_page_size,
+			  int nid)
+{
+	unsigned long pfn = pa >> PAGE_SHIFT;
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	/*
+	 * Make sure task size is correct as per the max adddr
+	 */
+	BUILD_BUG_ON(TASK_SIZE_USER64 > RADIX_PGTABLE_RANGE);
+	if (slab_is_available())
+		return radix__map_kernel_page(ea, pa, flags, map_page_size);
+
+	pgdp = pgd_offset_k(ea);
+	if (pgd_none(*pgdp)) {
+		pudp = early_alloc_pgtable(PUD_TABLE_SIZE, nid);
+		BUG_ON(pudp == NULL);
+		pgd_populate(&init_mm, pgdp, pudp);
+	}
+	pudp = pud_offset(pgdp, ea);
+	if (map_page_size == PUD_SIZE) {
+		ptep = (pte_t *)pudp;
+		goto set_the_pte;
+	}
+	if (pud_none(*pudp)) {
+		pmdp = early_alloc_pgtable(PMD_TABLE_SIZE, nid);
+		BUG_ON(pmdp == NULL);
+		pud_populate(&init_mm, pudp, pmdp);
+	}
+	pmdp = pmd_offset(pudp, ea);
+	if (map_page_size == PMD_SIZE) {
+		ptep = pmdp_ptep(pmdp);
+		goto set_the_pte;
+	}
+	if (!pmd_present(*pmdp)) {
+		ptep = early_alloc_pgtable(PAGE_SIZE, nid);
+		BUG_ON(ptep == NULL);
+		pmd_populate_kernel(&init_mm, pmdp, ptep);
+	}
+	ptep = pte_offset_kernel(pmdp, ea);
+
+set_the_pte:
+	set_pte_at(&init_mm, ea, ptep, pfn_pte(pfn, flags));
 	smp_wmb();
 	return 0;
 }
@@ -165,7 +212,8 @@ static inline void __meminit print_mapping(unsigned long start,
 }
 
 static int __meminit create_physical_mapping(unsigned long start,
-					     unsigned long end)
+					     unsigned long end,
+					     int nid)
 {
 	unsigned long vaddr, addr, mapping_size = 0;
 	pgprot_t prot;
@@ -221,7 +269,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 		else
 			prot = PAGE_KERNEL;
 
-		rc = radix__map_kernel_page(vaddr, addr, prot, mapping_size);
+		rc = early_map_kernel_page(vaddr, addr, prot, mapping_size, nid);
 		if (rc)
 			return rc;
 	}
@@ -230,7 +278,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 	return 0;
 }
 
-static void __init radix_init_pgtable(void)
+void __init radix_init_pgtable(void)
 {
 	unsigned long rts_field;
 	struct memblock_region *reg;
@@ -240,15 +288,17 @@ static void __init radix_init_pgtable(void)
 	/*
 	 * Create the linear mapping, using standard page size for now
 	 */
-	for_each_memblock(memory, reg)
+	for_each_memblock(memory, reg) {
 		WARN_ON(create_physical_mapping(reg->base,
-						reg->base + reg->size));
+						reg->base + reg->size,
+						reg->nid));
+	}
 	/*
 	 * Allocate Partition table and process table for the
 	 * host.
 	 */
 	BUILD_BUG_ON_MSG((PRTB_SIZE_SHIFT > 36), "Process table size too large.");
-	process_tb = early_alloc_pgtable(1UL << PRTB_SIZE_SHIFT);
+	process_tb = early_alloc_pgtable(1UL << PRTB_SIZE_SHIFT, -1);
 	/*
 	 * Fill in the process table.
 	 */
@@ -722,9 +772,9 @@ static void remove_pagetable(unsigned long start, unsigned long end)
 	radix__flush_tlb_kernel_range(start, end);
 }
 
-int __ref radix__create_section_mapping(unsigned long start, unsigned long end)
+int __ref radix__create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
-	return create_physical_mapping(start, end);
+	return create_physical_mapping(start, end, nid);
 }
 
 int radix__remove_section_mapping(unsigned long start, unsigned long end)
@@ -741,8 +791,17 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 {
 	/* Create a PTE encoding */
 	unsigned long flags = _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_KERNEL_RW;
+	int nid = early_pfn_to_nid(phys >> PAGE_SHIFT);
+	int ret;
+
+	if (!slab_is_available())
+		ret = early_map_kernel_page(start, phys, __pgprot(flags),
+								page_size, nid);
+	else
+		ret = radix__map_kernel_page(start, phys, __pgprot(flags),
+								page_size);
+	BUG_ON(ret);
 
-	BUG_ON(radix__map_kernel_page(start, phys, __pgprot(flags), page_size));
 	return 0;
 }
 
-- 
2.11.0
