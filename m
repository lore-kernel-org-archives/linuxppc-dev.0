Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfX6h2QT5zF0gg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 02:00:44 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1BEwgOZ071867
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 10:00:42 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g2exvkrmy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 10:00:41 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 11 Feb 2018 08:00:41 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 4/4] powerpc/mm/hash64: memset the pagetable pages on
 allocation.
Date: Sun, 11 Feb 2018 20:30:09 +0530
In-Reply-To: <20180211150009.21297-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180211150009.21297-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180211150009.21297-4-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we are using second half of the table to store slot details and we
don't clear them in the huge_pte_get_and_clear, we need to make sure we zero
out the range on allocation.

Simplify this by calling the object initialization after kmem_cache_alloc and
update the constructor do nothing.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 16 +++++++++++++
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 34 +++++++++++++++++++++++-----
 arch/powerpc/include/asm/nohash/pgalloc.h    | 16 +++++++++++++
 arch/powerpc/mm/init-common.c                | 15 ------------
 4 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 5073cc75f1c8..9f5c411bce1b 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -139,4 +139,20 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 	pgtable_page_dtor(table);
 	pgtable_free_tlb(tlb, page_address(table), 0);
 }
+
+static inline void pgd_ctor(void *addr)
+{
+	memset(addr, 0, PGD_TABLE_SIZE);
+}
+
+static inline void pud_ctor(void *addr)
+{
+	memset(addr, 0, PUD_TABLE_SIZE);
+}
+
+static inline void pmd_ctor(void *addr)
+{
+	memset(addr, 0, PMD_TABLE_SIZE);
+}
+
 #endif /* _ASM_POWERPC_BOOK3S_32_PGALLOC_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 53df86d3cfce..d6ee7563b09d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -73,10 +73,13 @@ static inline void radix__pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
+	pgd_t *pgd;
 	if (radix_enabled())
 		return radix__pgd_alloc(mm);
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
-		pgtable_gfp_flags(mm, GFP_KERNEL));
+	pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+			       pgtable_gfp_flags(mm, GFP_KERNEL));
+	memset(pgd, 0, PGD_TABLE_SIZE);
+	return pgd;
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
@@ -93,8 +96,11 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PUD_CACHE_INDEX),
-		pgtable_gfp_flags(mm, GFP_KERNEL));
+	pud_t *pud;
+	pud = kmem_cache_alloc(PGT_CACHE(PUD_CACHE_INDEX),
+			       pgtable_gfp_flags(mm, GFP_KERNEL));
+	memset(pud, 0, PUD_TABLE_SIZE);
+	return pud;
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
@@ -120,8 +126,12 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
-		pgtable_gfp_flags(mm, GFP_KERNEL));
+	pmd_t *pmd;
+	pmd = kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
+			       pgtable_gfp_flags(mm, GFP_KERNEL));
+	memset(pmd, 0, PMD_TABLE_SIZE);
+	return pmd;
+
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
@@ -218,4 +228,16 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 
 #define check_pgt_cache()	do { } while (0)
 
+static inline void pgd_ctor(void *addr)
+{
+}
+
+static inline void pud_ctor(void *addr)
+{
+}
+
+static inline void pmd_ctor(void *addr)
+{
+}
+
 #endif /* _ASM_POWERPC_BOOK3S_64_PGALLOC_H */
diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/include/asm/nohash/pgalloc.h
index 0634f2949438..df3be548ff97 100644
--- a/arch/powerpc/include/asm/nohash/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/pgalloc.h
@@ -21,4 +21,20 @@ static inline void tlb_flush_pgtable(struct mmu_gather *tlb,
 #else
 #include <asm/nohash/32/pgalloc.h>
 #endif
+
+static inline void pgd_ctor(void *addr)
+{
+	memset(addr, 0, PGD_TABLE_SIZE);
+}
+
+static inline void pud_ctor(void *addr)
+{
+	memset(addr, 0, PUD_TABLE_SIZE);
+}
+
+static inline void pmd_ctor(void *addr)
+{
+	memset(addr, 0, PMD_TABLE_SIZE);
+}
+
 #endif /* _ASM_POWERPC_NOHASH_PGALLOC_H */
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 2b656e67f2ea..f92dd8cee3c5 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -25,21 +25,6 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
-static void pgd_ctor(void *addr)
-{
-	memset(addr, 0, PGD_TABLE_SIZE);
-}
-
-static void pud_ctor(void *addr)
-{
-	memset(addr, 0, PUD_TABLE_SIZE);
-}
-
-static void pmd_ctor(void *addr)
-{
-	memset(addr, 0, PMD_TABLE_SIZE);
-}
-
 struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
 EXPORT_SYMBOL_GPL(pgtable_cache);	/* used by kvm_hv module */
 
-- 
2.14.3
