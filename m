Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 15EAFB6F18
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2011 14:33:59 +1100 (EST)
Received: by gyg4 with SMTP id 4so1486544gyg.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 20:33:57 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 12 Oct 2011 21:33:54 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH] ll_temac: Add support for ethtool
Message-ID: <20111013033354.GC15829@ponder.secretlab.ca>
References: <1318420049-23019-1-git-send-email-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318420049-23019-1-git-send-email-ricardo.ribalda@gmail.com>
Cc: linux-netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, ville.sundell@digilent.ro, dhlii@dlasys.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 12, 2011 at 01:47:29PM +0200, Ricardo Ribalda Delgado wrote:
> This patch enables the ethtool interface. The implementation is done
> using the libphy helper functions.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Looks good to me.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/net/ll_temac_main.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/ll_temac_main.c b/drivers/net/ll_temac_main.c
> index 728fe41..91a9804 100644
> --- a/drivers/net/ll_temac_main.c
> +++ b/drivers/net/ll_temac_main.c
> @@ -957,6 +957,32 @@ static const struct attribute_group temac_attr_group = {
>  	.attrs = temac_device_attrs,
>  };
>  
> +/* ethtool support */
> +static int temac_get_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
> +{
> +	struct temac_local *lp = netdev_priv(ndev);
> +	return phy_ethtool_gset(lp->phy_dev, cmd);
> +}
> +
> +static int temac_set_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
> +{
> +	struct temac_local *lp = netdev_priv(ndev);
> +	return phy_ethtool_sset(lp->phy_dev, cmd);
> +}
> +
> +static int temac_nway_reset(struct net_device *ndev)
> +{
> +	struct temac_local *lp = netdev_priv(ndev);
> +	return phy_start_aneg(lp->phy_dev);
> +}
> +
> +static const struct ethtool_ops temac_ethtool_ops = {
> +	.get_settings = temac_get_settings,
> +	.set_settings = temac_set_settings,
> +	.nway_reset = temac_nway_reset,
> +	.get_link = ethtool_op_get_link,
> +};
> +
>  static int __devinit temac_of_probe(struct platform_device *op)
>  {
>  	struct device_node *np;
> @@ -978,6 +1004,7 @@ static int __devinit temac_of_probe(struct platform_device *op)
>  	ndev->flags &= ~IFF_MULTICAST;  /* clear multicast */
>  	ndev->features = NETIF_F_SG | NETIF_F_FRAGLIST;
>  	ndev->netdev_ops = &temac_netdev_ops;
> +	ndev->ethtool_ops= &temac_ethtool_ops;
>  #if 0
>  	ndev->features |= NETIF_F_IP_CSUM; /* Can checksum TCP/UDP over IPv4. */
>  	ndev->features |= NETIF_F_HW_CSUM; /* Can checksum all the packets. */
> -- 
> 1.7.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
