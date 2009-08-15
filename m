Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 22750B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 22:44:33 +1000 (EST)
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5E19DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 22:44:31 +1000 (EST)
Date: Sat, 15 Aug 2009 13:43:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ARM clock API to PowerPC
Message-ID: <20090815124347.GB16112@flint.arm.linux.org.uk>
References: <1250063825.15143.43.camel@pasglop>
	<20090812111954.GB31596@zod.rchland.ibm.com>
	<4A90486C-8BF5-428C-9FD8-830D822C0D40@kernel.crashing.org>
	<1250112599.3587.21.camel@pasglop>
	<3A45394FD742FA419B760BB8D398F9ED59DE33@zch01exm26.fsl.freescale.net>
	<1250242149.24143.36.camel@pasglop>
	<Pine.LNX.4.64.0908141255230.5980@axis700.grange>
	<1250251664.24143.39.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250251664.24143.39.camel@pasglop>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: devicetree-discuss@lists.ozlabs.org, John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Torez Smith <torez@us.ibm.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 14, 2009 at 10:07:44PM +1000, Benjamin Herrenschmidt wrote:
> My idea is that struct clock would contain function pointers for the
> enable/disable/get_rate/ etc... methods

If you look at OMAP, doing that gets very expensive, both in terms of
number of lines of code, size of structure and maintainence thereof.
Neither does a 'clk_ops' structure containing all of the function
pointers work either for OMAP (OMAP has such a structure just for
enable and disable methods, of which there are about two or three to
chose from, but the rounding, set_rate and propagation methods are
per-clk.  This balance seems to work well for OMAP.)

FYI, there are 140 struct clk definitions for OMAP24xx, and 215 for
OMAP34xx, all statically initialized.  See arch/arm/mach-omap2/clock?4xx.h

-- 
Russell King
