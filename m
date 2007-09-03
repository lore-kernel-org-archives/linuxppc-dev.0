Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DEEEDDF6E
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Sep 2007 18:41:20 +1000 (EST)
Subject: Re: [RFC] AmigaOne device tree source v2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070903013431.GG31499@localhost.localdomain>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 03 Sep 2007 10:41:40 +0200
Message-Id: <1188808900.5972.133.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 'reg' and 'ranges' should not typically overlap.  'reg' should only
> encode control registers for the bridge, not the whole PCI space (not
> that I'm even entirely sure what you mean by that).
> 
> > 		ranges = <01000000 0 00000000 fe000000 0 00c00000	// PCI I/O
> > 			  02000000 0 80000000 80000000 0 7d000000	// PCI memory
> > 			  02000000 0 fd000000 fd000000 0 01000000>;	// PCI alias memory
> > 		8259-interrupt-acknowledge = <fef00000>;
> > 		#address-cells = <3>;
> > 		#size-cells = <2>;
> > 
> > 		host@0 {
> 
> The unit address (after the @) should be derived from the first range
> listed in the 'reg' property.  It's a bus address, not a slot number.

Actually... on PCI, the unit address is often the slot number, or
rather, "slot,function" with the second part ommited for non
multifunction devices.

> All these devices should have unit addresses.

 ... which for ISA are generally in the form iPORT (8242@i60 for
example) though I've seen the "i" ommited. Not terribly important I
would say but better to follow the spec.

> > 		ide@7,1 {
> 
> This will need a compatible property, at least.

Actually, it's a PCI device, it can have a compatible property based on
the generic PCI device compatible property generation as defined in the
OF PCI binding. Since that's just derived from other fields, I suppose
it can be omitted in a flat DT. It would be -nice- to have a more
explicit cpmpatible property but in that case, not absolutely necessary
since that device will be probed as PCI anyway.

Ben.
