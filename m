Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 08 May 2007 16:27:27 +1000
Subject: [PATCH 2/5] powerpc: Introduce address space "slices"
In-Reply-To: <1178605646.637780.625211974455.qpush@grosgo>
Message-Id: <20070508062748.AC87DDDEC7@ozlabs.org>
Cc: Hugh Dickins <hugh@veritas.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The basic issue is to be able to do what hugetlbfs does but with
different page sizes for some other special filesystems, more
specifically, my need is:

 - Huge pages

 - SPE local store mappings using 64K pages on a 4K base page size
kernel on Cell

 - Some special 4K segments in 64K pages kernels for mapping a dodgy
specie of powerpc specific infiniband hardware that requires 4K MMU
mappings for various reasons I won't explain here.

The main issues are:

 - To maintain/keep track of the page size per "segments" (as we can
only have one page size per segment on powerpc, which are 256MB
divisions of the address space).

 - To make sure special mappings stay within their alloted
"segments" (including MAP_FIXED crap)

 - To make sure everybody else doesn't mmap/brk/grow_stack into a
"segment" that is used for a special mapping

Some of the necessary mecanisms to handle that were present in the
hugetlbfs code, but mostly in ways not suitable for anything else.

The patch relies on some changes to the generic get_unmapped_area()
that just got merged. It still hijacks hugetlb callbacks here or
there as the generic code hasn't been entirely cleaned up yet but
that shouldn't be a problem. 

So what is a slice ? Well, I re-used the mecanism used formerly by our
hugetlbfs implementation which divides the address space in
"meta-segments" which I called "slices". The division is done using
256MB slices below 4G, and 1T slices above. Thus the address space is
divided currently into 16 "low" slices and 16 "high" slices. (Special
case: high slice 0 is the area between 4G and 1T).

Doing so simplifies significantly the tracking of segments and avoid
having to keep track of all the 256MB segments in the address space.

While I used the "concepts" of hugetlbfs, I mostly re-implemented
everything in a more generic way and "ported" hugetlbfs to it. 

slices can have an associated page size, which is encoded in the mmu
context and used by the SLB miss handler to set the segment sizes. The
hash code currently doesn't care, it has a specific check for hugepages,
though I might add a mecanism to provide per-slice hash mapping
functions in the future.

The slice code provide a pair of "generic" get_unmapped_area() (bottomup
and topdown) functions that should work with any slice size. There is
some trickyness here so I would appreciate people to have a look at the
implementation of these and let me know if I got something wrong.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/Kconfig                   |    5 
 arch/powerpc/kernel/asm-offsets.c      |   16 
 arch/powerpc/mm/Makefile               |    1 
 arch/powerpc/mm/hash_utils_64.c        |   20 -
 arch/powerpc/mm/hugetlbpage.c          |  548 ----------------------------
 arch/powerpc/mm/mmu_context_64.c       |   10 
 arch/powerpc/mm/slb.c                  |   11 
 arch/powerpc/mm/slb_low.S              |   54 +-
 arch/powerpc/mm/slice.c                |  633 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/spu_base.c |    9 
 include/asm-powerpc/mmu-hash64.h       |   11 
 include/asm-powerpc/paca.h             |    2 
 include/asm-powerpc/page_64.h          |   88 ++--
 13 files changed, 771 insertions(+), 637 deletions(-)

Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2007-05-08 15:27:05.000000000 +1000
+++ linux-cell/arch/powerpc/Kconfig	2007-05-08 15:27:52.000000000 +1000
@@ -338,6 +338,11 @@ config PPC_STD_MMU_32
 	def_bool y
 	depends on PPC_STD_MMU && PPC32
 
+config PPC_MM_SLICES
+	bool
+	default y if HUGETLB_PAGE
+	default n
+
 config VIRT_CPU_ACCOUNTING
 	bool "Deterministic task and CPU time accounting"
 	depends on PPC64
Index: linux-cell/include/asm-powerpc/paca.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/paca.h	2007-05-08 15:27:05.000000000 +1000
+++ linux-cell/include/asm-powerpc/paca.h	2007-05-08 15:27:52.000000000 +1000
@@ -83,8 +83,8 @@ struct paca_struct {
 
 	mm_context_t context;
 	u16 vmalloc_sllp;
-	u16 slb_cache[SLB_CACHE_ENTRIES];
 	u16 slb_cache_ptr;
+	u16 slb_cache[SLB_CACHE_ENTRIES];
 
 	/*
 	 * then miscellaneous read-write fields
Index: linux-cell/include/asm-powerpc/page_64.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/page_64.h	2007-05-08 15:27:05.000000000 +1000
+++ linux-cell/include/asm-powerpc/page_64.h	2007-05-08 15:27:52.000000000 +1000
@@ -88,57 +88,55 @@ extern unsigned int HPAGE_SHIFT;
 
 #endif /* __ASSEMBLY__ */
 
-#ifdef CONFIG_HUGETLB_PAGE
+#ifdef CONFIG_PPC_MM_SLICES
 
-#define HTLB_AREA_SHIFT		40
-#define HTLB_AREA_SIZE		(1UL << HTLB_AREA_SHIFT)
-#define GET_HTLB_AREA(x)	((x) >> HTLB_AREA_SHIFT)
-
-#define LOW_ESID_MASK(addr, len)    \
-	(((1U << (GET_ESID(min((addr)+(len)-1, 0x100000000UL))+1)) \
-	  - (1U << GET_ESID(min((addr), 0x100000000UL)))) & 0xffff)
-#define HTLB_AREA_MASK(addr, len)   (((1U << (GET_HTLB_AREA(addr+len-1)+1)) \
-		                      - (1U << GET_HTLB_AREA(addr))) & 0xffff)
+#define SLICE_LOW_SHIFT		28
+#define SLICE_HIGH_SHIFT	40
 
-#define ARCH_HAS_HUGEPAGE_ONLY_RANGE
-#define ARCH_HAS_HUGETLB_FREE_PGD_RANGE
-#define ARCH_HAS_PREPARE_HUGEPAGE_RANGE
-#define ARCH_HAS_SETCLEAR_HUGE_PTE
+#define SLICE_LOW_TOP		(0x100000000ul)
+#define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
+#define SLICE_NUM_HIGH		(PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
 
-#define touches_hugepage_low_range(mm, addr, len) \
-	(((addr) < 0x100000000UL) \
-	 && (LOW_ESID_MASK((addr), (len)) & (mm)->context.low_htlb_areas))
-#define touches_hugepage_high_range(mm, addr, len) \
-	((((addr) + (len)) > 0x100000000UL) \
-	  && (HTLB_AREA_MASK((addr), (len)) & (mm)->context.high_htlb_areas))
-
-#define __within_hugepage_low_range(addr, len, segmask) \
-	( (((addr)+(len)) <= 0x100000000UL) \
-	  && ((LOW_ESID_MASK((addr), (len)) | (segmask)) == (segmask)))
-#define within_hugepage_low_range(addr, len) \
-	__within_hugepage_low_range((addr), (len), \
-				    current->mm->context.low_htlb_areas)
-#define __within_hugepage_high_range(addr, len, zonemask) \
-	( ((addr) >= 0x100000000UL) \
-	  && ((HTLB_AREA_MASK((addr), (len)) | (zonemask)) == (zonemask)))
-#define within_hugepage_high_range(addr, len) \
-	__within_hugepage_high_range((addr), (len), \
-				    current->mm->context.high_htlb_areas)
-
-#define is_hugepage_only_range(mm, addr, len) \
-	(touches_hugepage_high_range((mm), (addr), (len)) || \
-	  touches_hugepage_low_range((mm), (addr), (len)))
-#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+#define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
+#define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
 
-#define in_hugepage_area(context, addr) \
-	(cpu_has_feature(CPU_FTR_16M_PAGE) && \
-	 ( ( (addr) >= 0x100000000UL) \
-	   ? ((1 << GET_HTLB_AREA(addr)) & (context).high_htlb_areas) \
-	   : ((1 << GET_ESID(addr)) & (context).low_htlb_areas) ) )
+#ifndef __ASSEMBLY__
 
