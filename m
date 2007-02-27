Return-Path: <kaber@trash.net>
Received: from stinky.trash.net (stinky.trash.net [213.144.137.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E8EFDDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 04:13:56 +1100 (EST)
Message-ID: <45E46208.3000003@trash.net>
Date: Tue, 27 Feb 2007 17:53:28 +0100
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 2/2] ehea: NAPI multi queue TX/RX path for SMP
References: <200702271732.51829.ossthema@de.ibm.com>
In-Reply-To: <200702271732.51829.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan-Bernd Themann wrote:
> This patch provides a functionality that allows parallel 
> RX processing on multiple RX queues by using dummy netdevices.
> 
>  
> +static inline int ehea_hash_skb(struct sk_buff *skb, int num_qps)
> +{
> +	u32 tmp;
> +	if ((skb->nh.iph->protocol == IPPROTO_TCP)
> +	    && skb->protocol == ETH_P_IP) {

skb->protocol has network byte order. The ETH_P_IP test should also
logically come before checking the IP protocol.

> +		tmp = (skb->h.th->source + (skb->h.th->dest << 16)) % 31;

Only locally generated packets have a valid h.th pointer.

> +		tmp += skb->nh.iph->daddr % 31;
> +		return tmp % num_qps;
> +	}
> +	else
> +		return 0;
> +}
> +
>  static int ehea_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct ehea_port *port = netdev_priv(dev);
> @@ -1796,9 +1818,18 @@ static int ehea_start_xmit(struct sk_buf
>  	unsigned long flags;
>  	u32 lkey;
>  	int swqe_index;
> -	struct ehea_port_res *pr = &port->port_res[0];
> +	struct ehea_port_res *pr;
> +
> +	pr = &port->port_res[ehea_hash_skb(skb, port->num_tx_qps)];
> +
