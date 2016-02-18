Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD8F31A04B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 03:51:48 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 18 Feb 2016 09:51:45 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 68DDE19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:39:41 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1IGphHH24707132
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 16:51:43 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1IGpgMu027212
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 11:51:43 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 13/30] powerpc/mm: Move hash64 specific definitions to
 separate header
Date: Thu, 18 Feb 2016 22:20:37 +0530
Message-Id: <1455814254-10226-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will be adding a radix variant of these routines in the followup
patches. Move the hash64 variant into its own header so that we can
rename them easily later. Also split pgalloc 64k and 4k headers

Reviewed-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 .../include/asm/book3s/64/pgalloc-hash-4k.h        |  92 ++++++++++
 .../include/asm/book3s/64/pgalloc-hash-64k.h       |  51 ++++++
 arch/powerpc/include/asm/book3s/64/pgalloc-hash.h  |  59 ++++++
 arch/powerpc/include/asm/book3s/64/pgalloc.h       | 199 +--------------------
 4 files changed, 210 insertions(+), 191 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgalloc-hash-4k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgalloc-hash-64k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgalloc-hash.h

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc-hash-4k.h b/arch/powerpc/include/asm/book3s/64/pgalloc-hash-4k.h
new file mode 100644
index 000000000000..d1d67e585ad4
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc-hash-4k.h
@@ -0,0 +1,92 @@
+#ifndef _ASM_POWERPC_BOOK3S_64_PGALLOC_HASH_4K_H
+#define _ASM_POWERPC_BOOK3S_64_PGALLOC_HASH_4K_H
+
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
+				pgtable_t pte_page)
+{
+	pmd_set(pmd, (unsigned long)page_address(pte_page));
+}
+
+static inline pgtable_t pmd_pgtable(pmd_t pmd)
+{
+	return pmd_page(pmd);
+}
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
+#endif /* _ASM_POWERPC_BOOK3S_64_PGALLOC_HASH_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc-hash-64k.h b/arch/powerpc/include/asm/book3s/64/pgalloc-hash-64k.h
new file mode 100644
index 000000000000..e2dab4f64316
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc-hash-64k.h
@@ -0,0 +1,51 @@
+#ifndef _ASM_POWERPC_BOOK3S_64_PGALLOC_HASH_64K_H
+#define _ASM_POWERPC_BOOK3S_64_PGALLOC_HASH_64K_H
+
+extern pte_t *page_table_alloc(struct mm_struct *, unsigned long, int);
+extern void page_table_free(struct mm_struct *, unsigned long *, int);
+extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
+#ifdef CONFIG_SMP
+extern void __tlb_remove_table(void *_table);
+#endif
+
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
+				pgtable_t pte_page)
+{
+	pmd_set(pmd, (unsigned long)pte_page);
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
+
+#endif /* _ASM_POWERPC_BOOK3S_64_PGALLOC_HASH_64K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc-hash.h b/arch/powerpc/include/asm/book3s/64/pgalloc-hash.h
new file mode 100644
index 000000000000..96f90c7e806f
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc-hash.h
@@ -0,0 +1,59 @@
+#ifndef _ASM_POWERPC_BOOK3S_64_PGALLOC_HASH_H
+#define _ASM_POWERPC_BOOK3S_64_PGALLOC_HASH_H
+
+/*
+ * FIXME!!
+ * Between 4K and 64K pages, we differ in what is stored in pmd. ie.
+ * typedef pte_t *pgtable_t; -> 64K
+ * typedef struct page *pgtable_t; -> 4k
+ */
+#ifdef CONFIG_PPC_64K_PAGES
+#include <asm/book3s/64/pgalloc-hash-64k.h>
+#else
+#include <asm/book3s/64/pgalloc-hash-4k.h>
+#endif
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
+static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
+				unsigned long address)
+{
+	return pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX);
+}
+
+static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
+				unsigned long address)
+{
+	pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE);
+}
+#endif /* _ASM_POWERPC_BOOK3S_64_PGALLOC_HASH_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 23b0dd07f9ae..ff3c0e36fe3d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -18,6 +18,11 @@ struct vmemmap_backing {
 };
 extern struct vmemmap_backing *vmemmap_list;
 
