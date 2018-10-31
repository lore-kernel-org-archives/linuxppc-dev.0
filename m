Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DB2ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 16:09:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D5220664
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 16:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JqvdN7ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D5220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lYDn0pMZzF3KP
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 03:09:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="JqvdN7ba";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="JqvdN7ba"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lY9b5MQBzF31Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 03:06:26 +1100 (AEDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id w9VG633M015366
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Nov 2018 01:06:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9VG633M015366
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1541001964;
 bh=rm4KBd9Y1DjyNm7gMyiNo8tn1N+1kLxAGdNLudCccdI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JqvdN7baYjxm3y4SffjP5dcqILVQxN1PONQylmH4GekjpfMQrGc0Gs20G1DxmPwwf
 2Ulw9WdymD1ePio94lpLlfQ1YS4kpIsF+0a4a5KtZ+7jTPhbfudfn7NsiqwCCotI9g
 1Bib5DRqKCQVrpddlKGJ6PZM/kUk3uUImVBaun4a/pyHQLn1ja3reeDiQBXUORPBIZ
 DYNxeCtBchszGB1DRll9bVzF3cxEoEmK04Xa4I9jSgsmhPLyLxBgkVbuXt7bDfQKHT
 U0mzY7fNxM2rWftsNgEhMYlolBjnLDPS2q9ZIEqNibzyyVveuQX4NBZnIWcYhvMpTR
 FQHlP5fw5dFZg==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id w19so6114927uaj.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 09:06:04 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKQPOEAtzM8Tm7zZ4BZqFeEDtJCo8KN7kiBtcLi0RfmFEycQfus
 RoTZBV03EeV0MZOwjT6MaVTvfFyftlaFK6JCp5c=
X-Google-Smtp-Source: AJdET5cPwAWbY9PNn2LZNg5TFvXRL1rtx5qnkG8+zSU8HbppT4T4TbtM5UymtdBlQNISyrl8mdSfRVTcQzB5blYEUyo=
X-Received: by 2002:ab0:5444:: with SMTP id o4mr1665827uaa.55.1541001962702;
 Wed, 31 Oct 2018 09:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-7-hch@lst.de>
 <20181019122228.GJ30658@n2100.armlinux.org.uk>
 <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com>
In-Reply-To: <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Nov 2018 01:05:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUArREw1AWUzcOoQCe5=4jyifbs+x2CdCK+qXJ+woAdw@mail.gmail.com>
Message-ID: <CAK7LNASUArREw1AWUzcOoQCe5=4jyifbs+x2CdCK+qXJ+woAdw@mail.gmail.com>
Subject: Re: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
To: Christoph Hellwig <hch@lst.de>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Russell King <linux@armlinux.org.uk>, Alex Bounine <alex.bou9@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,


On Fri, Oct 19, 2018 at 9:58 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Oct 19, 2018 at 9:23 PM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>
> > > index a68b34183107..b185794549be 100644
> > > --- a/arch/arm/mach-pxa/Kconfig
> > > +++ b/arch/arm/mach-pxa/Kconfig
> > > @@ -125,7 +125,7 @@ config MACH_ARMCORE
> > >       bool "CompuLab CM-X255/CM-X270 modules"
> > >       select ARCH_HAS_DMA_SET_COHERENT_MASK if PCI
> > >       select IWMMXT
> > > -     select MIGHT_HAVE_PCI
> > > +     select HAVE_PCI
> > >       select NEED_MACH_IO_H if PCI
> > >       select PXA25x
> > >       select PXA27x
> >
> > This is wrong.  "MIGHT_HAVE_PCI" is _not_ the same as "HAVE_PCI" - we
> > have a bunch of platforms that mandatorily have PCI and these select
> > PCI directly.  "MIGHT_HAVE_PCI" controls the _visibility_ of the PCI
> > menu option, but does not prevent it being selected.  Your patch will
> > cause Kconfig to complain for those which mandatorily have PCI but
> > do not set HAVE_PCI.
>
>
> Good catch!
> But, adding a bunch of 'select HAVE_PCI' along with 'select PCI' is ugly.
>
> Do you have any suggestion?
>
> How about letting CONFIG_ARM to select HAVE_PCI ?
>


I applied 1/9, 3/9, 4/9, 5/9.
(I think 2/9 should be squashed to 9/9)

As Russell pointed out, we need to avoid
the unmet dependency.


Are you planning to send
the updated version for 6/9 through - 9/9 ?

If so, could you please rebase 6/9
so that it is cleanly applicable ?


Thanks.


--
Best Regards
Masahiro Yamada
