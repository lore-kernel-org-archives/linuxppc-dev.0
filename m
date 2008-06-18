Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18520.40232.383998.820059@cargo.ozlabs.ibm.com>
Date: Wed, 18 Jun 2008 15:29:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Only demote individual slices rather than
	whole process
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At present, if we have a kernel with a 64kB page size, and some
process maps something that has to be mapped with 4kB pages (such as a
cache-inhibited mapping on POWER5+, or the eHCA infiniband queue-pair
pages), we change the process to use 4kB pages everywhere.  This hurts
the performance of HPC programs that access eHCA from userspace.

With this patch, the kernel will only demote the slice(s) containing
the eHCA or cache-inhibited mappings, leaving the remaining slices
able to use 64kB hardware pages.

This also changes the slice_get_unmapped_area code so that it is
willing to place a 64k-page mapping into (or across) a 4k-page slice
if there is no better alternative, i.e. if the program specified
MAP_FIXED or if there is not sufficient space available in slices that
are either empty or already have 64k-page mappings in them.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index bf5b6d7..8d3b58e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -695,6 +695,28 @@ unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
 	return pp;
 }
 
+#ifdef CONFIG_PPC_MM_SLICES
+unsigned int get_paca_psize(unsigned long addr)
+{
+	unsigned long index, slices;
+
+	if (addr < SLICE_LOW_TOP) {
+		slices = get_paca()->context.low_slices_psize;
+		index = GET_LOW_SLICE_INDEX(addr);
+	} else {
+		slices = get_paca()->context.high_slices_psize;
+		index = GET_HIGH_SLICE_INDEX(addr);
+	}
+	return (slices >> (index * 4)) & 0xF;
+}
+
+#else
+unsigned int get_paca_psize(unsigned long addr)
+{
+	return get_paca()->context.user_psize;
+}
+#endif
+
 /*
  * Demote a segment to using 4k pages.
  * For now this makes the whole process use 4k pages.
@@ -702,13 +724,13 @@ unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
 #ifdef CONFIG_PPC_64K_PAGES
 void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 {
-	if (mm->context.user_psize == MMU_PAGE_4K)
+	if (get_slice_psize(mm, addr) == MMU_PAGE_4K)
 		return;
-	slice_set_user_psize(mm, MMU_PAGE_4K);
+	slice_set_range_psize(mm, addr, 1, MMU_PAGE_4K);
 #ifdef CONFIG_SPU_BASE
 	spu_flush_all_slbs(mm);
 #endif
-	if (get_paca()->context.user_psize != MMU_PAGE_4K) {
+	if (get_paca_psize(addr) != MMU_PAGE_4K) {
 		get_paca()->context = mm->context;
 		slb_flush_and_rebolt();
 	}
@@ -792,11 +814,7 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 			DBG_LOW(" user region with no mm !\n");
 			return 1;
 		}
-#ifdef CONFIG_PPC_MM_SLICES
 		psize = get_slice_psize(mm, ea);
-#else
-		psize = mm->context.user_psize;
-#endif
 		ssize = user_segment_size(ea);
 		vsid = get_vsid(mm->context.id, ea, ssize);
 		break;
@@ -868,7 +886,7 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 	/* Do actual hashing */
 #ifdef CONFIG_PPC_64K_PAGES
 	/* If _PAGE_4K_PFN is set, make sure this is a 4k segment */
-	if (pte_val(*ptep) & _PAGE_4K_PFN) {
+	if ((pte_val(*ptep) & _PAGE_4K_PFN) && psize == MMU_PAGE_64K) {
 		demote_segment_4k(mm, ea);
 		psize = MMU_PAGE_4K;
 	}
@@ -897,7 +915,7 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 		}
 	}
 	if (user_region) {
-		if (psize != get_paca()->context.user_psize) {
+		if (psize != get_paca_psize(ea)) {
 			get_paca()->context = mm->context;
 			slb_flush_and_rebolt();
 		}
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index ad928ed..583be67 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -215,10 +215,7 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
 		  mm->context.high_slices_psize);
 
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
-	mb();
 
-	/* XXX this is sub-optimal but will do for now */
-	on_each_cpu(slice_flush_segments, mm, 0, 1);
 #ifdef CONFIG_SPU_BASE
 	spu_flush_all_slbs(mm);
 #endif
@@ -384,17 +381,34 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 		return slice_find_area_bottomup(mm, len, mask, psize, use_cache);
 }
 
