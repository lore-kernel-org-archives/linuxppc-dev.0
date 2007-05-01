Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73D9EDDF2A
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 01:11:44 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l41FBciS001351
	for <linuxppc-dev@ozlabs.org>; Tue, 1 May 2007 08:11:38 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l41FBbJi010311
	for <linuxppc-dev@ozlabs.org>; Tue, 1 May 2007 10:11:37 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RFC: new device types in the device tree (RE: [PATCH] powerpc: Add
	EDAC platform devices for 85xx)
Date: Tue, 1 May 2007 08:11:36 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302D5DC6F@az33exm25.fsl.freescale.net>
In-Reply-To: <e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
References: <20070425213700.GA8814@blade.az.mvista.com><20070426000852.GA2193@localhost.localdomain><20070426003748.GA30730@blade.az.mvista.com><9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org><4630D9AB.2040605@mvista.com>
	<e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Dave Jiang" <djiang@mvista.com>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	david@gibson.dropbear.id.au
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
> From: linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Segher Boessenkool
> Sent: Thursday, April 26, 2007 1:57 PM
> To: Dave Jiang
> Cc: linuxppc-dev@ozlabs.org; david@gibson.dropbear.id.au;=20
> bluesmoke-devel@lists.sourceforge.net
> Subject: Re: [PATCH] powerpc: Add EDAC platform devices for 85xx
>=20
> >>> +		mem-ctrl@2000 {
> >>> +			device_type =3D "mem-ctrl";
> >>> +			compatible =3D "85xx";
> >>>
> >> I'm concerned this is too generic.
> >>
> > I'm supposing not all 85xx uses the same soc? Is there=20
> something more
> > appropriate you can suggest? Thx!
>=20
> "name" =3D "memory-controller"
> "compatible" =3D "fsl,85xx-memory-controller"
> (or a more specific 85xx model if the controller
> isn't identical across those chips)
> No "device_type" at all, since there is no binding
> for this kind of device.

Is "no device_type" really the approach that should be
taken? =20

booting-without-of.txt currently reads:

   Every node which actually represents an actual device
   (that is, a node which isn't only a virtual "container"
   for more nodes, like "/cpus" is) is also required to
   have a "device_type" property indicating the type of
   node

The 1275 spec is 'Open Firmware centric' in that it says
you don't need a device_type if the node is not used
by Open Firmware.

What should the approach be for new device types that
keep popping up?   If the device type is generally useful
I think it makes sense to create a binding and add it to
booting-without-of.txt-- essentially documenting the
required properties, their values, and what they mean.

If it is vendor specific, that vendor should create some
vendors specific doc for their bindings--
Documentation/powerpc/fsl-of-dev-bindings.txt.

Comments?

Thanks,
Stuart Yoder
