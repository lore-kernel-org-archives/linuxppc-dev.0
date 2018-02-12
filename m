Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgDKS4jT3zF0rJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 05:12:28 +1100 (AEDT)
Message-Id: <b38e0382fec8df4aaf247256a1d56d44cb1a3c9c.1518382747.git.christophe.leroy@c-s.fr>
In-Reply-To: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC REBASED 2/5] powerpc/mm/slice: implement a slice mask cache
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 12 Feb 2018 19:12:24 +0100 (CET)
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
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  20 ++++++-
 arch/powerpc/include/asm/mmu-8xx.h       |  16 ++++-
 arch/powerpc/mm/slice.c                  | 100 ++++++++++++++++++++++++++-----
 3 files changed, 118 insertions(+), 18 deletions(-)

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
diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index b324ab46d838..b97d4ed3dddf 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -187,15 +187,29 @@
 #define M_APG3		0x00000060
 
 #ifndef __ASSEMBLY__
+struct slice_mask {
+	u64 low_slices;
+	DECLARE_BITMAP(high_slices, 0);
+};
+
 typedef struct {
 	unsigned int id;
 	unsigned int active;
 	unsigned long vdso_base;
 #ifdef CONFIG_PPC_MM_SLICES
+	unsigned long slb_addr_limit;
 	u16 user_psize;		/* page size index */
 	u64 low_slices_psize;	/* page size encodings */
 	unsigned char high_slices_psize[0];
-	unsigned long slb_addr_limit;
+# ifdef CONFIG_PPC_16K_PAGES
+	struct slice_mask mask_16k;
+# else
+	struct slice_mask mask_4k;
+# endif
+# ifdef CONFIG_HUGETLB_PAGE
+	struct slice_mask mask_512k;
+	struct slice_mask mask_8m;
+# endif
 #endif
 } mm_context_t;
 
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index db1278ac21c2..ddf015d2d05b 100644
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
@@ -147,7 +138,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
 			__set_bit(i, ret->high_slices);
 }
 
-static void slice_mask_for_size(struct mm_struct *mm, int psize,
+static void calc_slice_mask_for_size(struct mm_struct *mm, int psize,
 				struct slice_mask *ret,
 				unsigned long high_limit)
 {
@@ -176,6 +167,72 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize,
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
+#elif defined(CONFIG_PPC_8xx)
+static void recalc_slice_mask_cache(struct mm_struct *mm)
+{
+	unsigned long l = mm->context.slb_addr_limit;
+#ifdef CONFIG_PPC_16K_PAGES
+	calc_slice_mask_for_size(mm, MMU_PAGE_16K, &mm->context.mask_16k, l);
+#else
+	calc_slice_mask_for_size(mm, MMU_PAGE_4K, &mm->context.mask_4k, l);
+#endif
+#ifdef CONFIG_HUGETLB_PAGE
+	calc_slice_mask_for_size(mm, MMU_PAGE_512K, &mm->context.mask_512k, l);
+	calc_slice_mask_for_size(mm, MMU_PAGE_8M, &mm->context.mask_8m, l);
+#endif
+}
+
+static const struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
+{
+#ifdef CONFIG_PPC_16K_PAGES
+	if (psize == MMU_PAGE_16K)
+		return &mm->context.mask_16k;
+#else
+	if (psize == MMU_PAGE_4K)
+		return &mm->context.mask_4k;
+#endif
+#ifdef CONFIG_HUGETLB_PAGE
+	if (psize == MMU_PAGE_512K)
+		return &mm->context.mask_512k;
+	if (psize == MMU_PAGE_8M)
+		return &mm->context.mask_8m;
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
@@ -251,6 +308,8 @@ static void slice_convert(struct mm_struct *mm,
 		  (unsigned long)mm->context.low_slices_psize,
 		  (unsigned long)mm->context.high_slices_psize);
 
+	recalc_slice_mask_cache(mm);
+
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 
 	copro_flush_all_slbs(mm);
@@ -449,7 +508,14 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
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
 
@@ -488,7 +554,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/* First make up a "good" mask of slices that have the right size
 	 * already
 	 */
-	slice_mask_for_size(mm, psize, &good_mask, high_limit);
+	good_mask = *slice_mask_for_size(mm, psize);
 	slice_print_mask(" good_mask", &good_mask);
 
 	/*
@@ -513,7 +579,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 #ifdef CONFIG_PPC_64K_PAGES
 	/* If we support combo pages, we can allow 64k pages in 4k slices */
 	if (psize == MMU_PAGE_64K) {
-		slice_mask_for_size(mm, MMU_PAGE_4K, &compat_mask, high_limit);
+		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
 		if (fixed)
 			slice_or_mask(&good_mask, &compat_mask);
 	}
@@ -695,7 +761,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 		goto bail;
 
 	mm->context.user_psize = psize;
-	wmb();
+	wmb(); /* Why? */
 
 	lpsizes = mm->context.low_slices_psize;
 	for (i = 0; i < SLICE_NUM_LOW; i++)
@@ -722,6 +788,9 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 		  (unsigned long)mm->context.low_slices_psize,
 		  (unsigned long)mm->context.high_slices_psize);
 
+	recalc_slice_mask_cache(mm);
+	spin_unlock_irqrestore(&slice_convert_lock, flags);
+	return;
  bail:
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 }
@@ -762,18 +831,17 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
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
2.13.3
