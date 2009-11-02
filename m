Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 55C66B7C3D
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 05:40:28 +1100 (EST)
Date: Mon, 2 Nov 2009 19:40:23 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mpc512x/clocks: initialize CAN clocks
Message-ID: <20091102184023.GB3805@pengutronix.de>
References: <1256925231-21917-1-git-send-email-w.sang@pengutronix.de>
	<1257175056-26093-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40911021002x6d895606s57bca0f9fdd4e81b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
In-Reply-To: <fa686aa40911021002x6d895606s57bca0f9fdd4e81b@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Chen Hongjun <hong-jun.chen@freescale.com>,
	John Rigby <jrigby@freescale.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> These clock controllers are 1:1 dedicated to the CAN devices, correct?

Yes.

>  Wouldn't it make more sense to put this code directly into the CAN
> bus device driver instead of in common code?  And allocated the clk
> structure at driver probe time?

Yes, just...

> It seems like the only shared bit seems to be access to the mccr register=
s.

=2E..we can't access registers from two drivers?? Ah, wait, you are probably
aiming at moving the mscan_init-function to the can-driver and to expose the
mscan_calc_rate function from here? That sounds good in deed, will update!

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrvJ5cACgkQD27XaX1/VRuk5gCfYWhjsYAEHPLn5UlfaBfXsPXk
p48AnAxmSolsyXS7wC6y99SdiHtZ+gof
=1Kc4
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
