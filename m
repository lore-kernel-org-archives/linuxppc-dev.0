Return-Path: <g.liakhovetski@gmx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2B2DDB708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 21:30:05 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E9AD8DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2009 21:30:02 +1000 (EST)
Date: Fri, 14 Aug 2009 13:29:54 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: ARM clock API to PowerPC
In-Reply-To: <1250242149.24143.36.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0908141255230.5980@axis700.grange>
References: <1250063825.15143.43.camel@pasglop>
	<20090812111954.GB31596@zod.rchland.ibm.com>
	<4A90486C-8BF5-428C-9FD8-830D822C0D40@kernel.crashing.org>
	<1250112599.3587.21.camel@pasglop>
	<3A45394FD742FA419B760BB8D398F9ED59DE33@zch01exm26.fsl.freescale.net>
	<1250242149.24143.36.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: devicetree-discuss@lists.ozlabs.org, John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Torez Smith <torez@us.ibm.com>, Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 14 Aug 2009, Benjamin Herrenschmidt wrote:

> On Thu, 2009-08-13 at 16:59 +0800, Li Yang-R58472 wrote:
> > >Now, I know there is at least one person on earth 
> > >contemplating sharing some drivers between PPC and ARM. I 
> > >won't tell much more at this stage, but it makes sense in the 
> > >grand scheme of things to see SoC vendors put similar IO cores 
> > >into either PPC or ARM and providing that clock API is a good 
> > >way to also allow these drivers to work since the drivers in 
> > >questions make use of it.
> > 
> > Freescale USB UDC driver is another example that shared between PowerPC
> > and ARM(i.mx).  Currently, the imx part of the driver uses clk API, but
> > PowerPC part uses static initialization.  It will be better if we can
> > unify the clk setting part of the driver.
> 
> I had a look at it looks like it uses the API in a way that would fit
> nicely with my plans, ie, it should be possible to use the same driver
> on both archs pretty much without changes provided the ppc platform
> provides a clock source driver and hooks it up to the device-tree.
> 
> I'll work on some proof-of-concept implementation of the core bits
> early next week.

You might have a look at these threads:

http://marc.info/?t=124876760500001&r=1&w=2
http://marc.info/?t=124782904600005&r=2&w=2

but since they are quite long, in short, in them a patch has been 
discussed, that allowed to re-use an MMC driver, used on some MFDs, on 
SuperH SoCs. The patch was taking the "easy route" of adding the 
possibility to use the clock API to the tmio_mmc.c driver, while leaving 
it to use static clock configurations with MFD drivers. This approach has 
been rejected and initially it has been suggested to implement a 
platform-independent clock API like what had been proposed by clocklib, 
but since the future of clocklib is unclear, it has then been decided to 
remove the clock (and power) management from the driver proper and move 
them to some callbacks. I.e., there would be more users interested in a 
unified clock API, including other platforms and platform-independent 
drivers like MFD. Currently the reason, why MFD drivers cannot implement 
their own clock devices is that the "struct clk" differs between 
platforms.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
