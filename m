Return-Path: <jens@de.ibm.com>
From: Jens Osterkamp <jens@de.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>, James K Lewis <jim@jklewis.com>,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jgarzik@pobox.com,
	cbe-oss-dev@ozlabs.org, Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: [PATCH] spidernet : fix memory leak in spider_net_stop
Date: Thu, 1 Feb 2007 12:07:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702011207.47421.jens@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We forget to call spider_net_free_rx_chain_contents which does the
actual dev_kfree_skb. New skbs are allocated from skbuff_head_cache
on each "ifconfig up" letting the cache grow infinitely.

This patch fixes it.

Signed-off-by: Jens Osterkamp <jens@de.ibm.com>

Index: linux-2.6.20-rc6/drivers/net/spider_net.c
===================================================================
--- linux-2.6.20-rc6.orig/drivers/net/spider_net.c
+++ linux-2.6.20-rc6/drivers/net/spider_net.c
@@ -1925,6 +1925,8 @@ spider_net_stop(struct net_device *netde
 	/* release chains */
 	spider_net_release_tx_chain(card, 1);
 
+	spider_net_free_rx_chain_contents(card);
+
 	spider_net_free_chain(card, &card->tx_chain);
 	spider_net_free_chain(card, &card->rx_chain);
 
