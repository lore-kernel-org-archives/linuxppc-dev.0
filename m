Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50108DDF8D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 04:50:37 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l42IoV6N011556
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 11:50:31 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l42IoV2S000464
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 13:50:31 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RFC: new device types in the device tree (RE: [PATCH] powerpc:
	Add EDAC platform devices for 85xx)
Date: Wed, 2 May 2007 11:50:30 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302D5E195@az33exm25.fsl.freescale.net>
In-Reply-To: <567cddf8855d809f2e0c5b4101c2c15a@kernel.crashing.org>
References: <20070425213700.GA8814@blade.az.mvista.com><20070426000852.GA2193@localhost.localdomain><20070426003748.GA30730@blade.az.mvista.com><9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org><4630D9AB.2040605@mvista.com>
	<e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5DC6F@az33exm25.fsl.freescale.net>
	<567cddf8855d809f2e0c5b4101c2c15a@kernel.crashing.org>
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
> Sent: Tuesday, May 01, 2007 7:35 PM
> To: Yoder Stuart-B08248
> Cc: Dave Jiang; linuxppc-dev@ozlabs.org;=20
> david@gibson.dropbear.id.au; bluesmoke-devel@lists.sourceforge.net
> Subject: Re: RFC: new device types in the device tree (RE:=20
> [PATCH] powerpc: Add EDAC platform devices for 85xx)
>=20
> >> "name" =3D "memory-controller"
> >> "compatible" =3D "fsl,85xx-memory-controller"
> >> (or a more specific 85xx model if the controller
> >> isn't identical across those chips)
> >> No "device_type" at all, since there is no binding
> >> for this kind of device.
> >
> > Is "no device_type" really the approach that should be
> > taken?
>=20
> Yes.
>=20
> > booting-without-of.txt currently reads:
> >
> >    Every node which actually represents an actual device
> >    (that is, a node which isn't only a virtual "container"
> >    for more nodes, like "/cpus" is) is also required to
> >    have a "device_type" property indicating the type of
> >    node
>=20
> That is wrong, IMNSHO.
>=20
> > The 1275 spec is 'Open Firmware centric' in that it says
> > you don't need a device_type if the node is not used
> > by Open Firmware.
>=20
> It is "Open firmware centric" in every way; it is
> the Open firmware definition after all.
>=20
> "device_type" specifies what firmware interfaces a
> node implements.  "name" and "compatible" are for
> the client (i.e., OS, bootloader, etc.) to use for
> matching drivers to device nodes.

The flat device tree standard (i.e. booting-without-of.txt)
certainly inherited stuff from IEEE-1275, but can diverge
if need be.

The document currently defines the device_type property
to specify the class of device.  And it's required for
nodes describing a device.

name is always optional (as defined by b-w-of.txt)

There are no interfaces or methods with the device trees
defined in DTS files.  Given that, does the the device_type
property have any value at all?

There are a slew of device_types defined in the DTS files
and in booting-without-of.txt.  Should all these be
removed?


> It typically makes no sense to create a new "device_type"
> value for anything else than very generic classes of
> device, where you can drive the device without knowing
> anything else than what is defined in the binding for
> that "device_type".

What types devices get a device_type and which don't?  Linux
drives the devices based on "compatible".

> > What should the approach be for new device types that
> > keep popping up?   If the device type is generally useful
> > I think it makes sense to create a binding and add it to
> > booting-without-of.txt-- essentially documenting the
> > required properties, their values, and what they mean.
>=20
> And the associated methods and anything else that is
> needed.  It would be a big mistake to create incompatibilities
> with "real OF" where those can be avoided just as easily.

But there are no methods.

Even if the kernel does not use 'device_type', the property
still seems to have some value in that it specifies a
required set of properties and their values for various
classes of devices.

Take a flash device for instance--

        flash@ff000000 {
                device_type =3D "rom";
                compatible =3D "direct-mapped";
                probe-type =3D "CFI";
                reg =3D <ff000000 01000000>;
                bank-width =3D <4>;
                partitions =3D <00000000 00f80000
                              00f80000 00080001>;
                partition-names =3D "fs\0firmware";
        };

I suppose we can delete the device_type property and the
kernel will still be happy, but it's nice to have a standard
set of properties that everyone uses when describing a given
class of device.  The device_type is just a convenient
identifer to refer to this device class and set of properties.

Stuart
