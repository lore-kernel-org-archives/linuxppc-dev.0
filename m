Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B731C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 05:49:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B3721773
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 05:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B3721773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VrRC6cgczDqSv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:49:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 44VrMt4R3RzDqNp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 16:46:50 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id A23CAAE8003F;
 Fri, 29 Mar 2019 01:46:47 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 1/2] powerpc/mm_iommu: Prepare for less locking
Date: Fri, 29 Mar 2019 16:46:40 +1100
Message-Id: <20190329054641.48597-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329054641.48597-1-aik@ozlabs.ru>
References: <20190329054641.48597-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The next patch will reduce amount of time spent under locks.

This adds mm_iommu_find() to see if the region is already registered.

This removes a rather ugly union from the mm_iommu_table_group_mem_t
struct and keeps the hack local in mm_iommu_do_alloc().

This makes pageshift and hpas local and assigns them late as soon this
moves to a helper.

This should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/mm/mmu_context_iommu.c | 82 +++++++++++++++--------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index e7a9c4f6bfca..6b351c79713b 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -35,18 +35,8 @@ struct mm_iommu_table_group_mem_t {
 	atomic64_t mapped;
 	unsigned int pageshift;
 	u64 ua;			/* userspace address */
-	u64 entries;		/* number of entries in hpas/hpages[] */
-	/*
-	 * in mm_iommu_get we temporarily use this to store
-	 * struct page address.
-	 *
-	 * We need to convert ua to hpa in real mode. Make it
-	 * simpler by storing physical address.
-	 */
-	union {
-		struct page **hpages;	/* vmalloc'ed */
-		phys_addr_t *hpas;
-	};
+	u64 entries;		/* number of entries in hpas */
+	phys_addr_t *hpas;
 #define MM_IOMMU_TABLE_INVALID_HPA	((uint64_t)-1)
 	u64 dev_hpa;		/* Device memory base address */
 };
@@ -91,26 +81,36 @@ bool mm_iommu_preregistered(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
 
+/* Must be called with &mem_list_mutex held */
+static bool mm_iommu_find(struct mm_struct *mm, unsigned long ua,
+		unsigned long entries)
+{
+	struct mm_iommu_table_group_mem_t *mem;
+
+	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,	next) {
+		/* Overlap? */
+		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
+				(ua < (mem->ua + (mem->entries << PAGE_SHIFT))))
+			return true;
+	}
+	return false;
+}
+
 static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 			      unsigned long entries, unsigned long dev_hpa,
 			      struct mm_iommu_table_group_mem_t **pmem)
 {
 	struct mm_iommu_table_group_mem_t *mem;
 	long i, ret, locked_entries = 0;
-	unsigned int pageshift;
+	unsigned int pageshift, mem_pageshift;
+	struct page **hpages;
+	phys_addr_t *hpas;
 
 	mutex_lock(&mem_list_mutex);
 
-	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
-			next) {
-		/* Overlap? */
-		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
-				(ua < (mem->ua +
-				       (mem->entries << PAGE_SHIFT)))) {
-			ret = -EINVAL;
-			goto unlock_exit;
-		}
-
+	if (mm_iommu_find(mm, ua, entries)) {
+		ret = -EINVAL;
+		goto unlock_exit;
 	}
 
 	if (dev_hpa == MM_IOMMU_TABLE_INVALID_HPA) {
@@ -128,58 +128,60 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	}
 
 	if (dev_hpa != MM_IOMMU_TABLE_INVALID_HPA) {
-		mem->pageshift = __ffs(dev_hpa | (entries << PAGE_SHIFT));
+		mem_pageshift = __ffs(dev_hpa | (entries << PAGE_SHIFT));
+		hpas = NULL;
 		mem->dev_hpa = dev_hpa;
 		goto good_exit;
 	}
 	mem->dev_hpa = MM_IOMMU_TABLE_INVALID_HPA;
 
-	/*
-	 * For a starting point for a maximum page size calculation
-	 * we use @ua and @entries natural alignment to allow IOMMU pages
-	 * smaller than huge pages but still bigger than PAGE_SIZE.
-	 */
-	mem->pageshift = __ffs(ua | (entries << PAGE_SHIFT));
-	mem->hpas = vzalloc(array_size(entries, sizeof(mem->hpas[0])));
-	if (!mem->hpas) {
+	hpages = vzalloc(array_size(entries, sizeof(hpages[0])));
+	if (!hpages) {
 		kfree(mem);
 		ret = -ENOMEM;
 		goto unlock_exit;
 	}
 
 	down_read(&mm->mmap_sem);
-	ret = get_user_pages_longterm(ua, entries, FOLL_WRITE, mem->hpages, NULL);
+	ret = get_user_pages_longterm(ua, entries, FOLL_WRITE, hpages, NULL);
 	up_read(&mm->mmap_sem);
 	if (ret != entries) {
 		/* free the reference taken */
 		for (i = 0; i < ret; i++)
-			put_page(mem->hpages[i]);
+			put_page(hpages[i]);
 
-		vfree(mem->hpas);
+		vfree(hpages);
 		kfree(mem);
 		ret = -EFAULT;
 		goto unlock_exit;
 	}
 
+	/*
+	 * For a starting point for a maximum page size calculation
+	 * we use @ua and @entries natural alignment to allow IOMMU pages
+	 * smaller than huge pages but still bigger than PAGE_SIZE.
+	 */
+	mem_pageshift = __ffs(ua | (entries << PAGE_SHIFT));
+	hpas = (phys_addr_t *) hpages;
 	pageshift = PAGE_SHIFT;
 	for (i = 0; i < entries; ++i) {
-		struct page *page = mem->hpages[i];
+		struct page *page = hpages[i];
 
 		/*
 		 * Allow to use larger than 64k IOMMU pages. Only do that
 		 * if we are backed by hugetlb.
 		 */
-		if ((mem->pageshift > PAGE_SHIFT) && PageHuge(page)) {
+		if ((mem_pageshift > PAGE_SHIFT) && PageHuge(page)) {
 			struct page *head = compound_head(page);
 
 			pageshift = compound_order(head) + PAGE_SHIFT;
 		}
-		mem->pageshift = min(mem->pageshift, pageshift);
+		mem_pageshift = min(mem_pageshift, pageshift);
 		/*
 		 * We don't need struct page reference any more, switch
 		 * to physical address.
 		 */
-		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
+		hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
 	}
 
 good_exit:
@@ -188,6 +190,8 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	mem->used = 1;
 	mem->ua = ua;
 	mem->entries = entries;
+	mem->hpas = hpas;
+	mem->pageshift = mem_pageshift;
 	*pmem = mem;
 
 	list_add_rcu(&mem->next, &mm->context.iommu_group_mem_list);
-- 
2.17.1

