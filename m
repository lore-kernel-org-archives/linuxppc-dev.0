Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E03ACDDE00
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 08:12:26 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Wed, 14 Feb 2007 22:12:18 +0100
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I would use device_type "plb" (or "plb4") and "opb" I think.
>> Similar to how PCI and ISA etc. busses are represented.
>
> I think we should avoid making up new device_types unlesss it
> really is necessary.

In the case of peripheral busses there is significant
precedence though.  And it makes a lot of sense, too.

> Is it really necessary to distinguish between devices on
> the PLB or OPB?

This isn't about devices on the bus -- it is about the
bus itself.

> As I undestand it the "soc" device type is a logical container
> for a group of devices in an SOC, not necessarily a group
> of devices on the same bus.  Could we simply list all those
> devices under an "soc" node at the same level.

A "soc" node is meant to contain SoC specific stuff like
clock registers or whatnot.  It typically wouldn't have
child nodes.

> If for some reason the bus hierarchy distinction _is_ required,

It doesn't matter if you feel it is required.  You could in
principal list all devices as direct children of the root
node, if you take your argument to the extreme.  The device
tree is meant to reflect the physical hierarchy of the
devices in the system -- so it should show the PLB etc.
busses.  Maybe some day in the future the kernel can actually
make good use of the extra knowledge -- reconfigure something
about the PLB bus for example, who knows.  Also remember that
the device tree is *not* just for Linux, any argument that
says "Linux doesn't need this" is irrelevant.  And, again,
maybe Linux _could_ make good use of it.

> my suggestion would be to create new generic device type for
> representing an internal bus.   The "device_type" is supposed
> to be somewhat general-- "network", "serial", etc.

The device_type represents the programming model of the
device (programming model for OF).  Each type of bus has
its own programming model.  Your suggestion makes sense
for bus bridges that are 100% transparent -- same address
domain on both sides, completely identical ordering rules,
no configuration whatsoever.  I've never seen such a bus.

> The general philosophy is a general device_type prooperty and
> a specific compatible property.

For devices yes, but these aren't (endpoint) devices.


Segher
