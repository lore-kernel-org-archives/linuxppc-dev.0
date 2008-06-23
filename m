Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 318B3DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 09:21:05 +1000 (EST)
Subject: Re: [PATCH] ibm_newemac: Fixes entry of short packets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1214225705-25850-1-git-send-email-sr@denx.de>
References: <1214225705-25850-1-git-send-email-sr@denx.de>
Content-Type: text/plain
Date: Tue, 24 Jun 2008 09:20:57 +1000
Message-Id: <1214263257.8011.278.camel@pasglop>
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
> Short packets has to be discarded by the driver. So this patch addresses the
> issue of discarding the short packets of size lesser then ethernet header
> size.

You are freeing the skb, why ? Shouldn't we just keep the skb in the
ring for further rx ?

> Signed-off-by: Sathya Narayanan <sathyan@teamf1.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
>  drivers/net/ibm_newemac/core.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
> index 6dfc2c9..aa407b2 100644
> --- a/drivers/net/ibm_newemac/core.c
> +++ b/drivers/net/ibm_newemac/core.c
> @@ -1652,6 +1652,13 @@ static int emac_poll_rx(void *param, int budget)
>  
>  		skb_put(skb, len);
>  	push_packet:
> +		if (skb->len < ETH_HLEN) {
> +			dev_kfree_skb(skb);
> +			printk(KERN_WARNING "%s: short packets dropped\n",
> +			       dev->ndev->name);
> +			++dev->estats.rx_dropped_stack;
> +			goto next;
> +		}
>  		skb->dev = dev->ndev;
>  		skb->protocol = eth_type_trans(skb, dev->ndev);
>  		emac_rx_csum(dev, skb, ctrl);
