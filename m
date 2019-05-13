Return-Path: <SRS0=ygHD=TN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C310C04AA7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 11:54:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27FC7208CA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 11:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FC7208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 452fPG22SdzDqGG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 21:54:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 452fMq74pTzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2019 21:53:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 452fMp6Lnjz9s4V;
 Mon, 13 May 2019 21:53:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shawn Landden <shawn@git.icu>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RESEND] powerpc: add simd.h implementation specific to
 PowerPC
In-Reply-To: <20190513005104.20140-1-shawn@git.icu>
References: <20190512165032.19942-1-shawn@git.icu>
 <20190513005104.20140-1-shawn@git.icu>
Date: Mon, 13 May 2019 21:53:09 +1000
Message-ID: <87mujqtvtm.fsf@concordia.ellerman.id.au>
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
Cc: Shawn Landden <shawn@git.icu>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Shawn Landden <shawn@git.icu> writes:
> It is safe to do SIMD in an interrupt on PowerPC.

No it's not sorry :)

> Only disable when there is no SIMD available
> (and this is a static branch).
>
> Tested and works with the WireGuard (Zinc) patch I wrote that needs this.
> Also improves performance of the crypto subsystem that checks this.
>
> Re-sending because this linuxppc-dev didn't seem to accept it.

It did but you were probably moderated as a non-subscriber? In future if
you just wait a while for the moderators to wake up it should come
through. Though having posted once and been approved I think you might
not get moderated at all in future (?).

> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=203571
> Signed-off-by: Shawn Landden <shawn@git.icu>
> ---
>  arch/powerpc/include/asm/simd.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/simd.h
>
> diff --git a/arch/powerpc/include/asm/simd.h b/arch/powerpc/include/asm/simd.h
> new file mode 100644
> index 000000000..b3fecb95a
> --- /dev/null
> +++ b/arch/powerpc/include/asm/simd.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#include <asm/cpu_has_feature.h>
> +
> +/*
> + * may_use_simd - whether it is allowable at this time to issue SIMD
> + *                instructions or access the SIMD register file
> + *
> + * As documented in Chapter 6.2.1 Machine Status Save/Restore Registers
> + * of Power ISA (2.07 and 3.0), all registers are saved/restored in an interrupt.

I think the confusion here is that the ISA says:

  When various interrupts occur, the state of the machine is saved in the
  Machine Status Save/Restore registers (SRR0 and SRR1).

And you've read that to mean all "the state" of the machine, ie.
including GPRs, FPRs etc.

But unfortunately it's not that simple. All the hardware does is write
two 64-bit registers (SRR0 & SRR1) with the information required to be
able to return to the state the CPU was in prior to the interrupt. That
includes (obviously) the PC you were executing at, and what state the
CPU was in (ie. 64/32-bit, MMU on/off, FP on/off etc.). All the saving
of registers etc. is left up to software. It's the RISC way :)


I guess we need to work out why exactly may_use_simd() is returning
false in your kworker. 

cheers
