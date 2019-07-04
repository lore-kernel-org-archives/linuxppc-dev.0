Return-Path: <SRS0=vYn1=VB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063E4C0651F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jul 2019 16:05:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869F02085A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jul 2019 16:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869F02085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45fjVg1gy9zDqd0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jul 2019 02:05:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45fjDM5907zDqSS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2019 01:52:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45fjDM3kMWz9sPM; Fri,  5 Jul 2019 01:52:51 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0a882e28468f48ab3d9a36dde0a5723ea29ed1ed
In-Reply-To: <20190628063322.11628-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc/64s/exception: remove bad stack branch
Message-Id: <45fjDM3kMWz9sPM@ozlabs.org>
Date: Fri,  5 Jul 2019 01:52:51 +1000 (AEST)
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-06-28 at 06:33:18 UTC, Nicholas Piggin wrote:
> The bad stack test in interrupt handlers has a few problems. For
> performance it is taken in the common case, which is a fetch bubble
> and a waste of i-cache.
> 
> For code development and maintainence, it requires yet another stack
> frame setup routine, and that constrains all exception handlers to
> follow the same register save pattern which inhibits future
> optimisation.
> 
> Remove the test/branch and replace it with a trap. Teach the program
> check handler to use the emergency stack for this case.
> 
> This does not result in quite so nice a message, however the SRR0 and
> SRR1 of the crashed interrupt can be seen in r11 and r12, as is the
> original r1 (adjusted by INT_FRAME_SIZE). These are the most important
> parts to debugging the issue.
> 
> The original r9-12 and cr0 is lost, which is the main downside.
> 
>   kernel BUG at linux/arch/powerpc/kernel/exceptions-64s.S:847!
>   Oops: Exception in kernel mode, sig: 5 [#1]
>   BE SMP NR_CPUS=2048 NUMA PowerNV
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>   NIP:  c000000000009108 LR: c000000000cadbcc CTR: c0000000000090f0
>   REGS: c0000000fffcbd70 TRAP: 0700   Not tainted
>   MSR:  9000000000021032 <SF,HV,ME,IR,DR,RI>  CR: 28222448  XER: 20040000
>   CFAR: c000000000009100 IRQMASK: 0
>   GPR00: 000000000000003d fffffffffffffd00 c0000000018cfb00 c0000000f02b3166
>   GPR04: fffffffffffffffd 0000000000000007 fffffffffffffffb 0000000000000030
>   GPR08: 0000000000000037 0000000028222448 0000000000000000 c000000000ca8de0
>   GPR12: 9000000002009032 c000000001ae0000 c000000000010a00 0000000000000000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR20: c0000000f00322c0 c000000000f85200 0000000000000004 ffffffffffffffff
>   GPR24: fffffffffffffffe 0000000000000000 0000000000000000 000000000000000a
>   GPR28: 0000000000000000 0000000000000000 c0000000f02b391c c0000000f02b3167
>   NIP [c000000000009108] decrementer_common+0x18/0x160
>   LR [c000000000cadbcc] .vsnprintf+0x3ec/0x4f0
>   Call Trace:
>   Instruction dump:
>   996d098a 994d098b 38610070 480246ed 48005518 60000000 38200000 718a4000
>   7c2a0b78 3821fd00 41c20008 e82d0970 <0981fd00> f92101a0 f9610170 f9810178
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0a882e28468f48ab3d9a36dde0a5723ea29ed1ed

cheers
