Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2ACC282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 17:29:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F748222DE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 17:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O6Q5+GrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F748222DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44m2yY5np0zDqW7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 03:29:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="O6Q5+GrA"; dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44m2wt1dylzDqVQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 03:27:40 +1000 (AEST)
Received: by mail-lf1-x143.google.com with SMTP id w23so4479554lfc.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 10:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j4Pa6AaD11YFWbmWnx+oyTpQprnUAPqORvuUTpM5Xuw=;
 b=O6Q5+GrAK7AxKAU6R3bcr5tL2B2L81VIjsIgmsOOhsZVD8iJ86wAGcqox7QC0zGGm1
 W9L53HaLy/EVleG8CNrqtDGYiTHd8nr/LevmYFsuM9BgGpzLymCavDN+bBC9M/z6DcVF
 g3axT4iMKotCNYPdxBtlwANC2CxFrlsBybWog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j4Pa6AaD11YFWbmWnx+oyTpQprnUAPqORvuUTpM5Xuw=;
 b=bopcYDk40Qz4JjfUFEAeaMWTvIC3sICjon9D8ci4ql49BefXL9gzl3l/wiwi4YxiAD
 1Z99I6aRP9GDmY5jxLNH7dg1q9cmLPI3WTB0fYlz4Y1L9+PCcabeMaA6qJkGcySNAk5N
 Db8fqVZ6tcMuaS0AiruyIfdSR04NOnQKHl6QiwG+jNWXCkjnqRJg6EpWetGZIvI7qb2W
 +/X9TuGoiiBiHTEVLhcJQeIhFbW9PhZ8pj5LiOYYClWjaCT03ME8hjVUA2b5qi2SwqEL
 dFVl1utRplh1E/DaMZJnTlShOIKmKVnFfWVcFnfHE3J90eZgdY9u7bPS+UL57Im4jeSb
 sTYg==
X-Gm-Message-State: APjAAAU/EGpN29bOpP3RaeSaaF02KopsfRf7k3JzjGdeKeo7IusCRHFA
 XLgGFK6UQx0943AnEZUwIvchSkycqfM=
X-Google-Smtp-Source: APXvYqz5xHne5paUk0kIUQntW6md49cbqgmBQRE4AwDXkre2hC6AqSfR1k6uY6Mh15HVCHWZlFEfCg==
X-Received: by 2002:a19:f705:: with SMTP id z5mr2862351lfe.93.1555694855926;
 Fri, 19 Apr 2019 10:27:35 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176])
 by smtp.gmail.com with ESMTPSA id y20sm1269767lfe.8.2019.04.19.10.27.34
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Apr 2019 10:27:34 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q66so5202251ljq.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 10:27:34 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr2872561lja.125.1555694853846; 
 Fri, 19 Apr 2019 10:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
 <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
 <20190417094637.51ad4c67@mschwideX1> <20190417100244.42e29736@mschwideX1>
 <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
 <20190418100218.0a4afd51@mschwideX1>
 <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
 <20190418204144.16adf2a0@mschwideX1> <20190419153307.4f2911b5@mschwideX1>
In-Reply-To: <20190419153307.4f2911b5@mschwideX1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Apr 2019 10:27:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6yp7hkJ_wR38dhdDRkAHQaEx28v2FkVT9hDFXX_qfjA@mail.gmail.com>
Message-ID: <CAHk-=wj6yp7hkJ_wR38dhdDRkAHQaEx28v2FkVT9hDFXX_qfjA@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
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
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 19, 2019 at 6:33 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> That problem got stuck in my head and I thought more about it. Why not
> emulate the static folding sequence in the s390 page table code?

So this model seems much closer to what x86 does in its folding, where
the pattern is basically

> static inline pX-1d_t *pXd_offset(pXd_t *pXd, unsigned long address)
> {
>         if (pXd_folded(pXd)
>                 return (pX-1d_t *) pXd;
>         return (pX-1d_t *) pXd_deref(*pXd) + pXd_index(address);
> }

which is really how the code is designed to work (ie the folded entry
doesn't actually do anything to the page directory pointer, it just
says "ok, we'll use this exact page directory pointer for the next
lower level instead".

And that's very much what allows the generic gup code to load the
entry once, and use a temporary, and as you walk down the chain, if it
is folded it just then uses that (previous) temporary value for the
next level instead. IOW, the lower level page table is hidden inside
the upper level one, and folding just means "don't do any offsets,
don't change any values, just use the entry as-is for the next lower
level".

So I think that's the right thing to do.

Looking at the s390 code, it seems to fold things the other way,
conceptually hiding the upper level inside the lower one, and always
doing the offset thing (but just avoiding the dereference).

Maybe there's some reason why the s390 code does it that way, but I
think your new model is the right one, and hopefully means you can use
the generic page table walking more easily.

Of course, the s390 folding is very different from the x86 one (or the
generic fixed 3-level of 4-level cases). The x86 folding doesn't
depend on the contents of the page tables, it's just entirely static
(well, the 5th level is conditional, but it's conditional on a static
key, not on what is in the page tables). So maybe the old model of
s390 made more sense in that context, but I look at your new suggested
pXd_offset() functions and I go "yeah, that's the way it's supposed to
work".

                 Linus
