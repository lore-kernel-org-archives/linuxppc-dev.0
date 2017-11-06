Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVp6r0FD7zDrJs
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:03:47 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id g6so7815755pgn.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 02:03:47 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH 5/5] powerpc/64s: mm_context.addr_limit is only used on hash
Date: Mon,  6 Nov 2017 21:03:15 +1100
Message-Id: <20171106100315.29720-6-npiggin@gmail.com>
In-Reply-To: <20171106100315.29720-1-npiggin@gmail.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Radix keeps no meaningful state in addr_limit, so remove it from
radix code and rename to slb_addr_limit to make it clear it applies
to hash only.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
 arch/powerpc/include/asm/book3s/64/mmu.h      |  2 +-
 arch/powerpc/include/asm/paca.h               |  2 +-
 arch/powerpc/kernel/asm-offsets.c             |  2 +-
 arch/powerpc/kernel/paca.c                    |  4 ++--
 arch/powerpc/kernel/setup-common.c            |  3 ++-
 arch/powerpc/mm/hugetlbpage-radix.c           |  3 ---
 arch/powerpc/mm/mmap.c                        |  8 -------
 arch/powerpc/mm/mmu_context_book3s64.c        |  4 ++--
 arch/powerpc/mm/slb_low.S                     |  2 +-
 arch/powerpc/mm/slice.c                       | 34 +++++++++++++--------------
 11 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 508275bb05d5..e91e115a816f 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -606,7 +606,7 @@ extern void slb_set_size(u16 size);
 
 /* 4 bits per slice and we have one slice per 1TB */
 #define SLICE_ARRAY_SIZE	(H_PGTABLE_RANGE >> 41)
-#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.addr_limit >> 41)
+#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.slb_addr_limit >> 41)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index c3b00e8ff791..49a07c5d9e50 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -92,7 +92,7 @@ typedef struct {
 #ifdef CONFIG_PPC_MM_SLICES
 	u64 low_slices_psize;	/* SLB page size encodings */
 	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
-	unsigned long addr_limit;
+	unsigned long slb_addr_limit;
 #else
 	u16 sllp;		/* SLB page size encoding */
 #endif
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 7125efa6a6ae..2ef0c0da4bb7 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -143,7 +143,7 @@ struct paca_struct {
 #ifdef CONFIG_PPC_MM_SLICES
 	u64 mm_ctx_low_slices_psize;
 	unsigned char mm_ctx_high_slices_psize[SLICE_ARRAY_SIZE];
-	unsigned long addr_limit;
+	unsigned long mm_ctx_slb_addr_limit;
 #else
 	u16 mm_ctx_user_psize;
 	u16 mm_ctx_sllp;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 96c52235ecdc..912880873dfc 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -185,7 +185,7 @@ int main(void)
 #ifdef CONFIG_PPC_MM_SLICES
 	OFFSET(PACALOWSLICESPSIZE, paca_struct, mm_ctx_low_slices_psize);
 	OFFSET(PACAHIGHSLICEPSIZE, paca_struct, mm_ctx_high_slices_psize);
-	DEFINE(PACA_ADDR_LIMIT, offsetof(struct paca_struct, addr_limit));
+	OFFSET(PACA_SLB_ADDR_LIMIT, paca_struct, mm_ctx_slb_addr_limit);
 	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
 #endif /* CONFIG_PPC_MM_SLICES */
 #endif
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 2ff2b8a19f71..4c69d335863c 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -262,8 +262,8 @@ void copy_mm_to_paca(struct mm_struct *mm)
 
 	get_paca()->mm_ctx_id = context->id;
 #ifdef CONFIG_PPC_MM_SLICES
-	VM_BUG_ON(!mm->context.addr_limit);
-	get_paca()->addr_limit = mm->context.addr_limit;
+	VM_BUG_ON(!mm->context.slb_addr_limit);
+	get_paca()->mm_ctx_slb_addr_limit = mm->context.slb_addr_limit;
 	get_paca()->mm_ctx_low_slices_psize = context->low_slices_psize;
 	memcpy(&get_paca()->mm_ctx_high_slices_psize,
 	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2e3bc16d02b2..8c4fa6086b39 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -898,7 +898,8 @@ void __init setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_PPC_MM_SLICES
 #ifdef CONFIG_PPC64
-	init_mm.context.addr_limit = DEFAULT_MAP_WINDOW_USER64;
+	if (!radix_enabled())
+		init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
 #else
 #error	"context.addr_limit not initialized."
 #endif
diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 9c6a411e9c85..0f69bdf33367 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -51,9 +51,6 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	unsigned long high_limit = DEFAULT_MAP_WINDOW;
 	struct vm_unmapped_area_info info;
 
-	if (unlikely(addr > mm->context.addr_limit && addr < TASK_SIZE))
-		mm->context.addr_limit = TASK_SIZE;
-
 	if (addr > high_limit)
 		high_limit = TASK_SIZE;
 
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index e6cb3b3f7e93..62c1191670b0 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -109,10 +109,6 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	unsigned long high_limit = DEFAULT_MAP_WINDOW;
 	struct vm_unmapped_area_info info;
 
-	if (unlikely(addr > mm->context.addr_limit &&
-		     mm->context.addr_limit != TASK_SIZE))
-		mm->context.addr_limit = TASK_SIZE;
-
 	if (addr > high_limit)
 		high_limit = TASK_SIZE;
 
@@ -152,10 +148,6 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	unsigned long high_limit = DEFAULT_MAP_WINDOW;
 	struct vm_unmapped_area_info info;
 
-	if (unlikely(addr > mm->context.addr_limit &&
-		     mm->context.addr_limit != TASK_SIZE))
-		mm->context.addr_limit = TASK_SIZE;
-
 	if (addr > high_limit)
 		high_limit = TASK_SIZE;
 
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index b94fb62e60fd..995c98f3f392 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -96,8 +96,8 @@ static int hash__init_new_context(struct mm_struct *mm)
 	 * In the case of exec, use the default limit,
 	 * otherwise inherit it from the mm we are duplicating.
 	 */
-	if (!mm->context.addr_limit)
-		mm->context.addr_limit = DEFAULT_MAP_WINDOW_USER64;
+	if (!mm->context.slb_addr_limit)
+		mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
 
 	/*
 	 * The old code would re-promote on fork, we don't do that when using
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 906a86fe457b..7046bb389704 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -167,7 +167,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
         /*
          * user space make sure we are within the allowed limit
 	 */
-	ld	r11,PACA_ADDR_LIMIT(r13)
+	ld	r11,PACA_SLB_ADDR_LIMIT(r13)
 	cmpld	r3,r11
 	bge-	8f
 
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index f980397b449d..4933d5c71d57 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -96,7 +96,7 @@ static int slice_area_is_free(struct mm_struct *mm, unsigned long addr,
 {
 	struct vm_area_struct *vma;
 
-	if ((mm->context.addr_limit - len) < addr)
+	if ((mm->context.slb_addr_limit - len) < addr)
 		return 0;
 	vma = find_vma(mm, addr);
 	return (!vma || (addr + len) <= vm_start_gap(vma));
@@ -133,10 +133,10 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret)
 		if (!slice_low_has_vma(mm, i))
 			ret->low_slices |= 1u << i;
 
-	if (mm->context.addr_limit <= SLICE_LOW_TOP)
+	if (mm->context.slb_addr_limit <= SLICE_LOW_TOP)
 		return;
 
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.addr_limit); i++)
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++)
 		if (!slice_high_has_vma(mm, i))
 			__set_bit(i, ret->high_slices);
 }
