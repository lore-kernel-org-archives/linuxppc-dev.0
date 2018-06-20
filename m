Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419Vwk3zZSzF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 13:40:54 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5K3cm7r022811
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 23:40:51 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jqeegheu1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 23:40:51 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 20 Jun 2018 04:40:49 +0100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org
Subject: [PATCH] powerpc/mm: Initialize kernel pagetable memory for PTE
 fragments
Date: Wed, 20 Jun 2018 09:10:42 +0530
Message-Id: <20180620034042.17470-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kernel pagetable pages for PTE fragments never go through the standard init
sequence which can cause inaccuracies in utilization statistics reported at
places like /proc and /sysfs interfaces etc. Also the allocated page misses
out on pagetable lock and page flag init as well. Fix it by making sure all
pages allocated for either user process or kernel PTE fragments go through
same initialization.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable-book3s64.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index c1f4ca4..1e8f67c 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -335,23 +335,21 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
 
 static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 {
+	gfp_t gfp_mask = PGALLOC_GFP;
 	void *ret = NULL;
 	struct page *page;
 
-	if (!kernel) {
-		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
-		if (!page)
-			return NULL;
-		if (!pgtable_page_ctor(page)) {
-			__free_page(page);
-			return NULL;
-		}
-	} else {
-		page = alloc_page(PGALLOC_GFP);
-		if (!page)
-			return NULL;
-	}
+	if (!kernel)
+		gfp_mask |= __GFP_ACCOUNT;
 
+	page = alloc_page(gfp_mask);
+	if (!page)
+		return NULL;
+
+	if (!pgtable_page_ctor(page)) {
+		__free_page(page);
+		return NULL;
+	}
 
 	ret = page_address(page);
 	/*
-- 
1.8.3.1
