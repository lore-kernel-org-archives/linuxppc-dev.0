Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 25A14B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 19:29:44 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6DD66DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2009 19:29:43 +1000 (EST)
Subject: RE: ARM clock API to PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-R58472 <LeoLi@freescale.com>
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED59DE33@zch01exm26.fsl.freescale.net>
References: <1250063825.15143.43.camel@pasglop>
	<20090812111954.GB31596@zod.rchland.ibm.com>
	<4A90486C-8BF5-428C-9FD8-830D822C0D40@kernel.crashing.org>
	<1250112599.3587.21.camel@pasglop>
	<3A45394FD742FA419B760BB8D398F9ED59DE33@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Fri, 14 Aug 2009 19:29:09 +1000
Message-Id: <1250242149.24143.36.camel@pasglop>
Mime-Version: 1.0
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

On Thu, 2009-08-13 at 16:59 +0800, Li Yang-R58472 wrote:
> >Now, I know there is at least one person on earth 
> >contemplating sharing some drivers between PPC and ARM. I 
> >won't tell much more at this stage, but it makes sense in the 
> >grand scheme of things to see SoC vendors put similar IO cores 
> >into either PPC or ARM and providing that clock API is a good 
> >way to also allow these drivers to work since the drivers in 
> >questions make use of it.
> 
> Freescale USB UDC driver is another example that shared between PowerPC
> and ARM(i.mx).  Currently, the imx part of the driver uses clk API, but
> PowerPC part uses static initialization.  It will be better if we can
> unify the clk setting part of the driver.

I had a look at it looks like it uses the API in a way that would fit
nicely with my plans, ie, it should be possible to use the same driver
on both archs pretty much without changes provided the ppc platform
provides a clock source driver and hooks it up to the device-tree.

I'll work on some proof-of-concept implementation of the core bits
early next week.

Cheers,
Ben.
