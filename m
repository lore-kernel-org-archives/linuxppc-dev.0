Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1E8767BEC
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 00:19:12 +1100 (EST)
In-Reply-To: <89216897-DF66-4C4E-9436-BD7816424139@schihei.de>
References: <20061207172259.64168f8c@localhost>
	<200612090100.09380.arnd@arndb.de> <4579FE4F.8000206@acm.org>
	<200612091244.05862.arnd@arndb.de>
	<89216897-DF66-4C4E-9436-BD7816424139@schihei.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1F172C93-90F5-48E5-88D7-4D0BC0E1841A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Mon, 11 Dec 2006 14:18:36 +0100
To: Heiko J Schick <info@schihei.de>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Arnd Bergmann <arnd@arndb.de>, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> We have to include the IPMI information in a way which can be used
> for controllers which are accessed via memory mapped or legacy I/O.

How to access registers is implicit in the device tree;
just look at the parent bus, it knows how to do it, given
the "reg" value in your device.

> (2)
> name = ipmi
> device_type

device_type = ipmi-kcs

There's no real reason to include the IPMI version number
in here, if you really need the version it's trivial to
probe for; it's not a property of the hardware but of the
software on the controller (unless some day the IPMI spec
breaks backwards compatibility, of course).

> regs = <addr> <len>
> reg-spacing = <number>
> reg-size = <number>
> reg-shift = <number>
>
> The main difference between (1) and (2) is that (2) will represent
> the whole register region within the reg property.

Which is the proper thing to do.  The "reg" property should
describe all of the address space your device listens to.
Some IPMI-KCS devices listen to just the two registers, some
listen to an 8-reg block, some to a 16-reg block.

> Because of that
> you have to include additional properties.

Yes, since the device driver needs some additional information.
This is quite natural and logical.  Trying to do some clever
workaround will only come back to bite you later.

> In (1) you will include every register (e.g. Cmd / Status, Data_In /
> Data_Out, etc.) within the reg property. The values for reg-spacing
> are calculated by subtracting addr2 - addr1. The reg-size are the
> len's within the reg property.

This is giving additional semantics to the "reg" property
that is compatible to its standard semantics for "standard"
IPMI-KCS devices (which don't really _need_ that extra info,
those are the default values); however, they will not be
compatible for some (future) "special" devices.

> Personally I prefer (1), because I a the moment I don't seea big
> benefit in (2). For both options of have to implement source code

You shouldn't be thinking "how does Linux use the device tree";
you should think "how does the device tree describe the hardware".

> which checks the compatible node to get the used interface type.
> According to the emitted interface type you have to read in (1) two
> or three registers from the reg property.

The "reg" property has some semantics independent of the device
node it is in, too -- only dependent on that device's parent
bus.  Don't break that :-)


Segher
