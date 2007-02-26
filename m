Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 98470DDEE9
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 03:53:48 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l1QGrine011860
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 09:53:44 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1QGriZC016928
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 10:53:44 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: document new interrupt-array property
Date: Mon, 26 Feb 2007 09:53:43 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A59A28@az33exm25.fsl.freescale.net>
In-Reply-To: <20070226041646.GC29826@localhost.localdomain>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
	<20070222011811.GA18364@localhost.localdomain>
	<45b623f395654fc4f4920b9553794def@kernel.crashing.org>
	<20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
	<1172299259.1902.22.camel@localhost.localdomain>
	<20070226041646.GC29826@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
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
> Sent: Sunday, February 25, 2007 10:17 PM
> To: Benjamin Herrenschmidt
> Cc: Yoder Stuart-B08248; linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: Re: [PATCH] powerpc: document new interrupt-array property
>=20
> On Sat, Feb 24, 2007 at 07:40:59AM +0100, Benjamin=20
> Herrenschmidt wrote:
> > On Fri, 2007-02-23 at 12:15 -0700, Yoder Stuart-B08248 wrote:
> > > > I'd rather write it like
> > > >=20
> > > > >       interrupts        =3D < a 4   b 4   0 4   1 4   2 4 >
> > > > >       interrupt-parents =3D <&UIC0 &UIC0 &UIC1 &UIC1 &UIC1>
> > > >=20
> > >=20
> > > Segher, with your proposal here of an interrupt-parents property
> > > is this really keeping with the normal OF way of representing
> > > property values?
> > >=20
> > > Examples exists where one property tells you how to interpret
> > > or decode another (e.g. #address-cells), but your proposal we
> > > have two distinct properties each with values that together
> > > provide the complete 'value' (interrupt parent + interrupt
> > > specifier).  Is there any precedent for this approach?
> >=20
> > Somewhat... interrupt-map and interrupt-map-mask... that=20
> sort of thing.
> >=20
> > > I think I'd rather see all the information encoded in
> > > one value.
> >=20
> > On the other hand, I do quite like keeping with the old=20
> principle that
> > having interrupts =3D=3D having an "interrupts" node.
>=20
> That would be nice.  On the other hand, re-using interrupts means that
> it's possible to get a silent misparse of the interrupt information: a
> parser which doesn't understand the new 'interrupt-parents' property
> will encounter the node, see the 'interrupts' property, assume that
> the interrupt parent is the physical parent and, if the
> #interrupt-cells values match up, which is quite possible, assume that
> it has correctly understood the interrupt information.
>=20
> This is arguably a worse behaviour than simply having an old-style
> parser see the lack of 'interrupts' property and assume the device has
> no interrupts.

I agree that conceptually this is true.  However, in this particular
case, practically speaking, the only DTS files that would have
this new construct would some new 4xx ones.  If the updates to the
parser
and 4xx board support roughly go in at the same time we shouldn't
have many parser/DTS compatibility issues.

A new property here is really putting some infrastructure in place for
future DTS files.

Stuart
