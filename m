Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B623EC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 15:28:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F114D218A1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 15:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MbRMqiQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F114D218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LTxF4qvCzDqK1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 02:28:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.90; helo=conssluserg-05.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="MbRMqiQd"; 
 dkim-atps=neutral
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LTvF347KzDqT3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 02:26:32 +1100 (AEDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x2FFPr78003298
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 00:25:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2FFPr78003298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1552663554;
 bh=F1xXciikqYB8cmJ49LUR/BkfpBtjwYwmxJsa/dIlFGI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=MbRMqiQdv3FG+Yj08b5/4lrhQiMpbZXdvMTBz1GuzXDUg94e/8qUPLJQSWvu1hyVN
 kzQYvpeVWejCitMH8XioNvWHd82hwKLx4WPC6KkknC8k/25MBRlrvyLjwMDwKZX4cJ
 d38fI8yJ0kfDIV6MoQTEapBLMZW/GUoKcepyGJpqZQivLIY3TYGS9lVJp8ZHC7+fF5
 pp88WIQRsJ7yEJtLeeA8rBkJxRvlGFxXgi95yJol+NpVfDBXnaUlwKLIyjvb++cndV
 etHd80Zf9X7BqNxB83Or+6VO82rq178R02fIpzJKyBbqYCl7p30lNmyBig3yPx1Tcz
 pvdaK4gNa2XIQ==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id e126so5392211vse.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 08:25:54 -0700 (PDT)
X-Gm-Message-State: APjAAAX+RLf4AZORIMDuQS8XCvU146nzGnXMat/XTqVaVBBvBJJ4a13b
 1fuTLxjRFrBPUFb3gHkqXwSVhb2kEKMGZ7ILkS4=
X-Google-Smtp-Source: APXvYqx6IgPuQYoTzWZZ/vwI2xmBw+O/P2QPBMsgFT5JCb69+Q124LqkCHgVEXjrjThntXUz+o7il3GqrUyAfnFzxF4=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr2262322vso.179.1552663553032; 
 Fri, 15 Mar 2019 08:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <1550223519-18290-1-git-send-email-yamada.masahiro@socionext.com>
 <CA+7wUswJ5+nb3OdZYrx6++batRMUcnje3jLTgdN4zAQo=--xBg@mail.gmail.com>
 <CAK7LNAQUEivnhFnmkP+5uCHRJcYWDtK_fm2gB0rsbzGv1taBCg@mail.gmail.com>
 <CA+7wUsxruu0GdyRGJ3vsjRvSBAptMn8_f5BmeMo=-E3zbhGGxQ@mail.gmail.com>
 <87y35i9osc.fsf@concordia.ellerman.id.au>
In-Reply-To: <87y35i9osc.fsf@concordia.ellerman.id.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 16 Mar 2019 00:25:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzUiiG7ivyVmZCMF+5NbfrXJDw3GcLd-05pOk6+r5_Cg@mail.gmail.com>
Message-ID: <CAK7LNASzUiiG7ivyVmZCMF+5NbfrXJDw3GcLd-05pOk6+r5_Cg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: use $(origin ARCH) to select KBUILD_DEFCONFIG
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Mar 14, 2019 at 11:27 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Mathieu Malaterre <malat@debian.org> writes:
> > On Sat, Feb 16, 2019 at 3:26 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >>
> >> On Sat, Feb 16, 2019 at 1:11 AM Mathieu Malaterre <malat@debian.org> wrote:
> >> >
> >> > On Fri, Feb 15, 2019 at 10:41 AM Masahiro Yamada
> >> > <yamada.masahiro@socionext.com> wrote:
> >> > >
> >> > > I often test all Kconfig commands for all architectures. To ease my
> >> > > workflow, I want 'make defconfig' at least working without any cross
> >> > > compiler.
> >> > >
> >> > > Currently, arch/powerpc/Makefile checks CROSS_COMPILE to decide the
> >> > > default defconfig source.
> >> > >
> >> > > If CROSS_COMPILE is unset, it is likely to be the native build, so
> >> > > 'uname -m' is useful to choose the defconfig. If CROSS_COMPILE is set,
> >> > > the user is cross-building (i.e. 'uname -m' is probably x86_64), so
> >> > > it falls back to ppc64_defconfig. Yup, make sense.
> >> > >
> >> > > However, I want to run 'make ARCH=* defconfig' without setting
> >> > > CROSS_COMPILE for each architecture.
> >> > >
> >> > > My suggestion is to check $(origin ARCH).
> >> > >
> >> > > When you cross-compile the kernel, you need to set ARCH from your
> >> > > environment or from the command line.
> >> > >
> >> > > For the native build, you do not need to set ARCH. The default in
> >> > > the top Makefile is used:
> >> > >
> >> > >   ARCH            ?= $(SUBARCH)
> >> > >
> >> > > Hence, $(origin ARCH) returns 'file'.
> >> > >
> >> > > Before this commit, 'make ARCH=powerpc defconfig' failed:
> >> >
> >> > In case you have not seen it, please check:
> >> >
> >> > http://patchwork.ozlabs.org/patch/1037835/
> >>
> >> I did not know that because I do not subscribe to ppc ML.
> >>
> >> Michael's patch looks good to me.
> >
> > OK
> >
> >>
> >> If you mimic x86, the following will work:
> >>
> >
> > Nice! Michael do you have a preference ?
>
> Yeah I don't like playing games with ARCH. Doing so means auto builders
> and other build scripts need to learn about the special rules for ARCH,
> which is a pain.
>
> So I'll merge my patch, which I think will also work for Masahiro's
> case.
>
> cheers


Yes, works for me.

Thanks!




-- 
Best Regards
Masahiro Yamada
