Return-Path: <linas@austin.ibm.com>
Date: Tue, 22 May 2007 18:36:24 -0500
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/10] spidernet: zero out a pointer.
Message-ID: <20070522233624.GC2147@austin.ibm.com>
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


Invalidate a pointer as its pci_unmap'ed; this is a bit of 
paranoia to make sure hardware doesn't continue trying to 
DMA to it.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: netdev-2.6/drivers/net/spider_net.c
===================================================================
--- netdev-2.6.orig/drivers/net/spider_net.c	2007-05-22 18:03:30.000000000 -0500
+++ netdev-2.6/drivers/net/spider_net.c	2007-05-22 18:03:32.000000000 -0500
@@ -1069,6 +1069,7 @@ spider_net_decode_one_descr(struct spide
 	struct spider_net_descr_chain *chain = &card->rx_chain;
 	struct spider_net_descr *descr = chain->tail;
 	struct spider_net_hw_descr *hwdescr = descr->hwdescr;
+	u32 hw_buf_addr;
 	int status;
 
 	status = spider_net_get_descr_status(hwdescr);
@@ -1082,7 +1083,9 @@ spider_net_decode_one_descr(struct spide
 	chain->tail = descr->next;
 
 	/* unmap descriptor */
-	pci_unmap_single(card->pdev, hwdescr->buf_addr,
+	hw_buf_addr = hwdescr->buf_addr;
+	hwdescr->buf_addr = 0x0;
+	pci_unmap_single(card->pdev, hw_buf_addr,
 			SPIDER_NET_MAX_FRAME, PCI_DMA_FROMDEVICE);
 
 	if ( (status == SPIDER_NET_DESCR_RESPONSE_ERROR) ||
@@ -1118,7 +1121,7 @@ spider_net_decode_one_descr(struct spide
 		pr_err("%s: bad status, cmd_status=x%08x\n",
 			       card->netdev->name,
 			       hwdescr->dmac_cmd_status);
-		pr_err("buf_addr=x%08x\n", hwdescr->buf_addr);
+		pr_err("buf_addr=x%08x\n", hw_buf_addr);
 		pr_err("buf_size=x%08x\n", hwdescr->buf_size);
 		pr_err("next_descr_addr=x%08x\n", hwdescr->next_descr_addr);
 		pr_err("result_size=x%08x\n", hwdescr->result_size);
