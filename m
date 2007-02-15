Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DDFB6DDF39
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 11:10:59 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
	<9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a5fb5c16b8115bdcb34982645d4572b6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Thu, 15 Feb 2007 01:10:54 +0100
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

>>> As I undestand it the "soc" device type is a logical container
>>> for a group of devices in an SOC, not necessarily a group
>>> of devices on the same bus.  Could we simply list all those
>>> devices under an "soc" node at the same level.
>>
>> A "soc" node is meant to contain SoC specific stuff like
>> clock registers or whatnot.  It typically wouldn't have
>> child nodes.
>
> That's not what booting_without_of.txt says.  It says:
>
>     The SOC node may contain child nodes for each SOC
>     device that the  platform uses.

*May*.  There often is a better way to represent devices;
if they sit on some bus in reality, that's the best way
to describe them: by exposing that bus in the device tree.

> The current practice seems to be that an "soc" node contains
> all the on chip devices (regardless of the physical bus internal
> to the soc).

You can make the busses child nodes of the "soc" device
if you prefer.  I might even consider it good taste ;-)

>>> my suggestion would be to create new generic device type for
>>> representing an internal bus.   The "device_type" is supposed
>>> to be somewhat general-- "network", "serial", etc.
>>
>> The device_type represents the programming model of the
>> device (programming model for OF).
>
> The device_type is typically things like "network" and "serial"
> which don't specify the programming model.

The ___OF___ programming model, i.e. as you would use from
either of the client-, device- or user interface.  This
interface typically consists of a handful of properties
and device methods ("read", "seek", "max-transfer").

> The compatible
> property is used in driver selection.

For the OS, yes.

>> Each type of bus has
>> its own programming model.  Your suggestion makes sense
>> for bus bridges that are 100% transparent -- same address
>> domain on both sides, completely identical ordering rules,
>> no configuration whatsoever.  I've never seen such a bus.
>
> If the busses have different address domains and specific
> configuration then I agree, they need their own unique device_type.
>
> Do the ipb and opb busses have their own device driver similar to
> PCI?

Sigh.  Like I must have said 2**20 times now, it doesn't matter
if you currently have a certain Linux driver for something, nor
does it actually matter if there will ever be one.  I do know
that the OPB bus is different from the PLB bus and as such should
not be hidden.  Hey, it seems there are some DCR registers to
configure the thing if I remember the device tree that was posted
correctly.


Segher
