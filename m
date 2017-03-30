Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3G742JSzDqLk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 15/19] powerpc/mm: Add addr_limit to mm_context and use it
 to derive max slice index
Date: Thu, 30 Mar 2017 23:04:03 +1100
Message-Id: <1490875447-4016-15-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

In the followup patch, we will increase the slice array size to handle
512TB range, but will limit the max addr to 128TB. Avoid doing
unnecessary computation and avoid doing slice mask related operation
above address limit.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  3 ++-
 arch/powerpc/include/asm/book3s/64/mmu.h      |  1 +
 arch/powerpc/kernel/paca.c                    |  3 ++-
 arch/powerpc/kernel/setup-common.c            |  9 +++++++++
 arch/powerpc/mm/mmu_context_book3s64.c        |  7 +++++++
 arch/powerpc/mm/slice.c                       | 22 ++++++++++++----------
 6 files changed, 33 insertions(+), 12 deletions(-)

v6: Instead of using mm->task_size, add a addr_limit to the mm_context_t. This
has the advantage of making the series not depend on generic changes. Hopefully
it also makes it clearer that the value is not exactly equivalent to TASK_SIZE,
it's just the limit of currently used addresses, which may change in future.

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index c93450bf306f..5961b0d65a79 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -597,7 +597,8 @@ extern void slb_set_size(u16 size);
 #define USER_VSID_RANGE	(1UL << (ESID_BITS + SID_SHIFT))
 
 /* 4 bits per slice and we have one slice per 1TB */
-#define SLICE_ARRAY_SIZE  (H_PGTABLE_RANGE >> 41)
+#define SLICE_ARRAY_SIZE	(H_PGTABLE_RANGE >> 41)
+#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.addr_limit >> 41)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index cce434e7de06..c4b865112d24 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -82,6 +82,7 @@ typedef struct {
 #ifdef CONFIG_PPC_MM_SLICES
 	u64 low_slices_psize;	/* SLB page size encodings */
 	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
+	unsigned long addr_limit;
 #else
 	u16 sllp;		/* SLB page size encoding */
 #endif
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index e2cf745a4b94..a2c7a6456ee6 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -253,9 +253,10 @@ void copy_mm_to_paca(struct mm_struct *mm)
 
 	get_paca()->mm_ctx_id = context->id;
 #ifdef CONFIG_PPC_MM_SLICES
+	VM_BUG_ON(!mm->context.addr_limit);
 	get_paca()->mm_ctx_low_slices_psize = context->low_slices_psize;
 	memcpy(&get_paca()->mm_ctx_high_slices_psize,
-	       &context->high_slices_psize, SLICE_ARRAY_SIZE);
+	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
 #else /* CONFIG_PPC_MM_SLICES */
 	get_paca()->mm_ctx_user_psize = context->user_psize;
 	get_paca()->mm_ctx_sllp = context->sllp;
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 4697da895133..a79db6b63466 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -920,6 +920,15 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;
+
+#ifdef CONFIG_PPC_MM_SLICES
+#ifdef CONFIG_PPC64
+	init_mm.context.addr_limit = TASK_SIZE_USER64;
+#else
+#error	"context.addr_limit not initialized."
+#endif
+#endif
+
 #ifdef CONFIG_PPC_64K_PAGES
 	init_mm.context.pte_frag = NULL;
 #endif
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index e5fde156e11d..fd0bc6db2dcd 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -79,6 +79,13 @@ static int hash__init_new_context(struct mm_struct *mm)
 		return index;
 
 	/*
+	 * We do switch_slb() early in fork, even before we setup the
+	 * mm->context.addr_limit. Default to max task size so that we copy the
+	 * default values to paca which will help us to handle slb miss early.
+	 */
+	mm->context.addr_limit = TASK_SIZE_USER64;
+
+	/*
 	 * The old code would re-promote on fork, we don't do that when using
 	 * slices as it could cause problem promoting slices that have been
 	 * forced down to 4K.
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 95e5a20b1b6a..a79a20d4cf99 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -136,7 +136,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret)
 	if (mm->task_size <= SLICE_LOW_TOP)
 		return;
 
-	for (i = 0; i < SLICE_NUM_HIGH; i++)
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.addr_limit); i++)
 		if (!slice_high_has_vma(mm, i))
 			__set_bit(i, ret->high_slices);
 }
@@ -157,7 +157,7 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
 			ret->low_slices |= 1u << i;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < SLICE_NUM_HIGH; i++) {
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.addr_limit); i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
@@ -165,15 +165,17 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
 	}
 }
 
-static int slice_check_fit(struct slice_mask mask, struct slice_mask available)
+static int slice_check_fit(struct mm_struct *mm,
+			   struct slice_mask mask, struct slice_mask available)
 {
 	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
+	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.addr_limit);
 
 	bitmap_and(result, mask.high_slices,
-		   available.high_slices, SLICE_NUM_HIGH);
+		   available.high_slices, slice_count);
 
 	return (mask.low_slices & available.low_slices) == mask.low_slices &&
-		bitmap_equal(result, mask.high_slices, SLICE_NUM_HIGH);
+		bitmap_equal(result, mask.high_slices, slice_count);
 }
 
 static void slice_flush_segments(void *parm)
@@ -217,7 +219,7 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
 	mm->context.low_slices_psize = lpsizes;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < SLICE_NUM_HIGH; i++) {
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.addr_limit); i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (test_bit(i, mask.high_slices))
@@ -484,7 +486,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		/* Check if we fit in the good mask. If we do, we just return,
 		 * nothing else to do
 		 */
-		if (slice_check_fit(mask, good_mask)) {
+		if (slice_check_fit(mm, mask, good_mask)) {
 			slice_dbg(" fits good !\n");
 			return addr;
 		}
@@ -509,7 +511,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	slice_or_mask(&potential_mask, &good_mask);
 	slice_print_mask(" potential", potential_mask);
 
-	if ((addr != 0 || fixed) && slice_check_fit(mask, potential_mask)) {
+	if ((addr != 0 || fixed) && slice_check_fit(mm, mask, potential_mask)) {
 		slice_dbg(" fits potential !\n");
 		goto convert;
 	}
@@ -657,7 +659,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 	mm->context.low_slices_psize = lpsizes;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < SLICE_NUM_HIGH; i++) {
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.addr_limit); i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == old_psize)
@@ -734,6 +736,6 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	slice_print_mask(" mask", mask);
 	slice_print_mask(" available", available);
 #endif
-	return !slice_check_fit(mask, available);
+	return !slice_check_fit(mm, mask, available);
 }
 #endif
-- 
2.7.4
