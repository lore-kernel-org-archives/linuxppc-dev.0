Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PmN062Z4zF1vZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 21:28:16 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3GBNEp2061728
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:13 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hcs5unetv-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:13 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 16 Apr 2018 07:28:12 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V1 08/11] powerpc/book3s64/mm: Simplify the rcu callback for
 page table free
Date: Mon, 16 Apr 2018 16:57:21 +0530
In-Reply-To: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180416112724.9677-10-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Instead of encoding shift in the table address, use an enumerated index value.
This allow us to do different things in the callback for pte and pmd.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 10 +++----
 arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++++
 arch/powerpc/mm/pgtable-book3s64.c           | 45 ++++++++++++++++------------
 3 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 826171568192..ed313b8d3fac 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -124,14 +124,14 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 }
 
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
-                                  unsigned long address)
+				  unsigned long address)
 {
 	/*
 	 * By now all the pud entries should be none entries. So go
 	 * ahead and flush the page walk cache
 	 */
 	flush_tlb_pgtable(tlb, address);
-	pgtable_free_tlb(tlb, pud, PUD_CACHE_INDEX);
+	pgtable_free_tlb(tlb, pud, PUD_INDEX);
 }
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -146,14 +146,14 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 }
 
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
-                                  unsigned long address)
+				  unsigned long address)
 {
 	/*
 	 * By now all the pud entries should be none entries. So go
 	 * ahead and flush the page walk cache
 	 */
 	flush_tlb_pgtable(tlb, address);
-        return pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX);
+	return pgtable_free_tlb(tlb, pmd, PMD_INDEX);
 }
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
@@ -203,7 +203,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 	 * ahead and flush the page walk cache
 	 */
 	flush_tlb_pgtable(tlb, address);
-	pgtable_free_tlb(tlb, table, 0);
+	pgtable_free_tlb(tlb, table, PTE_INDEX);
 }
 
 #define check_pgt_cache()	do { } while (0)
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 47b5ffc8715d..9462bc18806c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -273,6 +273,16 @@ extern unsigned long __pte_frag_size_shift;
 /* Bits to mask out from a PGD to get to the PUD page */
 #define PGD_MASKED_BITS		0xc0000000000000ffUL
 
+/*
+ * Used as an indicator for rcu callback functions
+ */
+enum pgtable_index {
+	PTE_INDEX = 0,
+	PMD_INDEX,
+	PUD_INDEX,
+	PGD_INDEX,
+};
+
 extern unsigned long __vmalloc_start;
 extern unsigned long __vmalloc_end;
 #define VMALLOC_START	__vmalloc_start
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index fc42cccb96c7..0a05e99b54a1 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -309,38 +309,45 @@ void pte_fragment_free(unsigned long *table, int kernel)
 	}
 }
 
+static inline void pgtable_free(void *table, int index)
+{
+	switch (index) {
+	case PTE_INDEX:
+		pte_fragment_free(table, 0);
+		break;
+	case PMD_INDEX:
+		kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), table);
+		break;
+	case PUD_INDEX:
+		kmem_cache_free(PGT_CACHE(PUD_CACHE_INDEX), table);
+		break;
+		/* We don't free pgd table via RCU callback */
+	default:
+		BUG();
+	}
+}
+
 #ifdef CONFIG_SMP
-void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
+void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
 {
 	unsigned long pgf = (unsigned long)table;
 
-	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
-	pgf |= shift;
+	BUG_ON(index > MAX_PGTABLE_INDEX_SIZE);
+	pgf |= index;
 	tlb_remove_table(tlb, (void *)pgf);
 }
 
 void __tlb_remove_table(void *_table)
 {
 	void *table = (void *)((unsigned long)_table & ~MAX_PGTABLE_INDEX_SIZE);
-	unsigned int shift = (unsigned long)_table & MAX_PGTABLE_INDEX_SIZE;
+	unsigned int index = (unsigned long)_table & MAX_PGTABLE_INDEX_SIZE;
 
-	if (!shift)
-		/* PTE page needs special handling */
-		pte_fragment_free(table, 0);
-	else {
-		BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
-		kmem_cache_free(PGT_CACHE(shift), table);
-	}
+	return pgtable_free(table, index);
 }
 #else
-void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
+void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
 {
-	if (!shift) {
-		/* PTE page needs special handling */
-		pte_fragment_free(table, 0);
-	} else {
-		BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
-		kmem_cache_free(PGT_CACHE(shift), table);
-	}
+
+	return pgtable_free(table, index);
 }
 #endif
-- 
2.14.3
