Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 7773CDDEC3
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 09:24:45 +1100 (EST)
Date: Tue, 13 Feb 2007 15:25:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] mpc5200 device tree bindings refinement
Message-ID: <20070213222535.GD8109@mag.az.mvista.com>
References: <528646bc0702091038k5188d83fsbc088d875472791c@mail.gmail.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA3029428E1@az33exm25.fsl.freescale.net>
	<20070212205731.GC2729@mag.az.mvista.com>
	<528646bc0702130737t2c4fdb1cj6b994d89c8652c9d@mail.gmail.com>
	<1171402877.20192.105.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171402877.20192.105.camel@localhost.localdomain>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 08:41:17AM +1100, Benjamin Herrenschmidt wrote:
> 
> > I am concerned that this ends up been premature optimization (of the
> > device tree).  Hardware designers are fickle people and like to change
> > shared registers between different chips.  I do agree that logically
> > the device is attached to a block of registers that can be described
> > in a separate node (child of the soc node).  But since we have no idea
> > if it's going to change in the next chip, it's probably better just to
> > describe it as the block-index on the soc.
> > 
> > Of course, I this begs the argument: "why do we describe anything
> > about an soc at all; why not just specify the SoC name/revision and be
> > done with it?"  I don't like that direction myself, but I do find it
> > non-trivial to find the sweet spot between minimal and "fully-loaded"
> > device trees.  That just highlights to me that this is just as much of
> > an art as it is science.  :)
> 
> Yeah. Let's keep it simple. For example, with EMAC, well, when you look
> at all the 4xx specs around, they all talk about EMAC 0, EMAC 1, ... and
> the registers that might have bits for all emacs around (like clock
> control) do the same.
> 
> Thus it makes sense to use a property like cell-index or block-index to
> identify which EMAC within an ASIC a given node refers to. I don't think
> it's justified to have a complex mecanism to describe those registers
> individual bits however.

Hrm, I think you guys misunderstood what I meant about bits within a
register.  I'm talking about a single 32-bit register where bits 0-7
are for ctlr 0, bits 8-15 are for ctlr 1, etc.

This presents the same problem as a block of registers where the register
at offset 0 is for ctlr 0, offset 0x4 is for ctlr 1, offset 0x8 is for
ctlr 0, offset 0xc for ctlr 1.  That sort of thing.

Marvell bridges do both.  The driver needs some sort of index so it
knows which ones to access.  'block-index' will do that.

Mark
