Return-Path: <SRS0=KcrN=2N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C35C2D0C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Dec 2019 06:05:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4718620709
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Dec 2019 06:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4718620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47h83V3YzQzDqS2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Dec 2019 17:05:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=107.174.27.60; helo=ozlabs.ru;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.174.27.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 47h81Y3f8BzDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2019 17:03:59 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 46322AE80026;
 Mon, 23 Dec 2019 01:02:44 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3] powerpc/book3s64: Fix error handling in
 mm_iommu_do_alloc()
Date: Mon, 23 Dec 2019 17:03:51 +1100
Message-Id: <20191223060351.26359-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Jan Kara <jack@suse.cz>,
 kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The last jump to free_exit in mm_iommu_do_alloc() happens after page
pointers in struct mm_iommu_table_group_mem_t were already converted to
physical addresses. Thus calling put_page() on these physical addresses
will likely crash.

This moves the loop which calculates the pageshift and converts page
struct pointers to physical addresses later after the point when
we cannot fail; thus eliminating the need to convert pointers back.

Fixes: eb9d7a62c386 ("powerpc/mm_iommu: Fix potential deadlock")
Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* move pointers conversion after the last possible failure point
---
 arch/powerpc/mm/book3s64/iommu_api.c | 39 +++++++++++++++-------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/book3s64/iommu_api.c
index 56cc84520577..ef164851738b 100644
--- a/arch/powerpc/mm/book3s64/iommu_api.c
+++ b/arch/powerpc/mm/book3s64/iommu_api.c
@@ -121,24 +121,6 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 		goto free_exit;
 	}
 
-	pageshift = PAGE_SHIFT;
-	for (i = 0; i < entries; ++i) {
-		struct page *page = mem->hpages[i];
-
-		/*
-		 * Allow to use larger than 64k IOMMU pages. Only do that
-		 * if we are backed by hugetlb.
-		 */
-		if ((mem->pageshift > PAGE_SHIFT) && PageHuge(page))
-			pageshift = page_shift(compound_head(page));
-		mem->pageshift = min(mem->pageshift, pageshift);
-		/*
-		 * We don't need struct page reference any more, switch
-		 * to physical address.
-		 */
-		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
-	}
-
 good_exit:
 	atomic64_set(&mem->mapped, 1);
 	mem->used = 1;
@@ -158,6 +140,27 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 		}
 	}
 
+	if (mem->dev_hpa == MM_IOMMU_TABLE_INVALID_HPA) {
+		/*
+		 * Allow to use larger than 64k IOMMU pages. Only do that
+		 * if we are backed by hugetlb. Skip device memory as it is not
+		 * backed with page structs.
+		 */
+		pageshift = PAGE_SHIFT;
+		for (i = 0; i < entries; ++i) {
+			struct page *page = mem->hpages[i];
+
+			if ((mem->pageshift > PAGE_SHIFT) && PageHuge(page))
+				pageshift = page_shift(compound_head(page));
+			mem->pageshift = min(mem->pageshift, pageshift);
+			/*
+			 * We don't need struct page reference any more, switch
+			 * to physical address.
+			 */
+			mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
+		}
+	}
+
 	list_add_rcu(&mem->next, &mm->context.iommu_group_mem_list);
 
 	mutex_unlock(&mem_list_mutex);
-- 
2.17.1

