Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3512DE17A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:41:43 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Thu, 17 Apr 2008 16:41:33 +0200
References: <47FDEF9B.5000506@semihalf.com>
	<200804171619.56615.jbe@pengutronix.de>
	<48075D4B.7030501@genesi-usa.com>
In-Reply-To: <48075D4B.7030501@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200804171641.33986.jbe@pengutronix.de>
Subject: Re: RFC: MPC5200 PSC AC97 driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 17 April 2008 16:23, Matt Sealey wrote:
> Hooray! :)
>
> Does it work, though, with your board?
>
> > -	u16		ccr;		/* PSC + 0x20 */
> > -	u8		reserved7[14];
> > +	u32		ccr;		/* PSC + 0x20 */
> > +	u32		ac97_slots;	/* PSC + 0x24 */
>
> I think it should be left noted here that the CCR size changed from
> 16 bits to 32 bits from 5200 to 5200B in order to reduce confusion.
> You may have read the manual but that does not mean that an extra
> small comment would not be appreciated by a lot of people (after
> all who would want to write code for a legacy 5200 device, write
> to psc->ccr and wonder why it explodes?)

Hmm, my board runs an MPC5200B. How can we solve this u16 versus u32 issue =
for=20
both CPUs?

In the oftree one need somthing like that:

		// PSC1 is ac97
		ac97@2000 {
			device_type =3D "sound";
			compatible =3D "mpc5200b-psc-ac97","fsl,mpc5200b-psc-ac97";
			cell-index =3D <0>; // or <1> if it is PSC2! Very important!
			reg =3D <2000 100>;
			interrupts =3D <2 2 0>;
			interrupt-parent =3D <&mpc5200_pic>;
		};

Don't know if it uses the current correct content.

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=C2=A0Pengutronix - Linux Solutions for Science and Industry
=C2=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=C2=A0 =C2=A0 =C2=A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
