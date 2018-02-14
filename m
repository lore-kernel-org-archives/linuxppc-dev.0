Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhLQD5TLmzF1Gk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 00:50:28 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1EDnAGg021676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 08:50:26 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g4nw0sbgj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 08:50:25 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 14 Feb 2018 08:50:24 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/6] powerpc/mm: Rename pte fragment functions
Date: Wed, 14 Feb 2018 19:20:04 +0530
In-Reply-To: <20180214135009.32748-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180214135009.32748-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180214135009.32748-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We rename the alloc and get_from_cache to indicate they operate on pte
fragments. In later patch we will add pmd fragment support.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable_64.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index a0f8928c0b86..330ef1d1daf5 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -322,7 +322,7 @@ struct page *pmd_page(pmd_t pmd)
 }
 
 #ifdef CONFIG_PPC_64K_PAGES
-static pte_t *get_from_cache(struct mm_struct *mm)
+static pte_t *get_pte_from_cache(struct mm_struct *mm)
 {
 	void *pte_frag, *ret;
 
@@ -341,7 +341,7 @@ static pte_t *get_from_cache(struct mm_struct *mm)
 	return (pte_t *)ret;
 }
 
-static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
+static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 {
 	void *ret = NULL;
 	struct page *page;
@@ -380,12 +380,13 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel
 {
 	pte_t *pte;
 
-	pte = get_from_cache(mm);
+	pte = get_pte_from_cache(mm);
 	if (pte)
 		return pte;
 
-	return __alloc_for_cache(mm, kernel);
+	return __alloc_for_ptecache(mm, kernel);
 }
+
 #endif /* CONFIG_PPC_64K_PAGES */
 
 void pte_fragment_free(unsigned long *table, int kernel)
-- 
2.14.3
