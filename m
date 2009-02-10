Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 602D5DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 02:12:04 +1100 (EST)
Date: Tue, 10 Feb 2009 16:11:56 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for
	I2C to complete
Message-ID: <20090210151156.GA15678@pengutronix.de>
References: <1233928837-3401-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
In-Reply-To: <1233928837-3401-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, mditto@consentry.com,
	broonie@opensource.wolfsonmicro.com, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2009 at 08:00:37AM -0600, Timur Tabi wrote:
> The i2c_wait() function is using wait_event_interruptible_timeout() to wa=
it for
> the I2C controller to signal that it has completed an I2C bus operation. =
 If
> the process that causes the I2C operation terminated abruptly, the wait w=
ill
> be interrupted, returning an error.  It is better to let the I2C operation
> finished before the process exits.
>=20
> It is safe to use wait_event_timeout() instead, because the timeout will =
allow
> the process to exit if the I2C bus hangs.  It's also better to allow the
> I2C operation to finish, because unacknowledged I2C operations can cause =
the
> I2C bus to hang.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmRmTwACgkQD27XaX1/VRvD6gCghacTrahXacggGU1+ZWtk9yeJ
+BwAn0IpNXSVXfUM2XAVzdnomK4yOowT
=vZgE
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
