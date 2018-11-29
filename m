Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8687EC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 08:19:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6871205C9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 08:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6871205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4359RX6s6wzDqmj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:19:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4359Dj3lPbzDr0q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 19:10:13 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4359Dd5FQhz9vGm1;
 Thu, 29 Nov 2018 09:10:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id TZc51XkKmpfs; Thu, 29 Nov 2018 09:10:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4359Dd4gtCz9vGlV;
 Thu, 29 Nov 2018 09:10:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E2B08B892;
 Thu, 29 Nov 2018 09:10:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 4Wg3a0gYScNr; Thu, 29 Nov 2018 09:10:10 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 00D598B762;
 Thu, 29 Nov 2018 09:10:09 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C833669B13; Thu, 29 Nov 2018 08:10:09 +0000 (UTC)
Message-Id: <a0eb810bd261679fbddbef5578f50c64d8373038.1543478200.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543478199.git.christophe.leroy@c-s.fr>
References: <cover.1543478199.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 03/20] powerpc/mm: Move pte_fragment_alloc() to a common
 location
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 29 Nov 2018 08:10:09 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation of next patch which generalises the use of
pte_fragment_alloc() for all, this patch moves the related functions
in a place that is common to all subarches.

The 8xx will need that for supporting 16k pages, as in that mode
page tables still have a size of 4k.

Since pte_fragment with only once fragment is not different
from what is done in the general case, we can easily migrate all
subarchs to pte fragments.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h |   1 +
 arch/powerpc/mm/Makefile                     |   4 +-
 arch/powerpc/mm/mmu_context_book3s64.c       |  15 ----
 arch/powerpc/mm/pgtable-book3s64.c           |  85 --------------------
 arch/powerpc/mm/pgtable-frag.c               | 116 +++++++++++++++++++++++++++
 5 files changed, 120 insertions(+), 101 deletions(-)
 create mode 100644 arch/powerpc/mm/pgtable-frag.c

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 391ed2c3b697..f949dd90af9b 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -50,6 +50,7 @@ extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
 #ifdef CONFIG_SMP
 extern void __tlb_remove_table(void *_table);
 #endif
+void pte_frag_destroy(void *pte_frag);
 
 static inline pgd_t *radix__pgd_alloc(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index ca96e7be4d0e..3cbb1acf0745 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -15,7 +15,9 @@ obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
 hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o \
+				   $(hash64-y) mmu_context_book3s64.o \
+				   pgtable-book3s64.o pgtable-frag.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 510f103d7813..f720c5cc0b5e 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -164,21 +164,6 @@ static void destroy_contexts(mm_context_t *ctx)
 	}
 }
 
-static void pte_frag_destroy(void *pte_frag)
-{
-	int count;
-	struct page *page;
-
-	page = virt_to_page(pte_frag);
-	/* drop all the pending references */
-	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
-	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
-		pgtable_page_dtor(page);
-		__free_page(page);
-	}
-}
-
 static void pmd_frag_destroy(void *pmd_frag)
 {
 	int count;
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 9f93c9f985c5..0c0fd173208a 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -322,91 +322,6 @@ void pmd_fragment_free(unsigned long *pmd)
 	}
 }
 