-#else /* !CONFIG_HUGETLB_PAGE */
+struct slice_mask {
+	u16 low_slices;
+	u16 high_slices;
+};
 
-#define in_hugepage_area(mm, addr)	0
+struct mm_struct;
+
+extern unsigned long slice_get_unmapped_area(unsigned long addr,
+					     unsigned long len,
+					     unsigned long flags,
+					     unsigned int psize,
+					     int topdown,
+					     int use_cache);
+
+extern unsigned int get_slice_psize(struct mm_struct *mm,
+				    unsigned long addr);
+
+extern void slice_init_context(struct mm_struct *mm, unsigned int psize);
+extern void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
+
+#define ARCH_HAS_HUGEPAGE_ONLY_RANGE
+extern int is_hugepage_only_range(struct mm_struct *m,
+				  unsigned long addr,
+				  unsigned long len);
+
+#endif /* __ASSEMBLY__ */
+#else
+#define slice_init()
+#endif /* CONFIG_PPC_MM_SLICES */
+
+#ifdef CONFIG_HUGETLB_PAGE
+
+#define ARCH_HAS_HUGETLB_FREE_PGD_RANGE
+#define ARCH_HAS_SETCLEAR_HUGE_PTE
+#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
 #endif /* !CONFIG_HUGETLB_PAGE */
 
Index: linux-cell/arch/powerpc/mm/Makefile
===================================================================
--- linux-cell.orig/arch/powerpc/mm/Makefile	2007-05-08 15:27:05.000000000 +1000
+++ linux-cell/arch/powerpc/mm/Makefile	2007-05-08 15:27:52.000000000 +1000
@@ -18,4 +18,5 @@ obj-$(CONFIG_40x)		+= 4xx_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
 obj-$(CONFIG_FSL_BOOKE)		+= fsl_booke_mmu.o
 obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
+obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
Index: linux-cell/arch/powerpc/mm/slice.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/arch/powerpc/mm/slice.c	2007-05-08 15:27:52.000000000 +1000
@@ -0,0 +1,633 @@
+/*
+ * address space "slices" (meta-segments) support
+ *
+ * Copyright (C) 2007 Benjamin Herrenschmidt, IBM Corporation.
+ *
+ * Based on hugetlb implementation
+ *
+ * Copyright (C) 2003 David Gibson, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/err.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <asm/mman.h>
+#include <asm/mmu.h>
+#include <asm/spu.h>
+
+static spinlock_t slice_convert_lock = SPIN_LOCK_UNLOCKED;
+
+
+#ifdef DEBUG
+int _slice_debug = 1;
+
+static void slice_print_mask(const char *label, struct slice_mask mask)
+{
+	char	*p, buf[16 + 3 + 16 + 1];
+	int	i;
+
+	if (!_slice_debug)
+		return;
+	p = buf;
+	for (i = 0; i < SLICE_NUM_LOW; i++)
+		*(p++) = (mask.low_slices & (1 << i)) ? '1' : '0';
+	*(p++) = ' ';
+	*(p++) = '-';
+	*(p++) = ' ';
+	for (i = 0; i < SLICE_NUM_HIGH; i++)
+		*(p++) = (mask.high_slices & (1 << i)) ? '1' : '0';
+	*(p++) = 0;
+
+	printk(KERN_DEBUG "%s:%s\n", label, buf);
+}
+
+#define slice_dbg(fmt...) do { if (_slice_debug) pr_debug(fmt); } while(0)
+
+#else
+
+static void slice_print_mask(const char *label, struct slice_mask mask) {}
+#define slice_dbg(fmt...)
+
+#endif
+
+static struct slice_mask slice_range_to_mask(unsigned long start,
+					     unsigned long len)
+{
+	unsigned long end = start + len - 1;
+	struct slice_mask ret = { 0, 0 };
+
+	if (start < SLICE_LOW_TOP) {
+		unsigned long mend = min(end, SLICE_LOW_TOP);
+		unsigned long mstart = min(start, SLICE_LOW_TOP);
+
+		ret.low_slices = (1u << (GET_LOW_SLICE_INDEX(mend) + 1))
+			- (1u << GET_LOW_SLICE_INDEX(mstart));
+	}
+
+	if ((start + len) > SLICE_LOW_TOP)
+		ret.high_slices = (1u << (GET_HIGH_SLICE_INDEX(end) + 1))
+			- (1u << GET_HIGH_SLICE_INDEX(start));
+
+	return ret;
+}
+
+static int slice_area_is_free(struct mm_struct *mm, unsigned long addr,
+			      unsigned long len)
+{
+	struct vm_area_struct *vma;
+
+	if ((mm->task_size - len) < addr)
+		return 0;
+	vma = find_vma(mm, addr);
+	return (!vma || (addr + len) <= vma->vm_start);
+}
+
+static int slice_low_has_vma(struct mm_struct *mm, unsigned long slice)
+{
+	return !slice_area_is_free(mm, slice << SLICE_LOW_SHIFT,
+				   1ul << SLICE_LOW_SHIFT);
+}
+
+static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
+{
+	unsigned long start = slice << SLICE_HIGH_SHIFT;
+	unsigned long end = start + (1ul << SLICE_HIGH_SHIFT);
+
+	/* Hack, so that each addresses is controlled by exactly one
+	 * of the high or low area bitmaps, the first high area starts
+	 * at 4GB, not 0 */
+	if (start == 0)
+		start = SLICE_LOW_TOP;
+
+	return !slice_area_is_free(mm, start, end - start);
+}
+
+static struct slice_mask slice_mask_for_free(struct mm_struct *mm)
+{
+	struct slice_mask ret = { 0, 0 };
+	unsigned long i;
+
+	for (i = 0; i < SLICE_NUM_LOW; i++)
+		if (!slice_low_has_vma(mm, i))
+			ret.low_slices |= 1u << i;
+
+	if (mm->task_size <= SLICE_LOW_TOP)
+		return ret;
+
+	for (i = 0; i < SLICE_NUM_HIGH; i++)
+		if (!slice_high_has_vma(mm, i))
+			ret.high_slices |= 1u << i;
+
+	return ret;
+}
+
+static struct slice_mask slice_mask_for_size(struct mm_struct *mm, int psize)
+{
+	struct slice_mask ret = { 0, 0 };
+	unsigned long i;
+	u64 psizes;
+
+	psizes = mm->context.low_slices_psize;
+	for (i = 0; i < SLICE_NUM_LOW; i++)
+		if (((psizes >> (i * 4)) & 0xf) == psize)
+			ret.low_slices |= 1u << i;
+
+	psizes = mm->context.high_slices_psize;
+	for (i = 0; i < SLICE_NUM_HIGH; i++)
+		if (((psizes >> (i * 4)) & 0xf) == psize)
+			ret.high_slices |= 1u << i;
+
+	return ret;
+}
+
+static int slice_check_fit(struct slice_mask mask, struct slice_mask available)
+{
+	return (mask.low_slices & available.low_slices) == mask.low_slices &&
+		(mask.high_slices & available.high_slices) == mask.high_slices;
+}
+
+static void slice_flush_segments(void *parm)
+{
+	struct mm_struct *mm = parm;
+	unsigned long flags;
+
+	if (mm != current->active_mm)
+		return;
+
+	/* update the paca copy of the context struct */
+	get_paca()->context = current->active_mm->context;
+
+	local_irq_save(flags);
+	slb_flush_and_rebolt();
+	local_irq_restore(flags);
+}
+
+static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psize)
+{
+	/* Write the new slice psize bits */
+	u64 lpsizes, hpsizes;
+	unsigned long i, flags;
+
+	slice_dbg("slice_convert(mm=%p, psize=%d)\n", mm, psize);
+	slice_print_mask(" mask", mask);
+
+	/* We need to use a spinlock here to protect against
+	 * concurrent 64k -> 4k demotion ...
+	 */
+	spin_lock_irqsave(&slice_convert_lock, flags);
+
+	lpsizes = mm->context.low_slices_psize;
+	for (i = 0; i < SLICE_NUM_LOW; i++)
+		if (mask.low_slices & (1u << i))
+			lpsizes = (lpsizes & ~(0xful << (i * 4))) |
+				(((unsigned long)psize) << (i * 4));
+
+	hpsizes = mm->context.high_slices_psize;
+	for (i = 0; i < SLICE_NUM_HIGH; i++)
+		if (mask.high_slices & (1u << i))
+			hpsizes = (hpsizes & ~(0xful << (i * 4))) |
+				(((unsigned long)psize) << (i * 4));
+
+	mm->context.low_slices_psize = lpsizes;
+	mm->context.high_slices_psize = hpsizes;
+
+	slice_dbg(" lsps=%lx, hsps=%lx\n",
+		  mm->context.low_slices_psize,
+		  mm->context.high_slices_psize);
+
+	spin_unlock_irqrestore(&slice_convert_lock, flags);
+	mb();
+
+	/* XXX this is sub-optimal but will do for now */
+	on_each_cpu(slice_flush_segments, mm, 0, 1);
+#ifdef CONFIG_SPU_BASE
+	spu_flush_all_slbs(mm);
+#endif
+}
+
+static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
+					      unsigned long len,
+					      struct slice_mask available,
+					      int psize, int use_cache)
+{
+	struct vm_area_struct *vma;
+	unsigned long start_addr, addr;
+	struct slice_mask mask;
+	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
+
+	if (use_cache) {
+		if (len <= mm->cached_hole_size) {
+			start_addr = addr = TASK_UNMAPPED_BASE;
+			mm->cached_hole_size = 0;
+		} else
+			start_addr = addr = mm->free_area_cache;
+	} else
+		start_addr = addr = TASK_UNMAPPED_BASE;
+
+full_search:
+	for (;;) {
+		addr = _ALIGN_UP(addr, 1ul << pshift);
+		if ((TASK_SIZE - len) < addr)
+			break;
+		vma = find_vma(mm, addr);
+		BUG_ON(vma && (addr >= vma->vm_end));
+
+		mask = slice_range_to_mask(addr, len);
+		if (!slice_check_fit(mask, available)) {
+			if (addr < SLICE_LOW_TOP)
+				addr = _ALIGN_UP(addr + 1,  1ul << SLICE_LOW_SHIFT);
+			else
+				addr = _ALIGN_UP(addr + 1,  1ul << SLICE_HIGH_SHIFT);
+			continue;
+		}
+		if (!vma || addr + len <= vma->vm_start) {
+			/*
+			 * Remember the place where we stopped the search:
+			 */
+			if (use_cache)
+				mm->free_area_cache = addr + len;
+			return addr;
+		}
+		if (use_cache && (addr + mm->cached_hole_size) < vma->vm_start)
+		        mm->cached_hole_size = vma->vm_start - addr;
+		addr = vma->vm_end;
+	}
+
+	/* Make sure we didn't miss any holes */
+	if (use_cache && start_addr != TASK_UNMAPPED_BASE) {
+		start_addr = addr = TASK_UNMAPPED_BASE;
+		mm->cached_hole_size = 0;
+		goto full_search;
+	}
+	return -ENOMEM;
+}
+
+static unsigned long slice_find_area_topdown(struct mm_struct *mm,
+					     unsigned long len,
+					     struct slice_mask available,
+					     int psize, int use_cache)
+{
+	struct vm_area_struct *vma;
+	unsigned long addr;
+	struct slice_mask mask;
+	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
+
+	/* check if free_area_cache is useful for us */
+	if (use_cache) {
+		if (len <= mm->cached_hole_size) {
+			mm->cached_hole_size = 0;
+			mm->free_area_cache = mm->mmap_base;
+		}
+
+		/* either no address requested or can't fit in requested
+		 * address hole
+		 */
+		addr = mm->free_area_cache;
+
+		/* make sure it can fit in the remaining address space */
+		if (addr > len) {
+			addr = _ALIGN_DOWN(addr - len, 1ul << pshift);
+			mask = slice_range_to_mask(addr, len);
+			if (slice_check_fit(mask, available) &&
+			    slice_area_is_free(mm, addr, len))
+					/* remember the address as a hint for
+					 * next time
+					 */
+					return (mm->free_area_cache = addr);
+		}
+	}
+
+	addr = mm->mmap_base;
+	while (addr > len) {
+		/* Go down by chunk size */
+		addr = _ALIGN_DOWN(addr - len, 1ul << pshift);
+
+		/* Check for hit with different page size */
+		mask = slice_range_to_mask(addr, len);
+		if (!slice_check_fit(mask, available)) {
+			if (addr < SLICE_LOW_TOP)
+				addr = _ALIGN_DOWN(addr, 1ul << SLICE_LOW_SHIFT);
+			else if (addr < (1ul << SLICE_HIGH_SHIFT))
+				addr = SLICE_LOW_TOP;
+			else
+				addr = _ALIGN_DOWN(addr, 1ul << SLICE_HIGH_SHIFT);
+			continue;
+		}
+
+		/*
+		 * Lookup failure means no vma is above this address,
+		 * else if new region fits below vma->vm_start,
+		 * return with success:
+		 */
+		vma = find_vma(mm, addr);
+		if (!vma || (addr + len) <= vma->vm_start) {
+			/* remember the address as a hint for next time */
+			if (use_cache)
+				mm->free_area_cache = addr;
+			return addr;
+		}
+
+ 		/* remember the largest hole we saw so far */
+ 		if (use_cache && (addr + mm->cached_hole_size) < vma->vm_start)
+ 		        mm->cached_hole_size = vma->vm_start - addr;
+
+		/* try just below the current vma->vm_start */
+		addr = vma->vm_start;
+	}
+
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	addr = slice_find_area_bottomup(mm, len, available, psize, 0);
+
+	/*
+	 * Restore the topdown base:
+	 */
+	if (use_cache) {
+		mm->free_area_cache = mm->mmap_base;
+		mm->cached_hole_size = ~0UL;
+	}
+
+	return addr;
+}
+
+
+static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
+				     struct slice_mask mask, int psize,
+				     int topdown, int use_cache)
+{
+	if (topdown)
+		return slice_find_area_topdown(mm, len, mask, psize, use_cache);
+	else
+		return slice_find_area_bottomup(mm, len, mask, psize, use_cache);
+}
+
+unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
+				      unsigned long flags, unsigned int psize,
+				      int topdown, int use_cache)
+{
+	struct slice_mask mask;
+	struct slice_mask good_mask;
+	struct slice_mask potential_mask = {0,0} /* silence stupid warning */;
+	int pmask_set = 0;
+	int fixed = (flags & MAP_FIXED);
+	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
+	struct mm_struct *mm = current->mm;
+
+	/* Sanity checks */
+	BUG_ON(mm->task_size == 0);
+
+	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
+	slice_dbg(" addr=%lx, len=%lx, flags=%lx, topdown=%d, use_cache=%d\n",
+		  addr, len, flags, topdown, use_cache);
+
+	if (len > mm->task_size)
+		return -ENOMEM;
+	if (fixed && (addr & ((1ul << pshift) - 1)))
+		return -EINVAL;
+	if (fixed && addr > (mm->task_size - len))
+		return -EINVAL;
+
+	/* If hint, make sure it matches our alignment restrictions */
+	if (!fixed && addr) {
+		addr = _ALIGN_UP(addr, 1ul << pshift);
+		slice_dbg(" aligned addr=%lx\n", addr);
+	}
+
+	/* First makeup a "good" mask of slices that have the right size
+	 * already
+	 */
+	good_mask = slice_mask_for_size(mm, psize);
+	slice_print_mask(" good_mask", good_mask);
+
+	/* First check hint if it's valid or if we have MAP_FIXED */
+	if ((addr != 0 || fixed) && (mm->task_size - len) >= addr) {
+
+		/* Don't bother with hint if it overlaps a VMA */
+		if (!fixed && !slice_area_is_free(mm, addr, len))
+			goto search;
+
+		/* Build a mask for the requested range */
+		mask = slice_range_to_mask(addr, len);
+		slice_print_mask(" mask", mask);
+
+		/* Check if we fit in the good mask. If we do, we just return,
+		 * nothing else to do
+		 */
+		if (slice_check_fit(mask, good_mask)) {
+			slice_dbg(" fits good !\n");
+			return addr;
+		}
+
+		/* We don't fit in the good mask, check what other slices are
+		 * empty and thus can be converted
+		 */
+		potential_mask = slice_mask_for_free(mm);
+		potential_mask.low_slices |= good_mask.low_slices;
+		potential_mask.high_slices |= good_mask.high_slices;
+		pmask_set = 1;
+		slice_print_mask(" potential", potential_mask);
+		if (slice_check_fit(mask, potential_mask)) {
+			slice_dbg(" fits potential !\n");
+			goto convert;
+		}
+	}
+
+	/* If we have MAP_FIXED and failed the above step, then error out */
+	if (fixed)
+		return -EBUSY;
+
+ search:
+	slice_dbg(" search...\n");
+
+	/* Now let's see if we can find something in the existing slices
+	 * for that size
+	 */
+	addr = slice_find_area(mm, len, good_mask, psize, topdown, use_cache);
+	if (addr != -ENOMEM) {
+		/* Found within the good mask, we don't have to setup,
+		 * we thus return directly
+		 */
+		slice_dbg(" found area at 0x%lx\n", addr);
+		return addr;
+	}
+
+	/* Won't fit, check what can be converted */
+	if (!pmask_set) {
+		potential_mask = slice_mask_for_free(mm);
+		potential_mask.low_slices |= good_mask.low_slices;
+		potential_mask.high_slices |= good_mask.high_slices;
+		pmask_set = 1;
+		slice_print_mask(" potential", potential_mask);
+	}
+
+	/* Now let's see if we can find something in the existing slices
+	 * for that size
+	 */
+	addr = slice_find_area(mm, len, potential_mask, psize, topdown,
+			       use_cache);
+	if (addr == -ENOMEM)
+		return -ENOMEM;
+
+	mask = slice_range_to_mask(addr, len);
+	slice_dbg(" found potential area at 0x%lx\n", addr);
+	slice_print_mask(" mask", mask);
+
+ convert:
+	slice_convert(mm, mask, psize);
+	return addr;
+
+}
+EXPORT_SYMBOL_GPL(slice_get_unmapped_area);
+
+unsigned long arch_get_unmapped_area(struct file *filp,
+				     unsigned long addr,
+				     unsigned long len,
+				     unsigned long pgoff,
+				     unsigned long flags)
+{
+	return slice_get_unmapped_area(addr, len, flags,
+				       current->mm->context.user_psize,
+				       0, 1);
+}
+
+unsigned long arch_get_unmapped_area_topdown(struct file *filp,
+					     const unsigned long addr0,
+					     const unsigned long len,
+					     const unsigned long pgoff,
+					     const unsigned long flags)
+{
+	return slice_get_unmapped_area(addr0, len, flags,
+				       current->mm->context.user_psize,
+				       1, 1);
+}
+
+unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
+{
+	u64 psizes;
+	int index;
+
+	if (addr < SLICE_LOW_TOP) {
+		psizes = mm->context.low_slices_psize;
+		index = GET_LOW_SLICE_INDEX(addr);
+	} else {
+		psizes = mm->context.high_slices_psize;
+		index = GET_HIGH_SLICE_INDEX(addr);
+	}
+
+	return (psizes >> (index * 4)) & 0xf;
+}
+EXPORT_SYMBOL_GPL(get_slice_psize);
+
+/*
+ * This is called by hash_page when it needs to do a lazy conversion of
+ * an address space from real 64K pages to combo 4K pages (typically
+ * when hitting a non cacheable mapping on a processor or hypervisor
+ * that won't allow them for 64K pages).
+ *
+ * This is also called in init_new_context() to change back the user
+ * psize from whatever the parent context had it set to
+ *
+ * This function will only change the content of the {low,high)_slice_psize
+ * masks, it will not flush SLBs as this shall be handled lazily by the
+ * caller.
+ */
+void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
+{
+	unsigned long flags, lpsizes, hpsizes;
+	unsigned int old_psize;
+	int i;
+
+	slice_dbg("slice_set_user_psize(mm=%p, psize=%d)\n", mm, psize);
+
+	spin_lock_irqsave(&slice_convert_lock, flags);
+
+	old_psize = mm->context.user_psize;
+	slice_dbg(" old_psize=%d\n", old_psize);
+	if (old_psize == psize)
+		goto bail;
+
+	mm->context.user_psize = psize;
+	wmb();
+
+	lpsizes = mm->context.low_slices_psize;
+	for (i = 0; i < SLICE_NUM_LOW; i++)
+		if (((lpsizes >> (i * 4)) & 0xf) == old_psize)
+			lpsizes = (lpsizes & ~(0xful << (i * 4))) |
+				(((unsigned long)psize) << (i * 4));
+
+	hpsizes = mm->context.high_slices_psize;
+	for (i = 0; i < SLICE_NUM_HIGH; i++)
+		if (((hpsizes >> (i * 4)) & 0xf) == old_psize)
+			hpsizes = (hpsizes & ~(0xful << (i * 4))) |
+				(((unsigned long)psize) << (i * 4));
+
+	mm->context.low_slices_psize = lpsizes;
+	mm->context.high_slices_psize = hpsizes;
+
+	slice_dbg(" lsps=%lx, hsps=%lx\n",
+		  mm->context.low_slices_psize,
+		  mm->context.high_slices_psize);
+
+ bail:
+	spin_unlock_irqrestore(&slice_convert_lock, flags);
+}
+
+/*
+ * is_hugepage_only_range() is used by generic code to verify wether
+ * a normal mmap mapping (non hugetlbfs) is valid on a given area.
+ *
+ * until the generic code provides a more generic hook and/or starts
+ * calling arch get_unmapped_area for MAP_FIXED (which our implementation
+ * here knows how to deal with), we hijack it to keep standard mappings
+ * away from us.
+ *
+ * because of that generic code limitation, MAP_FIXED mapping cannot
+ * "convert" back a slice with no VMAs to the standard page size, only
+ * get_unmapped_area() can. It would be possible to fix it here but I
+ * prefer working on fixing the generic code instead.
+ *
+ * WARNING: This will not work if hugetlbfs isn't enabled since the
+ * generic code will redefine that function as 0 in that. This is ok
+ * for now as we only use slices with hugetlbfs enabled. This should
+ * be fixed as the generic code gets fixed.
+ */
+int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
+			   unsigned long len)
+{
+	struct slice_mask mask, available;
+
+	mask = slice_range_to_mask(addr, len);
+	available = slice_mask_for_size(mm, mm->context.user_psize);
+
+#if 0 /* too verbose */
+	slice_dbg("is_hugepage_only_range(mm=%p, addr=%lx, len=%lx)\n",
+		 mm, addr, len);
+	slice_print_mask(" mask", mask);
+	slice_print_mask(" available", available);
+#endif
+	return !slice_check_fit(mask, available);
+}
+
Index: linux-cell/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/asm-offsets.c	2007-05-08 15:27:05.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/asm-offsets.c	2007-05-08 15:27:52.000000000 +1000
@@ -122,12 +122,18 @@ int main(void)
 	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
 	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
 	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
