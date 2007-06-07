Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070606023939.GC8182@localhost.localdomain>
References: <20070601232022.GA21237@mag.az.mvista.com>
	<20070604205646.GD10612@mag.az.mvista.com>
	<20070606023939.GC8182@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Thu, 7 Jun 2007 15:30:46 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Whatever Segher says, I think it's fine to have the partition
> information here.

It's nonsense to have it *inside that device node*.  I
understand if you want to express it elsewhere.

> It may not be hardware information, but it is
> (often) firmware information;

Only part of it is.  The rest should *not* be dictated
by the firmware; for example, if a new OS image for
the device needs different flash partition sizes, you
would have to reflash the firmware!  Obviously less than
ideal, and we can't have that kind of stuff in a more-
or-less generic device tree binding.

> there are plenty precedents for things
> like this in the device tree and it doesn't get in the way of any real
> hardware information.

There is plenty of precedent for putting stuff that
is not configuration info for some OS in the device
tree, yes -- like describing the flash region used
by firmware code (as a subnode of the flash node,
perhaps).  A "generic" (i.e., specific to the current
implementation of linux-mtd) partition map is no such
thing.

> That said, I'm a bit dubious about the encoding of the RO/RW bit into
> the partition length (which I only just realised was used now).

Quite.

>> So, what should the DT look like for this thing?  And, what should
>> phymap_of.c be doing?

I think we want to define a binding for a "cfi-flash"
device, instead.


Segher
