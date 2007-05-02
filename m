Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F131EDDF90
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 05:04:18 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l42J4C4U010812
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 12:04:13 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l42J4CT1022457
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 14:04:12 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RFC: new device types in the device tree (RE: [PATCH] powerpc:
	Add EDAC platform devices for 85xx)
Date: Wed, 2 May 2007 12:04:11 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302D5E1A9@az33exm25.fsl.freescale.net>
In-Reply-To: <20070502011957.GA12876@localhost.localdomain>
References: <e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5DC6F@az33exm25.fsl.freescale.net>
	<567cddf8855d809f2e0c5b4101c2c15a@kernel.crashing.org>
	<20070502011957.GA12876@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net
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
> From: David Gibson [mailto:david@gibson.dropbear.id.au]=20
> Sent: Tuesday, May 01, 2007 8:20 PM
> To: Segher Boessenkool
> Cc: Yoder Stuart-B08248; linuxppc-dev@ozlabs.org;=20
> bluesmoke-devel@lists.sourceforge.net
> Subject: Re: RFC: new device types in the device tree (RE:=20
> [PATCH] powerpc: Add EDAC platform devices for 85xx)
>=20
> On Wed, May 02, 2007 at 02:34:45AM +0200, Segher Boessenkool wrote:
> > >> "name" =3D "memory-controller"
> > >> "compatible" =3D "fsl,85xx-memory-controller"
> > >> (or a more specific 85xx model if the controller
> > >> isn't identical across those chips)
> > >> No "device_type" at all, since there is no binding
> > >> for this kind of device.
> > >
> > > Is "no device_type" really the approach that should be
> > > taken?
> >=20
> > Yes.
> >=20
> > > booting-without-of.txt currently reads:
> > >
> > >    Every node which actually represents an actual device
> > >    (that is, a node which isn't only a virtual "container"
> > >    for more nodes, like "/cpus" is) is also required to
> > >    have a "device_type" property indicating the type of
> > >    node
> >=20
> > That is wrong, IMNSHO.
>=20
> I tend to agree. Device drivers should generally be searching on the
> "compatible" property, not "device_type".  Defining new device_type
> values isn't really of any use to the kernel, so we should just avoid
> it.

Right-- drivers search on "compatible".

But, don't we want to keep standardized sets of properties for
certain classes/types of devices?  Defining a standardized,
required set of properties for a "network", "rom", or "i2c"
class of device is helpful.  Without a standardized 'template'
of properties, developers may make up whatever properties they
want and things will work fine as long as the device tree and
driver are in sync.  It works, but you wind up with a plethora
of properties each describing the same thing.

Stuart



If we do away with device_type,
what is it that defines a particular node to be a certain class
of device.
