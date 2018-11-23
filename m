Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969B8C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 03:56:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD0120664
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 03:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2lZONFPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD0120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431MtQ1MwCzDqSN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 14:56:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="2lZONFPa";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.81; helo=conssluserg-02.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="2lZONFPa"; 
 dkim-atps=neutral
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431L8d3FDjzDqSS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 13:38:24 +1100 (AEDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id wAN2c8Zb026295
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 11:38:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAN2c8Zb026295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1542940688;
 bh=rOnl2xHenEB34XvFlsbt4tdAlicrEGa19eMCQMOc4l8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=2lZONFPavIUSmkAJVm28VwdolLuqRQvUCXBou4/6T/lAtYlQuaxb7SpzYRC9XfJR6
 BGVLw2CzrN58kFjrQb87XOPsoxbd6N1pWbQBEUKxXanJu9TJwB7c9QPaCq6B5WzGkl
 gSxyyiO9Da0T5YgXYzrwON3Mx7+41eMkwlMBBBmvHUZIUFX5Olv+Ub/v1H9MjA6jOa
 QL35DUd4s8pi5CH12hxCGYjZqrbDuPNpGBaxzmsPQUVXF2wjQJlxcxSZLjpIV10z6v
 O5yu/OY+R5J18m4drWjfqvNCIt+WGCFWde4WMYQtDQ2pnUA9ApxtXKkKXiMogotdzH
 +BMq748q6yt5A==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id d19so3652303uaq.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 18:38:08 -0800 (PST)
X-Gm-Message-State: AA+aEWaQiB4T6d27pucQshsEQ1wihnag24lFRLStTl4hEJQSWYcq2q90
 ZWwySph26zSJMjw9M5ApJ0VhLuoarulz1KbCrGg=
X-Google-Smtp-Source: AFSGD/Wwp/hah0oo5/0GQfUnvJYH3gLpyQOzZskl7GmU9GiR52iN5Ksf/5RfdO7QvUq7yQYQLdpcoh0AU0XiIzXFmps=
X-Received: by 2002:ab0:6705:: with SMTP id q5mr5908002uam.89.1542940687691;
 Thu, 22 Nov 2018 18:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de>
 <20181115190538.17016-4-hch@lst.de>
 <20181119210141.nissqr6zaldt23xg@pburton-laptop>
 <20181119210538.p6xhyxf3s2diyv2v@pburton-laptop>
In-Reply-To: <20181119210538.p6xhyxf3s2diyv2v@pburton-laptop>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Nov 2018 11:37:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5DHbe7RwixEi6vf6y+LzB5so0=xyFMMpv+xmEnVA3Mw@mail.gmail.com>
Message-ID: <CAK7LNAQ5DHbe7RwixEi6vf6y+LzB5so0=xyFMMpv+xmEnVA3Mw@mail.gmail.com>
Subject: Re: [PATCH 3/9] MIPS: remove the HT_PCI config option
To: Paul Burton <paul.burton@mips.com>
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
 Linux-MIPS <linux-mips@linux-mips.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Alex Bounine <alex.bou9@gmail.com>, linux-alpha@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 20, 2018 at 6:07 AM Paul Burton <paul.burton@mips.com> wrote:
>
> On Mon, Nov 19, 2018 at 01:01:41PM -0800, Paul Burton wrote:
> > On Thu, Nov 15, 2018 at 08:05:31PM +0100, Christoph Hellwig wrote:
> > > This option is always selected from LOONGSON_MACH3X.  Switch to just
> > > seleting PCI from that option and definining LOONGSON_PCIIO_BASE based
> > > on CONFIG_LOONGSON_MACH3X.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/mips/Kconfig                                | 11 -----------
> > >  arch/mips/include/asm/mach-loongson64/loongson.h |  2 +-
> > >  arch/mips/loongson64/Kconfig                     |  2 +-
> > >  3 files changed, 2 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > index 8272ea4c7264..7d28c9dd75d0 100644
> > > --- a/arch/mips/Kconfig
> > > +++ b/arch/mips/Kconfig
> > > @@ -3040,17 +3040,6 @@ config PCI
> > >       your box. Other bus systems are ISA, EISA, or VESA. If you have PCI,
> > >       say Y, otherwise N.
> > >
> > > -config HT_PCI
> > > -   bool "Support for HT-linked PCI"
> > > -   default y
> > > -   depends on CPU_LOONGSON3
> > > -   select PCI
> > > -   select PCI_DOMAINS
> > > -   help
> > > -     Loongson family machines use Hyper-Transport bus for inter-core
> > > -     connection and device connection. The PCI bus is a subordinate
> > > -     linked at HT. Choose Y for Loongson-3 based machines.
> > > -
> > >  config PCI_DOMAINS
> > >     bool
> > >
> > > diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
> > > index c865b4b9b775..781a5156ab21 100644
> > > --- a/arch/mips/loongson64/Kconfig
> > > +++ b/arch/mips/loongson64/Kconfig
> > > @@ -76,7 +76,7 @@ config LOONGSON_MACH3X
> > >     select CPU_HAS_WB
> > >     select HW_HAS_PCI
> > >     select ISA
> > > -   select HT_PCI
> > > +   select PCI
> > >     select I8259
> > >     select IRQ_MIPS_CPU
> > >     select NR_CPUS_DEFAULT_4
> >
> > Should this also select PCI_DOMAINS to preserve the existing behavior?
> >
> > If not, could you explain why in the commit message?
>
> Ah, I see - PCI already selects PCI_DOMAINS. I think it would have been
> worth mentioning

OK, I added "PCI already selects PCI_DOMAINS"
in the commit description.



> but I don't mind if you don't think it a big enough
> deal to respin the patch, so:
>
>     Acked-by: Paul Burton <paul.burton@mips.com>
>
> Thanks,
>     Paul



-- 
Best Regards
Masahiro Yamada
