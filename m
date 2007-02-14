Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Feb 2007 10:22:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Message-ID: <20070214232246.GE16279@localhost.localdomain>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6206de08b7f12175bebe669291c66334@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 06:58:04PM +0100, Segher Boessenkool wrote:
> >> Did you mean to have UIC1 nested under UIC0 or should
> >> they be at the same level?
> >
> > No, they are cascaded in hardware.  I think having UIC1 under UCI0 is a
> > correct representation.
> 
> Only the interrupt routing is cascaded AFAICS, and
> there is a separate interrupt tree to express that.

In the case of the UICs, I don't see that there's anything "only"
about the interrupt routing.  They're DCR controlled, and are not on
the normal bus.

> >> Hmm.  There are two "soc" devices here, one nested under the
> >> first??
> >>
> >> I'm assuming these are two levels of busses the opb bus is attached
> >> to the plb bus.  Is the "soc" device_type the right way to
> >> do this?
> >
> > Right, OPB hangs off of PLB in this case.  I dunno if "soc" is the 
> > right
> > device type for them though.
> 
> I would use device_type "plb" (or "plb4") and "opb" I think.
> Similar to how PCI and ISA etc. busses are represented.

Yeah, I've been pretty usnsure about this myself.  Using "soc" was
initially a hack to make the legacy serial detection stuff work, but I
think Arnd's of_platform serial stuff will deal with that better.

On the other hand, using separate device_type has no particular value,
either.  I wonder if we should have a general device_type for any
non-probeable, memory-mapped bus.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
