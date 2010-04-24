Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F39EB7D4C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Apr 2010 11:24:34 +1000 (EST)
Date: Sat, 24 Apr 2010 03:24:27 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Initcall ordering
Message-ID: <20100424012427.GA21255@pengutronix.de>
References: <4BD1C317.5000909@mlbassoc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
In-Reply-To: <4BD1C317.5000909@mlbassoc.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gary,

(adding linux-i2c)

On Fri, Apr 23, 2010 at 09:56:07AM -0600, Gary Thomas wrote:
> I'm having trouble with the I2C devices on my 8347 platform.
> The problem is that I2C device probe() functions are only called
> once, as the I2C bus is being initialized (in this case fsl_i2c_init())
> I have 2 devices on this bus, one device gets it's initcall
> before fsl_i2c_init, the second one does not :-(  This means
> that the second device is never probed.

Can you try this patch?

=46rom: Wolfram Sang <w.sang@pengutronix.de>
Date: Sat, 24 Apr 2010 03:18:16 +0200
Subject: [PATCH] i2c/mpc: use subsys_initcall() to allow early usage of dev=
ices

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/i2c/busses/i2c-mpc.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index f1321f7..32a3bae 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -693,13 +693,12 @@ static int __init fsl_i2c_init(void)
 		       " of_register_platform_driver failed (%i)\n", rv);
 	return rv;
 }
+subsys_initcall(fsl_i2c_init);
=20
 static void __exit fsl_i2c_exit(void)
 {
 	of_unregister_platform_driver(&mpc_i2c_driver);
 }
-
-module_init(fsl_i2c_init);
 module_exit(fsl_i2c_exit);
=20
 MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvSSEsACgkQD27XaX1/VRt4qQCdFAd3qkfs+cMiEkjejXQrodTZ
ImQAoIXP73i5osPKvrzRxnggkVzZnt/W
=l3JI
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
