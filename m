Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 627C81A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 07:12:50 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 01:42:47 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8B56D125801E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:35 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9KKCjJD5702134
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:45 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9KKCiiH006386
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:45 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/7] powerpc/mm: Don't hardcode page table size
Date: Wed, 21 Oct 2015 01:42:27 +0530
Message-Id: <1445371953-9627-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pte and pmd table size are dependent on config items. Don't
hard code the same. This make sure we use the right value
when masking pmd entries and also while checking pmd_bad

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h    | 30 ++++++++++++++++++------
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h | 22 +++++++++++++----
 arch/powerpc/include/asm/pgalloc-64.h            | 10 --------
 arch/powerpc/mm/init_64.c                        |  4 ----
 4 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 957d66d13a97..565f9418c25f 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -25,12 +25,6 @@
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-/* Bits to mask out from a PMD to get to the PTE page */
-/* PMDs point to PTE table fragments which are 4K aligned.  */
-#define PMD_MASKED_BITS		0xfff
-/* Bits to mask out from a PGD/PUD to get to the PMD page */
-#define PUD_MASKED_BITS		0x1ff
-
 #define _PAGE_COMBO	0x00020000 /* this is a combo 4k page */
 #define _PAGE_4K_PFN	0x00040000 /* PFN is for a single 4k page */
 
@@ -44,6 +38,24 @@
  * of addressable physical space, or 46 bits for the special 4k PFNs.
  */
 #define PTE_RPN_SHIFT	(30)
+/*
+ * we support 8 fragments per PTE page of 64K size.
+ */
+#define PTE_FRAG_NR	8
+/*
+ * We use a 2K PTE page fragment and another 4K for storing
+ * real_pte_t hash index. Rounding the entire thing to 8K
+ */
+#define PTE_FRAG_SIZE_SHIFT  13
+#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
+
+/*
+ * Bits to mask out from a PMD to get to the PTE page
+ * PMDs point to PTE table fragments which are PTE_FRAG_SIZE aligned.
+ */
+#define PMD_MASKED_BITS		(PTE_FRAG_SIZE - 1)
+/* Bits to mask out from a PGD/PUD to get to the PMD page */
+#define PUD_MASKED_BITS		0x1ff
 
 #ifndef __ASSEMBLY__
 
@@ -112,8 +124,12 @@ static inline bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
 		remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,	\
 			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN)))
 
-#define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
+#define PTE_TABLE_SIZE	PTE_FRAG_SIZE
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define PMD_TABLE_SIZE	((sizeof(pmd_t) << PMD_INDEX_SIZE) + (sizeof(unsigned long) << PMD_INDEX_SIZE))
+#else
 #define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
+#endif
 #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
 
 #define pgd_pte(pgd)	(pud_pte(((pud_t){ pgd })))
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
index a44660d76096..1d8e26e8167b 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
@@ -9,8 +9,20 @@
 #define PUD_INDEX_SIZE	0
 #define PGD_INDEX_SIZE  12
 
+/*
+ * we support 8 fragments per PTE page of 64K size
+ */
+#define PTE_FRAG_NR	8
+/*
+ * We use a 2K PTE page fragment and another 4K for storing
+ * real_pte_t hash index. Rounding the entire thing to 8K
+ */
+#define PTE_FRAG_SIZE_SHIFT  13
+#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
+
+
 #ifndef __ASSEMBLY__
-#define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
+#define PTE_TABLE_SIZE	PTE_FRAG_SIZE
 #define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
 #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
 #endif	/* __ASSEMBLY__ */
@@ -32,9 +44,11 @@
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-/* Bits to mask out from a PMD to get to the PTE page */
-/* PMDs point to PTE table fragments which are 4K aligned.  */
-#define PMD_MASKED_BITS		0xfff
+/*
+ * Bits to mask out from a PMD to get to the PTE page
+ * PMDs point to PTE table fragments which are PTE_FRAG_SIZE aligned.
+ */
+#define PMD_MASKED_BITS		(PTE_FRAG_SIZE - 1)
 /* Bits to mask out from a PGD/PUD to get to the PMD page */
 #define PUD_MASKED_BITS		0x1ff
 
diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index 4f1cc6c46728..69ef28a81733 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -163,16 +163,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 }
 
 #else /* if CONFIG_PPC_64K_PAGES */
-/*
- * we support 8 fragments per PTE page.
- */
-#define PTE_FRAG_NR	8
-/*
- * We use a 2K PTE page fragment and another 4K for storing
- * real_pte_t hash index. Rounding the entire thing to 8K
- */
-#define PTE_FRAG_SIZE_SHIFT  13
-#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
 
 extern pte_t *page_table_alloc(struct mm_struct *, unsigned long, int);
 extern void page_table_free(struct mm_struct *, unsigned long *, int);
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index d747dd7bc90b..379a6a90644b 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -87,11 +87,7 @@ static void pgd_ctor(void *addr)
 
 static void pmd_ctor(void *addr)
 {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	memset(addr, 0, PMD_TABLE_SIZE * 2);
-#else
 	memset(addr, 0, PMD_TABLE_SIZE);
-#endif
 }
 
 struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
-- 
2.5.0
