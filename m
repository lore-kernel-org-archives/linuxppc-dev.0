Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADF0C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 00:49:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F4120830
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 00:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F4120830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CLyq6VV0zDqHv
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 11:49:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CLwl3xdhzDqHR
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 11:48:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44CLwl2kdsz9sDn; Mon,  4 Mar 2019 11:48:07 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9580b71b5a7863c24a9bd18bcd2ad759b86b1eff
X-Patchwork-Hint: ignore
In-Reply-To: <d273fd9f1cc7ee36e1ee4da20631d507c39efe6d.1551267823.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicolai Stange <nstange@suse.de>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/32: Clear on-stack exception marker upon exception return
Message-Id: <44CLwl2kdsz9sDn@ozlabs.org>
Date: Mon,  4 Mar 2019 11:48:07 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-02-27 at 11:45:30 UTC, Christophe Leroy wrote:
> Clear the on-stack STACK_FRAME_REGS_MARKER on exception exit in order
> to avoid confusing stacktrace like the one below.
> 
> Call Trace:
> [c0e9dca0] [c01c42a0] print_address_description+0x64/0x2bc (unreliable)
> [c0e9dcd0] [c01c4684] kasan_report+0xfc/0x180
> [c0e9dd10] [c0895130] memchr+0x24/0x74
> [c0e9dd30] [c00a9e38] msg_print_text+0x124/0x574
> [c0e9dde0] [c00ab710] console_unlock+0x114/0x4f8
> [c0e9de40] [c00adc60] vprintk_emit+0x188/0x1c4
> --- interrupt: c0e9df00 at 0x400f330
>     LR = init_stack+0x1f00/0x2000
> [c0e9de80] [c00ae3c4] printk+0xa8/0xcc (unreliable)
> [c0e9df20] [c0c27e44] early_irq_init+0x38/0x108
> [c0e9df50] [c0c15434] start_kernel+0x310/0x488
> [c0e9dff0] [00003484] 0x3484
> 
> With this patch the trace becomes:
> 
> Call Trace:
> [c0e9dca0] [c01c42c0] print_address_description+0x64/0x2bc (unreliable)
> [c0e9dcd0] [c01c46a4] kasan_report+0xfc/0x180
> [c0e9dd10] [c0895150] memchr+0x24/0x74
> [c0e9dd30] [c00a9e58] msg_print_text+0x124/0x574
> [c0e9dde0] [c00ab730] console_unlock+0x114/0x4f8
> [c0e9de40] [c00adc80] vprintk_emit+0x188/0x1c4
> [c0e9de80] [c00ae3e4] printk+0xa8/0xcc
> [c0e9df20] [c0c27e44] early_irq_init+0x38/0x108
> [c0e9df50] [c0c15434] start_kernel+0x310/0x488
> [c0e9dff0] [00003484] 0x3484
> 
> Cc: stable@vger.kernel.org
> Cc: Nicolai Stange <nstange@suse.de>
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9580b71b5a7863c24a9bd18bcd2ad759

cheers
