Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3GB60RbzDqLB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 19/19] powerpc/mm: Enable mappings above 128TB
Date: Thu, 30 Mar 2017 23:04:07 +1100
Message-Id: <1490875447-4016-19-git-send-email-mpe@ellerman.id.au>
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

Not all user space application is ready to handle wide addresses. It's known that
at least some JIT compilers use higher bits in pointers to encode their
information. It collides with valid pointers with 512TB addresses and
leads to crashes.

To mitigate this, we are not going to allocate virtual address space
above 128TB by default.

But userspace can ask for allocation from full address space by
specifying hint address (with or without MAP_FIXED) above 128TB.

If hint address set above 128TB, but MAP_FIXED is not specified, we try
to look for unmapped area by specified address. If it's already
occupied, we look for unmapped area in *full* address space, rather than
from 128TB window.

This approach helps to easily make application's memory allocator aware
about large address space without manually tracking allocated virtual
address space.

This is going to be a per mmap decision. ie, we can have some mmaps with larger
addresses and other that do not.

A sample memory layout looks like below.

10000000-10010000 r-xp 00000000 fc:00 9057045                            /home/max_addr_512TB
10010000-10020000 r--p 00000000 fc:00 9057045                            /home/max_addr_512TB
10020000-10030000 rw-p 00010000 fc:00 9057045                            /home/max_addr_512TB
10029630000-10029660000 rw-p 00000000 00:00 0                            [heap]
7fff834a0000-7fff834b0000 rw-p 00000000 00:00 0
7fff834b0000-7fff83670000 r-xp 00000000 fc:00 9177190                    /lib/powerpc64le-linux-gnu/libc-2.23.so
7fff83670000-7fff83680000 r--p 001b0000 fc:00 9177190                    /lib/powerpc64le-linux-gnu/libc-2.23.so
7fff83680000-7fff83690000 rw-p 001c0000 fc:00 9177190                    /lib/powerpc64le-linux-gnu/libc-2.23.so
7fff83690000-7fff836a0000 rw-p 00000000 00:00 0
7fff836a0000-7fff836c0000 r-xp 00000000 00:00 0                          [vdso]
7fff836c0000-7fff83700000 r-xp 00000000 fc:00 9177193                    /lib/powerpc64le-linux-gnu/ld-2.23.so
7fff83700000-7fff83710000 r--p 00030000 fc:00 9177193                    /lib/powerpc64le-linux-gnu/ld-2.23.so
7fff83710000-7fff83720000 rw-p 00040000 fc:00 9177193                    /lib/powerpc64le-linux-gnu/ld-2.23.so
7fffdccf0000-7fffdcd20000 rw-p 00000000 00:00 0                          [stack]
1000000000000-1000000010000 rw-p 00000000 00:00 0
1ffff83710000-1ffff83720000 rw-p 00000000 00:00 0

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/processor.h | 23 +++++++++++----
 arch/powerpc/mm/hugetlbpage-radix.c  |  7 +++++
 arch/powerpc/mm/mmap.c               | 32 +++++++++++++--------
 arch/powerpc/mm/slice.c              | 54 ++++++++++++++++++++++++++++--------
 4 files changed, 87 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ea4b6c696f1f..a4b1d8d6b793 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -114,9 +114,9 @@ void release_thread(struct task_struct *);
 /*
  * Max value currently used:
  */
-#define TASK_SIZE_USER64 TASK_SIZE_128TB
+#define TASK_SIZE_USER64	TASK_SIZE_512TB
 #else
-#define TASK_SIZE_USER64 TASK_SIZE_64TB
+#define TASK_SIZE_USER64	TASK_SIZE_64TB
 #endif
 
 /*
@@ -128,26 +128,37 @@ void release_thread(struct task_struct *);
 #define TASK_SIZE_OF(tsk) (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
 		TASK_SIZE_USER32 : TASK_SIZE_USER64)
 #define TASK_SIZE	  TASK_SIZE_OF(current)
-
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
 #define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
-#define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(TASK_SIZE_USER64 / 4))
+#define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(TASK_SIZE_128TB / 4))
 
 #define TASK_UNMAPPED_BASE ((is_32bit_task()) ? \
 		TASK_UNMAPPED_BASE_USER32 : TASK_UNMAPPED_BASE_USER64 )
 #endif
 
+/*
+ * Initial task size value for user applications. For book3s 64 we start
+ * with 128TB and conditionally enable upto 512TB
+ */
+#ifdef CONFIG_PPC_BOOK3S_64
+#define DEFAULT_MAP_WINDOW	((is_32bit_task()) ? \
+				 TASK_SIZE_USER32 : TASK_SIZE_128TB)
+#else
+#define DEFAULT_MAP_WINDOW	TASK_SIZE
+#endif
+
 #ifdef __powerpc64__
 
