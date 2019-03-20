Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D209CC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:39:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542A52184E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dRCFgRrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542A52184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PRJC03LrzDq61
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:39:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="dRCFgRrL"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQZ95zQrzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:06:57 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQZ55R4Cz9vC01;
 Wed, 20 Mar 2019 11:06:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=dRCFgRrL; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id rEzj4i2gFG5C; Wed, 20 Mar 2019 11:06:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZ54HXSz9vByx;
 Wed, 20 Mar 2019 11:06:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076413; bh=q2dlJcvwEx/19eP32GJoFNCETbHxRUMjc50a+XUWIls=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=dRCFgRrL14qfFEKtLkGdld3JAzYDFmaJpaszSzdDQTDag3bhdOiEndInPRhpi73YI
 SbAaocZ4wlDGXfG/3iWKr3zdhnxPEkj4qSgL3iM1tN5VN0X8F3htETusVi4+R4sgbu
 WilFfN+ananrCgI6m5nuOgG5C8oxwmdJ4TcTd2rQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B21718B918;
 Wed, 20 Mar 2019 11:06:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id OP7VsYGiveK5; Wed, 20 Mar 2019 11:06:54 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 956A58B911;
 Wed, 20 Mar 2019 11:06:54 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 6ECA463AEF; Wed, 20 Mar 2019 10:06:54 +0000 (UTC)
Message-Id: <87b95ea8a9ea8395a3418f9c06bdf956cd944d5e.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 18/27] powerpc/mm: cleanup remaining ifdef mess in
 hugetlbpage.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:06:54 +0000 (UTC)
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

Only 3 subarches support huge pages. So when it either 2 of them, it
is not the third one.

And mmu_has_feature() is known by all subarches so IS_ENABLED() can
be used instead of #ifdef

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/hugetlbpage.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index dd62006e1243..a463ebf276b6 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -226,7 +226,7 @@ int __init alloc_bootmem_huge_page(struct hstate *h)
 	return __alloc_bootmem_huge_page(h);
 }
 
-#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
+#ifndef CONFIG_PPC_BOOK3S_64
 #define HUGEPD_FREELIST_SIZE \
 	((PAGE_SIZE - sizeof(struct hugepd_freelist)) / sizeof(pte_t))
 
@@ -596,10 +596,10 @@ static int __init hugetlbpage_init(void)
 		return 0;
 	}
 
-#if !defined(CONFIG_PPC_FSL_BOOK3E) && !defined(CONFIG_PPC_8xx)
-	if (!radix_enabled() && !mmu_has_feature(MMU_FTR_16M_PAGE))
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && !radix_enabled() &&
+	    !mmu_has_feature(MMU_FTR_16M_PAGE))
 		return -ENODEV;
-#endif
+
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 		unsigned shift;
 		unsigned pdshift;
@@ -637,10 +637,8 @@ static int __init hugetlbpage_init(void)
 			pgtable_cache_add(PTE_INDEX_SIZE);
 		else if (pdshift > shift)
 			pgtable_cache_add(pdshift - shift);
-#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
-		else
+		else if (IS_ENABLED(CONFIG_PPC_FSL_BOOK3E) || IS_ENABLED(CONFIG_PPC_8xx))
 			pgtable_cache_add(PTE_T_ORDER);
-#endif
 	}
 
 	if (IS_ENABLED(HUGETLB_PAGE_SIZE_VARIABLE))
-- 
2.13.3

