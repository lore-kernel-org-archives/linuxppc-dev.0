Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhLQX6gbmzF1Gk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 00:50:44 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1EDmnDK064950
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 08:50:42 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g4n6r39fd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 08:50:42 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 14 Feb 2018 08:50:41 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 5/6] powerpc/mm: Use page fragments for allocation page
 table at PMD level
Date: Wed, 14 Feb 2018 19:20:08 +0530
In-Reply-To: <20180214135009.32748-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180214135009.32748-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180214135009.32748-6-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 9 ++-------
 arch/powerpc/mm/init-common.c                | 2 --
 arch/powerpc/mm/pgtable_64.c                 | 2 +-
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index e5d104caae26..f91a8bc1d67f 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -128,17 +128,12 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	pmd_t *pmd;
-	pmd = kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
-			       pgtable_gfp_flags(mm, GFP_KERNEL));
-	memset(pmd, 0, PMD_TABLE_SIZE);
-	return pmd;
-
+	return pmd_fragment_alloc(mm, addr);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
-	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
+	pmd_fragment_free((unsigned long *)pmd);
 }
 
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index f92dd8cee3c5..0382df3ef6a8 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -78,8 +78,6 @@ void pgtable_cache_init(void)
 {
 	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
 
-	if (PMD_CACHE_INDEX && !PGT_CACHE(PMD_CACHE_INDEX))
-		pgtable_cache_add(PMD_CACHE_INDEX, pmd_ctor);
 	/*
 	 * In all current configs, when the PUD index exists it's the
 	 * same size as either the pgd or pmd index except with THP enabled
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index db3ee7ab8418..05267a8764f5 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -524,7 +524,7 @@ void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
 		pte_fragment_free(table, 0);
 		break;
 	case PMD_INDEX:
-		kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), table);
+		pmd_fragment_free(table);
 		break;
 	case PUD_INDEX:
 		kmem_cache_free(PGT_CACHE(PUD_CACHE_INDEX), table);
-- 
2.14.3