-	DEFINE(PACACONTEXTSLLP, offsetof(struct paca_struct, context.sllp));
 	DEFINE(PACAVMALLOCSLLP, offsetof(struct paca_struct, vmalloc_sllp));
-#ifdef CONFIG_HUGETLB_PAGE
-	DEFINE(PACALOWHTLBAREAS, offsetof(struct paca_struct, context.low_htlb_areas));
-	DEFINE(PACAHIGHHTLBAREAS, offsetof(struct paca_struct, context.high_htlb_areas));
-#endif /* CONFIG_HUGETLB_PAGE */
+#ifdef CONFIG_PPC_MM_SLICES
+	DEFINE(PACALOWSLICESPSIZE, offsetof(struct paca_struct,
+					    context.low_slices_psize));
+	DEFINE(PACAHIGHSLICEPSIZE, offsetof(struct paca_struct,
+					    context.high_slices_psize));
+	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
+	DEFINE(MMUPSIZESLLP, offsetof(struct mmu_psize_def, sllp));
+#else
+	DEFINE(PACACONTEXTSLLP, offsetof(struct paca_struct, context.sllp));
+
+#endif /* CONFIG_PPC_MM_SLICES */
 	DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
 	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
 	DEFINE(PACA_EXSLB, offsetof(struct paca_struct, exslb));
