Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422TTQ3FRyzF39b
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2018 18:11:36 +1000 (AEST)
Subject: Re: [PATCH v2 3/6] net/wan/fsl_ucc_hdlc: Adding ARPHRD_ETHER
To: David Gounaris <david.gounaris@infinera.com>, qiang.zhao@nxp.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org
References: <20180828110921.2542-2-david.gounaris@infinera.com>
 <20180829131328.27901-1-david.gounaris@infinera.com>
 <20180829131328.27901-4-david.gounaris@infinera.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <38fa6ba6-4806-d21b-2bd9-4606d8678da4@c-s.fr>
Date: Sat, 1 Sep 2018 10:05:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180829131328.27901-4-david.gounaris@infinera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/08/2018 à 15:13, David Gounaris a écrit :
> This patch is to avoid discarding ethernet
> packets when using HDLC_ETH protocol.
> 
> Signed-off-by: David Gounaris <david.gounaris@infinera.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index c8e526bf1130..0f703d7be5e0 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -376,6 +376,10 @@ static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
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
> @@ -513,6 +517,8 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
>   			break;
>   
>   		case ARPHRD_PPP:
> +		case ARPHRD_ETHER:
> +			

ERROR:TRAILING_WHITESPACE: trailing whitespace
#34: FILE: drivers/net/wan/fsl_ucc_hdlc.c:520:
+^I^I^I$

Note that 'git show' would show it to you in red background so you 
shouldn't miss it.

And this additional blank line is unnecessary.

>   			length -= HDLC_CRC_SIZE;
>   
>   			skb = dev_alloc_skb(length);
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
