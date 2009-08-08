Return-Path: <wsa@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F1C96B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 20:26:22 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 080BEDDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 20:26:21 +1000 (EST)
Date: Sat, 8 Aug 2009 12:26:13 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V2] Use clock freqency from the device tree to
	calculate correct MPC5200 PSC clock.
Message-ID: <20090808102613.GA7993@pengutronix.de>
References: <20090807191936.17939.69607.stgit@terra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
In-Reply-To: <20090807191936.17939.69607.stgit@terra>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2009 at 03:19:36PM -0400, Jon Smirl wrote:
> Use clock freqency from the device tree to calculate correct MPC5200 PSC =
clock.
> Previous code had errors or used a constant. This versions computes
> the right clock based on the xtal and register settings.
>=20
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>  arch/powerpc/include/asm/mpc52xx.h           |    2 +-
>  arch/powerpc/platforms/52xx/mpc52xx_common.c |   26 ++++++++++++++++++++=
++++--
>  drivers/spi/mpc52xx_psc_spi.c                |    8 +-------
>  sound/soc/fsl/mpc5200_psc_i2s.c              |   11 +----------
>  4 files changed, 27 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/as=
m/mpc52xx.h
> index cadd398..1ca8a0e 100644
> --- a/arch/powerpc/include/asm/mpc52xx.h
> +++ b/arch/powerpc/include/asm/mpc52xx.h
> @@ -285,7 +285,7 @@ struct mpc52xx_rtc {
>  extern void mpc5200_setup_xlb_arbiter(void);
>  extern void mpc52xx_declare_of_platform_devices(void);
>  extern void mpc52xx_map_common_devices(void);
> -extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
> +extern int mpc52xx_set_psc_clkdiv(int psc_id, int freq);
>  extern unsigned int mpc52xx_get_xtal_freq(struct device_node *node);
>  extern void mpc52xx_restart(char *cmd);
> =20
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/=
platforms/52xx/mpc52xx_common.c
> index a46bad0..8a19156 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -110,6 +110,8 @@ static struct of_device_id mpc52xx_cdm_ids[] __initda=
ta =3D {
>  	{}
>  };
> =20
> +static u32 mpc52xx_fsystem; /* fsystem clock on mpc5200 */
> +
>  /**
>   * mpc52xx_map_common_devices: iomap devices required by common code
>   */
> @@ -117,6 +119,7 @@ void __init
>  mpc52xx_map_common_devices(void)
>  {
>  	struct device_node *np;
> +	u32 val;
> =20
>  	/* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
>  	 * possibly from a interrupt context. wdt is only implement
> @@ -133,8 +136,16 @@ mpc52xx_map_common_devices(void)
> =20
>  	/* Clock Distribution Module, used by PSC clock setting function */
>  	np =3D of_find_matching_node(NULL, mpc52xx_cdm_ids);
> +	mpc52xx_fsystem =3D mpc5xxx_get_bus_frequency(np);
>  	mpc52xx_cdm =3D of_iomap(np, 0);
>  	of_node_put(np);
> +
> +	/* compute fsystem, it is either 4 or 8 times the bus freq */
> +	val =3D in_be32(&mpc52xx_cdm->rstcfg);
> +	if (val & (1 << 5))
> +		mpc52xx_fsystem *=3D 8;
> +	else
> +		mpc52xx_fsystem *=3D 4;
>  }
> =20
>  /**
> @@ -143,17 +154,28 @@ mpc52xx_map_common_devices(void)
>   * @psc_id: id of psc port; must be 1,2,3 or 6
>   * @clkdiv: clock divider value to put into CDM PSC register.
>   */
> -int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv)
> +int mpc52xx_set_psc_clkdiv(int psc_id, int freq)
>  {
>  	unsigned long flags;
>  	u16 __iomem *reg;
>  	u32 val;
> -	u32 mask;
> +	u32 mask, clkdiv, err;
>  	u32 mclken_div;
> =20
>  	if (!mpc52xx_cdm)
>  		return -ENODEV;
> =20
> +	/* figure out the closest frequency the hardware can make */
> +	clkdiv =3D mpc52xx_fsystem / freq;
> +	err =3D mpc52xx_fsystem % freq;
> +	if (err > freq / 2)
> +		clkdiv++;
> +	/* hardware is not very flexible, there will be significant error */
> +	/* frequency error =3D fsystem / clkdiv - freq; */
> +
> +	/* hardware adds one to the divisor */
> +	clkdiv -=3D 1;
> +
>  	mclken_div =3D 0x8000 | (clkdiv & 0x1FF);
>  	switch (psc_id) {
>  	case 1: reg =3D &mpc52xx_cdm->mclken_div_psc1; mask =3D 0x20; break;
> diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
> index d2a04d6..5c8e621 100644
> --- a/drivers/spi/mpc52xx_psc_spi.c
> +++ b/drivers/spi/mpc52xx_psc_spi.c
> @@ -33,7 +33,6 @@
>  struct mpc52xx_psc_spi {
>  	/* fsl_spi_platform data */
>  	void (*cs_control)(struct spi_device *spi, bool on);
> -	u32 sysclk;
> =20
>  	/* driver internal data */
>  	struct mpc52xx_psc __iomem *psc;
> @@ -313,12 +312,9 @@ static int mpc52xx_psc_spi_port_config(int psc_id, s=
truct mpc52xx_psc_spi *mps)
>  {
>  	struct mpc52xx_psc __iomem *psc =3D mps->psc;
>  	struct mpc52xx_psc_fifo __iomem *fifo =3D mps->fifo;
> -	u32 mclken_div;
>  	int ret =3D 0;
> =20
> -	/* default sysclk is 512MHz */
> -	mclken_div =3D (mps->sysclk ? mps->sysclk : 512000000) / MCLK;
> -	mpc52xx_set_psc_clkdiv(psc_id, mclken_div);
> +	mpc52xx_set_psc_clkdiv(psc_id, MCLK);
> =20
>  	/* Reset the PSC into a known state */
>  	out_8(&psc->command, MPC52xx_PSC_RST_RX);
> @@ -383,12 +379,10 @@ static int __init mpc52xx_psc_spi_do_probe(struct o=
f_device *op, u32 regaddr,
>  		dev_warn(&op->dev, "probe called without platform data, no "
>  				"cs_control function will be called\n");
>  		mps->cs_control =3D NULL;
> -		mps->sysclk =3D 0;
>  		master->bus_num =3D bus_num;
>  		master->num_chipselect =3D 255;
>  	} else {
>  		mps->cs_control =3D pdata->cs_control;
> -		mps->sysclk =3D pdata->sysclk;
>  		master->bus_num =3D pdata->bus_num;
>  		master->num_chipselect =3D pdata->max_chipselect;
>  	}
> diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_=
i2s.c
> index c58fcde..8de4719 100644
> --- a/sound/soc/fsl/mpc5200_psc_i2s.c
> +++ b/sound/soc/fsl/mpc5200_psc_i2s.c
> @@ -115,7 +115,6 @@ static int psc_i2s_set_sysclk(struct snd_soc_dai *cpu=
_dai,
>  			      int clk_id, unsigned int freq, int dir)
>  {
>  	struct psc_dma *psc_dma =3D cpu_dai->private_data;
> -	int clkdiv, err;
> =20
>  	dev_dbg(psc_dma->dev, "psc_i2s_set_sysclk(cpu_dai=3D%p, freq=3D%u, dir=
=3D%i)\n",
>  				cpu_dai, freq, dir);
> @@ -128,15 +127,7 @@ static int psc_i2s_set_sysclk(struct snd_soc_dai *cp=
u_dai,
>  			psc_dma->sicr &=3D ~MPC52xx_PSC_SICR_CELLSLAVE;
>  			psc_dma->sicr |=3D MPC52xx_PSC_SICR_GENCLK;
> =20
> -			clkdiv =3D ppc_proc_freq / freq;
> -			err =3D ppc_proc_freq % freq;
> -			if (err > freq / 2)
> -				clkdiv++;
> -
> -			dev_dbg(psc_dma->dev, "psc_i2s_set_sysclk(clkdiv %d freq error=3D%ldH=
z)\n",
> -					clkdiv, (ppc_proc_freq / clkdiv - freq));
> -
> -			return mpc52xx_set_psc_clkdiv(psc_dma->id + 1, clkdiv);
> +			return mpc52xx_set_psc_clkdiv(psc_dma->id + 1, freq);
>  		}
>  	}
>  	return 0;
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkp9UsUACgkQD27XaX1/VRtRFwCffkWSIXjMywtWcRQaIqzLnOjh
LOkAoKPnGHVz4DGdgQkoeMgoV79FCJVD
=IRKZ
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
