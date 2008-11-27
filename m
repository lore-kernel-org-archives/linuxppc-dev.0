Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id A4A33DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 07:50:13 +1100 (EST)
Date: Thu, 27 Nov 2008 21:30:48 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] mpc52xx/serial: fix error paths in probe function
Message-ID: <20081127203048.GA18994@pengutronix.de>
References: <1227800036-30109-1-git-send-email-w.sang@pengutronix.de>
	<9e4733910811270840w23214c91o4f8a141c245cb663@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
In-Reply-To: <9e4733910811270840w23214c91o4f8a141c245cb663@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Thu, Nov 27, 2008 at 11:40:55AM -0500, Jon Smirl wrote:

> > +       if (port->irq =3D=3D NO_IRQ) {
> > +               dev_err(&op->dev, "Could not get irq\n");
> > +               return -ENODEV;
> > +       }
>=20
> Doesn't NO_IRQ imply polling, not an error?

See below, I just copied the original behaviour. Having another look at
mpc52xx_uart_setup, I don't see any polling option there, so I think it
is correct to do this.

>=20
> >
> >        dev_dbg(&op->dev, "mpc52xx-psc uart at %p, irq=3D%x, freq=3D%i\n=
",
> >                (void *)port->mapbase, port->irq, port->uartclk);
> >
> > -       if ((port->irq =3D=3D NO_IRQ) || !port->mapbase) {
> > -               printk(KERN_ERR "Could not allocate resources for PSC\n=
");
> > -               return -EINVAL;
> > -       }

(Originaly dropout for NO_IRQ)

Regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkvA3gACgkQD27XaX1/VRvqqgCfQ2YIJ74UAB5jY3L5VZ3xZWUP
so4AnitdcnmvFnoYKFbvHZ3US+d4uVXl
=yzDp
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
