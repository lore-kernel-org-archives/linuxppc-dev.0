Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FB7C7112A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:26:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A457205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A457205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YY3T4qCzzF3Dj
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:26:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YY140xQMzF35j
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:24:23 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id BE9E0AE80054;
 Mon, 15 Oct 2018 05:24:20 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 1/4] powerpc/mm/iommu: Rename mm_iommu_get
Date: Mon, 15 Oct 2018 20:24:13 +1100
Message-Id: <20181015092416.47380-2-aik@ozlabs.ru>
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

Normally mm_iommu_get() is supposed to add a reference and
mm_iommu_put() to remove it. However historically mm_iommu_find() does
the referencing and mm_iommu_get() is doing allocation and referencing.

This is step 1 towards simpler mm_iommu_get().

This renames:
- mm_iommu_get to mm_iommu_new;
- mm_iommu_find to mm_iommu_get.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/mmu_context.h | 4 ++--
 arch/powerpc/mm/mmu_context_iommu.c    | 8 ++++----
 drivers/vfio/vfio_iommu_spapr_tce.c    | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b694d6a..59d4941 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -21,7 +21,7 @@ struct mm_iommu_table_group_mem_t;
 
 extern int isolate_lru_page(struct page *page);	/* from internal.h */
 extern bool mm_iommu_preregistered(struct mm_struct *mm);
-extern long mm_iommu_get(struct mm_struct *mm,
+extern long mm_iommu_new(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem);
 extern long mm_iommu_put(struct mm_struct *mm,
@@ -32,7 +32,7 @@ extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
 		unsigned long ua, unsigned long size);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(
 		struct mm_struct *mm, unsigned long ua, unsigned long size);
-extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
+extern struct mm_iommu_table_group_mem_t *mm_iommu_get(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries);
 extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 56c2234..8eeb99d 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -126,7 +126,7 @@ static int mm_iommu_move_page_from_cma(struct page *page)
 	return 0;
 }
 
-long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
+long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem)
 {
 	struct mm_iommu_table_group_mem_t *mem;
@@ -252,7 +252,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mm_iommu_get);
+EXPORT_SYMBOL_GPL(mm_iommu_new);
 
 static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
 {
@@ -368,7 +368,7 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(struct mm_struct *mm,
 	return ret;
 }
 
-struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
+struct mm_iommu_table_group_mem_t *mm_iommu_get(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries)
 {
 	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
@@ -382,7 +382,7 @@ struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mm_iommu_find);
+EXPORT_SYMBOL_GPL(mm_iommu_get);
 
 long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index ad63725..1701798 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -156,7 +156,7 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
 		return -EINVAL;
 
-	mem = mm_iommu_find(container->mm, vaddr, size >> PAGE_SHIFT);
+	mem = mm_iommu_get(container->mm, vaddr, size >> PAGE_SHIFT);
 	if (!mem)
 		return -ENOENT;
 
@@ -185,7 +185,7 @@ static long tce_iommu_register_pages(struct tce_container *container,
 			((vaddr + size) < vaddr))
 		return -EINVAL;
 
-	mem = mm_iommu_find(container->mm, vaddr, entries);
+	mem = mm_iommu_get(container->mm, vaddr, entries);
 	if (mem) {
 		list_for_each_entry(tcemem, &container->prereg_list, next) {
 			if (tcemem->mem == mem)
@@ -193,7 +193,7 @@ static long tce_iommu_register_pages(struct tce_container *container,
 		}
 	}
 
-	ret = mm_iommu_get(container->mm, vaddr, entries, &mem);
+	ret = mm_iommu_new(container->mm, vaddr, entries, &mem);
 	if (ret)
 		return ret;
 
-- 
2.11.0

