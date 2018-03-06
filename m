Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwcwR3ZH0zF1Sx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 00:25:43 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id m19so8256646pgn.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 05:25:43 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: [PATCH 05/10] powerpc/mm/slice: implement a slice mask cache
Date: Tue,  6 Mar 2018 23:25:02 +1000
Message-Id: <20180306132507.10649-6-npiggin@gmail.com>
In-Reply-To: <20180306132507.10649-1-npiggin@gmail.com>
References: <20180306132507.10649-1-npiggin@gmail.com>
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

On Book3S/64 this adds 288 bytes to the mm_context_t for the
slice mask caches.

On POWER8, this increases vfork+exec+exit performance by 9.9%
and reduces time to mmap+munmap a 64kB page by 28%.

Reduces time to mmap+munmap by about 10% on 8xx.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  18 +++++
 arch/powerpc/include/asm/mmu-8xx.h       |  14 ++++
 arch/powerpc/mm/slice.c                  | 118 ++++++++++++++++++++-----------
 3 files changed, 107 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index bef6e39ed63a..777778579305 100644
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
@@ -95,6 +105,14 @@ typedef struct {
 	unsigned char low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
 	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
 	unsigned long slb_addr_limit;
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
index d3d7e79140c6..4c3b14703b3e 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -192,6 +192,11 @@
 #endif
 
 #ifndef __ASSEMBLY__
+struct slice_mask {
+	u64 low_slices;
+	DECLARE_BITMAP(high_slices, 0);
+};
+
 typedef struct {
 	unsigned int id;
 	unsigned int active;
@@ -201,6 +206,15 @@ typedef struct {
 	unsigned char low_slices_psize[SLICE_ARRAY_SIZE];
 	unsigned char high_slices_psize[0];
 	unsigned long slb_addr_limit;
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
index 233c42d593dc..2115efe5e869 100644
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
@@ -149,37 +140,44 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
 			__set_bit(i, ret->high_slices);
 }
 
-static void slice_mask_for_size(struct mm_struct *mm, int psize,
-				struct slice_mask *ret,
-				unsigned long high_limit)
+#ifdef CONFIG_PPC_BOOK3S_64
+static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
 {
-	unsigned char *hpsizes, *lpsizes;
-	int index, mask_index;
-	unsigned long i;
-
-	ret->low_slices = 0;
-	if (SLICE_NUM_HIGH)
-		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
-
-	lpsizes = mm->context.low_slices_psize;
-	for (i = 0; i < SLICE_NUM_LOW; i++) {
-		mask_index = i & 0x1;
-		index = i >> 1;
-		if (((lpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
-			ret->low_slices |= 1u << i;
-	}
-
-	if (high_limit <= SLICE_LOW_TOP)
-		return;
-
-	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(high_limit); i++) {
-		mask_index = i & 0x1;
-		index = i >> 1;
-		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
-			__set_bit(i, ret->high_slices);
-	}
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
 }
+#elif defined(CONFIG_PPC_8xx)
+static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
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
 
 static int slice_check_fit(struct mm_struct *mm,
 			   const struct slice_mask *mask,
@@ -226,11 +224,15 @@ static void slice_convert(struct mm_struct *mm,
 	int index, mask_index;
 	/* Write the new slice psize bits */
 	unsigned char *hpsizes, *lpsizes;
+	struct slice_mask *psize_mask, *old_mask;
 	unsigned long i, flags;
+	int old_psize;
 
 	slice_dbg("slice_convert(mm=%p, psize=%d)\n", mm, psize);
 	slice_print_mask(" mask", mask);
 
+	psize_mask = slice_mask_for_size(mm, psize);
+
 	/* We need to use a spinlock here to protect against
 	 * concurrent 64k -> 4k demotion ...
 	 */
@@ -243,6 +245,14 @@ static void slice_convert(struct mm_struct *mm,
 
 		mask_index = i & 0x1;
 		index = i >> 1;
+
+		/* Update the slice_mask */
+		old_psize = (lpsizes[index] >> (mask_index * 4)) & 0xf;
+		old_mask = slice_mask_for_size(mm, old_psize);
+		old_mask->low_slices &= ~(1u << i);
+		psize_mask->low_slices |= 1u << i;
+
+		/* Update the sizes array */
 		lpsizes[index] = (lpsizes[index] & ~(0xf << (mask_index * 4))) |
 				(((unsigned long)psize) << (mask_index * 4));
 	}
@@ -254,6 +264,14 @@ static void slice_convert(struct mm_struct *mm,
 
 		mask_index = i & 0x1;
 		index = i >> 1;
+
+		/* Update the slice_mask */
+		old_psize = (hpsizes[index] >> (mask_index * 4)) & 0xf;
+		old_mask = slice_mask_for_size(mm, old_psize);
+		__clear_bit(i, old_mask->high_slices);
+		__set_bit(i, psize_mask->high_slices);
+
+		/* Update the sizes array */
 		hpsizes[index] = (hpsizes[index] & ~(0xf << (mask_index * 4))) |
 				(((unsigned long)psize) << (mask_index * 4));
 	}
@@ -464,7 +482,13 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	}
 
 	if (high_limit > mm->context.slb_addr_limit) {
+		/*
+		 * Increasing the slb_addr_limit does not require
+		 * slice mask cache to be recalculated because it should
+		 * be already initialised beyond the old address limit.
+		 */
 		mm->context.slb_addr_limit = high_limit;
+
 		on_each_cpu(slice_flush_segments, mm, 1);
 	}
 
@@ -506,7 +530,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/* First make up a "good" mask of slices that have the right size
 	 * already
 	 */
-	slice_mask_for_size(mm, psize, &good_mask, high_limit);
+	good_mask = *slice_mask_for_size(mm, psize);
 	slice_print_mask(" good_mask", &good_mask);
 
 	/*
@@ -531,7 +555,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 #ifdef CONFIG_PPC_64K_PAGES
 	/* If we support combo pages, we can allow 64k pages in 4k slices */
 	if (psize == MMU_PAGE_64K) {
-		slice_mask_for_size(mm, MMU_PAGE_4K, &compat_mask, high_limit);
+		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
 		if (fixed)
 			slice_or_mask(&good_mask, &compat_mask);
 	}
@@ -683,6 +707,7 @@ EXPORT_SYMBOL_GPL(get_slice_psize);
 void slice_init_new_context_exec(struct mm_struct *mm)
 {
 	unsigned char *hpsizes, *lpsizes;
+	struct slice_mask *mask;
 	unsigned int psize = mmu_virtual_psize;
 
 	slice_dbg("slice_init_new_context_exec(mm=%p)\n", mm);
@@ -703,6 +728,14 @@ void slice_init_new_context_exec(struct mm_struct *mm)
 
 	hpsizes = mm->context.high_slices_psize;
 	memset(hpsizes, (psize << 4) | psize, SLICE_NUM_HIGH >> 1);
+
+	/*
+	 * Slice mask cache starts zeroed, fill the default size cache.
+	 */
+	mask = slice_mask_for_size(mm, psize);
+	mask->low_slices = ~0UL;
+	if (SLICE_NUM_HIGH)
+		bitmap_fill(mask->high_slices, SLICE_NUM_HIGH);
 }
 
 void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
@@ -741,18 +774,17 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
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
2.16.1
