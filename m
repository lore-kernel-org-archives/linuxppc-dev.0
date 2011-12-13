Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 220CC1007D3
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2011 05:23:13 +1100 (EST)
Date: Tue, 13 Dec 2011 19:23:07 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH RESEND] gpio: mpc8xxx: don't allow input-only pins to be
 output for MPC5121
Message-ID: <20111213182307.GA2736@pengutronix.de>
References: <1323767568-9565-1-git-send-email-w.sang@pengutronix.de>
 <20111213181659.GA29243@ponder.secretlab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
In-Reply-To: <20111213181659.GA29243@ponder.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2011 at 11:16:59AM -0700, Grant Likely wrote:
> On Tue, Dec 13, 2011 at 10:12:48AM +0100, Wolfram Sang wrote:
> > Add a 5121-custom reject if an input-only pin is requested to be output
> > (see 18.3.1.1 in the refman). Also, rewrite mach-specific quirk setup to
> > consume less lines which scales better.
> >=20
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > ---
> >  drivers/gpio/gpio-mpc8xxx.c |   17 ++++++++++++-----
> >  1 files changed, 12 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> > index ec3fcf0..25dc736 100644
> > --- a/drivers/gpio/gpio-mpc8xxx.c
> > +++ b/drivers/gpio/gpio-mpc8xxx.c
> > @@ -115,6 +115,14 @@ static int mpc8xxx_gpio_dir_in(struct gpio_chip *g=
c, unsigned int gpio)
> >  	return 0;
> >  }
> > =20
> > +static int mpc5121_gpio_dir_out(struct gpio_chip *gc, unsigned int gpi=
o, int val)
> > +{
> > +	/* GPIO 28..31 are input only on MPC5121 */
> > +	if (gpio >=3D 28)
> > +		return -EINVAL;
> > +
> > +	return mpc8xxx_gpio_dir_out(gc, gpio, val);
> > +}
> >  static int mpc8xxx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpi=
o, int val)
>=20
> This actually caused a build failure.  mpc8xxx_gpio_dir_out() was used be=
fore
> it was declared.  I moved the symbol to immediately below and applied any=
way,
> but how did it compile for you?  Should I drop this patch until you retes=
t?

Huh, I am surprised as well. Will investigate tomorrow. Sorry for the
inconvenience.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7nmAsACgkQD27XaX1/VRtuWQCeMXeAVzoGuVcSdCOn5ZOjFO/f
ngMAoK5aYa7lR6ElC5sPQFZ1AAo18360
=oDhg
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
