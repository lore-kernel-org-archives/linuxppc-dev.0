Return-Path: <linas@austin.ibm.com>
Date: Tue, 22 May 2007 18:13:54 -0500
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/10] spidernet: beautify error messages
Message-ID: <20070522231354.GA2147@austin.ibm.com>
References: <20070522230942.GT5921@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070522230942.GT5921@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, Florin Malita <fmalita@gmail.com>,
	cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Make error messages print which interface they apply to.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |   10 ++++++----
 drivers/net/spider_net.h |    2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

Index: netdev-2.6/drivers/net/spider_net.c
===================================================================
--- netdev-2.6.orig/drivers/net/spider_net.c	2007-05-22 18:03:16.000000000 -0500
+++ netdev-2.6/drivers/net/spider_net.c	2007-05-22 18:03:24.000000000 -0500
@@ -434,7 +434,8 @@ spider_net_prepare_rx_descr(struct spide
 				      bufsize + SPIDER_NET_RXBUF_ALIGN - 1);
 	if (!descr->skb) {
 		if (netif_msg_rx_err(card) && net_ratelimit())
-			pr_err("Not enough memory to allocate rx buffer\n");
+			pr_err("%s: Not enough memory to allocate rx buffer\n",
+			    card->netdev->name);
 		card->spider_stats.alloc_rx_skb_error++;
 		return -ENOMEM;
 	}
@@ -455,7 +456,8 @@ spider_net_prepare_rx_descr(struct spide
 		dev_kfree_skb_any(descr->skb);
 		descr->skb = NULL;
 		if (netif_msg_rx_err(card) && net_ratelimit())
-			pr_err("Could not iommu-map rx buffer\n");
+			pr_err("%s: Could not iommu-map rx buffer\n",
+			      card->netdev->name);
 		card->spider_stats.rx_iommu_map_error++;
 		hwdescr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
 	} else {
@@ -1455,8 +1457,8 @@ spider_net_handle_error_irq(struct spide
 	case SPIDER_NET_GRFAFLLINT: /* fallthrough */
 	case SPIDER_NET_GRMFLLINT:
 		if (netif_msg_intr(card) && net_ratelimit())
-			pr_err("Spider RX RAM full, incoming packets "
-			       "might be discarded!\n");
+			pr_err("%s: Spider RX RAM full, incoming packets "
+			       "might be discarded!\n", card->netdev->name);
 		spider_net_rx_irq_off(card);
 		netif_rx_schedule(card->netdev);
 		show_error = 0;
Index: netdev-2.6/drivers/net/spider_net.h
===================================================================
--- netdev-2.6.orig/drivers/net/spider_net.h	2007-05-21 17:40:49.000000000 -0500
+++ netdev-2.6/drivers/net/spider_net.h	2007-05-22 18:03:24.000000000 -0500
@@ -25,7 +25,7 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
-#define VERSION "2.0 A"
+#define VERSION "2.0 B"
 
 #include "sungem_phy.h"
 
