Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m9761YvMzF14x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 20:05:53 +1000 (AEST)
Message-Id: <c275de01c2c8d9710b7bf85711b27d1335501d40.1526464250.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1526464250.git.christophe.leroy@c-s.fr>
References: <cover.1526464250.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 13/14] powerpc/mm: Use pte_fragment_alloc() on 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 May 2018 12:05:49 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In 16k page size mode, the 8xx need only 4k for a page table.

This patch makes use of the pte_fragment functions in order
to avoid wasting memory space

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu-8xx.h           |  4 +++
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 44 +++++++++++++++++++++++++++-
 arch/powerpc/include/asm/nohash/32/pgtable.h | 10 ++++++-
 arch/powerpc/mm/mmu_context_nohash.c         |  4 +++
 arch/powerpc/mm/pgtable.c                    | 10 ++++++-
 arch/powerpc/mm/pgtable_32.c                 | 12 ++++++++
 arch/powerpc/platforms/Kconfig.cputype       |  1 +
 7 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index 193f53116c7a..4f4cb754afd8 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -190,6 +190,10 @@ typedef struct {
 	struct slice_mask mask_8m;
 # endif
 #endif
+#ifdef CONFIG_NEED_PTE_FRAG
+	/* for 4K PTE fragment support */
+	void *pte_frag;
+#endif
 } mm_context_t;
 
 #define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 81c19d6460bd..d65b5f29008c 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -69,11 +69,22 @@ static inline void pmd_populate_kernel_g(struct mm_struct *mm, pmd_t *pmdp,
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pte_page)
 {
+#ifdef CONFIG_NEED_PTE_FRAG
+	*pmdp = __pmd(__pa(pte_page) | _PMD_USER | _PMD_PRESENT);
+#else
 	*pmdp = __pmd((page_to_pfn(pte_page) << PAGE_SHIFT) | _PMD_USER |
 		      _PMD_PRESENT);
+#endif
 }
 
+#ifdef CONFIG_NEED_PTE_FRAG
+static inline pgtable_t pmd_pgtable(pmd_t pmd)
+{
+	return (pgtable_t)pmd_page_vaddr(pmd);
+}
+#else
 #define pmd_pgtable(pmd) pmd_page(pmd)
+#endif
 #else
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
@@ -95,6 +106,32 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel_g(pmd, address))? \
 		NULL: pte_offset_kernel(pmd, address))
 
+#ifdef CONFIG_NEED_PTE_FRAG
+extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
+extern void pte_fragment_free(unsigned long *, int);
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
+					  unsigned long address)
+{
+	return (pte_t *)pte_fragment_alloc(mm, address, 1);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
+				      unsigned long address)
+{
+	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
+}
+
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+	pte_fragment_free((unsigned long *)pte, 1);
+}
+
+static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
+{
+	pte_fragment_free((unsigned long *)ptepage, 0);
+}
+#else
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
 extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
 
@@ -108,11 +145,12 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 	pgtable_page_dtor(ptepage);
 	__free_page(ptepage);
 }
+#endif
 
 static inline void pgtable_free(void *table, unsigned index_size)
 {
 	if (!index_size) {
-		free_page((unsigned long)table);
+		pte_free_kernel(NULL, table);
 	} else {
 		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
 		kmem_cache_free(PGT_CACHE(index_size), table);
@@ -150,7 +188,11 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
 	tlb_flush_pgtable(tlb, address);
+#ifdef CONFIG_NEED_PTE_FRAG
+	pgtable_free_tlb(tlb, table, 0);
+#else
 	pgtable_page_dtor(table);
 	pgtable_free_tlb(tlb, page_address(table), 0);
+#endif
 }
 #endif /* _ASM_POWERPC_PGALLOC_32_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 5872d79360a9..ab5671e14fa1 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -20,6 +20,9 @@ extern int icache_44x_need_flush;
 
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
 #define PTE_INDEX_SIZE  (PTE_SHIFT - 2)
+#define PTE_FRAG_NR		4
+#define PTE_FRAG_SIZE_SHIFT	12
+#define PTE_FRAG_SIZE		(1UL << PTE_FRAG_SIZE_SHIFT)
 #else
 #define PTE_INDEX_SIZE	PTE_SHIFT
 #endif
@@ -319,7 +322,7 @@ static inline int pte_young(pte_t pte)
  */
 #ifndef CONFIG_BOOKE
 #define pmd_page_vaddr(pmd)	\
-	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+	((unsigned long) __va(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
 #define pmd_page(pmd)		\
 	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 #else
@@ -342,9 +345,14 @@ static inline int pte_young(pte_t pte)
 #define pte_offset_kernel(dir, addr)	\
 	(pmd_bad(*(dir)) ? NULL : (pte_t *)pmd_page_vaddr(*(dir)) + \
 				  pte_index(addr))
+#ifdef CONFIG_NEED_PTE_FRAG
+#define pte_offset_map(dir, addr)	pte_offset_kernel(dir, addr)
+#define pte_unmap(pte)		do {} while (0)
+#else
 #define pte_offset_map(dir, addr)		\
 	((pte_t *) kmap_atomic(pmd_page(*(dir))) + pte_index(addr))
 #define pte_unmap(pte)		kunmap_atomic(pte)
+#endif
 
 /*
  * Encode and decode a swap entry.
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index e09228a9ad00..8b0ab33673e5 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -390,6 +390,9 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
 #endif
 	mm->context.id = MMU_NO_CONTEXT;
 	mm->context.active = 0;
+#ifdef CONFIG_NEED_PTE_FRAG
+	mm->context.pte_frag = NULL;
+#endif
 	return 0;
 }
 
@@ -418,6 +421,7 @@ void destroy_context(struct mm_struct *mm)
 		nr_free_contexts++;
 	}
 	raw_spin_unlock_irqrestore(&context_lock, flags);
+	destroy_pagetable_page(mm);
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 2d34755ed727..96cc5aa73331 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -23,6 +23,7 @@
 
 #include <linux/kernel.h>
 #include <linux/gfp.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
@@ -320,10 +321,17 @@ static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
 	return (pte_t *)ret;
 }
 
-pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
+__ref pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
 {
 	pte_t *pte;
 
+	if (kernel && !slab_is_available()) {
+		pte = __va(memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE));
+		if (pte)
+			memset(pte, 0, PTE_FRAG_SIZE);
+
+		return pte;
+	}
 	pte = get_from_cache(mm);
 	if (pte)
 		return pte;
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 3aa0c78db95d..5c8737cf2945 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -40,6 +40,17 @@
 
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
+#ifdef CONFIG_NEED_PTE_FRAG
+void pte_fragment_free(unsigned long *table, int kernel)
+{
+	struct page *page = virt_to_page(table);
+	if (put_page_testzero(page)) {
+		if (!kernel)
+			pgtable_page_dtor(page);
+		free_unref_page(page);
+	}
+}
+#else
 __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
 	pte_t *pte;
@@ -69,6 +80,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 	}
 	return ptepage;
 }
+#endif
 
 #ifdef CONFIG_PPC_GUARDED_PAGE_IN_PMD
 int __pte_alloc_kernel_g(pmd_t *pmd, unsigned long address)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 906f0ebd1e08..40cebb461bcb 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -340,6 +340,7 @@ config PPC_MM_SLICES
 config NEED_PTE_FRAG
 	bool
 	default y if PPC_BOOK3S_64 && PPC_64K_PAGES
+	default y if PPC_8xx && PPC_16K_PAGES
 	default n
 
 config PPC_HAVE_PMU_SUPPORT
-- 
2.13.3