Index: linux-cell/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/hugetlbpage.c	2007-05-08 15:27:05.000000000 +1000
+++ linux-cell/arch/powerpc/mm/hugetlbpage.c	2007-05-08 15:27:52.000000000 +1000
@@ -92,7 +92,7 @@ pte_t *huge_pte_offset(struct mm_struct 
 	pgd_t *pg;
 	pud_t *pu;
 
-	BUG_ON(! in_hugepage_area(mm->context, addr));
+	BUG_ON(get_slice_psize(mm, addr) != mmu_huge_psize);
 
 	addr &= HPAGE_MASK;
 
@@ -120,7 +120,7 @@ pte_t *huge_pte_alloc(struct mm_struct *
 	pud_t *pu;
 	hugepd_t *hpdp = NULL;
 
-	BUG_ON(! in_hugepage_area(mm->context, addr));
+	BUG_ON(get_slice_psize(mm, addr) != mmu_huge_psize);
 
 	addr &= HPAGE_MASK;
 
@@ -303,7 +303,7 @@ void hugetlb_free_pgd_range(struct mmu_g
 	start = addr;
 	pgd = pgd_offset((*tlb)->mm, addr);
 	do {
-		BUG_ON(! in_hugepage_area((*tlb)->mm->context, addr));
+		BUG_ON(get_slice_psize((*tlb)->mm, addr) != mmu_huge_psize);
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
@@ -332,203 +332,13 @@ pte_t huge_ptep_get_and_clear(struct mm_
 	return __pte(old);
 }
 
-struct slb_flush_info {
-	struct mm_struct *mm;
-	u16 newareas;
-};
-
-static void flush_low_segments(void *parm)
-{
-	struct slb_flush_info *fi = parm;
-	unsigned long i;
-
-	BUILD_BUG_ON((sizeof(fi->newareas)*8) != NUM_LOW_AREAS);
-
-	if (current->active_mm != fi->mm)
-		return;
-
-	/* Only need to do anything if this CPU is working in the same
-	 * mm as the one which has changed */
-
-	/* update the paca copy of the context struct */
-	get_paca()->context = current->active_mm->context;
-
-	asm volatile("isync" : : : "memory");
-	for (i = 0; i < NUM_LOW_AREAS; i++) {
-		if (! (fi->newareas & (1U << i)))
-			continue;
-		asm volatile("slbie %0"
-			     : : "r" ((i << SID_SHIFT) | SLBIE_C));
-	}
-	asm volatile("isync" : : : "memory");
-}
-
-static void flush_high_segments(void *parm)
-{
-	struct slb_flush_info *fi = parm;
-	unsigned long i, j;
-
-
-	BUILD_BUG_ON((sizeof(fi->newareas)*8) != NUM_HIGH_AREAS);
-
-	if (current->active_mm != fi->mm)
-		return;
-
-	/* Only need to do anything if this CPU is working in the same
-	 * mm as the one which has changed */
-
-	/* update the paca copy of the context struct */
-	get_paca()->context = current->active_mm->context;
-
-	asm volatile("isync" : : : "memory");
-	for (i = 0; i < NUM_HIGH_AREAS; i++) {
-		if (! (fi->newareas & (1U << i)))
-			continue;
-		for (j = 0; j < (1UL << (HTLB_AREA_SHIFT-SID_SHIFT)); j++)
-			asm volatile("slbie %0"
-				     :: "r" (((i << HTLB_AREA_SHIFT)
-					      + (j << SID_SHIFT)) | SLBIE_C));
-	}
-	asm volatile("isync" : : : "memory");
-}
-
-static int prepare_low_area_for_htlb(struct mm_struct *mm, unsigned long area)
-{
-	unsigned long start = area << SID_SHIFT;
-	unsigned long end = (area+1) << SID_SHIFT;
-	struct vm_area_struct *vma;
-
-	BUG_ON(area >= NUM_LOW_AREAS);
-
-	/* Check no VMAs are in the region */
-	vma = find_vma(mm, start);
-	if (vma && (vma->vm_start < end))
-		return -EBUSY;
-
-	return 0;
-}
-
-static int prepare_high_area_for_htlb(struct mm_struct *mm, unsigned long area)
-{
-	unsigned long start = area << HTLB_AREA_SHIFT;
-	unsigned long end = (area+1) << HTLB_AREA_SHIFT;
-	struct vm_area_struct *vma;
-
-	BUG_ON(area >= NUM_HIGH_AREAS);
-
-	/* Hack, so that each addresses is controlled by exactly one
-	 * of the high or low area bitmaps, the first high area starts
-	 * at 4GB, not 0 */
-	if (start == 0)
-		start = 0x100000000UL;
-
-	/* Check no VMAs are in the region */
-	vma = find_vma(mm, start);
-	if (vma && (vma->vm_start < end))
-		return -EBUSY;
-
-	return 0;
-}
-
-static int open_low_hpage_areas(struct mm_struct *mm, u16 newareas)
-{
-	unsigned long i;
-	struct slb_flush_info fi;
-
-	BUILD_BUG_ON((sizeof(newareas)*8) != NUM_LOW_AREAS);
-	BUILD_BUG_ON((sizeof(mm->context.low_htlb_areas)*8) != NUM_LOW_AREAS);
-
-	newareas &= ~(mm->context.low_htlb_areas);
-	if (! newareas)
-		return 0; /* The segments we want are already open */
-
-	for (i = 0; i < NUM_LOW_AREAS; i++)
-		if ((1 << i) & newareas)
-			if (prepare_low_area_for_htlb(mm, i) != 0)
-				return -EBUSY;
-
-	mm->context.low_htlb_areas |= newareas;
-
-	/* the context change must make it to memory before the flush,
-	 * so that further SLB misses do the right thing. */
-	mb();
-
-	fi.mm = mm;
-	fi.newareas = newareas;
-	on_each_cpu(flush_low_segments, &fi, 0, 1);
-
-	return 0;
-}
-
-static int open_high_hpage_areas(struct mm_struct *mm, u16 newareas)
-{
-	struct slb_flush_info fi;
-	unsigned long i;
-
-	BUILD_BUG_ON((sizeof(newareas)*8) != NUM_HIGH_AREAS);
-	BUILD_BUG_ON((sizeof(mm->context.high_htlb_areas)*8)
-		     != NUM_HIGH_AREAS);
-
-	newareas &= ~(mm->context.high_htlb_areas);
-	if (! newareas)
-		return 0; /* The areas we want are already open */
-
-	for (i = 0; i < NUM_HIGH_AREAS; i++)
-		if ((1 << i) & newareas)
-			if (prepare_high_area_for_htlb(mm, i) != 0)
-				return -EBUSY;
-
-	mm->context.high_htlb_areas |= newareas;
-
-	/* the context change must make it to memory before the flush,
-	 * so that further SLB misses do the right thing. */
-	mb();
-
-	fi.mm = mm;
-	fi.newareas = newareas;
-	on_each_cpu(flush_high_segments, &fi, 0, 1);
-
-	return 0;
-}
-
-int prepare_hugepage_range(unsigned long addr, unsigned long len, pgoff_t pgoff)
-{
-	int err = 0;
-
-	if (pgoff & (~HPAGE_MASK >> PAGE_SHIFT))
-		return -EINVAL;
-	if (len & ~HPAGE_MASK)
-		return -EINVAL;
-	if (addr & ~HPAGE_MASK)
-		return -EINVAL;
-
-	if (addr < 0x100000000UL)
-		err = open_low_hpage_areas(current->mm,
-					  LOW_ESID_MASK(addr, len));
-	if ((addr + len) > 0x100000000UL)
-		err = open_high_hpage_areas(current->mm,
-					    HTLB_AREA_MASK(addr, len));
-#ifdef CONFIG_SPE_BASE
-	spu_flush_all_slbs(current->mm);
-#endif
-	if (err) {
-		printk(KERN_DEBUG "prepare_hugepage_range(%lx, %lx)"
-		       " failed (lowmask: 0x%04hx, highmask: 0x%04hx)\n",
-		       addr, len,
-		       LOW_ESID_MASK(addr, len), HTLB_AREA_MASK(addr, len));
-		return err;
-	}
-
-	return 0;
-}
-
 struct page *
 follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 {
 	pte_t *ptep;
 	struct page *page;
 
-	if (! in_hugepage_area(mm->context, address))
+	if (get_slice_psize(mm, address) != mmu_huge_psize)
 		return ERR_PTR(-EINVAL);
 
 	ptep = huge_pte_offset(mm, address);
@@ -552,359 +362,13 @@ follow_huge_pmd(struct mm_struct *mm, un
 	return NULL;
 }
 
-/* Because we have an exclusive hugepage region which lies within the
- * normal user address space, we have to take special measures to make
- * non-huge mmap()s evade the hugepage reserved regions. */
-unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
-				     unsigned long len, unsigned long pgoff,
-				     unsigned long flags)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	unsigned long start_addr;
-
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
-	/* handle fixed mapping: prevent overlap with huge pages */
-	if (flags & MAP_FIXED) {
-		if (is_hugepage_only_range(mm, addr, len))
-			return -EINVAL;
-		return addr;
-	}
-
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma(mm, addr);
-		if (((TASK_SIZE - len) >= addr)
-		    && (!vma || (addr+len) <= vma->vm_start)
-		    && !is_hugepage_only_range(mm, addr,len))
-			return addr;
-	}
-	if (len > mm->cached_hole_size) {
-	        start_addr = addr = mm->free_area_cache;
-	} else {
-	        start_addr = addr = TASK_UNMAPPED_BASE;
-	        mm->cached_hole_size = 0;
-	}
-
-full_search:
-	vma = find_vma(mm, addr);
-	while (TASK_SIZE - len >= addr) {
-		BUG_ON(vma && (addr >= vma->vm_end));
-
-		if (touches_hugepage_low_range(mm, addr, len)) {
-			addr = ALIGN(addr+1, 1<<SID_SHIFT);
-			vma = find_vma(mm, addr);
-			continue;
-		}
-		if (touches_hugepage_high_range(mm, addr, len)) {
-			addr = ALIGN(addr+1, 1UL<<HTLB_AREA_SHIFT);
-			vma = find_vma(mm, addr);
-			continue;
-		}
-		if (!vma || addr + len <= vma->vm_start) {
-			/*
-			 * Remember the place where we stopped the search:
-			 */
-			mm->free_area_cache = addr + len;
-			return addr;
-		}
-		if (addr + mm->cached_hole_size < vma->vm_start)
-		        mm->cached_hole_size = vma->vm_start - addr;
-		addr = vma->vm_end;
-		vma = vma->vm_next;
-	}
-
-	/* Make sure we didn't miss any holes */
-	if (start_addr != TASK_UNMAPPED_BASE) {
-		start_addr = addr = TASK_UNMAPPED_BASE;
-		mm->cached_hole_size = 0;
-		goto full_search;
-	}
-	return -ENOMEM;
-}
-
-/*
- * This mmap-allocator allocates new areas top-down from below the
- * stack's low limit (the base):
- *
- * Because we have an exclusive hugepage region which lies within the
- * normal user address space, we have to take special measures to make
- * non-huge mmap()s evade the hugepage reserved regions.
- */
-unsigned long
-arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
-			  const unsigned long len, const unsigned long pgoff,
-			  const unsigned long flags)
-{
-	struct vm_area_struct *vma, *prev_vma;
-	struct mm_struct *mm = current->mm;
-	unsigned long base = mm->mmap_base, addr = addr0;
-	unsigned long largest_hole = mm->cached_hole_size;
-	int first_time = 1;
-
-	/* requested length too big for entire address space */
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
-	/* handle fixed mapping: prevent overlap with huge pages */
-	if (flags & MAP_FIXED) {
-		if (is_hugepage_only_range(mm, addr, len))
-			return -EINVAL;
-		return addr;
-	}
-
-	/* dont allow allocations above current base */
-	if (mm->free_area_cache > base)
-		mm->free_area_cache = base;
-
-	/* requesting a specific address */
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
-				(!vma || addr + len <= vma->vm_start)
-				&& !is_hugepage_only_range(mm, addr,len))
-			return addr;
-	}
-
-	if (len <= largest_hole) {
-	        largest_hole = 0;
-		mm->free_area_cache = base;
-	}
-try_again:
-	/* make sure it can fit in the remaining address space */
-	if (mm->free_area_cache < len)
-		goto fail;
-
-	/* either no address requested or cant fit in requested address hole */
-	addr = (mm->free_area_cache - len) & PAGE_MASK;
-	do {
-hugepage_recheck:
-		if (touches_hugepage_low_range(mm, addr, len)) {
-			addr = (addr & ((~0) << SID_SHIFT)) - len;
-			goto hugepage_recheck;
-		} else if (touches_hugepage_high_range(mm, addr, len)) {
-			addr = (addr & ((~0UL) << HTLB_AREA_SHIFT)) - len;
-			goto hugepage_recheck;
-		}
-
-		/*
-		 * Lookup failure means no vma is above this address,
-		 * i.e. return with success:
-		 */
- 	 	if (!(vma = find_vma_prev(mm, addr, &prev_vma)))
-			return addr;
-
-		/*
-		 * new region fits between prev_vma->vm_end and
-		 * vma->vm_start, use it:
-		 */
-		if (addr+len <= vma->vm_start &&
-		          (!prev_vma || (addr >= prev_vma->vm_end))) {
-			/* remember the address as a hint for next time */
-		        mm->cached_hole_size = largest_hole;
-		        return (mm->free_area_cache = addr);
-		} else {
-			/* pull free_area_cache down to the first hole */
-		        if (mm->free_area_cache == vma->vm_end) {
-				mm->free_area_cache = vma->vm_start;
-				mm->cached_hole_size = largest_hole;
-			}
-		}
-
-		/* remember the largest hole we saw so far */
-		if (addr + largest_hole < vma->vm_start)
-		        largest_hole = vma->vm_start - addr;
-
-		/* try just below the current vma->vm_start */
-		addr = vma->vm_start-len;
-	} while (len <= vma->vm_start);
-
-fail:
-	/*
-	 * if hint left us with no space for the requested
-	 * mapping then try again:
-	 */
-	if (first_time) {
-		mm->free_area_cache = base;
-		largest_hole = 0;
-		first_time = 0;
-		goto try_again;
-	}
-	/*
-	 * A failed mmap() very likely causes application failure,
-	 * so fall back to the bottom-up function here. This scenario
-	 * can happen with large stack limits and large mmap()
-	 * allocations.
-	 */
-	mm->free_area_cache = TASK_UNMAPPED_BASE;
-	mm->cached_hole_size = ~0UL;
-	addr = arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
-	/*
-	 * Restore the topdown base:
-	 */
-	mm->free_area_cache = base;
-	mm->cached_hole_size = ~0UL;
-
-	return addr;
-}
-
-static int htlb_check_hinted_area(unsigned long addr, unsigned long len)
-{
-	struct vm_area_struct *vma;
-
-	vma = find_vma(current->mm, addr);
-	if (TASK_SIZE - len >= addr &&
-	    (!vma || ((addr + len) <= vma->vm_start)))
-		return 0;
-
-	return -ENOMEM;
-}
-
-static unsigned long htlb_get_low_area(unsigned long len, u16 segmask)
-{
-	unsigned long addr = 0;
-	struct vm_area_struct *vma;
-
-	vma = find_vma(current->mm, addr);
-	while (addr + len <= 0x100000000UL) {
-		BUG_ON(vma && (addr >= vma->vm_end)); /* invariant */
-
-		if (! __within_hugepage_low_range(addr, len, segmask)) {
-			addr = ALIGN(addr+1, 1<<SID_SHIFT);
-			vma = find_vma(current->mm, addr);
-			continue;
-		}
-
-		if (!vma || (addr + len) <= vma->vm_start)
-			return addr;
-		addr = ALIGN(vma->vm_end, HPAGE_SIZE);
-		/* Depending on segmask this might not be a confirmed
-		 * hugepage region, so the ALIGN could have skipped
-		 * some VMAs */
-		vma = find_vma(current->mm, addr);
-	}
-
-	return -ENOMEM;
-}
-
-static unsigned long htlb_get_high_area(unsigned long len, u16 areamask)
-{
-	unsigned long addr = 0x100000000UL;
-	struct vm_area_struct *vma;
-
-	vma = find_vma(current->mm, addr);
-	while (addr + len <= TASK_SIZE_USER64) {
-		BUG_ON(vma && (addr >= vma->vm_end)); /* invariant */
-
-		if (! __within_hugepage_high_range(addr, len, areamask)) {
-			addr = ALIGN(addr+1, 1UL<<HTLB_AREA_SHIFT);
-			vma = find_vma(current->mm, addr);
-			continue;
-		}
-
-		if (!vma || (addr + len) <= vma->vm_start)
-			return addr;
-		addr = ALIGN(vma->vm_end, HPAGE_SIZE);
-		/* Depending on segmask this might not be a confirmed
-		 * hugepage region, so the ALIGN could have skipped
-		 * some VMAs */
-		vma = find_vma(current->mm, addr);
-	}
-
-	return -ENOMEM;
-}
 
 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 					unsigned long len, unsigned long pgoff,
 					unsigned long flags)
 {
-	int lastshift;
-	u16 areamask, curareas;
-
-	if (HPAGE_SHIFT == 0)
-		return -EINVAL;
-	if (len & ~HPAGE_MASK)
-		return -EINVAL;
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
-	if (!cpu_has_feature(CPU_FTR_16M_PAGE))
-		return -EINVAL;
-
-	/* Paranoia, caller should have dealt with this */
-	BUG_ON((addr + len)  < addr);
-
-	/* Handle MAP_FIXED */
-	if (flags & MAP_FIXED) {
-		if (prepare_hugepage_range(addr, len, pgoff))
-			return -EINVAL;
-		return addr;
-	}
-
-	if (test_thread_flag(TIF_32BIT)) {
-		curareas = current->mm->context.low_htlb_areas;
-
-		/* First see if we can use the hint address */
-		if (addr && (htlb_check_hinted_area(addr, len) == 0)) {
-			areamask = LOW_ESID_MASK(addr, len);
-			if (open_low_hpage_areas(current->mm, areamask) == 0)
-				return addr;
-		}
-
-		/* Next see if we can map in the existing low areas */
-		addr = htlb_get_low_area(len, curareas);
-		if (addr != -ENOMEM)
-			return addr;
-
-		/* Finally go looking for areas to open */
-		lastshift = 0;
-		for (areamask = LOW_ESID_MASK(0x100000000UL-len, len);
-		     ! lastshift; areamask >>=1) {
-			if (areamask & 1)
-				lastshift = 1;
-
-			addr = htlb_get_low_area(len, curareas | areamask);
-			if ((addr != -ENOMEM)
-			    && open_low_hpage_areas(current->mm, areamask) == 0)
-				return addr;
-		}
-	} else {
-		curareas = current->mm->context.high_htlb_areas;
-
-		/* First see if we can use the hint address */
-		/* We discourage 64-bit processes from doing hugepage
-		 * mappings below 4GB (must use MAP_FIXED) */
-		if ((addr >= 0x100000000UL)
-		    && (htlb_check_hinted_area(addr, len) == 0)) {
-			areamask = HTLB_AREA_MASK(addr, len);
-			if (open_high_hpage_areas(current->mm, areamask) == 0)
-				return addr;
-		}
-
-		/* Next see if we can map in the existing high areas */
-		addr = htlb_get_high_area(len, curareas);
-		if (addr != -ENOMEM)
-			return addr;
-
-		/* Finally go looking for areas to open */
-		lastshift = 0;
-		for (areamask = HTLB_AREA_MASK(TASK_SIZE_USER64-len, len);
-		     ! lastshift; areamask >>=1) {
-			if (areamask & 1)
-				lastshift = 1;
-
-			addr = htlb_get_high_area(len, curareas | areamask);
-			if ((addr != -ENOMEM)
-			    && open_high_hpage_areas(current->mm, areamask) == 0)
-				return addr;
-		}
-	}
-	printk(KERN_DEBUG "hugetlb_get_unmapped_area() unable to open"
-	       " enough areas\n");
-	return -ENOMEM;
+ 	return slice_get_unmapped_area(addr, len, flags,
+				       mmu_huge_psize, 1, 0);
 }
 
 /*
Index: linux-cell/arch/powerpc/mm/mmu_context_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/mmu_context_64.c	2007-05-08 15:27:05.000000000 +1000
+++ linux-cell/arch/powerpc/mm/mmu_context_64.c	2007-05-08 15:27:52.000000000 +1000
@@ -28,6 +28,7 @@ int init_new_context(struct task_struct 
 {
 	int index;
 	int err;
+	int new_context = (mm->context.id == 0);
 
 again:
 	if (!idr_pre_get(&mmu_context_idr, GFP_KERNEL))
@@ -50,9 +51,18 @@ again:
 	}
 
 	mm->context.id = index;
+#ifdef CONFIG_PPC_MM_SLICES
+	/* The old code would re-promote on fork, we don't do that
+	 * when using slices as it could cause problem promoting slices
+	 * that have been forced down to 4K
+	 */
+	if (new_context)
+		slice_set_user_psize(mm, mmu_virtual_psize);
+#else
 	mm->context.user_psize = mmu_virtual_psize;
 	mm->context.sllp = SLB_VSID_USER |
 		mmu_psize_defs[mmu_virtual_psize].sllp;
