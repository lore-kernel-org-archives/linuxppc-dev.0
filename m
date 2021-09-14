Return-Path: <SRS0=BtxG=OE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17203C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Sep 2021 01:38:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA88360F6F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Sep 2021 01:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA88360F6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7mG92KJkz3000
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Sep 2021 11:38:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=LWKknnDl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::135;
 helo=mail-lf1-x135.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=google header.b=LWKknnDl; 
 dkim-atps=neutral
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7mFP2xqgz2yHN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Sep 2021 11:38:00 +1000 (AEST)
Received: by mail-lf1-x135.google.com with SMTP id x27so25105258lfu.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Sep 2021 18:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vaxVMoYr01ooBsRLl+9NrQ8wh4tzlePArs6uZi+Ocvk=;
 b=LWKknnDlMezAs3gUXR3kh/QfVsbTeK+nWV3l/0fmyZ2xNtUAX8M6drYh43BUMBEtMD
 GDa6WkmcV7mH8tsO4kjdyzm6FXGRqNGpF5OqxXxX39QZusB8c+baEHhdSa1tzasPozfR
 H0g67r5PAKacEgCwf/LDT7505JFTZAmmkEQjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vaxVMoYr01ooBsRLl+9NrQ8wh4tzlePArs6uZi+Ocvk=;
 b=W5D0xXAe3uhRfT49K+oB6G7+b4oTXcq6ph2sf8F+HThPln9oeBnzL6bKqbEoZYxGZQ
 LUwQphKdfezvCObHyQZKQePdWxqRF9TULIOflqVtQG6SLhM7vg127SqRqMQH+n2Tv02S
 UWS2sVaz/Dn1szYP1UJz+8NpF+7mgpDDswzUpble5HI+o/SZkCJ31nSV/2VLpvB+Z/6X
 iuQaAVnzu+2wORKC1mM/D7/q4B+HpEESR7PlXyNE5J8aalJCMyFu74ird8ebwTpndbXl
 Rdt+P9kT4Vm8DLwnMGLG24qUBJkEyx4XLW9NvPAuY8OTFxfVGSkIL0zWcJI/d0lrkfqU
 U03A==
X-Gm-Message-State: AOAM532hVXwLQihhuvL76pg0D6CF5oD2sAG0/BsBeirxQ0vy3nbunTGy
 i2Wj4tJ+dGxooJ919p/mZjQq+OG7AfzP60f2XLk=
X-Google-Smtp-Source: ABdhPJy+9O0GSYTLQK3KVsfWseaLHM22oaUKLvI58tMJEW/0hWqp9E8pNZFQTySc4W1aFEEUCmLAWQ==
X-Received: by 2002:a19:8c4c:: with SMTP id i12mr11174220lfj.445.1631583475870; 
 Mon, 13 Sep 2021 18:37:55 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45])
 by smtp.gmail.com with ESMTPSA id h13sm398377lfl.205.2021.09.13.18.37.55
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 18:37:55 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id g1so13637661lfj.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Sep 2021 18:37:55 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id
 m12mr11493578lfg.150.1631583475033; 
 Mon, 13 Sep 2021 18:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210914100853.3f502bc9@canb.auug.org.au>
 <CAHk-=whOv-LZKxBqQr8yzmhi7sN4zoFG7t8ALNx+2XFhXjGTpA@mail.gmail.com>
 <CAHk-=whGuEkYmQcJx8WfZ7MFhbKGJDcA6NUZWtrnM6Y6xFqATw@mail.gmail.com>
 <20210914105359.5c651d55@canb.auug.org.au>
 <CAHk-=whyWUdJDeOBN1hRWYSkQkvzYiQ5RbSW5rJjExgnbSNX9Q@mail.gmail.com>
In-Reply-To: <CAHk-=whyWUdJDeOBN1hRWYSkQkvzYiQ5RbSW5rJjExgnbSNX9Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 Sep 2021 18:37:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4-=NbwH7-bZQayZa4waw=G8r6inxzBK9NFRQsvUceCg@mail.gmail.com>
Message-ID: <CAHk-=wj4-=NbwH7-bZQayZa4waw=G8r6inxzBK9NFRQsvUceCg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the origin tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Sep 13, 2021 at 6:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, do I know *why* that ppc Makefile it does that? No.

Well, that is simple enough to find out..

        git show 77433830ed164

just tells us.

Of course, that also points to scripts/Makefile.lib, which doesn't
have this problem, because it keeps c_flags and a_flags nicely
separated.

Anyway, that just makes me think that something like that patch in my
previous email is the way to go, but I would like to stress (again)
how little testing it had: exactly none.

So please consider that nothing more than a hand-wavy "something like this".

              Linus