+#define or_mask(dst, src)	do {			\
+	(dst).low_slices |= (src).low_slices;		\
+	(dst).high_slices |= (src).high_slices;		\
+} while (0)
+
+#define andnot_mask(dst, src)	do {			\
+	(dst).low_slices &= ~(src).low_slices;		\
+	(dst).high_slices &= ~(src).high_slices;	\
+} while (0)
+
+#ifdef CONFIG_PPC_64K_PAGES
+#define MMU_PAGE_BASE	MMU_PAGE_64K
+#else
+#define MMU_PAGE_BASE	MMU_PAGE_4K
+#endif
+
 unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 				      unsigned long flags, unsigned int psize,
 				      int topdown, int use_cache)
 {
-	struct slice_mask mask;
+	struct slice_mask mask = {0, 0};
 	struct slice_mask good_mask;
 	struct slice_mask potential_mask = {0,0} /* silence stupid warning */;
-	int pmask_set = 0;
+	struct slice_mask compat_mask = {0, 0};
 	int fixed = (flags & MAP_FIXED);
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	struct mm_struct *mm = current->mm;
+	unsigned long newaddr;
 
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
@@ -416,21 +430,48 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	if (!fixed && addr) {
 		addr = _ALIGN_UP(addr, 1ul << pshift);
 		slice_dbg(" aligned addr=%lx\n", addr);
+		/* Ignore hint if it's too large or overlaps a VMA */
+		if (addr > mm->task_size - len ||
+		    !slice_area_is_free(mm, addr, len))
+			addr = 0;
 	}
 
-	/* First makeup a "good" mask of slices that have the right size
+	/* First make up a "good" mask of slices that have the right size
 	 * already
 	 */
 	good_mask = slice_mask_for_size(mm, psize);
 	slice_print_mask(" good_mask", good_mask);
 
-	/* First check hint if it's valid or if we have MAP_FIXED */
-	if ((addr != 0 || fixed) && (mm->task_size - len) >= addr) {
+	/*
+	 * Here "good" means slices that are already the right page size,
+	 * "compat" means slices that have a compatible page size (i.e.
+	 * 4k in a 64k pagesize kernel), and "free" means slices without
+	 * any VMAs.
+	 *
+	 * If MAP_FIXED:
+	 *	check if fits in good | compat => OK
+	 *	check if fits in good | compat | free => convert free
+	 *	else bad
+	 * If have hint:
+	 *	check if hint fits in good => OK
+	 *	check if hint fits in good | free => convert free
+	 * Otherwise:
+	 *	search in good, found => OK
+	 *	search in good | free, found => convert free
+	 *	search in good | compat | free, found => convert free.
+	 */
 
-		/* Don't bother with hint if it overlaps a VMA */
-		if (!fixed && !slice_area_is_free(mm, addr, len))
-			goto search;
+#ifdef CONFIG_PPC_64K_PAGES
+	/* If we support combo pages, we can allow 64k pages in 4k slices */
+	if (psize == MMU_PAGE_64K) {
+		compat_mask = slice_mask_for_size(mm, MMU_PAGE_4K);
+		if (fixed)
+			or_mask(good_mask, compat_mask);
+	}
+#endif
 
+	/* First check hint if it's valid or if we have MAP_FIXED */
+	if (addr != 0 || fixed) {
 		/* Build a mask for the requested range */
 		mask = slice_range_to_mask(addr, len);
 		slice_print_mask(" mask", mask);
@@ -442,54 +483,66 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 			slice_dbg(" fits good !\n");
 			return addr;
 		}
-
-		/* We don't fit in the good mask, check what other slices are
-		 * empty and thus can be converted
+	} else {
+		/* Now let's see if we can find something in the existing
+		 * slices for that size
 		 */
-		potential_mask = slice_mask_for_free(mm);
-		potential_mask.low_slices |= good_mask.low_slices;
-		potential_mask.high_slices |= good_mask.high_slices;
-		pmask_set = 1;
-		slice_print_mask(" potential", potential_mask);
-		if (slice_check_fit(mask, potential_mask)) {
-			slice_dbg(" fits potential !\n");
-			goto convert;
+		newaddr = slice_find_area(mm, len, good_mask, psize, topdown,
+					  use_cache);
+		if (newaddr != -ENOMEM) {
+			/* Found within the good mask, we don't have to setup,
+			 * we thus return directly
+			 */
+			slice_dbg(" found area at 0x%lx\n", newaddr);
+			return newaddr;
 		}
 	}
 
-	/* If we have MAP_FIXED and failed the above step, then error out */
+	/* We don't fit in the good mask, check what other slices are
+	 * empty and thus can be converted
+	 */
+	potential_mask = slice_mask_for_free(mm);
+	or_mask(potential_mask, good_mask);
+	slice_print_mask(" potential", potential_mask);
+
+	if ((addr != 0 || fixed) && slice_check_fit(mask, potential_mask)) {
+		slice_dbg(" fits potential !\n");
+		goto convert;
+	}
+
+	/* If we have MAP_FIXED and failed the above steps, then error out */
 	if (fixed)
 		return -EBUSY;
 
- search:
 	slice_dbg(" search...\n");
 
-	/* Now let's see if we can find something in the existing slices
-	 * for that size
+	/* If we had a hint that didn't work out, see if we can fit
+	 * anywhere in the good area.
 	 */
-	addr = slice_find_area(mm, len, good_mask, psize, topdown, use_cache);
-	if (addr != -ENOMEM) {
-		/* Found within the good mask, we don't have to setup,
-		 * we thus return directly
-		 */
-		slice_dbg(" found area at 0x%lx\n", addr);
-		return addr;
-	}
-
-	/* Won't fit, check what can be converted */
-	if (!pmask_set) {
-		potential_mask = slice_mask_for_free(mm);
-		potential_mask.low_slices |= good_mask.low_slices;
-		potential_mask.high_slices |= good_mask.high_slices;
-		pmask_set = 1;
-		slice_print_mask(" potential", potential_mask);
+	if (addr) {
+		addr = slice_find_area(mm, len, good_mask, psize, topdown,
+				       use_cache);
+		if (addr != -ENOMEM) {
+			slice_dbg(" found area at 0x%lx\n", addr);
+			return addr;
+		}
 	}
 
 	/* Now let's see if we can find something in the existing slices
-	 * for that size
+	 * for that size plus free slices
 	 */
 	addr = slice_find_area(mm, len, potential_mask, psize, topdown,
 			       use_cache);
+
+#ifdef CONFIG_PPC_64K_PAGES
+	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
+		/* retry the search with 4k-page slices included */
+		or_mask(potential_mask, compat_mask);
+		addr = slice_find_area(mm, len, potential_mask, psize,
+				       topdown, use_cache);
+	}
+#endif
+
 	if (addr == -ENOMEM)
 		return -ENOMEM;
 
@@ -498,7 +551,13 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	slice_print_mask(" mask", mask);
 
  convert:
-	slice_convert(mm, mask, psize);
+	andnot_mask(mask, good_mask);
+	andnot_mask(mask, compat_mask);
+	if (mask.low_slices || mask.high_slices) {
+		slice_convert(mm, mask, psize);
+		if (psize > MMU_PAGE_BASE)
+			on_each_cpu(slice_flush_segments, mm, 0, 1);
+	}
 	return addr;
 
 }
@@ -598,6 +657,36 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 }
 
