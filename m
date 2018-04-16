Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PmMj4fj9zF1vf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 21:28:01 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3GBNJbe048204
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:00 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hcqhs1hxq-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:27:59 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 16 Apr 2018 07:27:58 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V1 04/11] powerpc/mm: Rename pte fragment functions
Date: Mon, 16 Apr 2018 16:57:17 +0530
In-Reply-To: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180416112724.9677-6-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We rename the alloc and get_from_cache to indicate they operate on pte
fragments. In later patch we will add pmd fragment support.

No functional change in this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable_64.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index a41784dd2042..3873f94a3ae9 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -314,7 +314,7 @@ struct page *pmd_page(pmd_t pmd)
 }
 
 #ifdef CONFIG_PPC_64K_PAGES
-static pte_t *get_from_cache(struct mm_struct *mm)
+static pte_t *get_pte_from_cache(struct mm_struct *mm)
 {
 	void *pte_frag, *ret;
 
@@ -333,7 +333,7 @@ static pte_t *get_from_cache(struct mm_struct *mm)
 	return (pte_t *)ret;
 }
 
-static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
+static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 {
 	void *ret = NULL;
 	struct page *page;
@@ -372,12 +372,13 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel
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
