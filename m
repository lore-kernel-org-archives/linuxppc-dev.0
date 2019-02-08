Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23502C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:43:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599E520869
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="od0pUUpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599E520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wxGc2kbVzDqV5
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 00:43:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="od0pUUpA"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ww831L5czDqW3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 23:52:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43ww7y5N6Gz9v0dK;
 Fri,  8 Feb 2019 13:52:46 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=od0pUUpA; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id V40e50qwJ-Fe; Fri,  8 Feb 2019 13:52:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43ww7y4LgXz9v0dH;
 Fri,  8 Feb 2019 13:52:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549630366; bh=jmw26VL5DlbU5xPzwi20JA1iGuP0Zz1UBCkxt3nBWKk=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=od0pUUpAS5EB4OeZ9qmt7dQt7q1e4qlKlLKojyRt7MCwL7SnbBaoRqFstGnSJ+PHO
 x6JU3JyCxOAvkT0J+BeLGrhVMACXMt4JxapnssbDKbb+9rO/BFRdq2HpUYduAcBG5M
 Y/+JJJwdYigmqra1SfrSVcfI1alg3pBadolA4R9o=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E7FA48B8D7;
 Fri,  8 Feb 2019 13:52:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id tSQ4rcdjwaCh; Fri,  8 Feb 2019 13:52:47 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CDB2E8B756;
 Fri,  8 Feb 2019 13:52:47 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 99C8F653E8; Fri,  8 Feb 2019 12:52:47 +0000 (UTC)
Message-Id: <4f699ac0dd85d4108f240dc7bdfba340e5cb835b.1549630193.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1549630193.git.christophe.leroy@c-s.fr>
References: <cover.1549630193.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 15/16] powerpc/32: Remove MSR_PR test when returning
 from syscall
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri,  8 Feb 2019 12:52:47 +0000 (UTC)
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

syscalls are from user only, so we can account time without checking
whether returning to kernel or user as it will only be user.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 137bd2103051..0927d5ff1e79 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -482,12 +482,7 @@ BEGIN_FTR_SECTION
 	lwarx	r7,0,r1
 END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1			/* to clear the reservation */
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-	andi.	r4,r8,MSR_PR
-	beq	3f
 	ACCOUNT_CPU_USER_EXIT(r2, r5, r7)
-3:
-#endif
 	lwz	r4,_LINK(r1)
 	lwz	r5,_CCR(r1)
 	mtlr	r4
-- 
2.13.3

