Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADC1C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 17:07:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BE22184D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 17:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nyXYIod6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BE22184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W7Tf4W6mzDqXr
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 04:07:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="nyXYIod6"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W6r22S2CzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 03:38:42 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44W6qx3vvVz9tyQj;
 Fri, 29 Mar 2019 17:38:37 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=nyXYIod6; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id AglH_oIGkeWC; Fri, 29 Mar 2019 17:38:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44W6qx2s6Dz9tyQR;
 Fri, 29 Mar 2019 17:38:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553877517; bh=DsBNl9Sur9OH4PdUs/hysFTLVmz5ylaox1/f92Sqvd8=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=nyXYIod6pPssD/qU4noHRCfYT525MBEvMU9Wgzk1LG+QUimSD2fx7YqBqYoEXNtHV
 yGU5P73h5tLN3abw0dYDIMAYfgn3OVyJec8eyZlFp/C/eEa0Sz3l5JjGahChOo9eJR
 0UhyU0ZZCB9jBfl2SurWY9pF1vvxWaV9X2hORn4k=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 050768B93D;
 Fri, 29 Mar 2019 17:38:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id L-087Tu9WM4e; Fri, 29 Mar 2019 17:38:38 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E2D498B938;
 Fri, 29 Mar 2019 17:38:38 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C3AB16FC56; Fri, 29 Mar 2019 16:38:38 +0000 (UTC)
Message-Id: <7b2c2ab6328b33b3cacc47d24f5cb20b6fcbf96b.1553877076.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553877076.git.christophe.leroy@c-s.fr>
References: <cover.1553877076.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 16/17] powerpc/32: don't do syscall stuff in
 transfer_to_handler
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 29 Mar 2019 16:38:38 +0000 (UTC)
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
 arch/powerpc/kernel/entry_32.S | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index edd119d3c52b..c648b75f41a3 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -211,7 +211,6 @@ transfer_to_handler_cont:
 	 */
 	tophys(r12, r1)
 	lwz	r12,_MSR(r12)
-	xor	r12,r10,r12
 	andi.	r12,r12,MSR_EE
 	bne	1f
 
@@ -252,9 +251,6 @@ reenable_mmu:
 	 * the rest is restored from the exception frame.
 	 */
 
-	/* Are we enabling or disabling interrupts ? */
-	andi.	r0,r10,MSR_EE
-
 	stwu	r1,-32(r1)
 	stw	r9,8(r1)
 	stw	r11,12(r1)
@@ -262,8 +258,6 @@ reenable_mmu:
 	stw	r4,20(r1)
 	stw	r5,24(r1)
 
-	bne-	0f
-
 	/* If we are disabling interrupts (normal case), simply log it with
 	 * lockdep
 	 */
@@ -281,19 +275,6 @@ reenable_mmu:
 	mtctr	r11
 	mtlr	r9
 	bctr				/* jump to handler */
-
-	/* If we are enabling interrupt, this is a syscall. They shouldn't
-	 * happen while interrupts are disabled, so let's do a warning here.
-	 */
-0:	trap
-	EMIT_BUG_ENTRY 0b,__FILE__,__LINE__, BUGFLAG_WARNING
-	bl	trace_hardirqs_on
-
-	/* Now enable for real */
-	mfmsr	r10
-	ori	r10,r10,MSR_EE
-	mtmsr	r10
-	b	2b
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 #if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
-- 
2.13.3

