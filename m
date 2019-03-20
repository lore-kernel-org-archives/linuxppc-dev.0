Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD313C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:51:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA4F2184E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nZO1F+Wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA4F2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PRY72RV5zDqPX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:51:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="nZO1F+Wl"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQZK42B0zDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:07:05 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQZF305Mz9vC0C;
 Wed, 20 Mar 2019 11:07:01 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=nZO1F+Wl; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ub_0466ghx69; Wed, 20 Mar 2019 11:07:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZF1CqLz9vByx;
 Wed, 20 Mar 2019 11:07:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076421; bh=WJ7TCgPivsGBDKY9DLw8e4vCOBbhMBoUDuExbw1LynI=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=nZO1F+WlAYNt95mU+MPvPjQMwVmLLwHK6D3EbtY9EQ1BfebpD2xzQbrC7b+dKDCzD
 UH2o71BjSoae/rUKJc2U+31X5BgONXXJPMYL6Qo+oSZwLLCtqZl3stVTVrK5REdcCe
 9xCZa24U0D1gpMJbijEeFal4s08E3gLHu9SfyBrM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4550D8B918;
 Wed, 20 Mar 2019 11:07:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id XWGiWzpgMPuU; Wed, 20 Mar 2019 11:07:02 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 21A188B911;
 Wed, 20 Mar 2019 11:07:02 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id DB96763AEF; Wed, 20 Mar 2019 10:07:01 +0000 (UTC)
Message-Id: <91d2bdbcf0f02f689405ad7eb760ca5c6cb91ca5.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 25/27] powerpc/mm: flatten function __find_linux_pte()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:07:01 +0000 (UTC)
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

This patch flattens the function by getting rid of as much if/else
as possible. In order to ease the review, this is done in two steps.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 9f4ccd15849f..d332abeedf0a 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -339,12 +339,16 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 	 */
 	if (pgd_none(pgd))
 		return NULL;
-	else if (pgd_huge(pgd)) {
-		ret_pte = (pte_t *) pgdp;
+
+	if (pgd_huge(pgd)) {
+		ret_pte = (pte_t *)pgdp;
 		goto out;
-	} else if (is_hugepd(__hugepd(pgd_val(pgd))))
+	}
+	if (is_hugepd(__hugepd(pgd_val(pgd)))) {
 		hpdp = (hugepd_t *)&pgd;
-	else {
+		goto out_huge;
+	}
+	{
 		/*
 		 * Even if we end up with an unmap, the pgtable will not
 		 * be freed, because we do an rcu free and here we are
@@ -356,12 +360,16 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 
 		if (pud_none(pud))
 			return NULL;
-		else if (pud_huge(pud)) {
+
+		if (pud_huge(pud)) {
 			ret_pte = (pte_t *) pudp;
 			goto out;
-		} else if (is_hugepd(__hugepd(pud_val(pud))))
+		}
+		if (is_hugepd(__hugepd(pud_val(pud)))) {
 			hpdp = (hugepd_t *)&pud;
-		else {
+			goto out_huge;
+		}
+		{
 			pdshift = PMD_SHIFT;
 			pmdp = pmd_offset(&pud, ea);
 			pmd  = READ_ONCE(*pmdp);
@@ -386,12 +394,16 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 			if (pmd_huge(pmd) || pmd_large(pmd)) {
 				ret_pte = (pte_t *) pmdp;
 				goto out;
-			} else if (is_hugepd(__hugepd(pmd_val(pmd))))
+			}
+			if (is_hugepd(__hugepd(pmd_val(pmd)))) {
 				hpdp = (hugepd_t *)&pmd;
-			else
-				return pte_offset_kernel(&pmd, ea);
+				goto out_huge;
+			}
+
+			return pte_offset_kernel(&pmd, ea);
 		}
 	}
+out_huge:
 	if (!hpdp)
 		return NULL;
 
-- 
2.13.3

