Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9CCEBDDF58
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2009 19:00:33 +1000 (EST)
In-Reply-To: <20090425225323.32392.1254.stgit@localhost.localdomain>
References: <20090425224458.32392.31296.stgit@localhost.localdomain>
	<20090425225323.32392.1254.stgit@localhost.localdomain>
To: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
Subject: Re: [PATCH v3 09/13] net: Rework ucc_geth driver to use of_mdio
	infrastructure
Message-ID: <OFD90DF3E8.3B40B9BF-ONC12575A4.0030C830-C12575A4.00317AE2@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Sun, 26 Apr 2009 11:00:27 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Andy Fleming <afleming@freescale.com>,
	netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change in fixed link case, see inline.

> 
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> This patch simplifies the driver by making use of more common code.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Acked-by: Andy Fleming <afleming@freescale.com>
> ---
> 
>  drivers/net/ucc_geth.c |   47 
++++++++++++-----------------------------------
>  drivers/net/ucc_geth.h |    2 +-
>  2 files changed, 13 insertions(+), 36 deletions(-)
> 
> 
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index d3f39e8..195b490 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -27,6 +27,7 @@
>  #include <linux/mii.h>
>  #include <linux/phy.h>
>  #include <linux/workqueue.h>
> +#include <linux/of_mdio.h>
>  #include <linux/of_platform.h>
> 
>  #include <asm/uaccess.h>
> @@ -1542,12 +1543,14 @@ static int init_phy(struct net_device *dev)
>     priv->oldspeed = 0;
>     priv->oldduplex = -1;
> 
> -   phydev = phy_connect(dev, ug_info->phy_bus_id, &adjust_link, 0,
> -              priv->phy_interface);
> +   if (!ug_info->phy_node)
> +      return 0;
> 
> -   if (IS_ERR(phydev)) {
> +   phydev = of_phy_connect(dev, ug_info->phy_node, &adjust_link, 0,
> +            priv->phy_interface);
> +   if (!phydev) {
>        printk("%s: Could not attach to PHY\n", dev->name);
> -      return PTR_ERR(phydev);
> +      return -ENODEV;
>     }
> 
>     phydev->supported &= (ADVERTISED_10baseT_Half |
> @@ -3519,14 +3522,12 @@ static int ucc_geth_probe(struct of_device* 
ofdev, const struct of_device_id *ma
>  {
>     struct device *device = &ofdev->dev;
>     struct device_node *np = ofdev->node;
> -   struct device_node *mdio;
>     struct net_device *dev = NULL;
>     struct ucc_geth_private *ugeth = NULL;
>     struct ucc_geth_info *ug_info;
>     struct resource res;
>     struct device_node *phy;
>     int err, ucc_num, max_speed = 0;
> -   const phandle *ph;
>     const u32 *fixed_link;
>     const unsigned int *prop;
>     const char *sprop;
> @@ -3626,45 +3627,21 @@ static int ucc_geth_probe(struct of_device* 
ofdev, const struct of_device_id *ma
>     ug_info->uf_info.irq = irq_of_parse_and_map(np, 0);
>     fixed_link = of_get_property(np, "fixed-link", NULL);
>     if (fixed_link) {
> -      snprintf(ug_info->phy_bus_id, sizeof(ug_info->phy_bus_id),
> -          PHY_ID_FMT, "0", fixed_link[0]);
>        phy = NULL;

phy assigned to NULL ...

>     } else {
> -      char bus_name[MII_BUS_ID_SIZE];
> -
> -      ph = of_get_property(np, "phy-handle", NULL);
> -      phy = of_find_node_by_phandle(*ph);
> -
> +      phy = of_parse_phandle(np, "phy-handle", 0);
>        if (phy == NULL)
>           return -ENODEV;
> -
> -      /* set the PHY address */
> -      prop = of_get_property(phy, "reg", NULL);
> -      if (prop == NULL)
> -         return -1;
> -
> -      /* Set the bus id */
> -      mdio = of_get_parent(phy);
> -
> -      if (mdio == NULL)
> -         return -ENODEV;
> -
> -      err = of_address_to_resource(mdio, 0, &res);
> -
> -      if (err) {
> -         of_node_put(mdio);
> -         return err;
> -      }
> -      fsl_pq_mdio_bus_name(bus_name, mdio);
> -      of_node_put(mdio);
> -      snprintf(ug_info->phy_bus_id, sizeof(ug_info->phy_bus_id),
> -         "%s:%02x", bus_name, *prop);
>     }
> +   ug_info->phy_node = phy;
> 
>     /* get the phy interface type, or default to MII */
>     prop = of_get_property(np, "phy-connection-type", NULL);
>     if (!prop) {
>        /* handle interface property present in old trees */
> +      if (!phy)
> +         return -ENODEV;

.. here an error is returned. Is this intentional?

> +
>        prop = of_get_property(phy, "interface", NULL);
>        if (prop != NULL) {
>           phy_interface = enet_to_phy_interface[*prop];
> diff --git a/drivers/net/ucc_geth.h b/drivers/net/ucc_geth.h
> index 2f8ee7c..bc31975 100644
> --- a/drivers/net/ucc_geth.h
> +++ b/drivers/net/ucc_geth.h
> @@ -1100,7 +1100,7 @@ struct ucc_geth_info {
>     u32 eventRegMask;
>     u16 pausePeriod;
>     u16 extensionField;
> -   char phy_bus_id[BUS_ID_SIZE];
> +   struct device_node *phy_node;
>     u8 weightfactor[NUM_TX_QUEUES];
>     u8 interruptcoalescingmaxvalue[NUM_RX_QUEUES];
>     u8 l2qt[UCC_GETH_VLAN_PRIORITY_MAX];
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
