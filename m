Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295F5C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 15:38:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3F22054F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 15:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jaUhc7Sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3F22054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lXXp6cbnzF3G6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 02:38:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="jaUhc7Sp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.83; helo=conssluserg-04.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="jaUhc7Sp"; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lXSL6ZBXzF3N0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 02:34:10 +1100 (AEDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id w9VFXfPM005499
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Nov 2018 00:33:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w9VFXfPM005499
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1541000021;
 bh=7MVqzDRPdYZDW53V3e7ri//BecS61EPHkL2jRn69Nm0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=jaUhc7SpUqcQl6UKFLIbCDG52ekg8Pl3Ap7rsCe8VL2betxB2GweIv0bMCLuOs6fh
 hVr3R5S/oyQN0RBI/qpxqdFUmMRH/mZVJaVitQY9qXCVyw+xXKlxC1rD3dmgkw+54I
 LWZbrA9oEQJ9jTDDeyqLB81AaoZOylaTUf6Dz1zgaX1A5w2nFXsgupn1xDCWSWzMb3
 J+NZR2VE1RMf3mnhkb+5vJJM/6WbwATSFh0HKSH6oRFA8DAxu5ied5nsQraKmXXIfY
 2EouAvcmJ0qtbzSEL53Z97+iQWCBxkRVnxBX+5Rtgqpvct1MwEH41mVRxc6zGXw7kJ
 vXppOSOrk0n9w==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id m199-v6so4010500vke.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 08:33:41 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJU2hB3VqwdV0VflMpfI6Y/a4YIftwgagWGTADHClUyULhxG6Nw
 3r0FZFLFXTNpRDZTDN5faXtddrL8e7SRXKMIDjM=
X-Google-Smtp-Source: AJdET5cSKM07kpQyZQ73G/EvgXpVGTYb+L6+vGDKhCWRoPmOB0xQTbJTKCGHcBBdV8iKhtsZJhGWT++V5NCTdRKbt4o=
X-Received: by 2002:a1f:1d4b:: with SMTP id
 d72-v6mr1474118vkd.34.1541000020309; 
 Wed, 31 Oct 2018 08:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-6-hch@lst.de>
 <20181019151019.GA5618@localhost>
In-Reply-To: <20181019151019.GA5618@localhost>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Nov 2018 00:33:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARa7xqG1iyQb9PE271L8QTC7nsaVXSAofm0hzku8T5Xvg@mail.gmail.com>
Message-ID: <CAK7LNARa7xqG1iyQb9PE271L8QTC7nsaVXSAofm0hzku8T5Xvg@mail.gmail.com>
Subject: Re: [PATCH 5/9] powerpc: PCI_MSI needs PCI
To: Josh Triplett <josh@joshtriplett.org>
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
 Alex Bounine <alex.bou9@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Oct 20, 2018 at 12:10 AM Josh Triplett <josh@joshtriplett.org> wrote:
>
> On Fri, Oct 19, 2018 at 02:09:48PM +0200, Christoph Hellwig wrote:
> > Various powerpc boards select the PCI_MSI config option without selecting
> > PCI, resulting in potentially not compilable configurations if the by
> > default enabled PCI option is disabled.  Explicitly select PCI to ensure
> > we always have valid configs.
> [...]
> > --- a/arch/powerpc/platforms/44x/Kconfig
> > +++ b/arch/powerpc/platforms/44x/Kconfig
> > @@ -24,6 +24,7 @@ config BLUESTONE
> >       default n
> >       select PPC44x_SIMPLE
> >       select APM821xx
> > +     select PCI
> >       select PCI_MSI
> >       select PPC4xx_MSI
> >       select PPC4xx_PCI_EXPRESS
> > @@ -78,6 +79,7 @@ config KATMAI
> >       select 440SPe
> >       select PCI
> >       select PPC4xx_PCI_EXPRESS
> > +     select PCI
> >       select PCI_MSI
>
> This case already had PCI selected a couple of lines above.


Good catch!

I dropped this hunk,
and applied to linux-kbuild.





> >       select PPC4xx_MSI
> >       help
> > @@ -219,6 +221,7 @@ config AKEBONO
> >       select SWIOTLB
> >       select 476FPE
> >       select PPC4xx_PCI_EXPRESS
> > +     select PCI
> >       select PCI_MSI
> >       select PPC4xx_HSTA_MSI
> >       select I2C
> > --
> > 2.19.1
> >



-- 
Best Regards
Masahiro Yamada
