Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 82D44DDED4
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 20:53:34 +1000 (EST)
Date: Thu, 17 Jul 2008 12:53:25 +0200
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [patch] powerpc: lockless get_user_pages
Message-ID: <20080717105325.GB25083@wotan.suse.de>
References: <20080717104426.GA25083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080717104426.GA25083@wotan.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Together with the previous patch, I've tested this on mmotm, including
with 64K base pages.  However I only have a machine with a single possible
hugepage size, so testing a real multi size system would be nice.

Thanks to Dave for reworking for multiple hugepage sizes (Dave, I had to
make a small change to the slice shift calculation here).

--

powerpc: lockless get_user_pages_fast

Implement lockless get_user_pages_fast for powerpc. Page table existence is
guaranteed with RCU, and speculative page references are used to take a
reference to the pages without having a prior existence guarantee on them.

Signed-off-by: Nick Piggin <npiggin@suse.de>
Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                |    3 
 arch/powerpc/mm/Makefile            |    2 
 arch/powerpc/mm/gup.c               |  245 ++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/pgtable-ppc64.h |    2 
 include/linux/pagemap.h             |   23 +++
 6 files changed, 275 insertions(+), 2 deletions(-)

Index: linux-2.6/include/asm-powerpc/pgtable-ppc64.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/pgtable-ppc64.h	2008-07-17 20:30:06.000000000 +1000
+++ linux-2.6/include/asm-powerpc/pgtable-ppc64.h	2008-07-17 20:30:09.000000000 +1000
@@ -461,6 +461,8 @@
 	return pt;
 }
 
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long address);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_PPC64_H_ */
Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h	2008-07-17 20:30:06.000000000 +1000
+++ linux-2.6/include/linux/pagemap.h	2008-07-17 20:30:09.000000000 +1000
@@ -171,6 +171,29 @@
 	return 1;
 }
 