-#define STACK_TOP_USER64 TASK_SIZE_USER64
+/* Limit stack to 128TB */
+#define STACK_TOP_USER64 TASK_SIZE_128TB
 #define STACK_TOP_USER32 TASK_SIZE_USER32
 
 #define STACK_TOP (is_32bit_task() ? \
 		   STACK_TOP_USER32 : STACK_TOP_USER64)
 
-#define STACK_TOP_MAX STACK_TOP_USER64
+#define STACK_TOP_MAX TASK_SIZE_USER64
 
 #else /* __powerpc64__ */
 
diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 95207c117b82..0aa9cade422f 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -50,6 +50,9 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	struct hstate *h = hstate_file(file);
 	struct vm_unmapped_area_info info;
 
+	if (unlikely(addr > mm->context.addr_limit && addr < TASK_SIZE))
+		mm->context.addr_limit = TASK_SIZE;
+
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
 	if (len > mm->context.addr_limit)
@@ -78,5 +81,9 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	info.high_limit = current->mm->mmap_base;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
+
+	if (addr > DEFAULT_MAP_WINDOW)
+		info.high_limit += mm->context.addr_limit - DEFAULT_MAP_WINDOW;
+
 	return vm_unmapped_area(&info);
 }
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index 6e9fead92969..b2111baa0da6 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -79,7 +79,7 @@ static inline unsigned long mmap_base(unsigned long rnd)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return PAGE_ALIGN(TASK_SIZE - gap - rnd);
+	return PAGE_ALIGN(DEFAULT_MAP_WINDOW - gap - rnd);
 }
 
 #ifdef CONFIG_PPC_RADIX_MMU
@@ -97,6 +97,9 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct vm_area_struct *vma;
 	struct vm_unmapped_area_info info;
 
+	if (unlikely(addr > mm->context.addr_limit && addr < TASK_SIZE))
+		mm->context.addr_limit = TASK_SIZE;
+
 	if (len > mm->context.addr_limit - mmap_min_addr)
 		return -ENOMEM;
 
@@ -114,8 +117,13 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.flags = 0;
 	info.length = len;
 	info.low_limit = mm->mmap_base;
-	info.high_limit = mm->context.addr_limit;
 	info.align_mask = 0;
+
+	if (unlikely(addr > DEFAULT_MAP_WINDOW))
+		info.high_limit = mm->context.addr_limit;
+	else
+		info.high_limit = DEFAULT_MAP_WINDOW;
+
 	return vm_unmapped_area(&info);
 }
 
@@ -131,6 +139,9 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info;
 
+	if (unlikely(addr > mm->context.addr_limit && addr < TASK_SIZE))
+		mm->context.addr_limit = TASK_SIZE;
+
 	/* requested length too big for entire address space */
 	if (len > mm->context.addr_limit - mmap_min_addr)
 		return -ENOMEM;
@@ -152,7 +163,14 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
 	info.high_limit = mm->mmap_base;
 	info.align_mask = 0;
+
+	if (addr > DEFAULT_MAP_WINDOW)
+		info.high_limit += mm->context.addr_limit - DEFAULT_MAP_WINDOW;
+
 	addr = vm_unmapped_area(&info);
+	if (!(addr & ~PAGE_MASK))
+		return addr;
+	VM_BUG_ON(addr != -ENOMEM);
 
 	/*
 	 * A failed mmap() very likely causes application failure,
@@ -160,15 +178,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	 * can happen with large stack limits and large mmap()
 	 * allocations.
 	 */
