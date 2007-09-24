Return-Path: <mel@skynet.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 73BCADDE1B
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 21:12:53 +1000 (EST)
Date: Mon, 24 Sep 2007 12:12:48 +0100
To: Satyam Sharma <satyam@infradead.org>
Subject: Re: 2.6.23-rc6-mm1: Build failures on ppc64_defconfig
Message-ID: <20070924111248.GC3968@skynet.ie>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<20070920132512.GF24105@skynet.ie>
	<alpine.LFD.0.999.0709201903180.17093@enigma.security.iitk.ac.in>
	<alpine.LFD.0.999.0709221221500.22517@enigma.security.iitk.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <alpine.LFD.0.999.0709221221500.22517@enigma.security.iitk.ac.in>
From: mel@skynet.ie (Mel Gorman)
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jeff@garzik.org,
	Linux Netdev Mailing List <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (22/09/07 12:24), Satyam Sharma didst pronounce:
> 
> 
> On Thu, 20 Sep 2007, Satyam Sharma wrote:
> > 
> > BTW ppc64_defconfig didn't quite like 2.6.23-rc6-mm1 either ...
> > IIRC I got build failures in:
> 
> > drivers/net/spider_net.c
> 
> 
> [PATCH -mm] spider_net: Misc build fixes after recent netdev stats changes
> 
> Unbreak the following:
> 
> drivers/net/spider_net.c: In function 'spider_net_release_tx_chain':
> drivers/net/spider_net.c:818: error: 'dev' undeclared (first use in this function)
> drivers/net/spider_net.c:818: error: (Each undeclared identifier is reported only once
> drivers/net/spider_net.c:818: error: for each function it appears in.)
> drivers/net/spider_net.c: In function 'spider_net_xmit':
> drivers/net/spider_net.c:922: error: 'dev' undeclared (first use in this function)
> drivers/net/spider_net.c: In function 'spider_net_pass_skb_up':
> drivers/net/spider_net.c:1018: error: 'dev' undeclared (first use in this function)
> drivers/net/spider_net.c: In function 'spider_net_decode_one_descr':
> drivers/net/spider_net.c:1215: error: 'dev' undeclared (first use in this function)
> make[2]: *** [drivers/net/spider_net.o] Error 1
> 
> Signed-off-by: Satyam Sharma <satyam@infradead.org>

I've confirmed that this patch fixes the build error in question.

Acked-by: Mel Gorman <mel@csn.ul.ie>

> 
> ---
> 
>  drivers/net/spider_net.c |   24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff -ruNp a/drivers/net/spider_net.c b/drivers/net/spider_net.c
> --- a/drivers/net/spider_net.c	2007-09-22 06:26:39.000000000 +0530
> +++ b/drivers/net/spider_net.c	2007-09-22 12:12:23.000000000 +0530
> @@ -795,6 +795,7 @@ spider_net_set_low_watermark(struct spid
>  static int
>  spider_net_release_tx_chain(struct spider_net_card *card, int brutal)
>  {
> +	struct net_device *dev = card->netdev;
>  	struct spider_net_descr_chain *chain = &card->tx_chain;
>  	struct spider_net_descr *descr;
>  	struct spider_net_hw_descr *hwdescr;
> @@ -919,7 +920,7 @@ spider_net_xmit(struct sk_buff *skb, str
>  	spider_net_release_tx_chain(card, 0);
>  
>  	if (spider_net_prepare_tx_descr(card, skb) != 0) {
> -		dev->stats.tx_dropped++;
> +		netdev->stats.tx_dropped++;
>  		netif_stop_queue(netdev);
>  		return NETDEV_TX_BUSY;
>  	}
> @@ -979,16 +980,12 @@ static void
>  spider_net_pass_skb_up(struct spider_net_descr *descr,
>  		       struct spider_net_card *card)
>  {
> -	struct spider_net_hw_descr *hwdescr= descr->hwdescr;
> -	struct sk_buff *skb;
> -	struct net_device *netdev;
> -	u32 data_status, data_error;
> -
> -	data_status = hwdescr->data_status;
> -	data_error = hwdescr->data_error;
> -	netdev = card->netdev;
> +	struct spider_net_hw_descr *hwdescr = descr->hwdescr;
> +	struct sk_buff *skb = descr->skb;
> +	struct net_device *netdev = card->netdev;
> +	u32 data_status = hwdescr->data_status;
> +	u32 data_error = hwdescr->data_error;
>  
> -	skb = descr->skb;
>  	skb_put(skb, hwdescr->valid_size);
>  
>  	/* the card seems to add 2 bytes of junk in front
> @@ -1015,8 +1012,8 @@ spider_net_pass_skb_up(struct spider_net
>  	}
>  
>  	/* update netdevice statistics */
> -	dev->stats.rx_packets++;
> -	dev->stats.rx_bytes += skb->len;
> +	netdev->stats.rx_packets++;
> +	netdev->stats.rx_bytes += skb->len;
>  
>  	/* pass skb up to stack */
>  	netif_receive_skb(skb);
> @@ -1184,6 +1181,7 @@ static int spider_net_resync_tail_ptr(st
>  static int
>  spider_net_decode_one_descr(struct spider_net_card *card)
>  {
> +	struct net_device *dev = card->netdev;
>  	struct spider_net_descr_chain *chain = &card->rx_chain;
>  	struct spider_net_descr *descr = chain->tail;
>  	struct spider_net_hw_descr *hwdescr = descr->hwdescr;
> @@ -1210,7 +1208,7 @@ spider_net_decode_one_descr(struct spide
>  	     (status == SPIDER_NET_DESCR_PROTECTION_ERROR) ||
>  	     (status == SPIDER_NET_DESCR_FORCE_END) ) {
>  		if (netif_msg_rx_err(card))
> -			dev_err(&card->netdev->dev,
> +			dev_err(&dev->dev,
>  			       "dropping RX descriptor with state %d\n", status);
>  		dev->stats.rx_dropped++;
>  		goto bad_desc;
> 

-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
