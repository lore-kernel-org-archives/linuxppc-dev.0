Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E0BDB6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 19:48:50 +1000 (EST)
Date: Thu, 19 May 2011 11:48:42 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
	sdhci-esdhc-imx
Message-ID: <20110519094841.GB2219@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
In-Reply-To: <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
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


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +config MMC_SDHCI_ESDHC
> +	bool
> +	depends on MMC_SDHCI
> +	select MMC_SDHCI_PLTFM
> +	help
> +	  This selects SDHCI driver for Freescale eSDHC controller.

bool is not a good choice here, because if ESDHC_IMX is selected as a
module (-m), it will get converted here to built-in (-y). Same goes for
MMC_SDHCI_PLTFM. If I change both into tristate and then compile, I get
a build error:

ERROR: "sdhci_pltfm_suspend" [drivers/mmc/host/sdhci-esdhc.ko] undefined!
ERROR: "sdhci_get_of_property" [drivers/mmc/host/sdhci-esdhc.ko] undefined!
ERROR: "sdhci_pltfm_init" [drivers/mmc/host/sdhci-esdhc.ko] undefined!
ERROR: "sdhci_pltfm_free" [drivers/mmc/host/sdhci-esdhc.ko] undefined!

So, the module-support seems to be missing for the library.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3U53kACgkQD27XaX1/VRtYigCfaUQ0Zm6JgulAx7GPts/7nUwP
pi8AoKgWBD6yoBCrQblL/2kel4qUhfy/
=1g4j
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
