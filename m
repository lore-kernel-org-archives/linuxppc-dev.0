Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B478B7D07
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Jan 2010 03:25:03 +1100 (EST)
Date: Fri, 29 Jan 2010 17:24:49 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4 2/3] i2c-mpc: add support for the MPC512x processors
	from Freescale
Message-ID: <20100129162449.GJ7812@pengutronix.de>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com>
	<1264685141-26391-3-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KCXyoJ//PRyfzsc9"
In-Reply-To: <1264685141-26391-3-git-send-email-wg@grandegger.com>
Cc: Wolfgang Grandegger <wg@denx.de>, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--KCXyoJ//PRyfzsc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 28, 2010 at 02:25:40PM +0100, Wolfgang Grandegger wrote:
> From: Wolfgang Grandegger <wg@denx.de>
>=20
> The "setclock" initialization functions have been renamed to "setup"
> because I2C interrupts must be enabled for the MPC512x. This requires
> to handle "fsl,preserve-clocking" in a slighly different way. Also,
> the old settings are now reported calling dev_dbg(). For the MPC512x
> the clock setup function of the MPC52xx can be re-used. Furthermore,
> the Kconfig help has been updated and corrected.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>

One minor thing and you can add my

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>  drivers/i2c/busses/Kconfig   |    7 +-
>  drivers/i2c/busses/i2c-mpc.c |  127 ++++++++++++++++++++++++++++++------=
------
>  2 files changed, 94 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 5f318ce..5477e41 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -418,13 +418,12 @@ config I2C_IXP2000
>  	  instead.
> =20
>  config I2C_MPC
> -	tristate "MPC107/824x/85xx/52xx/86xx"
> +	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
>  	depends on PPC32
>  	help
>  	  If you say yes to this option, support will be included for the
> -	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
> -	  MPC85xx/MPC8641 family processors. The driver may also work on 52xx
> -	  family processors, though interrupts are known not to work.
> +	  built-in I2C interface on the MPC107, Tsi107, MPC512x, MPC52xx,
> +	  MPC8240, MPC8245, MPC83xx, MPC85xx and MPC8641 family processors.
> =20
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mpc.
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 275ebe6..1af0730 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -31,6 +31,9 @@
> =20
>  #define DRV_NAME "mpc-i2c"
> =20
> +#define MPC_I2C_CLOCK_SAFE     0

For clarity, I think this define should also be used when checking for the
condition (instead of using !clock).

