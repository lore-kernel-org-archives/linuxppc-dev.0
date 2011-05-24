Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50583B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 05:32:10 +1000 (EST)
Date: Tue, 24 May 2011 21:32:02 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 3/7] mmc: sdhci: make sdhci-of device drivers self
	registered
Message-ID: <20110524193202.GB25727@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-4-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
In-Reply-To: <1304601778-13837-4-git-send-email-shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, sameo@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, patches@linaro.org,
	devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	Saeed Bishara <saeed@marvell.com>,
	Xiaobo Xie <X.Xie@freescale.com>, kernel@pengutronix.de,
	Mike Rapoport <mike@compulab.co.il>, Olof Johansson <olof@lixom.net>,
	Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2011 at 09:22:54PM +0800, Shawn Guo wrote:
> The patch turns the sdhci-of-core common stuff into helper functions
> added into sdhci-pltfm.c, and makes sdhci-of device drviers self
> registered using the same pair of .probe and .remove used by
> sdhci-pltfm device drivers.
>=20
> As a result, sdhci-of-core.c and sdhci-of.h can be eliminated with
> those common things merged into sdhci-pltfm.c and sdhci-pltfm.h
> respectively.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

After taking care of Anton's comment and fixing this minor thingie...

> +#ifdef CONFIG_OF
> +static bool sdhci_of_wp_inverted(struct device_node *np)
> +{
> +	if (of_get_property(np, "sdhci,wp-inverted", NULL))
> +		return true;
> +
> +	/* Old device trees don't have the wp-inverted property. */
> +#ifdef CONFIG_PPC
> +	return machine_is(mpc837x_rdb) || machine_is(mpc837x_mds);
> +#else
> +	return false;
> +#endif

/* CONFIG_PPC */ after #endif

> +}
> +
> +void sdhci_get_of_property(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	const __be32 *clk;
> +	int size;
> +
> +	if (of_device_is_available(np)) {
> +		if (of_get_property(np, "sdhci,auto-cmd12", NULL))
> +			host->quirks |=3D SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
> +
> +		if (of_get_property(np, "sdhci,1-bit-only", NULL))
> +			host->quirks |=3D SDHCI_QUIRK_FORCE_1_BIT_DATA;
> +
> +		if (sdhci_of_wp_inverted(np))
> +			host->quirks |=3D SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> +
> +		clk =3D of_get_property(np, "clock-frequency", &size);
> +		if (clk && size =3D=3D sizeof(*clk) && *clk)
> +			pltfm_host->clock =3D be32_to_cpup(clk);
> +	}
> +}
> +#else
> +void sdhci_get_of_property(struct platform_device *pdev) {}
> +#endif

/* CONFIG_OF */

you can add

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3cB7IACgkQD27XaX1/VRv8XQCfbXIP6Bwqj7F9+8hw5und9rjK
lj4AnRBCnlqBCFgHF/mPg4mGfbISYWCr
=V9P3
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
