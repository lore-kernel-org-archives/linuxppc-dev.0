Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D119DDEE8
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 09:22:00 +1000 (EST)
Subject: Re: [PATCH] ibm_newemac: Fixes memory leak in ibm_newemac ethernet
	driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1214225712-25882-1-git-send-email-sr@denx.de>
References: <1214225712-25882-1-git-send-email-sr@denx.de>
Content-Type: text/plain
Date: Tue, 24 Jun 2008 09:21:50 +1000
Message-Id: <1214263310.8011.280.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sathya Narayanan <sathyan@teamf1.com>,
	netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-06-23 at 14:55 +0200, Stefan Roese wrote:
> From: Sathya Narayanan <sathyan@teamf1.com>
> 
> This patch addresses the memory leak happenning in drivers transmit queue
> under heavy load condition. Once the transmit queue becomes full, driver
> does an automatic wrapup of queue. During which the untransmitted SKB's are
> lost without getting freed up.

This would be a bug. We should stop the queue when full instead.

> Signed-off-by: Sathya Narayanan <sathyan@teamf1.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
>  drivers/net/ibm_newemac/core.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
> index aa407b2..ee868b6 100644
> --- a/drivers/net/ibm_newemac/core.c
> +++ b/drivers/net/ibm_newemac/core.c
> @@ -1328,6 +1328,13 @@ static int emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  
>  	DBG2(dev, "xmit(%u) %d" NL, len, slot);
>  
> +	if (dev->tx_skb[slot] && dev->tx_desc[slot].data_ptr) {
> +		dev_kfree_skb(dev->tx_skb[slot]);
> +		dev->tx_skb[slot] = NULL;
> +		dev->tx_cnt--;
> +		++dev->estats.tx_dropped;
> +	}
> +
>  	dev->tx_skb[slot] = skb;
>  	dev->tx_desc[slot].data_ptr = dma_map_single(&dev->ofdev->dev,
>  						     skb->data, len,
