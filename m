Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1S2m1731zDr4d
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 23:02:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 09/10] powerpc/mm/radix: Implement
 STRICT_RWX/mark_rodata_ro() for Radix
Date: Mon,  3 Jul 2017 23:01:53 +1000
Message-Id: <1499086914-25695-9-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
References: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

The Radix linear mapping code (create_physical_mapping()) tries to use
the largest page size it can at each step. Currently the only reason
it steps down to a smaller page size is if the start addr is
unaligned (never happens in practice), or the end of memory is not
aligned to a huge page boundary.

To support STRICT_RWX we need to break the mapping at __init_begin,
so that the text and rodata prior to that can be marked R_X and the
regular pages after can be marked RW.

Having done that we can now implement mark_rodata_ro() for Radix,
knowing that we won't need to split any mappings.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
[mpe: Split down to PAGE_SIZE, not 2MB, rewrite change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/pgtable-radix.c | 67 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index b07e0008d02a..d2fd34a6f542 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -11,6 +11,7 @@
 #include <linux/sched/mm.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/mm.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -113,7 +114,48 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 #ifdef CONFIG_STRICT_KERNEL_RWX
 void radix__mark_rodata_ro(void)
 {
-	pr_warn("Not yet implemented for radix\n");
+	unsigned long start = (unsigned long)_stext;
+	unsigned long end = (unsigned long)__init_begin;
+	unsigned long idx;
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	if (!mmu_has_feature(MMU_FTR_KERNEL_RO)) {
+		pr_info("R/O rodata not supported\n");
+		return;
+	}
+
+	start = ALIGN_DOWN(start, PAGE_SIZE);
+	end = PAGE_ALIGN(end); // aligns up
+
+	pr_devel("marking ro start %lx, end %lx\n", start, end);
+
+	for (idx = start; idx < end; idx += PAGE_SIZE) {
+		pgdp = pgd_offset_k(idx);
+		pudp = pud_alloc(&init_mm, pgdp, idx);
+		if (!pudp)
+			continue;
+		if (pud_huge(*pudp)) {
+			ptep = (pte_t *)pudp;
+			goto update_the_pte;
+		}
+		pmdp = pmd_alloc(&init_mm, pudp, idx);
+		if (!pmdp)
+			continue;
+		if (pmd_huge(*pmdp)) {
+			ptep = pmdp_ptep(pmdp);
+			goto update_the_pte;
+		}
+		ptep = pte_alloc_kernel(pmdp, idx);
+		if (!ptep)
+			continue;
+update_the_pte:
+		radix__pte_update(&init_mm, idx, ptep, _PAGE_WRITE, 0, 0);
+	}
+	radix__flush_tlb_kernel_range(start, end);
+
 }
 #endif
 
@@ -132,6 +174,12 @@ static int __meminit create_physical_mapping(unsigned long start,
 {
 	unsigned long vaddr, addr, mapping_size = 0;
 	pgprot_t prot;
+	unsigned long max_mapping_size;
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	int split_text_mapping = 1;
+#else
+	int split_text_mapping = 0;
+#endif
 
 	start = _ALIGN_UP(start, PAGE_SIZE);
 	for (addr = start; addr < end; addr += mapping_size) {
@@ -140,9 +188,12 @@ static int __meminit create_physical_mapping(unsigned long start,
 
 		gap = end - addr;
 		previous_size = mapping_size;
+		max_mapping_size = PUD_SIZE;
 
+retry:
 		if (IS_ALIGNED(addr, PUD_SIZE) && gap >= PUD_SIZE &&
-		    mmu_psize_defs[MMU_PAGE_1G].shift)
+		    mmu_psize_defs[MMU_PAGE_1G].shift &&
+		    PUD_SIZE <= max_mapping_size)
 			mapping_size = PUD_SIZE;
 		else if (IS_ALIGNED(addr, PMD_SIZE) && gap >= PMD_SIZE &&
 			 mmu_psize_defs[MMU_PAGE_2M].shift)
@@ -150,6 +201,18 @@ static int __meminit create_physical_mapping(unsigned long start,
 		else
 			mapping_size = PAGE_SIZE;
 
+		if (split_text_mapping && (mapping_size == PUD_SIZE) &&
+			(addr <= __pa_symbol(__init_begin)) &&
+			(addr + mapping_size) >= __pa_symbol(_stext)) {
+			max_mapping_size = PMD_SIZE;
+			goto retry;
+		}
+
+		if (split_text_mapping && (mapping_size == PMD_SIZE) &&
+		    (addr <= __pa_symbol(__init_begin)) &&
+		    (addr + mapping_size) >= __pa_symbol(_stext))
+			mapping_size = PAGE_SIZE;
+
 		if (mapping_size != previous_size) {
 			print_mapping(start, addr, previous_size);
 			start = addr;
-- 
2.7.4
