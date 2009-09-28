Return-Path: <dgibson@ozlabs.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [5/5] Split hash MMU specific hugepage code into a new file
In-Reply-To: <20090928043902.GA6302@yookeroo.seuss>
Message-Id: <20090928044114.E1129B7BFA@ozlabs.org>
Date: Mon, 28 Sep 2009 14:41:14 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch separates the parts of hugetlbpage.c which are inherently
specific to the hash MMU into a new hugelbpage-hash64.c file.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

---
 arch/powerpc/include/asm/hugetlb.h   |    3 
 arch/powerpc/mm/Makefile             |    5 -
 arch/powerpc/mm/hugetlbpage-hash64.c |  167 ++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/hugetlbpage.c        |  168 -----------------------------------
 4 files changed, 176 insertions(+), 167 deletions(-)

Index: working-2.6/arch/powerpc/mm/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/mm/Makefile	2009-09-28 13:51:57.000000000 +1000
+++ working-2.6/arch/powerpc/mm/Makefile	2009-09-28 13:53:21.000000000 +1000
@@ -28,7 +28,10 @@ obj-$(CONFIG_44x)		+= 44x_mmu.o
 obj-$(CONFIG_FSL_BOOKE)		+= fsl_booke_mmu.o
 obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
-obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
+ifeq ($(CONFIG_HUGETLB_PAGE),y)
+obj-y				+= hugetlbpage.o
+obj-$(CONFIG_PPC_STD_MMU_64)	+= hugetlbpage-hash64.o
+endif
 obj-$(CONFIG_PPC_SUBPAGE_PROT)	+= subpage-prot.o
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
Index: working-2.6/arch/powerpc/mm/hugetlbpage-hash64.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/mm/hugetlbpage-hash64.c	2009-09-28 13:53:21.000000000 +1000
@@ -0,0 +1,167 @@
+/*
+ * PPC64 Huge TLB Page Support for hash based MMUs (POWER4 and later)
+ *
+ * Copyright (C) 2003 David Gibson, IBM Corporation.
+ *
+ * Based on the IA-32 version:
+ * Copyright (C) 2002, Rohit Seth <rohit.seth@intel.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/cacheflush.h>
+#include <asm/machdep.h>
+
+/*
+ * Called by asm hashtable.S for doing lazy icache flush
+ */
+static unsigned int hash_huge_page_do_lazy_icache(unsigned long rflags,
+					pte_t pte, int trap, unsigned long sz)
+{
+	struct page *page;
+	int i;
+
+	if (!pfn_valid(pte_pfn(pte)))
+		return rflags;
+
+	page = pte_page(pte);
+
+	/* page is dirty */
+	if (!test_bit(PG_arch_1, &page->flags) && !PageReserved(page)) {
+		if (trap == 0x400) {
+			for (i = 0; i < (sz / PAGE_SIZE); i++)
+				__flush_dcache_icache(page_address(page+i));
+			set_bit(PG_arch_1, &page->flags);
+		} else {
+			rflags |= HPTE_R_N;
+		}
+	}
+	return rflags;
+}
+
+int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
+		     pte_t *ptep, unsigned long trap, int local, int ssize,
+		     unsigned int shift, unsigned int mmu_psize)
+{
+	unsigned long old_pte, new_pte;
+	unsigned long va, rflags, pa, sz;
+	long slot;
+	int err = 1;
+
+	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
+
+	/* Search the Linux page table for a match with va */
+	va = hpt_va(ea, vsid, ssize);
+
+	/*
+	 * Check the user's access rights to the page.  If access should be
+	 * prevented then send the problem up to do_page_fault.
+	 */
+	if (unlikely(access & ~pte_val(*ptep)))
+		goto out;
+	/*
+	 * At this point, we have a pte (old_pte) which can be used to build
+	 * or update an HPTE. There are 2 cases:
+	 *
+	 * 1. There is a valid (present) pte with no associated HPTE (this is
+	 *	the most common case)
+	 * 2. There is a valid (present) pte with an associated HPTE. The
+	 *	current values of the pp bits in the HPTE prevent access
+	 *	because we are doing software DIRTY bit management and the
+	 *	page is currently not DIRTY.
+	 */
+
+
+	do {
+		old_pte = pte_val(*ptep);
+		if (old_pte & _PAGE_BUSY)
+			goto out;
+		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
+	} while(old_pte != __cmpxchg_u64((unsigned long *)ptep,
+					 old_pte, new_pte));
+
+	rflags = 0x2 | (!(new_pte & _PAGE_RW));
+ 	/* _PAGE_EXEC -> HW_NO_EXEC since it's inverted */
+	rflags |= ((new_pte & _PAGE_EXEC) ? 0 : HPTE_R_N);
+	sz = ((1UL) << shift);
+	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
+		/* No CPU has hugepages but lacks no execute, so we
+		 * don't need to worry about that case */
+		rflags = hash_huge_page_do_lazy_icache(rflags, __pte(old_pte),
+						       trap, sz);
+
+	/* Check if pte already has an hpte (case 2) */
+	if (unlikely(old_pte & _PAGE_HASHPTE)) {
+		/* There MIGHT be an HPTE for this pte */
+		unsigned long hash, slot;
+
+		hash = hpt_hash(va, shift, ssize);
+		if (old_pte & _PAGE_F_SECOND)
+			hash = ~hash;
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+		slot += (old_pte & _PAGE_F_GIX) >> 12;
+
+		if (ppc_md.hpte_updatepp(slot, rflags, va, mmu_psize,
+					 ssize, local) == -1)
+			old_pte &= ~_PAGE_HPTEFLAGS;
+	}
+
+	if (likely(!(old_pte & _PAGE_HASHPTE))) {
+		unsigned long hash = hpt_hash(va, shift, ssize);
+		unsigned long hpte_group;
+
+		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
+
+repeat:
+		hpte_group = ((hash & htab_hash_mask) *
+			      HPTES_PER_GROUP) & ~0x7UL;
+
+		/* clear HPTE slot informations in new PTE */
+#ifdef CONFIG_PPC_64K_PAGES
+		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HPTE_SUB0;
+#else
+		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
+#endif
+		/* Add in WIMG bits */
+		rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
+				      _PAGE_COHERENT | _PAGE_GUARDED));
+
+		/* Insert into the hash table, primary slot */
+		slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags, 0,
+					  mmu_psize, ssize);
+
+		/* Primary is full, try the secondary */
+		if (unlikely(slot == -1)) {
+			hpte_group = ((~hash & htab_hash_mask) *
+				      HPTES_PER_GROUP) & ~0x7UL;
+			slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags,
+						  HPTE_V_SECONDARY,
+						  mmu_psize, ssize);
+			if (slot == -1) {
+				if (mftb() & 0x1)
+					hpte_group = ((hash & htab_hash_mask) *
+						      HPTES_PER_GROUP)&~0x7UL;
+
+				ppc_md.hpte_remove(hpte_group);
+				goto repeat;
+                        }
+		}
+
+		if (unlikely(slot == -2))
+			panic("hash_huge_page: pte_insert failed\n");
+
+		new_pte |= (slot << 12) & (_PAGE_F_SECOND | _PAGE_F_GIX);
+	}
+
+	/*
+	 * No need to use ldarx/stdcx here
+	 */
+	*ptep = __pte(new_pte & ~_PAGE_BUSY);
+
+	err = 0;
+
+ out:
+	return err;
+}
Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2009-09-28 13:53:16.000000000 +1000
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2009-09-28 13:53:21.000000000 +1000
@@ -7,29 +7,17 @@
  * Copyright (C) 2002, Rohit Seth <rohit.seth@intel.com>
  */
 
