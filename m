Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40C7C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:50:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6070D2086A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="E9ddfQYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6070D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444rpb2T86zDqKR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 21:50:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="E9ddfQYt"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444rXT6fZ8zDqNN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 21:38:01 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444rXP5MjJz9typD;
 Thu, 21 Feb 2019 11:37:57 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=E9ddfQYt; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id d2JJfiF9qa1q; Thu, 21 Feb 2019 11:37:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444rXP480kz9typB;
 Thu, 21 Feb 2019 11:37:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550745477; bh=MAszOCzV0/hHXUCEqsnUBeQfl5X8y4aIl+tqH9Rpxb0=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=E9ddfQYtOAhHLcw6fyE5y/XnjzFDmQPziNp9UZzihqXMJFh0fpSnVvBBTduuCZqkC
 aXAukLcCYpfZzklUMX+GhWS3daf08AOFTbcBX4YiKi147iDFLE8eDfP2ZklB300sBm
 lzjHtXR5TSGHB6XCMBojsAG5v+sNZkQYzDAi06ks=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BB1218B859;
 Thu, 21 Feb 2019 11:37:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 64LiCa2_Ketq; Thu, 21 Feb 2019 11:37:58 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 946668B852;
 Thu, 21 Feb 2019 11:37:58 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 68C256E856; Thu, 21 Feb 2019 10:37:58 +0000 (UTC)
Message-Id: <c02cb25143cd8e8350bb79d41786929f1460b6c3.1550745320.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550745320.git.christophe.leroy@c-s.fr>
References: <cover.1550745320.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 06/10] powerpc/603: Don't handle kernel page TLB misses
 when not need
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 21 Feb 2019 10:37:58 +0000 (UTC)
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

ITLB miss on kernel pages only occur with CONFIG_MODULES and
CONFIG_DEBUG_PAGEALLOC.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 4c2cc42399aa..e4338d785a94 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -498,15 +498,19 @@ InstructionTLBMiss:
  */
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_IMISS
+#if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC)
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
+#endif
 	mfspr	r2, SPRN_SPRG_PGDIR
 	li	r1,_PAGE_USER|_PAGE_PRESENT|_PAGE_EXEC /* low addresses tested as user */
+#if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC)
 	bge-	112f
 	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
 	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
+#endif
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
-- 
2.13.3

