Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3775B7150
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Sep 2010 02:49:58 +1000 (EST)
Date: Fri, 3 Sep 2010 18:49:53 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH] powerpc/5200: tighten up ac97 reset timing
Message-ID: <20100903164953.GG4813@pengutronix.de>
References: <1283528722-15644-1-git-send-email-emillbrandt@dekaresearch.com>
	<20100903160209.GE4813@pengutronix.de>
	<0A40042D85E7C84DB443060EC44B3FD3254AA09E8E@dekaexchange07.deka.local>
	<20100903162224.GF4813@pengutronix.de>
	<0A40042D85E7C84DB443060EC44B3FD3254AA09E8F@dekaexchange07.deka.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD3254AA09E8F@dekaexchange07.deka.local>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Yes, but it is way more readable. Does the extra delay hurt? The value
> > of 7 looks a bit magic to me. Are you sure it will do for various
> > clock frequencies?
> >
>=20
> The reset is happening in the gpio spinlock, so I am trying to keep busy
> waiting to a minimum.  The magic value of 7 calculates to *roughly* 200ns
> with a system timebase of 33mhz.  This timebase drives the mpc5200(b) at
> its max clock speed of 400mhz, so slower frequencies should just extend t=
he
> delay, which is acceptable.  If you strongly object to the use of __delay
> I can change it to ndelay.

That might be a valid reason, dunno the details here. I'll leave the
final decision for Grant. If the use of __delay is acceptable, the
calculation that led to 7 should be explained, I think.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyBJzEACgkQD27XaX1/VRuyrQCfb7FPr50kPSfxVea1dkvhNtkm
T2sAni0vjjbyb9AHxV+IUOC3aVr4e4Tc
=svjT
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
