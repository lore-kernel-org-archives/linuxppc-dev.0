Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxFrj6f6LzF1jR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 01:09:41 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w27E8pbS067224
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2018 09:09:39 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gjfev690c-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 09:09:38 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 09:09:35 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2] powerpc/mm/hugetlb: initialize the pagetable cache
 correctly for hugetlb
Date: Wed,  7 Mar 2018 19:39:25 +0530
Message-Id: <20180307140925.5755-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With 64k page size, we have hugetlb pte entries at the pmd and pud level for
book3s64. We don't need to create a separate page table cache for that. With 4k
we need to make sure hugepd page table cache for 16M is placed at PUD level
and 16G at the PGD level.

Simplify all these by not using HUGEPD_PD_SHIFT which is confusing for book3s64.

Without this patch, with 64k page size we create pagetable caches with shift
value 10 and 7 which are not used at all.

Fixes:419df06eea5bfa81("powerpc: Reduce the PTE_INDEX_SIZE")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 876da2bc1796..3b509b268030 100644
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
@@ -669,12 +666,24 @@ static int __init hugetlbpage_init(void)
 		if (add_huge_page_size(1ULL << shift) < 0)
 			continue;
 
+
+#ifdef CONFIG_PPC_BOOK3S_64
+		if (shift > PGDIR_SHIFT)
+			BUG();
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
 		/*
 		 * if we have pdshift and shift value same, we don't
 		 * use pgt cache for hugepd.
-- 
2.14.3
