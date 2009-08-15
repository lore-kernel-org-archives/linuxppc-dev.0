Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2CE0EB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 16 Aug 2009 08:18:51 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83CB7DDD0B
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Aug 2009 08:18:50 +1000 (EST)
Subject: Re: ARM clock API to PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20090815124347.GB16112@flint.arm.linux.org.uk>
References: <1250063825.15143.43.camel@pasglop>
	<20090812111954.GB31596@zod.rchland.ibm.com>
	<4A90486C-8BF5-428C-9FD8-830D822C0D40@kernel.crashing.org>
	<1250112599.3587.21.camel@pasglop>
	<3A45394FD742FA419B760BB8D398F9ED59DE33@zch01exm26.fsl.freescale.net>
	<1250242149.24143.36.camel@pasglop>
	<Pine.LNX.4.64.0908141255230.5980@axis700.grange>
	<1250251664.24143.39.camel@pasglop>
	<20090815124347.GB16112@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 16 Aug 2009 08:18:03 +1000
Message-Id: <1250374683.24143.69.camel@pasglop>
Mime-Version: 1.0
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

On Sat, 2009-08-15 at 13:43 +0100, Russell King wrote:
> On Fri, Aug 14, 2009 at 10:07:44PM +1000, Benjamin Herrenschmidt wrote:
> > My idea is that struct clock would contain function pointers for the
> > enable/disable/get_rate/ etc... methods
> 
> If you look at OMAP, doing that gets very expensive, both in terms of
> number of lines of code, size of structure and maintainence thereof. 

Well, it depends. Having the function pointer or ops structure allows
you to use different function pointers/ops per clock ... but doesn't
force you to do so :-)

For example, in the OMAP case, you could just have one struct
omap_soc_clk_ops for example that contains the existing implementations
going through the existing table etc... 

But having the func. pointers allow designers to still use struct clk
for other clock sources if they wish to, which is pretty much precluded
if they link straight into the arch.

This cover two things: external clock sources (i2c PLLs etc...) used to
clock devices, and big combo-devices that have their own sets of clocks
and subsystems that may want to use the clk API separately from the main
SoC and platform code. 

For ppc we really don't have much of a choice here anyway because we
support multiple platforms compiled in the same kernel as long as they
have a CPU core that's the same overall family, and that can be very
wide. For example, 440-type cores can exist in all sort of IBM/AMCC
cores, but also Xilinx FPGAs, and when you start saying FPGA the
possibilities go wild :-)

> Neither does a 'clk_ops' structure containing all of the function
> pointers work either for OMAP (OMAP has such a structure just for
> enable and disable methods, of which there are about two or three to
> chose from, but the rounding, set_rate and propagation methods are
> per-clk.  This balance seems to work well for OMAP.)
> 
> FYI, there are 140 struct clk definitions for OMAP24xx, and 215 for
> OMAP34xx, all statically initialized.  See arch/arm/mach-omap2/clock?4xx.h

I had a look, and it doesn't appear to be a huge deal either way. In the
relatively minor detail as to use fun. pointers vs, ops, the func
pointers may win the OMAP case becaues ops would require pretty much
allocating & populating a new ops structure for each clock ... unless
you have one standard one whose set_rate that calls back into the table
via another function pointer ;-) but then it depends how hot those code
path are.

I might initially go with flat function pointers in struct clk on ppc
for now, and we'll see how things pan out.

Cheers,
Ben.
