Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Feb 2007 11:43:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] ppc: Add support for AMCC Taishan 440GX eval board
Message-ID: <20070213004322.GA4894@localhost.localdomain>
References: <200702121129.05004.sr@denx.de>
	<1171281988.20192.1.camel@localhost.localdomain>
	<ada7iun8bz3.fsf@cisco.com>
	<1171310108.20192.7.camel@localhost.localdomain>
	<E1HGhb3-0001fb-9M@jdl.com> <45D0CEC6.3010209@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D0CEC6.3010209@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	Stefan Roese <sr@denx.de>, Roland Dreier <rdreier@cisco.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 12, 2007 at 02:32:06PM -0600, Scott Wood wrote:
> Jon Loeliger wrote:
> > So, like, the other day Benjamin Herrenschmidt mumbled:
> > 
> >>Note that there are still things that we might want to change. For
> >>example, I think we really should look into adding a macro mecanism
> >>and/or an include mecanism to dtc so that we can do things like #include
> >><ibm440gp.dtc> to get the base processor/SoC definition and then
> >>"overlay" some properties on top of it (like emac phy mode etc...)
> > 
> > 
> > What do people prefer here?  Straight CPP pre-run?
> > Direct support built into dtc to do file-inclusion, macros?
> 
> Simple textual macros would make it difficult to define 123A and 123B 
> SoCs whose device tree nodes are mostly a generic 123, but require a few 
> changes in various parts.  I'd rather see dtc support overlaying trees, 
> with the "newer" tree able to add, modify, and remove nodes and 
> properties from the "older", more generic tree.

We'll certainly need both macros and overlaying trees.  Since SoC
nodes including external bus controllers in particular could have
entire board-dependent subtrees hanging off them a mere macro isn't
really sufficient.

Simple overlaying to add nodes, and/or add or replace properties is
pretty easy and natural to add.  Removing nodes or properties is
rather uglier and I'd like to avoid if possible.

More convenient overlaying, by say grafting to a given labelled node,
rather than having to reproduce step-by-step the path to the overlaid
node is more complex but should be doable.  The main thing is just
working out a sane syntax.

> Parametric macros (or "template" nodes) might be nice for a few things 
> on top of that, though (preferably with better syntax than CPP).

Yes, macros certainly want to be parametric.

I'm leaning towards the conclusion that CPP won't quite cut it, for a
handful of reasons.  But implementing macro and include support
directly in dtc strikes me as something which could suck up an
enormous amount of development.  I'm considering using m4.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
