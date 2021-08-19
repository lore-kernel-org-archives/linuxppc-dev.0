Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B645C4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 15:21:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9089161101
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 15:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9089161101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gr7ll6hcjz3d9P
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 01:21:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gr7lJ4l7Cz3bZD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Aug 2021 01:21:13 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Gr7lB5Jntz9sTf;
 Thu, 19 Aug 2021 17:21:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8-HapuuuVvve; Thu, 19 Aug 2021 17:21:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Gr7lB4PCtz9sTb;
 Thu, 19 Aug 2021 17:21:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6330B8B842;
 Thu, 19 Aug 2021 17:21:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id i2TXcgzTbkic; Thu, 19 Aug 2021 17:21:10 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.102])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 460738B837;
 Thu, 19 Aug 2021 17:21:10 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 03B7166958; Thu, 19 Aug 2021 15:21:09 +0000 (UTC)
Message-Id: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629386461.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/3] powerpc: Remove MSR_PR check in
 interrupt_exit_{user/kernel}_prepare()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 npiggin@gmail.com
Date: Thu, 19 Aug 2021 15:21:09 +0000 (UTC)
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

In those hot functions that are called at every interrupt, any saved
cycle is worth it.

interrupt_exit_user_prepare() and interrupt_exit_kernel_prepare() are
called from three places:
- From entry_32.S
- From interrupt_64.S
- From interrupt_exit_user_restart() and interrupt_exit_kernel_restart()

In entry_32.S, there are inambiguously called based on MSR_PR:

	interrupt_return:
		lwz	r4,_MSR(r1)
		addi	r3,r1,STACK_FRAME_OVERHEAD
		andi.	r0,r4,MSR_PR
		beq	.Lkernel_interrupt_return
		bl	interrupt_exit_user_prepare
	...
	.Lkernel_interrupt_return:
		bl	interrupt_exit_kernel_prepare

In interrupt_64.S, that's similar:

	interrupt_return_\srr\():
		ld	r4,_MSR(r1)
		andi.	r0,r4,MSR_PR
		beq	interrupt_return_\srr\()_kernel
	interrupt_return_\srr\()_user: /* make backtraces match the _kernel variant */
		addi	r3,r1,STACK_FRAME_OVERHEAD
		bl	interrupt_exit_user_prepare
	...
	interrupt_return_\srr\()_kernel:
		addi	r3,r1,STACK_FRAME_OVERHEAD
		bl	interrupt_exit_kernel_prepare

In interrupt_exit_user_restart() and interrupt_exit_kernel_restart(),
MSR_PR is verified respectively by BUG_ON(!user_mode(regs)) and
BUG_ON(user_mode(regs)) prior to calling interrupt_exit_user_prepare()
and interrupt_exit_kernel_prepare().

The verification in interrupt_exit_user_prepare() and
interrupt_exit_kernel_prepare() are therefore useless and can be removed.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/interrupt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 21bbd615ca41..f26caf911ab5 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -465,7 +465,6 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 
 	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x))
 		BUG_ON(!(regs->msr & MSR_RI));
-	BUG_ON(!(regs->msr & MSR_PR));
 	BUG_ON(arch_irq_disabled_regs(regs));
 	CT_WARN_ON(ct_state() == CONTEXT_USER);
 
@@ -499,7 +498,6 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x) &&
 	    unlikely(!(regs->msr & MSR_RI)))
 		unrecoverable_exception(regs);
-	BUG_ON(regs->msr & MSR_PR);
 	/*
 	 * CT_WARN_ON comes here via program_check_exception,
 	 * so avoid recursion.
-- 
2.25.0

