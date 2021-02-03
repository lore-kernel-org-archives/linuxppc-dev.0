Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0FBC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:27:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BFD64F5F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BFD64F5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW2YN4FMFzF2Wj
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 00:27:52 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW0JB2r7HzDwwm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:46:18 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW0J83pDTz9tkv; Wed,  3 Feb 2021 22:46:16 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210123061244.2076145-1-npiggin@gmail.com>
References: <20210123061244.2076145-1-npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: prevent recursive replay_soft_interrupts
 causing superfluous interrupt
Message-Id: <161235275142.1521894.15184732734416488851.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:46:16 +1100 (AEDT)
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
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 23 Jan 2021 16:12:44 +1000, Nicholas Piggin wrote:
> When an asynchronous interrupt calls irq_exit, it checks for softirqs
> that may have been created, and runs them. Running softirqs enables
> local irqs, which can replay pending interrupts causing recursion in
> replay_soft_interrupts. This abridged trace shows how this can occur:
> 
> ! NIP replay_soft_interrupts
>   LR  interrupt_exit_kernel_prepare
>   Call Trace:
>     interrupt_exit_kernel_prepare (unreliable)
>     interrupt_return
>   --- interrupt: ea0 at __rb_reserve_next
>   NIP __rb_reserve_next
>   LR __rb_reserve_next
>   Call Trace:
>     ring_buffer_lock_reserve
>     trace_function
>     function_trace_call
>     ftrace_call
>     __do_softirq
>     irq_exit
>     timer_interrupt
> !   replay_soft_interrupts
>     interrupt_exit_kernel_prepare
>     interrupt_return
>   --- interrupt: ea0 at arch_local_irq_restore
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/64s: prevent recursive replay_soft_interrupts causing superfluous interrupt
      https://git.kernel.org/powerpc/c/4025c784c573cab7e3f84746cc82b8033923ec62

cheers
