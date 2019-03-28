Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9933CC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 13:06:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1492173C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 13:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cO0bmT8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1492173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VQ9c6dbCzDqQc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 00:06:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="cO0bmT8R"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VQ6c171yzDqPM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 00:03:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44VQ6T3VDvz9v2Hk;
 Thu, 28 Mar 2019 14:03:45 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=cO0bmT8R; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id TO4ir2j_GK_q; Thu, 28 Mar 2019 14:03:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44VQ6T2PVRz9v2Hh;
 Thu, 28 Mar 2019 14:03:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553778225; bh=00mcQBSgYO78zRbK1rxCu3YRaTtOXke+6rL37WP4sfQ=;
 h=From:Subject:To:Cc:Date:From;
 b=cO0bmT8R9gNu3H0ngv5FyHtJVZSCuSKi3egXxjfdOVGSjBTBlz4WsqnpNw/CjFEG2
 u2B4b7FESvoP56Y4DzYRh7ktlp2iSEPlXSw6XY3Htukey+FR1nlGq9Fyks86e0tDMI
 Sguy7WJU6PIlXq65+SLc4Ck2C5Ihs4oXc5axe+wU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A57C38B91B;
 Thu, 28 Mar 2019 14:03:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id yWcfnxQcHxZd; Thu, 28 Mar 2019 14:03:46 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 79FA78B90A;
 Thu, 28 Mar 2019 14:03:46 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id DF2A06FC7A; Thu, 28 Mar 2019 13:03:45 +0000 (UTC)
Message-Id: <92e8f0bcec682e878796758e1efb88c172c7ffe4.1553778054.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/book3e: drop BUG_ON() in map_kernel_page()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 28 Mar 2019 13:03:45 +0000 (UTC)
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

early_alloc_pgtable() never returns NULL as it panics on failure.

This patch drops the three BUG_ON() which check the non nullity
of early_alloc_pgtable() returned value.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable-book3e.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-book3e.c b/arch/powerpc/mm/pgtable-book3e.c
index 1032ef7aaf62..390a6d0b216d 100644
--- a/arch/powerpc/mm/pgtable-book3e.c
+++ b/arch/powerpc/mm/pgtable-book3e.c
@@ -98,20 +98,17 @@ int map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
 #ifndef __PAGETABLE_PUD_FOLDED
 		if (pgd_none(*pgdp)) {
 			pudp = early_alloc_pgtable(PUD_TABLE_SIZE);
-			BUG_ON(pudp == NULL);
 			pgd_populate(&init_mm, pgdp, pudp);
 		}
 #endif /* !__PAGETABLE_PUD_FOLDED */
 		pudp = pud_offset(pgdp, ea);
 		if (pud_none(*pudp)) {
 			pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
-			BUG_ON(pmdp == NULL);
 			pud_populate(&init_mm, pudp, pmdp);
 		}
 		pmdp = pmd_offset(pudp, ea);
 		if (!pmd_present(*pmdp)) {
 			ptep = early_alloc_pgtable(PAGE_SIZE);
-			BUG_ON(ptep == NULL);
 			pmd_populate_kernel(&init_mm, pmdp, ptep);
 		}
 		ptep = pte_offset_kernel(pmdp, ea);
-- 
2.13.3

