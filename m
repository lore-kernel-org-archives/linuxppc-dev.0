Return-Path: <lawrence@softsystem.co.uk>
Received: from smtp21.services.sfr.fr (smtp21.services.sfr.fr [93.17.128.3])
	by ozlabs.org (Postfix) with ESMTP id 0C2E6B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 16:27:04 +1000 (EST)
Received: from smtp21.services.sfr.fr (msfrf2122 [10.18.25.36])
	by msfrf2110.sfr.fr (SMTP Server) with ESMTP id 5B1117002116
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 08:18:49 +0200 (CEST)
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2122.sfr.fr (SMTP Server) with ESMTP id 7DCEC7000082
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 08:18:45 +0200 (CEST)
Received: from smtp-in.softsystem.co.uk (unknown [77.200.117.118])
	by msfrf2122.sfr.fr (SMTP Server) with SMTP id 324D97000089
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 08:18:45 +0200 (CEST)
Received: FROM [192.168.1.62] (gagarin [192.168.1.62])
	BY smtp-in.softsystem.co.uk [77.200.117.118] (SoftMail 1.0.5,
	www.softsystem.co.uk) WITH ESMTP
	FOR <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jul 2010 08:18:27 +0200
Subject: Re: [PATCH] Add cmd64x IDE driver to default pmac32 config
From: lawrence rust <lawrence@softsystem.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1278565221.28659.74.camel@pasglop>
References: <1278181316.3232.45.camel@gagarin>
	<1278565221.28659.74.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 08:18:27 +0200
Message-ID: <1278569907.1411.19.camel@gagarin>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-08 at 15:00 +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2010-07-03 at 20:21 +0200, lawrence rust wrote:
> > The Blue/White Apple PowerMac G3 and early G4's use a cmd64x compatible
> > IDE disk controller.  E.g. lspci shows...
> > 
> > 01:01.0 IDE interface: Silicon Image, Inc. PCI0646 (rev 07)
> > 
> > Unfortunately the default pmac32 configuration does not include this
> > driver and so PowerMac G3's can't load a root filesystem.  This is an
> > issue on a least Ubuntu since version 9.04, which uses the default
> > config as a starting point.
> > 
> > Signed-off-by: Lawrence Rust <lawrence at softsystem.co.uk>
> 
> Shouldn't we just switch the whole thing to libata now anyways ?

Sure. it would be preferable but unfortunately the PowerMac on-board IDE
controller (CONFIG_BLK_DEV_IDE_PMAC), used for the DVD drive on B/W
G3's, doesn't have a PATA equivalent.  So it's pragmatic (until the IDE
code is removed) to use the IDE cmd64x driver to minimise kernel code
size.

A minor correction to my previous post, the first version of Ubuntu to
suffer from this problem was 9.10.

-- Lawrence
> 
> Cheers,
> Ben.
> 
> > diff -uprN a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig 
> > --- a/arch/powerpc/configs/pmac32_defconfig	2010-05-16 23:17:36.000000000 +0200
> > +++ b/arch/powerpc/configs/pmac32_defconfig	2010-07-03 20:11:10.000000000 +0200
> > @@ -738,7 +738,7 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
> >  # CONFIG_BLK_DEV_AEC62XX is not set
> >  # CONFIG_BLK_DEV_ALI15X3 is not set
> >  # CONFIG_BLK_DEV_AMD74XX is not set
> > -# CONFIG_BLK_DEV_CMD64X is not set
> > +CONFIG_BLK_DEV_CMD64X=y
> >  # CONFIG_BLK_DEV_TRIFLEX is not set
> >  # CONFIG_BLK_DEV_CS5520 is not set
> >  # CONFIG_BLK_DEV_CS5530 is not set
> > 
> > 
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 


-- 
-- Lawrence Rust