-static pte_t *get_pte_from_cache(struct mm_struct *mm)
-{
-	void *pte_frag, *ret;
-
-	spin_lock(&mm->page_table_lock);
-	ret = mm->context.pte_frag;
-	if (ret) {
-		pte_frag = ret + PTE_FRAG_SIZE;
-		/*
-		 * If we have taken up all the fragments mark PTE page NULL
-		 */
-		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
-			pte_frag = NULL;
-		mm->context.pte_frag = pte_frag;
-	}
-	spin_unlock(&mm->page_table_lock);
-	return (pte_t *)ret;
-}
-
-static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
-{
-	void *ret = NULL;
-	struct page *page;
-
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
-
-	atomic_set(&page->pt_frag_refcount, 1);
-
-	ret = page_address(page);
-	/*
-	 * if we support only one fragment just return the
-	 * allocated page.
-	 */
-	if (PTE_FRAG_NR == 1)
-		return ret;
-	spin_lock(&mm->page_table_lock);
-	/*
-	 * If we find pgtable_page set, we return
-	 * the allocated page with single fragement
-	 * count.
-	 */
-	if (likely(!mm->context.pte_frag)) {
-		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
-		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
-	}
-	spin_unlock(&mm->page_table_lock);
-
-	return (pte_t *)ret;
-}
-
-pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
-{
-	pte_t *pte;
-
-	pte = get_pte_from_cache(mm);
-	if (pte)
-		return pte;
-
-	return __alloc_for_ptecache(mm, kernel);
-}
-
-void pte_fragment_free(unsigned long *table, int kernel)
-{
-	struct page *page = virt_to_page(table);
-
-	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
-	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
-		if (!kernel)
-			pgtable_page_dtor(page);
-		__free_page(page);
-	}
-}
-
 static inline void pgtable_free(void *table, int index)
 {
 	switch (index) {
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
new file mode 100644
index 000000000000..d61e7c2a9a79
--- /dev/null
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ *  Handling Page Tables through page fragments
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/percpu.h>
+#include <linux/hardirq.h>
+#include <linux/hugetlb.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/tlb.h>
+
+void pte_frag_destroy(void *pte_frag)
+{
+	int count;
+	struct page *page;
+
+	page = virt_to_page(pte_frag);
+	/* drop all the pending references */
+	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
+	/* We allow PTE_FRAG_NR fragments from a PTE page */
+	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
+		pgtable_page_dtor(page);
+		__free_page(page);
+	}
+}
+
+static pte_t *get_pte_from_cache(struct mm_struct *mm)
+{
+	void *pte_frag, *ret;
+
+	spin_lock(&mm->page_table_lock);
+	ret = mm->context.pte_frag;
+	if (ret) {
+		pte_frag = ret + PTE_FRAG_SIZE;
+		/*
+		 * If we have taken up all the fragments mark PTE page NULL
+		 */
+		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
+			pte_frag = NULL;
+		mm->context.pte_frag = pte_frag;
+	}
+	spin_unlock(&mm->page_table_lock);
+	return (pte_t *)ret;
+}
+
+static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
+{
+	void *ret = NULL;
+	struct page *page;
+
+	if (!kernel) {
+		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
+		if (!page)
+			return NULL;
+		if (!pgtable_page_ctor(page)) {
+			__free_page(page);
+			return NULL;
+		}
+	} else {
+		page = alloc_page(PGALLOC_GFP);
+		if (!page)
+			return NULL;
+	}
+
+	atomic_set(&page->pt_frag_refcount, 1);
+
+	ret = page_address(page);
+	/*
+	 * if we support only one fragment just return the
+	 * allocated page.
+	 */
+	if (PTE_FRAG_NR == 1)
+		return ret;
+	spin_lock(&mm->page_table_lock);
+	/*
+	 * If we find pgtable_page set, we return
+	 * the allocated page with single fragement
+	 * count.
+	 */
+	if (likely(!mm->context.pte_frag)) {
+		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
+		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
+	}
+	spin_unlock(&mm->page_table_lock);
+
+	return (pte_t *)ret;
+}
+
+pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
+{
+	pte_t *pte;
+
+	pte = get_pte_from_cache(mm);
+	if (pte)
+		return pte;
+
+	return __alloc_for_ptecache(mm, kernel);
+}
+
+void pte_fragment_free(unsigned long *table, int kernel)
+{
+	struct page *page = virt_to_page(table);
+
+	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
+	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
+		if (!kernel)
+			pgtable_page_dtor(page);
+		__free_page(page);
+	}
+}
-- 
2.13.3

