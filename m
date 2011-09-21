Return-Path: <paulus@ozlabs.org>
Date: Wed, 21 Sep 2011 15:58:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix hugetlb with CONFIG_PPC_MM_SLICES=y
Message-ID: <20110921055810.GA21681@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 41151e77a4 ("powerpc: Hugetlb for BookE") added some
#ifdef CONFIG_MM_SLICES conditionals to hugetlb_get_unmapped_area()
and vma_mmu_pagesize().  Unfortunately this is not the correct config
symbol; it should be CONFIG_PPC_MM_SLICES.  The result is that
attempting to use hugetlbfs on 64-bit Power server processors results
in an infinite stack recursion between get_unmapped_area() and
hugetlb_get_unmapped_area().

This fixes it by changing the #ifdef to use CONFIG_PPC_MM_SLICES
in those functions and also in book3e_hugetlb_preload().

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/mm/hugetlbpage-book3e.c |    2 +-
 arch/powerpc/mm/hugetlbpage.c        |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index 1295b7c..343ad0b 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -52,7 +52,7 @@ void book3e_hugetlb_preload(struct mm_struct *mm, unsigned long ea, pte_t pte)
 	if (unlikely(is_kernel_addr(ea)))
 		return;
 
-#ifdef CONFIG_MM_SLICES
+#ifdef CONFIG_PPC_MM_SLICES
 	psize = mmu_get_tsize(get_slice_psize(mm, ea));
 	tsize = mmu_get_psize(psize);
 	shift = mmu_psize_defs[psize].shift;
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 3a5f59d..48b65be 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -690,7 +690,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 					unsigned long len, unsigned long pgoff,
 					unsigned long flags)
 {
-#ifdef CONFIG_MM_SLICES
+#ifdef CONFIG_PPC_MM_SLICES
 	struct hstate *hstate = hstate_file(file);
 	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));
 
@@ -702,7 +702,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 {
-#ifdef CONFIG_MM_SLICES
+#ifdef CONFIG_PPC_MM_SLICES
 	unsigned int psize = get_slice_psize(vma->vm_mm, vma->vm_start);
 
 	return 1UL << mmu_psize_to_shift(psize);
-- 
1.7.5.4
