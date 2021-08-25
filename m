Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28795C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Aug 2021 05:28:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A206128A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Aug 2021 05:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30A206128A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GvZJ75DYfz2ymP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Aug 2021 15:28:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=HwJnYeTK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=HwJnYeTK; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GvZHM4yhBz2xjR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Aug 2021 15:27:27 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GvZHH0xwTz9sW8;
 Wed, 25 Aug 2021 15:27:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1629869244;
 bh=piMp678SY23RlkKblnlJz3x7vve0PTSeMYbmkKycX6E=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=HwJnYeTKh8xD9IFZCs53L4xkr1Usjvrd6AS9CTigFtJMcrqlVTfbidEeDj38/w3VG
 flLS25RORjjXJqRqSKiPBxfa1P/VGGbbAIZq2p77HTSxVZQpUmYvMh57uokmK4lmnZ
 FFqmjK1Qn3CkJkprLbxVCiXwoSV2M9czV7wzvLiW+ULPWmh/O0rH5zRDsD01Of2n82
 ewgPWCmspZXFsE4PZ1asTmSCOZvwFznLZtz1F4YVj0axH8zDQAYjHmMhxUabEFlDxO
 WUx6mXn7UF8BPKQdwt8nJbtQFYeFy9wPMBwam7V6ApFAi+rIXRXIyiXrHOEVqhzcWC
 bqq0kCM1NdfsA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 npiggin@gmail.com
Subject: Re: [PATCH v3 1/3] powerpc: Remove MSR_PR check in
 interrupt_exit_{user/kernel}_prepare()
In-Reply-To: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629707037.git.christophe.leroy@csgroup.eu>
References: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629707037.git.christophe.leroy@csgroup.eu>
Date: Wed, 25 Aug 2021 15:27:22 +1000
Message-ID: <87zgt6aybp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> In those hot functions that are called at every interrupt, any saved
> cycle is worth it.
>
> interrupt_exit_user_prepare() and interrupt_exit_kernel_prepare() are
> called from three places:
> - From entry_32.S
> - From interrupt_64.S
> - From interrupt_exit_user_restart() and interrupt_exit_kernel_restart()
>
> In entry_32.S, there are inambiguously called based on MSR_PR:
>
> 	interrupt_return:
> 		lwz	r4,_MSR(r1)
> 		addi	r3,r1,STACK_FRAME_OVERHEAD
> 		andi.	r0,r4,MSR_PR
> 		beq	.Lkernel_interrupt_return
> 		bl	interrupt_exit_user_prepare
> 	...
> 	.Lkernel_interrupt_return:
> 		bl	interrupt_exit_kernel_prepare
>
> In interrupt_64.S, that's similar:
>
> 	interrupt_return_\srr\():
> 		ld	r4,_MSR(r1)
> 		andi.	r0,r4,MSR_PR
> 		beq	interrupt_return_\srr\()_kernel
> 	interrupt_return_\srr\()_user: /* make backtraces match the _kernel variant */
> 		addi	r3,r1,STACK_FRAME_OVERHEAD
> 		bl	interrupt_exit_user_prepare
> 	...
> 	interrupt_return_\srr\()_kernel:
> 		addi	r3,r1,STACK_FRAME_OVERHEAD
> 		bl	interrupt_exit_kernel_prepare
>
> In interrupt_exit_user_restart() and interrupt_exit_kernel_restart(),
> MSR_PR is verified respectively by BUG_ON(!user_mode(regs)) and
> BUG_ON(user_mode(regs)) prior to calling interrupt_exit_user_prepare()
> and interrupt_exit_kernel_prepare().
>
> The verification in interrupt_exit_user_prepare() and
> interrupt_exit_kernel_prepare() are therefore useless and can be removed.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/interrupt.c | 2 --
>  1 file changed, 2 deletions(-)

I'll pick this one up independent of the other two patches.

cheers
