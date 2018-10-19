Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F88ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:32:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB32521470
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB32521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42byL16jcBzF39T
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:32:25 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bxWN0GqfzF3Tj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 17:55:28 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bxWH6MvXz9ttFp;
 Fri, 19 Oct 2018 08:55:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id M_KTX_SHIwsD; Fri, 19 Oct 2018 08:55:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bxWH5tVZz9ttFM;
 Fri, 19 Oct 2018 08:55:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 02F6C8B8DF;
 Fri, 19 Oct 2018 08:55:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id SD0IOLaud1y6; Fri, 19 Oct 2018 08:55:24 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D424E8B75B;
 Fri, 19 Oct 2018 08:55:24 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 9CAA46F496; Fri, 19 Oct 2018 06:55:24 +0000 (UTC)
Message-Id: <aa97d2209a16a38572d3e4b8ecb034d051b4bd8c.1539931702.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539931702.git.christophe.leroy@c-s.fr>
References: <cover.1539931702.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 16/20] powerpc/mm: inline pte_alloc_one() and
 pte_alloc_one_kernel() in PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 19 Oct 2018 06:55:24 +0000 (UTC)
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

As in PPC64, inline pte_alloc_one() and pte_alloc_one_kernel()
in PPC32. This will allow to switch nohash/32 to pte_fragment
without impacting hash/32.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 22 ++++++++++++++++++++--
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 22 ++++++++++++++++++++--
 arch/powerpc/mm/pgtable_32.c                 | 21 ---------------------
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 4ddc7df20381..a4cf0de10931 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -80,8 +80,26 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #endif
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
-extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+{
+	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	struct page *ptepage;
+
+	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
+
+	ptepage = alloc_pages(flags, 0);
+	if (!ptepage)
+		return NULL;
+	if (!pgtable_page_ctor(ptepage)) {
+		__free_page(ptepage);
+		return NULL;
+	}
+	return ptepage;
+}
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index da8fdfc76418..78367855a4f3 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -81,8 +81,26 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #endif
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
-extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+{
+	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	struct page *ptepage;
+
+	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
+
+	ptepage = alloc_pages(flags, 0);
+	if (!ptepage)
+		return NULL;
+	if (!pgtable_page_ctor(ptepage)) {
+		__free_page(ptepage);
+		return NULL;
+	}
+	return ptepage;
+}
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index ea4442dde0d5..745f2f30d4e9 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -43,27 +43,6 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
-pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
-{
-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-}
-
-pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
-{
-	struct page *ptepage;
-
-	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
-
-	ptepage = alloc_pages(flags, 0);
-	if (!ptepage)
-		return NULL;
-	if (!pgtable_page_ctor(ptepage)) {
-		__free_page(ptepage);
-		return NULL;
-	}
-	return ptepage;
-}
-
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
-- 
2.13.3