+/*
+ * Same as above, but add instead of inc (could just be merged)
+ */
+static inline int page_cache_add_speculative(struct page *page, int count)
+{
+	VM_BUG_ON(in_interrupt());
+
+#if !defined(CONFIG_SMP) && defined(CONFIG_CLASSIC_RCU)
+# ifdef CONFIG_PREEMPT
+	VM_BUG_ON(!in_atomic());
+# endif
+	VM_BUG_ON(page_count(page) == 0);
+	atomic_add(count, &page->_count);
+
+#else
+	if (unlikely(!atomic_add_unless(&page->_count, count, 0)))
+		return 0;
+#endif
+	VM_BUG_ON(PageCompound(page) && page != compound_head(page));
+
+	return 1;
+}
+
 static inline int page_freeze_refs(struct page *page, int count)
 {
 	return likely(atomic_cmpxchg(&page->_count, count, 0) == count);
Index: linux-2.6/arch/powerpc/mm/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/Makefile	2008-07-17 20:30:06.000000000 +1000
+++ linux-2.6/arch/powerpc/mm/Makefile	2008-07-17 20:30:09.000000000 +1000
@@ -6,7 +6,7 @@
 EXTRA_CFLAGS	+= -mno-minimal-toc
 endif
 
-obj-y				:= fault.o mem.o \
+obj-y				:= fault.o mem.o gup.o \
 				   init_$(CONFIG_WORD_SIZE).o \
 				   pgtable_$(CONFIG_WORD_SIZE).o \
 				   mmu_context_$(CONFIG_WORD_SIZE).o
Index: linux-2.6/arch/powerpc/mm/gup.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/powerpc/mm/gup.c	2008-07-17 20:30:09.000000000 +1000
@@ -0,0 +1,258 @@
+/*
+ * Lockless get_user_pages_fast for powerpc
+ *
+ * Copyright (C) 2008 Nick Piggin
+ * Copyright (C) 2008 Novell Inc.
+ */
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <linux/vmstat.h>
+#include <linux/pagemap.h>
+#include <linux/rwsem.h>
+#include <asm/pgtable.h>
+
+/*
+ * The performance critical leaf functions are made noinline otherwise gcc
+ * inlines everything into a single function which results in too much
+ * register pressure.
+ */
+static noinline int gup_pte_range(pmd_t pmd, unsigned long addr,
+		unsigned long end, int write, struct page **pages, int *nr)
+{
+	unsigned long mask, result;
+	pte_t *ptep;
+
+	result = _PAGE_PRESENT|_PAGE_USER;
+	if (write)
+		result |= _PAGE_RW;
+	mask = result | _PAGE_SPECIAL;
+
+	ptep = pte_offset_kernel(&pmd, addr);
+	do {
+		pte_t pte = *ptep;
+		struct page *page;
+
+		if ((pte_val(pte) & mask) != result)
+			return 0;
+		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
+		page = pte_page(pte);
+		if (!page_cache_get_speculative(page))
+			return 0;
+		if (unlikely(pte != *ptep)) {
+			put_page(page);
+			return 0;
+		}
+		pages[*nr] = page;
+		(*nr)++;
+
+	} while (ptep++, addr += PAGE_SIZE, addr != end);
+
+	return 1;
+}
+
+static noinline int gup_huge_pte(pte_t *ptep, struct hstate *hstate,
+				 unsigned long *addr, unsigned long end,
+				 int write, struct page **pages, int *nr)
+{
+	unsigned long mask;
+	unsigned long pte_end;
+	struct page *head, *page;
+	pte_t pte;
+	int refs;
+
+	pte_end = (*addr + huge_page_size(hstate)) & huge_page_mask(hstate);
+	if (pte_end < end)
+		end = pte_end;
+
+	pte = *ptep;
+	mask = _PAGE_PRESENT|_PAGE_USER;
+	if (write)
+		mask |= _PAGE_RW;
+	if ((pte_val(pte) & mask) != mask)
+		return 0;
+	/* hugepages are never "special" */
+	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
+
+	refs = 0;
+	head = pte_page(pte);
+	page = head + ((*addr & ~huge_page_mask(hstate)) >> PAGE_SHIFT);
+	do {
+		VM_BUG_ON(compound_head(page) != head);
+		pages[*nr] = page;
+		(*nr)++;
+		page++;
+		refs++;
+	} while (*addr += PAGE_SIZE, *addr != end);
+
+	if (!page_cache_add_speculative(head, refs)) {
+		*nr -= refs;
+		return 0;
+	}
+	if (unlikely(pte != *ptep)) {
+		/* Could be optimized better */
+		while (*nr) {
+			put_page(page);
+			(*nr)--;
+		}
+	}
+
+	return 1;
+}
+
+static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
+		int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	pmd_t *pmdp;
+
+	pmdp = pmd_offset(&pud, addr);
+	do {
+		pmd_t pmd = *pmdp;
+
+		next = pmd_addr_end(addr, end);
+		if (pmd_none(pmd))
+			return 0;
+		if (!gup_pte_range(pmd, addr, next, write, pages, nr))
+			return 0;
+	} while (pmdp++, addr = next, addr != end);
+
+	return 1;
+}
+
+static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
+		int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	pud_t *pudp;
+
+	pudp = pud_offset(&pgd, addr);
+	do {
+		pud_t pud = *pudp;
+
+		next = pud_addr_end(addr, end);
+		if (pud_none(pud))
+			return 0;
+		if (!gup_pmd_range(pud, addr, next, write, pages, nr))
+			return 0;
+	} while (pudp++, addr = next, addr != end);
+
+	return 1;
+}
+
+int get_user_pages_fast(unsigned long start, int nr_pages, int write,
+			struct page **pages)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long end = start + (nr_pages << PAGE_SHIFT);
+	unsigned long addr = start;
+	unsigned long next;
+	pgd_t *pgdp;
+	int nr = 0;
+	unsigned int shift;
+
+
+	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
+					start, nr_pages*PAGE_SIZE)))
+		goto slow_irqon;
+
+	/* Cross a slice boundary? */
+	if (addr < SLICE_LOW_TOP) {
+		if (end > SLICE_LOW_TOP)
+			goto slow_irqon;
+
+		if (unlikely(GET_LOW_SLICE_INDEX(addr) !=
+			     GET_LOW_SLICE_INDEX(end - 1)))
+			goto slow_irqon;
+	} else {
+		if (unlikely(GET_HIGH_SLICE_INDEX(addr) !=
+			     GET_HIGH_SLICE_INDEX(end - 1)))
+			goto slow_irqon;
+	}
+
+	/*
+	 * XXX: batch / limit 'nr', to avoid large irq off latency
+	 * needs some instrumenting to determine the common sizes used by
+	 * important workloads (eg. DB2), and whether limiting the batch size
+	 * will decrease performance.
+	 *
+	 * It seems like we're in the clear for the moment. Direct-IO is
+	 * the main guy that batches up lots of get_user_pages, and even
+	 * they are limited to 64-at-a-time which is not so many.
+	 */
+	/*
+	 * This doesn't prevent pagetable teardown, but does prevent
+	 * the pagetables from being freed on powerpc.
+	 *
+	 * So long as we atomically load page table pointers versus teardown,
+	 * we can follow the address down to the the page and take a ref on it.
+	 */
+	local_irq_disable();
+
+	shift = mmu_psize_defs[get_slice_psize(mm, addr)].shift;
+
+	if (shift > PAGE_SHIFT) {
+		pte_t *ptep;
+		unsigned long a = addr;
+		unsigned long sz = ((1UL) << shift);
+		struct hstate *hstate = size_to_hstate(sz);
+
+		BUG_ON(!hstate);
+		/*
+		 * XXX: could be optimized to avoid hstate
+		 * lookup entirely (just use shift)
+		 */
+
+		ptep = huge_pte_offset(mm, a);
+		do {
+			VM_BUG_ON(shift != mmu_psize_defs[get_slice_psize(mm, a)].shift);
+			if (!gup_huge_pte(ptep, hstate, &a, end, write, pages,
+					  &nr))
+				goto slow;
+			ptep++;
+		} while (a != end);
+	} else {
+		pgdp = pgd_offset(mm, addr);
+		do {
+			pgd_t pgd = *pgdp;
+
+			VM_BUG_ON(shift != mmu_psize_defs[get_slice_psize(mm, addr)].shift);
+
+			next = pgd_addr_end(addr, end);
+			if (pgd_none(pgd))
+				goto slow;
+			if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+				goto slow;
+		} while (pgdp++, addr = next, addr != end);
+	}
+	local_irq_enable();
+
+	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
+	return nr;
+
+	{
+		int ret;
+
+slow:
+		local_irq_enable();
+slow_irqon:
+		/* Try to get the remaining pages with get_user_pages */
+		start += nr << PAGE_SHIFT;
+		pages += nr;
+
+		down_read(&mm->mmap_sem);
+		ret = get_user_pages(current, mm, start,
+			(end - start) >> PAGE_SHIFT, write, 0, pages, NULL);
+		up_read(&mm->mmap_sem);
+
+		/* Have to be a bit careful with return values */
+		if (nr > 0) {
+			if (ret < 0)
+				ret = nr;
+			else
+				ret += nr;
+		}
+
+		return ret;
+	}
+}
Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig	2008-07-17 20:30:06.000000000 +1000
+++ linux-2.6/arch/powerpc/Kconfig	2008-07-17 20:30:09.000000000 +1000
@@ -42,6 +42,9 @@
 	bool
 	default y
 
+config HAVE_GET_USER_PAGES_FAST
+	def_bool PPC64
+
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool PPC64
 
