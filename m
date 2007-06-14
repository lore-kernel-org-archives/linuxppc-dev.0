Return-Path: <dgibson@ozlabs.org>
Date: Thu, 14 Jun 2007 14:29:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Message-ID: <20070614042906.GC11177@localhost.localdomain>
References: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>
	<20070612044246.GC4198@localhost.localdomain>
	<9fbd7a7f5cdde58768569ab23c7aec7c@kernel.crashing.org>
	<20070613061254.GG16148@localhost.localdomain>
	<bc98b5372977d171b0075074bfce7747@kernel.crashing.org>
	<20070613091904.GA30948@localhost.localdomain>
	<791ab8b82c5b5d2b3ae4827a891a43ea@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <791ab8b82c5b5d2b3ae4827a891a43ea@kernel.crashing.org>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2007 at 11:37:42AM +0200, Segher Boessenkool wrote:
> >> How do non-device-tree MTD users handle this?
> >
> > Invidual, board-specific map files with hardcoded partition tables.
> 
> That's what I was afraid of.  Sigh.
> 
> > See drivers/mtd/maps/ebony.c for example.
> 
> [/me looks...]  Oh horror.
> 
> > Hence my view of the device
> > tree as a preferable option.
> 
> I think some binary partition table format that can be
> used by _all_ MTD consumers should be defined.  How
> that table should be communicated to the kernel in the
> device tree case we can discuss later, then.  Maybe
> something as simple as storing it in flash, and have a
> "partition-table-offset" property or something like that.
> 
> This is something the MTD people will have to buy into
> of course.

I tought I saw some config option implying that there already existed
an on-device partition table format for flashes.  Doesn't help us for
existing boards which don't expect such a setup, of course.

Incidentally, with either the partitions-described-by-properties, or
the revised more-flexible partitions-described-by-subnodes format, I'm
not seeing it as required that the whole of the flash address space be
described.  So it would certainly be possible to *only* describe the
sections of the flash used by firmware.  But I'm suggesting that we
optionally allow other partitions to be described for boards / systems
which have strong conventions about how the flash is divided and where
we don't have any other way of recording the partition layout short of
hardcoding.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
