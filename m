Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78160C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 13:52:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F4B208AE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 13:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ahwd3Iv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F4B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P3cN3ZxQzDqXr
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:52:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ahwd3Iv7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ahwd3Iv7"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P31V5PjBzDqh3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 23:25:18 +1000 (AEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A1D2721480
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538400316;
 bh=77lmcVg22ixrSNiGFEFecQMU5osb7alLu04g/J4GUf0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Ahwd3Iv7VlQAV0BKEH4RBhDkHbrjmNeQrN+z4pQTTmkDz5WODcP1F5tgdjVMKmKqf
 dYrgyyTGERrMCnYOzknxTWzKoSlh4M2E5+aeBNS3yeDzZMxFRhF2MONcB2g2UAVw2p
 d+prz8nLb6X1M+uZqHl3Wqb0gsAugD7SDAw9Aa2Y=
Received: by mail-qt1-f177.google.com with SMTP id v19-v6so453391qtg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 06:25:16 -0700 (PDT)
X-Gm-Message-State: ABuFfohI16taYE7jVb8yY/uka08Z+bkYAnXhLvbW3JcEUxCr4lXdiNh+
 /lAPme3AGljlVe0a3oy3iyMXMO0cxcDJNB6Kwg==
X-Google-Smtp-Source: ACcGV602dgl5yG/ReLnFOboqT3pCuRkd2dRGiHEIqM1s4SPS4YcPl1B2TnuuR7IE472SD6uk1rt92LRt9t4lfFWyInE=
X-Received: by 2002:ac8:190e:: with SMTP id
 t14-v6mr8511789qtj.327.1538400315685; 
 Mon, 01 Oct 2018 06:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
 <20180928154150.GA25013@bogus>
 <CAK7LNATiSbwVfCRNsDOyksfq5wcv0pnNQYnMXdo2yRyE7fcn-Q@mail.gmail.com>
In-Reply-To: <CAK7LNATiSbwVfCRNsDOyksfq5wcv0pnNQYnMXdo2yRyE7fcn-Q@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 1 Oct 2018 08:25:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLPaX3GB1Esw3DhkQ+2fQLVG8=_UbyJC5RJ-6_s=v288g@mail.gmail.com>
Message-ID: <CAL_JsqLPaX3GB1Esw3DhkQ+2fQLVG8=_UbyJC5RJ-6_s=v288g@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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
 devicetree@vger.kernel.org,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Michal Marek <michal.lkml@markovi.net>,
 Vineet Gupta <vgupta@synopsys.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 nios2-dev@lists.rocketboards.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 1, 2018 at 12:49 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Rob,
>
>
> 2018=E5=B9=B49=E6=9C=8829=E6=97=A5(=E5=9C=9F) 0:43 Rob Herring <robh@kern=
el.org>:
>
> > +#
> > -----------------------------------------------------------------------=
----
> > +# Devicetree files
> > +
> > +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> > +dtstree :=3D arch/$(SRCARCH)/boot/dts
> > +endif
> > +
> > +ifneq ($(dtstree),)
> > +
> > +%.dtb : scripts_dtc
>
> %.dtb: prepare3 prepare

I assume you didn't mean to drop scripts_dtc as that doesn't work.

Why "prepare" here and not on dtbs?

> because we need to make sure KERNELRELEASE
> is correctly defined before dtbs_install happens.

Yes, indeed. With prepare3 added I get:

cp: cannot create regular file
'/boot/dtbs/4.19.0-rc3-00009-g0afba9b7b2ea-dirty': No such file or
directory

vs. with it:

cp: cannot create regular file '/boot/dtbs/': Not a directory

>
>
> > +       $(Q)$(MAKE) $(build)=3D$(dtstree) $(dtstree)/$@
> > +
> > +PHONY +=3D dtbs dtbs_install
> > +dtbs: scripts_dtc
>
>
> dtbs: prepare3 scripts_dtc
>
>
>
> > +       $(Q)$(MAKE) $(build)=3D$(dtstree)
> > +
> > +dtbs_install: dtbs
>
>
> Please do not have dtbs_install to depend on dtbs.
>
> No install targets should ever trigger building anything
> in the source tree.
>
>
> For the background, see the commit log of
> 19514fc665ffbce624785f76ee7ad0ea6378a527

Okay, thanks.

Rob
