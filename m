Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 3DCF8DDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 08:35:43 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1ELZcwq016078
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 14:35:39 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l1ELZc4L002746
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 15:35:38 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 15/16] Add device tree for Ebony
Date: Wed, 14 Feb 2007 14:35:37 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
In-Reply-To: <9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
	<9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]=20
> Sent: Wednesday, February 14, 2007 3:12 PM
[snip]
> > As I undestand it the "soc" device type is a logical container
> > for a group of devices in an SOC, not necessarily a group
> > of devices on the same bus.  Could we simply list all those
> > devices under an "soc" node at the same level.
>=20
> A "soc" node is meant to contain SoC specific stuff like
> clock registers or whatnot.  It typically wouldn't have
> child nodes.

That's not what booting_without_of.txt says.  It says:

    The SOC node may contain child nodes for each SOC
    device that the  platform uses.

All the dts files in arch/powerpc/boot/dts I've looked at have
an soc node with a whole bunch of devices under it.

The current practice seems to be that an "soc" node contains
all the on chip devices (regardless of the physical bus internal
to the soc).

> > If for some reason the bus hierarchy distinction _is_ required,
>=20
> It doesn't matter if you feel it is required.  You could in
> principal list all devices as direct children of the root
> node, if you take your argument to the extreme.  The device
> tree is meant to reflect the physical hierarchy of the
> devices in the system -- so it should show the PLB etc.
> busses.  Maybe some day in the future the kernel can actually
> make good use of the extra knowledge -- reconfigure something
> about the PLB bus for example, who knows.  Also remember that
> the device tree is *not* just for Linux, any argument that
> says "Linux doesn't need this" is irrelevant.  And, again,
> maybe Linux _could_ make good use of it.
>=20
> > my suggestion would be to create new generic device type for
> > representing an internal bus.   The "device_type" is supposed
> > to be somewhat general-- "network", "serial", etc.
>=20
> The device_type represents the programming model of the
> device (programming model for OF).

The device_type is typically things like "network" and "serial"
which don't specify the programming model.   The compatible=20
property is used in driver selection.=20

> Each type of bus has
> its own programming model.  Your suggestion makes sense
> for bus bridges that are 100% transparent -- same address
> domain on both sides, completely identical ordering rules,
> no configuration whatsoever.  I've never seen such a bus.

If the busses have different address domains and specific=20
configuration then I agree, they need their own unique device_type.

Do the ipb and opb busses have their own device driver similar to
PCI?

Stuart
