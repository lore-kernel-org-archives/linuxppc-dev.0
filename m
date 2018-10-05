Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DD5C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:30:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BB42084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpyCaBkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BB42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RdbK5c7MzDqCq
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:30:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WpyCaBkm";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="WpyCaBkm"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Rc9s6LHGzF3Sb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 03:26:25 +1000 (AEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DAB092148C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538760384;
 bh=BtUlJXPxzROTLh5ruMHdsHXX1cniMwLqNEy6YBOxFLs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=WpyCaBkmY13bYCX9Dm6dlNgD3zKBzhcv59HVq1kD4kNNE2LhIPGlcgGJamww/O+Mu
 e/OcNrh8Zat9KbJXHeKrGHsLxwg6TWnrA9MDI4TlMU6vRGl8DbMpxV8wcSSwYOs4yW
 IUpIW9wWBPqj1fDQ+xA9cEMLO44CbSPEMoC1BIEY=
Received: by mail-wr1-f42.google.com with SMTP id e4-v6so14364206wrs.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 10:26:23 -0700 (PDT)
X-Gm-Message-State: ABuFfogLRtJOxhj5WiMTfGJAUV6yOATCW7E5OmWHPSgTT4Ok+1AokeM3
 uUvP8e8cxIokfRaGEB/gsx4GcyTpXYPX8U22lqbN6A==
X-Google-Smtp-Source: ACcGV63+AuOHy0b95rEYlVpCtCt0DDMWrn3Jmw20yMApLh17Axv0MfvrRS34XYxbDPUkWS2zSyBBjpgjCwN+kPowR7I=
X-Received: by 2002:adf:82e3:: with SMTP id
 90-v6mr8597642wrc.131.1538760380286; 
 Fri, 05 Oct 2018 10:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005133705.GA4588@zx2c4.com>
 <CAKv+Gu-f4uKBF=gtFcNJEeoC2L4qShX0+3p7kVhjTn0tR+3Gng@mail.gmail.com>
In-Reply-To: <CAKv+Gu-f4uKBF=gtFcNJEeoC2L4qShX0+3p7kVhjTn0tR+3Gng@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 5 Oct 2018 10:26:08 -0700
X-Gmail-Original-Message-ID: <CALCETrVxv1fHt6WE4ZpvVEwtfsKQ19gRrhhA40zwCXGMk+DTLQ@mail.gmail.com>
Message-ID: <CALCETrVxv1fHt6WE4ZpvVEwtfsKQ19gRrhhA40zwCXGMk+DTLQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] patchable function pointers for pluggable crypto
 routines
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
 Andrew Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
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

On Fri, Oct 5, 2018 at 10:15 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On 5 October 2018 at 15:37, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> ...
> > Therefore, I think this patch goes in exactly the wrong direction. I
> > mean, if you want to introduce dynamic patching as a means for making
> > the crypto API's dynamic dispatch stuff not as slow in a post-spectre
> > world, sure, go for it; that may very well be a good idea. But
> > presenting it as an alternative to Zinc very widely misses the point and
> > serves to prolong a series of bad design choices, which are now able to
> > be rectified by putting energy into Zinc instead.
> >
>
> This series has nothing to do with dynamic dispatch: the call sites
> call crypto functions using ordinary function calls (although my
> example uses CRC-T10DIF), and these calls are redirected via what is
> essentially a PLT entry, so that we can supsersede those routines at
> runtime.

If you really want to do it PLT-style, then just do:

extern void whatever_func(args);

Call it like:
whatever_func(args here);

And rig up something to emit asm like:

GLOBAL(whatever_func)
  jmpq default_whatever_func
ENDPROC(whatever_func)

Architectures without support can instead do:

void whatever_func(args)
{
  READ_ONCE(patchable_function_struct_for_whatever_func->ptr)(args);
}

and patch the asm function for basic support.  It will be slower than
necessary, but maybe the relocation trick could be used on top of this
to redirect the call to whatever_func directly to the target for
architectures that want to squeeze out the last bit of performance.
This might actually be the best of all worlds: easy implementation on
all architectures, no inline asm, and the totally non-magical version
works with okay performance.

(Is this what your code is doing?  I admit I didn't follow all the way
through all the macros.)
