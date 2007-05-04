Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58972DDED9
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 01:29:33 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l44FTRJp004144
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 08:29:27 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l44FTQ33021045
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 10:29:27 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RFC: new device types in the device tree (RE: [PATCH] powerpc:
	Add EDAC platform devices for 85xx)
Date: Fri, 4 May 2007 08:29:26 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302D5E8A5@az33exm25.fsl.freescale.net>
In-Reply-To: <20070503001729.GB4331@localhost.localdomain>
References: <e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5DC6F@az33exm25.fsl.freescale.net>
	<567cddf8855d809f2e0c5b4101c2c15a@kernel.crashing.org>
	<20070502011957.GA12876@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5E1A9@az33exm25.fsl.freescale.net>
	<20070503001729.GB4331@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
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
> Sent: Wednesday, May 02, 2007 7:17 PM
> To: Yoder Stuart-B08248
> Cc: Segher Boessenkool; linuxppc-dev@ozlabs.org;=20
> bluesmoke-devel@lists.sourceforge.net
> Subject: Re: RFC: new device types in the device tree (RE:=20
> [PATCH] powerpc: Add EDAC platform devices for 85xx)
>=20
> On Wed, May 02, 2007 at 12:04:11PM -0700, Yoder Stuart-B08248 wrote:
> > =20
> >=20
> > > -----Original Message-----
> > > From: David Gibson [mailto:david@gibson.dropbear.id.au]=20
> > > Sent: Tuesday, May 01, 2007 8:20 PM
> > > To: Segher Boessenkool
> > > Cc: Yoder Stuart-B08248; linuxppc-dev@ozlabs.org;=20
> > > bluesmoke-devel@lists.sourceforge.net
> > > Subject: Re: RFC: new device types in the device tree (RE:=20
> > > [PATCH] powerpc: Add EDAC platform devices for 85xx)
> > >=20
> > > On Wed, May 02, 2007 at 02:34:45AM +0200, Segher=20
> Boessenkool wrote:
> > > > >> "name" =3D "memory-controller"
> > > > >> "compatible" =3D "fsl,85xx-memory-controller"
> > > > >> (or a more specific 85xx model if the controller
> > > > >> isn't identical across those chips)
> > > > >> No "device_type" at all, since there is no binding
> > > > >> for this kind of device.
> > > > >
> > > > > Is "no device_type" really the approach that should be
> > > > > taken?
> > > >=20
> > > > Yes.
> > > >=20
> > > > > booting-without-of.txt currently reads:
> > > > >
> > > > >    Every node which actually represents an actual device
> > > > >    (that is, a node which isn't only a virtual "container"
> > > > >    for more nodes, like "/cpus" is) is also required to
> > > > >    have a "device_type" property indicating the type of
> > > > >    node
> > > >=20
> > > > That is wrong, IMNSHO.
> > >=20
> > > I tend to agree. Device drivers should generally be=20
> searching on the
> > > "compatible" property, not "device_type".  Defining new=20
> device_type
> > > values isn't really of any use to the kernel, so we=20
> should just avoid
> > > it.
> >=20
> > Right-- drivers search on "compatible".
> >=20
> > But, don't we want to keep standardized sets of properties for
> > certain classes/types of devices?  Defining a standardized,
> > required set of properties for a "network", "rom", or "i2c"
> > class of device is helpful.  Without a standardized 'template'
> > of properties, developers may make up whatever properties they
> > want and things will work fine as long as the device tree and
> > driver are in sync.  It works, but you wind up with a plethora
> > of properties each describing the same thing.
>=20
> If there's an obvious new class, with common properties, then yes,
> sure.  But I don't think we need to feel impelled to think up new
> classes (and therefore a device_type value) for each new device. =20
>=20
> And even in the case of new classes, I think we might be best off
> waiting for a few devices to appear so we can tell what's really
> common information before we define the class's device_type and
> required properties.

I think this makes sense.  I have seen various new device_type=20
properties popping up that seem very generic.  They simply have
the standard list of "reg",  "compatible", "interrupts",
"interrupt-parent".

I think one thing that would be very helpful would be a=20
crisp list of what the standardized device_types are so
when people create new device trees they have a guideline.
I'll take a stab at adding a section to booting-without-of.txt
for this.

Stuart
