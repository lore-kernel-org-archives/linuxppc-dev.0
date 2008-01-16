Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B1EEDDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 18:16:07 +1100 (EST)
Subject: Re: [PATCH] net: NEWEMAC: Fix problem with mtu > 4080 on non TAH
	equipped 4xx PPC's
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1200467475-1663-1-git-send-email-sr@denx.de>
References: <1200467475-1663-1-git-send-email-sr@denx.de>
Content-Type: text/plain
Date: Wed, 16 Jan 2008 18:15:44 +1100
Message-Id: <1200467744.6755.18.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-01-16 at 08:11 +0100, Stefan Roese wrote:
> Currently, all non TAH equipped 4xx PPC's call emac_start_xmit() upon
> xmit. This routine doesn't check if the frame length exceeds the max.
> MAL buffer size.
> 
> This patch now changes the driver to call emac_start_xmit_sg() on all
> GigE platforms and not only the TAH equipped ones (440GX). This enables
> an MTU of 9000 instead 4080.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Jeff, please pick up for .25.

Ben.

>  drivers/net/ibm_newemac/core.c |   14 ++++----------
>  1 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
> index cb06280..b24bd2d 100644
> --- a/drivers/net/ibm_newemac/core.c
> +++ b/drivers/net/ibm_newemac/core.c
> @@ -1297,7 +1297,6 @@ static int emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	return emac_xmit_finish(dev, len);
>  }
>  
> -#ifdef CONFIG_IBM_NEW_EMAC_TAH
>  static inline int emac_xmit_split(struct emac_instance *dev, int slot,
>  				  u32 pd, int len, int last, u16 base_ctrl)
>  {
> @@ -1410,9 +1409,6 @@ static int emac_start_xmit_sg(struct sk_buff *skb, struct net_device *ndev)
>  	DBG2(dev, "stopped TX queue" NL);
>  	return 1;
>  }
> -#else
> -# define emac_start_xmit_sg	emac_start_xmit
> -#endif	/* !defined(CONFIG_IBM_NEW_EMAC_TAH) */
>  
>  /* Tx lock BHs */
>  static void emac_parse_tx_error(struct emac_instance *dev, u16 ctrl)
> @@ -2683,13 +2679,8 @@ static int __devinit emac_probe(struct of_device *ofdev,
>  
>  	/* Fill in the driver function table */
>  	ndev->open = &emac_open;
> -#ifdef CONFIG_IBM_NEW_EMAC_TAH
> -	if (dev->tah_dev) {
> -		ndev->hard_start_xmit = &emac_start_xmit_sg;
> +	if (dev->tah_dev)
>  		ndev->features |= NETIF_F_IP_CSUM | NETIF_F_SG;
> -	} else
> -#endif
> -		ndev->hard_start_xmit = &emac_start_xmit;
>  	ndev->tx_timeout = &emac_tx_timeout;
>  	ndev->watchdog_timeo = 5 * HZ;
>  	ndev->stop = &emac_close;
> @@ -2697,8 +2688,11 @@ static int __devinit emac_probe(struct of_device *ofdev,
>  	ndev->set_multicast_list = &emac_set_multicast_list;
>  	ndev->do_ioctl = &emac_ioctl;
>  	if (emac_phy_supports_gige(dev->phy_mode)) {
> +		ndev->hard_start_xmit = &emac_start_xmit_sg;
>  		ndev->change_mtu = &emac_change_mtu;
>  		dev->commac.ops = &emac_commac_sg_ops;
> +	} else {
> +		ndev->hard_start_xmit = &emac_start_xmit;
>  	}
>  	SET_ETHTOOL_OPS(ndev, &emac_ethtool_ops);
>  
