Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7C5C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:32:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F172171F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F172171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4496lN2pHzzDq8v
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 20:32:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4496Vd3FnbzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:21:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4496Vd1f7xz9sBF; Thu, 28 Feb 2019 20:21:12 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 75d9fc7fd94eb43cdf0bec04499a27ced780af19
X-Patchwork-Hint: ignore
In-Reply-To: <20190226093035.7176-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/powernv: move OPAL call wrapper tracing and interrupt
 handling to C
Message-Id: <4496Vd1f7xz9sBF@ozlabs.org>
Date: Thu, 28 Feb 2019 20:21:12 +1100 (AEDT)
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

On Tue, 2019-02-26 at 09:30:35 UTC, Nicholas Piggin wrote:
> The OPAL call wrapper gets interrupt disabling wrong. It disables
> interrupts just by clearing MSR[EE], which has two problems:
> 
> - It doesn't call into the IRQ tracing subsystem, which means tracing
>   across OPAL calls does not always notice IRQs have been disabled.
> 
> - It doesn't go through the IRQ soft-mask code, which causes a minor
>   bug. MSR[EE] can not be restored by saving the MSR then clearing
>   MSR[EE], because a racing interrupt while soft-masked could clear
>   MSR[EE] between the two steps. This can cause MSR[EE] to be
>   incorrectly enabled when the OPAL call returns. Fortunately that
>   should only result in another masked interrupt being taken to
>   disable MSR[EE] again, but it's a bit sloppy.
> 
> The existing code also saves MSR to PACA, which is not re-entrant if
> there is a nested OPAL call from different MSR contexts, which can
> happen these days with SRESET interrupts on bare metal.
> 
> To fix these issues, move the tracing and IRQ handling code to C, and
> call into asm just for the low level call when everything is ready to
> go. Save the MSR on stack rather than PACA.
> 
> Performance cost is kept to a minimum with a few optimisations:
> 
> - The endian switch upon return is combined with the MSR restore,
>   which avoids an expensive context synchronizing operation for LE
>   kernels. This makes up for the additional mtmsrd to enable
>   interrupts with local_irq_enable().
> 
> - blr is now used to return from the opal_* functions that are called
>   as C functions, to avoid link stack corruption. This requires a
>   skiboot fix as well to keep the call stack balanced.
> 
> A NULL call is more costly after this, (410ns->430ns on POWER9), but
> OPAL calls are generally not performance critical at this scale.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/75d9fc7fd94eb43cdf0bec04499a27ce

cheers
