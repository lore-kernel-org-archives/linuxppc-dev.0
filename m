Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 11F1CDE1CD
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 03:57:16 +1000 (EST)
Date: Wed, 20 May 2009 19:57:06 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: mpc5200 fec error
Message-ID: <20090520175706.GA13287@pengutronix.de>
References: <20090519205706.GD27476@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBC@dekaexchange.deka.local>
	<fa686aa40905191636u6f4a23d0xc8c6c13904a65b8e@mail.gmail.com>
	<20090520064218.GA29102@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBE@dekaexchange.deka.local>
	<9e4733910905200814p63915ff8pf65614dbb8dc9adf@mail.gmail.com>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBF@dekaexchange.deka.local>
	<9e4733910905200829o423bf483h5b0b6dd202367872@mail.gmail.com>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEC0@dekaexchange.deka.local>
	<fa686aa40905200949q1fbeee8fy4b3a06d8e44d7c6b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <fa686aa40905200949q1fbeee8fy4b3a06d8e44d7c6b@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Yes, that sounds familiar.  Most likely, the value of the MDIO bus
> control register got clobbered and not reset when the FEC was reset.

I recall that I wondered about the RFIFO-error case back then. The manual s=
tates

=3D=3D=3D

Receive FIFO Error - indicates error occurred within the RX FIFO. When
RFIFO_ERROR bit is set, ECNTRL.ETHER_EN is cleared, halting FEC frame
processing. When this occurs, software must ensure both the FIFO Controller=
 and
BestComm are soft-reset.

=3D=3D=3D

It does not say that the whole FEC needs to be reset. (BTW doing a full FEC
reset in IRQ context caused OOPSes back then, have to dig up details, as it
doesn't seem to happen here...)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoURHIACgkQD27XaX1/VRvuDgCfY1rGjwYw4NxYhpbVtMLg6ND+
PDMAoIKI/Px7jxOHNPp0m+FIju0KGtWe
=U7x7
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
