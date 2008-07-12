Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 45150DDE22
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 18:23:14 +1000 (EST)
Date: Sat, 12 Jul 2008 10:22:59 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [i2c] [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,
	otherwise kernel will oops
Message-ID: <20080712082259.GA16810@pengutronix.de>
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
	<20080711182323.GB15321@secretlab.ca> <4877ADF6.8070702@scram.de>
	<20080711191502.GA21847@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <20080711191502.GA21847@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2008 at 11:15:02PM +0400, Anton Vorontsov wrote:

> > Nope, it was a bug in the i2c documentation fixed recently:
>=20
> Nope? I'm looking into i2c-core.c:
>=20
> .. i2c_new_device(...)
> {
> 	client->irq =3D info->irq;
>=20
> Core will blindly pass irq, so clients should ensure that irq contains
> correct value. And as far as there is no common scheme of checking that
> "there is no irq specified", the most safe option is -1.

I wonder if -1 is really the safest; even kernel functions related to
irqs are not consistent if "irq" is int or unsigned int. So, -1 could
cause subtle signedness defects.

The whole "no irq" mess really needs to be cleared generally. It just
disturbed me that i2c_core was imposing -1, whilst some other subsystem
may have chosen 0. IMHO, subsystems like i2c should pass irqs
transparently. This is why I submitted the patch for i2c documentation.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIeGnjD27XaX1/VRsRArEiAJ9xfVOqDCtbNBdZwYcDEW7rV69+kACfeWzP
l8tV0MpEEcfv3agorJmyMP0=
=no9Z
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
