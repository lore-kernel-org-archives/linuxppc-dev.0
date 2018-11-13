Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2624FC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 05:20:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDD92245E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 05:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VRzB+YME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDD92245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vGD3230hzF3Lk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 16:20:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="VRzB+YME";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="VRzB+YME"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vG9N5l82zF3L3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 16:17:58 +1100 (AEDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id wAD5HH8W007228
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 14:17:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wAD5HH8W007228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1542086238;
 bh=eIepQQZqGhbrF7uUL6KRHAz7aUR5FXmFTRzaAQhPa8E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=VRzB+YMEqY0Fj2p6s4F32pXrZvW5LKr90C/SF8Yik0+644VsmQJtivWyGYCOeOqWY
 IqFQhE7Laii82Pd7TYuOisZxWUwrTWC+2TQhnozOYWYoKvNc/u/LI0M3XhyJ04Z0pY
 /t8tSyYINyj0MDWdtK6FINmAL40B59RjCC86+THvajMs2VPLOhmppoFBdXSIErZSXk
 CXTPV2GDYKd+BUQHzwH97kCNHKB/cPqUzpuO4etQvpOkMw3sc/Y+Is6NtODBjEt6bw
 KvSHQ/uwiaTI0oV8tdmR1NCeFYpX1hXFBE0IZeJ3qlVnT+jllFB7q6DTi3Km4rwMqD
 lIoZA3aQN+Fsg==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id s26so3895892uao.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 21:17:17 -0800 (PST)
X-Gm-Message-State: AGRZ1gLA5/8aYly3KiCtEUnC92Y2mWTRlfe7qinDAqxJ0ESN3BMnEMsd
 u/cNllIKf4IHkIQf0+BWhy65Yt4vFBlJnIkK7ek=
X-Google-Smtp-Source: AJdET5dj5QGaE7Ecx7U/WJGwqMdrASdN7yj/X8TFiar4CCe07FyYChwKdkxv8dTEcporgtJvQ2g8T+Fc5HfGZrWQtM0=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr1741892uap.6.1542086236514;
 Mon, 12 Nov 2018 21:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20181112042116.5271-1-joel@jms.id.au>
 <20181112042116.5271-2-joel@jms.id.au>
 <CAKwvOdnBMFYXvS+GH0cUiczgkpLWtBinPRjkTJBQGrKjxktUUg@mail.gmail.com>
In-Reply-To: <CAKwvOdnBMFYXvS+GH0cUiczgkpLWtBinPRjkTJBQGrKjxktUUg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 13 Nov 2018 14:16:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNASE=xCaE-q_Jke5aDd9aF=dJ+ThUjORLa0i_m3e6UzUig@mail.gmail.com>
Message-ID: <CAK7LNASE=xCaE-q_Jke5aDd9aF=dJ+ThUjORLa0i_m3e6UzUig@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: Export clang toolchain variables
To: Nick Desaulniers <ndesaulniers@google.com>
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Joel Stanley <joel@jms.id.au>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 13, 2018 at 3:56 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Nov 11, 2018 at 8:21 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > The powerpc makefile will use these in it's boot wrapper.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 09278330282d..840efe6eb54c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -495,6 +495,7 @@ endif
> >  ifneq ($(GCC_TOOLCHAIN),)
> >  CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
> >  endif
> > +export CLANG_FLAGS
> >  CLANG_FLAGS    += -no-integrated-as
>
> Does this export CLANG_FLAGS before `-no-integrated-as` is set?

This does not matter.

For example, KBUILD_CFLAGS accumulates several compiler flags
after it is marked as 'export'.


> Either way, I think it would be clearer to export this after all the
> relevant flags are set.

OK. It is just a matter of preference,
but I will move the export line below
when I pick up this patch set.



> >  KBUILD_CFLAGS  += $(CLANG_FLAGS)
> >  KBUILD_AFLAGS  += $(CLANG_FLAGS)
> > --
> > 2.19.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
