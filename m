Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F18C6B6F6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 11:43:36 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAT0hXft012711
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 18:43:33 -0600
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/book3e: Change hugetlb preload to take vma argument
Date: Mon, 28 Nov 2011 18:43:33 -0600
Message-Id: <13225274132130-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

This avoids an extra find_vma() and is less error-prone.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/hugetlb.h   |    3 ++-
 arch/powerpc/mm/hugetlbpage-book3e.c |    8 ++++++--
 arch/powerpc/mm/mem.c                |    2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 555044c..863f49d 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -52,7 +52,8 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 }
 #endif
 
-void book3e_hugetlb_preload(struct mm_struct *mm, unsigned long ea, pte_t pte);
+void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
+			    pte_t pte);
 void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 
 void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index 4d6d849..3bc7006 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -37,12 +37,14 @@ static inline int book3e_tlb_exists(unsigned long ea, unsigned long pid)
 	return found;
 }
 
-void book3e_hugetlb_preload(struct mm_struct *mm, unsigned long ea, pte_t pte)
+void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
+			    pte_t pte)
 {
 	unsigned long mas1, mas2;
 	u64 mas7_3;
 	unsigned long psize, tsize, shift;
 	unsigned long flags;
+	struct mm_struct *mm;
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
 	int index, ncams;
@@ -51,12 +53,14 @@ void book3e_hugetlb_preload(struct mm_struct *mm, unsigned long ea, pte_t pte)
 	if (unlikely(is_kernel_addr(ea)))
 		return;
 
+	mm = vma->vm_mm;
+
 #ifdef CONFIG_PPC_MM_SLICES
 	psize = get_slice_psize(mm, ea);
 	tsize = mmu_get_tsize(psize);
 	shift = mmu_psize_defs[psize].shift;
 #else
-	psize = vma_mmu_pagesize(find_vma(mm, ea));
+	psize = vma_mmu_pagesize(vma);
 	shift = __ilog2(psize);
 	tsize = shift - 10;
 #endif
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 4dbc388..846065c 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -552,6 +552,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 #if (defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_FSL_BOOK3E)) \
 	&& defined(CONFIG_HUGETLB_PAGE)
 	if (is_vm_hugetlb_page(vma))
-		book3e_hugetlb_preload(vma->vm_mm, address, *ptep);
+		book3e_hugetlb_preload(vma, address, *ptep);
 #endif
 }
-- 
1.5.6.5
