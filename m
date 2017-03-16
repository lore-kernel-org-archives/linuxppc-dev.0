Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkQ070r8LzDqd1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:37:26 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GAXlcS073316
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:37:24 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 297kjn7t8j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:37:24 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 06:37:23 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 01/14] powerpc/mm/slice: Convert slice_mask high slice to a
 bitmap
Date: Thu, 16 Mar 2017 16:07:00 +0530
In-Reply-To: <1489660633-24125-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1489660633-24125-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1489660633-24125-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In followup patch we want to increase the va range which will result
in us requiring high_slices to have more than 64 bits. To enable this
convert high_slices to bitmap. We keep the number bits same in this patch
and later change that to higher value

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/page_64.h |  15 ++---
 arch/powerpc/mm/slice.c            | 110 +++++++++++++++++++++++++------------
 2 files changed, 80 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index 3e83d2a20b6f..bd55ff751938 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -98,19 +98,16 @@ extern u64 ppc64_pft_size;
 #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
 
+#ifndef __ASSEMBLY__
 /*
- * 1 bit per slice and we have one slice per 1TB
- * Right now we support only 64TB.
- * IF we change this we will have to change the type
- * of high_slices
+ * One bit per slice. We have lower slices which cover 256MB segments
+ * upto 4G range. That gets us 16 low slices. For the rest we track slices
+ * in 1TB size.
+ * 64 below is actually SLICE_NUM_HIGH to fixup complie errros
  */
-#define SLICE_MASK_SIZE 8
-
-#ifndef __ASSEMBLY__
-
 struct slice_mask {
 	u16 low_slices;
-	u64 high_slices;
+	DECLARE_BITMAP(high_slices, 64);
 };
 
 struct mm_struct;
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index bf150557dba8..2b7a3f8295c0 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -36,11 +36,6 @@
 #include <asm/copro.h>
 #include <asm/hugetlb.h>
 
-/* some sanity checks */
-#if (H_PGTABLE_RANGE >> 43) > SLICE_MASK_SIZE
-#error H_PGTABLE_RANGE exceeds slice_mask high_slices size
-#endif
-
 static DEFINE_SPINLOCK(slice_convert_lock);
 
 
