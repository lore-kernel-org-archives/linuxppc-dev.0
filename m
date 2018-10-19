Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ECDECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:30:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED60B20645
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED60B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42byHp0dztzF3VG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:30:30 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bxWK6SzTzF3Tc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 17:55:25 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bxWF5Wjtz9ttFT;
 Fri, 19 Oct 2018 08:55:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id WxDhXAdeo87o; Fri, 19 Oct 2018 08:55:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bxWF5334z9ttFM;
 Fri, 19 Oct 2018 08:55:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DE6068B8DF;
 Fri, 19 Oct 2018 08:55:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id uQ4MnH_aPXJB; Fri, 19 Oct 2018 08:55:22 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BA3F68B75B;
 Fri, 19 Oct 2018 08:55:22 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8618A6F496; Fri, 19 Oct 2018 06:55:22 +0000 (UTC)
Message-Id: <73606304f6ebf6022c37ef48631b1f3a523db76e.1539931702.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539931702.git.christophe.leroy@c-s.fr>
References: <cover.1539931702.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 15/20] powerpc/mm: don't use pte_alloc_one_kernel() before
 slab is available
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 19 Oct 2018 06:55:22 +0000 (UTC)
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

In the same way as PPC64, let's handle pte allocation directly
in kernel_map_page() when slab is not available.

The new function early_pte_alloc_kernel() is put in as inline in
platforms pgalloc.h, this will allow to have different ones later.
It is not an issue because early_pte_alloc_kernel() is called only
once from map_kernel_page() and is inlined anyway.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 15 +++++++++++++++
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 15 +++++++++++++++
 arch/powerpc/mm/pgtable_32.c                 | 20 +++++++-------------
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 96138ab3ddd6..4ddc7df20381 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -4,6 +4,7 @@
 
 #include <linux/threads.h>
 #include <linux/slab.h>
+#include <linux/memblock.h>
 
 /*
  * Functions that deal with pagetables that could be at any level of
@@ -137,4 +138,18 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 {
 	pgtable_free_tlb(tlb, page_address(table), 0);
 }
+
+static inline pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va)
+{
+	if (!pmd_present(*pmdp)) {
+		pte_t *ptep = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
+
+		if (!ptep)
+			return NULL;
+
+		clear_page(ptep);
+		pmd_populate_kernel(&init_mm, pmdp, ptep);
+	}
+	return pte_offset_kernel(pmdp, va);
+}
 #endif /* _ASM_POWERPC_BOOK3S_32_PGALLOC_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 6fbbb90043c0..da8fdfc76418 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -4,6 +4,7 @@
 
 #include <linux/threads.h>
 #include <linux/slab.h>
+#include <linux/memblock.h>
 
 /*
  * Functions that deal with pagetables that could be at any level of
@@ -139,4 +140,18 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 	tlb_flush_pgtable(tlb, address);
 	pgtable_free_tlb(tlb, page_address(table), 0);
 }
+
+static inline pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va)
+{
+	if (!pmd_present(*pmdp)) {
+		pte_t *ptep = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
+
+		if (!ptep)
+			return NULL;
+
+		clear_page(ptep);
+		pmd_populate_kernel(&init_mm, pmdp, ptep);
+	}
+	return pte_offset_kernel(pmdp, va);
+}
 #endif /* _ASM_POWERPC_PGALLOC_32_H */
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 5877f5aa8f5d..ea4442dde0d5 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -43,18 +43,9 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
-__ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte;
-
-	if (slab_is_available()) {
-		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	} else {
-		pte = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
-		if (pte)
-			clear_page(pte);
-	}
-	return pte;
+	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 }
 
 pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
@@ -222,7 +213,7 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
-int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
+__ref int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 {
 	pmd_t *pd;
 	pte_t *pg;
@@ -231,7 +222,10 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 	/* Use upper 10 bits of VA to index the first level map */
 	pd = pmd_offset(pud_offset(pgd_offset_k(va), va), va);
 	/* Use middle 10 bits of VA to index the second-level map */
-	pg = pte_alloc_kernel(pd, va);
+	if (slab_is_available())
+		pg = pte_alloc_kernel(pd, va);
+	else
+		pg = early_pte_alloc_kernel(pd, va);
 	if (pg != 0) {
 		err = 0;
 		/* The PTE should never be already set nor present in the
-- 
2.13.3