-	if (addr & ~PAGE_MASK) {
-		VM_BUG_ON(addr != -ENOMEM);
-		info.flags = 0;
-		info.low_limit = TASK_UNMAPPED_BASE;
-		info.high_limit = mm->context.addr_limit;
-		addr = vm_unmapped_area(&info);
-	}
-
-	return addr;
+	return radix__arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
 }
 
 static void radix__arch_pick_mmap_layout(struct mm_struct *mm,
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index bf41825054d0..ff82b651d15d 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -265,7 +265,7 @@ static bool slice_scan_available(unsigned long addr,
 static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 					      unsigned long len,
 					      struct slice_mask available,
-					      int psize)
+					      int psize, unsigned long high_limit)
 {
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	unsigned long addr, found, next_end;
@@ -277,7 +277,10 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 	info.align_offset = 0;
 
 	addr = TASK_UNMAPPED_BASE;
-	while (addr < mm->context.addr_limit) {
+	/*
+	 * Check till the allow max value for this mmap request
+	 */
+	while (addr < high_limit) {
 		info.low_limit = addr;
 		if (!slice_scan_available(addr, available, 1, &addr))
 			continue;
@@ -308,7 +311,7 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 					     unsigned long len,
 					     struct slice_mask available,
-					     int psize)
+					     int psize, unsigned long high_limit)
 {
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	unsigned long addr, found, prev;
@@ -320,6 +323,15 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 	info.align_offset = 0;
 
 	addr = mm->mmap_base;
+	/*
+	 * If we are trying to allocate above DEFAULT_MAP_WINDOW
+	 * Add the different to the mmap_base.
+	 * Only for that request for which high_limit is above
+	 * DEFAULT_MAP_WINDOW we should apply this.
+	 */
+	if (high_limit  > DEFAULT_MAP_WINDOW)
+		addr += mm->context.addr_limit - DEFAULT_MAP_WINDOW;
+
 	while (addr > PAGE_SIZE) {
 		info.high_limit = addr;
 		if (!slice_scan_available(addr - 1, available, 0, &addr))
@@ -351,18 +363,18 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 	 * can happen with large stack limits and large mmap()
 	 * allocations.
 	 */
-	return slice_find_area_bottomup(mm, len, available, psize);
+	return slice_find_area_bottomup(mm, len, available, psize, high_limit);
 }
 
 
 static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 				     struct slice_mask mask, int psize,
-				     int topdown)
+				     int topdown, unsigned long high_limit)
 {
 	if (topdown)
-		return slice_find_area_topdown(mm, len, mask, psize);
+		return slice_find_area_topdown(mm, len, mask, psize, high_limit);
 	else
-		return slice_find_area_bottomup(mm, len, mask, psize);
+		return slice_find_area_bottomup(mm, len, mask, psize, high_limit);
 }
 
 static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
@@ -402,8 +414,23 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	struct mm_struct *mm = current->mm;
 	unsigned long newaddr;
+	unsigned long high_limit;
 
 	/*
+	 * Check if we need to expland slice area.
+	 */
+	if (unlikely(addr > mm->context.addr_limit && addr < TASK_SIZE)) {
+		mm->context.addr_limit = TASK_SIZE;
+		on_each_cpu(slice_flush_segments, mm, 1);
+	}
+	/*
+	 * This mmap request can allocate upt to 512TB
+	 */
+	if (addr > DEFAULT_MAP_WINDOW)
+		high_limit = mm->context.addr_limit;
+	else
+		high_limit = DEFAULT_MAP_WINDOW;
+	/*
 	 * init different masks
 	 */
 	mask.low_slices = 0;
@@ -494,7 +521,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		/* Now let's see if we can find something in the existing
 		 * slices for that size
 		 */
-		newaddr = slice_find_area(mm, len, good_mask, psize, topdown);
+		newaddr = slice_find_area(mm, len, good_mask,
+					  psize, topdown, high_limit);
 		if (newaddr != -ENOMEM) {
 			/* Found within the good mask, we don't have to setup,
 			 * we thus return directly
@@ -526,7 +554,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * anywhere in the good area.
 	 */
 	if (addr) {
-		addr = slice_find_area(mm, len, good_mask, psize, topdown);
+		addr = slice_find_area(mm, len, good_mask,
+				       psize, topdown, high_limit);
 		if (addr != -ENOMEM) {
 			slice_dbg(" found area at 0x%lx\n", addr);
 			return addr;
@@ -536,14 +565,15 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/* Now let's see if we can find something in the existing slices
 	 * for that size plus free slices
 	 */
-	addr = slice_find_area(mm, len, potential_mask, psize, topdown);
+	addr = slice_find_area(mm, len, potential_mask,
+			       psize, topdown, high_limit);
 
 #ifdef CONFIG_PPC_64K_PAGES
 	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
 		/* retry the search with 4k-page slices included */
 		slice_or_mask(&potential_mask, &compat_mask);
-		addr = slice_find_area(mm, len, potential_mask, psize,
-				       topdown);
+		addr = slice_find_area(mm, len, potential_mask,
+				       psize, topdown, high_limit);
 	}
 #endif
 
-- 
2.7.4
