Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrm529RhzDt2V
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:43:49 +1000 (AEST)
Received: from pps.filterd (m0048817.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58Ed2DM038630
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:43:46 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9mfam5u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:43:46 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:43:45 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 03/16] mm/mmu_gather: Track page size with mmu gather and
 force flush if page size change
Date: Wed,  8 Jun 2016 20:13:10 +0530
In-Reply-To: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465397003-26812-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows arch which need to do special handing with respect to
different page size when flushing tlb to implement the same in mmu gather

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/arm/include/asm/tlb.h  | 12 ++++++++++++
 arch/ia64/include/asm/tlb.h | 12 ++++++++++++
 arch/s390/include/asm/tlb.h | 13 +++++++++++++
 arch/sh/include/asm/tlb.h   | 12 ++++++++++++
 arch/um/include/asm/tlb.h   | 12 ++++++++++++
 include/asm-generic/tlb.h   | 27 +++++++++++++++++++++------
 mm/huge_memory.c            |  2 +-
 mm/hugetlb.c                |  2 +-
 mm/memory.c                 | 10 +++++++++-
 9 files changed, 93 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index a9d2aee3826f..1e25cd80589e 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -225,12 +225,24 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	}
 }
 
+static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
+					  struct page *page, int page_size)
+{
+	return __tlb_remove_page(tlb, page);
+}
+
 static inline bool __tlb_remove_pte_page(struct mmu_gather *tlb,
 					 struct page *page)
 {
 	return __tlb_remove_page(tlb, page);
 }
 
+static inline void tlb_remove_page_size(struct mmu_gather *tlb,
+					struct page *page, int page_size)
+{
+	return tlb_remove_page(tlb, page);
+}
+
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 	unsigned long addr)
 {
diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
index e7da41aa9110..77e541cf0e5d 100644
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -242,12 +242,24 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	}
 }
 
+static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
+					  struct page *page, int page_size)
+{
+	return __tlb_remove_page(tlb, page);
+}
+
 static inline bool __tlb_remove_pte_page(struct mmu_gather *tlb,
 					 struct page *page)
 {
 	return __tlb_remove_page(tlb, page);
 }
 
+static inline void tlb_remove_page_size(struct mmu_gather *tlb,
+					struct page *page, int page_size)
+{
+	return tlb_remove_page(tlb, page);
+}
+
 /*
  * Remove TLB entry for PTE mapped at virtual address ADDRESS.  This is called for any
  * PTE, not just those pointing to (normal) physical memory.
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 30759b560849..15711de10403 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -98,11 +98,24 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	free_page_and_swap_cache(page);
 }
 
+static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
+					  struct page *page, int page_size)
+{
+	return __tlb_remove_page(tlb, page);
+}
+
 static inline bool __tlb_remove_pte_page(struct mmu_gather *tlb,
 					 struct page *page)
 {
 	return __tlb_remove_page(tlb, page);
 }
+
+static inline void tlb_remove_page_size(struct mmu_gather *tlb,
+					struct page *page, int page_size)
+{
+	return tlb_remove_page(tlb, page);
+}
+
 /*
  * pte_free_tlb frees a pte table and clears the CRSTE for the
  * page table from the tlb.
diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
index 21ae8f5546b2..025cdb1032f6 100644
--- a/arch/sh/include/asm/tlb.h
+++ b/arch/sh/include/asm/tlb.h
@@ -109,12 +109,24 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	__tlb_remove_page(tlb, page);
 }
 
+static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
+					  struct page *page, int page_size)
+{
+	return __tlb_remove_page(tlb, page);
+}
+
 static inline bool __tlb_remove_pte_page(struct mmu_gather *tlb,
 					 struct page *page)
 {
 	return __tlb_remove_page(tlb, page);
 }
 
+static inline void tlb_remove_page_size(struct mmu_gather *tlb,
+					struct page *page, int page_size)
+{
+	return tlb_remove_page(tlb, page);
+}
+
 #define pte_free_tlb(tlb, ptep, addr)	pte_free((tlb)->mm, ptep)
 #define pmd_free_tlb(tlb, pmdp, addr)	pmd_free((tlb)->mm, pmdp)
 #define pud_free_tlb(tlb, pudp, addr)	pud_free((tlb)->mm, pudp)
diff --git a/arch/um/include/asm/tlb.h b/arch/um/include/asm/tlb.h
index 3dc4cbb3c2c0..821ff0acfe17 100644
--- a/arch/um/include/asm/tlb.h
+++ b/arch/um/include/asm/tlb.h
@@ -110,12 +110,24 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	__tlb_remove_page(tlb, page);
 }
 
+static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
+					  struct page *page, int page_size)
+{
+	return __tlb_remove_page(tlb, page);
+}
+
 static inline bool __tlb_remove_pte_page(struct mmu_gather *tlb,
 					 struct page *page)
 {
 	return __tlb_remove_page(tlb, page);
 }
 
+static inline void tlb_remove_page_size(struct mmu_gather *tlb,
+					struct page *page, int page_size)
+{
+	return tlb_remove_page(tlb, page);
+}
+
 /**
  * tlb_remove_tlb_entry - remember a pte unmapping for later tlb invalidation.
  *
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 7b899a46a4cb..c6d667187608 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -112,6 +112,7 @@ struct mmu_gather {
 	 * that that we can adjust the range after the flush
 	 */
 	unsigned long addr;
