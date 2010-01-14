Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E3DF1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jan 2010 03:20:19 +1100 (EST)
Subject: Re: [PATCH 4/4] phy: add RTBI mode for m88e1111
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1263456799-3306-4-git-send-email-yu.liu@freescale.com>
Date: Thu, 14 Jan 2010 10:20:09 -0600
Message-Id: <BC00E67D-5906-4740-A961-84FC1C524A4F@kernel.crashing.org>
References: <1263456799-3306-1-git-send-email-yu.liu@freescale.com>
	<1263456799-3306-2-git-send-email-yu.liu@freescale.com>
	<1263456799-3306-3-git-send-email-yu.liu@freescale.com>
	<1263456799-3306-4-git-send-email-yu.liu@freescale.com>
To: Liu Yu <Yu.Liu@freescale.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 14, 2010, at 2:13 AM, Liu Yu wrote:

> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> drivers/net/phy/marvell.c |   38 =
++++++++++++++++++++++++++++++++++++++
> 1 files changed, 38 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index 6f69b9b..65ed385 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -63,6 +63,7 @@
> #define MII_M1111_HWCFG_MODE_COPPER_RGMII	0xb
> #define MII_M1111_HWCFG_MODE_FIBER_RGMII	0x3
> #define MII_M1111_HWCFG_MODE_SGMII_NO_CLK	0x4
> +#define MII_M1111_HWCFG_MODE_COPPER_RTBI	0x9
> #define MII_M1111_HWCFG_FIBER_COPPER_AUTO	0x8000
> #define MII_M1111_HWCFG_FIBER_COPPER_RES	0x2000
>=20
> @@ -269,6 +270,43 @@ static int m88e1111_config_init(struct phy_device =
*phydev)
> 			return err;
> 	}
>=20
> +	if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RTBI) {
> +		temp =3D phy_read(phydev, MII_M1111_PHY_EXT_CR);
> +		if (temp < 0)
> +			return temp;
> +		temp |=3D (MII_M1111_RX_DELAY | MII_M1111_TX_DELAY);
> +		err =3D phy_write(phydev, MII_M1111_PHY_EXT_CR, temp);
> +		if (err < 0)
> +			return err;
> +
> +		temp =3D phy_read(phydev, MII_M1111_PHY_EXT_SR);
> +		if (temp < 0)
> +			return temp;
> +		temp &=3D ~(MII_M1111_HWCFG_MODE_MASK | =
MII_M1111_HWCFG_FIBER_COPPER_RES);
> +		temp |=3D 0x7 | MII_M1111_HWCFG_FIBER_COPPER_AUTO;

Does this magic 0x7 have some meaning?

> +		err =3D phy_write(phydev, MII_M1111_PHY_EXT_SR, temp);
> +		if (err < 0)
> +			return err;
> +
> +		/* soft reset */
> +		err =3D phy_write(phydev, MII_BMCR, BMCR_RESET);
> +		if (err < 0)
> +			return err;
> +		do
> +			temp =3D phy_read(phydev, MII_BMCR);
> +		while (temp & BMCR_RESET);
> +
> +		temp =3D phy_read(phydev, MII_M1111_PHY_EXT_SR);
> +		if (temp < 0)
> +			return temp;
> +		temp &=3D ~(MII_M1111_HWCFG_MODE_MASK | =
MII_M1111_HWCFG_FIBER_COPPER_RES);
> +		temp |=3D MII_M1111_HWCFG_MODE_COPPER_RTBI | =
MII_M1111_HWCFG_FIBER_COPPER_AUTO;
> +		err =3D phy_write(phydev, MII_M1111_PHY_EXT_SR, temp);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +
> 	err =3D phy_write(phydev, MII_BMCR, BMCR_RESET);
> 	if (err < 0)
> 		return err;
> --=20
> 1.6.4
