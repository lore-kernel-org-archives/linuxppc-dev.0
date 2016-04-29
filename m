Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyQ4J4hzDqBR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 50/70] powerpc/mm: Make a copy of pgalloc.h for 32 and 64
 book3s
Date: Fri, 29 Apr 2016 23:26:13 +1000
Message-Id: <1461936393-10131-50-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This patch start to make a book3s variant for pgalloc headers. We have
multiple book3s specific changes such as:
  * 4 level page table
  * store physical address in higher level table
  * use pte_t * for pgtable_t

Having a book3s64 specific variant helps to keep code simpler and remove
lots of #ifdef around code.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 109 +++++++++++
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 266 +++++++++++++++++++++++++++
 2 files changed, 375 insertions(+)
 create mode 100644 arch/powerpc/include/asm/book3s/32/pgalloc.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgalloc.h

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
new file mode 100644
index 000000000000..76d6b9e0c8a9
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -0,0 +1,109 @@
+#ifndef _ASM_POWERPC_PGALLOC_32_H
+#define _ASM_POWERPC_PGALLOC_32_H
+
+#include <linux/threads.h>
+
+/* For 32-bit, all levels of page tables are just drawn from get_free_page() */
+#define MAX_PGTABLE_INDEX_SIZE	0
+
+extern void __bad_pte(pmd_t *pmd);
+
+extern pgd_t *pgd_alloc(struct mm_struct *mm);
+extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
+
+/*
+ * We don't have any real pmd's, and this code never triggers because
+ * the pgd will always be present..
+ */
+/* #define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); }) */
+#define pmd_free(mm, x) 		do { } while (0)
+#define __pmd_free_tlb(tlb,x,a)		do { } while (0)
+/* #define pgd_populate(mm, pmd, pte)      BUG() */
+
+#ifndef CONFIG_BOOKE
+
+static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
+				       pte_t *pte)
+{
+	*pmdp = __pmd(__pa(pte) | _PMD_PRESENT);
+}
+
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
+				pgtable_t pte_page)
+{
+	*pmdp = __pmd((page_to_pfn(pte_page) << PAGE_SHIFT) | _PMD_PRESENT);
+}
+
+#define pmd_pgtable(pmd) pmd_page(pmd)
+#else
+
+static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
+				       pte_t *pte)
+{
+	*pmdp = __pmd((unsigned long)pte | _PMD_PRESENT);
+}
+
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
+				pgtable_t pte_page)
+{
+	*pmdp = __pmd((unsigned long)lowmem_page_address(pte_page) | _PMD_PRESENT);
+}
+
+#define pmd_pgtable(pmd) pmd_page(pmd)
+#endif
+
+extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
+extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
+
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+	free_page((unsigned long)pte);
+}
+
+static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
+{
+	pgtable_page_dtor(ptepage);
+	__free_page(ptepage);
+}
+
+static inline void pgtable_free(void *table, unsigned index_size)
+{
+	BUG_ON(index_size); /* 32-bit doesn't use this */
+	free_page((unsigned long)table);
+}
+
+#define check_pgt_cache()	do { } while (0)
+
+#ifdef CONFIG_SMP
+static inline void pgtable_free_tlb(struct mmu_gather *tlb,
+				    void *table, int shift)
+{
+	unsigned long pgf = (unsigned long)table;
+	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
+	pgf |= shift;
+	tlb_remove_table(tlb, (void *)pgf);
+}
+
+static inline void __tlb_remove_table(void *_table)
+{
+	void *table = (void *)((unsigned long)_table & ~MAX_PGTABLE_INDEX_SIZE);
+	unsigned shift = (unsigned long)_table & MAX_PGTABLE_INDEX_SIZE;
+
+	pgtable_free(table, shift);
+}
+#else
+static inline void pgtable_free_tlb(struct mmu_gather *tlb,
+				    void *table, int shift)
+{
+	pgtable_free(table, shift);
+}
+#endif
+
+static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
+				  unsigned long address)
+{
+	tlb_flush_pgtable(tlb, address);
+	pgtable_page_dtor(table);
+	pgtable_free_tlb(tlb, page_address(table), 0);
+}
+#endif /* _ASM_POWERPC_PGALLOC_32_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
new file mode 100644
index 000000000000..8d5fc3ac43da
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -0,0 +1,266 @@
+#ifndef _ASM_POWERPC_PGALLOC_64_H
+#define _ASM_POWERPC_PGALLOC_64_H
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/slab.h>
+#include <linux/cpumask.h>
+#include <linux/percpu.h>
+
+struct vmemmap_backing {
+	struct vmemmap_backing *list;
+	unsigned long phys;
+	unsigned long virt_addr;
+};
+extern struct vmemmap_backing *vmemmap_list;
+
+/*
+ * Functions that deal with pagetables that could be at any level of
+ * the table need to be passed an "index_size" so they know how to
+ * handle allocation.  For PTE pages (which are linked to a struct
+ * page for now, and drawn from the main get_free_pages() pool), the
+ * allocation size will be (2^index_size * sizeof(pointer)) and
+ * allocations are drawn from the kmem_cache in PGT_CACHE(index_size).
+ *
+ * The maximum index size needs to be big enough to allow any
+ * pagetable sizes we need, but small enough to fit in the low bits of
+ * any page table pointer.  In other words all pagetables, even tiny
+ * ones, must be aligned to allow at least enough low 0 bits to
+ * contain this value.  This value is also used as a mask, so it must
+ * be one less than a power of two.
+ */
+#define MAX_PGTABLE_INDEX_SIZE	0xf
+
+extern struct kmem_cache *pgtable_cache[];
+#define PGT_CACHE(shift) ({				\
+			BUG_ON(!(shift));		\
+			pgtable_cache[(shift) - 1];	\
+		})
+
+static inline pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE), GFP_KERNEL);
+}
+
+static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
+}
+
+#ifndef CONFIG_PPC_64K_PAGES
+
+#define pgd_populate(MM, PGD, PUD)	pgd_set(PGD, __pgtable_ptr_val(PUD))
+
+static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE),
+				GFP_KERNEL|__GFP_REPEAT);
+}
+
+static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+{
+	kmem_cache_free(PGT_CACHE(PUD_INDEX_SIZE), pud);
+}
+
+static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
+{
+	pud_set(pud, __pgtable_ptr_val(pmd));
+}
+
+static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
+				       pte_t *pte)
+{
+	pmd_set(pmd, __pgtable_ptr_val(pte));
+}
+
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
+				pgtable_t pte_page)
+{
+	pmd_set(pmd, __pgtable_ptr_val(page_address(pte_page)));
+}
+
+#define pmd_pgtable(pmd) pmd_page(pmd)
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
+					  unsigned long address)
+{
+	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
+				      unsigned long address)
+{
+	struct page *page;
+	pte_t *pte;
+
+	pte = pte_alloc_one_kernel(mm, address);
+	if (!pte)
+		return NULL;
+	page = virt_to_page(pte);
+	if (!pgtable_page_ctor(page)) {
+		__free_page(page);
+		return NULL;
+	}
+	return page;
+}
+
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+	free_page((unsigned long)pte);
+}
+
+static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
+{
+	pgtable_page_dtor(ptepage);
+	__free_page(ptepage);
+}
+
+static inline void pgtable_free(void *table, unsigned index_size)
+{
+	if (!index_size)
+		free_page((unsigned long)table);
+	else {
+		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
+		kmem_cache_free(PGT_CACHE(index_size), table);
+	}
+}
+
+#ifdef CONFIG_SMP
+static inline void pgtable_free_tlb(struct mmu_gather *tlb,
+				    void *table, int shift)
+{
+	unsigned long pgf = (unsigned long)table;
+	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
+	pgf |= shift;
+	tlb_remove_table(tlb, (void *)pgf);
+}
+
+static inline void __tlb_remove_table(void *_table)
+{
+	void *table = (void *)((unsigned long)_table & ~MAX_PGTABLE_INDEX_SIZE);
+	unsigned shift = (unsigned long)_table & MAX_PGTABLE_INDEX_SIZE;
+
+	pgtable_free(table, shift);
+}
+#else /* !CONFIG_SMP */
+static inline void pgtable_free_tlb(struct mmu_gather *tlb,
+				    void *table, int shift)
+{
+	pgtable_free(table, shift);
+}
+#endif /* CONFIG_SMP */
+
+static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
+				  unsigned long address)
+{
+	tlb_flush_pgtable(tlb, address);
+	pgtable_page_dtor(table);
+	pgtable_free_tlb(tlb, page_address(table), 0);
+}
+
+#else /* if CONFIG_PPC_64K_PAGES */
+
+extern pte_t *page_table_alloc(struct mm_struct *, unsigned long, int);
+extern void page_table_free(struct mm_struct *, unsigned long *, int);
+extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
+#ifdef CONFIG_SMP
+extern void __tlb_remove_table(void *_table);
+#endif
+
+#ifndef __PAGETABLE_PUD_FOLDED
+/* book3s 64 is 4 level page table */
+static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
+{
+	pgd_set(pgd, __pgtable_ptr_val(pud));
+}
+
+static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE),
+				GFP_KERNEL|__GFP_REPEAT);
+}
+
+static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+{
+	kmem_cache_free(PGT_CACHE(PUD_INDEX_SIZE), pud);
+}
+#endif
+
+static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
+{
+	pud_set(pud, __pgtable_ptr_val(pmd));
+}
+
+static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
+				       pte_t *pte)
+{
+	pmd_set(pmd, __pgtable_ptr_val(pte));
+}
+
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
+				pgtable_t pte_page)
+{
+	pmd_set(pmd, __pgtable_ptr_val(pte_page));
+}
+
+static inline pgtable_t pmd_pgtable(pmd_t pmd)
+{
+	return (pgtable_t)pmd_page_vaddr(pmd);
+}
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
+					  unsigned long address)
+{
+	return (pte_t *)page_table_alloc(mm, address, 1);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
+					unsigned long address)
+{
+	return (pgtable_t)page_table_alloc(mm, address, 0);
+}
+
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+	page_table_free(mm, (unsigned long *)pte, 1);
+}
+
+static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
+{
+	page_table_free(mm, (unsigned long *)ptepage, 0);
+}
+
+static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
+				  unsigned long address)
+{
+	tlb_flush_pgtable(tlb, address);
+	pgtable_free_tlb(tlb, table, 0);
+}
+#endif /* CONFIG_PPC_64K_PAGES */
+
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
+				GFP_KERNEL|__GFP_REPEAT);
+}
+
+static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+{
+	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
+}
+
+#define __pmd_free_tlb(tlb, pmd, addr)		      \
+	pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX)
+#ifndef __PAGETABLE_PUD_FOLDED
+#define __pud_free_tlb(tlb, pud, addr)		      \
+	pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE)
+
+#endif /* __PAGETABLE_PUD_FOLDED */
+
+#define check_pgt_cache()	do { } while (0)
+
+#endif /* _ASM_POWERPC_PGALLOC_64_H */
-- 
2.5.0
