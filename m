Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1384CDDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 11:25:27 +1100 (EST)
In-Reply-To: <20070222224809.GA15387@localhost.localdomain>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
	<20070222011811.GA18364@localhost.localdomain>
	<45b623f395654fc4f4920b9553794def@kernel.crashing.org>
	<20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<20070222224809.GA15387@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <740231a8bb5a4ec8f877b6a17dfdf8db@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Fri, 23 Feb 2007 01:25:19 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stuart Yoder <b08248@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> [Of course the #a value better be the same as the value
>> in the physical parent, and all nodes mapping via a
>> particular "interrupt-map" better have unique unit
>> address for that map].
>
> Right.  In other words, the addressing format of the interrupt-parent
> must match that of the physical parent,

Not just the addressing _format_, the _whole_
addressing (addresses need to be unique!)

> which breaks the usual
> disconnection between the interrupt tree and the main tree.

Well they aren't really disconnected anyway.  But yeah I
know what you mean, and it doesn't help constructing
elegant interrupt trees -- you often end up creating
lots of extra nexus nodes, just to get a couple of devices
at the same level.

> Or to
> look at it another way, the "reg" property is doubly constrained to
> make sense both in the main tree, and in the interrupt tree.

But in all cases where it makes sense to use the unit
address in an interrupt map, that map does sit in the
parent node in question so all is good.

> And
> really, the only way I can see it working other than by happy
> coincidence is if the interrupt-parent *is* the physical parent.

It works by having interrupt-controller nodes for
all interrupt controllers, and interrupt-nexus
nodes for all wacky routing / swizzling / whatever.
Since a nexus is a bunch of wires that aren't described
elsewhere in the tree you have to create a node for
it.  It's not physically addressable so you just have to
put it somewhere logical.  In the case of a PCI-PCI
bridge's "standard" swizzling for example, the bridge
node is a reasonable spot.  In many cases there is no
suitable already existing node so you just have to
create a new node.


Segher
