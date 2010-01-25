Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32303B7CC1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Jan 2010 22:52:18 +1100 (EST)
Date: Mon, 25 Jan 2010 12:52:11 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/3] i2c-mpc: add support for the MPC512x processors
	from Freescale
Message-ID: <20100125115211.GA5257@pengutronix.de>
References: <1264408029-5290-1-git-send-email-wg@grandegger.com>
	<1264408029-5290-2-git-send-email-wg@grandegger.com>
	<1264408029-5290-3-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
In-Reply-To: <1264408029-5290-3-git-send-email-wg@grandegger.com>
Cc: Devicetree-discuss@lists.ozlabs.org, Linuxppc-dev@lists.ozlabs.org,
	Linux-i2c@vger.kernel.org, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Wolfgang,

On Mon, Jan 25, 2010 at 09:27:08AM +0100, Wolfgang Grandegger wrote:
> From: Wolfgang Grandegger <wg@denx.de>
>=20
> The "setclock" initialization functions have been renamed to "setup"
> because I2C interrupts must be enabled for the MPC512x. This requires
> to handle "fsl,preserve-clocking" in a slighly different way. Also,
> the old settings are now reported calling dev_dbg(). For the MPC512x
> the clock setup function of the MPC52xx can be re-used.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> ---
>  drivers/i2c/busses/Kconfig   |    9 ++--
>  drivers/i2c/busses/i2c-mpc.c |  122 ++++++++++++++++++++++++++++++------=
------
>  2 files changed, 93 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 5f318ce..f481f30 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -418,13 +418,14 @@ config I2C_IXP2000
>  	  instead.
> =20
>  config I2C_MPC
> -	tristate "MPC107/824x/85xx/52xx/86xx"
> +	tristate "MPC107/824x/85xx/512x/52xx/86xx"
>  	depends on PPC32
>  	help
>  	  If you say yes to this option, support will be included for the
> -	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
> -	  MPC85xx/MPC8641 family processors. The driver may also work on 52xx
> -	  family processors, though interrupts are known not to work.
> +	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245,
> +	  MPC85xx/MPC8641 and MPC512x family processors. The driver may
> +	  also work on 52xx family processors, though interrupts are known
> +	  not to work.

Opinion poll: Can we remove the "may work" sentence while we are here? It h=
as
worked fine for years. BTW, which interrupts are meant here (from I2C slave=
s?
interrupts of the controller?)?

> =20
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mpc.
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 2cb864e..70c3e5d 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -67,9 +67,8 @@ struct mpc_i2c_divider {
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
> @@ -164,7 +163,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned tim=
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
> @@ -216,12 +215,18 @@ static int __devinit mpc_i2c_get_fdr_52xx(struct de=
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
> +	if (clock =3D=3D -1) {

Could we use 0 for 'no_clock'? This would make the above statement simply

	if (!clock)

and saves us using -1 with a u32.

> +		dev_dbg(i2c->dev, "using fdr %d\n",
> +			readb(i2c->base + MPC_I2C_FDR));
> +		return;	/* preserve clocking */
> +	}
> +
>  	ret =3D mpc_i2c_get_fdr_52xx(node, clock, prescaler);
>  	fdr =3D (ret >=3D 0) ? ret : 0x3f; /* backward compatibility */
> =20
> @@ -230,13 +235,50 @@ static void __devinit mpc_i2c_setclock_52xx(struct =
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
> +
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
> @@ -322,12 +364,19 @@ static int __devinit mpc_i2c_get_fdr_8xxx(struct de=
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
> +	if (clock =3D=3D -1) {
> +		dev_dbg(i2c->dev, "using dfsrr %d, fdr %d\n",
> +			readb(i2c->base + MPC_I2C_DFSRR),
> +			readb(i2c->base + MPC_I2C_FDR));
> +		return;	/* preserve clocking */
> +	}
> +
>  	ret =3D mpc_i2c_get_fdr_8xxx(node, clock, prescaler);
>  	fdr =3D (ret >=3D 0) ? ret : 0x1031; /* backward compatibility */
> =20
> @@ -340,9 +389,9 @@ static void __devinit mpc_i2c_setclock_8xxx(struct de=
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
> @@ -525,21 +574,21 @@ static int __devinit fsl_i2c_probe(struct of_device=
 *op,
>  		}
>  	}
> =20
> -	if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
> +	if (of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
> +		clock =3D -1;
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
> +		struct mpc_i2c_data *data =3D (struct mpc_i2c_data *)match->data;

The cast should not be necessary.

> +		data->setup(op->node, i2c, clock, data->prescaler);
> +	} else {
> +		/* Backwards compatibility */
> +		if (of_get_property(op->node, "dfsrr", NULL))
> +			mpc_i2c_setup_8xxx(op->node, i2c, clock, 0);
>  	}
> =20
>  	dev_set_drvdata(&op->dev, i2c);
> @@ -585,20 +634,24 @@ static int __devexit fsl_i2c_remove(struct of_devic=
e *op)
>  };
> =20
>  static struct mpc_i2c_data __devinitdata mpc_i2c_data_52xx =3D {
> -	.setclock =3D mpc_i2c_setclock_52xx,
> +	.setup =3D mpc_i2c_setup_52xx,
> +};
> +
> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_512x =3D {
> +	.setup =3D mpc_i2c_setup_512x,
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
> @@ -606,6 +659,7 @@ static const struct of_device_id mpc_i2c_of_match[] =
=3D {
>  	{.compatible =3D "mpc5200-i2c", .data =3D &mpc_i2c_data_52xx, },
>  	{.compatible =3D "fsl,mpc5200b-i2c", .data =3D &mpc_i2c_data_52xx, },
>  	{.compatible =3D "fsl,mpc5200-i2c", .data =3D &mpc_i2c_data_52xx, },
> +	{.compatible =3D "fsl,mpc5121-i2c", .data =3D &mpc_i2c_data_512x, },
>  	{.compatible =3D "fsl,mpc8313-i2c", .data =3D &mpc_i2c_data_8313, },
>  	{.compatible =3D "fsl,mpc8543-i2c", .data =3D &mpc_i2c_data_8543, },
>  	{.compatible =3D "fsl,mpc8544-i2c", .data =3D &mpc_i2c_data_8544, },
> @@ -648,5 +702,5 @@ module_exit(fsl_i2c_exit);
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

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktdhesACgkQD27XaX1/VRtxnACcCTvr4f4XMnXBpsjdT/L8NFS7
OHkAoI8WJgGu4f9lxMlFvovKXwGmXdm3
=VD4n
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
