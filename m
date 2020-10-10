Return-Path: <SRS0=a44y=DR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7C2C433DF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2020 15:23:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CCCF22363
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2020 15:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCCF22363
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C7pbs70ZhzDr58
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Oct 2020 02:23:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C7pQ80NqdzDqsl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2020 02:14:35 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4C7pPx2Vssz9v1JY;
 Sat, 10 Oct 2020 17:14:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id cuGeN8Bp2LeP; Sat, 10 Oct 2020 17:14:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4C7pPx0sj0z9v1JX;
 Sat, 10 Oct 2020 17:14:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 686AD8B77D;
 Sat, 10 Oct 2020 17:14:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id oGgrYaCL4l73; Sat, 10 Oct 2020 17:14:30 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 29AE88B75B;
 Sat, 10 Oct 2020 17:14:30 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id EF177663C3; Sat, 10 Oct 2020 15:14:29 +0000 (UTC)
Message-Id: <b02ca2ed2d3676a096219b48c0f69ec982a75bcf.1602342801.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/40x: Always fault when _PAGE_ACCESSED is not set
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Sat, 10 Oct 2020 15:14:29 +0000 (UTC)
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

The kernel expects pte_young() to work regardless of CONFIG_SWAP.

Make sure a minor fault is taken to set _PAGE_ACCESSED when it
is not already set, regardless of the selection of CONFIG_SWAP.

Fixes: 2c74e2586bb9 ("powerpc/40x: Rework 40x PTE access and TLB miss")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_40x.S | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 44c9018aed1b..a1ae00689e0f 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -284,11 +284,7 @@ _ENTRY(saved_ksp_limit)
 
 	rlwimi	r11, r10, 22, 20, 29	/* Compute PTE address */
 	lwz	r11, 0(r11)		/* Get Linux PTE */
-#ifdef CONFIG_SWAP
 	li	r9, _PAGE_PRESENT | _PAGE_ACCESSED
-#else
-	li	r9, _PAGE_PRESENT
-#endif
 	andc.	r9, r9, r11		/* Check permission */
 	bne	5f
 
@@ -369,11 +365,7 @@ _ENTRY(saved_ksp_limit)
 
 	rlwimi	r11, r10, 22, 20, 29	/* Compute PTE address */
 	lwz	r11, 0(r11)		/* Get Linux PTE */
-#ifdef CONFIG_SWAP
 	li	r9, _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
-#else
-	li	r9, _PAGE_PRESENT | _PAGE_EXEC
-#endif
 	andc.	r9, r9, r11		/* Check permission */
 	bne	5f
 
-- 
2.25.0

