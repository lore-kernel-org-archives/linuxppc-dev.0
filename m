Return-Path: <bsingharora@gmail.com>
Received: from mail-ot0-x243.google.com (mail-ot0-x243.google.com
 [IPv6:2607:f8b0:4003:c0f::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgW1D735pzF0pX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 16:14:24 +1100 (AEDT)
Received: by mail-ot0-x243.google.com with SMTP id l10so16188595oth.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 21:14:24 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC] powerpc/radix/hotunplug: Atomically replace pte entries
Date: Tue, 13 Feb 2018 16:14:14 +1100
Message-Id: <20180213051414.26985-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current approach uses stop machine for atomicity while removing
a smaller range from a larger mapping. For example, while trying
to hotunplug 256MiB from a 1GiB range, we split the mappings into
the next slower size (2MiB). This is done using stop machine. This
approach atomically replaces the pte entry by

a. Creating an array of smaller mappings
b. Ignoring the holes (the area to be hot-unplugged)
c. Atomically replacing the entry at the pud/pmd level

The code assumes that permissions in a linear mapping don't change
once set. The permissions are copied from the larger PTE to the
smaller PTE's based on this assumption.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 125 +++++++++++++++++++++++++++++-----------
 1 file changed, 91 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 17ae5c15a9e06..4b3642a9e8d13 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -124,6 +124,93 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 	return 0;
 }
 
+static int replace_pte_entries(unsigned long start, unsigned long end,
+			       unsigned long hole_start, unsigned long hole_end,
+			       unsigned long map_page_size, pgprot_t flags)
+{
+	int i;
+	int rc = 0;
+	unsigned long addr, pa;
+
+	if (map_page_size == PUD_SIZE) {
+		pgd_t *pgdp;
+		pud_t *pudp;
+		pmd_t *pmdp, *new_pmdp;
+		unsigned long size = RADIX_PMD_TABLE_SIZE / sizeof(pmd_t);
+
+		pgdp = pgd_offset_k(start);
+		pudp = pud_offset(pgdp, start);
+
+		pmdp = pmd_alloc_one(&init_mm, start);
+		if (!pmdp) {
+			rc = 1;
+			goto done;
+		}
+
+		for (i = 0; i < size; i++) {
+			addr = start + i * PMD_SIZE;
+			new_pmdp = (pmd_t *)(pmdp + i);
+
+			if (addr >= hole_start ||
+				addr <= hole_end) {
+				*new_pmdp = __pmd(0ULL);
+				continue;
+			}
+
+			pa = __pa(addr);
+			*new_pmdp = pfn_pmd(pa >> PMD_SHIFT, flags);
+			*new_pmdp = pmd_mkhuge(*pmdp);
+		}
+
+		pud_populate(&init_mm, pudp, pmdp);
+	} else if (map_page_size == PMD_SIZE) {
+		pgd_t *pgdp;
+		pud_t *pudp;
+		pmd_t *pmdp;
+		pte_t *new_ptep, *ptep;
+		unsigned long size = RADIX_PTE_TABLE_SIZE / sizeof(pte_t);
+
+		pgdp = pgd_offset_k(start);
+		pudp = pud_offset(pgdp, start);
+		pmdp = pmd_offset(pudp, start);
+
+		ptep = pte_alloc_one(&init_mm, start);
+		if (!ptep) {
+			rc = 1;
+			goto done;
+		}
+
+		for (i = 0; i < size; i++) {
+			addr = start + i * PAGE_SIZE;
+			new_ptep = (pte_t *)(ptep + i);
+
+			if (addr >= hole_start ||
+				addr <= hole_end) {
+				*new_ptep = __pte(0ULL);
+				continue;
+			}
+
+			pa = __pa(addr);
+			*new_ptep = pfn_pte(pa >> PAGE_SHIFT, flags);
+			*new_ptep = __pte(pte_val(*new_ptep) | _PAGE_PTE);
+		}
+
+		pmd_populate_kernel(&init_mm, pmdp, ptep);
+	} else {
+		WARN_ONCE(1, "Unsupported mapping size to "
+			     "split %lx, ea %lx\n", map_page_size, start);
+		rc = 1;
+	}
+
+	smp_wmb();
+	if (rc == 0)
+		radix__flush_tlb_kernel_range(start, start + map_page_size);
+
+done:
+	return rc;
+
+}
+
 #ifdef CONFIG_STRICT_KERNEL_RWX
 void radix__change_memory_range(unsigned long start, unsigned long end,
 				unsigned long clear)
@@ -672,30 +759,6 @@ static void free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 	pud_clear(pud);
 }
 
-struct change_mapping_params {
-	pte_t *pte;
-	unsigned long start;
-	unsigned long end;
-	unsigned long aligned_start;
-	unsigned long aligned_end;
-};
-
-static int stop_machine_change_mapping(void *data)
-{
-	struct change_mapping_params *params =
-			(struct change_mapping_params *)data;
-
-	if (!data)
-		return -1;
-
-	spin_unlock(&init_mm.page_table_lock);
-	pte_clear(&init_mm, params->aligned_start, params->pte);
-	create_physical_mapping(params->aligned_start, params->start);
-	create_physical_mapping(params->end, params->aligned_end);
-	spin_lock(&init_mm.page_table_lock);
-	return 0;
-}
-
 static void remove_pte_table(pte_t *pte_start, unsigned long addr,
 			     unsigned long end)
 {
@@ -728,12 +791,11 @@ static void remove_pte_table(pte_t *pte_start, unsigned long addr,
  * clear the pte and potentially split the mapping helper
  */
 static void split_kernel_mapping(unsigned long addr, unsigned long end,
-				unsigned long size, pte_t *pte)
+				unsigned long size, pte_t *ptep)
 {
 	unsigned long mask = ~(size - 1);
 	unsigned long aligned_start = addr & mask;
 	unsigned long aligned_end = addr + size;
-	struct change_mapping_params params;
 	bool split_region = false;
 
 	if ((end - addr) < size) {
@@ -757,17 +819,12 @@ static void split_kernel_mapping(unsigned long addr, unsigned long end,
 	}
 
 	if (split_region) {
-		params.pte = pte;
-		params.start = addr;
-		params.end = end;
-		params.aligned_start = addr & ~(size - 1);
-		params.aligned_end = min_t(unsigned long, aligned_end,
-				(unsigned long)__va(memblock_end_of_DRAM()));
-		stop_machine(stop_machine_change_mapping, &params, NULL);
+		replace_pte_entries(aligned_start, aligned_end, addr, end,
+					size, pte_pgprot(*ptep));
 		return;
 	}
 
-	pte_clear(&init_mm, addr, pte);
+	pte_clear(&init_mm, addr, ptep);
 }
 
 static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
-- 
2.13.6
