Return-Path: <Shaohui.Xie@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3A07C2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 23:31:30 +1100 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: "shh.xie@gmail.com" <shh.xie@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] phylib: Add generic 10G driver
Date: Tue, 12 Nov 2013 12:31:21 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C915117384@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1384168049-2899-1-git-send-email-shh.xie@gmail.com>
In-Reply-To: <1384168049-2899-1-git-send-email-shh.xie@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Shruti Kanetkar <Shruti@freescale.com>,
 "jg1.han@samsung.com" <jg1.han@samsung.com>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Madalin-Cristian Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added more people and list.

Best Regards,=20
Shaohui Xie


> -----Original Message-----
> From: shh.xie@gmail.com [mailto:shh.xie@gmail.com]
> Sent: Monday, November 11, 2013 7:07 PM
> To: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> Cc: Bucur Madalin-Cristian-B32716; Kanetkar Shruti-B44454; Xie Shaohui-B2=
1989
> Subject: [PATCH 2/4] phylib: Add generic 10G driver
>=20
> From: Andy Fleming
>=20
> Very incomplete, but will allow for binding an ethernet controller to it.
>=20
> Also, Add XGMII interface type
>=20
> Signed-off-by: Andy Fleming
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
>  drivers/net/phy/phy_device.c | 101 +++++++++++++++++++++++++++++++++++++=
+++++-
>  include/linux/phy.h          |   1 +
>  2 files changed, 101 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c =
index
> 74630e9..30bf2d5 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -32,6 +32,7 @@
>  #include <linux/module.h>
>  #include <linux/mii.h>
>  #include <linux/ethtool.h>
> +#include <linux/mdio.h>
>  #include <linux/phy.h>
>=20
>  #include <asm/io.h>
> @@ -689,6 +690,13 @@ static int genphy_config_advert(struct phy_device *p=
hydev)
>  	return changed;
>  }
>=20
> +int gen10g_config_advert(struct phy_device *dev) {
> +	return 0;
> +}
> +EXPORT_SYMBOL(gen10g_config_advert);
> +
> +
>  /**
>   * genphy_setup_forced - configures/forces speed/duplex from @phydev
>   * @phydev: target phy_device struct
> @@ -742,6 +750,12 @@ int genphy_restart_aneg(struct phy_device *phydev)  =
}
> EXPORT_SYMBOL(genphy_restart_aneg);
>=20
> +int gen10g_restart_aneg(struct phy_device *phydev) {
> +	return 0;
> +}
> +EXPORT_SYMBOL(gen10g_restart_aneg);
> +
>=20
>  /**
>   * genphy_config_aneg - restart auto-negotiation or write BMCR @@ -784,6
> +798,13 @@ int genphy_config_aneg(struct phy_device *phydev)  }
> EXPORT_SYMBOL(genphy_config_aneg);
>=20
> +int gen10g_config_aneg(struct phy_device *phydev) {
> +	return 0;
> +}
> +EXPORT_SYMBOL(gen10g_config_aneg);
> +
> +
>  /**
>   * genphy_update_link - update link status in @phydev
>   * @phydev: target phy_device struct
> @@ -913,6 +934,35 @@ int genphy_read_status(struct phy_device *phydev)  }
> EXPORT_SYMBOL(genphy_read_status);
>=20
> +int gen10g_read_status(struct phy_device *phydev) {
> +	int devad, reg;
> +	u32 mmd_mask =3D phydev->c45_ids.devices_in_package;
> +
> +	phydev->link =3D 1;
> +
> +	/* For now just lie and say it's 10G all the time */
> +	phydev->speed =3D 10000;
> +	phydev->duplex =3D DUPLEX_FULL;
> +
> +	for (devad =3D 0; mmd_mask; devad++, mmd_mask =3D mmd_mask >> 1) {
> +		if (!(mmd_mask & 1))
> +			continue;
> +
> +		/* Read twice because link state is latched and a
> +		 * read moves the current state into the register
> +		 */
> +		phy_read_mmd(phydev, devad, MDIO_STAT1);
> +		reg =3D phy_read_mmd(phydev, devad, MDIO_STAT1);
> +		if (reg < 0 || !(reg & MDIO_STAT1_LSTATUS))
> +			phydev->link =3D 0;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(gen10g_read_status);
> +
> +
>  static int genphy_config_init(struct phy_device *phydev)  {
>  	int val;
> @@ -959,6 +1009,15 @@ static int genphy_config_init(struct phy_device *ph=
ydev)
>=20
>  	return 0;
>  }
> +
> +static int gen10g_config_init(struct phy_device *phydev) {
> +	/* Temporarily just say we support everything */
> +	phydev->supported =3D phydev->advertising =3D SUPPORTED_10000baseT_Full=
;
> +
> +	return 0;
> +}
> +
>  int genphy_suspend(struct phy_device *phydev)  {
>  	int value;
> @@ -974,6 +1033,13 @@ int genphy_suspend(struct phy_device *phydev)  }
> EXPORT_SYMBOL(genphy_suspend);
>=20
> +int gen10g_suspend(struct phy_device *phydev) {
> +	return 0;
> +}
> +EXPORT_SYMBOL(gen10g_suspend);
> +
> +
>  int genphy_resume(struct phy_device *phydev)  {
>  	int value;
> @@ -989,6 +1055,13 @@ int genphy_resume(struct phy_device *phydev)  }
> EXPORT_SYMBOL(genphy_resume);
>=20
> +int gen10g_resume(struct phy_device *phydev) {
> +	return 0;
> +}
> +EXPORT_SYMBOL(gen10g_resume);
> +
> +
>  /**
>   * phy_probe - probe and init a PHY device
>   * @dev: device to probe and init
> @@ -1129,6 +1202,20 @@ static struct phy_driver genphy_driver =3D {
>  	.driver		=3D {.owner=3D THIS_MODULE, },
>  };
>=20
> +static struct phy_driver gen10g_driver =3D {
> +	.phy_id         =3D 0xffffffff,
> +	.phy_id_mask    =3D 0xffffffff,
> +	.name           =3D "Generic 10G PHY",
> +	.config_init    =3D gen10g_config_init,
> +	.features       =3D 0,
> +	.config_aneg    =3D gen10g_config_aneg,
> +	.read_status    =3D gen10g_read_status,
> +	.suspend        =3D gen10g_suspend,
> +	.resume         =3D gen10g_resume,
> +	.driver         =3D {.owner =3D THIS_MODULE, },
> +};
> +
> +
>  static int __init phy_init(void)
>  {
>  	int rc;
> @@ -1139,13 +1226,25 @@ static int __init phy_init(void)
>=20
>  	rc =3D phy_driver_register(&genphy_driver);
>  	if (rc)
> -		mdio_bus_exit();
> +		goto genphy_register_failed;
> +
> +	rc =3D phy_driver_register(&gen10g_driver);
> +	if (rc)
> +		goto gen10g_register_failed;
> +
> +	return rc;
> +
> +gen10g_register_failed:
> +	phy_driver_unregister(&genphy_driver);
> +genphy_register_failed:
> +	mdio_bus_exit();
>=20
>  	return rc;
>  }
>=20
>  static void __exit phy_exit(void)
>  {
> +	phy_driver_unregister(&gen10g_driver);
>  	phy_driver_unregister(&genphy_driver);
>  	mdio_bus_exit();
>  }
> diff --git a/include/linux/phy.h b/include/linux/phy.h index 684925a..f86=
4004
> 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -66,6 +66,7 @@ typedef enum {
>  	PHY_INTERFACE_MODE_RGMII_TXID,
>  	PHY_INTERFACE_MODE_RTBI,
>  	PHY_INTERFACE_MODE_SMII,
> +	PHY_INTERFACE_MODE_XGMII,
>  } phy_interface_t;
>=20
>=20
> --
> 1.8.4.1
