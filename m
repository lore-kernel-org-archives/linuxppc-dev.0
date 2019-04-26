Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35DBC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:14:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E4120651
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="bL7lil+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E4120651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rJyx5kbGzDqRy
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 02:14:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="bL7lil+Q"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rJcM4tnkzDqQT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 01:58:11 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44rJcG3hV4z9v0yZ;
 Fri, 26 Apr 2019 17:58:06 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=bL7lil+Q; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 53-PhI43rlTs; Fri, 26 Apr 2019 17:58:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44rJcG1zk9z9v0yT;
 Fri, 26 Apr 2019 17:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556294286; bh=+Uu8VBdnaA8+SsUDdkzafHe93tdN8JfJSiH2W7NS9Nc=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=bL7lil+Q/5XpdaWv/a9ybWfZH4gve3HB78Ykk6yO1xy1sMYvALc3Osb8tLaAGbZD0
 E9qffEeG9gfxJ2aCyYgxfhINCzG/8vIhMPSDBXTxQdtFkuiVIeRSEuXLZPGZPtwSZU
 yRaAfzuM09YzrZJfhCFR2XuE+hbkHuImI1VqhRD8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E73E28B94A;
 Fri, 26 Apr 2019 17:58:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id rEieSrJZjYYF; Fri, 26 Apr 2019 17:58:07 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BFEDA8B82F;
 Fri, 26 Apr 2019 17:58:07 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id A8665666FE; Fri, 26 Apr 2019 15:58:07 +0000 (UTC)
Message-Id: <90f5242d483aced3a0ebc9abdebf0dc6ab431e1e.1556293738.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556293738.git.christophe.leroy@c-s.fr>
References: <cover.1556293738.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 09/15] powerpc/mm: inline pte_alloc_one_kernel() and
 pte_alloc_one() on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 15:58:07 +0000 (UTC)
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

pte_alloc_one_kernel() and pte_alloc_one() are simple calls to
pte_fragment_alloc(), so they are good candidates for inlining as
already done on PPC64.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 15 ++++++++++++---
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 15 ++++++++++++---
 arch/powerpc/mm/pgtable_32.c                 | 10 ----------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 645af86cd072..0ed856068bb8 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -59,10 +59,19 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 
 #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
-extern pgtable_t pte_alloc_one(struct mm_struct *mm);
-void pte_frag_destroy(void *pte_frag);
 pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel);
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
+{
+	return (pte_t *)pte_fragment_alloc(mm, 1);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
+{
+	return (pgtable_t)pte_fragment_alloc(mm, 0);
+}
+
+void pte_frag_destroy(void *pte_frag);
 void pte_fragment_free(unsigned long *table, int kernel);
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index ea265a578eb0..1d41508f0676 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -77,10 +77,19 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 #endif
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
-extern pgtable_t pte_alloc_one(struct mm_struct *mm);
-void pte_frag_destroy(void *pte_frag);
 pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel);
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
+{
+	return (pte_t *)pte_fragment_alloc(mm, 1);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
+{
+	return (pgtable_t)pte_fragment_alloc(mm, 0);
+}
+
+void pte_frag_destroy(void *pte_frag);
 void pte_fragment_free(unsigned long *table, int kernel);
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index a1c3062f0665..d02fe3ce64db 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -43,16 +43,6 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
-pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)pte_fragment_alloc(mm, 1);
-}
-
-pgtable_t pte_alloc_one(struct mm_struct *mm)
-{
-	return (pgtable_t)pte_fragment_alloc(mm, 0);
-}
-
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
-- 
2.13.3

