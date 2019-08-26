Return-Path: <SRS0=H2FS=WW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83772C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Aug 2019 11:43:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7F820679
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Aug 2019 11:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7F820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46H9B15X2szDqhN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Aug 2019 21:43:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46H9870tSVzDqNB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2019 21:41:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46H98664TJz9sMr;
 Mon, 26 Aug 2019 21:41:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/time: use feature fixup in __USE_RTC() instead of
 cpu feature.
In-Reply-To: <55c267ac6e0cd289970accfafbf9dda11a324c2e.1566802736.git.christophe.leroy@c-s.fr>
References: <55c267ac6e0cd289970accfafbf9dda11a324c2e.1566802736.git.christophe.leroy@c-s.fr>
Date: Mon, 26 Aug 2019 21:41:39 +1000
Message-ID: <87blwc40i4.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> sched_clock(), used by printk(), calls __USE_RTC() to know
> whether to use realtime clock or timebase.
>
> __USE_RTC() uses cpu_has_feature() which is initialised by
> machine_init(). Before machine_init(), __USE_RTC() returns true,
> leading to a program check exception on CPUs not having realtime
> clock.
>
> In order to be able to use printk() earlier, use feature fixup.
> Feature fixups are applies in early_init(), enabling the use of
> printk() earlier.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/time.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

The other option would be just to make this a compile time decision, eg.
add CONFIG_PPC_601 and use that to gate whether we use RTC.

Given how many 601 users there are, maybe 1?, I think that would be a
simpler option and avoids complicating the code / binary for everyone
else.

cheers

> diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
> index 54f4ec1f9fab..3455cb54c333 100644
> --- a/arch/powerpc/include/asm/time.h
> +++ b/arch/powerpc/include/asm/time.h
> @@ -42,7 +42,14 @@ struct div_result {
>  /* Accessor functions for the timebase (RTC on 601) registers. */
>  /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
>  #ifdef CONFIG_PPC_BOOK3S_32
> -#define __USE_RTC()	(cpu_has_feature(CPU_FTR_USE_RTC))
> +static inline bool __USE_RTC(void)
> +{
> +	asm_volatile_goto(ASM_FTR_IFCLR("nop;", "b %1;", %0) ::
> +			  "i" (CPU_FTR_USE_RTC) :: l_use_rtc);
> +	return false;
> +l_use_rtc:
> +	return true;
> +}
>  #else
>  #define __USE_RTC()	0
>  #endif
> -- 
> 2.13.3
