Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C2CCB7154
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Sep 2010 02:22:28 +1000 (EST)
Date: Fri, 3 Sep 2010 18:22:24 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH] powerpc/5200: tighten up ac97 reset timing
Message-ID: <20100903162224.GF4813@pengutronix.de>
References: <1283528722-15644-1-git-send-email-emillbrandt@dekaresearch.com>
	<20100903160209.GE4813@pengutronix.de>
	<0A40042D85E7C84DB443060EC44B3FD3254AA09E8E@dekaexchange07.deka.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD3254AA09E8E@dekaexchange07.deka.local>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >> -       udelay(2);
> >> +       udelay(1);
> >>
> >>         /* Deassert reset */
> >>         setbits8(&wkup_gpio->wkup_dvo, reset);
> >>
> >> +       /* wait at least 200ns */
> >> +       __delay(7);
> >
> > ndelay(200)?
>=20
> Is ndelay defined for powerpc?  I was under the impression that it was
> being redefined to udelay in linux/delay.h.
>=20
> #ifndef ndelay
> static inline void ndelay(unsigned long x)
> {
>         udelay(DIV_ROUND_UP(x, 1000));
> }
> #define ndelay(x) ndelay(x)
> #endif

Yes, but it is way more readable. Does the extra delay hurt? The value
of 7 looks a bit magic to me. Are you sure it will do for various clock
frequencies?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyBIMAACgkQD27XaX1/VRvM7wCglLV8DnTQ9Dlx5HKSOLbieJs0
zBsAmwZgLGVpiqwQtgkva4s2YmS19qZZ
=BYQ1
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
