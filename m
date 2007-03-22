Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 17296DDFFE
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 02:58:48 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2MFwiJh027744
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 08:58:44 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2MFwitq022096
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 10:58:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Fwd: [PATCH Resend 01/02] Add Linux ASMP support for MPC8641D]
Date: Thu, 22 Mar 2007 08:58:43 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302B97FCD@az33exm25.fsl.freescale.net>
In-Reply-To: <9E7C3CAC-307E-44A9-9ACB-8A8B8C5B464C@kernel.crashing.org>
References: <1174573524.6595.509.camel@ld0161-tx32>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97F7C@az33exm25.fsl.freescale.net>
	<20070322155155.GA19903@lixom.net>
	<9E7C3CAC-307E-44A9-9ACB-8A8B8C5B464C@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, "Olof Johansson" <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
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
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Thursday, March 22, 2007 10:44 AM
> To: Olof Johansson
> Cc: Yoder Stuart-B08248; linuxppc-dev@ozlabs.org
> Subject: Re: [Fwd: [PATCH Resend 01/02] Add Linux ASMP=20
> support for MPC8641D]
>=20
>=20
> On Mar 22, 2007, at 10:51 AM, Olof Johansson wrote:
>=20
> > On Thu, Mar 22, 2007 at 08:32:33AM -0700, Yoder Stuart-B08248 wrote:
> >>
> >>> +		mpic: pic@40000 {
> >>> +			clock-frequency =3D <0>;
> >>> +			interrupt-controller;
> >>> +			#address-cells =3D <0>;
> >>> +			#interrupt-cells =3D <2>;
> >>> +			reg =3D <40000 40000>;
> >>> +			built-in;
> >>> +			compatible =3D "chrp,open-pic";
> >>> +			device_type =3D "open-pic";
> >>> +			big-endian;
> >>> +			interrupts =3D <
> >>> +			18 2 49 2 19 2
> >>> +			2a 2 2b 2 4a 1
> >>> +			1d 2 1e 2 22 2
> >>> +			23 2 24 2 28 2
> >>> +			>;
> >>> +		};
> >>> +	};
> >>> +};
> >>
> >> I think using the 'interrupts' property in this way is bad.  It's
> >> being used to tell the pic which interrupts belong to it.
> >>
> >> The problem is that the interrupts property is being overloaded
> >> and used for a completely different purpose than that which
> >> it was originally intended and documented.  Interrupt controllers
> >> should not have an interrupts property.
> >>
> >> The only reason I can see to do this is as a convenience to avoid
> >> walking the device tree.   The pic code should walk the device tree
> >> to determine the irq numbers the running core.
> >
> > Not speaking for the case of the freescale boards here, but not all
> > interrupts are in the device tree, nor do they have to.=20
> Especially for
> > PCI devices, etc.
> >
> > This is quite a special case. Having a brand new property=20
> for it might
> > be a good idea. It's a pretty big hack anyway, so adding another =20
> > one to
> > the device tree isn't that big a deal.
>=20
> I think the issue is you don't want the per interrupt registers =20
> initialized twice.  Thus I suggest we just let set_irq_type handle it.
>=20
> There is still an issue for shared interrupts, but I don't think you =20
> can solve that.  W/o moving the interrupt processing to some common =20
> level.

As I understand the patch, there are two DTS files once for each core
and each having a partitioned set of devices for that core.  In the=20
current patch the pic in each DTS has a unique 'interrupts' property.

This shouldn't be necessary-- to initialize the pic should simply be
a matter of each core walking it's device tree, which only has the
devices=20
assigned to it, and programming the pic appropriately.   No registers
should be programmed twice.

Stuart
