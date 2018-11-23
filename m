Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA230C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 05:56:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171A820672
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 05:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171A820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431QYS4cXSzDqT9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 16:56:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 431QTZ0dN8zDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 16:53:22 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 57B8DAE801F8;
 Fri, 23 Nov 2018 00:53:17 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v4 02/19] powerpc/mm/iommu/vfio_spapr_tce: Change
 mm_iommu_get to reference a region
Date: Fri, 23 Nov 2018 16:52:47 +1100
Message-Id: <20181123055304.25116-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123055304.25116-1-aik@ozlabs.ru>
References: <20181123055304.25116-1-aik@ozlabs.ru>
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Normally mm_iommu_get() is supposed to add a reference and
mm_iommu_put() to remove it. However historically mm_iommu_find() does
the referencing and mm_iommu_get() is doing allocation and referencing.

We are going to add another helper to preregister device memory so
instead of having mm_iommu_new() which pre-registers the normal memory
and references the region, we need separate helpers for pre-registering
and referencing.

This renames:
- mm_iommu_get to mm_iommu_new;
- mm_iommu_find to mm_iommu_get.

To make the mm_iommu_get name reflect what it is supposed to do, this
changes mm_iommu_get() to reference the region so from now on for every
mm_iommu_get() we need a matching mm_iommu_put().

This removes the check for exact match as the check for overlap is
enough now.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* squashed "powerpc/mm/iommu: Make mm_iommu_new() fail on existing regions" into this

v2:
* merged 2 patches into one
---
 arch/powerpc/include/asm/mmu_context.h |  4 +--
 arch/powerpc/mm/mmu_context_iommu.c    | 19 +++++++------
 drivers/vfio/vfio_iommu_spapr_tce.c    | 37 +++++++++++++++++---------
 3 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 0381394..2d6b00d 100644
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
index 1d5161f..580d89e 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -89,7 +89,7 @@ bool mm_iommu_preregistered(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
 
-long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
+long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem)
 {
 	struct mm_iommu_table_group_mem_t *mem;
@@ -102,12 +102,6 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 
 	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
 			next) {
-		if ((mem->ua == ua) && (mem->entries == entries)) {
-			++mem->used;
-			*pmem = mem;
-			goto unlock_exit;
-		}
-
 		/* Overlap? */
 		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
 				(ua < (mem->ua +
@@ -202,7 +196,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mm_iommu_get);
+EXPORT_SYMBOL_GPL(mm_iommu_new);
 
 static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
 {
@@ -318,21 +312,26 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(struct mm_struct *mm,
 	return ret;
 }
 
-struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
+struct mm_iommu_table_group_mem_t *mm_iommu_get(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries)
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
-EXPORT_SYMBOL_GPL(mm_iommu_find);
+EXPORT_SYMBOL_GPL(mm_iommu_get);
 
 long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index ad63725..56db071 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -151,12 +151,13 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
 {
 	struct mm_iommu_table_group_mem_t *mem;
 	struct tce_iommu_prereg *tcemem;
-	bool found = false;
+	bool found;
+	long ret;
 
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
 		return -EINVAL;
 
-	mem = mm_iommu_find(container->mm, vaddr, size >> PAGE_SHIFT);
+	mem = mm_iommu_get(container->mm, vaddr, size >> PAGE_SHIFT);
 	if (!mem)
 		return -ENOENT;
 
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
@@ -185,22 +190,24 @@ static long tce_iommu_register_pages(struct tce_container *container,
 			((vaddr + size) < vaddr))
 		return -EINVAL;
 
-	mem = mm_iommu_find(container->mm, vaddr, entries);
+	mem = mm_iommu_get(container->mm, vaddr, entries);
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
 
-	ret = mm_iommu_get(container->mm, vaddr, entries, &mem);
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
2.17.1

