Return-Path: <prvs=06277935a1=aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40CKzR5vQ6zF1sc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 23:04:19 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2UC39Xp125237
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 08:04:17 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h1hrvqd84-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 08:04:17 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 30 Mar 2018 08:04:16 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3] powerpc/mm/hugetlb: initialize the pagetable cache
 correctly for hugetlb
Date: Fri, 30 Mar 2018 17:34:08 +0530
Message-Id: <20180330120408.25036-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

With 64k page size, we have hugetlb pte entries at the pmd and pud level for
book3s64. We don't need to create a separate page table cache for that. With 4k
we need to make sure hugepd page table cache for 16M is placed at PUD level
and 16G at the PGD level.

Simplify all these by not using HUGEPD_PD_SHIFT which is confusing for book3s64.

Without this patch, with 64k page size we create pagetable caches with shift
value 10 and 7 which are not used at all.

Fixes: 419df06eea5b ("powerpc: Reduce the PTE_INDEX_SIZE")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index f4153f21d214..99cf86096970 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -122,9 +122,6 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 #define HUGEPD_PGD_SHIFT PGDIR_SHIFT
 #define HUGEPD_PUD_SHIFT PUD_SHIFT
-#else
-#define HUGEPD_PGD_SHIFT PUD_SHIFT
-#define HUGEPD_PUD_SHIFT PMD_SHIFT
 #endif
 
 /*
@@ -670,15 +667,26 @@ static int __init hugetlbpage_init(void)
 
 		shift = mmu_psize_to_shift(psize);
 
-		if (add_huge_page_size(1ULL << shift) < 0)
+#ifdef CONFIG_PPC_BOOK3S_64
+		if (shift > PGDIR_SHIFT)
 			continue;
-
+		else if (shift > PUD_SHIFT)
+			pdshift = PGDIR_SHIFT;
+		else if (shift > PMD_SHIFT)
+			pdshift = PUD_SHIFT;
+		else
+			pdshift = PMD_SHIFT;
+#else
 		if (shift < HUGEPD_PUD_SHIFT)
 			pdshift = PMD_SHIFT;
 		else if (shift < HUGEPD_PGD_SHIFT)
 			pdshift = PUD_SHIFT;
 		else
 			pdshift = PGDIR_SHIFT;
+#endif
+
+		if (add_huge_page_size(1ULL << shift) < 0)
+			continue;
 		/*
 		 * if we have pdshift and shift value same, we don't
 		 * use pgt cache for hugepd.
-- 
2.14.3