+void slice_set_psize(struct mm_struct *mm, unsigned long address,
+		     unsigned int psize)
+{
+	unsigned long i, flags;
+	u64 *p;
+
+	spin_lock_irqsave(&slice_convert_lock, flags);
+	if (address < SLICE_LOW_TOP) {
+		i = GET_LOW_SLICE_INDEX(address);
+		p = &mm->context.low_slices_psize;
+	} else {
+		i = GET_HIGH_SLICE_INDEX(address);
+		p = &mm->context.high_slices_psize;
+	}
+	*p = (*p & ~(0xful << (i * 4))) | ((unsigned long) psize << (i * 4));
+	spin_unlock_irqrestore(&slice_convert_lock, flags);
+
+#ifdef CONFIG_SPU_BASE
+	spu_flush_all_slbs(mm);
+#endif
+}
+
+void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
+			   unsigned long len, unsigned int psize)
+{
+	struct slice_mask mask = slice_range_to_mask(start, len);
+
+	slice_convert(mm, mask, psize);
+}
+
 /*
  * is_hugepage_only_range() is used by generic code to verify wether
  * a normal mmap mapping (non hugetlbfs) is valid on a given area.
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f7efaa9..57347a8 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -182,7 +182,7 @@ config PPC_STD_MMU_32
 
 config PPC_MM_SLICES
 	bool
-	default y if HUGETLB_PAGE
+	default y if HUGETLB_PAGE || PPC_64K_PAGES
 	default n
 
 config VIRT_CPU_ACCOUNTING
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 4c1c584..6a51b1c 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -9,6 +9,7 @@ FONTMAPFILE = cp437.uni
 
 obj-y	 += mem.o random.o tty_io.o n_tty.o tty_ioctl.o
 
+obj-$(CONFIG_PPC_64K_PAGES)	+= single.o
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
 obj-y				+= misc.o
diff --git a/include/asm-powerpc/page_64.h b/include/asm-powerpc/page_64.h
index 25af4fc..02fd807 100644
--- a/include/asm-powerpc/page_64.h
+++ b/include/asm-powerpc/page_64.h
@@ -126,16 +126,22 @@ extern unsigned int get_slice_psize(struct mm_struct *mm,
 
 extern void slice_init_context(struct mm_struct *mm, unsigned int psize);
 extern void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
+extern void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
+				  unsigned long len, unsigned int psize);
+
 #define slice_mm_new_context(mm)	((mm)->context.id == 0)
 
 #endif /* __ASSEMBLY__ */
 #else
 #define slice_init()
+#define get_slice_psize(mm, addr)	((mm)->context.user_psize)
 #define slice_set_user_psize(mm, psize)		\
 do {						\
 	(mm)->context.user_psize = (psize);	\
 	(mm)->context.sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
 } while (0)
+#define slice_set_range_psize(mm, start, len, psize)	\
+	slice_set_user_psize((mm), (psize))
 #define slice_mm_new_context(mm)	1
 #endif /* CONFIG_PPC_MM_SLICES */
 
