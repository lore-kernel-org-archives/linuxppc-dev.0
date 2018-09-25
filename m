Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KRsy5ftKzF1pS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 02:51:18 +1000 (AEST)
Message-Id: <cda95a5508594e2a2ad5f6f214c435d9a1b44c46.1537892499.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537892498.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 18/22] powerpc/mm: Extend pte_fragment functionality to
 nohash/32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Sep 2018 16:51:14 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to allow the 8xx to handle pte_fragments, this patch
extends the use of pte_fragments to nohash/32 platforms.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu_context.h       |  2 +-
 arch/powerpc/include/asm/nohash/32/mmu-40x.h |  1 +
 arch/powerpc/include/asm/nohash/32/mmu-44x.h |  1 +
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  1 +
 arch/powerpc/include/asm/nohash/32/mmu.h     |  4 ++-
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 52 +++++++++++++---------------
 arch/powerpc/include/asm/nohash/32/pgtable.h | 11 ++++--
 arch/powerpc/include/asm/nohash/mmu-book3e.h |  1 +
 arch/powerpc/mm/Makefile                     |  3 ++
 arch/powerpc/mm/mmu_context_nohash.c         | 14 ++++++++
 10 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b2f89b621b15..7f2c37a3f99d 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -222,7 +222,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
 	return 0;
 }
 
-#ifndef CONFIG_PPC_BOOK3S_64
+#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_BOOK3S_32)
 static inline void arch_exit_mmap(struct mm_struct *mm)
 {
 }
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-40x.h b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
index 74f4edb5916e..7c77ceed71d6 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
@@ -58,6 +58,7 @@ typedef struct {
 	unsigned int	id;
 	unsigned int	active;
 	unsigned long	vdso_base;
+	void *pte_frag;
 } mm_context_t;
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-44x.h b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
index 295b3dbb2698..3d72e889ae7b 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-44x.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
@@ -109,6 +109,7 @@ typedef struct {
 	unsigned int	id;
 	unsigned int	active;
 	unsigned long	vdso_base;
+	void *pte_frag;
 } mm_context_t;
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index fa05aa566ece..750cef6f65e3 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -179,6 +179,7 @@ typedef struct {
 	unsigned int id;
 	unsigned int active;
 	unsigned long vdso_base;
+	void *pte_frag;
 #ifdef CONFIG_PPC_MM_SLICES
 	u16 user_psize;		/* page size index */
 	unsigned char low_slices_psize[SLICE_ARRAY_SIZE];
diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
index f61f933a4cd8..7d94a36d57d2 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_NOHASH_32_MMU_H_
 #define _ASM_POWERPC_NOHASH_32_MMU_H_
 
+#include <asm/page.h>
+
 #if defined(CONFIG_40x)
 /* 40x-style software loaded TLB */
 #include <asm/nohash/32/mmu-40x.h>
@@ -17,7 +19,7 @@
 #endif
 
 #ifndef __ASSEMBLY__
-typedef struct page *pgtable_t;
+typedef pte_t *pgtable_t;
 #endif
 
 #endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 78367855a4f3..77c09bef3122 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -28,6 +28,10 @@ extern void __bad_pte(pmd_t *pmd);
 extern struct kmem_cache *pgtable_cache[];
 #define PGT_CACHE(shift) pgtable_cache[shift]
 
+void pte_frag_destroy(void *pte_frag);
+pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel);
+void pte_fragment_free(unsigned long *table, int kernel);
+
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
@@ -59,11 +63,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pte_page)
 {
-	*pmdp = __pmd((page_to_pfn(pte_page) << PAGE_SHIFT) | _PMD_USER |
-		      _PMD_PRESENT);
+	*pmdp = __pmd(__pa(pte_page) | _PMD_USER | _PMD_PRESENT);
 }
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
+#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 #else
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
@@ -75,49 +78,38 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pte_page)
 {
-	*pmdp = __pmd((unsigned long)lowmem_page_address(pte_page) | _PMD_PRESENT);
+	*pmdp = __pmd((unsigned long)pte_page | _PMD_PRESENT);
 }
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
+#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 #endif
 
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
+					  unsigned long address)
 {
-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	return (pte_t *)pte_fragment_alloc(mm, address, 1);
 }
 
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
+				      unsigned long address)
 {
-	struct page *ptepage;
-
-	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
-
-	ptepage = alloc_pages(flags, 0);
-	if (!ptepage)
-		return NULL;
-	if (!pgtable_page_ctor(ptepage)) {
-		__free_page(ptepage);
-		return NULL;
-	}
-	return ptepage;
+	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
 }
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_page((unsigned long)pte);
+	pte_fragment_free((unsigned long *)pte, 1);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 {
-	pgtable_page_dtor(ptepage);
-	__free_page(ptepage);
+	pte_fragment_free((unsigned long *)ptepage, 0);
 }
 
 static inline void pgtable_free(void *table, unsigned index_size)
 {
 	if (!index_size) {
-		pgtable_page_dtor(virt_to_page(table));
-		free_page((unsigned long)table);
+		pte_fragment_free((unsigned long *)table, 0);
 	} else {
 		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
 		kmem_cache_free(PGT_CACHE(index_size), table);
@@ -156,18 +148,22 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
 	tlb_flush_pgtable(tlb, address);
-	pgtable_free_tlb(tlb, page_address(table), 0);
+	pgtable_free_tlb(tlb, table, 0);
 }
 
 static inline pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va)
 {
 	if (!pmd_present(*pmdp)) {
-		pte_t *ptep = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
+		pte_t *ptep = __va(memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE));
 
 		if (!ptep)
 			return NULL;
 
-		clear_page(ptep);
+		if (PTE_FRAG_SIZE == PAGE_SIZE)
+			clear_page(ptep);
+		else
+			memset(ptep, 0, PTE_FRAG_SIZE);
+
 		pmd_populate_kernel(&init_mm, pmdp, ptep);
 	}
 	return pte_offset_kernel(pmdp, va);
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index d2908a8038e8..97fdc9b05a14 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -20,6 +20,10 @@ extern int icache_44x_need_flush;
 #endif /* __ASSEMBLY__ */
 
 #define PTE_INDEX_SIZE	PTE_SHIFT
