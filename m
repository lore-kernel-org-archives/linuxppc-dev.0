Return-Path: <linas@austin.ibm.com>
Date: Tue, 22 May 2007 18:45:32 -0500
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 8/10] spidernet: reset the card when an rxramfull is seen
Message-ID: <20070522234532.GG2147@austin.ibm.com>
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


Some versions of the spider have a firmware bug, where the
RX ring sequencer goes crazy when the RX RAM on the device
fills up. Appearently the only viable wrkaround is a soft
reset of the card.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

Index: netdev-2.6/drivers/net/spider_net.c
===================================================================
--- netdev-2.6.orig/drivers/net/spider_net.c	2007-05-22 18:03:37.000000000 -0500
+++ netdev-2.6/drivers/net/spider_net.c	2007-05-22 18:03:39.000000000 -0500
@@ -1506,11 +1506,17 @@ spider_net_handle_error_irq(struct spide
 	case SPIDER_NET_GRFBFLLINT: /* fallthrough */
 	case SPIDER_NET_GRFAFLLINT: /* fallthrough */
 	case SPIDER_NET_GRMFLLINT:
-		if (netif_msg_intr(card) && net_ratelimit())
-			pr_err("%s: Spider RX RAM full, incoming packets "
-			       "might be discarded!\n", card->netdev->name);
+		if (netif_msg_intr(card) && net_ratelimit()) {
+			pr_err("%s: Spider RX RAM full, reseting device.\n",
+			       card->netdev->name);
+			show_rx_chain(card);
+		}
 		spider_net_rx_irq_off(card);
 		netif_rx_schedule(card->netdev);
+
+		/* If the card is spewing rxramfulls, then reset */
+		atomic_inc(&card->tx_timeout_task_counter);
+		schedule_work(&card->tx_timeout_task);
 		show_error = 0;
 		break;
 
@@ -2087,6 +2093,8 @@ spider_net_workaround_rxramfull(struct s
 {
 	int i, sequencer = 0;
 
+	printk(KERN_INFO "%s: calling rxramfull workaround\n", card->netdev->name);
+
 	/* cancel reset */
 	spider_net_write_reg(card, SPIDER_NET_CKRCTRL,
 			     SPIDER_NET_CKRCTRL_RUN_VALUE);
