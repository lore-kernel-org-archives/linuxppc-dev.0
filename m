Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwrKT3Z2tzDrKl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 22:57:49 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id hh10so7003140pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 05:57:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc/64: implement a slice mask cache
Date: Fri, 22 Jul 2016 22:57:28 +1000
Message-Id: <1469192248-25141-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Calculating the slice mask can become a signifcant overhead for
get_unmapped_area. The mask is relatively small and does not change
frequently, so we can cache it in the mm context.

This saves about 30% kernel time on a 4K user address allocation
in a microbenchmark.

Comments on the approach taken? I think there is the option for fixed
allocations to avoid some of the slice calculation entirely, but first
I think it will be good to have a general speedup that covers all
mmaps.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  8 +++++++
 arch/powerpc/mm/slice.c                  | 39 ++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 5854263..0d15af4 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -71,6 +71,14 @@ typedef struct {
 #ifdef CONFIG_PPC_MM_SLICES
 	u64 low_slices_psize;	/* SLB page size encodings */
 	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
+	struct slice_mask mask_4k;
+# ifdef CONFIG_PPC_64K_PAGES
+	struct slice_mask mask_64k;
+# endif
+# ifdef CONFIG_HUGETLB_PAGE
+	struct slice_mask mask_16m;
+	struct slice_mask mask_16g;
+# endif
 #else
 	u16 sllp;		/* SLB page size encoding */
 #endif
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 2b27458..559ea5f 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -147,7 +147,7 @@ static struct slice_mask slice_mask_for_free(struct mm_struct *mm)
 	return ret;
 }
 
-static struct slice_mask slice_mask_for_size(struct mm_struct *mm, int psize)
+static struct slice_mask calc_slice_mask_for_size(struct mm_struct *mm, int psize)
 {
 	unsigned char *hpsizes;
 	int index, mask_index;
@@ -171,6 +171,36 @@ static struct slice_mask slice_mask_for_size(struct mm_struct *mm, int psize)
 	return ret;
 }
 
+static void recalc_slice_mask_cache(struct mm_struct *mm)
+{
+	mm->context.mask_4k = calc_slice_mask_for_size(mm, MMU_PAGE_4K);
+#ifdef CONFIG_PPC_64K_PAGES
+	mm->context.mask_64k = calc_slice_mask_for_size(mm, MMU_PAGE_64K);
+#endif
+# ifdef CONFIG_HUGETLB_PAGE
+	/* Radix does not come here */
+	mm->context.mask_16m = calc_slice_mask_for_size(mm, MMU_PAGE_16M);
+	mm->context.mask_16g = calc_slice_mask_for_size(mm, MMU_PAGE_16G);
+# endif
+}
+
+static struct slice_mask slice_mask_for_size(struct mm_struct *mm, int psize)
+{
+	if (psize == MMU_PAGE_4K)
+		return mm->context.mask_4k;
+#ifdef CONFIG_PPC_64K_PAGES
+	if (psize == MMU_PAGE_64K)
+		return mm->context.mask_64k;
+#endif
+# ifdef CONFIG_HUGETLB_PAGE
+	if (psize == MMU_PAGE_16M)
+		return mm->context.mask_16m;
+	if (psize == MMU_PAGE_16G)
+		return mm->context.mask_16g;
+# endif
+	BUG();
+}
+
 static int slice_check_fit(struct slice_mask mask, struct slice_mask available)
 {
 	return (mask.low_slices & available.low_slices) == mask.low_slices &&
@@ -233,6 +263,8 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
 
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 
+	recalc_slice_mask_cache(mm);
+
 	copro_flush_all_slbs(mm);
 }
 
@@ -625,7 +657,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 		goto bail;
 
 	mm->context.user_psize = psize;
-	wmb();
+	wmb(); /* Why? */
 
 	lpsizes = mm->context.low_slices_psize;
 	for (i = 0; i < SLICE_NUM_LOW; i++)
@@ -652,6 +684,9 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 		  mm->context.low_slices_psize,
 		  mm->context.high_slices_psize);
 
+	spin_unlock_irqrestore(&slice_convert_lock, flags);
+	recalc_slice_mask_cache(mm);
+	return;
  bail:
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 }
-- 
2.8.1
