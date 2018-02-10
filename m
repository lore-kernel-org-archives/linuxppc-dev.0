Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdl5V4F4SzF0dt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 19:11:58 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id g18so2548676plo.7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 00:11:58 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 2/5] powerpc/mm/slice: implement a slice mask cache
Date: Sat, 10 Feb 2018 18:11:36 +1000
Message-Id: <20180210081139.27236-3-npiggin@gmail.com>
In-Reply-To: <20180210081139.27236-1-npiggin@gmail.com>
References: <20180210081139.27236-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Calculating the slice mask can become a signifcant overhead for
get_unmapped_area. This patch adds a struct slice_mask for
each page size in the mm_context, and keeps these in synch with
the slices psize arrays and slb_addr_limit.

This saves about 30% kernel time on a single-page mmap/munmap micro
benchmark.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 20 +++++++++-
 arch/powerpc/mm/slice.c                  | 68 ++++++++++++++++++++++++--------
 2 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 0abeb0e2d616..b6d136fd8ffd 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -80,6 +80,16 @@ struct spinlock;
 /* Maximum possible number of NPUs in a system. */
 #define NV_MAX_NPUS 8
 
+/*
+ * One bit per slice. We have lower slices which cover 256MB segments
+ * upto 4G range. That gets us 16 low slices. For the rest we track slices
+ * in 1TB size.
+ */
+struct slice_mask {
+	u64 low_slices;
+	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
+};
+
 typedef struct {
 	mm_context_id_t id;
 	u16 user_psize;		/* page size index */
@@ -91,9 +101,17 @@ typedef struct {
 	struct npu_context *npu_context;
 
 #ifdef CONFIG_PPC_MM_SLICES
+	unsigned long slb_addr_limit;
 	u64 low_slices_psize;	/* SLB page size encodings */
 	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
-	unsigned long slb_addr_limit;
+# ifdef CONFIG_PPC_64K_PAGES
+	struct slice_mask mask_64k;
+# endif
+	struct slice_mask mask_4k;
+# ifdef CONFIG_HUGETLB_PAGE
+	struct slice_mask mask_16m;
+	struct slice_mask mask_16g;
+# endif
 #else
 	u16 sllp;		/* SLB page size encoding */
 #endif
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index e8f6922d3c9b..837700bb50a9 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -37,15 +37,6 @@
 #include <asm/hugetlb.h>
 
 static DEFINE_SPINLOCK(slice_convert_lock);
-/*
- * One bit per slice. We have lower slices which cover 256MB segments
- * upto 4G range. That gets us 16 low slices. For the rest we track slices
- * in 1TB size.
- */
-struct slice_mask {
-	u64 low_slices;
-	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
-};
 
 #ifdef DEBUG
 int _slice_debug = 1;
@@ -144,7 +135,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
 			__set_bit(i, ret->high_slices);
 }
 
-static void slice_mask_for_size(struct mm_struct *mm, int psize,
+static void calc_slice_mask_for_size(struct mm_struct *mm, int psize,
 				struct slice_mask *ret,
 				unsigned long high_limit)
 {
@@ -173,6 +164,40 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize,
 	}
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
+static void recalc_slice_mask_cache(struct mm_struct *mm)
+{
+	unsigned long l = mm->context.slb_addr_limit;
+	calc_slice_mask_for_size(mm, MMU_PAGE_4K, &mm->context.mask_4k, l);
+#ifdef CONFIG_PPC_64K_PAGES
+	calc_slice_mask_for_size(mm, MMU_PAGE_64K, &mm->context.mask_64k, l);
+#endif
+#ifdef CONFIG_HUGETLB_PAGE
+	calc_slice_mask_for_size(mm, MMU_PAGE_16M, &mm->context.mask_16m, l);
+	calc_slice_mask_for_size(mm, MMU_PAGE_16G, &mm->context.mask_16g, l);
+#endif
+}
+
+static const struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
+{
+#ifdef CONFIG_PPC_64K_PAGES
+	if (psize == MMU_PAGE_64K)
+		return &mm->context.mask_64k;
+#endif
+	if (psize == MMU_PAGE_4K)
+		return &mm->context.mask_4k;
+#ifdef CONFIG_HUGETLB_PAGE
+	if (psize == MMU_PAGE_16M)
+		return &mm->context.mask_16m;
+	if (psize == MMU_PAGE_16G)
+		return &mm->context.mask_16g;
+#endif
+	BUG();
+}
+#else
+#error "Must define the slice masks for page sizes supported by the platform"
+#endif
+
 static int slice_check_fit(struct mm_struct *mm,
 			   const struct slice_mask *mask,
 			   const struct slice_mask *available)
@@ -246,6 +271,8 @@ static void slice_convert(struct mm_struct *mm,
 		  (unsigned long)mm->context.low_slices_psize,
 		  (unsigned long)mm->context.high_slices_psize);
 
+	recalc_slice_mask_cache(mm);
+
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 
 	copro_flush_all_slbs(mm);
@@ -448,7 +475,14 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	}
 
 	if (high_limit > mm->context.slb_addr_limit) {
+		unsigned long flags;
+
 		mm->context.slb_addr_limit = high_limit;
+
+		spin_lock_irqsave(&slice_convert_lock, flags);
+		recalc_slice_mask_cache(mm);
+		spin_unlock_irqrestore(&slice_convert_lock, flags);
+
 		on_each_cpu(slice_flush_segments, mm, 1);
 	}
 
@@ -487,7 +521,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/* First make up a "good" mask of slices that have the right size
 	 * already
 	 */
-	slice_mask_for_size(mm, psize, &good_mask, high_limit);
+	good_mask = *slice_mask_for_size(mm, psize);
 	slice_print_mask(" good_mask", &good_mask);
 
 	/*
@@ -512,7 +546,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 #ifdef CONFIG_PPC_64K_PAGES
 	/* If we support combo pages, we can allow 64k pages in 4k slices */
 	if (psize == MMU_PAGE_64K) {
-		slice_mask_for_size(mm, MMU_PAGE_4K, &compat_mask, high_limit);
+		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
 		if (fixed)
 			slice_or_mask(&good_mask, &compat_mask);
 	}
@@ -693,7 +727,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 		goto bail;
 
 	mm->context.user_psize = psize;
-	wmb();
+	wmb(); /* Why? */
 
 	lpsizes = mm->context.low_slices_psize;
 	for (i = 0; i < SLICE_NUM_LOW; i++)
@@ -720,6 +754,9 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 		  (unsigned long)mm->context.low_slices_psize,
 		  (unsigned long)mm->context.high_slices_psize);
 
+	recalc_slice_mask_cache(mm);
+	spin_unlock_irqrestore(&slice_convert_lock, flags);
+	return;
  bail:
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 }
@@ -760,18 +797,17 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 {
 	struct slice_mask mask, available;
 	unsigned int psize = mm->context.user_psize;
-	unsigned long high_limit = mm->context.slb_addr_limit;
 
 	if (radix_enabled())
 		return 0;
 
 	slice_range_to_mask(addr, len, &mask);
-	slice_mask_for_size(mm, psize, &available, high_limit);
+	available = *slice_mask_for_size(mm, psize);
 #ifdef CONFIG_PPC_64K_PAGES
 	/* We need to account for 4k slices too */
 	if (psize == MMU_PAGE_64K) {
 		struct slice_mask compat_mask;
-		slice_mask_for_size(mm, MMU_PAGE_4K, &compat_mask, high_limit);
+		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
 		slice_or_mask(&available, &compat_mask);
 	}
 #endif
-- 
2.15.1
