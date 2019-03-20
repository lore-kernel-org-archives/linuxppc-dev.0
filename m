Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F5BC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:47:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3DB2184E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pUB/33c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3DB2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PRTD0GdZzDq8W
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:47:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="pUB/33c7"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQZH22X4zDqJj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:07:03 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQZC1CZ5z9vC08;
 Wed, 20 Mar 2019 11:06:59 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=pUB/33c7; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dt7OGr0Amqqs; Wed, 20 Mar 2019 11:06:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZC01n3z9vByx;
 Wed, 20 Mar 2019 11:06:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076419; bh=GRw9serwW7zFtU57RbE/6YCutDn11hX2MbKn6Ueg0VA=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=pUB/33c7xcb2Rd+ChasI1rbY4LOTJ90LTcus4rsLKhCMUSt5Pb9+tTj5Ntzo+yExR
 urrRb2/syMgKxRKoItzJ5c90J7PeqFHTSVqIu+6UKAUVM5gGpFiam4nTVyQ/2t4pnK
 amu7BGY0DQFovdKjSD2rkLXl+da8Y17M4RKRhZzA=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 218828B918;
 Wed, 20 Mar 2019 11:07:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Zm2YLoeU2qU2; Wed, 20 Mar 2019 11:07:00 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EDCF28B911;
 Wed, 20 Mar 2019 11:06:59 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id BB95D63AEF; Wed, 20 Mar 2019 10:06:59 +0000 (UTC)
Message-Id: <5466dd36168b85f8b6ff2fd1e2a4491542714990.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 23/27] powerpc/mm: remove a couple of #ifdef
 CONFIG_PPC_64K_PAGES in mm/slice.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:06:59 +0000 (UTC)
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

This patch replaces a couple of #ifdef CONFIG_PPC_64K_PAGES
by IS_ENABLED(CONFIG_PPC_64K_PAGES) to improve code maintainability.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/slice.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 357d64e14757..50b1a5528384 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -558,14 +558,13 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	newaddr = slice_find_area(mm, len, &potential_mask,
 				  psize, topdown, high_limit);
 
-#ifdef CONFIG_PPC_64K_PAGES
-	if (newaddr == -ENOMEM && psize == MMU_PAGE_64K) {
+	if (IS_ENABLED(CONFIG_PPC_64K_PAGES) && newaddr == -ENOMEM &&
+	    psize == MMU_PAGE_64K) {
 		/* retry the search with 4k-page slices included */
 		slice_or_mask(&potential_mask, &potential_mask, compat_maskp);
 		newaddr = slice_find_area(mm, len, &potential_mask,
 					  psize, topdown, high_limit);
 	}
-#endif
 
 	if (newaddr == -ENOMEM)
 		return -ENOMEM;
@@ -731,9 +730,9 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	VM_BUG_ON(radix_enabled());
 
 	maskp = slice_mask_for_size(&mm->context, psize);
-#ifdef CONFIG_PPC_64K_PAGES
+
 	/* We need to account for 4k slices too */
-	if (psize == MMU_PAGE_64K) {
+	if (IS_ENABLED(CONFIG_PPC_64K_PAGES) && psize == MMU_PAGE_64K) {
 		const struct slice_mask *compat_maskp;
 		struct slice_mask available;
 
@@ -741,7 +740,6 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 		slice_or_mask(&available, maskp, compat_maskp);
 		return !slice_check_range_fits(mm, &available, addr, len);
 	}
-#endif
 
 	return !slice_check_range_fits(mm, maskp, addr, len);
 }
-- 
2.13.3

