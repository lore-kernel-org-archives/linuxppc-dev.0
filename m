Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Sep 2007 12:48:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: [RFC] AmigaOne device tree source v2
Message-ID: <20070905024805.GE17189@localhost.localdomain>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
	<20070904114945.303440@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070904114945.303440@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2007 at 01:49:45PM +0200, Gerhard Pircher wrote:
> 
> -------- Original-Nachricht --------
> > Datum: Tue, 4 Sep 2007 00:32:57 +0200
> > Von: Segher Boessenkool <segher@kernel.crashing.org>
> > An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> > CC: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
> > Betreff: Re: [RFC] AmigaOne device tree source v2
> 
> > PCI memory space sits on the PCI bus, not on the PCI host bridge,
> > so is not part of "reg" but is part of "ranges" here, since it is
> > direct mapped into the host's address space.
> That's right, but what about this example here (from a Pegasos II):
> 
> /proc/device-tree/pci@80000000:
> name             "pci"
> linux,phandle    0fc59260 (264606304)
> bus-range        00000000 00000000
> pci-bridge-number 00000000
> reg              80000000 40000000
> 8259-interrupt-acknowledge f1000cb4
> ranges           01000000 00000000 00000000 fe000000 00000000 00010000
> 		 02000000 00000000 80000000 80000000 00000000 40000000
> clock-frequency  01fca055 (33333333)
> #size-cells      00000002
> #address-cells   00000003
> device_type      "pci"
> 
> AFAIU the reg property overlaps the ranges property for the PCI memory
> space from 0x80000000 to 0xC0000000 or the CPU address space at the
> same location!? Would be good to know, why it was defined like this.

That looks totally bogus.  Unlike Segher, I think there are a few
cases where overlapping reg and ranges can make sense (PCI bridges
where config space is accessed indirectly via MMIO registers which lie
in the legacy ISA IO space is an example).  But this doesn't look like
such a case - it just looks like whoever did the device tree
misunderstood the distinction between reg and ranges.

> > PCI legacy I/O is not direct mapped: there is no legacy I/O on a
> > PowerPC system bus.  So, it can not be mentioned in the "ranges"
> > property, but the PHB registers used to access it should be shown
> > in the "reg" property.  It could be a simple linear window (it
> > sounds like it is here?), but it could for example also be implemented
> > via an address/data register pair.

Err... huh?  The legacy IO space is assigned a block of addresses in
3-word "OF-PCI-space by the PCI binding.  When that is translated into
an MMIO range by the bridge, there's no reason that can't be encoded
into the ranges property.

> Yes, it is a simple linear address window. I'll remove its address range
> from the reg property.
> 
> > The order of the "reg" entries depends on the exact model of PCI
> > bridge, so a device binding for it has to be written.
> Only the Pegasos I and the AmigaOne use this PCI bridge. I guess it should
> be enough to check for the board type, but a compatible property doesn't
> hurt.

The whole damn point of the device tree is to avoid using this kind of
non-local information "I know what the board type is over there, so it
must be this PCI bridge over here".  The node should have a compatible
property which is sufficient to select the right bridge driver.

I think this is typically badly done at the moment, simply because PCI
has historically been set up by the platform code, rather than by a
"host bridge driver" in the mould of other drivers.  I don't see that
changing real soon, but that doesn't mean we shouldn't at least put
enough information in the device tree to make it possible.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