+#define PTE_FRAG_NR		1
+#define PTE_FRAG_SIZE_SHIFT	PAGE_SHIFT
+#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
+
 #define PMD_INDEX_SIZE	0
 #define PUD_INDEX_SIZE	0
 #define PGD_INDEX_SIZE	(32 - PGDIR_SHIFT)
@@ -336,12 +340,12 @@ static inline int pte_young(pte_t pte)
  */
 #ifndef CONFIG_BOOKE
 #define pmd_page_vaddr(pmd)	\
-	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+	((unsigned long)__va(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
 #define pmd_page(pmd)		\
 	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 #else
 #define pmd_page_vaddr(pmd)	\
-	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
+	((unsigned long)(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
 #define pmd_page(pmd)		\
 	pfn_to_page((__pa(pmd_val(pmd)) >> PAGE_SHIFT))
 #endif
@@ -360,7 +364,8 @@ static inline int pte_young(pte_t pte)
 	(pmd_bad(*(dir)) ? NULL : (pte_t *)pmd_page_vaddr(*(dir)) + \
 				  pte_index(addr))
 #define pte_offset_map(dir, addr)		\
-	((pte_t *) kmap_atomic(pmd_page(*(dir))) + pte_index(addr))
+	((pte_t *)(kmap_atomic(pmd_page(*(dir))) + \
+		   (pmd_page_vaddr(*(dir)) & ~PAGE_MASK)) + pte_index(addr))
 #define pte_unmap(pte)		kunmap_atomic(pte)
 
 /*
diff --git a/arch/powerpc/include/asm/nohash/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-book3e.h
index e20072972e35..8e8aad5172ab 100644
--- a/arch/powerpc/include/asm/nohash/mmu-book3e.h
+++ b/arch/powerpc/include/asm/nohash/mmu-book3e.h
@@ -230,6 +230,7 @@ typedef struct {
 	unsigned int	id;
 	unsigned int	active;
 	unsigned long	vdso_base;
+	void *pte_frag;
 } mm_context_t;
 
 /* Page size definitions, common between 32 and 64-bit
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index db2f001183d1..9ce26baf8547 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -18,6 +18,9 @@ obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o \
 				   $(hash64-y) mmu_context_book3s64.o \
 				   pgtable-book3s64.o pgtable-frag.o
+ifndef CONFIG_PPC_BOOK3S_32
+obj-$(CONFIG_PPC32)		+= pgtable-frag.o
+endif
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 4d80239ef83c..c434c254adce 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -51,6 +51,7 @@
 
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
+#include <asm/pgalloc.h>
 
 #include "mmu_decl.h"
 
@@ -385,6 +386,7 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
 #endif
 	mm->context.id = MMU_NO_CONTEXT;
 	mm->context.active = 0;
+	mm->context.pte_frag = NULL;
 	return 0;
 }
 
@@ -487,3 +489,15 @@ void __init mmu_context_init(void)
 	nr_free_contexts = LAST_CONTEXT - FIRST_CONTEXT + 1;
 }
 
+#ifdef CONFIG_PPC32
+void arch_exit_mmap(struct mm_struct *mm)
+{
+	void *frag;
+
+	frag = mm->context.pte_frag;
+	if (frag)
+		pte_frag_destroy(frag);
+
+	return;
+}
+#endif
-- 
2.13.3
