Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 813F9B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 22:08:34 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4F3EDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2009 22:08:33 +1000 (EST)
Subject: RE: ARM clock API to PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0908141255230.5980@axis700.grange>
References: <1250063825.15143.43.camel@pasglop>
	<20090812111954.GB31596@zod.rchland.ibm.com>
	<4A90486C-8BF5-428C-9FD8-830D822C0D40@kernel.crashing.org>
	<1250112599.3587.21.camel@pasglop>
	<3A45394FD742FA419B760BB8D398F9ED59DE33@zch01exm26.fsl.freescale.net>
	<1250242149.24143.36.camel@pasglop>
	<Pine.LNX.4.64.0908141255230.5980@axis700.grange>
Content-Type: text/plain
Date: Fri, 14 Aug 2009 22:07:44 +1000
Message-Id: <1250251664.24143.39.camel@pasglop>
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

On Fri, 2009-08-14 at 13:29 +0200, Guennadi Liakhovetski wrote:
> but since they are quite long, in short, in them a patch has been 
> discussed, that allowed to re-use an MMC driver, used on some MFDs, on 
> SuperH SoCs. The patch was taking the "easy route" of adding the 
> possibility to use the clock API to the tmio_mmc.c driver, while leaving 
> it to use static clock configurations with MFD drivers. This approach has 
> been rejected and initially it has been suggested to implement a 
> platform-independent clock API like what had been proposed by clocklib, 
> but since the future of clocklib is unclear, it has then been decided to 
> remove the clock (and power) management from the driver proper and move 
> them to some callbacks. I.e., there would be more users interested in a 
> unified clock API, including other platforms and platform-independent 
> drivers like MFD. Currently the reason, why MFD drivers cannot implement 
> their own clock devices is that the "struct clk" differs between 
> platforms.

But there is no reason for it to differ !

My idea is that struct clock would contain function pointers for the
enable/disable/get_rate/ etc... methods

Thus it's up to clk_get() to provide an object with the right pointers.

Now, on ARM, it's currently done in such a way that it's mostly up to
the platform (though that's less true with clkdev).

But with the help of the device-tree, it becomes trivial to have
somebody register clock providers (ie, objects that can product struct
clk *) and bind them to driver.

I think struct clk is the way to go. The problem is to sort out the
binding between the clock provider and the driver. The DT is an easy and
nice way to do it for archs that have it. But there are other ways.

Cheers,
Ben.
