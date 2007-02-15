Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Feb 2007 12:53:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Message-ID: <20070215015316.GL16279@localhost.localdomain>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<20070214232246.GE16279@localhost.localdomain>
	<fbff2510963c6c5bb9d5ccb0574f97b1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fbff2510963c6c5bb9d5ccb0574f97b1@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 01:31:36AM +0100, Segher Boessenkool wrote:
> >>> No, they are cascaded in hardware.  I think having UIC1 under UCI0 
> >>> is a
> >>> correct representation.
> >>
> >> Only the interrupt routing is cascaded AFAICS, and
> >> there is a separate interrupt tree to express that.
> >
> > In the case of the UICs, I don't see that there's anything "only"
> > about the interrupt routing.  They're DCR controlled, and are not on
> > the normal bus.
> 
> Yes.  UIC1 is not addressed via UIC0, and as such should
> not be a child of it; it should be a direct child of its DCR
> controller, just like UIC0.

No, the DCR tree, like the interrupt tree in most cases, is
independent of the main tree structure.  The ultimate DCR parent is
the CPU node.  I see no reason to prefer the DCR connection over the
interrupt connection for the nesting here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
