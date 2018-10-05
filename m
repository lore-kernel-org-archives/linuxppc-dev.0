Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD06C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 23:51:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408BE208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 23:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MEtcOJ+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408BE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RmkD1XBfzF3d4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 09:51:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.b="MEtcOJ+0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zx2c4.com
 (client-ip=192.95.5.64; helo=frisell.zx2c4.com; envelope-from=jason@zx2c4.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.b="MEtcOJ+0"; 
 dkim-atps=neutral
Received: from frisell.zx2c4.com (frisell.zx2c4.com [192.95.5.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RcRL3LdrzF3bS
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 03:38:03 +1000 (AEST)
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id e6c57699
 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 5 Oct 2018 17:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
 :references:in-reply-to:from:date:message-id:subject:to:cc
 :content-type; s=mail; bh=sJM2xZ5pstyh+eUmNRLpvJyjYjk=; b=MEtcOJ
 +0akxYb38ucSad3OxdYK8aKz/osuRGSRcTbsdyFMAyZhuKHXKld14WILaamJd/rr
 99Li7I2i/dig7eQcJocYqXlk+PVfL2NflnHLJBZSQ1MbbypClObn1kYBwy8v08hq
 jLjdLsdyKIwtD/uwEALk/qg70jQkvgFIgRktR3NN5yd699FUqz1drdpWZOW/GTlQ
 5y6xbWRgoTuzdiJTMczKJOOo/zXVvtdIxLiPDQND6ADzKZNIvH+t7RiRX0EdXq2Q
 Japg+dKrBmxvEWH7GtYMGOdyoGOKIIKprGH69eYTIC2qKn8YJIJlgi/Nm1oI4oAT
 ucXk0Jesl8uHAGoA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id edd08c18
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 5 Oct 2018 17:37:31 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id j68-v6so11051138oib.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 10:37:58 -0700 (PDT)
X-Gm-Message-State: ABuFfogcvFhiKhCyrDwnqHREqcmH0nwJ+P/wDJVLUj2DWFqc92ymCl4i
 75MzgIeKDEOWgmc3Rh64v6JSKrslTIuHtfvzHh8=
X-Google-Smtp-Source: ACcGV63HrUPCNwTe+qa0U1mdJpTIXnbp4ml2S10xIOuzmw4JB7vaQwjHA4F7/vnqW1OYrmJdRzUubOypSXCKqRbbr0A=
X-Received: by 2002:aca:b04:: with SMTP id 4-v6mr3891323oil.192.1538761076036; 
 Fri, 05 Oct 2018 10:37:56 -0700 (PDT)
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
In-Reply-To: <CALCETrVMBULVP9qEQDVuisxAMzdheM1qQ97AZFs-xcO0eaXiiA@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 5 Oct 2018 19:37:44 +0200
X-Gmail-Original-Message-ID: <CAHmME9pgJ_2GGDUVsbQXcNRfh3yACqFG+5uemFRMZkb8LdH95g@mail.gmail.com>
Message-ID: <CAHmME9pgJ_2GGDUVsbQXcNRfh3yACqFG+5uemFRMZkb8LdH95g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
To: Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
 Samuel Neves <sneves@dei.uc.pt>, paulus@samba.org,
 Herbert Xu <herbert@gondor.apana.org.au>, richard@nod.at,
 Eric Biggers <ebiggers@kernel.org>, mingo@redhat.com,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 5, 2018 at 7:29 PM Andy Lutomirski <luto@kernel.org> wrote:
> (None of this is to say that I disagree with Jason, though -- I'm not
> entirely convinced that this makes sense for Zinc.  But maybe it can
> be done in a way that makes everyone happy.)

Zinc indeed will continue to push in the simpler and more minimal
direction. Down the line I'm open to trying and benching a few
different ways of going about it with dynamic patching -- something
that will be pretty easy to experiment with given the lean structure
of Zinc -- but for the initial merge I intend to do it the way it is,
which is super fast and pretty straightforward to follow.

Jason
