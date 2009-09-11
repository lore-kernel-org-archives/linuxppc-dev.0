Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6458BB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 21:48:01 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ED611DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 21:48:00 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8BBluQI027881
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 04:47:57 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n8BBnhaH024746
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 06:49:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH][v1] powerpc/85xx: Create dts for each core in CAMPmodefor
	P2020RDB
Date: Fri, 11 Sep 2009 17:17:50 +0530
Message-ID: <1BD5CFC378ED0946B688E0C9BA2EF0951FD33A@zin33exm24.fsl.freescale.net>
In-Reply-To: <20090910160233.GA24085@iram.es>
References: <1252573031-4157-1-git-send-email-poonam.aggrwal@freescale.com>
	<20090910093307.GA17117@iram.es>
	<1BD5CFC378ED0946B688E0C9BA2EF0951FD268@zin33exm24.fsl.freescale.net>
	<20090910160233.GA24085@iram.es>
From: "Aggrwal Poonam-B10812" <Poonam.Aggrwal@freescale.com>
To: "Gabriel Paubert" <paubert@iram.es>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Gabriel Paubert [mailto:paubert@iram.es]=20
> Sent: Thursday, September 10, 2009 9:33 PM
> To: Aggrwal Poonam-B10812
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH][v1] powerpc/85xx: Create dts for each=20
> core in CAMPmodefor P2020RDB
>=20
> On Thu, Sep 10, 2009 at 08:48:38PM +0530, Aggrwal Poonam-B10812 wrote:
> > =20
> >=20
> > > -----Original Message-----
> > > From: Gabriel Paubert [mailto:paubert@iram.es]
> > > Sent: Thursday, September 10, 2009 3:03 PM
> > > To: Aggrwal Poonam-B10812
> > > Cc: linuxppc-dev@ozlabs.org
> > > Subject: Re: [PATCH][v1] powerpc/85xx: Create dts for=20
> each core in=20
> > > CAMPmode for P2020RDB
> > >=20
> > > On Thu, Sep 10, 2009 at 02:27:11PM +0530, Poonam Aggrwal wrote:
> > > > This patch creates the dts files for each core and splits
> > > the devices
> > > > between the two cores for P2020RDB.
> > > >=20
> > > > core0 has memory, L2, i2c, spi, dma1, usb, eth0, eth1, crypto,=20
> > > > global-util, pci0
> > > > core1 has L2, dma2, eth0, pci1, msi.
> > >=20
> > > Surely you mean eth1 and eth2 for core0, no?
> > Yes you are right , I'll fix this.
> > >=20
> > > At least it's what I gather from the code.
> > >=20
> > > Also both cores have a node called serial0, at different=20
> addresses=20
> > > but with the same interrupt!
> > Yes both the UARTS use the same int line in shared mode.=20
> > >=20
> > > But in the mpic comment line there is "serial1", and=20
> interrupt 42 is=20
> > > the only number which appears in both lists of mpic protected=20
> > > interrupts.
> > I am not sure how to handle the shared interrupts in AMP scenario,=20
> > although this has been tested and both serials are working=20
> one on each=20
> > core.
>=20
> Ok, I wrongly understood protected interrupts as reserved for=20
> one core. However, I still dislike two devices having the same name.
>=20
> Otherwise it may work if every interrupt is delivered to both=20
> cores although statistically only one core will actually have=20
> some work to do. Doesn't the kernel complain about unhandled=20
> irqs however?=20
>=20
We don't see any such messages of unhandled interrupts, although I
checked the corresponding files for mpc8572ds, they do not have the
interrupts property for the serial ports at all, in both the core0 and
core1 dts.
Don't know the reason.
> 	Regards,
> 	Gabriel
>=20
> > > > +
> > > > +		serial0: serial@4500 {
> > > > +			cell-index =3D <0>;
> > > > +			device_type =3D "serial";
> > > > +			compatible =3D "ns16550";
> > > > +			reg =3D <0x4500 0x100>;
> > > > +			clock-frequency =3D <0>;
> > > > +			interrupts =3D <42 2>;
> > > > +			interrupt-parent =3D <&mpic>;
> > > > +		};
>=20
> > > > +
> > > > +		mpic: pic@40000 {
> > > > +			interrupt-controller;
> > > > +			#address-cells =3D <0>;
> > > > +			#interrupt-cells =3D <2>;
> > > > +			reg =3D <0x40000 0x40000>;
> > > > +			compatible =3D "chrp,open-pic";
> > > > +			device_type =3D "open-pic";
> > > > +			protected-sources =3D <
> > > > +			42 76 77 78 79 /* serial1 , dma2 */
> > > > +			29 30 34 26 /* enet0, pci1 */
> > > > +			0xe0 0xe1 0xe2 0xe3 /* msi */
> > > > +			0xe4 0xe5 0xe6 0xe7
> > > > +			>;
> > > > +		};
> > > > +
> > > > +
>=20
> > > > +		serial0: serial@4600 {
> > > > +			cell-index =3D <1>;
> > > > +			device_type =3D "serial";
> > > > +			compatible =3D "ns16550";
> > > > +			reg =3D <0x4600 0x100>;
> > > > +			clock-frequency =3D <0>;
> > > > +			interrupts =3D <42 2>;
> > > > +			interrupt-parent =3D <&mpic>;
> > > > +		};
> > > > +
> > > > +
>=20
> > > > +		mpic: pic@40000 {
> > > > +			interrupt-controller;
> > > > +			#address-cells =3D <0>;
> > > > +			#interrupt-cells =3D <2>;
> > > > +			reg =3D <0x40000 0x40000>;
> > > > +			compatible =3D "chrp,open-pic";
> > > > +			device_type =3D "open-pic";
> > > > +			protected-sources =3D <
> > > > +			17 18 43 42 59 47 /*ecm, mem,=20
> i2c, serial0, spi,gpio */
> > > > +			16 20 21 22 23 28 	/* L2,=20
> dma1, USB */
> > > > +			03 35 36 40 31 32 33 	/*=20
> mdio, enet1, enet2 */
> > > > +			72 45 58 25 		/*=20
> sdhci, crypto , pci */
> > > > +			>;
> > > > +		};
> > > > +
>=20
>=20
