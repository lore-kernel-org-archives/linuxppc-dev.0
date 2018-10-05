Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243F9C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 23:44:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D6E208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 23:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BYXn4QrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D6E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RmZB15sGzF3G2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 09:44:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.b="BYXn4QrA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zx2c4.com
 (client-ip=192.95.5.64; helo=frisell.zx2c4.com; envelope-from=jason@zx2c4.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.b="BYXn4QrA"; 
 dkim-atps=neutral
X-Greylist: delayed 389 seconds by postgrey-1.36 at bilbo;
 Fri, 05 Oct 2018 23:43:56 AEST
Received: from frisell.zx2c4.com (frisell.zx2c4.com [192.95.5.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RWF85bHkzDr43
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 23:43:55 +1000 (AEST)
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d2f8a01b;
 Fri, 5 Oct 2018 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
 :cc:subject:message-id:references:mime-version:content-type
 :in-reply-to; s=mail; bh=0Kq5AE3q2nUGsIwGUcZBMZ664cM=; b=BYXn4Qr
 Ab754itrzm2wYeUg9qCn9cZjunZdHOgUUZnT0iGSYsB2aWqJ+hc1Arr/CMcKUxpw
 Qn11N/vGsJyZAAa7d952BE5JztA4SFpZdUNGD5X1/4vs30IP9/upKJpgQ41htlkC
 4qUQKXDtNxH8QvSLldw3k0gMuXhuCKmH1QkKJNoUuu8DZivWlB98R4AyTniwnRB2
 SOLJ/9WeMO+q0BMFLz96zfwEhM9Ff3ZwEGFhQkuMz352he7J588yuBUgJ/U29iU5
 RRWdnpcL829/SPjhN5kOvoVHpZ57BLtALwUWolNRrQ3r6ijiifQya5NDIaycu1BZ
 QXVSpsZ9Fahjncg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 25245c3f
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO); 
 Fri, 5 Oct 2018 13:36:46 +0000 (UTC)
Date: Fri, 5 Oct 2018 15:37:06 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH 0/9] patchable function pointers for pluggable crypto
 routines
Message-ID: <20181005133705.GA4588@zx2c4.com>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
X-Mailman-Approved-At: Sat, 06 Oct 2018 09:42:00 +1000
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Ard,

On Fri, Oct 5, 2018 at 10:13 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> At the moment, the Zinc library [1] is being proposed as a solution for that,
> and while it does address the usability problems, it does a lot more than
> that, and what we end up with is a lot less flexible than what we have now.
>
> Currently, arch specific implementations (based on SIMD or optimized
> assembler) live in arch/*/crypto, where each sub-community is in charge
> of its own specialized versions of the various primitives (although still
> under the purview of the crypto maintainer). Any proposal to change this
> model should be judged on its own merit, and not blindly accepted as the
> fallout of cleaning up some library code.
>
> Also, Zinc removes the possibility to plug different versions of a routine,
> and instead, keeps all versions in the same module. Currently, the kernel's
> module support permits user land to take charge of the policies that decide
> which version to use in which context (by loading or blacklisting modules).

I think this explanation misunderstands many of the design goals of Zinc and
also points to why going your direction instead is a bad idea that will cause
even more problems down the road.

Zinc does several important things:

- Introduces direct C function calls throughout, as a central way of being
  implemented and as a central way of being used by consumers of the
  API. This has various obvious benefits for the consumers of the API,
  but it also has big benefits for the developers of the library as
  well. Namely, it keeps the relationship between different parts
  extremely clear and direct. It's an explicit choice for simplicity.
  And by being the simpler and more direct solution, it also gives gcc
  an important opportunity to optimize and inline.

- Reorganizes crypto routines so that they're grouped together by
  primitive. This again leads to a much simpler design and layout,
  making it more obvious what's happening, and making things generally
  cleaner. It is not only useful and clearer for developers, but it
  also makes contributors and auditors more easily aware of what
  implementations are available.

- Has higher standards for code and implementations that are introduced.
  Zinc prefers code that has been formally verified, that has been in
  widespread usage and has received many eyeballs and fuzzing hours,
  that has been fuzzed extensively, that is simple in design, that comes
  from well-known high-quality authors -- in roughly but not precisely
  that order of preference. That's a bit different from the current
  practices of the existing crypto API.

- Has a simpler mechanism that is just as effective for choosing
  available implementations. This is, again, more obvious and direct
  than the present crypto API's module approach, leads to smaller code
  size, and has the potential of being just as flexible with the
  inevitable desire for nobs, adjustable from userspace, from
  kernelspace, or from elsewhere.

- Is designed to promote collaboration with the larger cryptography
  community and with academia, which will yield better implementations
  and for assurance.

- Can easily be extracted to userspace libraries (perhaps a future
  libzinc could be easily based on it), which makes testing and fuzzing
  using tools like libfuzzer and afl more accessible.

- Has faster implementations than the current crypto API.

- Has, again, a very strong focus on being simple and minimal, as
  opposed to bloated and complicated, so that it's actually possible to
  understand and audit the library.

Therefore, I think this patch goes in exactly the wrong direction. I
mean, if you want to introduce dynamic patching as a means for making
the crypto API's dynamic dispatch stuff not as slow in a post-spectre
world, sure, go for it; that may very well be a good idea. But
presenting it as an alternative to Zinc very widely misses the point and
serves to prolong a series of bad design choices, which are now able to
be rectified by putting energy into Zinc instead.

Jason
