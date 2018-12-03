Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DB4C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 18:47:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CECE42146D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 18:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MpvNoSUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECE42146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437vBV52W9zDqWp
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 05:47:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="MpvNoSUA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="MpvNoSUA"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437v7b1TcmzDqWS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 05:45:14 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id 101so6909608pld.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 10:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vz4RpNkAFts865UAXW8DwCyoEd+dqjleopIGrH/AuTc=;
 b=MpvNoSUAkZNzT9UDKsFED7+PSWmlGIKGTyin/3c6lY09+HFuDaQiWQZlGcbjXfjrKM
 d3tveLhB+nGuR45U8IoYFsgJfykUgiwxWmXc5D1UzwwviIw1QKD4HPyWI8aJZnP7pin9
 QN6Gwoim2yL0kCFeAO71NeL4r5SSUkypfyUyYf5+ZTuzCNnBUOj1RhgGYnpGU8w30r6P
 FVFtLNtynLG253MLslHNvI9r1gHvQnX1h3dTzE8VlS8wtjmYhHhi0IK31sVW1H2AmMmo
 uhUO5gJW9c4XLYzMi8xWDD7TSi9RyIbeux5xTzu8j6CbawpKsLAfqYpjA4bn7LJr9uvM
 SFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vz4RpNkAFts865UAXW8DwCyoEd+dqjleopIGrH/AuTc=;
 b=KFO/tZxwlaY4kVJZXmKNH0W6jgxwGBsH2GerT9vcMCKgTf3Yo9qkVVOe0IKh5mP8BS
 FTssrS5YSipD6HP/WODbHYOvRMhX2kZktn3IBln207mARmLDLWGqd6iOpUkfUP7V3Uj8
 IjEOkwEAMSFb+zCcjlTgTvkhDWa6Oo+w5jlhHfqzOC3fwFBV2U701oKxI7+wBZWh+OGs
 aCGXCF5k5H0+XM5fCzXO8yhG5hjzEQxNU8NPRNdodm1QUdzoIzApKB1aEmcS6RG8SlTL
 kLGqcGHpasiDRSyRxg/BAD5Gq6kIYcjXH7tSN/rz/0YQeTi7NPsxWpqaGYzbMwDF9q+x
 Jz6A==
X-Gm-Message-State: AA+aEWbnmY2or+80QpbBZzc42DAM34JvCAzDftuXNGgftZqxTOVNtMjA
 6s+jwV9U9LNJJRac0XXjFsWFzH4580/DEB6fqNzUFg==
X-Google-Smtp-Source: AFSGD/UyFqTohNcPZfT+W/QTh6VZmuq/cE0JrDEfs+Q4pUtX4iT0u0B6XCvx2oumEIfzz5lmOmcv2l8nb5iIVvCnpzk=
X-Received: by 2002:a17:902:29ab:: with SMTP id
 h40mr16898432plb.238.1543862712734; 
 Mon, 03 Dec 2018 10:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20181102004455.10157-1-joel@jms.id.au>
 <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
 <CACPK8XdbWzb=52iFV_fj0Y5KMWPgsRv_A8PZgfKn9vm96y3LOw@mail.gmail.com>
In-Reply-To: <CACPK8XdbWzb=52iFV_fj0Y5KMWPgsRv_A8PZgfKn9vm96y3LOw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 3 Dec 2018 10:45:01 -0800
Message-ID: <CAKwvOdndyeRZApOqbp-6evEpYgzHyGo4qqaMKd_DQ4U9x8_5wA@mail.gmail.com>
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

On Mon, Dec 3, 2018 at 2:24 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Sat, 3 Nov 2018 at 04:04, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Thu, Nov 1, 2018 at 5:45 PM Joel Stanley <joel@jms.id.au> wrote:
> > >
> > > We cannot build these files with clang as it does not allow altivec
> > > instructions in assembly when -msoft-float is passed.
> > >
> > > Jinsong Ji <jji@us.ibm.com> wrote:
> > > > We currently disable Altivec/VSX support when enabling soft-float.  So
> > > > any usage of vector builtins will break.
> > > >
> > > > Enable Altivec/VSX with soft-float may need quite some clean up work, so
> > > > I guess this is currently a limitation.
> > > >
> > > > Removing -msoft-float will make it work (and we are lucky that no
> > > > floating point instructions will be generated as well).
> > >
> > > This is a workaround until the issue is resolved in clang.
> > >
> > > Link: https://bugs.llvm.org/show_bug.cgi?id=31177
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/239
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > ---
> > > v2: fix typo in comment, thanks Jinsong
> > >
> > >  lib/raid6/Makefile | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> > > index 2f8b61dfd9b0..7ed43eaa02ef 100644
> > > --- a/lib/raid6/Makefile
> > > +++ b/lib/raid6/Makefile
> > > @@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
> > >
> > >  ifeq ($(CONFIG_ALTIVEC),y)
> > >  altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
> > > +
> > > +ifdef CONFIG_CC_IS_CLANG
> > > +# clang ppc port does not yet support -maltivec when -msoft-float is
> > > +# enabled. A future release of clang will resolve this
> > > +# https://bugs.llvm.org/show_bug.cgi?id=31177
> > > +CFLAGS_REMOVE_altivec1.o  += -msoft-float
> > > +CFLAGS_REMOVE_altivec2.o  += -msoft-float
> > > +CFLAGS_REMOVE_altivec4.o  += -msoft-float
> > > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > > +CFLAGS_REMOVE_vpermxor1.o += -msoft-float
> > > +CFLAGS_REMOVE_vpermxor2.o += -msoft-float
> > > +CFLAGS_REMOVE_vpermxor4.o += -msoft-float
> > > +CFLAGS_REMOVE_vpermxor8.o += -msoft-float
> > > +endif
> >
> > Hi Joel, thanks for this patch!  My same thoughts about
> > CONFIG_CC_IS_CLANG vs cc-option from
> > https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/180939.html
> > apply here as well.  I don't feel strongly about either though.  What
> > are your thoughts?
>
> I'm not sure that we can test for this one with cc-option. The result
> of having -maltivec with -msoft-float is a error about the internals
> of clang, which isn't something that kbuild is set up to test for.

As in clang itself crashes, and cc-option/kbuild can't handle that gracefully?

>
> When clang is fixed to allow this combination we will still build this
> code in the same way, so in that sense it fails "open".
>
> Cheers,
>
> Joel



-- 
Thanks,
~Nick Desaulniers
