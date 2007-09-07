Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Sep 2007 13:37:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in QE,
	register mmc_spi stub
Message-ID: <20070907033753.GC3082@localhost.localdomain>
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<6c73dab2fcf21490edc64b9b7ec52295@kernel.crashing.org>
	<46DCCE19.6050401@freescale.com>
	<3299c27fe2551315c6f5ecff3569f2e0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3299c27fe2551315c6f5ecff3569f2e0@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 04:13:56PM +0200, Segher Boessenkool wrote:
> >> This kind of thing is typically hardcoded into the firmware (just like
> >> the device tree is) -- just put it somewhere _next to_ the device 
> >> tree,
> >> not _in_ it.
> >
> > What is next to the device tree?
> 
> "Anywhere else in the firmware".
> 
> > AFAIK, there is no other standard data structure that could take place 
> > of the par_io nodes in the DTS.
> 
> The device tree is not a dumping ground for all your "I need some
> standard data structure" stuff.  Use an XML file if you have to ;-)

Actually, I think "I need a standard data structure" is well within
the purview of what we hoped the flat device tree could do.  We don't
have to follow IEEE1275 slavishly.

To isolate this sort of thing out from the device tree "proper", we
may wish to define some new "virtual" device nodes to go at the root
level (in the same way that /chosen and /aliases already have defined
purposes that don't involve describing real devices).

I can't speak specifically to the par_io nodes, because their function
was not obvious to me from my glance at the examples we have, and I
don't recall whatever previous discussions they were described in.

We do want, where possible, though, to make it unambiguous what things
are describing immutable facts about the hardware and what are hints
or startup configuration only.

> > I agree with your points, Segher, but replacing the par_io node with a 
> > bunch of par_io_config_pin() calls in the kernel is not really an 
> > improvement, I think.  Until we migrate the QE pin configuration code 
> > to U-boot, I suggest that we keep the device tree structure as-is and 
> > continue to use it for new code.  That way, it will all stay in one 
> > place.
> 
> Sure, some migration plan is in order, things won't change overnight.
> That doesn't mean you don't need to start planning _now_ ;-)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
