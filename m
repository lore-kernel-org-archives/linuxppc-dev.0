Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1F7BDDEF2
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 06:06:38 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9UJ6XWT021076
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 12:06:33 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9UJ6XuE008379
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 14:06:33 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RFC:  replace device_type with new "class" property?
Date: Tue, 30 Oct 2007 12:06:33 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3035F2872@az33exm25.fsl.freescale.net>
In-Reply-To: <20071030163343.GA4517@loki.buserror.net>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F278B@az33exm25.fsl.freescale.net>
	<20071030163343.GA4517@loki.buserror.net>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Wood Scott-B07421" <scottwood@freescale.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
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
> From: Wood Scott-B07421=20
> Sent: Tuesday, October 30, 2007 11:34 AM
> To: Yoder Stuart-B08248
> Cc: David Gibson; Olof Johansson; linuxppc-dev@ozlabs.org
> Subject: Re: RFC: replace device_type with new "class" property?
>=20
> On Tue, Oct 30, 2007 at 09:23:14AM -0700, Yoder Stuart-B08248 wrote:
> >   mpic: pic@40000 {
> >      clock-frequency =3D <0>;
> >      interrupt-controller;
> >      #address-cells =3D <0>;
> >      #interrupt-cells =3D <2>;
> >      reg =3D <40000 40000>;
> >      compatible =3D "fsl,xyz";
> >      big-endian;
> > }
> >=20
> > Note-- I removed the device_type property and changed
> > compatible somewhat.  How are you going to find where
> > the meaning interrupt controller's interrupt cells are
> > defined?   What spec will you look at?
>=20
> The binding for fsl,xyz.

Not every string listed in compatible has a spec=20
backing it (or should be required to).  You would
have to go look at the source code and cross your
fingers that the comments were sufficient.

Another good reason for device_type-- it helps=20
distinguish between two similar classes of devices.
Both "open-pic" and "isa-pic" look very similar but
have different encodings of their interrupt cells.
Without a device_type it may be difficult or impossible
to distinguish them unless the "name" and
"compatible" are luckily clear enough.

Stuart
