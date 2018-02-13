Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgmCj4GvdzF1Nw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 02:09:21 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id o1so44875pgn.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 07:09:21 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 14/14] powerpc/64s/radix: allocate kernel page tables
 node-local if possible
Date: Wed, 14 Feb 2018 01:08:24 +1000
Message-Id: <20180213150824.27689-15-npiggin@gmail.com>
In-Reply-To: <20180213150824.27689-1-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Try to allocate kernel page tables for direct mapping and vmemmap
according to the node of the memory they will map. The node is not
available for the linear map in early boot, so use range allocation
to allocate the page tables from the region they map, which is
effectively node-local.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 111 ++++++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 4c5cc69c92c2..66b07718875a 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -48,11 +48,26 @@ static int native_register_process_table(unsigned long base, unsigned long pg_sz
 	return 0;
 }
 
-static __ref void *early_alloc_pgtable(unsigned long size)
+static __ref void *early_alloc_pgtable(unsigned long size, int nid,
+			unsigned long region_start, unsigned long region_end)
 {
+	unsigned long pa = 0;
 	void *pt;
 
-	pt = __va(memblock_alloc_base(size, size, MEMBLOCK_ALLOC_ANYWHERE));
+	if (region_start || region_end) /* has region hint */
+		pa = memblock_alloc_range(size, size, region_start, region_end,
+						MEMBLOCK_NONE);
+	else if (nid != -1) /* has node hint */
+		pa = memblock_alloc_base_nid(size, size,
+						MEMBLOCK_ALLOC_ANYWHERE,
+						nid, MEMBLOCK_NONE);
+
+	if (!pa)
+		pa = memblock_alloc_base(size, size, MEMBLOCK_ALLOC_ANYWHERE);
+
+	BUG_ON(!pa);
+
+	pt = __va(pa);
 	memset(pt, 0, size);
 
 	return pt;
@@ -60,8 +75,11 @@ static __ref void *early_alloc_pgtable(unsigned long size)
 
 static int early_map_kernel_page(unsigned long ea, unsigned long pa,
 			  pgprot_t flags,
-			  unsigned int map_page_size)
+			  unsigned int map_page_size,
+			  int nid,
+			  unsigned long region_start, unsigned long region_end)
 {
+	unsigned long pfn = pa >> PAGE_SHIFT;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
@@ -69,8 +87,8 @@ static int early_map_kernel_page(unsigned long ea, unsigned long pa,
 
 	pgdp = pgd_offset_k(ea);
 	if (pgd_none(*pgdp)) {
-		pudp = early_alloc_pgtable(PUD_TABLE_SIZE);
-		BUG_ON(pudp == NULL);
+		pudp = early_alloc_pgtable(PUD_TABLE_SIZE, nid,
+						region_start, region_end);
 		pgd_populate(&init_mm, pgdp, pudp);
 	}
 	pudp = pud_offset(pgdp, ea);
@@ -79,8 +97,8 @@ static int early_map_kernel_page(unsigned long ea, unsigned long pa,
 		goto set_the_pte;
 	}
 	if (pud_none(*pudp)) {
-		pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
-		BUG_ON(pmdp == NULL);
+		pmdp = early_alloc_pgtable(PMD_TABLE_SIZE, nid,
+						region_start, region_end);
 		pud_populate(&init_mm, pudp, pmdp);
 	}
 	pmdp = pmd_offset(pudp, ea);
@@ -89,23 +107,29 @@ static int early_map_kernel_page(unsigned long ea, unsigned long pa,
 		goto set_the_pte;
 	}
 	if (!pmd_present(*pmdp)) {
-		ptep = early_alloc_pgtable(PAGE_SIZE);
-		BUG_ON(ptep == NULL);
+		ptep = early_alloc_pgtable(PAGE_SIZE, nid,
+						region_start, region_end);
 		pmd_populate_kernel(&init_mm, pmdp, ptep);
 	}
 	ptep = pte_offset_kernel(pmdp, ea);
 
 set_the_pte:
-	set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, flags));
+	set_pte_at(&init_mm, ea, ptep, pfn_pte(pfn, flags));
 	smp_wmb();
 	return 0;
 }
 
-
-int radix__map_kernel_page(unsigned long ea, unsigned long pa,
+/*
+ * nid, region_start, and region_end are hints to try to place the page
+ * table memory in the same node or region.
+ */
+static int __map_kernel_page(unsigned long ea, unsigned long pa,
 			  pgprot_t flags,
-			  unsigned int map_page_size)
+			  unsigned int map_page_size,
+			  int nid,
+			  unsigned long region_start, unsigned long region_end)
 {
+	unsigned long pfn = pa >> PAGE_SHIFT;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
@@ -115,9 +139,15 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 	 */
 	BUILD_BUG_ON(TASK_SIZE_USER64 > RADIX_PGTABLE_RANGE);
 
-	if (!slab_is_available())
-		return early_map_kernel_page(ea, pa, flags, map_page_size);
+	if (unlikely(!slab_is_available()))
+		return early_map_kernel_page(ea, pa, flags, map_page_size,
+						nid, region_start, region_end);
 
+	/*
+	 * Should make page table allocation functions be able to take a
+	 * node, so we can place kernel page tables on the right nodes after
+	 * boot.
+	 */
 	pgdp = pgd_offset_k(ea);
 	pudp = pud_alloc(&init_mm, pgdp, ea);
 	if (!pudp)
@@ -138,11 +168,25 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 		return -ENOMEM;
 
 set_the_pte:
-	set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, flags));
+	set_pte_at(&init_mm, ea, ptep, pfn_pte(pfn, flags));
 	smp_wmb();
 	return 0;
 }
 