@@ -157,7 +157,7 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
 			ret->low_slices |= 1u << i;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.addr_limit); i++) {
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
@@ -169,7 +169,7 @@ static int slice_check_fit(struct mm_struct *mm,
 			   struct slice_mask mask, struct slice_mask available)
 {
 	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
-	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.addr_limit);
+	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
 
 	bitmap_and(result, mask.high_slices,
 		   available.high_slices, slice_count);
@@ -219,7 +219,7 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
 	mm->context.low_slices_psize = lpsizes;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.addr_limit); i++) {
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (test_bit(i, mask.high_slices))
@@ -329,8 +329,8 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 	 * Only for that request for which high_limit is above
 	 * DEFAULT_MAP_WINDOW we should apply this.
 	 */
-	if (high_limit  > DEFAULT_MAP_WINDOW)
-		addr += mm->context.addr_limit - DEFAULT_MAP_WINDOW;
+	if (high_limit > DEFAULT_MAP_WINDOW)
+		addr += mm->context.slb_addr_limit - DEFAULT_MAP_WINDOW;
 
 	while (addr > PAGE_SIZE) {
 		info.high_limit = addr;
@@ -419,17 +419,17 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/*
 	 * Check if we need to expland slice area.
 	 */
-	if (unlikely(((addr > mm->context.addr_limit) ||
-			(fixed && addr + len > mm->context.addr_limit)) &&
-		     mm->context.addr_limit != TASK_SIZE)) {
-		mm->context.addr_limit = TASK_SIZE;
+	if (unlikely(((addr > mm->context.slb_addr_limit) ||
+			(fixed && addr + len > mm->context.slb_addr_limit)) &&
+		     mm->context.slb_addr_limit != TASK_SIZE)) {
+		mm->context.slb_addr_limit = TASK_SIZE;
 		on_each_cpu(slice_flush_segments, mm, 1);
 	}
 	/*
 	 * This mmap request can allocate upt to 512TB
 	 */
 	if (addr > DEFAULT_MAP_WINDOW)
-		high_limit = mm->context.addr_limit;
+		high_limit = mm->context.slb_addr_limit;
 	else
 		high_limit = DEFAULT_MAP_WINDOW;
 	/*
@@ -447,20 +447,20 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
-	BUG_ON(mm->context.addr_limit == 0);
+	BUG_ON(mm->context.slb_addr_limit == 0);
 	VM_BUG_ON(radix_enabled());
 
 	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
 	slice_dbg(" addr=%lx, len=%lx, flags=%lx, topdown=%d\n",
 		  addr, len, flags, topdown);
 
-	if (len > mm->context.addr_limit)
+	if (len > mm->context.slb_addr_limit)
 		return -ENOMEM;
 	if (len & ((1ul << pshift) - 1))
 		return -EINVAL;
 	if (fixed && (addr & ((1ul << pshift) - 1)))
 		return -EINVAL;
-	if (fixed && addr > (mm->context.addr_limit - len))
+	if (fixed && addr > (mm->context.slb_addr_limit - len))
 		return -ENOMEM;
 
 	/* If hint, make sure it matches our alignment restrictions */
@@ -468,7 +468,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		addr = _ALIGN_UP(addr, 1ul << pshift);
 		slice_dbg(" aligned addr=%lx\n", addr);
 		/* Ignore hint if it's too large or overlaps a VMA */
-		if (addr > mm->context.addr_limit - len ||
+		if (addr > mm->context.slb_addr_limit - len ||
 		    !slice_area_is_free(mm, addr, len))
 			addr = 0;
 	}
-- 
2.15.0
