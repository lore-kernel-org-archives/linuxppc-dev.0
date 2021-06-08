Return-Path: <SRS0=nRCD=LC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0EDC47082
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 17:11:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C379C6127A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 17:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C379C6127A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fzxbr5Zlcz3bvr
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 03:11:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=IywdZbGo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::22a;
 helo=mail-lj1-x22a.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=google header.b=IywdZbGo; 
 dkim-atps=neutral
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FzxbK37M5z301N
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jun 2021 03:11:07 +1000 (AEST)
Received: by mail-lj1-x22a.google.com with SMTP id e11so27949419ljn.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jun 2021 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=etyKwyH/Z6zsvIPi36f/jr7sZJSDRryKbRXIKyys1es=;
 b=IywdZbGoCLgy8Pngf2ClQ8CLffHPaiViyi6GgffnbvaGdE1YPmAaJLr0qrF3j5oxea
 DhICDT6RT6i3ONdWc1W/roz/ZwrQHoMVFo/0NAy16CfGpJUb4wN+q8T5qjWqtuaTcnqT
 SIls+fZdW5OfZbDp4dczeg3YLhea/V5jNsSCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=etyKwyH/Z6zsvIPi36f/jr7sZJSDRryKbRXIKyys1es=;
 b=solts5WEtipu0toglF4FzuoT5yMcrWiyl7mq3HElssM46q89ROj2qoIZvnzSGm2RcG
 c6fCzCdjCI8p4aYSiLUtC/oNUT+JYD66DJtH5HXBbDgEErESrfVuchTv8hzwCzUXHzRA
 0x2qhQ8d2jImtyExiA0aZAVdewHqZc4bJOExgLRrfAj3qS9sZBGo75U1n9SUgtRxoZRP
 cTUPvQpVJOTd7/j+Cm+0gKIw/JnlCvXfHAIDxhghwqfm7aPy+ZhmihUcXaudX6n+uJC6
 LBzwmnCwQpO/1diVySRS0IrBICBlxjIeMvJHUI4pYRkxcBuZUDTQLibW0b6eOb52pRlj
 ETtw==
X-Gm-Message-State: AOAM533W7d38Uz8rlkYXQmxNEvUWFX5OzQK9+07Fj2SDVDGmCUp49eif
 N8HmZ/7lu8VMaJEJTmgflYoO0b9mxvXsy0AtTtQ=
X-Google-Smtp-Source: ABdhPJzWP9qnbMpP5OCqHjK+j/tW9qPal/sy3ERWeRZD8ROemqyrS/v6s3YWwI2LUJa/qZfQ81ppkA==
X-Received: by 2002:a2e:96c9:: with SMTP id d9mr2344708ljj.0.1623172258149;
 Tue, 08 Jun 2021 10:10:58 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com.
 [209.85.167.54])
 by smtp.gmail.com with ESMTPSA id x1sm30058lfa.21.2021.06.08.10.10.57
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 10:10:57 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id f11so33109368lfq.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jun 2021 10:10:57 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id
 x2mr15509421lfa.421.1623172256802; 
 Tue, 08 Jun 2021 10:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210607055131.156184-1-aneesh.kumar@linux.ibm.com>
 <CAPa8GCAmgUyqqAcuLC7KxDvDepkqhhvVcwgSGJh92PT+LoMQcw@mail.gmail.com>
In-Reply-To: <CAPa8GCAmgUyqqAcuLC7KxDvDepkqhhvVcwgSGJh92PT+LoMQcw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Jun 2021 10:10:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipa02d8tN-fCYJ=iH915yHtFr6wEDBcOeFtawVVF4niQ@mail.gmail.com>
Message-ID: <CAHk-=wipa02d8tN-fCYJ=iH915yHtFr6wEDBcOeFtawVVF4niQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] Speedup mremap on ppc64
To: Nick Piggin <npiggin@gmail.com>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "kaleshsingh@google.com" <kaleshsingh@google.com>,
 "joel@joelfernandes.org" <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 7, 2021 at 3:10 AM Nick Piggin <npiggin@gmail.com> wrote:
>
> I'd really rather not do this, I'm not sure if micro benchmark captures everything.

I don't much care what powerpc code does _itnernally_ for this
architecture-specific mis-design issue, but I really don't want to see
more complex generic interfaces unless you have better hard numbers
for them.

So far the numbers are: "no observable difference".

It would have to be not just observable, but actually meaningful for
me to go "ok, we'll add this crazy flag that nobody else cares about".

And honestly, from everything I've seen on page table walker caches:
they are great, but once you start remapping big ranges and
invallidating megabytes of TLB's, the walker caches just aren't going
to be your issue.

But: numbers talk.  I'd take the sane generic interfaces as a first
cut. If somebody then has really compelling numbers, we can _then_
look at that "optimize for odd page table walker cache situation"
case.

And in the meantime, maybe you can talk to the hardware people and
tell them that you want the "flush range" capability to work right,
and that if the walker cache is <i>so</i> important they shouldn't
have made it a all-or-nothing flush.

            Linus
