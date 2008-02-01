Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F796DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 15:51:54 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m114pOYk020423
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 21:51:39 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m114pMaP001916
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 22:51:23 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 1/2] Add RapidIO node into MPC8641HPCN dts file
Date: Fri, 1 Feb 2008 12:51:21 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AEBD08DB@zch01exm26.fsl.freescale.net>
In-Reply-To: <47A1F73E.3090600@freescale.com>
References: <12017656032841-git-send-email-wei.zhang@freescale.com>
	<47A1F73E.3090600@freescale.com>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Loeliger Jon" <jdl@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Jon,=20

> -----Original Message-----
> From: Loeliger Jon=20
>=20
> Zhang Wei wrote:
> > Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/mpc8641_hpcn.dts |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts=20
> b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> > index 556a9ca..1a0fce5 100644
> > --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> > +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> > @@ -25,6 +25,7 @@
> >  		serial1 =3D &serial1;
> >  		pci0 =3D &pci0;
> >  		pci1 =3D &pci1;
> > +		rapidio0 =3D &rapidio0;
> >  	};
> > =20
> >  	cpus {
> > @@ -499,4 +500,16 @@
> >  				  0 00100000>;
> >  		};
> >  	};
> > +
> > +	rapidio0: rapidio@f80c0000 {
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		compatible =3D "fsl,rapidio-delta";
> > +		reg =3D <f80c0000 20000>;
> > +		ranges =3D <0 0 c0000000 0 20000000>;
> > +		interrupt-parent =3D <&mpic>;
> > +		/* err_irq bell_outb_irq bell_inb_irq
> > +			msg1_tx_irq msg1_rx_irq	msg2_tx_irq=20
> msg2_rx_irq */
> > +		interrupts =3D <30 2 31 2 32 2 35 2 36 2 37 2 38 2>;
> > +	};
> >  };
>=20
> The 8641 DTS file has been converted to /dts-v1/ format now.
> Please rewrite this patch with explicit hex numbers for
> addresses, even if 0x0, and decimal for IRQs.
>=20
I have seen other nodes in mpc8641_hpcn.dts still use old style.
 Is it better to create an another new patch for correcting the style =
all?

Cheers!
Wei
