Return-Path: <linas@austin.ibm.com>
Date: Thu, 1 Feb 2007 11:36:18 -0600
To: Jens Osterkamp <jens@de.ibm.com>
Subject: Re: [PATCH] spidernet : fix memory leak in spider_net_stop
Message-ID: <20070201173618.GI5616@austin.ibm.com>
References: <200702011207.47421.jens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702011207.47421.jens@de.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com, James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


A variant of this patch is queued up for 2.6.21,
as a part of the patch
http://www.mail-archive.com/netdev@vger.kernel.org/msg28213.html

I beleive its in the -mm tree, I have not checked.

--linas

On Thu, Feb 01, 2007 at 12:07:47PM +0100, Jens Osterkamp wrote:
> 
> We forget to call spider_net_free_rx_chain_contents which does the
> actual dev_kfree_skb. New skbs are allocated from skbuff_head_cache
> on each "ifconfig up" letting the cache grow infinitely.
> 
> This patch fixes it.
> 
> Signed-off-by: Jens Osterkamp <jens@de.ibm.com>
> 
> Index: linux-2.6.20-rc6/drivers/net/spider_net.c
> ===================================================================
> --- linux-2.6.20-rc6.orig/drivers/net/spider_net.c
> +++ linux-2.6.20-rc6/drivers/net/spider_net.c
> @@ -1925,6 +1925,8 @@ spider_net_stop(struct net_device *netde
>  	/* release chains */
>  	spider_net_release_tx_chain(card, 1);
>  
> +	spider_net_free_rx_chain_contents(card);
> +
>  	spider_net_free_chain(card, &card->tx_chain);
>  	spider_net_free_chain(card, &card->rx_chain);
>  
