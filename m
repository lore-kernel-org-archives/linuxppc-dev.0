Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2FFABDDE1E
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 08:52:20 +1000 (EST)
In-Reply-To: <20070903161156.306700@gmx.net>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<1188808900.5972.133.camel@localhost.localdomain>
	<ad58529dfd4a248ab904c2c5871258bf@kernel.crashing.org>
	<20070903101234.GA12212@localhost.localdomain>
	<20070903161156.306700@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6858c7a36ed061265937daa7b14cc5ac@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
Date: Tue, 4 Sep 2007 00:52:02 +0200
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Yeah, PCI is a special case for Linux.  Maybe add a "pciclass,XXXX"
>>> compatible property though, for good measure.  Anything else isn't
>>> all that useful I think.
> Wouldn't that be the same as the class-code property?

Sure, except it is a different property.  If you use the "class-code"
thing, you really should implement _all_ of the PCI binding's required
properties.  If you don't (since Linux doesn't use it anyway), it might
still be nice to have a "compatible" property at least (since that is
what is used for figuring out what device driver to use for this device
node).  Linux doesn't currently use that either, so you don't have to,
but you could put it there and it would make sense, that's all.

>> Indeed, since PCI is probable, it's unclear whether these device nodes
>> are even necessary at all.  Depends on whether there's anything
>> interesting in the omitted interrupt routing information.
> Well, I mainly specified the device node for the IDE controller, 
> because
> it works in compatible mode and thus the IDE driver needs to know about
> the I/O ports. I guess the driver doesn't probe the BARs, if the
> controller is configured for compatible mode (and AFAIK a VIA IDE
> controller cannot be made work in fully native mode).

Yeah most of those are nasty.

If the driver grabs some hardcoded legacy I/O ranges if the controller
is in legacy mode, the only thing that showing those ranges in the
"reg" property helps are _other_ parts of the kernel that might care,
not that driver since it hardcodes the address; and those other parts
of the kernel shouldn't care anyway, since _they_ shouldn't use any
hardcoded ranges either!

If those addresses really show up in the PCI BARs (most controllers
don't do that in legacy mode), the kernel's own PCI probing will
see it already; if they aren't in BARs, it is a bit tricky to encode
that correctly in the "reg" (it's perfectly well-defined, just a bit
hard to get it right).

> The interrupts for the IDE controller are another story. Judging from
> what some developers wrote on this mailing list, there doesn't seem to
> be a way to define legacy IDE interrupts (14 & 15) for a PCI device 
> node.

There is no such thing as "interrupt 14 and 15" on PCI.  You can use
the interrupt mapping recommended practice to show two interrupts
(and their polarity, and how they are routed to the relevant interrupt
controller) in the IDE node.


Segher
