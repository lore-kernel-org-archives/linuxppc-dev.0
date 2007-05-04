Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AEFFFDDE2F
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 01:16:32 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l44FGQ0p002780
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 08:16:26 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l44FGP2E027426
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 10:16:26 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RFC: new device types in the device tree (RE: [PATCH] powerpc:
	Add EDAC platform devices for 85xx)
Date: Fri, 4 May 2007 08:16:25 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302D5E891@az33exm25.fsl.freescale.net>
In-Reply-To: <1624cd331b61117d7251f70caaa86292@kernel.crashing.org>
References: <20070425213700.GA8814@blade.az.mvista.com><20070426000852.GA2193@localhost.localdomain><20070426003748.GA30730@blade.az.mvista.com><9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org><4630D9AB.2040605@mvista.com>
	<e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5DC6F@az33exm25.fsl.freescale.net>
	<567cddf8855d809f2e0c5b4101c2c15a@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5E195@az33exm25.fsl.freescale.net>
	<1624cd331b61117d7251f70caaa86292@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au,
	bluesmoke-devel@lists.sourceforge.net
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
> Sent: Wednesday, May 02, 2007 7:48 PM
> To: Yoder Stuart-B08248
> Cc: Dave Jiang; linuxppc-dev@ozlabs.org;=20
> david@gibson.dropbear.id.au; bluesmoke-devel@lists.sourceforge.net
> Subject: Re: RFC: new device types in the device tree (RE:=20
> [PATCH] powerpc: Add EDAC platform devices for 85xx)
>=20
> >>> The 1275 spec is 'Open Firmware centric' in that it says
> >>> you don't need a device_type if the node is not used
> >>> by Open Firmware.
> >>
> >> It is "Open firmware centric" in every way; it is
> >> the Open firmware definition after all.
> >>
> >> "device_type" specifies what firmware interfaces a
> >> node implements.  "name" and "compatible" are for
> >> the client (i.e., OS, bootloader, etc.) to use for
> >> matching drivers to device nodes.
> >
> > The flat device tree standard (i.e. booting-without-of.txt)
> > certainly inherited stuff from IEEE-1275, but can diverge
> > if need be.
>=20
> It shares the kernel interface.  You cannot go diverge
> on fundamental things.
>=20
> > name is always optional (as defined by b-w-of.txt)
>=20
> Where does it say that?  "name" is always required!  In
> the newer flat tree format, it's even impossible to
> create a node without "name".

I'm specifically referring to the "name" property.  Here is
what booting-without-of.txt says:

   While earlier users of Open Firmware like OldWorld
   macintoshes tended to use the actual device name for
   the "name" property, it's nowadays considered a good
   practice to use a name that is closer to the device
   class (often equal to device_type)...[snip]... However,
   the kernel doesn't generally put any restriction on the
   "name" property; it is simply considered good practice
   to follow the standard and its evolutions as closely as
   possible.

   Note also that the new format version 16 makes the
   "name" property optional. If it's absent for a node, then
   the node's unit name is then used to reconstruct the name.
   That is, the part of the unit name before the "@" sign
   is used (or the entire unit name if no "@" sign is present).

If the name property is missing the kernel contructs it from
the unit name.  I guess my point is the name property implies
nothing and the kernel doesn't seem to care what name is used.
It certainly doesn't imply a required set of properties.

Stuart
