Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BF0C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 14:51:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A215120C0A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 14:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1ooz8dPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A215120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P4wp4WNDzF380
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 00:51:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="1ooz8dPb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="1ooz8dPb"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P4t12RwkzF33P
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 00:48:56 +1000 (AEST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id w91EmckC015851
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Oct 2018 23:48:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w91EmckC015851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1538405319;
 bh=5xLnjWYlaLHDfQSoDnaw2ichwJ/ivXEr+S7uTOdzoRE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=1ooz8dPb0BRed5QUDq53QAokaJGPIX9D9rN+QsLlMx019h4MVYrueF6bhRvJ5s6tk
 LjISdYLwtp0QF/A9D3n/g4IZp53Wrr9ec26ATLdV4Vvn0eDK5tR9ANGcSgkgfQz70X
 p/OvwPpLbMOMNhzoHgX7ztKauV6vxE8DMyzPEBWsSa2JIAdQkAyt0LQ9naUx86x358
 2g9DSriFxDvYJgxC9jf21OzscNay5Yrjhyw3oNtV4ybcwl8WE2SMELoZ488P2KKWUB
 avKwib11KoW2UxmngNH5UPN2B6GJMsiDPmM1bajxof8ZFZEcXab8akUdARTtat5E0j
 mgMYm4dFgnYcQ==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id g18-v6so4976452uam.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 07:48:38 -0700 (PDT)
X-Gm-Message-State: ABuFfoieTU2m+WX5GEnhi9WyH/G1WJGW8PUD/EngeILD3ZltSgIEtx8m
 4YOnkYqqZXcQnH4B77tAS/xzDUkBEle4ENzQGa8=
X-Google-Smtp-Source: ACcGV63Lp5DmcNEdHObPJ9iIFkuC5aeS+D9PUDy+KEQ3Qc97quis/gIiKLMM01moL3IgHngn1YfjSCscCPfngL34bMo=
X-Received: by 2002:a9f:3826:: with SMTP id
 p35-v6mr1734574uad.42.1538405317121; 
 Mon, 01 Oct 2018 07:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
 <20180928154150.GA25013@bogus>
 <CAK7LNATiSbwVfCRNsDOyksfq5wcv0pnNQYnMXdo2yRyE7fcn-Q@mail.gmail.com>
 <CAL_JsqLPaX3GB1Esw3DhkQ+2fQLVG8=_UbyJC5RJ-6_s=v288g@mail.gmail.com>
In-Reply-To: <CAL_JsqLPaX3GB1Esw3DhkQ+2fQLVG8=_UbyJC5RJ-6_s=v288g@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 1 Oct 2018 23:48:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNASX+2iLbXmpgcsH9agrxkd5xeWbTZdh8hxL+zJm4L11gw@mail.gmail.com>
Message-ID: <CAK7LNASX+2iLbXmpgcsH9agrxkd5xeWbTZdh8hxL+zJm4L11gw@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-xtensa@linux-xtensa.org,
 Will Deacon <will.deacon@arm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Frank Rowand <frowand.list@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 DTML <devicetree@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Michal Marek <michal.lkml@markovi.net>, Vineet Gupta <vgupta@synopsys.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 nios2-dev@lists.rocketboards.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,


2018=E5=B9=B410=E6=9C=881=E6=97=A5(=E6=9C=88) 22:26 Rob Herring <robh@kerne=
l.org>:
>
> On Mon, Oct 1, 2018 at 12:49 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Rob,
> >
> >
> > 2018=E5=B9=B49=E6=9C=8829=E6=97=A5(=E5=9C=9F) 0:43 Rob Herring <robh@ke=
rnel.org>:
> >
> > > +#
> > > ---------------------------------------------------------------------=
------
> > > +# Devicetree files
> > > +
> > > +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> > > +dtstree :=3D arch/$(SRCARCH)/boot/dts
> > > +endif
> > > +
> > > +ifneq ($(dtstree),)
> > > +
> > > +%.dtb : scripts_dtc
> >
> > %.dtb: prepare3 prepare
>
> I assume you didn't mean to drop scripts_dtc as that doesn't work.
>
> Why "prepare" here and not on dtbs?


Sorry, my mistake.


%.dtb: prepare3 scripts_dtc

is the correct one.



> > because we need to make sure KERNELRELEASE
> > is correctly defined before dtbs_install happens.
>
> Yes, indeed. With prepare3 added I get:
>
> cp: cannot create regular file
> '/boot/dtbs/4.19.0-rc3-00009-g0afba9b7b2ea-dirty': No such file or
> directory
>
> vs. with it:
>
> cp: cannot create regular file '/boot/dtbs/': Not a directory
>
> >
> >
> > > +       $(Q)$(MAKE) $(build)=3D$(dtstree) $(dtstree)/$@
> > > +
> > > +PHONY +=3D dtbs dtbs_install
> > > +dtbs: scripts_dtc
> >
> >
> > dtbs: prepare3 scripts_dtc
> >
> >
> >
> > > +       $(Q)$(MAKE) $(build)=3D$(dtstree)
> > > +
> > > +dtbs_install: dtbs
> >
> >
> > Please do not have dtbs_install to depend on dtbs.
> >
> > No install targets should ever trigger building anything
> > in the source tree.
> >
> >
> > For the background, see the commit log of
> > 19514fc665ffbce624785f76ee7ad0ea6378a527
>
> Okay, thanks.
>
> Rob



--=20
Best Regards
Masahiro Yamada
