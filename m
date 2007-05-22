Return-Path: <linas@austin.ibm.com>
Date: Tue, 22 May 2007 18:42:26 -0500
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 7/10] spidernet: enhance the dump routine
Message-ID: <20070522234226.GF2147@austin.ibm.com>
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


Crazy device problems are hard to debug, when one does not have
good trace info. This patch makes a major enhancement to the
device dump routine.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |   62 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 8 deletions(-)

Index: netdev-2.6/drivers/net/spider_net.c
===================================================================
--- netdev-2.6.orig/drivers/net/spider_net.c	2007-05-22 18:03:35.000000000 -0500
+++ netdev-2.6/drivers/net/spider_net.c	2007-05-22 18:03:37.000000000 -0500
@@ -1024,34 +1024,78 @@ spider_net_pass_skb_up(struct spider_net
 	netif_receive_skb(skb);
 }
 
-#ifdef DEBUG
 static void show_rx_chain(struct spider_net_card *card)
 {
 	struct spider_net_descr_chain *chain = &card->rx_chain;
 	struct spider_net_descr *start= chain->tail;
 	struct spider_net_descr *descr= start;
+	struct spider_net_hw_descr *hwd = start->hwdescr;
+	char *iface = card->netdev->name;
+	u32 curr_desc, next_desc;
 	int status;
 
 	int cnt = 0;
-	int cstat = spider_net_get_descr_status(descr);
-	printk(KERN_INFO "RX chain tail at descr=%ld\n",
-	     (start - card->descr) - card->tx_chain.num_desc);
+	int off = 0;
+	int cstat = hwd->dmac_cmd_status;
+
+	printk(KERN_INFO "%s: Total number of descrs=%d\n",
+		iface, chain->num_desc);
+	printk(KERN_INFO "%s: Chain tail located at descr=%d\n",
+		iface, (int) (start - chain->ring));
+
+	curr_desc = spider_net_read_reg(card, SPIDER_NET_GDACTDPA);
+	next_desc = spider_net_read_reg(card, SPIDER_NET_GDACNEXTDA);
+
 	status = cstat;
 	do
 	{
-		status = spider_net_get_descr_status(descr);
+		hwd = descr->hwdescr;
+		off = descr - chain->ring;
+		if (descr==chain->head)
+			printk(KERN_INFO "%s: chain head is at %d\n", iface, off);
+		if (curr_desc == descr->bus_addr)
+			printk(KERN_INFO "%s: hw curr desc is at %d\n", iface, off);
+		if (next_desc == descr->bus_addr)
+			printk(KERN_INFO "%s: hw next desc is at %d\n", iface, off);
+		if (hwd->next_descr_addr == 0)
+			printk(KERN_INFO "%s: chain is cut at %d\n", iface, off);
+		status = hwd->dmac_cmd_status;
 		if (cstat != status) {
-			printk(KERN_INFO "Have %d descrs with stat=x%08x\n", cnt, cstat);
+			printk(KERN_INFO "%s: Have %d descrs with stat=x%08x\n",
+				iface, cnt, cstat);
 			cstat = status;
 			cnt = 0;
 		}
 		cnt ++;
 		descr = descr->next;
 	} while (descr != start);
-	printk(KERN_INFO "Last %d descrs with stat=x%08x\n", cnt, cstat);
-}
+	printk(KERN_INFO "%s: Last %d descrs with stat=x%08x\n",
+		iface, cnt, cstat);
+
+#ifdef DEBUG
+	/* Now dump the whole ring */
+	descr = start;
+	do
+	{
+		struct spider_net_hw_descr *hwd = descr->hwdescr;
+		status = spider_net_get_descr_status(hwd);
+		cnt = descr - chain->ring;
+		printk(KERN_INFO "Descr %d stat=0x%08x skb=%p\n",
+			cnt, status, descr->skb);
+		printk(KERN_INFO "bus addr=%08x buf addr=%08x sz=%d\n",
+			descr->bus_addr, hwd->buf_addr, hwd->buf_size);
+		printk(KERN_INFO "next=%08x result sz=%d valid sz=%d\n",
+			hwd->next_descr_addr, hwd->result_size, hwd->valid_size);
+		printk(KERN_INFO "dmac=%08x data stat=%08x data err=%08x\n",
+			hwd->dmac_cmd_status, hwd->data_status, hwd->data_error);
+		printk(KERN_INFO "\n");
+
+		descr = descr->next;
+	} while (descr != start);
 #endif
 
+}
+
 /**
  * spider_net_decode_one_descr - processes an RX descriptor
  * @card: card structure
@@ -1141,6 +1185,8 @@ spider_net_decode_one_descr(struct spide
 	return 1;
 
 bad_desc:
+	if (netif_msg_rx_err(card))
+		show_rx_chain(card);
 	dev_kfree_skb_irq(descr->skb);
 	descr->skb = NULL;
 	hwdescr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
