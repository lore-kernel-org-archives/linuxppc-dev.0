Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0EA30DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 22:27:22 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 04 Sep 2007 14:20:40 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <6858c7a36ed061265937daa7b14cc5ac@kernel.crashing.org>
Message-ID: <20070904122040.276440@gmx.net>
MIME-Version: 1.0
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<1188808900.5972.133.camel@localhost.localdomain>
	<ad58529dfd4a248ab904c2c5871258bf@kernel.crashing.org>
	<20070903101234.GA12212@localhost.localdomain>
	<20070903161156.306700@gmx.net>
	<6858c7a36ed061265937daa7b14cc5ac@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Tue, 4 Sep 2007 00:52:02 +0200
> Von: Segher Boessenkool <segher@kernel.crashing.org>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
> Betreff: Re: [RFC] AmigaOne device tree source v2

> >>> Yeah, PCI is a special case for Linux.  Maybe add a "pciclass,XXXX"
> >>> compatible property though, for good measure.  Anything else isn't
> >>> all that useful I think.
> > Wouldn't that be the same as the class-code property?
> 
> Sure, except it is a different property.  If you use the "class-code"
> thing, you really should implement _all_ of the PCI binding's required
> properties.  If you don't (since Linux doesn't use it anyway), it might
> still be nice to have a "compatible" property at least (since that is
> what is used for figuring out what device driver to use for this device
> node).  Linux doesn't currently use that either, so you don't have to,
> but you could put it there and it would make sense, that's all.
Okay, I'll add a compatible = "pciclass,0101"; property to the node.
BTW: It looks like the Pegasos II device tree defines device_type = "spi"
for the IDE controller. Is that correct?

> If those addresses really show up in the PCI BARs (most controllers
> don't do that in legacy mode), the kernel's own PCI probing will
> see it already; if they aren't in BARs, it is a bit tricky to encode
> that correctly in the "reg" (it's perfectly well-defined, just a bit
> hard to get it right).
These addresses show up in the PCI BARs of the VIA 686B IDE controller,
even if it is configured for compatible mode.

> There is no such thing as "interrupt 14 and 15" on PCI.  You can use
> the interrupt mapping recommended practice to show two interrupts
> (and their polarity, and how they are routed to the relevant interrupt
> controller) in the IDE node.
But I'll still need a quirk in the IDE driver, because it doesn't make
use of any interrupt routing information in the device tree. If so, I
can omit the whole IDE controller device node and simply rely on the
IDE driver's probe functions and the Pegasos IDE IRQ quirk.
I wonder how this issue will be handled for libata and the via-pata
driver, since IIRC this one doesn't contain the Pegasos IDE IRQ quirk.

Thanks,

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger
