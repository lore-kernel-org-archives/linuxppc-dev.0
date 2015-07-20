Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id DDC431A2DFC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 22:16:20 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "igal.liberman@freescale.com" <igal.liberman@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "madalin.bucur@freescale.com" <madalin.bucur@freescale.com>
Subject: Re: [RFC,v3,12/12] fsl/fman: Add FMan MAC driver
Date: Mon, 20 Jul 2015 12:16:15 +0000
Message-ID: <1437394575.10831.18.camel@transmode.se>
References: <1430299742-29428-1-git-send-email-igal.liberman@freescale.com>
In-Reply-To: <1430299742-29428-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-29 at 12:29 +0300, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
>=20
> This patch adds the Ethernet MAC driver support.
>=20
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> ---
>  drivers/net/ethernet/freescale/fman/inc/mac.h     |  125 +++++
>  drivers/net/ethernet/freescale/fman/mac/Makefile  |    3 +-
>  drivers/net/ethernet/freescale/fman/mac/mac-api.c |  605 +++++++++++++++=
++++++
>  drivers/net/ethernet/freescale/fman/mac/mac.c     |  527 +++++++++++++++=
+++
>  4 files changed, 1259 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/freescale/fman/inc/mac.h
>  create mode 100644 drivers/net/ethernet/freescale/fman/mac/mac-api.c
>  create mode 100644 drivers/net/ethernet/freescale/fman/mac/mac.c
>=20
> diff --git a/drivers/net/ethernet/freescale/fman/inc/mac.h b/drivers/net/=
ethernet/freescale/fman/inc/mac.h
> new file mode 100644
> index 0000000..2d27331
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/fman/inc/mac.h
.....
> +	/* Get the rest of the PHY information */
> +	mac_dev->phy_node =3D of_parse_phandle(mac_node, "phy-handle", 0);
> +	if (!mac_dev->phy_node) {
> +		int sz;
> +		const u32 *phy_id =3D of_get_property(mac_node, "fixed-link",
> +							&sz);
> +		if (!phy_id || sz < sizeof(*phy_id)) {
> +			dev_err(dev, "No PHY (or fixed link) found\n");
> +			_errno =3D -EINVAL;
> +			goto _return_dev_set_drvdata;
> +		}
> +
> +		sprintf(mac_dev->fixed_bus_id, PHY_ID_FMT, "fixed-0",
> +			phy_id[0]);
> +	}

The above for fixed PHY does not work for me, changing it to does:

diff --git a/drivers/net/ethernet/freescale/fman/mac/mac.c b/drivers/net/et=
hernet/freescale/fman/mac/mac.c
index 4eb8f7c..a8be96a 100644
--- a/drivers/net/ethernet/freescale/fman/mac/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac/mac.c
@@ -42,6 +42,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/device.h>
 #include <linux/phy.h>
@@ -399,7 +400,7 @@ static int __cold mac_probe(struct platform_device *_of=
_dev)
=20
        /* Get the rest of the PHY information */
        mac_dev->phy_node =3D of_parse_phandle(mac_node, "phy-handle", 0);
-       if (!mac_dev->phy_node) {
+       if (0 && !mac_dev->phy_node) {
                int sz;
                const u32 *phy_id =3D of_get_property(mac_node, "fixed-link=
",
                                                        &sz);
@@ -412,6 +413,16 @@ static int __cold mac_probe(struct platform_device *_o=
f_dev)
                sprintf(mac_dev->fixed_bus_id, PHY_ID_FMT, "fixed-0",
                        phy_id[0]);
        }
+       if (!mac_dev->phy_node && of_phy_is_fixed_link(mac_node)) {
+               /*
+                * In the case of a fixed PHY, the DT node associated
+                * to the PHY is the Ethernet MAC DT node.
+                */
+               _errno =3D of_phy_register_fixed_link(mac_node);
+               if (_errno)
+                       return _errno;
+               mac_dev->phy_node =3D of_node_get(mac_node);
+       }=
