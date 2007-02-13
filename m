Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 659EBDDEC1
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 08:41:41 +1100 (EST)
Subject: Re: [RFC] mpc5200 device tree bindings refinement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0702130737t2c4fdb1cj6b994d89c8652c9d@mail.gmail.com>
References: <528646bc0702091038k5188d83fsbc088d875472791c@mail.gmail.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA3029428E1@az33exm25.fsl.freescale.net>
	<20070212205731.GC2729@mag.az.mvista.com>
	<528646bc0702130737t2c4fdb1cj6b994d89c8652c9d@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 08:41:17 +1100
Message-Id: <1171402877.20192.105.camel@localhost.localdomain>
Mime-Version: 1.0
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


> I am concerned that this ends up been premature optimization (of the
> device tree).  Hardware designers are fickle people and like to change
> shared registers between different chips.  I do agree that logically
> the device is attached to a block of registers that can be described
> in a separate node (child of the soc node).  But since we have no idea
> if it's going to change in the next chip, it's probably better just to
> describe it as the block-index on the soc.
> 
> Of course, I this begs the argument: "why do we describe anything
> about an soc at all; why not just specify the SoC name/revision and be
> done with it?"  I don't like that direction myself, but I do find it
> non-trivial to find the sweet spot between minimal and "fully-loaded"
> device trees.  That just highlights to me that this is just as much of
> an art as it is science.  :)

Yeah. Let's keep it simple. For example, with EMAC, well, when you look
at all the 4xx specs around, they all talk about EMAC 0, EMAC 1, ... and
the registers that might have bits for all emacs around (like clock
control) do the same.

Thus it makes sense to use a property like cell-index or block-index to
identify which EMAC within an ASIC a given node refers to. I don't think
it's justified to have a complex mecanism to describe those registers
individual bits however.

It's a matter of taste/common sense when faced with a given situation,
pick up the simplest thing that is a good enough solution for the
problem and will reasonably not rot as soon as the next chip is
released. On the other hand, don't try to solve problems you don't have
and fall into an over-engineering pitfall :-)

Ben.
