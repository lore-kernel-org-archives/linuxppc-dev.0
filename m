Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4160L406S7zDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 20:32:11 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5EATQAb092867
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 06:32:09 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jkpakgv56-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 06:32:09 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 14 Jun 2018 04:32:08 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] powerpc/mm/hash/4k: Free hugetlb page table caches correctly.
Date: Thu, 14 Jun 2018 16:01:52 +0530
Message-Id: <20180614103152.7344-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With 4k page size for hugetlb we allocate hugepage directories from its on slab
cache. With patch 0c4d26802 ("powerpc/book3s64/mm: Simplify the rcu callback for page table free")
we missed to free these allocated hugepd tables.

Update pgtable_free to handle hugetlb hugepd directory table.

Fixes:  0c4d26802 ("powerpc/book3s64/mm: Simplify the rcu callback for page table free")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h  |  1 +
 .../include/asm/book3s/64/pgtable-4k.h        | 21 +++++++++++++++++++
 .../include/asm/book3s/64/pgtable-64k.h       |  9 ++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  5 +++++
 arch/powerpc/include/asm/nohash/32/pgalloc.h  |  1 +
 arch/powerpc/include/asm/nohash/64/pgalloc.h  |  1 +
 arch/powerpc/mm/hugetlbpage.c                 |  3 ++-
 arch/powerpc/mm/pgtable-book3s64.c            | 12 +++++++++++
 8 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 6a6673907e45..e4633803fe43 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -108,6 +108,7 @@ static inline void pgtable_free(void *table, unsigned index_size)
 }
 
 #define check_pgt_cache()	do { } while (0)
+#define get_hugepd_cache_index(x)  (x)
 
 #ifdef CONFIG_SMP
 static inline void pgtable_free_tlb(struct mmu_gather *tlb,
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
index af5f2baac80f..a069dfcac9a9 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
@@ -49,6 +49,27 @@ static inline int hugepd_ok(hugepd_t hpd)
 }
 #define is_hugepd(hpd)		(hugepd_ok(hpd))
 
+/*
+ * 16M and 16G huge page directory tables are allocated from slab cache
+ *
+ */
+#define H_16M_CACHE_INDEX (PAGE_SHIFT + H_PTE_INDEX_SIZE + H_PMD_INDEX_SIZE - 24)
+#define H_16G_CACHE_INDEX                                                      \
+	(PAGE_SHIFT + H_PTE_INDEX_SIZE + H_PMD_INDEX_SIZE + H_PUD_INDEX_SIZE - 34)
+
+static inline int get_hugepd_cache_index(int index)
+{
+	switch (index) {
+	case H_16M_CACHE_INDEX:
+		return HTLB_16M_INDEX;
+	case H_16G_CACHE_INDEX:
+		return HTLB_16G_INDEX;
+	default:
+		BUG();
+	}
+	/* should not reach */
+}
+
 #else /* !CONFIG_HUGETLB_PAGE */
 static inline int pmd_huge(pmd_t pmd) { return 0; }
 static inline int pud_huge(pud_t pud) { return 0; }
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index fb4b3ba52339..d7ee249d6890 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -45,8 +45,17 @@ static inline int hugepd_ok(hugepd_t hpd)
 {
 	return 0;
 }
+
 #define is_hugepd(pdep)			0
 
+/*
+ * This should never get called
+ */
+static inline int get_hugepd_cache_index(int index)
+{
+	BUG();
+}
+
 #else /* !CONFIG_HUGETLB_PAGE */
 static inline int pmd_huge(pmd_t pmd) { return 0; }
 static inline int pud_huge(pud_t pud) { return 0; }
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 42fe7c2ff2df..1022f622397f 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -287,6 +287,11 @@ enum pgtable_index {
 	PMD_INDEX,
 	PUD_INDEX,
 	PGD_INDEX,
+	/*
+	 * Below are used with 4k page size and hugetlb
+	 */
+	HTLB_16M_INDEX,
+	HTLB_16G_INDEX,
 };
 
 extern unsigned long __vmalloc_start;
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 1707781d2f20..9de40eb614da 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -109,6 +109,7 @@ static inline void pgtable_free(void *table, unsigned index_size)
 }
 
 #define check_pgt_cache()	do { } while (0)
+#define get_hugepd_cache_index(x)	(x)
 
 #ifdef CONFIG_SMP
 static inline void pgtable_free_tlb(struct mmu_gather *tlb,
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 0e693f322cb2..e2d62d033708 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -141,6 +141,7 @@ static inline void pgtable_free(void *table, int shift)
 	}
 }
 
+#define get_hugepd_cache_index(x)	(x)
 #ifdef CONFIG_SMP
 static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 {
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7c5f479c5c00..8a9a49c13865 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -337,7 +337,8 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
 	if (shift >= pdshift)
 		hugepd_free(tlb, hugepte);
 	else
-		pgtable_free_tlb(tlb, hugepte, pdshift - shift);
+		pgtable_free_tlb(tlb, hugepte,
+				 get_hugepd_cache_index(pdshift - shift));
 }
 
 static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index c1f4ca45c93a..468c3d83a2aa 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -409,6 +409,18 @@ static inline void pgtable_free(void *table, int index)
 	case PUD_INDEX:
 		kmem_cache_free(PGT_CACHE(PUD_CACHE_INDEX), table);
 		break;
+#ifdef CONFIG_PPC_4K_PAGES
+		/* 16M hugepd directory at pud level */
+	case HTLB_16M_INDEX:
+		BUILD_BUG_ON(H_16M_CACHE_INDEX <= 0);
+		kmem_cache_free(PGT_CACHE(H_16M_CACHE_INDEX), table);
+		break;
+		/* 16G hugepd directory at the pgd level */
+	case HTLB_16G_INDEX:
+		BUILD_BUG_ON(H_16G_CACHE_INDEX <= 0);
+		kmem_cache_free(PGT_CACHE(H_16G_CACHE_INDEX), table);
+		break;
+#endif
 		/* We don't free pgd table via RCU callback */
 	default:
 		BUG();
-- 
2.17.1
