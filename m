Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Feb 2007 14:33:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Message-ID: <20070215033328.GA17554@localhost.localdomain>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<20070214232246.GE16279@localhost.localdomain>
	<fbff2510963c6c5bb9d5ccb0574f97b1@kernel.crashing.org>
	<20070215015316.GL16279@localhost.localdomain>
	<889579906c6fd096a82283d5a3a0227e@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <889579906c6fd096a82283d5a3a0227e@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 04:09:15AM +0100, Segher Boessenkool wrote:
> >> Yes.  UIC1 is not addressed via UIC0, and as such should
> >> not be a child of it; it should be a direct child of its DCR
> >> controller, just like UIC0.
> >
> > No, the DCR tree, like the interrupt tree in most cases, is
> > independent of the main tree structure.
> 
> Yes true; you can hang the UICs from somewhere under the
> "soc" node or whatever you want.  You need some way to
> distinguish separate identical devices though; you can't
> do it by device unit since your devices don't have any
> (they don't have a "reg" but only a "dcr-reg").  If you
> would hang them in a DCR tree, you could use the plain
> "reg" property instead of the "dcr-reg" property and
> all would be fine (if the DCR binding allows this -- and
> it better should, it is the standard OF addressing algorithm).

No, doesn't work.  The trouble is there are other devices that *do*
sit on the normal MMIO bus, but also have DCRs (MAL, POB, SDRAM
controller).  The DCR tree has to cut across the normal bus tree, like
the interrupt tree.

> However, my main point remains: the two interrupt controllers
> should be siblings in the device tree, since they are that on
> the hardware.

In what way are they "that on the hardware".  They're siblings on the
DCR tree, they're parent/child on the interrupt tree.  Given that
they're not on the MMIO tree at all, I see no strong reason to pick
one representation over another.  I picked the interrupt tree, because
it seemed to make as much or more logical sense as the other, and as a
bonus it makes the probing logic easier.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
