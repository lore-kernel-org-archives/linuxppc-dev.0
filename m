Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2292F1A0186
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 23:01:38 +1000 (AEST)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Liberman Igal <Igal.Liberman@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC,v3,12/12] fsl/fman: Add FMan MAC driver
Date: Mon, 20 Jul 2015 12:28:11 +0000
Message-ID: <BL2PR03MB5450DB021D160D507432FC5E6850@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1430299742-29428-1-git-send-email-igal.liberman@freescale.com>
 <1437394575.10831.18.camel@transmode.se>
In-Reply-To: <1437394575.10831.18.camel@transmode.se>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joakim,

It seems we just need to align to the API introduced by Thomas Petazzoni
in 3be2a49e.

Madalin

> -----Original Message-----
> From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]
> Sent: Monday, July 20, 2015 3:16 PM
> To: netdev@vger.kernel.org; Liberman Igal-B31950
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Bucur
> Madalin-Cristian-B32716
> Subject: Re: [RFC,v3,12/12] fsl/fman: Add FMan MAC driver
>=20
> On Wed, 2015-04-29 at 12:29 +0300, Igal.Liberman wrote:
> > From: Igal Liberman <Igal.Liberman@freescale.com>
> >
> > This patch adds the Ethernet MAC driver support.
> >
> > Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> > ---
> >  drivers/net/ethernet/freescale/fman/inc/mac.h     |  125 +++++
> >  drivers/net/ethernet/freescale/fman/mac/Makefile  |    3 +-
> >  drivers/net/ethernet/freescale/fman/mac/mac-api.c |  605
> +++++++++++++++++++++
> >  drivers/net/ethernet/freescale/fman/mac/mac.c     |  527
> ++++++++++++++++++
> >  4 files changed, 1259 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/net/ethernet/freescale/fman/inc/mac.h
> >  create mode 100644 drivers/net/ethernet/freescale/fman/mac/mac-api.c
> >  create mode 100644 drivers/net/ethernet/freescale/fman/mac/mac.c
> >
> > diff --git a/drivers/net/ethernet/freescale/fman/inc/mac.h
> b/drivers/net/ethernet/freescale/fman/inc/mac.h
> > new file mode 100644
> > index 0000000..2d27331
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/fman/inc/mac.h
> .....
> > +	/* Get the rest of the PHY information */
> > +	mac_dev->phy_node =3D of_parse_phandle(mac_node, "phy-handle",
> 0);
> > +	if (!mac_dev->phy_node) {
> > +		int sz;
> > +		const u32 *phy_id =3D of_get_property(mac_node, "fixed-
> link",
> > +							&sz);
> > +		if (!phy_id || sz < sizeof(*phy_id)) {
> > +			dev_err(dev, "No PHY (or fixed link) found\n");
> > +			_errno =3D -EINVAL;
> > +			goto _return_dev_set_drvdata;
> > +		}
> > +
> > +		sprintf(mac_dev->fixed_bus_id, PHY_ID_FMT, "fixed-0",
> > +			phy_id[0]);
> > +	}
>=20
> The above for fixed PHY does not work for me, changing it to does:
>=20
> diff --git a/drivers/net/ethernet/freescale/fman/mac/mac.c
> b/drivers/net/ethernet/freescale/fman/mac/mac.c
> index 4eb8f7c..a8be96a 100644
> --- a/drivers/net/ethernet/freescale/fman/mac/mac.c
> +++ b/drivers/net/ethernet/freescale/fman/mac/mac.c
> @@ -42,6 +42,7 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> +#include <linux/of_mdio.h>
>  #include <linux/of_net.h>
>  #include <linux/device.h>
>  #include <linux/phy.h>
> @@ -399,7 +400,7 @@ static int __cold mac_probe(struct platform_device
> *_of_dev)
>=20
>         /* Get the rest of the PHY information */
>         mac_dev->phy_node =3D of_parse_phandle(mac_node, "phy-handle", 0)=
;
> -       if (!mac_dev->phy_node) {
> +       if (0 && !mac_dev->phy_node) {
>                 int sz;
>                 const u32 *phy_id =3D of_get_property(mac_node, "fixed-li=
nk",
>                                                         &sz);
> @@ -412,6 +413,16 @@ static int __cold mac_probe(struct platform_device
> *_of_dev)
>                 sprintf(mac_dev->fixed_bus_id, PHY_ID_FMT, "fixed-0",
>                         phy_id[0]);
>         }
> +       if (!mac_dev->phy_node && of_phy_is_fixed_link(mac_node)) {
> +               /*
> +                * In the case of a fixed PHY, the DT node associated
> +                * to the PHY is the Ethernet MAC DT node.
> +                */
> +               _errno =3D of_phy_register_fixed_link(mac_node);
> +               if (_errno)
> +                       return _errno;
> +               mac_dev->phy_node =3D of_node_get(mac_node);
> +       }
