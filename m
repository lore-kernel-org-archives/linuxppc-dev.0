Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B568C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:46:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782BD20869
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="b+RNrtoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782BD20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wxKz1y1JzDq5W
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 00:46:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="b+RNrtoI"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ww860LsbzDqW3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 23:52:53 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43ww805yzcz9v0dM;
 Fri,  8 Feb 2019 13:52:48 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=b+RNrtoI; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 3Hj8E3XDvFOq; Fri,  8 Feb 2019 13:52:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43ww804yZ0z9v0dH;
 Fri,  8 Feb 2019 13:52:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549630368; bh=77j0wGUnvUgbpHVhTJyROpdDSW+dwdzLxURZEG3jqb0=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=b+RNrtoIn2FEyqUD2dikw6CcErmTWeO8elSPxhty3NtPQIZYK8WLPwTRn+7nNBdAP
 xzD9G2tmJ3ZeiXcPr2GMUpBPSBRgdPyqUqnatz4gfQPaVPhTNIHDCihQHn0yJxdhpT
 gBGDDfwyohivI+xhXtj9Vi/LJXbiUfNmUv8TF0tA=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 075C38B8D7;
 Fri,  8 Feb 2019 13:52:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id WyCDRsC37F5J; Fri,  8 Feb 2019 13:52:49 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E2DB08B756;
 Fri,  8 Feb 2019 13:52:49 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id A6F46653E8; Fri,  8 Feb 2019 12:52:49 +0000 (UTC)
Message-Id: <e7ba540e3ca711be32ca84870fb2314c2f0b025d.1549630193.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1549630193.git.christophe.leroy@c-s.fr>
References: <cover.1549630193.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 16/16] powerpc/32: don't do syscall stuff in
 transfer_to_handler on non BOOKE
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri,  8 Feb 2019 12:52:49 +0000 (UTC)
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

As syscalls are now handled via a fast entry path, syscall related
actions can be removed from the generic transfer_to_handler path.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0927d5ff1e79..85f1fc88c237 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -211,7 +211,9 @@ transfer_to_handler_cont:
 	 */
 	tophys(r12, r1)
 	lwz	r12,_MSR(r12)
+#ifdef CONFIG_BOOKE	/* to be removed once BOOKE uses fast syscall entry */
 	xor	r12,r10,r12
+#endif
 	andi.	r12,r12,MSR_EE
 	bne	1f
 
@@ -252,8 +254,10 @@ reenable_mmu:
 	 * the rest is restored from the exception frame.
 	 */
 
+#ifdef CONFIG_BOOKE	/* to be removed once BOOKE uses fast syscall entry */
 	/* Are we enabling or disabling interrupts ? */
 	andi.	r0,r10,MSR_EE
+#endif
 
 	stwu	r1,-32(r1)
 	stw	r9,8(r1)
@@ -262,7 +266,9 @@ reenable_mmu:
 	stw	r4,20(r1)
 	stw	r5,24(r1)
 
+#ifdef CONFIG_BOOKE	/* to be removed once BOOKE uses fast syscall entry */
 	bne-	0f
+#endif
 
 	/* If we are disabling interrupts (normal case), simply log it with
 	 * lockdep
@@ -282,6 +288,7 @@ reenable_mmu:
 	mtlr	r9
 	bctr				/* jump to handler */
 
+#ifdef CONFIG_BOOKE	/* to be removed once BOOKE uses fast syscall entry */
 	/* If we are enabling interrupt, this is a syscall. They shouldn't
 	 * happen while interrupts are disabled, so let's do a warning here.
 	 */
@@ -294,6 +301,7 @@ reenable_mmu:
 	ori	r10,r10,MSR_EE
 	mtmsr	r10
 	b	2b
+#endif
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 #if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
-- 
2.13.3

