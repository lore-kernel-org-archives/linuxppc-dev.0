Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3117BDDF96
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 12:54:13 +1100 (EST)
Message-ID: <47EDA13E.3080504@garzik.org>
Date: Fri, 28 Mar 2008 21:54:06 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] ibm_newemac: emac_tx_csum typo fix
References: <20080327144357.GA9111@ru.mvista.com>
In-Reply-To: <20080327144357.GA9111@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak wrote:
> Move the "&& skb->ip_summed == CHECKSUM_PARTIAL" part out of
> emac_has_feature parameters.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  drivers/net/ibm_newemac/core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -pruN linux-2.6.orig/drivers/net/ibm_newemac/core.c linux-2.6/drivers/net/ibm_newemac/core.c
> --- linux-2.6.orig/drivers/net/ibm_newemac/core.c	2008-02-21 16:45:36.000000000 +0300
> +++ linux-2.6/drivers/net/ibm_newemac/core.c	2008-02-22 19:55:29.000000000 +0300
> @@ -1235,8 +1235,8 @@ static int emac_close(struct net_device 
>  static inline u16 emac_tx_csum(struct emac_instance *dev,
>  			       struct sk_buff *skb)
>  {
> -	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH &&
> -			     skb->ip_summed == CHECKSUM_PARTIAL)) {
> +	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH) &&
> +		(skb->ip_summed == CHECKSUM_PARTIAL)) {
>  		++dev->stats.tx_packets_csum;
>  		return EMAC_TX_CTRL_TAH_CSUM;

applied
