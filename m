Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Mar 2007 14:24:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 07/17] bootwrapper: Add dt_set_memory(),
	to fill in the /memory node.
Message-ID: <20070323032440.GD28006@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172848.GG29784@ld0162-tx32.am.freescale.net>
	<20070317012654.GE3969@localhost.localdomain>
	<c01196ee10aa2b13278465a835a49fdf@kernel.crashing.org>
	<20070321234226.GB2295@localhost.localdomain>
	<7ce9c69ae76258f47790c5ceb851a355@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7ce9c69ae76258f47790c5ceb851a355@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2007 at 12:02:56PM +0100, Segher Boessenkool wrote:
> >>> However, #address-cells=2, #size-cells=1 is common enough that we
> >>> really need to support that case.
> >>
> >> On the root node?!?  Who would do such a strange thing?
> >
> > Ebony, for one, it works nicely for a 32-bit system with >32-bit bus.
> 
> It means you cannot have a 4GB-or-bigger region below your
> root node.  Dunno if Ebony ever needs one, for I/O mapping
> perhaps?

Nope.  0-4GB is RAM, 4-8 is in-built IO, 8-12 is PCI IO, and I forget
what 12-16 is, if anything.

> > Apple G5s do it too.
> 
> And they do a an awful workaround for their memory node
> because of this.
> 
> Is their any reason why you couldn't use #a=#s=2 on 32-bit
> systems?  The root node is one contiguous hunk of address
> space, so the biggest (theoretically) possible size is equal
> to the biggest address (+1).  It's not hard to come up with
> an example where you need a size of 4GB or more.

Well, yes, we could.  I believe the only reason Apple does it is to
make the tree a little more compact.  But the point is that trees are
out there with #a=2 #s=1, so the fixup code ought to be able to handle
them.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
