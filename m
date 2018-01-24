Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRK1m3ztdzDqrP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 20:02:36 +1100 (AEDT)
Message-Id: <5dfafb3f0e2438e43f44917ffcf70e3daa4f37ee.1516783089.git.christophe.leroy@c-s.fr>
In-Reply-To: <6920f6efe2dcdabf59350b2d31ee6bd4bdef57f4.1516783089.git.christophe.leroy@c-s.fr>
References: <6920f6efe2dcdabf59350b2d31ee6bd4bdef57f4.1516783089.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 4/5] powerpc/mm: Allow up to 64 low slices
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 24 Jan 2018 10:02:32 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While the implementation of the "slices" address space allows
a significant amount of high slices, it limits the number of
low slices to 16 due to the use of a single u64 low_slices_psize
element in struct mm_context_t

On the 8xx, the minimum slice size is the size of the area
covered by a single PMD entry, ie 4M in 4K pages mode and 64M in
16K pages mode. This means we could have at least 64 slices.

In order to override this limitation, this patch switches the
handling of low_slices_psize to char array as done already for
high_slices_psize. This allows to increase the number of low
slices to 64 on the 8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Usign slice_bitmap_xxx() macros instead of bitmap_xxx() functions.
 v3: keep low_slices as a u64, this allows 64 slices which is enough.
 
 arch/powerpc/include/asm/book3s/64/mmu.h |  3 +-
 arch/powerpc/include/asm/mmu-8xx.h       |  7 +++-
 arch/powerpc/include/asm/paca.h          |  2 +-
 arch/powerpc/include/asm/slice.h         |  1 -
 arch/powerpc/include/asm/slice_32.h      |  2 ++
 arch/powerpc/include/asm/slice_64.h      |  2 ++
 arch/powerpc/kernel/paca.c               |  3 +-
 arch/powerpc/mm/hash_utils_64.c          | 13 ++++----
 arch/powerpc/mm/slb_low.S                |  8 +++--
 arch/powerpc/mm/slice.c                  | 57 +++++++++++++++++---------------
 10 files changed, 56 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index c9448e19847a..b076a2d74c69 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -91,7 +91,8 @@ typedef struct {
 	struct npu_context *npu_context;
 
 #ifdef CONFIG_PPC_MM_SLICES
-	u64 low_slices_psize;	/* SLB page size encodings */
+	 /* SLB page size encodings*/
+	unsigned char low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
 	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
 	unsigned long slb_addr_limit;
 #else
diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index 5f89b6010453..5f37ba06b56c 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -164,6 +164,11 @@
  */
 #define SPRN_M_TW	799
 
+#ifdef CONFIG_PPC_MM_SLICES
+#include <asm/slice_32.h>
+#define SLICE_ARRAY_SIZE	(1 << (32 - SLICE_LOW_SHIFT - 1))
+#endif
+
 #ifndef __ASSEMBLY__
 typedef struct {
 	unsigned int id;
@@ -171,7 +176,7 @@ typedef struct {
 	unsigned long vdso_base;
 #ifdef CONFIG_PPC_MM_SLICES
 	u16 user_psize;		/* page size index */
-	u64 low_slices_psize;	/* page size encodings */
+	unsigned char low_slices_psize[SLICE_ARRAY_SIZE];
 	unsigned char high_slices_psize[0];
 	unsigned long slb_addr_limit;
 #endif
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 23ac7fc0af23..a3e531fe9ac7 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -141,7 +141,7 @@ struct paca_struct {
 #ifdef CONFIG_PPC_BOOK3S
 	mm_context_id_t mm_ctx_id;
 #ifdef CONFIG_PPC_MM_SLICES
-	u64 mm_ctx_low_slices_psize;
+	unsigned char mm_ctx_low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
 	unsigned char mm_ctx_high_slices_psize[SLICE_ARRAY_SIZE];
 	unsigned long mm_ctx_slb_addr_limit;
 #else
diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
index 2b4b70de7e71..b67ba8faa507 100644
--- a/arch/powerpc/include/asm/slice.h
+++ b/arch/powerpc/include/asm/slice.h
@@ -16,7 +16,6 @@
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 
-#define SLICE_LOW_SHIFT		28
 #define SLICE_LOW_TOP		(0x100000000ull)
 #define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
 #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
diff --git a/arch/powerpc/include/asm/slice_32.h b/arch/powerpc/include/asm/slice_32.h
index 7e27c0dfb913..349187c20100 100644
--- a/arch/powerpc/include/asm/slice_32.h
+++ b/arch/powerpc/include/asm/slice_32.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_SLICE_32_H
 #define _ASM_POWERPC_SLICE_32_H
 
+#define SLICE_LOW_SHIFT		26	/* 64 slices */
+
 #define SLICE_HIGH_SHIFT	0
 #define SLICE_NUM_HIGH		0ul
 #define GET_HIGH_SLICE_INDEX(addr)	(addr & 0)
diff --git a/arch/powerpc/include/asm/slice_64.h b/arch/powerpc/include/asm/slice_64.h
index 9d1c97b83010..0959475239c6 100644
--- a/arch/powerpc/include/asm/slice_64.h
+++ b/arch/powerpc/include/asm/slice_64.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_SLICE_64_H
 #define _ASM_POWERPC_SLICE_64_H
 
+#define SLICE_LOW_SHIFT		28
+
 #define SLICE_HIGH_SHIFT	40
 #define SLICE_NUM_HIGH		(H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index d6597038931d..8e1566bf82b8 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -264,7 +264,8 @@ void copy_mm_to_paca(struct mm_struct *mm)
 #ifdef CONFIG_PPC_MM_SLICES
 	VM_BUG_ON(!mm->context.slb_addr_limit);
 	get_paca()->mm_ctx_slb_addr_limit = mm->context.slb_addr_limit;
-	get_paca()->mm_ctx_low_slices_psize = context->low_slices_psize;
+	memcpy(&get_paca()->mm_ctx_low_slices_psize,
+	       &context->low_slices_psize, sizeof(context->low_slices_psize));
 	memcpy(&get_paca()->mm_ctx_high_slices_psize,
 	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
 #else /* CONFIG_PPC_MM_SLICES */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 655a5a9a183d..da696565b969 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1097,19 +1097,18 @@ unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
 #ifdef CONFIG_PPC_MM_SLICES
 static unsigned int get_paca_psize(unsigned long addr)
 {
-	u64 lpsizes;
-	unsigned char *hpsizes;
+	unsigned char *psizes;
 	unsigned long index, mask_index;
 
 	if (addr < SLICE_LOW_TOP) {
-		lpsizes = get_paca()->mm_ctx_low_slices_psize;
+		psizes = get_paca()->mm_ctx_low_slices_psize;
 		index = GET_LOW_SLICE_INDEX(addr);
-		return (lpsizes >> (index * 4)) & 0xF;
+	} else {
+		psizes = get_paca()->mm_ctx_high_slices_psize;
+		index = GET_HIGH_SLICE_INDEX(addr);
 	}
-	hpsizes = get_paca()->mm_ctx_high_slices_psize;
-	index = GET_HIGH_SLICE_INDEX(addr);
 	mask_index = index & 0x1;
-	return (hpsizes[index >> 1] >> (mask_index * 4)) & 0xF;
+	return (psizes[index >> 1] >> (mask_index * 4)) & 0xF;
 }
 
 #else
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 2cf5ef3fc50d..2c7c717fd2ea 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -200,10 +200,12 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 5:
 	/*
 	 * Handle lpsizes
-	 * r9 is get_paca()->context.low_slices_psize, r11 is index
+	 * r9 is get_paca()->context.low_slices_psize[index], r11 is mask_index
 	 */
-	ld	r9,PACALOWSLICESPSIZE(r13)
-	mr	r11,r10
+	srdi    r11,r10,1 /* index */
+	addi	r9,r11,PACALOWSLICESPSIZE
+	lbzx	r9,r13,r9		/* r9 is lpsizes[r11] */
+	rldicl	r11,r10,0,63		/* r11 = r10 & 0x1 */
 6:
 	sldi	r11,r11,2  /* index * 4 */
 	/* Extract the psize and multiply to get an array offset */
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 549704dfa777..3d573a038d42 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -148,18 +148,20 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
 static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_mask *ret,
 				unsigned long high_limit)
 {
-	unsigned char *hpsizes;
+	unsigned char *hpsizes, *lpsizes;
 	int index, mask_index;
 	unsigned long i;
-	u64 lpsizes;
 
 	ret->low_slices = 0;
 	slice_bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
 	lpsizes = mm->context.low_slices_psize;
-	for (i = 0; i < SLICE_NUM_LOW; i++)
-		if (((lpsizes >> (i * 4)) & 0xf) == psize)
+	for (i = 0; i < SLICE_NUM_LOW; i++) {
+		mask_index = i & 0x1;
+		index = i >> 1;
+		if (((lpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
 			ret->low_slices |= 1u << i;
+	}
 
 	if (high_limit <= SLICE_LOW_TOP)
 		return;
@@ -211,8 +213,7 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
 {
 	int index, mask_index;
 	/* Write the new slice psize bits */
-	unsigned char *hpsizes;
-	u64 lpsizes;
+	unsigned char *hpsizes, *lpsizes;
 	unsigned long i, flags;
 
 	slice_dbg("slice_convert(mm=%p, psize=%d)\n", mm, psize);
@@ -225,12 +226,13 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
 
 	lpsizes = mm->context.low_slices_psize;
 	for (i = 0; i < SLICE_NUM_LOW; i++)
-		if (mask.low_slices & (1u << i))
-			lpsizes = (lpsizes & ~(0xful << (i * 4))) |
-				(((unsigned long)psize) << (i * 4));
-
-	/* Assign the value back */
-	mm->context.low_slices_psize = lpsizes;
+		if (mask.low_slices & (1u << i)) {
+			mask_index = i & 0x1;
+			index = i >> 1;
+			lpsizes[index] = (lpsizes[index] &
+					  ~(0xf << (mask_index * 4))) |
+				(((unsigned long)psize) << (mask_index * 4));
+		}
 
 	hpsizes = mm->context.high_slices_psize;
 	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
@@ -629,7 +631,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 
 unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
 {
-	unsigned char *hpsizes;
+	unsigned char *psizes;
 	int index, mask_index;
 
 	/*
@@ -643,15 +645,14 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
 #endif
 	}
 	if (addr < SLICE_LOW_TOP) {
-		u64 lpsizes;
-		lpsizes = mm->context.low_slices_psize;
+		psizes = mm->context.low_slices_psize;
 		index = GET_LOW_SLICE_INDEX(addr);
-		return (lpsizes >> (index * 4)) & 0xf;
+	} else {
+		psizes = mm->context.high_slices_psize;
+		index = GET_HIGH_SLICE_INDEX(addr);
 	}
-	hpsizes = mm->context.high_slices_psize;
-	index = GET_HIGH_SLICE_INDEX(addr);
 	mask_index = index & 0x1;
-	return (hpsizes[index >> 1] >> (mask_index * 4)) & 0xf;
+	return (psizes[index >> 1] >> (mask_index * 4)) & 0xf;
 }
 EXPORT_SYMBOL_GPL(get_slice_psize);
 
@@ -672,8 +673,8 @@ EXPORT_SYMBOL_GPL(get_slice_psize);
 void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 {
 	int index, mask_index;
-	unsigned char *hpsizes;
-	unsigned long flags, lpsizes;
+	unsigned char *hpsizes, *lpsizes;
+	unsigned long flags;
 	unsigned int old_psize;
 	int i;
 
@@ -691,12 +692,14 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 	wmb();
 
 	lpsizes = mm->context.low_slices_psize;
-	for (i = 0; i < SLICE_NUM_LOW; i++)
-		if (((lpsizes >> (i * 4)) & 0xf) == old_psize)
-			lpsizes = (lpsizes & ~(0xful << (i * 4))) |
-				(((unsigned long)psize) << (i * 4));
-	/* Assign the value back */
-	mm->context.low_slices_psize = lpsizes;
+	for (i = 0; i < SLICE_NUM_LOW; i++) {
+		mask_index = i & 0x1;
+		index = i >> 1;
+		if (((lpsizes[index] >> (mask_index * 4)) & 0xf) == old_psize)
+			lpsizes[index] = (lpsizes[index] &
+					  ~(0xf << (mask_index * 4))) |
+				(((unsigned long)psize) << (mask_index * 4));
+	}
 
 	hpsizes = mm->context.high_slices_psize;
 	for (i = 0; i < SLICE_NUM_HIGH; i++) {
-- 
2.13.3
