Return-Path: <linas@austin.ibm.com>
Date: Tue, 22 May 2007 18:47:25 -0500
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 9/10] spidernet: service TX later.
Message-ID: <20070522234725.GH2147@austin.ibm.com>
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


When entering the netdev poll routine, empty out the RX
chain first, before cleaning up the TX chain. This should
help avoid RX buffer overflows.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: netdev-2.6/drivers/net/spider_net.c
===================================================================
--- netdev-2.6.orig/drivers/net/spider_net.c	2007-05-22 18:03:39.000000000 -0500
+++ netdev-2.6/drivers/net/spider_net.c	2007-05-22 18:03:41.000000000 -0500
@@ -1212,7 +1212,6 @@ spider_net_poll(struct net_device *netde
 	int packets_to_do, packets_done = 0;
 	int no_more_packets = 0;
 
-	spider_net_cleanup_tx_ring(card);
 	packets_to_do = min(*budget, netdev->quota);
 
 	while (packets_to_do) {
@@ -1231,6 +1230,8 @@ spider_net_poll(struct net_device *netde
 	spider_net_refill_rx_chain(card);
 	spider_net_enable_rxdmac(card);
 
+	spider_net_cleanup_tx_ring(card);
+
 	/* if all packets are in the stack, enable interrupts and return 0 */
 	/* if not, return 1 */
 	if (no_more_packets) {
