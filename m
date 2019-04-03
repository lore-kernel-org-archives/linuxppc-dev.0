Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CA6C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:26:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5FB20882
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="b/y3sl+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5FB20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZHg26m7qzDqDW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 07:26:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="b/y3sl+l"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZHCS3FV4zDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 07:06:28 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44ZHCN6494z9v3py;
 Wed,  3 Apr 2019 22:06:24 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=b/y3sl+l; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id eaFfVy2lEeyO; Wed,  3 Apr 2019 22:06:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHCN4x6tz9v3pp;
 Wed,  3 Apr 2019 22:06:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554321984; bh=caDzAPxyJgpXt/HP++4Ec3vEnpJi256n8UK7QelwuVM=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=b/y3sl+lmD+5Tlm0QQG+RUGkcRVsR9XGMJz3/UMyMx/b3WLEanuiET9c4PGnWa/uu
 6RHxWSMWTRWz/IxlSoLJYTKDO75AJTzNWTIl8egJFCULemoVDYRalmeAzUAaACS7fs
 /4tCMdoDUAwEszhO4vArAOp7LTBS+LlHVZITzm1o=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CB5DF8B905;
 Wed,  3 Apr 2019 22:06:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id vS2L4BhxgFm7; Wed,  3 Apr 2019 22:06:24 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A33618B902;
 Wed,  3 Apr 2019 22:06:24 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 85443655EC; Wed,  3 Apr 2019 20:06:24 +0000 (UTC)
Message-Id: <3f85b0df9361404a7ba02931cd1708533147ee19.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 12/15] powerpc/mm: Only keep one version of pmd_populate()
 functions on nohash/32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed,  3 Apr 2019 20:06:24 +0000 (UTC)
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

Use IS_ENABLED(CONFIG_BOOKE) to make single versions of
pmd_populate() and pmd_populate_kernel()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 4615801aa953..7ee8e27070f4 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -25,37 +25,25 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 #define __pmd_free_tlb(tlb,x,a)		do { } while (0)
 /* #define pgd_populate(mm, pmd, pte)      BUG() */
 
-#ifndef CONFIG_BOOKE
-
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 				       pte_t *pte)
 {
-	*pmdp = __pmd(__pa(pte) | _PMD_PRESENT);
+	if (IS_ENABLED(CONFIG_BOOKE))
+		*pmdp = __pmd((unsigned long)pte | _PMD_PRESENT);
+	else
+		*pmdp = __pmd(__pa(pte) | _PMD_PRESENT);
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pte_page)
 {
-	*pmdp = __pmd(__pa(pte_page) | _PMD_USER | _PMD_PRESENT);
+	if (IS_ENABLED(CONFIG_BOOKE))
+		*pmdp = __pmd((unsigned long)pte_page | _PMD_PRESENT);
+	else
+		*pmdp = __pmd(__pa(pte_page) | _PMD_USER | _PMD_PRESENT);
 }
 
 #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
-#else
-
-static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
-				       pte_t *pte)
-{
-	*pmdp = __pmd((unsigned long)pte | _PMD_PRESENT);
-}
-
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pte_page)
-{
-	*pmdp = __pmd((unsigned long)pte_page | _PMD_PRESENT);
-}
-
-#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
-#endif
 
 static inline void pgtable_free(void *table, unsigned index_size)
 {
-- 
2.13.3

