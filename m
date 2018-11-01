Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347DBECDE47
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 10:28:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711752081B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 10:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mcK7rckW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711752081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42m1dP2xQYzF3NB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 21:28:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mcK7rckW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=armlinux.org.uk
 (client-ip=2001:4d48:ad52:3201:214:fdff:fe10:1be6;
 helo=pandora.armlinux.org.uk;
 envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.b="mcK7rckW"; dkim-atps=neutral
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42m1Yl5WkNzF3Mq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 21:25:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pfBYPcKEHFmp/09Hz2p1i9SED+F/1DOEjiI7amX/IgY=; b=mcK7rckWm93VnKfbX3LmKsGrV
 YYuXCUZtnmAAVC7MLl/1vn773bBPxQv2RCflQF/J6tDIxIzBQiWD9MlJKPgwwnXaUKHnBLuDjPkKt
 UYTVIT0cbKiCy3FQvSpNuFlpgkcohc222qwEtW+Tq3MWDrCayYfcQ0ffbR6KsSm42BXfg=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:43519)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gIAA0-0004WL-HU; Thu, 01 Nov 2018 10:25:08 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gIA9s-0006ug-Cy; Thu, 01 Nov 2018 10:25:00 +0000
Date: Thu, 1 Nov 2018 10:24:58 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
Message-ID: <20181101102458.GN30658@n2100.armlinux.org.uk>
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-7-hch@lst.de>
 <20181019122228.GJ30658@n2100.armlinux.org.uk>
 <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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

On Fri, Oct 19, 2018 at 09:58:46PM +0900, Masahiro Yamada wrote:
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

Well, the situation we have on ARM is rather optimal - when the
rest of the configuration supports PCI, PCI is made visible.  When
there's no hardware support for PCI, PCI is hidden.  When PCI is
mandatory, PCI is selected and mostly always hidden.

It seems that with this consolidation, we lose that - we end up
with PCI being visible for every ARM config, not only those where
PCI is "impossible" but also for those where PCI is forcefully
selected.

That said, offering PCI for platforms that do not have any possibility
of PCI hardware shouldn't cause any compile issues, and would increase
build coverage - but I'd say it wouldn't _usefully_ increase build
coverage.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
