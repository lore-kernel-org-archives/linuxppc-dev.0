Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 56D292C1462
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 22:31:54 +1000 (EST)
Message-ID: <51ED2619.5040107@pengutronix.de>
Date: Mon, 22 Jul 2013 14:31:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v3 11/31] net: can: mscan: improve clock API use
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-12-git-send-email-gsi@denx.de>
In-Reply-To: <1374495298-22019-12-git-send-email-gsi@denx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2OWONUNAQPXCRQRQQQQVW"
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>, David Woodhouse <dwmw2@infradead.org>,
 devicetree-discuss@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2OWONUNAQPXCRQRQQQQVW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/22/2013 02:14 PM, Gerhard Sittig wrote:
> the .get_clock() callback is run from probe() and might allocate
> resources, introduce a .put_clock() callback that is run from remove()
> to undo any allocation activities

looks good

> use devm_get_clk() upon lookup (for SYS and REF) to have the clocks put=

> upon driver unload

fine

> assume that resources get prepared but not necessarily enabled in the
> setup phase, make the open() and close() callbacks of the CAN network
> device enable and disable a previously acquired and prepared clock

I think you should call prepare_enable and disable_unprepare in the
open/close functions.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2OWONUNAQPXCRQRQQQQVW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHtJhkACgkQjTAFq1RaXHNfdQCfQM1L9doSuBU/M0j2iJ/JQE8u
8VkAoIVcTKHIkeH6+hyiPryhO5GVRclX
=C0Sd
-----END PGP SIGNATURE-----

------enig2OWONUNAQPXCRQRQQQQVW--
