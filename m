Return-Path: <wsa@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 21132B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 03:14:19 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 03FC9DDD1C
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 03:14:17 +1000 (EST)
Date: Sun, 14 Jun 2009 19:14:06 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: "Hans J. Koch" <hjk@linutronix.de>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
Message-ID: <20090614171406.GA1010@pengutronix.de>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
	<20090614122136.GD3639@local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
In-Reply-To: <20090614122136.GD3639@local>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Hans,

> > +	uioinfo->irq =3D irq_of_parse_and_map(op->node, 0);
> > +	if (!uioinfo->irq)
> > +		uioinfo->irq =3D UIO_IRQ_NONE;
>=20
> Please don't do this. It's inconsistent if all other UIO drivers require
> people to use UIO_IRQ_NONE and you also allow zero. UIO_IRQ_NONE was
> introduced because 0 may be a legal interrupt number on some platforms.

Yes, well, the '0' vs. 'NO_IRQ' thing is still not fully sorted out AFAIK. =
But
you are possibly right here, as long as irq_of_parse_and_map does return
NO_IRQ, I should explicitly check for it, like this:

	if (uioinfo->irq =3D=3D NO_IRQ)
		uioinfo->irq =3D UIO_IRQ_NONE;

> > +/* Match table for of_platform binding */
> > +static const struct of_device_id __devinitconst uio_of_genirq_match[] =
=3D {
>=20
> checkpatch.pl complains about that. Please check.

Did that, it is a false positive. See here:

http://lkml.indiana.edu/hypermail/linux/kernel/0906.1/02780.html

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko1L94ACgkQD27XaX1/VRsKRwCgkV+etCy/P9oVMZy21qFkhDpW
rlYAoLiY/tAj0womxa/gTg4pkEdXWp/t
=/oK2
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
