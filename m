Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 94927DDE1C
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 12:49:40 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5D2nXIu013862
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 19:49:34 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5D2nVtH024772
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 21:49:32 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/5] Add RapidIO sector to MPC8641HPCN board dts file.
Date: Wed, 13 Jun 2007 10:49:30 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C526D5D@zch01exm26.fsl.freescale.net>
In-Reply-To: <1181689112.9736.29.camel@pterry-fc6.micromemory.com>
References: <11816389393593-git-send-email-wei.zhang@freescale.com>
	<1181638939310-git-send-email-wei.zhang@freescale.com>
	<11816389401714-git-send-email-wei.zhang@freescale.com>
	<1181689112.9736.29.camel@pterry-fc6.micromemory.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: <pterry@micromemory.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Phil,

> > +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> > @@ -329,6 +329,19 @@
> >  				>;
> >  		};
> > =20
> > +		srio@c0000 {
> > +			device_type =3D "rapidio";
> > +			compatible =3D "fsl,rapidio-v1.0";
> > +			#address-cells =3D <2>;
> > +			reg =3D <c0000 20000>;
> > +			ranges =3D <0 0 c0000000 20000000>;
>=20
> Don't understand the range setup... The code uses c0000000 as=20
> the start
> and 20000000 as the size for the rapidio law. So whats the 0 0 for?=20
> At first I thought address-cells 2 means that the range numbers are
> pairs expressing 64-bit numbers, eg start 0 0, size c0000000 20000000
> but thats not right...
>=20

RapidIO address width is 34bits, so we use <2> for #address-cells.
"0 0" is the RapidIO bus address, since the #address-cells is 2, it's
double zero. "c0000000" is the parent bus address, which is memory
address. "20000000" is the size.
So, they means mapping the address of memory 0xc0000000 to RapidIO bus
address 0x0 and the size is 0x20000000.

> Sorry if I'm asking stupid questions....
>=20
> And thanks for the patch, just what I need.
>=20
> BTW do you have any notes/documentation on the space=20
> allocation routines
> intended use. I'm trying to work it out but I don't see any=20
> actual users
> of it yet... I need something like it for my distributed DMA driver,
> hence the interest.

Sorry, there is no documentation now. But I'll post an example for using
them.

>=20
> Cheers
> Phil
>=20
> > +			interrupt-parent =3D <&mpic>;
> > +			/* err_irq bell_outb_irq bell_inb_irq
> > +						msg1_tx_irq msg1_rx_irq
> > +						msg2_tx_irq=20
> msg2_rx_irq */
> > +			interrupts =3D <30 2 31 2 32 2 35 2 36 2=20
> 37 2 38 2>;
> > +		};
> > +
> >  		mpic: pic@40000 {
> >  			clock-frequency =3D <0>;
> >  			interrupt-controller;
>=20
>=20
>=20
