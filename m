Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64B83B7CA1
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 21:49:20 +1100 (EST)
Date: Wed, 20 Jan 2010 11:49:15 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 06/11] mtd: Add MPC5121 NAND Flash Controller driver
Message-ID: <20100120104915.GB5041@pengutronix.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-7-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
In-Reply-To: <1263932653-3634-7-git-send-email-agust@denx.de>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, wd@denx.de,
	dzu@denx.de, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2010 at 09:24:08PM +0100, Anatolij Gustschin wrote:
> From: Piotr Ziecik <kosmo@semihalf.com>
>=20
> Adds NAND Flash Controller driver for MPC5121 Revision 2.
> All device features, except hardware ECC and power management,
> are supported.
>=20
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: <linux-mtd@lists.infradead.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---

Please include a logfile with changes since the last version. This really
helps.

> +static int __init mpc5121_nfc_probe(struct of_device *op,
> +					const struct of_device_id *match)

[...]

> +{
> +	/* Support external chip-select logic on ADS5121 board */
> +	rootnode =3D of_find_node_by_path("/");
> +	if (of_device_is_compatible(rootnode, "fsl,mpc5121ads")) {
> +		retval =3D ads5121_chipselect_init(mtd);
> +		if (retval) {
> +			dev_err(dev, "Chipselect init error!\n");
> +			of_node_put(rootnode);
> +			return retval;
> +		}
> +
> +		chip->select_chip =3D ads5121_select_chip;
> +	}
> +	of_node_put(rootnode);

If we have to live with the platform-stuff being in the driver, maybe a tab=
le
having the compatible-string and an init-function pointer per entry will ma=
ke
it scale better with the number of boards?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktW36sACgkQD27XaX1/VRtA1wCgponKWU3rPA15UQtrVNd9DmWV
U3gAnj7gLY4JGG8+nHsMWsTH5Oi3eXXf
=UvF3
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