+	int page_size;
 };
 
 #define HAVE_GENERIC_MMU_GATHER
@@ -120,7 +121,8 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm, unsigned long
 void tlb_flush_mmu(struct mmu_gather *tlb);
 void tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start,
 							unsigned long end);
-bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page);
+extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
+				   int page_size);
 
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
 				      unsigned long address)
@@ -145,23 +147,36 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
 	}
 }
 
+static inline void tlb_remove_page_size(struct mmu_gather *tlb,
+					struct page *page, int page_size)
+{
+	if (__tlb_remove_page_size(tlb, page, page_size)) {
+		tlb_flush_mmu(tlb);
+		tlb->page_size = page_size;
+		__tlb_adjust_range(tlb, tlb->addr);
+		__tlb_remove_page_size(tlb, page, page_size);
+	}
+}
+
+static bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+{
+	return __tlb_remove_page_size(tlb, page, PAGE_SIZE);
+}
+
 /* tlb_remove_page
  *	Similar to __tlb_remove_page but will call tlb_flush_mmu() itself when
  *	required.
  */
 static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 {
-	if (__tlb_remove_page(tlb, page)) {
-		tlb_flush_mmu(tlb);
-		__tlb_adjust_range(tlb, tlb->addr);
-		__tlb_remove_page(tlb, page);
-	}
+	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
 }
 
 static inline bool __tlb_remove_pte_page(struct mmu_gather *tlb, struct page *page)
 {
 	/* active->nr should be zero when we call this */
 	VM_BUG_ON_PAGE(tlb->active->nr, page);
+	tlb->page_size = PAGE_SIZE;
 	__tlb_adjust_range(tlb, tlb->addr);
 	return __tlb_remove_page(tlb, page);
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9ed58530f695..a5711093a829 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1694,7 +1694,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		pte_free(tlb->mm, pgtable_trans_huge_withdraw(tlb->mm, pmd));
 		atomic_long_dec(&tlb->mm->nr_ptes);
 		spin_unlock(ptl);
-		tlb_remove_page(tlb, page);
+		tlb_remove_page_size(tlb, page, HPAGE_PMD_SIZE);
 	}
 	return 1;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 741429d01668..cab0b1861670 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3211,7 +3211,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		page_remove_rmap(page, true);
 
 		spin_unlock(ptl);
-		tlb_remove_page(tlb, page);
+		tlb_remove_page_size(tlb, page, huge_page_size(h));
 		/*
 		 * Bail out after unmapping reference page if supplied
 		 */
diff --git a/mm/memory.c b/mm/memory.c
index 8e78a3bc75b3..c2e7ea955f06 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -233,6 +233,7 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm, unsigned long
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 	tlb->batch = NULL;
 #endif
+	tlb->page_size = 0;
 
 	__tlb_reset_range(tlb);
 }
@@ -294,12 +295,19 @@ void tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long e
  *	When out of page slots we must call tlb_flush_mmu().
  *returns true if the caller should flush.
  */
-bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size)
 {
 	struct mmu_gather_batch *batch;
 
 	VM_BUG_ON(!tlb->end);
 
+	if (!tlb->page_size)
+		tlb->page_size = page_size;
+	else {
+		if (page_size != tlb->page_size)
+			return true;
+	}
+
 	batch = tlb->active;
 	if (batch->nr == batch->max) {
 		if (!tlb_next_batch(tlb))
-- 
2.7.4