+static inline void check_pgt_cache(void)
+{
+
+}
+
 /*
  * Functions that deal with pagetables that could be at any level of
  * the table need to be passed an "index_size" so they know how to
@@ -41,32 +46,11 @@ extern struct kmem_cache *pgtable_cache[];
 			pgtable_cache[(shift) - 1];	\
 		})
 
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE), GFP_KERNEL);
-}
-
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
-}
-
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 {
 	pgd_set(pgd, (unsigned long)pud);
 }
 
-static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE),
-				GFP_KERNEL|__GFP_REPEAT);
-}
-
-static inline void pud_free(struct mm_struct *mm, pud_t *pud)
-{
-	kmem_cache_free(PGT_CACHE(PUD_INDEX_SIZE), pud);
-}
-
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
 	pud_set(pud, (unsigned long)pmd);
@@ -78,175 +62,8 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 	pmd_set(pmd, (unsigned long)pte);
 }
 
-/*
- * FIXME!!
- * Between 4K and 64K pages, we differ in what is stored in pmd. ie.
- * typedef pte_t *pgtable_t; -> 64K
- * typedef struct page *pgtable_t; -> 4k
- */
-#ifndef CONFIG_PPC_64K_PAGES
-
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-				pgtable_t pte_page)
-{
-	pmd_set(pmd, (unsigned long)page_address(pte_page));
-}
-
-static inline pgtable_t pmd_pgtable(pmd_t pmd)
-{
-	return pmd_page(pmd);
-}
-
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
-					  unsigned long address)
-{
-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO);
-}
-
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
-				      unsigned long address)
-{
-	struct page *page;
-	pte_t *pte;
-
-	pte = pte_alloc_one_kernel(mm, address);
-	if (!pte)
-		return NULL;
-	page = virt_to_page(pte);
-	if (!pgtable_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
-	}
-	return page;
-}
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long)pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
-{
-	pgtable_page_dtor(ptepage);
-	__free_page(ptepage);
-}
-
-static inline void pgtable_free(void *table, unsigned index_size)
-{
-	if (!index_size)
-		free_page((unsigned long)table);
-	else {
-		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
-		kmem_cache_free(PGT_CACHE(index_size), table);
-	}
-}
-
-#ifdef CONFIG_SMP
-static inline void pgtable_free_tlb(struct mmu_gather *tlb,
-				    void *table, int shift)
-{
-	unsigned long pgf = (unsigned long)table;
-	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
-	pgf |= shift;
-	tlb_remove_table(tlb, (void *)pgf);
-}
-
-static inline void __tlb_remove_table(void *_table)
-{
-	void *table = (void *)((unsigned long)_table & ~MAX_PGTABLE_INDEX_SIZE);
-	unsigned shift = (unsigned long)_table & MAX_PGTABLE_INDEX_SIZE;
-
-	pgtable_free(table, shift);
-}
-#else /* !CONFIG_SMP */
-static inline void pgtable_free_tlb(struct mmu_gather *tlb,
-				    void *table, int shift)
-{
-	pgtable_free(table, shift);
-}
-#endif /* CONFIG_SMP */
-
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
-				  unsigned long address)
-{
-	tlb_flush_pgtable(tlb, address);
-	pgtable_page_dtor(table);
-	pgtable_free_tlb(tlb, page_address(table), 0);
-}
-
-#else /* if CONFIG_PPC_64K_PAGES */
-
-extern pte_t *page_table_alloc(struct mm_struct *, unsigned long, int);
-extern void page_table_free(struct mm_struct *, unsigned long *, int);
-extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
-#ifdef CONFIG_SMP
-extern void __tlb_remove_table(void *_table);
+#ifdef CONFIG_PPC_STD_MMU_64
+#include <asm/book3s/64/pgalloc-hash.h>
 #endif
 
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-				pgtable_t pte_page)
-{
-	pmd_set(pmd, (unsigned long)pte_page);
-}
-
-static inline pgtable_t pmd_pgtable(pmd_t pmd)
-{
-	return (pgtable_t)pmd_page_vaddr(pmd);
-}
-
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
-					  unsigned long address)
-{
-	return (pte_t *)page_table_alloc(mm, address, 1);
-}
-
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
-					unsigned long address)
-{
-	return (pgtable_t)page_table_alloc(mm, address, 0);
-}
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	page_table_free(mm, (unsigned long *)pte, 1);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
-{
-	page_table_free(mm, (unsigned long *)ptepage, 0);
-}
-
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
-				  unsigned long address)
-{
-	tlb_flush_pgtable(tlb, address);
-	pgtable_free_tlb(tlb, table, 0);
-}
-#endif /* CONFIG_PPC_64K_PAGES */
-
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
-				GFP_KERNEL|__GFP_REPEAT);
-}
-
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-{
-	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
-}
-
-static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
-                                  unsigned long address)
-{
-        return pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX);
-}
-
-static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
-                                  unsigned long address)
-{
-        pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE);
-}
-
-#define check_pgt_cache()	do { } while (0)
-
-#endif /* _ASM_POWERPC_BOOK3S_64_PGALLOC_H */
+#endif /* __ASM_POWERPC_BOOK3S_64_PGALLOC_H */
-- 
2.5.0
