Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2129C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 17:09:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A97B2184D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 17:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="X75PS0go"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A97B2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W7WK1Bh7zDqXY
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 04:09:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="X75PS0go"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W6r31tJCzDqRh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 03:38:43 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44W6qy4VTDz9tyQh;
 Fri, 29 Mar 2019 17:38:38 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=X75PS0go; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id es42c00ocNvf; Fri, 29 Mar 2019 17:38:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44W6qy3Ns9z9tyQR;
 Fri, 29 Mar 2019 17:38:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553877518; bh=hEmTQ9o0T7UyWMxVbi3/Eu5O/W8AzX4iVyLZHLLlYzg=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=X75PS0gojQfhh4QhIHdH0oAeU9z7Hb+RmNBQMPQ6kg0QpAli+N1LBxcpKArIKL7q8
 Ed4cPAR9oJO6heTCf9/FulWpZotzCpUW4H7l0lJ8RvZN9X+rxM8vsPnWwtN9bdsi/a
 0Jskt9DKYM5yAbbsGj+UAn/x250c2UQEpwW6mziU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1224E8B93D;
 Fri, 29 Mar 2019 17:38:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id bYi_-NeMyelb; Fri, 29 Mar 2019 17:38:40 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E9C7A8B938;
 Fri, 29 Mar 2019 17:38:39 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C93A76FC56; Fri, 29 Mar 2019 16:38:39 +0000 (UTC)
Message-Id: <8f513e30d3fc875263befdaf38f4f80c3165c671.1553877076.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553877076.git.christophe.leroy@c-s.fr>
References: <cover.1553877076.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 17/17] powerpc/32: Don't add dummy frames when calling
 trace_hardirqs_on/off
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 29 Mar 2019 16:38:39 +0000 (UTC)
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

No need to add dummy frames when calling trace_hardirqs_on or
trace_hardirqs_off. GCC properly handles empty stacks.

In addition, powerpc doesn't set CONFIG_FRAME_POINTER, therefore
__builtin_return_address(1..) returns NULL at all time. So the
dummy frames are definitely unneeded here.

In the meantime, avoid reading memory for loading r1 with a value
we already know.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index c648b75f41a3..c1e9be5cba10 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -237,12 +237,7 @@ transfer_to_handler_cont:
 
 reenable_mmu:
 	/*
-	 * The trace_hardirqs_off will use CALLER_ADDR0 and CALLER_ADDR1.
-	 * If from user mode there is only one stack frame on the stack, and
-	 * accessing CALLER_ADDR1 will cause oops. So we need create a dummy
-	 * stack frame to make trace_hardirqs_off happy.
-	 *
-	 * This is handy because we also need to save a bunch of GPRs,
+	 * We save a bunch of GPRs,
 	 * r3 can be different from GPR3(r1) at this point, r9 and r11
 	 * contains the old MSR and handler address respectively,
 	 * r4 & r5 can contain page fault arguments that need to be passed
@@ -933,18 +928,11 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 	 */
 	andi.	r10,r9,MSR_EE
 	beq	1f
-	/*
-	 * Since the ftrace irqsoff latency trace checks CALLER_ADDR1,
-	 * which is the stack frame here, we need to force a stack frame
-	 * in case we came from user space.
-	 */
 	stwu	r1,-32(r1)
 	mflr	r0
 	stw	r0,4(r1)
-	stwu	r1,-32(r1)
 	bl	trace_hardirqs_on
-	lwz	r1,0(r1)
-	lwz	r1,0(r1)
+	addi	r1, r1, 32
 	lwz	r9,_MSR(r1)
 1:
 #endif /* CONFIG_TRACE_IRQFLAGS */
-- 
2.13.3

