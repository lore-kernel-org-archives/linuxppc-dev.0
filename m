Return-Path: <linas@austin.ibm.com>
Date: Tue, 22 May 2007 18:21:15 -0500
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/10] spidernet: move a block of code around
Message-ID: <20070522232115.GB2147@austin.ibm.com>
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


Put the enable and disable routines next to one-another, 
as this makes verifying thier symmetry that much easier.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

Index: netdev-2.6/drivers/net/spider_net.c
===================================================================
--- netdev-2.6.orig/drivers/net/spider_net.c	2007-05-22 18:03:24.000000000 -0500
+++ netdev-2.6/drivers/net/spider_net.c	2007-05-22 18:03:30.000000000 -0500
@@ -506,6 +506,20 @@ spider_net_enable_rxdmac(struct spider_n
 }
 
 /**
+ * spider_net_disable_rxdmac - disables the receive DMA controller
+ * @card: card structure
+ *
+ * spider_net_disable_rxdmac terminates processing on the DMA controller
+ * by turing off the DMA controller, with the force-end flag set.
+ */
+static inline void
+spider_net_disable_rxdmac(struct spider_net_card *card)
+{
+	spider_net_write_reg(card, SPIDER_NET_GDADMACCNTR,
+			     SPIDER_NET_DMA_RX_FEND_VALUE);
+}
+
+/**
  * spider_net_refill_rx_chain - refills descriptors/skbs in the rx chains
  * @card: card structure
  *
@@ -657,20 +671,6 @@ write_hash:
 }
 
 /**
- * spider_net_disable_rxdmac - disables the receive DMA controller
- * @card: card structure
- *
- * spider_net_disable_rxdmac terminates processing on the DMA controller by
- * turing off DMA and issueing a force end
- */
-static void
-spider_net_disable_rxdmac(struct spider_net_card *card)
-{
-	spider_net_write_reg(card, SPIDER_NET_GDADMACCNTR,
-			     SPIDER_NET_DMA_RX_FEND_VALUE);
-}
-
-/**
  * spider_net_prepare_tx_descr - fill tx descriptor with skb data
  * @card: card structure
  * @descr: descriptor structure to fill out
