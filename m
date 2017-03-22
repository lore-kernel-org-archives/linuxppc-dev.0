Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwPV5fjpzDqZb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:38:06 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M3TFKC103192
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:38:04 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vmae1b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:38:04 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 21:38:03 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 12/17] powerpc/mm/slice: Use mm task_size as max value of
 slice index
Date: Wed, 22 Mar 2017 09:06:58 +0530
In-Reply-To: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1490153823-29241-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the followup patch, we will increase the slice array size to handle 512TB
range, but will limit the task size to 128TB. Avoid doing uncessary computation
and avoid doing slice mask related operation above task_size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  3 ++-
 arch/powerpc/kernel/paca.c                    |  3 ++-
 arch/powerpc/kernel/setup-common.c            |  9 +++++++++
 arch/powerpc/mm/mmu_context_book3s64.c        |  8 ++++++++
 arch/powerpc/mm/slice.c                       | 22 ++++++++++++----------
 5 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 73f34a98ce99..c99ea6bbd82c 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -586,7 +586,8 @@ extern void slb_set_size(u16 size);
 #define USER_VSID_RANGE	(1UL << (ESID_BITS + SID_SHIFT))
 
 /* 4 bits per slice and we have one slice per 1TB */
-#define SLICE_ARRAY_SIZE  (H_PGTABLE_RANGE >> 41)
+#define SLICE_ARRAY_SIZE	(H_PGTABLE_RANGE >> 41)
+#define TASK_SLICE_ARRAY_SZ(x)	((x)->task_size >> 41)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index e2cf745a4b94..bffdbd6d6774 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -253,9 +253,10 @@ void copy_mm_to_paca(struct mm_struct *mm)
 
 	get_paca()->mm_ctx_id = context->id;
 #ifdef CONFIG_PPC_MM_SLICES
+	VM_BUG_ON(!mm->task_size);
 	get_paca()->mm_ctx_low_slices_psize = context->low_slices_psize;
 	memcpy(&get_paca()->mm_ctx_high_slices_psize,
-	       &context->high_slices_psize, SLICE_ARRAY_SIZE);
+	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
 #else /* CONFIG_PPC_MM_SLICES */
 	get_paca()->mm_ctx_user_psize = context->user_psize;
 	get_paca()->mm_ctx_sllp = context->sllp;
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 4697da895133..aaf1e2befbcb 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -920,6 +920,15 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;
+
+#ifdef CONFIG_PPC_MM_SLICES
+#ifdef CONFIG_PPC64
+	init_mm.task_size = TASK_SIZE_USER64;
+#else
+#error	"task_size not initialized."
+#endif
+#endif
+
 #ifdef CONFIG_PPC_64K_PAGES
 	init_mm.context.pte_frag = NULL;
 #endif
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index e6a5bcbf8abe..9ab6cd2923be 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -86,6 +86,14 @@ static int hash__init_new_context(struct mm_struct *mm)
 	 * We should not be calling init_new_context() on init_mm. Hence a
 	 * check against 0 is ok.
 	 */
+#ifdef CONFIG_PPC_MM_SLICES
+	/*
+	 * We do switch_slb early in fork, even before we setup the mm->task_size.
+	 * Default to max task size so that we copy the default values to paca
+	 * which will help us to handle slb miss early.
+	 */
+	mm->task_size = TASK_SIZE_USER64;
+#endif
 	if (mm->context.id == 0)
 		slice_set_user_psize(mm, mmu_virtual_psize);
 	subpage_prot_init_new_context(mm);
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index ee3cfc5d9bbc..217638846053 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -136,7 +136,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret)
 	if (mm->task_size <= SLICE_LOW_TOP)
 		return;
 
-	for (i = 0; i < SLICE_NUM_HIGH; i++)
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->task_size); i++)
 		if (!slice_high_has_vma(mm, i))
 			__set_bit(i, ret->high_slices);
 }
@@ -157,7 +157,7 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
 			ret->low_slices |= 1u << i;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < SLICE_NUM_HIGH; i++) {
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->task_size); i++) {
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
+	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->task_size);
 
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
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->task_size); i++) {
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
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->task_size); i++) {
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
