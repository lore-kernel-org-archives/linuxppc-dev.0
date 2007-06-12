Return-Path: <dgibson@ozlabs.org>
Date: Tue, 12 Jun 2007 14:42:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Message-ID: <20070612044246.GC4198@localhost.localdomain>
References: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 07, 2007 at 03:30:46PM +0200, Segher Boessenkool wrote:
> > Whatever Segher says, I think it's fine to have the partition
> > information here.
> 
> It's nonsense to have it *inside that device node*.  I
> understand if you want to express it elsewhere.
> 
> > It may not be hardware information, but it is
> > (often) firmware information;
> 
> Only part of it is.  The rest should *not* be dictated
> by the firmware; for example, if a new OS image for
> the device needs different flash partition sizes, you
> would have to reflash the firmware!  Obviously less than
> ideal, and we can't have that kind of stuff in a more-
> or-less generic device tree binding.
> 
> > there are plenty precedents for things
> > like this in the device tree and it doesn't get in the way of any real
> > hardware information.
> 
> There is plenty of precedent for putting stuff that
> is not configuration info for some OS in the device
> tree, yes -- like describing the flash region used
> by firmware code (as a subnode of the flash node,
> perhaps).  A "generic" (i.e., specific to the current
> implementation of linux-mtd) partition map is no such
> thing.

So, what you're suggesting is a subnode for each described partition?
Seems an awfully verbose way of going about it, and I don't see what
it buys us over the partitions/partition-names pair of properties.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