-#include <linux/init.h>
-#include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/io.h>
 #include <linux/hugetlb.h>
-#include <linux/pagemap.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/sysctl.h>
-#include <asm/mman.h>
+#include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
-#include <asm/tlbflush.h>
-#include <asm/mmu_context.h>
-#include <asm/machdep.h>
-#include <asm/cputable.h>
-#include <asm/spu.h>
 
 #define PAGE_SHIFT_64K	16
 #define PAGE_SHIFT_16M	24
 #define PAGE_SHIFT_16G	34
 
-#define NUM_LOW_AREAS	(0x100000000UL >> SID_SHIFT)
-#define NUM_HIGH_AREAS	(PGTABLE_RANGE >> HTLB_AREA_SHIFT)
 #define MAX_NUMBER_GPAGES	1024
 
 /* Tracks the 16G pages after the device tree is scanned and before the
@@ -507,158 +495,6 @@ unsigned long vma_mmu_pagesize(struct vm
 	return 1UL << mmu_psize_to_shift(psize);
 }
 
-/*
- * Called by asm hashtable.S for doing lazy icache flush
- */
-static unsigned int hash_huge_page_do_lazy_icache(unsigned long rflags,
-					pte_t pte, int trap, unsigned long sz)
-{
-	struct page *page;
-	int i;
-
-	if (!pfn_valid(pte_pfn(pte)))
-		return rflags;
-
-	page = pte_page(pte);
-
-	/* page is dirty */
-	if (!test_bit(PG_arch_1, &page->flags) && !PageReserved(page)) {
-		if (trap == 0x400) {
-			for (i = 0; i < (sz / PAGE_SIZE); i++)
-				__flush_dcache_icache(page_address(page+i));
-			set_bit(PG_arch_1, &page->flags);
-		} else {
-			rflags |= HPTE_R_N;
-		}
-	}
-	return rflags;
-}
-
-int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
-		     pte_t *ptep, unsigned long trap, int local, int ssize,
-		     unsigned int shift, unsigned int mmu_psize)
-{
-	unsigned long old_pte, new_pte;
-	unsigned long va, rflags, pa, sz;
-	long slot;
-	int err = 1;
-
-	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
-
-	/* Search the Linux page table for a match with va */
-	va = hpt_va(ea, vsid, ssize);
-
-	/* 
-	 * Check the user's access rights to the page.  If access should be
-	 * prevented then send the problem up to do_page_fault.
-	 */
-	if (unlikely(access & ~pte_val(*ptep)))
-		goto out;
-	/*
-	 * At this point, we have a pte (old_pte) which can be used to build
-	 * or update an HPTE. There are 2 cases:
-	 *
-	 * 1. There is a valid (present) pte with no associated HPTE (this is 
-	 *	the most common case)
-	 * 2. There is a valid (present) pte with an associated HPTE. The
-	 *	current values of the pp bits in the HPTE prevent access
-	 *	because we are doing software DIRTY bit management and the
-	 *	page is currently not DIRTY. 
-	 */
-
-
-	do {
-		old_pte = pte_val(*ptep);
-		if (old_pte & _PAGE_BUSY)
-			goto out;
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
-	} while(old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					 old_pte, new_pte));
-
-	rflags = 0x2 | (!(new_pte & _PAGE_RW));
- 	/* _PAGE_EXEC -> HW_NO_EXEC since it's inverted */
-	rflags |= ((new_pte & _PAGE_EXEC) ? 0 : HPTE_R_N);
-	sz = ((1UL) << shift);
-	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
-		/* No CPU has hugepages but lacks no execute, so we
-		 * don't need to worry about that case */
-		rflags = hash_huge_page_do_lazy_icache(rflags, __pte(old_pte),
-						       trap, sz);
-
-	/* Check if pte already has an hpte (case 2) */
-	if (unlikely(old_pte & _PAGE_HASHPTE)) {
-		/* There MIGHT be an HPTE for this pte */
-		unsigned long hash, slot;
-
-		hash = hpt_hash(va, shift, ssize);
-		if (old_pte & _PAGE_F_SECOND)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += (old_pte & _PAGE_F_GIX) >> 12;
-
-		if (ppc_md.hpte_updatepp(slot, rflags, va, mmu_psize,
-					 ssize, local) == -1)
-			old_pte &= ~_PAGE_HPTEFLAGS;
-	}
-
-	if (likely(!(old_pte & _PAGE_HASHPTE))) {
-		unsigned long hash = hpt_hash(va, shift, ssize);
-		unsigned long hpte_group;
-
-		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
-
-repeat:
-		hpte_group = ((hash & htab_hash_mask) *
-			      HPTES_PER_GROUP) & ~0x7UL;
-
-		/* clear HPTE slot informations in new PTE */
-#ifdef CONFIG_PPC_64K_PAGES
-		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HPTE_SUB0;
-#else
-		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
-#endif
-		/* Add in WIMG bits */
-		rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
-				      _PAGE_COHERENT | _PAGE_GUARDED));
-
-		/* Insert into the hash table, primary slot */
-		slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags, 0,
-					  mmu_psize, ssize);
-
-		/* Primary is full, try the secondary */
-		if (unlikely(slot == -1)) {
-			hpte_group = ((~hash & htab_hash_mask) *
-				      HPTES_PER_GROUP) & ~0x7UL; 
-			slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags,
-						  HPTE_V_SECONDARY,
-						  mmu_psize, ssize);
-			if (slot == -1) {
-				if (mftb() & 0x1)
-					hpte_group = ((hash & htab_hash_mask) *
-						      HPTES_PER_GROUP)&~0x7UL;
-
-				ppc_md.hpte_remove(hpte_group);
-				goto repeat;
-                        }
-		}
-
-		if (unlikely(slot == -2))
-			panic("hash_huge_page: pte_insert failed\n");
-
-		new_pte |= (slot << 12) & (_PAGE_F_SECOND | _PAGE_F_GIX);
-	}
-
-	/*
-	 * No need to use ldarx/stdcx here
-	 */
-	*ptep = __pte(new_pte & ~_PAGE_BUSY);
-
-	err = 0;
-
- out:
-	return err;
-}
-
 static int __init add_huge_page_size(unsigned long long size)
 {
 	int shift = __ffs(size);
Index: working-2.6/arch/powerpc/include/asm/hugetlb.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/hugetlb.h	2009-09-28 13:53:00.000000000 +1000
+++ working-2.6/arch/powerpc/include/asm/hugetlb.h	2009-09-28 13:53:21.000000000 +1000
@@ -13,6 +13,9 @@ static inline int hugepd_ok(hugepd_t hpd
 #define is_hugepd(pdep)               (hugepd_ok(*((hugepd_t *)(pdep))))
 #define HUGEPD_SHIFT_MASK     0x3f
 
+pte_t *huge_pte_offset_and_shift(struct mm_struct *mm,
+				 unsigned long addr, unsigned *shift);
+
 int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 			   unsigned long len);
 
