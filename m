Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4208tK30XlzDrVP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 23:36:41 +1000 (AEST)
Subject: Re: [PATCH 3/6] net/wan/fsl_ucc_hdlc: Adding ARPHRD_ETHER
To: David Gounaris <david.gounaris@infinera.com>, qiang.zhao@nxp.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180828110921.2542-1-david.gounaris@infinera.com>
 <20180828110921.2542-4-david.gounaris@infinera.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7bb86f0f-d378-69f1-bc39-99f0479b3c09@c-s.fr>
Date: Tue, 28 Aug 2018 15:36:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180828110921.2542-4-david.gounaris@infinera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 28/08/2018 à 13:09, David Gounaris a écrit :
> This was done to avoid discarding ethernet
> packets when using HDLC_ETH protocol.

Maybe use 'present' form instead of 'past form', ie 'This patch is to 
avoid discarding ethernet ...'

Christophe

> 
> Signed-off-by: David Gounaris <david.gounaris@infinera.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 963b3b5ae15e..54e2b2143e36 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -375,6 +375,10 @@ static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
>   		dev->stats.tx_bytes += skb->len;
>   		break;
>   
> +	case ARPHRD_ETHER:
> +		dev->stats.tx_bytes += skb->len;
> +		break;
> +
>   	default:
>   		dev->stats.tx_dropped++;
>   		dev_kfree_skb(skb);
> @@ -512,6 +516,8 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
>   			break;
>   
>   		case ARPHRD_PPP:
> +		case ARPHRD_ETHER:
> +			
>   			length -= HDLC_CRC_SIZE;
>   
>   			skb = dev_alloc_skb(length);
> 
