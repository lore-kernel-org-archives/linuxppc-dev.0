Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxdP24NYYzDr3t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 17:49:42 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id z6so3671448pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 00:49:42 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v4 8/9] powerpc/mm/radix: Implement mark_rodata_ro() for radix
Date: Tue, 27 Jun 2017 17:49:02 +1000
Message-Id: <20170627074903.19324-9-bsingharora@gmail.com>
In-Reply-To: <20170627074903.19324-1-bsingharora@gmail.com>
References: <20170627074903.19324-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch splits the linear page mapping such that
the ones with kernel text are mapped as 2M and others
are mapped with the largest possible size - 1G. The downside
of this is that we split a 1G mapping into 512 2M mappings
for the kernel, but in the absence of that we cannot support
R/O areas in 1G, the kernel size is much smaller and using
1G as the granularity will waste a lot of space at the cost
of optimizing the TLB. The text itself should fit into about
6-8 mappings, so the effect should not be all that bad.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 68 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 0797c4e..bdd85f9 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -11,6 +11,7 @@
 #include <linux/sched/mm.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/mm.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -23,6 +24,8 @@
 
 #include <trace/events/thp.h>
 
+int mmu_radix_linear_psize = PAGE_SIZE;
+
 static int native_register_process_table(unsigned long base, unsigned long pg_sz,
 					 unsigned long table_size)
 {
@@ -112,7 +115,53 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 #ifdef CONFIG_STRICT_KERNEL_RWX
 void radix__mark_rodata_ro(void)
 {
-	pr_warn("Not yet implemented for radix\n");
+	unsigned long start = (unsigned long)_stext;
+	unsigned long end = (unsigned long)__init_begin;
+	unsigned long idx;
+	unsigned int step, shift;
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
+	shift = mmu_psize_defs[mmu_radix_linear_psize].shift;
+	step = 1 << shift;
+
+	start = ((start + step - 1) >> shift) << shift;
+	end = (end >> shift) << shift;
+
+	pr_devel("marking ro start %lx, end %lx, step %x\n",
+			start, end, step);
+
+	for (idx = start; idx < end; idx += step) {
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
 
@@ -131,6 +180,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 {
 	unsigned long vaddr, addr, mapping_size = 0;
 	pgprot_t prot;
+	unsigned long max_mapping_size;
 
 	start = _ALIGN_UP(start, PAGE_SIZE);
 	for (addr = start; addr < end; addr += mapping_size) {
@@ -139,9 +189,12 @@ static int __meminit create_physical_mapping(unsigned long start,
 
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
@@ -149,6 +202,17 @@ static int __meminit create_physical_mapping(unsigned long start,
 		else
 			mapping_size = PAGE_SIZE;
 
+		if (mapping_size == PUD_SIZE &&
+			addr <= __pa_symbol(__init_begin) &&
+			(addr + mapping_size) >= __pa_symbol(_stext)) {
+			max_mapping_size = PMD_SIZE;
+			goto retry;
+		}
+
+		if (addr <= __pa_symbol(__init_begin) &&
+			(addr + mapping_size) >= __pa_symbol(_stext))
+			mmu_radix_linear_psize = mapping_size;
+
 		if (mapping_size != previous_size) {
 			print_mapping(start, addr, previous_size);
 			start = addr;
-- 
2.9.4