+static int __map_kernel_page_nid(unsigned long ea, unsigned long pa,
+			  pgprot_t flags,
+			  unsigned int map_page_size, int nid)
+{
+	return __map_kernel_page(ea, pa, flags, map_page_size, nid, 0, 0);
+}
+
+int radix__map_kernel_page(unsigned long ea, unsigned long pa,
+			  pgprot_t flags,
+			  unsigned int map_page_size)
+{
+	return __map_kernel_page(ea, pa, flags, map_page_size, -1, 0, 0);
+}
+
 #ifdef CONFIG_STRICT_KERNEL_RWX
 void radix__change_memory_range(unsigned long start, unsigned long end,
 				unsigned long clear)
@@ -229,7 +273,8 @@ static inline void __meminit print_mapping(unsigned long start,
 }
 
 static int __meminit create_physical_mapping(unsigned long start,
-					     unsigned long end)
+					     unsigned long end,
+					     int nid)
 {
 	unsigned long vaddr, addr, mapping_size = 0;
 	pgprot_t prot;
@@ -285,7 +330,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 		else
 			prot = PAGE_KERNEL;
 
-		rc = radix__map_kernel_page(vaddr, addr, prot, mapping_size);
+		rc = __map_kernel_page(vaddr, addr, prot, mapping_size, nid, start, end);
 		if (rc)
 			return rc;
 	}
@@ -294,7 +339,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 	return 0;
 }
 
-static void __init radix_init_pgtable(void)
+void __init radix_init_pgtable(void)
 {
 	unsigned long rts_field;
 	struct memblock_region *reg;
@@ -304,9 +349,16 @@ static void __init radix_init_pgtable(void)
 	/*
 	 * Create the linear mapping, using standard page size for now
 	 */
-	for_each_memblock(memory, reg)
+	for_each_memblock(memory, reg) {
+		/*
+		 * The memblock allocator  is up at this point, so the
+		 * page tables will be allocated within the range. No
+		 * need or a node (which we don't have yet).
+		 */
 		WARN_ON(create_physical_mapping(reg->base,
-						reg->base + reg->size));
+						reg->base + reg->size,
+						-1));
+	}
 
 	/* Find out how many PID bits are supported */
 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
@@ -335,7 +387,7 @@ static void __init radix_init_pgtable(void)
 	 * host.
 	 */
 	BUG_ON(PRTB_SIZE_SHIFT > 36);
-	process_tb = early_alloc_pgtable(1UL << PRTB_SIZE_SHIFT);
+	process_tb = early_alloc_pgtable(1UL << PRTB_SIZE_SHIFT, -1, 0, 0);
 	/*
 	 * Fill in the process table.
 	 */
@@ -716,14 +768,17 @@ static int stop_machine_change_mapping(void *data)
 {
 	struct change_mapping_params *params =
 			(struct change_mapping_params *)data;
+	int nid;
 
 	if (!data)
 		return -1;
 
+	nid = pfn_to_nid(params->start >> PAGE_SHIFT);
+
 	spin_unlock(&init_mm.page_table_lock);
 	pte_clear(&init_mm, params->aligned_start, params->pte);
-	create_physical_mapping(params->aligned_start, params->start);
-	create_physical_mapping(params->end, params->aligned_end);
+	create_physical_mapping(params->aligned_start, params->start, nid);
+	create_physical_mapping(params->end, params->aligned_end, nid);
 	spin_lock(&init_mm.page_table_lock);
 	return 0;
 }
@@ -882,7 +937,7 @@ static void remove_pagetable(unsigned long start, unsigned long end)
 
 int __ref radix__create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
-	return create_physical_mapping(start, end);
+	return create_physical_mapping(start, end, nid);
 }
 
 int radix__remove_section_mapping(unsigned long start, unsigned long end)
@@ -899,8 +954,12 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 {
 	/* Create a PTE encoding */
 	unsigned long flags = _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_KERNEL_RW;
+	int nid = early_pfn_to_nid(phys >> PAGE_SHIFT);
+	int ret;
+
+	ret = __map_kernel_page_nid(start, phys, __pgprot(flags), page_size, nid);
+	BUG_ON(ret);
 
-	BUG_ON(radix__map_kernel_page(start, phys, __pgprot(flags), page_size));
 	return 0;
 }
 
-- 
2.16.1
