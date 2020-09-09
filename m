Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEB9C433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 21:36:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0F5208CA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 21:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZC+O3RgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0F5208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BmwLT0xPKzDqGN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 07:36:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::141;
 helo=mail-lf1-x141.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=google header.b=ZC+O3RgW; 
 dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BmwJ921DjzDqYC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2020 07:33:58 +1000 (AEST)
Received: by mail-lf1-x141.google.com with SMTP id y17so2407418lfa.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2020 14:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B0+jz5nEBaWAhh7n7Hp1qz3wUrloORRxGTRRlKkQIgM=;
 b=ZC+O3RgWhIgNKsFzAoxkbel7tu0gOmF8ciyCULsTleltXACSMEUPzu0YhQCYyxG+n0
 fRQ2KEHRUpo3+MHY+wuhqjq5jU82lgflP0z62nRjLA58w/Z1YR52q8f3ta82dR9XKkQK
 4JeSuKlLlKaSmxiZJnS7lLTjpttmYgqxvU9OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B0+jz5nEBaWAhh7n7Hp1qz3wUrloORRxGTRRlKkQIgM=;
 b=pWQW35lcE7WKiqrnR4ikr8oy19SatiQpwWbVwPXMjq9j+prazPEQBsh+tQXPG92aJ5
 ficOSMaPhDGWxF84qFiAShzRaJF3BNMYuxpoOUAclI+sMukEyeBkaSlwH3GWvlDjJYON
 vpLjlv1Pw+iTFnID8Y/LV1l2SPkr99GxEJ4BSniXiKHHKyTcBAGb9wP30pn0nzjHRtc/
 3H6kR8MVDyPWB0CbmAtGJV7i/rUPutKp8J4toZluw5ivK3iJte99MV2i3bCJdwY56DO+
 qmtpm7hOvIIq/OPT4QYliIacrwFPPYLwVpzFuZy9IqiIWgsimKW9QuU4i1mm8JJAy14P
 DWaA==
X-Gm-Message-State: AOAM5336aT48cZkuOtjxYifg03sHHrsBa0sKS3QwobpWzS7op+GL9Bgf
 yprNA79FpWUIv2i1fiAYdq3AQcr5ceH6jg==
X-Google-Smtp-Source: ABdhPJzReYcWECoHCNEq0rrLKU+zJkxL4FBA9WAB6u1Pcu7yXTD4vEvJRYIbUsEHQ50OouPn9s9B8g==
X-Received: by 2002:a05:6512:214c:: with SMTP id
 s12mr2733214lfr.18.1599687233657; 
 Wed, 09 Sep 2020 14:33:53 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182])
 by smtp.gmail.com with ESMTPSA id z10sm839333lfa.10.2020.09.09.14.33.52
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 14:33:52 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id c2so5434814ljj.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2020 14:33:52 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr2679648ljh.70.1599687232145; 
 Wed, 09 Sep 2020 14:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142803.GM1236603@ZenIV.linux.org.uk>
 <CAHk-=wgQNyeHxXfckd1WtiYnoDZP1Y_kD-tJKqWSksRoDZT=Aw@mail.gmail.com>
 <20200909184001.GB28786@gate.crashing.org>
In-Reply-To: <20200909184001.GB28786@gate.crashing.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Sep 2020 14:33:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
Message-ID: <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
To: Segher Boessenkool <segher@kernel.crashing.org>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Alexey Dobriyan <adobriyan@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 9, 2020 at 11:42 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> It will not work like this in GCC, no.  The LLVM people know about that.
> I do not know why they insist on pushing this, being incompatible and
> everything.

Umm. Since they'd be the ones supporting this, *gcc* would be the
incompatible one, not clang.

Like it or not, clang is becoming a major kernel compiler. It's
already basically used for all android uses afaik.

So I'd phrase it differently. If gcc is planning on doing some
different model for asm goto with outputs, that would be the
incompatible case.

I'm not sure how gcc could do it differently. The only possible
difference I see is

 (a) not doing it at all

 (b) doing the "all goto targets have the outputs" case

and honestly, (b) is actually inferior for the error cases, even if to
a compiler person it might feel like the "RightThing(tm)" to do.
Because when an exception happens, the outputs simply won't be
initialized.

Anyway, for either of those cases, the kernel won't care either way.
We'll have to support the non-goto case for many years even if
everybody were to magically implement it today, so it's not like this
is a "you have to do it" thing.

           Linus
