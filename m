Return-Path: <dgibson@ozlabs.org>
Date: Mon, 3 Sep 2007 20:12:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
Message-ID: <20070903101234.GA12212@localhost.localdomain>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<1188808900.5972.133.camel@localhost.localdomain>
	<ad58529dfd4a248ab904c2c5871258bf@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ad58529dfd4a248ab904c2c5871258bf@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 03, 2007 at 12:02:58PM +0200, Segher Boessenkool wrote:
> >>> 		host@0 {
> >>
> >> The unit address (after the @) should be derived from the first range
> >> listed in the 'reg' property.  It's a bus address, not a slot number.
> >
> > Actually... on PCI, the unit address is often the slot number, or
> > rather, "slot,function" with the second part ommited for non
> > multifunction devices.
> 
> Not slot number, but "device-id".  Like, if you have actual
> PCI plugin slots on your board, they likely have device ids
> 16,17,...; but slot numbers 1, 2, 3 (little labels on the box).
> 
> David's point is that unit addresses are not random numbers.

You flatter me.  But i'll happily make that point, now that my
ignorance is slightly alleviated ;-).

> >> All these devices should have unit addresses.
> >
> >  ... which for ISA are generally in the form iPORT (8242@i60 for
> > example) though I've seen the "i" ommited. Not terribly important I
> > would say but better to follow the spec.
> 
> Omitting the "i" is perfectly in line with the spec :-)
> 
> >>> 		ide@7,1 {
> >>
> >> This will need a compatible property, at least.
> >
> > Actually, it's a PCI device, it can have a compatible property based on
> > the generic PCI device compatible property generation as defined in the
> > OF PCI binding. Since that's just derived from other fields, I suppose
> > it can be omitted in a flat DT. It would be -nice- to have a more
> > explicit cpmpatible property but in that case, not absolutely necessary
> > since that device will be probed as PCI anyway.
> 
> Yeah, PCI is a special case for Linux.  Maybe add a "pciclass,XXXX"
> compatible property though, for good measure.  Anything else isn't
> all that useful I think.

Indeed, since PCI is probable, it's unclear whether these device nodes
are even necessary at all.  Depends on whether there's anything
interesting in the omitted interrupt routing information.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
