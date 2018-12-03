Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9071FC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:04:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0520820850
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="IjkAZUF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0520820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4380tX6P71zDqVb
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 10:04:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="IjkAZUF5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="IjkAZUF5"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4380hl5nY7zDqP8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 09:55:51 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id b5so7228072plr.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 14:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=obRrg9rAKQUkvbX4DNcGu49eavX10jLobDBdHEgdouo=;
 b=IjkAZUF5Z3+b+H0hRs2KJJiEkImw364FYfRX1RfNTe4LO+brr9aAkGnKSAB3fO/XKd
 0YzhcKz5LyYfgQ22bnqhLejw+mPTlnHX8SJRxWpgu9ms6dRHb7GWinhlYxGMGMg43dlh
 8NnWVZOv7NTmvoJ92HalXpkzsaI2W1B3UKyOenYOAPFFo8KiRsYCPv6v3NnNRZK/7OVo
 mllQO8kH3aoRk80njWH9ON/9uHWRLXY9+hdu/M/DJWs/FLtqPiVUPzCROQkKTMAOMwqp
 322+2y/LFgHKcTcWTyAy92O1nA6lobkJOWksfnPU3qDnQJOydiA969KDovyfdCQUHvH3
 aPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=obRrg9rAKQUkvbX4DNcGu49eavX10jLobDBdHEgdouo=;
 b=CzoMTSLJWMU595hhaBdwyz8iKX4EKx23OrfuSD/l2/7VVywF/PCxwzIuv+3SApJGBp
 GCggHy8o12Sm1W35QASO+yzILgAt6E105VV2ueJbdASRTPua8eLiW5yRmuxvFtLD5/nd
 MZXvd75xnTuTi3sKzvo1+oN/zh/u6vJx49vPU5tyD8fEI9kMBMypAS6llFD74lxuXaO9
 w6HFwVQ3LUiHXhTZrvDfQSyZunS0ZgcJ3fQsYouuQgO2C8R96C27lXCrPJgYqxJc7ACI
 911rOgd6v2cuLA4T31SSejBTHgwHrORfgwXavYXeiE6qD944J+9aKKBkD/wz61iByrHY
 FeKA==
X-Gm-Message-State: AA+aEWaiQmsA31jioX1hUg85byzk5wCr/eMLmGnwjyjg66OgHU9NSlRP
 Ny433pyMoG3acgIfkhkF2Gs9sPtmdLbIQ7sloZ1bQg==
X-Google-Smtp-Source: AFSGD/W3qXwXJMsvkEYh7rj1gNeRHfyqwNLOcril4ge7vSKBbH8Kf2u9OvSQJLFmlnCrzy7qqMAqMfdCVJCigbpJWTc=
X-Received: by 2002:a17:902:820d:: with SMTP id
 x13mr18272982pln.229.1543877748297; 
 Mon, 03 Dec 2018 14:55:48 -0800 (PST)
MIME-Version: 1.0
References: <20181102004455.10157-1-joel@jms.id.au>
 <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
 <CACPK8XdbWzb=52iFV_fj0Y5KMWPgsRv_A8PZgfKn9vm96y3LOw@mail.gmail.com>
 <CAKwvOdndyeRZApOqbp-6evEpYgzHyGo4qqaMKd_DQ4U9x8_5wA@mail.gmail.com>
 <CACPK8Xcz4YzfnFAHGOcJZkt0UFfQ02YabtEQDHXdSFsH57xRiQ@mail.gmail.com>
In-Reply-To: <CACPK8Xcz4YzfnFAHGOcJZkt0UFfQ02YabtEQDHXdSFsH57xRiQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 3 Dec 2018 14:55:37 -0800
Message-ID: <CAKwvOdm953JFNaR6wMtDJDiwkaqXM83s2Qr=RFJ5OZAzeNQwEA@mail.gmail.com>
Subject: Re: [PATCH v2] raid6/ppc: Fix build for clang
To: joel@jms.id.au
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 jji@us.ibm.com, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 3, 2018 at 2:14 PM Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 4 Dec 2018 at 05:15, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > > +ifdef CONFIG_CC_IS_CLANG
> > > > > +# clang ppc port does not yet support -maltivec when -msoft-float is
> > > > > +# enabled. A future release of clang will resolve this
> > > > > +# https://bugs.llvm.org/show_bug.cgi?id=31177
> > > > > +CFLAGS_REMOVE_altivec1.o  += -msoft-float
> > > > > +CFLAGS_REMOVE_altivec2.o  += -msoft-float
> > > > > +CFLAGS_REMOVE_altivec4.o  += -msoft-float
> > > > > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > > > > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > > > > +CFLAGS_REMOVE_vpermxor1.o += -msoft-float
> > > > > +CFLAGS_REMOVE_vpermxor2.o += -msoft-float
> > > > > +CFLAGS_REMOVE_vpermxor4.o += -msoft-float
> > > > > +CFLAGS_REMOVE_vpermxor8.o += -msoft-float
> > > > > +endif
> > > >
> > > > Hi Joel, thanks for this patch!  My same thoughts about
> > > > CONFIG_CC_IS_CLANG vs cc-option from
> > > > https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/180939.html
> > > > apply here as well.  I don't feel strongly about either though.  What
> > > > are your thoughts?
> > >
> > > I'm not sure that we can test for this one with cc-option. The result
> > > of having -maltivec with -msoft-float is a error about the internals
> > > of clang, which isn't something that kbuild is set up to test for.
> >
> > As in clang itself crashes, and cc-option/kbuild can't handle that gracefully?
>
> The developer gets something like this:
>
> SplitVectorResult #0: t196: v16i8 = llvm.ppc.altivec.vcmpgtsb
> TargetConstant:i64<4823>, t146, t195
> fatal error: error in backend: Do not know how to split the result of
> this operator!
> clang-8: error: clang frontend command failed with exit code 70 (use
> -v to see invocation)
>
> >
> > >
> > > When clang is fixed to allow this combination we will still build this
> > > code in the same way, so in that sense it fails "open".
> > >

Eek, that means cc-option is not hardened against flags that crash the
compiler (misbehaving compiler).  We'll have to get some version check
in place should we ever want to use those flags for these object
files, but for now:

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
