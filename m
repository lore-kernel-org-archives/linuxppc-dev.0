Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B442FC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:41:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34997208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHUZE5EA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34997208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rdqw1bC9zF3cs
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:41:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EHUZE5EA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="EHUZE5EA"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RcZc2BH6zF3fs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 03:44:24 +1000 (AEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3F77A2084D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538761462;
 bh=O9q3VnBXuU3U2B2KsI93KQt4N0OimsBG8KXQ5BMVg/M=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EHUZE5EAhxhg6aYkcND3sEY/xUYu5ULthevOKz9aDhYWP/G7mcBBws2+j2L0YyUFR
 53tJb9LMqxn87Ucly/JTTZTC0FrqxX+Wt9tQagGSBHS6OM/cQ7NvK0ImoFxRk7ZFnE
 ChXD512Hg12bYdpmQiq3td9P7L76hHJ7dy7p2C5o=
Received: by mail-wm1-f45.google.com with SMTP id a8-v6so2658227wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 10:44:22 -0700 (PDT)
X-Gm-Message-State: ABuFfogDRlAlr7DJsmCjJNyEEuU1o2VrdKT6p2Pw191BKn0aoQhKUujB
 t0nszlvC8YNKGegqxDC+95cwhni6LdIZ4ac31lvMHQ==
X-Google-Smtp-Source: ACcGV63ADM++7G3vmAGudX89A7S4EWFuJ4tukYwkNJ51Np7eV0VnQQINbMsaeej8UbH5GNKpzZqsd1W6fMHPsHKRwUE=
X-Received: by 2002:a1c:9355:: with SMTP id
 v82-v6mr8430319wmd.128.1538761458721; 
 Fri, 05 Oct 2018 10:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
 <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
 <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
 <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
 <CAKv+Gu-oHBtgGbWXJu6+z4+BNhBZyY5VvF_v6cJJUGk_5YX1eQ@mail.gmail.com>
 <CALCETrU=fm+ZG4WZJfG-5GwL7kv5_GS1aZYu=L42d5BuSbhJDQ@mail.gmail.com>
 <CAKv+Gu8eHPEsUbkhN=61z9FvhdCo2e3VOdemp4g0bzdO1EJFYQ@mail.gmail.com>
 <CALCETrVMBULVP9qEQDVuisxAMzdheM1qQ97AZFs-xcO0eaXiiA@mail.gmail.com>
 <CAHmME9pgJ_2GGDUVsbQXcNRfh3yACqFG+5uemFRMZkb8LdH95g@mail.gmail.com>
In-Reply-To: <CAHmME9pgJ_2GGDUVsbQXcNRfh3yACqFG+5uemFRMZkb8LdH95g@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 5 Oct 2018 10:44:07 -0700
X-Gmail-Original-Message-ID: <CALCETrWjCY2Wceiqu99C+g5RdnrZuRujYO_+jBvuJFRB1LTG4w@mail.gmail.com>
Message-ID: <CALCETrWjCY2Wceiqu99C+g5RdnrZuRujYO_+jBvuJFRB1LTG4w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 5, 2018 at 10:38 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Fri, Oct 5, 2018 at 7:29 PM Andy Lutomirski <luto@kernel.org> wrote:
> > (None of this is to say that I disagree with Jason, though -- I'm not
> > entirely convinced that this makes sense for Zinc.  But maybe it can
> > be done in a way that makes everyone happy.)
>
> Zinc indeed will continue to push in the simpler and more minimal
> direction. Down the line I'm open to trying and benching a few
> different ways of going about it with dynamic patching -- something
> that will be pretty easy to experiment with given the lean structure
> of Zinc -- but for the initial merge I intend to do it the way it is,
> which is super fast and pretty straightforward to follow.
>

I *think* the only change to Zinc per se would be that the calls like
chacha20_simd() would be static calls or patchable functions or
whatever we want to call them.  And there could be a debugfs to
override the default selection.

Ard, I don't think that sticking this in udev rules makes sense.  The
kernel has bascially complete information as to what the right choice
is, and that will change over time as the implementation gets tuned,
and the udev rules will never get updated in sync.