@@ -49,7 +44,7 @@ int _slice_debug = 1;
 
 static void slice_print_mask(const char *label, struct slice_mask mask)
 {
-	char	*p, buf[16 + 3 + 64 + 1];
+	char	*p, buf[SLICE_NUM_LOW + 3 + SLICE_NUM_HIGH + 1];
 	int	i;
 
 	if (!_slice_debug)
@@ -60,8 +55,12 @@ static void slice_print_mask(const char *label, struct slice_mask mask)
 	*(p++) = ' ';
 	*(p++) = '-';
 	*(p++) = ' ';
-	for (i = 0; i < SLICE_NUM_HIGH; i++)
-		*(p++) = (mask.high_slices & (1ul << i)) ? '1' : '0';
+	for (i = 0; i < SLICE_NUM_HIGH; i++) {
+		if (test_bit(i, mask.high_slices))
+			*(p++) = '1';
+		else
+			*(p++) = '0';
+	}
 	*(p++) = 0;
 
 	printk(KERN_DEBUG "%s:%s\n", label, buf);
@@ -80,7 +79,10 @@ static struct slice_mask slice_range_to_mask(unsigned long start,
 					     unsigned long len)
 {
 	unsigned long end = start + len - 1;
-	struct slice_mask ret = { 0, 0 };
+	struct slice_mask ret;
+
+	ret.low_slices = 0;
+	bitmap_zero(ret.high_slices, SLICE_NUM_HIGH);
 
 	if (start < SLICE_LOW_TOP) {
 		unsigned long mend = min(end, (SLICE_LOW_TOP - 1));
@@ -89,10 +91,13 @@ static struct slice_mask slice_range_to_mask(unsigned long start,
 			- (1u << GET_LOW_SLICE_INDEX(start));
 	}
 
-	if ((start + len) > SLICE_LOW_TOP)
-		ret.high_slices = (1ul << (GET_HIGH_SLICE_INDEX(end) + 1))
-			- (1ul << GET_HIGH_SLICE_INDEX(start));
+	if ((start + len) > SLICE_LOW_TOP) {
+		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
+		unsigned long align_end = ALIGN(end, (1UL <<SLICE_HIGH_SHIFT));
+		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
 
+		bitmap_set(ret.high_slices, start_index, count);
+	}
 	return ret;
 }
 
@@ -129,9 +134,12 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
 
 static struct slice_mask slice_mask_for_free(struct mm_struct *mm)
 {
-	struct slice_mask ret = { 0, 0 };
+	struct slice_mask ret;
 	unsigned long i;
 
+	ret.low_slices = 0;
+	bitmap_zero(ret.high_slices, SLICE_NUM_HIGH);
+
 	for (i = 0; i < SLICE_NUM_LOW; i++)
 		if (!slice_low_has_vma(mm, i))
 			ret.low_slices |= 1u << i;
@@ -141,7 +149,7 @@ static struct slice_mask slice_mask_for_free(struct mm_struct *mm)
 
 	for (i = 0; i < SLICE_NUM_HIGH; i++)
 		if (!slice_high_has_vma(mm, i))
-			ret.high_slices |= 1ul << i;
+			__set_bit(i, ret.high_slices);
 
 	return ret;
 }
@@ -150,10 +158,13 @@ static struct slice_mask slice_mask_for_size(struct mm_struct *mm, int psize)
 {
 	unsigned char *hpsizes;
 	int index, mask_index;
-	struct slice_mask ret = { 0, 0 };
+	struct slice_mask ret;
 	unsigned long i;
 	u64 lpsizes;
 
+	ret.low_slices = 0;
+	bitmap_zero(ret.high_slices, SLICE_NUM_HIGH);
+
 	lpsizes = mm->context.low_slices_psize;
 	for (i = 0; i < SLICE_NUM_LOW; i++)
 		if (((lpsizes >> (i * 4)) & 0xf) == psize)
@@ -164,7 +175,7 @@ static struct slice_mask slice_mask_for_size(struct mm_struct *mm, int psize)
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
-			ret.high_slices |= 1ul << i;
+			__set_bit(i, ret.high_slices);
 	}
 
 	return ret;
@@ -172,8 +183,13 @@ static struct slice_mask slice_mask_for_size(struct mm_struct *mm, int psize)
 
 static int slice_check_fit(struct slice_mask mask, struct slice_mask available)
 {
+	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
+
+	bitmap_and(result, mask.high_slices,
+		   available.high_slices, SLICE_NUM_HIGH);
+
 	return (mask.low_slices & available.low_slices) == mask.low_slices &&
-		(mask.high_slices & available.high_slices) == mask.high_slices;
+		bitmap_equal(result, mask.high_slices, SLICE_NUM_HIGH);
 }
 
 static void slice_flush_segments(void *parm)
@@ -220,7 +236,7 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
 	for (i = 0; i < SLICE_NUM_HIGH; i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
-		if (mask.high_slices & (1ul << i))
+		if (test_bit(i, mask.high_slices))
 			hpsizes[index] = (hpsizes[index] &
 					  ~(0xf << (mask_index * 4))) |
 				(((unsigned long)psize) << (mask_index * 4));
@@ -256,7 +272,7 @@ static bool slice_scan_available(unsigned long addr,
 		slice = GET_HIGH_SLICE_INDEX(addr);
 		*boundary_addr = (slice + end) ?
 			((slice + end) << SLICE_HIGH_SHIFT) : SLICE_LOW_TOP;
-		return !!(available.high_slices & (1ul << slice));
+		return !!test_bit(slice, available.high_slices);
 	}
 }
 
@@ -363,15 +379,24 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 		return slice_find_area_bottomup(mm, len, mask, psize);
 }
 
-#define or_mask(dst, src)	do {			\
-	(dst).low_slices |= (src).low_slices;		\
-	(dst).high_slices |= (src).high_slices;		\
-} while (0)
+static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
+{
+	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
 
-#define andnot_mask(dst, src)	do {			\
-	(dst).low_slices &= ~(src).low_slices;		\
-	(dst).high_slices &= ~(src).high_slices;	\
-} while (0)
+	dst->low_slices |= src->low_slices;
+	bitmap_or(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
+	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
+}
+
+static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *src)
+{
+	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
+
+	dst->low_slices &= ~src->low_slices;
+
+	bitmap_andnot(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
+	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
+}
 
 #ifdef CONFIG_PPC_64K_PAGES
 #define MMU_PAGE_BASE	MMU_PAGE_64K
@@ -383,15 +408,28 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 				      unsigned long flags, unsigned int psize,
 				      int topdown)
 {
-	struct slice_mask mask = {0, 0};
+	struct slice_mask mask;
 	struct slice_mask good_mask;
-	struct slice_mask potential_mask = {0,0} /* silence stupid warning */;
-	struct slice_mask compat_mask = {0, 0};
+	struct slice_mask potential_mask;
+	struct slice_mask compat_mask;
 	int fixed = (flags & MAP_FIXED);
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	struct mm_struct *mm = current->mm;
 	unsigned long newaddr;
 
+	/*
+	 * init different masks
+	 */
+	mask.low_slices = 0;
+	bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
+
+	/* silence stupid warning */;
+	potential_mask.low_slices = 0;
+	bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
+
+	compat_mask.low_slices = 0;
+	bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
+
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
 	VM_BUG_ON(radix_enabled());
@@ -449,7 +487,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	if (psize == MMU_PAGE_64K) {
 		compat_mask = slice_mask_for_size(mm, MMU_PAGE_4K);
 		if (fixed)
-			or_mask(good_mask, compat_mask);
+			slice_or_mask(&good_mask, &compat_mask);
 	}
 #endif
 
@@ -484,7 +522,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * empty and thus can be converted
 	 */
 	potential_mask = slice_mask_for_free(mm);
-	or_mask(potential_mask, good_mask);
+	slice_or_mask(&potential_mask, &good_mask);
 	slice_print_mask(" potential", potential_mask);
 
 	if ((addr != 0 || fixed) && slice_check_fit(mask, potential_mask)) {
@@ -517,7 +555,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 #ifdef CONFIG_PPC_64K_PAGES
 	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
 		/* retry the search with 4k-page slices included */
-		or_mask(potential_mask, compat_mask);
+		slice_or_mask(&potential_mask, &compat_mask);
 		addr = slice_find_area(mm, len, potential_mask, psize,
 				       topdown);
 	}
@@ -531,8 +569,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	slice_print_mask(" mask", mask);
 
  convert:
-	andnot_mask(mask, good_mask);
-	andnot_mask(mask, compat_mask);
+	slice_andnot_mask(&mask, &good_mask);
+	slice_andnot_mask(&mask, &compat_mask);
 	if (mask.low_slices || mask.high_slices) {
 		slice_convert(mm, mask, psize);
 		if (psize > MMU_PAGE_BASE)
@@ -700,7 +738,7 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	if (psize == MMU_PAGE_64K) {
 		struct slice_mask compat_mask;
 		compat_mask = slice_mask_for_size(mm, MMU_PAGE_4K);
-		or_mask(available, compat_mask);
+		slice_or_mask(&available, &compat_mask);
 	}
 #endif
 
-- 
2.7.4
