Return-Path: <linville@tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C52D6688B7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 01:57:34 +1100 (EST)
Date: Thu, 8 Dec 2005 09:57:18 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
Message-ID: <20051208145714.GA16049@tuxdriver.com>
References: <1134045255.28438.4.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1134045255.28438.4.camel@mephisto.spb.rtsoft.ru>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Netpoll controller support for PPC EMAC driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Dec 08, 2005 at 03:34:15PM +0300, Ruslan V. Sushko wrote:
> This patch adds netpoll controller support for PPC EMAC driver
> 
> Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>

Patches in-line are easier to review... :-)

> @@ -1071,8 +1071,16 @@ static int emac_start_xmit(struct sk_buf
>  	struct ocp_enet_private *dev = ndev->priv;
>  	unsigned int len = skb->len;
>  	int slot;
> +	u16 ctrl;
>  
> -	u16 ctrl = EMAC_TX_CTRL_GFCS | EMAC_TX_CTRL_GP | MAL_TX_CTRL_READY |
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +	if (unlikely(dev->tx_cnt == NUM_TX_BUFF)) {
> +		netif_stop_queue(ndev);
> +		return -EBUSY;
> +	}
> +#endif

Why is this necessary?

> +
> +	ctrl = EMAC_TX_CTRL_GFCS | EMAC_TX_CTRL_GP | MAL_TX_CTRL_READY |
>  	    MAL_TX_CTRL_LAST | emac_tx_csum(dev, skb);
>  
>  	slot = dev->tx_slot++;
> @@ -1938,6 +1946,33 @@ static int emac_ioctl(struct net_device 
>  		return -EOPNOTSUPP;
>  	}
>  }
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +void
> +poll_ctrl(struct net_device *dev)
> +{
> +	int budget = 16;
> +	struct ibm_ocp_mal *mal = ((struct ocp_enet_private*)(dev->priv))->mal;
> +	struct net_device *poll_dev = &(mal->poll_dev);
> +
> +	/* disable  MAL interrupts */
> +	mal_disable_eob_irq(mal);
> +	netif_poll_disable(poll_dev);

Is the call to netif_poll_disable necessary?  Aren't NAPI and netpoll
aware of each other?

> +
> +	emac_poll_rx(dev->priv, budget);
> +	emac_poll_tx(dev->priv);
> +
> +	netif_poll_enable(poll_dev);
> +	/* Enable mal interrupts */
> +	mal_enable_eob_irq(mal);
> +}
> +
> +int
> +poll_fake(struct net_device *dev, int *budget)
> +{
> +	/* It will be never invoked */
> +	return 0;
> +}
> +#endif

If it's never invoked, then why define it?

>  
>  static int __init emac_probe(struct ocp_device *ocpdev)
>  {
> @@ -2188,6 +2223,11 @@ static int __init emac_probe(struct ocp_
>  	netif_carrier_off(ndev);
>  	netif_stop_queue(ndev);
>  
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +	ndev->poll_controller = poll_ctrl;
> +	ndev->poll = poll_fake;
> +#endif
> +

->poll is not related to ->poll_controller.  It is for NAPI, not
netpoll.

I'll defer to others to comment on the IBM EMAC manipulation code.
It looked reasonable to me at first glance.

John
-- 
John W. Linville
linville@tuxdriver.com
