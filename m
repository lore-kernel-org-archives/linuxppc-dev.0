Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D326C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:32:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FE02084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SUJiV1sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FE02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rdf55STXzF3cc
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:32:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SUJiV1sb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="SUJiV1sb"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RcCy5Qq4zF3c9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 03:28:14 +1000 (AEST)
Received: by mail-it1-x142.google.com with SMTP id i76-v6so3803931ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=KeuwEIGLwIhFnp/zlZGqWtiTYKkJEMFiADynXUfL25E=;
 b=SUJiV1sbbTKmPc9HPG1slNKP6p5baYgdH3XkIvNxgRs4ZyKISmE9fT6fEB0CJTl/S5
 0ubY+Idg3BztaD8swEnk88xueIApSBYO2WkK04eHlOC81j2jOl1U1DuyQl8yMLQROAJy
 XUfuCNIMkrwNy9Z2/fTdHg1vmErnsGL1+zH60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=KeuwEIGLwIhFnp/zlZGqWtiTYKkJEMFiADynXUfL25E=;
 b=WetjRCWFe4Y3YsMUdC+DkIwSz+ijqJHJep8qQ8gEhq2UTAhUXdCdGG2aUyIHIrrlo7
 PS8S5AvlI56vXJm0myOardLMuDo8PJLi3rG+jpsrS4RpS7qPTVmqJi/d7BPKyE/TG7ZT
 KBIyPjNMYh5uJorFBM+Qpr2WgKnXCdDIInEkYuoAqXpamn/Nm8C9j2ybgL82SQf8xke/
 h5EpMAnXvQHDAbhTcZ+vKpNfs4UoU1etfEz0QRCXVt3mMRXtYpgBtsvuEdxOU1tiUDhu
 1R8eNZ5tXaHsTcCuxMrprfWT0h28fam5pURmRSfWwqy1vM1w7VUXbNi/RC+4VQlPKetp
 /K+A==
X-Gm-Message-State: ABuFfogoAY9UKiV2YeYfgQEcKISCMQqrulr2NAu+olGxFB4KVjQsnKSD
 5dspDn9/YA5xBdHf5SchE6PTTqOCLa9mQg7Y61bRSQ==
X-Google-Smtp-Source: ACcGV63aGKMJpr5iTElN96TVtIJ9jMtEzfWpHyUa+ryt08/aiKtWkGo/CZ4zCA/Diby+Fed3Ee/KKUxJ3o4V2rqHq4s=
X-Received: by 2002:a24:a10b:: with SMTP id
 y11-v6mr5209852ite.148.1538760492849; 
 Fri, 05 Oct 2018 10:28:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP;
 Fri, 5 Oct 2018 10:28:12 -0700 (PDT)
In-Reply-To: <CALCETrVxv1fHt6WE4ZpvVEwtfsKQ19gRrhhA40zwCXGMk+DTLQ@mail.gmail.com>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005133705.GA4588@zx2c4.com>
 <CAKv+Gu-f4uKBF=gtFcNJEeoC2L4qShX0+3p7kVhjTn0tR+3Gng@mail.gmail.com>
 <CALCETrVxv1fHt6WE4ZpvVEwtfsKQ19gRrhhA40zwCXGMk+DTLQ@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 5 Oct 2018 19:28:12 +0200
Message-ID: <CAKv+Gu_fFvoXmWscnx=dF7ovc2qXJgBnDte3Z8Co9Y4TzDfwbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] patchable function pointers for pluggable crypto
 routines
To: Andy Lutomirski <luto@kernel.org>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5 October 2018 at 19:26, Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Oct 5, 2018 at 10:15 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> On 5 October 2018 at 15:37, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> ...
>> > Therefore, I think this patch goes in exactly the wrong direction. I
>> > mean, if you want to introduce dynamic patching as a means for making
>> > the crypto API's dynamic dispatch stuff not as slow in a post-spectre
>> > world, sure, go for it; that may very well be a good idea. But
>> > presenting it as an alternative to Zinc very widely misses the point and
>> > serves to prolong a series of bad design choices, which are now able to
>> > be rectified by putting energy into Zinc instead.
>> >
>>
>> This series has nothing to do with dynamic dispatch: the call sites
>> call crypto functions using ordinary function calls (although my
>> example uses CRC-T10DIF), and these calls are redirected via what is
>> essentially a PLT entry, so that we can supsersede those routines at
>> runtime.
>
> If you really want to do it PLT-style, then just do:
>
> extern void whatever_func(args);
>
> Call it like:
> whatever_func(args here);
>
> And rig up something to emit asm like:
>
> GLOBAL(whatever_func)
>   jmpq default_whatever_func
> ENDPROC(whatever_func)
>
> Architectures without support can instead do:
>
> void whatever_func(args)
> {
>   READ_ONCE(patchable_function_struct_for_whatever_func->ptr)(args);
> }
>
> and patch the asm function for basic support.  It will be slower than
> necessary, but maybe the relocation trick could be used on top of this
> to redirect the call to whatever_func directly to the target for
> architectures that want to squeeze out the last bit of performance.
> This might actually be the best of all worlds: easy implementation on
> all architectures, no inline asm, and the totally non-magical version
> works with okay performance.
>
> (Is this what your code is doing?  I admit I didn't follow all the way
> through all the macros.)

Basically