+#endif
 
 	return 0;
 }
Index: linux-cell/arch/powerpc/mm/slb_low.S
===================================================================
--- linux-cell.orig/arch/powerpc/mm/slb_low.S	2007-05-08 15:27:05.000000000 +1000
+++ linux-cell/arch/powerpc/mm/slb_low.S	2007-05-08 15:27:52.000000000 +1000
@@ -82,31 +82,45 @@ _GLOBAL(slb_miss_kernel_load_io)
 	srdi.	r9,r10,USER_ESID_BITS
 	bne-	8f			/* invalid ea bits set */
 
-	/* Figure out if the segment contains huge pages */
-#ifdef CONFIG_HUGETLB_PAGE
-BEGIN_FTR_SECTION
-	b	1f
-END_FTR_SECTION_IFCLR(CPU_FTR_16M_PAGE)
+
+	/* when using slices, we extract the psize off the slice bitmaps
+	 * and then we need to get the sllp encoding off the mmu_psize_defs
+	 * array.
+	 *
+	 * XXX This is a bit inefficient especially for the normal case,
+	 * so we should try to implement a fast path for the standard page
+	 * size using the old sllp value so we avoid the array. We cannot
+	 * really do dynamic patching unfortunately as processes might flip
+	 * between 4k and 64k standard page size
+	 */
+#ifdef CONFIG_PPC_MM_SLICES
 	cmpldi	r10,16
 
