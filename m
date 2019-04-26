Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E49C43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:26:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FEF20675
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="u3ZWvJcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FEF20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r3x64v8hzDqgG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:26:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="u3ZWvJcv"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r3L33MkCzDqdl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 15:59:55 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44r3Kz3yByz9v1vT;
 Fri, 26 Apr 2019 07:59:51 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=u3ZWvJcv; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 1eTNAcPJdeIu; Fri, 26 Apr 2019 07:59:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44r3Kz2hZpz9v1tj;
 Fri, 26 Apr 2019 07:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556258391; bh=6CbrzkRb9RKVUNX5pyD8e/XjgXIgb01llI2Zcr1ERKw=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=u3ZWvJcv37/VkU0yMfxSyyQHhGLG/zAcpee88kdokAjyW0dSkYjmQP+7dIA1adkG2
 B4EBmuOhIBpSTU/u913v/o/14ZZmdmyXQgbkqs0EkNVamte0K+x22ysu3LvXqO3X7H
 pjEgZ0mwzvKapOgQB818Sgi+XFPXWX7b6FE6LjVs=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4864A8B807;
 Fri, 26 Apr 2019 07:59:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 5hOiM4u1OHi2; Fri, 26 Apr 2019 07:59:52 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F8858B74C;
 Fri, 26 Apr 2019 07:59:52 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 0AD6E66276; Fri, 26 Apr 2019 05:59:52 +0000 (UTC)
Message-Id: <52555dbf9b237ac904c8c4c6b7c09c823c867a7b.1556258135.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556258134.git.christophe.leroy@c-s.fr>
References: <cover.1556258134.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 16/17] powerpc/mm: flatten function __find_linux_pte() step
 2
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 05:59:52 +0000 (UTC)
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

__find_linux_pte() is full of if/else which is hard to
follow allthough the handling is pretty simple.

Previous patch left { } blocks. This patch removes the first one
by shifting its content to the left.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable.c | 62 +++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index d332abeedf0a..c1c6d0b79baa 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -369,39 +369,37 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 			hpdp = (hugepd_t *)&pud;
 			goto out_huge;
 		}
-		{
-			pdshift = PMD_SHIFT;
-			pmdp = pmd_offset(&pud, ea);
-			pmd  = READ_ONCE(*pmdp);
-			/*
-			 * A hugepage collapse is captured by pmd_none, because
-			 * it mark the pmd none and do a hpte invalidate.
-			 */
-			if (pmd_none(pmd))
-				return NULL;
-
-			if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
-				if (is_thp)
-					*is_thp = true;
-				ret_pte = (pte_t *) pmdp;
-				goto out;
-			}
-			/*
-			 * pmd_large check below will handle the swap pmd pte
-			 * we need to do both the check because they are config
-			 * dependent.
-			 */
-			if (pmd_huge(pmd) || pmd_large(pmd)) {
-				ret_pte = (pte_t *) pmdp;
-				goto out;
-			}
-			if (is_hugepd(__hugepd(pmd_val(pmd)))) {
-				hpdp = (hugepd_t *)&pmd;
-				goto out_huge;
-			}
-
-			return pte_offset_kernel(&pmd, ea);
+		pdshift = PMD_SHIFT;
+		pmdp = pmd_offset(&pud, ea);
+		pmd  = READ_ONCE(*pmdp);
+		/*
+		 * A hugepage collapse is captured by pmd_none, because
+		 * it mark the pmd none and do a hpte invalidate.
+		 */
+		if (pmd_none(pmd))
+			return NULL;
+
+		if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
+			if (is_thp)
+				*is_thp = true;
+			ret_pte = (pte_t *)pmdp;
+			goto out;
+		}
+		/*
+		 * pmd_large check below will handle the swap pmd pte
+		 * we need to do both the check because they are config
+		 * dependent.
+		 */
+		if (pmd_huge(pmd) || pmd_large(pmd)) {
+			ret_pte = (pte_t *)pmdp;
+			goto out;
 		}
+		if (is_hugepd(__hugepd(pmd_val(pmd)))) {
+			hpdp = (hugepd_t *)&pmd;
+			goto out_huge;
+		}
+
+		return pte_offset_kernel(&pmd, ea);
 	}
 out_huge:
 	if (!hpdp)
-- 
2.13.3

