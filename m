Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3F978DDED4
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 16:51:20 +1000 (EST)
Date: Wed, 15 Aug 2007 16:51:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] tidy up CONFIG_PPC_MM_SLICES code
Message-Id: <20070815165118.ee72d00c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This removes some of the #ifdefs from .c files.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/hash_utils_64.c  |    6 ------
 arch/powerpc/mm/mmu_context_64.c |    8 +-------
 include/asm-powerpc/page_64.h    |    7 +++++++
 3 files changed, 8 insertions(+), 13 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f178957..c42741f 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -602,13 +602,7 @@ static void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 {
 	if (mm->context.user_psize == MMU_PAGE_4K)
 		return;
-#ifdef CONFIG_PPC_MM_SLICES
 	slice_set_user_psize(mm, MMU_PAGE_4K);
-#else /* CONFIG_PPC_MM_SLICES */
-	mm->context.user_psize = MMU_PAGE_4K;
-	mm->context.sllp = SLB_VSID_USER | mmu_psize_defs[MMU_PAGE_4K].sllp;
-#endif /* CONFIG_PPC_MM_SLICES */
-
 #ifdef CONFIG_SPU_BASE
 	spu_flush_all_slbs(mm);
 #endif
diff --git a/arch/powerpc/mm/mmu_context_64.c b/arch/powerpc/mm/mmu_context_64.c
index 901ea76..1db38ba 100644
--- a/arch/powerpc/mm/mmu_context_64.c
+++ b/arch/powerpc/mm/mmu_context_64.c
@@ -49,18 +49,12 @@ again:
 		return -ENOMEM;
 	}
 
-#ifdef CONFIG_PPC_MM_SLICES
 	/* The old code would re-promote on fork, we don't do that
 	 * when using slices as it could cause problem promoting slices
 	 * that have been forced down to 4K
 	 */
-	if (mm->context.id == 0)
+	if (slice_mm_new_context(mm))
 		slice_set_user_psize(mm, mmu_virtual_psize);
-#else
-	mm->context.user_psize = mmu_virtual_psize;
-	mm->context.sllp = SLB_VSID_USER |
-		mmu_psize_defs[mmu_virtual_psize].sllp;
-#endif
 	mm->context.id = index;
 
 	return 0;
diff --git a/include/asm-powerpc/page_64.h b/include/asm-powerpc/page_64.h
index 3448a3d..4ceb113 100644
--- a/include/asm-powerpc/page_64.h
+++ b/include/asm-powerpc/page_64.h
@@ -121,6 +121,7 @@ extern unsigned int get_slice_psize(struct mm_struct *mm,
 
 extern void slice_init_context(struct mm_struct *mm, unsigned int psize);
 extern void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
+#define slice_mm_new_context(mm)	((mm)->context.id == 0)
 
 #define ARCH_HAS_HUGEPAGE_ONLY_RANGE
 extern int is_hugepage_only_range(struct mm_struct *m,
@@ -130,6 +131,12 @@ extern int is_hugepage_only_range(struct mm_struct *m,
 #endif /* __ASSEMBLY__ */
 #else
 #define slice_init()
+#define slice_set_user_psize(mm, psize)		\
+do {						\
+	(mm)->context.user_psize = (psize);	\
+	(mm)->context.sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
+} while (0)
+#define slice_mm_new_context(mm)	1
 #endif /* CONFIG_PPC_MM_SLICES */
 
 #ifdef CONFIG_HUGETLB_PAGE
-- 
1.5.2.4