> +#define MPC_I2C_CLOCK_PRESERVE (~0U)
> +
>  #define MPC_I2C_FDR   0x04
>  #define MPC_I2C_CR    0x08
>  #define MPC_I2C_SR    0x0c
> @@ -67,9 +70,8 @@ struct mpc_i2c_divider {
>  };
> =20
>  struct mpc_i2c_data {
> -	void (*setclock)(struct device_node *node,
> -			 struct mpc_i2c *i2c,
> -			 u32 clock, u32 prescaler);
> +	void (*setup)(struct device_node *node, struct mpc_i2c *i2c,
> +		      u32 clock, u32 prescaler);
>  	u32 prescaler;
>  };
> =20
> @@ -164,7 +166,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned tim=
eout, int writing)
>  	return 0;
>  }
> =20
> -#ifdef CONFIG_PPC_MPC52xx
> +#if defined(CONFIG_PPC_MPC52xx) || defined(CONFIG_PPC_MPC512x)
>  static const struct __devinitdata mpc_i2c_divider mpc_i2c_dividers_52xx[=
] =3D {
>  	{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
>  	{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
> @@ -216,12 +218,18 @@ static int __devinit mpc_i2c_get_fdr_52xx(struct de=
vice_node *node, u32 clock,
>  	return div ? (int)div->fdr : -EINVAL;
>  }
> =20
> -static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
> -					    struct mpc_i2c *i2c,
> -					    u32 clock, u32 prescaler)
> +static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
> +					 struct mpc_i2c *i2c,
> +					 u32 clock, u32 prescaler)
>  {
>  	int ret, fdr;
> =20
> +	if (clock =3D=3D MPC_I2C_CLOCK_PRESERVE) {
> +		dev_dbg(i2c->dev, "using fdr %d\n",
> +			readb(i2c->base + MPC_I2C_FDR));
> +		return;
> +	}
> +
>  	ret =3D mpc_i2c_get_fdr_52xx(node, clock, prescaler);
>  	fdr =3D (ret >=3D 0) ? ret : 0x3f; /* backward compatibility */
> =20
> @@ -230,13 +238,49 @@ static void __devinit mpc_i2c_setclock_52xx(struct =
device_node *node,
>  	if (ret >=3D 0)
>  		dev_info(i2c->dev, "clock %d Hz (fdr=3D%d)\n", clock, fdr);
>  }
> -#else /* !CONFIG_PPC_MPC52xx */
> -static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
> -					    struct mpc_i2c *i2c,
> -					    u32 clock, u32 prescaler)
> +#else /* !(CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x) */
> +static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
> +					 struct mpc_i2c *i2c,
> +					 u32 clock, u32 prescaler)
> +{
> +}
> +#endif /* CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x */
> +
> +#ifdef CONFIG_PPC_MPC512x
> +static void __devinit mpc_i2c_setup_512x(struct device_node *node,
> +					 struct mpc_i2c *i2c,
> +					 u32 clock, u32 prescaler)
> +{
> +	struct device_node *node_ctrl;
> +	void __iomem *ctrl;
> +	const u32 *pval;
> +	u32 idx;
> +
> +	/* Enable I2C interrupts for mpc5121 */
> +	node_ctrl =3D of_find_compatible_node(NULL, NULL,
> +					    "fsl,mpc5121-i2c-ctrl");
> +	if (node_ctrl) {
> +		ctrl =3D of_iomap(node_ctrl, 0);
> +		if (ctrl) {
> +			/* Interrupt enable bits for i2c-0/1/2: bit 24/26/28 */
> +			pval =3D of_get_property(node, "reg", NULL);
> +			idx =3D (*pval & 0xff) / 0x20;
> +			setbits32(ctrl, 1 << (24 + idx * 2));
> +			iounmap(ctrl);
> +		}
> +		of_node_put(node_ctrl);
> +	}
> +
> +	/* The clock setup for the 52xx works also fine for the 512x */
> +	mpc_i2c_setup_52xx(node, i2c, clock, prescaler);
> +}
> +#else /* CONFIG_PPC_MPC512x */
> +static void __devinit mpc_i2c_setup_512x(struct device_node *node,
> +					 struct mpc_i2c *i2c,
> +					 u32 clock, u32 prescaler)
>  {
>  }
> -#endif /* CONFIG_PPC_MPC52xx*/
> +#endif /* CONFIG_PPC_MPC512x */
> =20
>  #ifdef CONFIG_FSL_SOC
>  static const struct __devinitdata mpc_i2c_divider mpc_i2c_dividers_8xxx[=
] =3D {
> @@ -322,12 +366,19 @@ static int __devinit mpc_i2c_get_fdr_8xxx(struct de=
vice_node *node, u32 clock,
>  	return div ? (int)div->fdr : -EINVAL;
>  }
> =20
> -static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
> -					    struct mpc_i2c *i2c,
> -					    u32 clock, u32 prescaler)
> +static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
> +					 struct mpc_i2c *i2c,
> +					 u32 clock, u32 prescaler)
>  {
>  	int ret, fdr;
> =20
> +	if (clock =3D=3D MPC_I2C_CLOCK_PRESERVE) {
> +		dev_dbg(i2c->dev, "using dfsrr %d, fdr %d\n",
> +			readb(i2c->base + MPC_I2C_DFSRR),
> +			readb(i2c->base + MPC_I2C_FDR));
> +		return;
> +	}
> +
>  	ret =3D mpc_i2c_get_fdr_8xxx(node, clock, prescaler);
>  	fdr =3D (ret >=3D 0) ? ret : 0x1031; /* backward compatibility */
> =20
> @@ -340,9 +391,9 @@ static void __devinit mpc_i2c_setclock_8xxx(struct de=
vice_node *node,
>  }
> =20
>  #else /* !CONFIG_FSL_SOC */
> -static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
> -					    struct mpc_i2c *i2c,
> -					    u32 clock, u32 prescaler)
> +static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
> +					 struct mpc_i2c *i2c,
> +					 u32 clock, u32 prescaler)
>  {
>  }
>  #endif /* CONFIG_FSL_SOC */
> @@ -496,7 +547,7 @@ static int __devinit fsl_i2c_probe(struct of_device *=
op,
>  {
>  	struct mpc_i2c *i2c;
>  	const u32 *prop;
> -	u32 clock =3D 0;
> +	u32 clock =3D MPC_I2C_CLOCK_SAFE;
>  	int result =3D 0;
>  	int plen;
> =20
> @@ -525,21 +576,21 @@ static int __devinit fsl_i2c_probe(struct of_device=
 *op,
>  		}
>  	}
> =20
> -	if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
> +	if (of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
> +		clock =3D MPC_I2C_CLOCK_PRESERVE;
> +	} else {
>  		prop =3D of_get_property(op->node, "clock-frequency", &plen);
>  		if (prop && plen =3D=3D sizeof(u32))
>  			clock =3D *prop;
> +	}
> =20
> -		if (match->data) {
> -			struct mpc_i2c_data *data =3D
> -				(struct mpc_i2c_data *)match->data;
> -			data->setclock(op->node, i2c, clock, data->prescaler);
> -		} else {
> -			/* Backwards compatibility */
> -			if (of_get_property(op->node, "dfsrr", NULL))
> -				mpc_i2c_setclock_8xxx(op->node, i2c,
> -						      clock, 0);
> -		}
> +	if (match->data) {
> +		struct mpc_i2c_data *data =3D match->data;
> +		data->setup(op->node, i2c, clock, data->prescaler);
> +	} else {
> +		/* Backwards compatibility */
> +		if (of_get_property(op->node, "dfsrr", NULL))
> +			mpc_i2c_setup_8xxx(op->node, i2c, clock, 0);
>  	}
> =20
>  	dev_set_drvdata(&op->dev, i2c);
> @@ -584,21 +635,25 @@ static int __devexit fsl_i2c_remove(struct of_devic=
e *op)
>  	return 0;
>  };
> =20
> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_512x =3D {
> +	.setup =3D mpc_i2c_setup_512x,
> +};
> +
>  static struct mpc_i2c_data __devinitdata mpc_i2c_data_52xx =3D {
> -	.setclock =3D mpc_i2c_setclock_52xx,
> +	.setup =3D mpc_i2c_setup_52xx,
>  };
> =20
>  static struct mpc_i2c_data __devinitdata mpc_i2c_data_8313 =3D {
> -	.setclock =3D mpc_i2c_setclock_8xxx,
> +	.setup =3D mpc_i2c_setup_8xxx,
>  };
> =20
>  static struct mpc_i2c_data __devinitdata mpc_i2c_data_8543 =3D {
> -	.setclock =3D mpc_i2c_setclock_8xxx,
> +	.setup =3D mpc_i2c_setup_8xxx,
>  	.prescaler =3D 2,
>  };
> =20
>  static struct mpc_i2c_data __devinitdata mpc_i2c_data_8544 =3D {
> -	.setclock =3D mpc_i2c_setclock_8xxx,
> +	.setup =3D mpc_i2c_setup_8xxx,
>  	.prescaler =3D 3,
>  };
> =20
> @@ -606,6 +661,7 @@ static const struct of_device_id mpc_i2c_of_match[] =
=3D {
>  	{.compatible =3D "mpc5200-i2c", .data =3D &mpc_i2c_data_52xx, },
>  	{.compatible =3D "fsl,mpc5200b-i2c", .data =3D &mpc_i2c_data_52xx, },
>  	{.compatible =3D "fsl,mpc5200-i2c", .data =3D &mpc_i2c_data_52xx, },
> +	{.compatible =3D "fsl,mpc5121-i2c", .data =3D &mpc_i2c_data_512x, },
>  	{.compatible =3D "fsl,mpc8313-i2c", .data =3D &mpc_i2c_data_8313, },
>  	{.compatible =3D "fsl,mpc8543-i2c", .data =3D &mpc_i2c_data_8543, },
>  	{.compatible =3D "fsl,mpc8544-i2c", .data =3D &mpc_i2c_data_8544, },
> @@ -615,7 +671,6 @@ static const struct of_device_id mpc_i2c_of_match[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
> =20
> -
>  /* Structure for a device driver */
>  static struct of_platform_driver mpc_i2c_driver =3D {
>  	.match_table	=3D mpc_i2c_of_match,
> @@ -648,5 +703,5 @@ module_exit(fsl_i2c_exit);
> =20
>  MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
>  MODULE_DESCRIPTION("I2C-Bus adapter for MPC107 bridge and "
> -		   "MPC824x/85xx/52xx processors");
> +		   "MPC824x/85xx/512x/52xx processors");
>  MODULE_LICENSE("GPL");
> --=20
> 1.6.2.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--KCXyoJ//PRyfzsc9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktjC9EACgkQD27XaX1/VRtKsQCfebRDIxjsMUOTIpaQwlO9HP+W
4mQAoJePgc8S7PP1N0JvKojPqq+OeC2J
=ZNCF
-----END PGP SIGNATURE-----

--KCXyoJ//PRyfzsc9--