-	lhz	r9,PACALOWHTLBAREAS(r13)
-	mr	r11,r10
+	/* Get the slice index * 4 in r11 and matching slice size mask in r9 */
+	ld	r9,PACALOWSLICESPSIZE(r13)
+	sldi	r11,r10,2
 	blt	5f
+	ld	r9,PACAHIGHSLICEPSIZE(r13)
+	srdi	r11,r10,(SLICE_HIGH_SHIFT - SLICE_LOW_SHIFT - 2)
+	andi.	r11,r11,0x3c
+
+5:	/* Extract the psize and multiply to get an array offset */
+	srd	r9,r9,r11
+	andi.	r9,r9,0xf
+	mulli	r9,r9,MMUPSIZEDEFSIZE
 
-	lhz	r9,PACAHIGHHTLBAREAS(r13)
-	srdi	r11,r10,(HTLB_AREA_SHIFT-SID_SHIFT)
-
-5:	srd	r9,r9,r11
-	andi.	r9,r9,1
-	beq	1f
-_GLOBAL(slb_miss_user_load_huge)
-	li	r11,0
-	b	2f
-1:
-#endif /* CONFIG_HUGETLB_PAGE */
-
+	/* Now get to the array and obtain the sllp
+	 */
+	ld	r11,PACATOC(r13)
+	ld	r11,mmu_psize_defs@got(r11)
+	add	r11,r11,r9
+	ld	r11,MMUPSIZESLLP(r11)
+	ori	r11,r11,SLB_VSID_USER
+#else
+	/* paca context sllp already contains the SLB_VSID_USER bits */
 	lhz	r11,PACACONTEXTSLLP(r13)
