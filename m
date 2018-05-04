Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cs051KC3zDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 22:34:28 +1000 (AEST)
Message-Id: <8955044d4d18afa0fc413d9401669156c990a243.1525435203.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH BAD 17/17] powerpc/mm: Use pte_fragment_alloc() on 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  4 May 2018 14:34:24 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DO NOT APPLY THAT ONE, IT BUGS. But comments are welcome.


In 16k pages mode, the 8xx still need only 4k for the page table.

This patch makes use of the pte_fragment functions in order
to avoid wasting memory space

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu-8xx.h           |  4 ++++
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 29 +++++++++++++++++++++++++++-
 arch/powerpc/include/asm/nohash/32/pgtable.h |  5 ++++-
 arch/powerpc/mm/mmu_context_nohash.c         |  4 ++++
 arch/powerpc/mm/pgtable.c                    | 10 +++++++++-
 arch/powerpc/mm/pgtable_32.c                 | 12 ++++++++++++
 arch/powerpc/platforms/Kconfig.cputype       |  1 +
 7 files changed, 62 insertions(+), 3 deletions(-)

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
index 1c6461e7c6aa..1e3b8f580499 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -93,6 +93,32 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
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
 
@@ -106,11 +132,12 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
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
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 3efd616bbc80..e2a22c8dc7f6 100644
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
@@ -303,7 +306,7 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
  */
 #ifndef CONFIG_BOOKE
 #define pmd_page_vaddr(pmd)	\
-	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+	((unsigned long) __va(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
 #define pmd_page(pmd)		\
 	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 #else
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
index 7172b04c91b5..eff6210ad3c0 100644
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
