Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 974D8DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 18:14:57 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l5D8Epus005377
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 01:14:52 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l5D8Emap008376
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 03:14:49 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/5] Add the explanation and sample of RapidIO DTS sector
	to the document of booting-without-of.txt file.
Date: Wed, 13 Jun 2007 16:14:44 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C526DD9@zch01exm26.fsl.freescale.net>
In-Reply-To: <39c7d60cebf03badd106d7f75a08f449@kernel.crashing.org>
References: <11816389393593-git-send-email-wei.zhang@freescale.com>
	<1181638939310-git-send-email-wei.zhang@freescale.com>
	<39c7d60cebf03badd106d7f75a08f449@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Segher,=20

> -----Original Message-----
> Subject: Re: [PATCH 1/5] Add the explanation and sample of=20
> RapidIO DTS sector to the document of booting-without-of.txt file.
>=20
> > +   k) RapidIO
> > +
> > +   Required properties:
> > +
> > +    - device_type : Should be "rapidio"
>=20
> There is no OF binding, so no.

So, we need to define it.

>=20
> > +    - compatible : Should be "fsl,rapidio-v0.0" or=20
> "fsl,rapidio-v1.0"
> > +      and so on. The version number is got from IP Block Revision
> > +      Register of RapidIO controller.
>=20
> It's better to use real device names, just like everyone
> else.

Some silicons of Freescale processor are the same RapidIO controller,
such as mpc8540/mpc8560 are the same (v0.0), mpc8548/mpc8641 are the
same (v1.0). For v1.0 RapidIO controller, should we use mpc8548 or
mpc8641? Those will make people confused. Using IP Block Revision is a
clear choice.

>=20
> > +    - #address-cells : Address representation for=20
> "rapidio" devices.
> > +      This field represents the number of cells needed to represent
> > +      the RapidIO address of the registers.  For=20
> supporting more than
> > +      36-bits RapidIO address, this field should be <2>.
>=20
> More than 32 bit?

Yes, RapidIO bus address width is 34 bits.

>=20
> > +    - interrupt-parent : the phandle for the interrupt=20
> controller that
> > +      services interrupts for this device.
>=20
> Not required, depends on the interrupt tree of the system.
>=20
> > +    - interrupts : <a b> where a is the interrupt number and b is a
> > +      field that represents an encoding of the sense and level
> > +      information for the interrupt.
>=20
> No.  The format of an "interrupts" entry is defined by
> the interrupt domain this device sits in, not by the
> device itself.
>=20
Do you misunderstand the meaning of 'interrupts'? These interrupts is
issued from the RapidIO controller to the pic controller for tx, rx,
err, doorbell and message.


> > For this sector, interrupts order should be
> > +      <err_irq bell_outb_irq bell_inb_irq msg1_tx_irq msg1_rx_irq
> > +      msg2_tx_irq msg2_rx_irq ... msgN_tx_irq msgN_rx_irq>.
>=20
> That's to be defined in the binding for your specific device,
> not in a more generic rapidio binding.

These description is just for compatible=3D"fsl,rapidio-v*.*" rapidio
controller.

>=20
> > +		#address-cells =3D <2>;
>=20
> You want a #size-cells as well.
>=20

The size is not used in this sector, so no defined.

Thanks!
Wei.
