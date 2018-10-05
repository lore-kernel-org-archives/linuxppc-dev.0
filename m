Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A45C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:07:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A8420834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpgsJjsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A8420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RWmk1v4TzF3bK
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 00:07:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XpgsJjsg";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="XpgsJjsg"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RWhF2sDGzF310
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 00:03:56 +1000 (AEST)
Received: by mail-io1-xd41.google.com with SMTP id e12-v6so10725347iok.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=HVMWWg/mFD5PXPFOehRjIN8RzKVxwNX8V7J9t8QauFE=;
 b=XpgsJjsg0FQXAuT8PNue7Tqx3IR/J7a+g2BQ5zLsVJlb0YPhU/wYgioDt6tNxMhgcU
 druYByvNgzYVkAL45oandJmyT3StCL1JRuYruX4NW+bzqzuDwp/wjAqZgjEOo/fAYm6x
 2rJXfvq8L0mjZuY5qa38LF7rvY5cOMZmy6K+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=HVMWWg/mFD5PXPFOehRjIN8RzKVxwNX8V7J9t8QauFE=;
 b=Yvv0OoeEO8Xzka9MvuEmQHePk3liObUH5n8u6ed4NOKHudPm69O6SZ5Oc5C1HzZdF5
 rVbeXd81QTfabKrdvQWcfm+bSdRIon2dv6SjpyaznhtbtbL+IVIIhi7U+4wprY5Y1gut
 +g+X2Y7aHzLvMVrdJpvjV2OVdJKUrD276SlVQECXbAwl4Ak519vXOO1iqF9zsbizUmsG
 ujz+HOM22EKjp6N2rmARpK50xCOWAZl+EMIA8jA6cYvRG8IYYusgL6aeCzlb0KMLUpet
 I4MmUpSNW7dWxx7MKkkn0vmx6t8gpb8NnnFHwf37qTn4vIG8wn7F0eDGbzz4QAmhEPgS
 CobA==
X-Gm-Message-State: ABuFfoh1alSE+Y3KuMMPIDJg/Ges/4HjxFPvObeLLNzn64Wv1869QOu5
 tVlJQTffMdUryCAPrYyF9nwLiU13l/hbgsng8wQ7Nw==
X-Google-Smtp-Source: ACcGV63juOXPe0juD5jLlbDdJbMKdA9iBER8Rm2251M2tj+Tkwv5IKEybrjAbu7JDMaRntevXql60hB48ivGgkWsKi4=
X-Received: by 2002:a6b:3787:: with SMTP id
 e129-v6mr8267883ioa.60.1538748234165; 
 Fri, 05 Oct 2018 07:03:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP;
 Fri, 5 Oct 2018 07:03:53 -0700 (PDT)
In-Reply-To: <20181005135728.GR19272@hirez.programming.kicks-ass.net>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
 <20181005135728.GR19272@hirez.programming.kicks-ass.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 5 Oct 2018 16:03:53 +0200
Message-ID: <CAKv+Gu_GpeqvTHC0E341ehvbYVyEiXMxirijhFTJrwo0OMrdAg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5 October 2018 at 15:57, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>> Add a function pointer abstraction that can be implemented by the arch
>> in a manner that avoids the downsides of function pointers, i.e., the
>> fact that they are typically located in a writable data section, and
>> their vulnerability to Spectre like defects.
>>
>> The FFP (or fast function pointer) is callable as a function, since
>> the generic incarnation is simply that. However, due to the fact that
>> C does not distinguish between functions and function pointers at the
>> call site, the architecture can instead emit it as a patchable sequence
>> of instructions consisting of ordinary branches.
>
> This is basically a static_key, except for indirection function calls?

Yes, that is why I put you on cc :-)

> So why not call the thing static_func or static_call or something like
> that?

Yep that sounds better.
