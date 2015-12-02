Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0137.outbound.protection.outlook.com [207.46.100.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DC281A0286
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 08:40:48 +1100 (AEDT)
Message-ID: <1449092431.29246.156.camel@freescale.com>
Subject: Re: [net-next v4 4/8] dpaa_eth: add driver's Tx queue selection
From: Scott Wood <scottwood@freescale.com>
To: <madalin.bucur@freescale.com>, <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <igal.liberman@freescale.com>,
 <roy.pledge@freescale.com>, <ppc@mindchasers.com>, <joe@perches.com>,
 <pebolle@tiscali.nl>, <joakim.tjernlund@transmode.se>,
 <gregkh@linuxfoundation.org>
Date: Wed, 2 Dec 2015 15:40:31 -0600
In-Reply-To: <1446485500-9782-5-git-send-email-madalin.bucur@freescale.com>
References: <1446485500-9782-1-git-send-email-madalin.bucur@freescale.com>
 <1446485500-9782-5-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-11-02 at 19:31 +0200, Madalin Bucur wrote:
> Allow the selection of the transmission queue based on the CPU id.

Explain why.

> 
> Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
> ---
>  drivers/net/ethernet/freescale/dpaa/Kconfig           | 10 ++++++++++
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c        |  3 +++
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.h        |  6 ++++++
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.c |  8 ++++++++
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.h |  4 ++++
>  5 files changed, 31 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa/Kconfig
> b/drivers/net/ethernet/freescale/dpaa/Kconfig
> index 022d5aa..2577aac 100644
> --- a/drivers/net/ethernet/freescale/dpaa/Kconfig
> +++ b/drivers/net/ethernet/freescale/dpaa/Kconfig
> @@ -11,6 +11,16 @@ menuconfig FSL_DPAA_ETH
>  
>  if FSL_DPAA_ETH
>  
> +config FSL_DPAA_ETH_USE_NDO_SELECT_QUEUE
> +	bool "Use driver's Tx queue selection mechanism"
> +	default y
> +	---help---
> +	  The DPAA Ethernet driver defines a ndo_select_queue() callback
> for optimal selection
> +	  of the egress FQ. That will override the XPS support for this
> netdevice.
> +	  If for whatever reason you want to be in control of the egress FQ
> -to-CPU selection and mapping,
> +	  or simply don't want to use the driver's ndo_select_queue()
> callback, then unselect this
> +	  and use the standard XPS support instead.

Is there a use case for needing this to be configurable?

> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index 31d55b4..894f1a7 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -390,6 +390,9 @@ static const struct net_device_ops dpa_private_ops = {
>  	.ndo_get_stats64 = dpa_get_stats64,
>  	.ndo_set_mac_address = dpa_set_mac_address,
>  	.ndo_validate_addr = eth_validate_addr,
> +#ifdef CONFIG_FSL_DPAA_ETH_USE_NDO_SELECT_QUEUE
> +	.ndo_select_queue = dpa_select_queue,
> +#endif
>  	.ndo_change_mtu = dpa_change_mtu,
>  	.ndo_set_rx_mode = dpa_set_rx_mode,
>  	.ndo_init = dpa_ndo_init,
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> index 1ba6617..87577cf 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> @@ -420,9 +420,15 @@ static inline void _dpa_assign_wq(struct dpa_fq *fq)
>  	}
>  }
>  
> +#ifdef CONFIG_FSL_DPAA_ETH_USE_NDO_SELECT_QUEUE
> +/* Use in lieu of skb_get_queue_mapping() */
> +#define dpa_get_queue_mapping(skb) \
> +	raw_smp_processor_id()
> +#else
>  /* Use the queue selected by XPS */
>  #define dpa_get_queue_mapping(skb) \
>  	skb_get_queue_mapping(skb)
> +#endif

Why is this necessary?  Shouldn't providing a custom .ndo_select_queue() be
sufficient to ensure that skb_get_queue_mapping() returns the same thing?

And if this goes away, it's just a matter of a function pointer, so if it does
need to be configurable it could be a runtime option.

-Scott
