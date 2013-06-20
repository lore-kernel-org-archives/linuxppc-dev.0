Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5AD9A2C029B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:22 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 18:47:05 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EB1272BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:18 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K8kZrR6357378
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 18:46:35 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K91HuO000455
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:18 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V11 02/15] powerpc/THP: Double the PMD table size for THP
Date: Thu, 20 Jun 2013 14:30:14 +0530
Message-Id: <1371718827-15065-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1371718827-15065-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1371718827-15065-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

THP code does PTE page allocation along with large page request and deposit them
for later use. This is to ensure that we won't have any failures when we split
hugepages to regular pages.

On powerpc we want to use the deposited PTE page for storing hash pte slot and
secondary bit information for the HPTEs. We use the second half
of the pmd table to save the deposted PTE page.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgalloc-64.h        | 6 +++---
 arch/powerpc/include/asm/pgtable-ppc64-64k.h | 3 ++-
 arch/powerpc/include/asm/pgtable-ppc64.h     | 6 +++++-
 arch/powerpc/mm/init_64.c                    | 9 ++++++---
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index b66ae72..f65e27b 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -221,17 +221,17 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PMD_INDEX_SIZE),
+	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
 				GFP_KERNEL|__GFP_REPEAT);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
-	kmem_cache_free(PGT_CACHE(PMD_INDEX_SIZE), pmd);
+	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
 }
 
 #define __pmd_free_tlb(tlb, pmd, addr)		      \
-	pgtable_free_tlb(tlb, pmd, PMD_INDEX_SIZE)
+	pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX)
 #ifndef CONFIG_PPC_64K_PAGES
 #define __pud_free_tlb(tlb, pud, addr)		      \
 	pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/pgtable-ppc64-64k.h b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
index 45142d6..a56b82f 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-64k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
@@ -33,7 +33,8 @@
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 /* Bits to mask out from a PMD to get to the PTE page */
-#define PMD_MASKED_BITS		0x1ff
+/* PMDs point to PTE table fragments which are 4K aligned.  */
+#define PMD_MASKED_BITS		0xfff
 /* Bits to mask out from a PGD/PUD to get to the PMD page */
 #define PUD_MASKED_BITS		0x1ff
 
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index e3d55f6f..ab84332 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -20,7 +20,11 @@
                 	    PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
 #define PGTABLE_RANGE (ASM_CONST(1) << PGTABLE_EADDR_SIZE)
 
-
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define PMD_CACHE_INDEX	(PMD_INDEX_SIZE + 1)
+#else
+#define PMD_CACHE_INDEX	PMD_INDEX_SIZE
+#endif
 /*
  * Define the address range of the kernel non-linear virtual area
  */
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index a90b9c4..d0cd9e4 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -88,7 +88,11 @@ static void pgd_ctor(void *addr)
 
 static void pmd_ctor(void *addr)
 {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	memset(addr, 0, PMD_TABLE_SIZE * 2);
+#else
 	memset(addr, 0, PMD_TABLE_SIZE);
+#endif
 }
 
 struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
@@ -137,10 +141,9 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 void pgtable_cache_init(void)
 {
 	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
-	pgtable_cache_add(PMD_INDEX_SIZE, pmd_ctor);
-	if (!PGT_CACHE(PGD_INDEX_SIZE) || !PGT_CACHE(PMD_INDEX_SIZE))
+	pgtable_cache_add(PMD_CACHE_INDEX, pmd_ctor);
+	if (!PGT_CACHE(PGD_INDEX_SIZE) || !PGT_CACHE(PMD_CACHE_INDEX))
 		panic("Couldn't allocate pgtable caches");
-
 	/* In all current configs, when the PUD index exists it's the
 	 * same size as either the pgd or pmd index.  Verify that the
 	 * initialization above has also created a PUD cache.  This
-- 
1.8.1.2
