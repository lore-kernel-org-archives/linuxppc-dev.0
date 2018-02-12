Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgBwP0N49zF0nL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 04:09:09 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id l24so1863669pgc.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 09:09:08 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 12/12] powerpc/64s/radix: allocate kernel page tables
 node-local if possible
Date: Tue, 13 Feb 2018 03:08:22 +1000
Message-Id: <20180212170822.14612-13-npiggin@gmail.com>
In-Reply-To: <20180212170822.14612-1-npiggin@gmail.com>
References: <20180212170822.14612-1-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h  |   2 +-
 arch/powerpc/include/asm/book3s/64/radix.h |   2 +-
 arch/powerpc/include/asm/sparsemem.h       |   2 +-
 arch/powerpc/mm/hash_utils_64.c            |   2 +-
 arch/powerpc/mm/mem.c                      |   4 +-
 arch/powerpc/mm/pgtable-book3s64.c         |   6 +-
 arch/powerpc/mm/pgtable-radix.c            | 178 +++++++++++++++++++----------
 7 files changed, 128 insertions(+), 68 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 0920eff731b3..b1ace9619e94 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -201,7 +201,7 @@ extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
 extern void hash__vmemmap_remove_mapping(unsigned long start,
 				     unsigned long page_size);
 
-int hash__create_section_mapping(unsigned long start, unsigned long end);
+int hash__create_section_mapping(unsigned long start, unsigned long end, int nid);
 int hash__remove_section_mapping(unsigned long start, unsigned long end);
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 19c44e1495ae..4edcc797cf43 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -319,7 +319,7 @@ static inline unsigned long radix__get_tree_size(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int radix__create_section_mapping(unsigned long start, unsigned long end);
+int radix__create_section_mapping(unsigned long start, unsigned long end, int nid);
 int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #endif /* CONFIG_MEMORY_HOTPLUG */
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index a7916ee6dfb6..bc66712bdc3c 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -17,7 +17,7 @@
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-extern int create_section_mapping(unsigned long start, unsigned long end);
+extern int create_section_mapping(unsigned long start, unsigned long end, int nid);
 extern int remove_section_mapping(unsigned long start, unsigned long end);
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 7d07c7e17db6..ceb5494804b2 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -781,7 +781,7 @@ void resize_hpt_for_hotplug(unsigned long new_mem_size)
 	}
 }
 
-int hash__create_section_mapping(unsigned long start, unsigned long end)
+int hash__create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
 	int rc = htab_bolt_mapping(start, end, __pa(start),
 				   pgprot_val(PAGE_KERNEL), mmu_linear_psize,
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 70f7b6426a15..3f75fbb10c87 100644
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
 		pr_warn("Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
 			start, start + size, rc);
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 3b65917785a5..2b7375f05408 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -152,12 +152,12 @@ void mmu_cleanup_all(void)
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
index 573a9a2ee455..716a68baf137 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -46,79 +46,127 @@ static int native_register_process_table(unsigned long base, unsigned long pg_sz
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
+		return early_map_kernel_page(ea, pa, flags, map_page_size,
+						early_pfn_to_nid(pfn));
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
@@ -209,7 +257,8 @@ static inline void __meminit print_mapping(unsigned long start,
 }
 
 static int __meminit create_physical_mapping(unsigned long start,
-					     unsigned long end)
+					     unsigned long end,
+					     int nid)
 {
 	unsigned long vaddr, addr, mapping_size = 0;
 	pgprot_t prot;
@@ -265,7 +314,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 		else
 			prot = PAGE_KERNEL;
 
-		rc = radix__map_kernel_page(vaddr, addr, prot, mapping_size);
+		rc = early_map_kernel_page(vaddr, addr, prot, mapping_size, nid);
 		if (rc)
 			return rc;
 	}
@@ -274,7 +323,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 	return 0;
 }
 
-static void __init radix_init_pgtable(void)
+void __init radix_init_pgtable(void)
 {
 	unsigned long rts_field;
 	struct memblock_region *reg;
@@ -284,9 +333,11 @@ static void __init radix_init_pgtable(void)
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
 
 	/* Find out how many PID bits are supported */
 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
@@ -315,7 +366,7 @@ static void __init radix_init_pgtable(void)
 	 * host.
 	 */
 	BUG_ON(PRTB_SIZE_SHIFT > 36);
-	process_tb = early_alloc_pgtable(1UL << PRTB_SIZE_SHIFT);
+	process_tb = early_alloc_pgtable(1UL << PRTB_SIZE_SHIFT, -1);
 	/*
 	 * Fill in the process table.
 	 */
@@ -790,9 +841,9 @@ static void remove_pagetable(unsigned long start, unsigned long end)
 	radix__flush_tlb_kernel_range(start, end);
 }
 
-int __ref radix__create_section_mapping(unsigned long start, unsigned long end)
+int __ref radix__create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
-	return create_physical_mapping(start, end);
+	return create_physical_mapping(start, end, nid);
 }
 
 int radix__remove_section_mapping(unsigned long start, unsigned long end)
@@ -809,8 +860,17 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
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
2.16.1
