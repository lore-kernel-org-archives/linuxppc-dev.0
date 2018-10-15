Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F778C7112A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:34:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8132205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8132205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YYDs6NxhzF3Df
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:34:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YY1g0zBfzF3Fj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:24:55 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 6A959AE807D4;
 Mon, 15 Oct 2018 05:24:22 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 2/4] powerpc/mm/iommu/vfio_spapr_tce: Change
 mm_iommu_get to reference a region
Date: Mon, 15 Oct 2018 20:24:14 +1100
Message-Id: <20181015092416.47380-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181015092416.47380-1-aik@ozlabs.ru>
References: <20181015092416.47380-1-aik@ozlabs.ru>
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
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We are going to add another helper to preregister device memory so
instead of having mm_iommu_new() which pre-registers the normal memory
and references the region, we need separate helpers for pre-registerign
and referencing.

To make the mm_iommu_get name reflect what it is supposed to do, this
changes mm_iommu_get() to reference the region so from now on for every
mm_iommu_get() we need a matching mm_iommu_put().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/mm/mmu_context_iommu.c |  5 +++++
 drivers/vfio/vfio_iommu_spapr_tce.c | 33 ++++++++++++++++++++++-----------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 8eeb99d..a8c4a3c 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -373,13 +373,18 @@ struct mm_iommu_table_group_mem_t *mm_iommu_get(struct mm_struct *mm,
 {
 	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
 
+	mutex_lock(&mem_list_mutex);
+
 	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
 		if ((mem->ua == ua) && (mem->entries == entries)) {
 			ret = mem;
+			++mem->used;
 			break;
 		}
 	}
 
+	mutex_unlock(&mem_list_mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mm_iommu_get);
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 1701798..56db071 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -151,7 +151,8 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
 {
 	struct mm_iommu_table_group_mem_t *mem;
 	struct tce_iommu_prereg *tcemem;
-	bool found = false;
+	bool found;
+	long ret;
 
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
 		return -EINVAL;
@@ -168,9 +169,13 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
 	}
 
 	if (!found)
-		return -ENOENT;
+		ret = -ENOENT;
+	else
+		ret = tce_iommu_prereg_free(container, tcemem);
 
-	return tce_iommu_prereg_free(container, tcemem);
+	mm_iommu_put(container->mm, mem);
+
+	return ret;
 }
 
 static long tce_iommu_register_pages(struct tce_container *container,
@@ -188,19 +193,21 @@ static long tce_iommu_register_pages(struct tce_container *container,
 	mem = mm_iommu_get(container->mm, vaddr, entries);
 	if (mem) {
 		list_for_each_entry(tcemem, &container->prereg_list, next) {
-			if (tcemem->mem == mem)
-				return -EBUSY;
+			if (tcemem->mem == mem) {
+				ret = -EBUSY;
+				goto put_exit;
+			}
 		}
+	} else {
+		ret = mm_iommu_new(container->mm, vaddr, entries, &mem);
+		if (ret)
+			return ret;
 	}
 
-	ret = mm_iommu_new(container->mm, vaddr, entries, &mem);
-	if (ret)
-		return ret;
-
 	tcemem = kzalloc(sizeof(*tcemem), GFP_KERNEL);
 	if (!tcemem) {
-		mm_iommu_put(container->mm, mem);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto put_exit;
 	}
 
 	tcemem->mem = mem;
@@ -209,6 +216,10 @@ static long tce_iommu_register_pages(struct tce_container *container,
 	container->enabled = true;
 
 	return 0;
+
+put_exit:
+	mm_iommu_put(container->mm, mem);
+	return ret;
 }
 
 static bool tce_page_is_contained(struct page *page, unsigned page_shift)
-- 
2.11.0

