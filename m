Return-Path: <socketcan@hartkopp.net>
Message-ID: <4B46239E.2000403@hartkopp.net>
Date: Thu, 07 Jan 2010 19:10:38 +0100
From: Oliver Hartkopp <socketcan@hartkopp.net>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH net-next v3 1/3] can: mscan: fix improper return if dlc
	< 8 in start_xmit function
References: <1262873421-6863-1-git-send-email-wg@grandegger.com>
	<1262873421-6863-2-git-send-email-wg@grandegger.com>
In-Reply-To: <1262873421-6863-2-git-send-email-wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Netdev@vger.kernel.org, Devicetree-discuss@lists.ozlabs.org,
	Socketcan-core@lists.berlios.de, Linuxppc-dev@lists.ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfgang Grandegger wrote:

> The start_xmit function of the MSCAN Driver did return improperly if
> the CAN dlc check failed (skb not freed and invalid return code). This
> patch adds a proper check of the frame lenght and data size and returns
> now correctly. 

> @@ -177,8 +177,13 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	int i, rtr, buf_id;
>  	u32 can_id;
>  
> -	if (frame->can_dlc > 8)
> -		return -EINVAL;
> +	if (skb->len != sizeof(*frame) || frame->can_dlc > 8) {
> +		dev_err(dev->dev.parent,
> +			"Dropping non-conform packet: len %u, can_dlc %u\n",
> +			skb->len, frame->can_dlc);
> +		kfree_skb(skb);
> +		return NETDEV_TX_OK;
> +	}
>  

Hi Wolfgang,

i would suggest to remove the dev_err() which may flood the kernel log and add

   dev->stats.tx_dropped++;

instead.

As discussed with DaveM on netdev-ML this 'silent' handling seems to be the
most appropriate approach to deal with invalid skbs.

We should update the other CAN drivers in a similar way, if this is ok for you.

Best regards,
Oliver
