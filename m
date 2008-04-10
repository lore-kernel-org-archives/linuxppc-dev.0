Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C64DDDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 16:39:42 +1000 (EST)
Date: Thu, 10 Apr 2008 08:39:35 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Question on mpc52xx_common.c
Message-ID: <20080410063935.GD13814@pengutronix.de>
References: <m21w5map5f.fsf@ohwell.denx.de>
	<fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>
	<47FAA0A8.7050602@genesi-usa.com>
	<200804080414.42867.arnd@arndb.de>
	<fa686aa40804071925v6c7d28edna529e6122fdc9cf7@mail.gmail.com>
	<23d2e4300804071926n57746a3cj551ef38bf10486c7@mail.gmail.com>
	<47FB3CD6.2090706@genesi-usa.com>
	<fa686aa40804080752g595196det8f576df1884bac5d@mail.gmail.com>
	<20080408194517.GX13814@pengutronix.de>
	<fa686aa40804081426u2c2a530ej8ecb6ce9f8fb49a0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <fa686aa40804081426u2c2a530ej8ecb6ce9f8fb49a0@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

On Tue, Apr 08, 2008 at 03:26:11PM -0600, Grant Likely wrote:
> I disagree and that is not my point.

Well, having something like a device tree that describes the hardware is
definitely a good thing, in general.

> Now, if out-of-tree ports continue to break then we've got a problem
> that needs to be fixed.

Right, that's the point. Don't get me wrong, I'm deeply against
maintaining large code bases out-of-tree. But it shows in this case that
we have a maintenance problem with the current oftree concept.

When a simple BSP that supports almost nothing than CPU, mem, serial
console and flash needs > 1 week of hacking from an experienced kernel
hacker, just in order to get all the string changes right, something is
wrong.

> Once a binding is established (which usually takes a few kernel
> releases) it should be very stable and even if the definition of ideal
> is changed, backwards compatibility must be maintained.

That's theory, but in practise we see it changing every second day.

> >  The ARM method of using just a device number is so much easier ...
>
> Only if the assumption is made that very little data needs to be
> shared between the kernel and the firmware. The moment you try to do
> something more complex you either have the nightmare of bd_info or you
> use a structured data format (like the device tree)

I agree that the usual ARM hardwares are much less complicated and
configurable than what's available elsewhere. We usually need the
information "this is board FOO_BAR", maybe, if it is a module, on a
"BAZ" baseboard, and this is everything we need to register the platform
devices in some arch/arm/mach-*/my_cpu.c and arch/arm/mach-*/my_board.c
file.

> On another node, there are platforms where a device number is
> unworkable. For example, for Linux on an FPGA like the Xilinx Virtex,
> there would need to be a new platform number every time the FPGA
> bitstream was updated because it is effectively an entirely different
> platform.

Well, we have done FPGA based boards with ARM in the past, and we've
just added hardware auto-detection to the IP cores.

> Finally, using a device number means you need to encode into the
> kernel the exact layout of every platform it supports.  That adds up
> to a lot of code in a real hurry; even if most of it is just
> boilerplate instantiations.

You are right in general. However, it doesn't change the fact that we
are living in maintenance-nightmare land right now ...

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