-2:
+#endif /* CONFIG_PPC_MM_SLICES */
+
 	ld	r9,PACACONTEXTID(r13)
 	rldimi	r10,r9,USER_ESID_BITS,0
 	b	slb_finish_load
Index: linux-cell/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/hash_utils_64.c	2007-05-08 15:27:29.000000000 +1000
+++ linux-cell/arch/powerpc/mm/hash_utils_64.c	2007-05-08 15:28:34.000000000 +1000
@@ -51,6 +51,7 @@
 #include <asm/cputable.h>
 #include <asm/abs_addr.h>
 #include <asm/sections.h>
+#include <asm/spu.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -601,8 +602,13 @@ static void demote_segment_4k(struct mm_
 {
 	if (mm->context.user_psize == MMU_PAGE_4K)
 		return;
+#ifdef CONFIG_PPC_MM_SLICES
+	slice_set_user_psize(mm, MMU_PAGE_4K);
+#else /* CONFIG_PPC_MM_SLICES */
 	mm->context.user_psize = MMU_PAGE_4K;
 	mm->context.sllp = SLB_VSID_USER | mmu_psize_defs[MMU_PAGE_4K].sllp;
+#endif /* CONFIG_PPC_MM_SLICES */
+
 #ifdef CONFIG_SPE_BASE
 	spu_flush_all_slbs(mm);
 #endif
@@ -670,11 +676,14 @@ int hash_page(unsigned long ea, unsigned
 	if (user_region && cpus_equal(mm->cpu_vm_mask, tmp))
 		local = 1;
 
+#ifdef CONFIG_HUGETLB_PAGE
 	/* Handle hugepage regions */
-	if (unlikely(in_hugepage_area(mm->context, ea))) {
+	if (HPAGE_SHIFT &&
+	    unlikely(get_slice_psize(mm, ea) == mmu_huge_psize)) {
 		DBG_LOW(" -> huge page !\n");
 		return hash_huge_page(mm, access, ea, vsid, local, trap);
 	}
+#endif /* CONFIG_HUGETLB_PAGE */
 
 	/* Get PTE and page size from page tables */
 	ptep = find_linux_pte(pgdir, ea);
@@ -770,10 +779,13 @@ void hash_preload(struct mm_struct *mm, 
 	unsigned long flags;
 	int local = 0;
 
-	/* We don't want huge pages prefaulted for now
-	 */
-	if (unlikely(in_hugepage_area(mm->context, ea)))
+	BUG_ON(REGION_ID(ea) != USER_REGION_ID);
+
+#ifdef CONFIG_PPC_MM_SLICES
+	/* We only prefault standard pages for now */
+	if (unlikely(get_slice_psize(mm, ea) != mm->context.user_psize));
 		return;
+#endif
 
 	DBG_LOW("hash_preload(mm=%p, mm->pgdir=%p, ea=%016lx, access=%lx,"
 		" trap=%lx\n", mm, mm->pgd, ea, access, trap);
Index: linux-cell/arch/powerpc/mm/slb.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/slb.c	2007-05-08 15:27:05.000000000 +1000
+++ linux-cell/arch/powerpc/mm/slb.c	2007-05-08 15:27:52.000000000 +1000
@@ -198,12 +198,6 @@ void slb_initialize(void)
 	static int slb_encoding_inited;
 	extern unsigned int *slb_miss_kernel_load_linear;
 	extern unsigned int *slb_miss_kernel_load_io;
-#ifdef CONFIG_HUGETLB_PAGE
-	extern unsigned int *slb_miss_user_load_huge;
-	unsigned long huge_llp;
-
-	huge_llp = mmu_psize_defs[mmu_huge_psize].sllp;
-#endif
 
 	/* Prepare our SLB miss handler based on our page size */
 	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
@@ -220,11 +214,6 @@ void slb_initialize(void)
 
 		DBG("SLB: linear  LLP = %04x\n", linear_llp);
 		DBG("SLB: io      LLP = %04x\n", io_llp);
-#ifdef CONFIG_HUGETLB_PAGE
-		patch_slb_encoding(slb_miss_user_load_huge,
-				   SLB_VSID_USER | huge_llp);
-		DBG("SLB: huge    LLP = %04x\n", huge_llp);
-#endif
 	}
 
 	get_paca()->stab_rr = SLB_NUM_BOLTED;
Index: linux-cell/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spu_base.c	2007-05-08 15:27:05.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/spu_base.c	2007-05-08 15:27:52.000000000 +1000
@@ -144,12 +144,11 @@ static int __spu_trap_data_seg(struct sp
 
 	switch(REGION_ID(ea)) {
 	case USER_REGION_ID:
-#ifdef CONFIG_HUGETLB_PAGE
-		if (in_hugepage_area(mm->context, ea))
-			psize = mmu_huge_psize;
-		else
+#ifdef CONFIG_PPC_MM_SLICES
+		psize = get_slice_psize(mm, ea);
+#else
+		psize = mm->context.user_psize;
 #endif
-			psize = mm->context.user_psize;
 		vsid = (get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT) |
 				SLB_VSID_USER;
 		break;
Index: linux-cell/include/asm-powerpc/mmu-hash64.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/mmu-hash64.h	2007-05-08 15:27:05.000000000 +1000
+++ linux-cell/include/asm-powerpc/mmu-hash64.h	2007-05-08 15:27:52.000000000 +1000
@@ -350,10 +350,13 @@ typedef unsigned long mm_context_id_t;
 
 typedef struct {
 	mm_context_id_t id;
-	u16 user_psize;			/* page size index */
-	u16 sllp;			/* SLB entry page size encoding */
-#ifdef CONFIG_HUGETLB_PAGE
-	u16 low_htlb_areas, high_htlb_areas;
+	u16 user_psize;		/* page size index */
+
+#ifdef CONFIG_PPC_MM_SLICES
+	u64 low_slices_psize;	/* SLB page size encodings */
+	u64 high_slices_psize;  /* 4 bits per slice for now */
+#else
+	u16 sllp;		/* SLB page size encoding */
 #endif
 	unsigned long vdso_base;
 } mm_context_t;
