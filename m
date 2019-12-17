Return-Path: <SRS0=7pZz=2H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68795C43603
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 18:21:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D13206D7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 18:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RfiBPyWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D13206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47cmgF2r9KzDqGm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 05:21:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::141;
 helo=mail-lf1-x141.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="RfiBPyWe"; dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47cmKh4vLfzDqNF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2019 05:06:16 +1100 (AEDT)
Received: by mail-lf1-x141.google.com with SMTP id v201so7596580lfa.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2019 10:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2FmdBG00eyF0mCLPHUhnZPiYsr9gMuTHxWDo5KEuXIA=;
 b=RfiBPyWeZAzQgIBtq60kIzhloZUPXwDzUfA7/StNCE0CG0dtDUhp2Ewy/xVxfm6KGP
 Df5Tk+VbkeJUcH9BCjIfG5UOSKgGvWdi5Az1/Qo1yD1OhxmYNXkDchH0t3cs5GTsnGGc
 mY0wPUPFyCbvMDhlKo0Sh/qqCC9ol32klGEME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2FmdBG00eyF0mCLPHUhnZPiYsr9gMuTHxWDo5KEuXIA=;
 b=nDbF9+7c3xX+FajzZPOEIGp7wSma5qe0x4NYmGiK4g+Epw2yMAWdVfgLSgJygWQn6Z
 TrlYGs5smFE/zX6h/YlHEvtozyaMOgsiggEJ4QtecahEz+1lipvypYdVdqW/RQwkna9S
 5sXvggo4XS41DpDLmqJoWmVNEopXweRtEY2KaBizOCrb+hnwh7lTCnzl/DbL7PqNQeCb
 EweHgaEY0kMOLXiitpeYzWoX0KBKSbkYDGqth5PJAMZ/pWvLn3+XQMO8nJtoAmJa68Rw
 uIRvwDuKcp5JMy8yc3MFuuvIl0HIn7TPr9J3kmaR+RG8y0KY9zFXTYh/pautuI4rMQaR
 onNg==
X-Gm-Message-State: APjAAAXpNw3Dgul58+qWtgZUR67eTNhQBj2u31+JHypdCfAlcQpwWmss
 ORuY5m8LW7aIY4tixQ8qBjmYw6sb9j0=
X-Google-Smtp-Source: APXvYqxSdjYdeFrQ6lyyrJpnXW31yc8JMZr3ipCV9/84RRn6KBS0Lc3pGWNkGyA+sELFfAb2nTAyYw==
X-Received: by 2002:a19:be93:: with SMTP id o141mr3745212lff.181.1576605971807; 
 Tue, 17 Dec 2019 10:06:11 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com.
 [209.85.208.169])
 by smtp.gmail.com with ESMTPSA id f16sm1087446ljn.17.2019.12.17.10.06.10
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 10:06:11 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id u1so1129032ljk.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2019 10:06:10 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr4238381ljj.148.1576605970602; 
 Tue, 17 Dec 2019 10:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <20191217170719.GA869@willie-the-truck>
 <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
In-Reply-To: <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2019 10:05:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsbrq6sFOSd9QrjR-fCamgzqCtFuO2_8qvJANA1+Jm6g@mail.gmail.com>
Message-ID: <CAHk-=wgsbrq6sFOSd9QrjR-fCamgzqCtFuO2_8qvJANA1+Jm6g@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To: Will Deacon <will@kernel.org>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 17, 2019 at 10:04 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me think about it.

.. and in the short term, maybe for code generation, the right thing
is to just do the cast in the bitops, where we can just cast to
"unsigned long *" and remove the volatile that way.

I'm still hoping there's a trick, but..

           Linus
