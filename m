Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 9DBC4DDE0A
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 18:00:16 +1000 (EST)
Date: Sat, 12 Jul 2008 10:00:04 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [i2c] [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,
	otherwise kernel will oops
Message-ID: <20080712080004.GA16739@pengutronix.de>
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
	<20080711182323.GB15321@secretlab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
In-Reply-To: <20080711182323.GB15321@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2008 at 12:23:23PM -0600, Grant Likely wrote:
> On Fri, Jul 11, 2008 at 09:48:59PM +0400, Anton Vorontsov wrote:
> > Firstly kernel warns at set_irq_chip, and then dies completely:
> >=20
> > Trying to install chip for IRQ-1
> >
> > diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> > index b2ccdcb..95a24de 100644
> > --- a/drivers/of/of_i2c.c
> > +++ b/drivers/of/of_i2c.c
> > @@ -93,10 +93,8 @@ void of_register_i2c_devices(struct i2c_adapter *ada=
p,
> >  		if (info.irq =3D=3D NO_IRQ)
> >  			info.irq =3D -1;
>=20
> What is the reason that info.irq is set to -1 in the first place?  This
> looks like another bug to me.  Does something in the i2c layer depend on
> the -1 value?
>=20

You already acked a fix to this :) I wasn't sure if my patch would
make it on its own, as Jon Smirl was also working on fixes to of_i2c.c
and he seemed to pick up this issue, too.

(Original patch is here:
http://ozlabs.org/pipermail/linuxppc-dev/2008-June/058801.html
)

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIeGSED27XaX1/VRsRAr+EAJ948UwobnY7WSSR4i/ywjof1+8dJACfWzPN
bhW6NXgBCnwqITIC5rSXeAI=
=W3sj
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
