Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 90FC5DDE3A
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 09:50:19 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1EMoFHI002451
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 15:50:15 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l1EMoFmT022170
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:50:15 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 15/16] Add device tree for Ebony
Date: Wed, 14 Feb 2007 15:50:14 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1B952@az33exm25.fsl.freescale.net>
In-Reply-To: <1171489360.20192.184.camel@localhost.localdomain>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
	<9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
	<1171489360.20192.184.camel@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
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
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
> Sent: Wednesday, February 14, 2007 3:43 PM
> To: Yoder Stuart-B08248
> Cc: Segher Boessenkool; linuxppc-dev@ozlabs.org; David Gibson
> Subject: RE: [PATCH 15/16] Add device tree for Ebony
>=20
> > der an "soc" node at the same level.
> > >=20
> > > A "soc" node is meant to contain SoC specific stuff like
> > > clock registers or whatnot.  It typically wouldn't have
> > > child nodes.
> >=20
> > That's not what booting_without_of.txt says.  It says:
> >=20
> >     The SOC node may contain child nodes for each SOC
> >     device that the  platform uses.
> >=20
> > All the dts files in arch/powerpc/boot/dts I've looked at have
> > an soc node with a whole bunch of devices under it.
>=20
> Wel, that was written by FSL not long ago :-)
>=20
> > The current practice seems to be that an "soc" node contains
> > all the on chip devices (regardless of the physical bus internal
> > to the soc).
>=20
> That's the current FSL practice yes. As I said, I'm not too=20
> fan of it. I
> prefer a more precise representation of the internal bus layout.

Hmm.  I haven't been around here that long and assumed that
the soc node was an approach arrived at after discussion and
debate in the PPC Linux community in general.

> > The device_type is typically things like "network" and "serial"
> > which don't specify the programming model.   The compatible=20
> > property is used in driver selection.=20
>=20
> The device type specifies the programming model of the node=20
> for OF, that
> is the set of words the driver will provide to OF. So that's something
> we don't necessarily care much about for non-OF=20
> implementation but still
> we should avoid going too far from that model either (after all,
> somebody can very well want to use a real OF on a board with a SoC).
>=20
> The device type is also used by the kernel in some areas. For example,
> the spec specifies that PCI host controllers and P2P bridges have a
> device-type of "pci" and the kernel relies heavily on that. Same for
> ISA. It thus makes sense to continue that practice with other=20
> bus types.

Do we need to re-open up the discussion about how to represent
SOCs in the device tree?  Does it matter?  Or, just have different
vendors do it their own way?

Some consistency would be good in my opinion.

Stuart
