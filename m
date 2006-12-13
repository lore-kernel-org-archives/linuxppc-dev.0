Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6EE7E6813E
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 08:25:10 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBDLPYE4005466
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:25:34 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBDLP6ot228572
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:25:06 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBDLP5US032148
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:25:06 -0500
Date: Wed, 13 Dec 2006 15:25:05 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 14/14] Spidernet Rework RX linked list
Message-ID: <20061213212505.GN1915@austin.ibm.com>
References: <20061213210010.GR4329@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061213210010.GR4329@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Jens Osterkamp <Jens.Osterkamp@gmx.de>, jgarzik@pobox.com,
	James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Make the hardware perceive the RX descriptor ring as a 
null-terminated linked list, instead of a circular ring.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-13 14:32:13.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-13 14:33:21.000000000 -0600
@@ -419,9 +419,13 @@ spider_net_prepare_rx_descr(struct spide
 		card->spider_stats.rx_iommu_map_error++;
 		descr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
 	} else {
+		descr->next_descr_addr = 0;
 		wmb();
 		descr->dmac_cmd_status = SPIDER_NET_DESCR_CARDOWNED |
 					 SPIDER_NET_DMAC_NOINTR_COMPLETE;
+
+		wmb();
+		descr->prev->next_descr_addr = descr->bus_addr;
 	}
 
 	return 0;
@@ -1650,7 +1654,6 @@ int
 spider_net_open(struct net_device *netdev)
 {
 	struct spider_net_card *card = netdev_priv(netdev);
-	struct spider_net_descr *descr;
 	int result;
 
 	result = spider_net_init_chain(card, &card->tx_chain);
@@ -1662,13 +1665,6 @@ spider_net_open(struct net_device *netde
 	if (result)
 		goto alloc_rx_failed;
 
-	/* Make a ring of of bus addresses */
-	descr = card->rx_chain.ring;
-	do {
-		descr->next_descr_addr = descr->next->bus_addr;
-		descr = descr->next;
-	} while (descr != card->rx_chain.ring);
-
 	/* Allocate rx skbs */
 	if (spider_net_alloc_rx_skbs(card))
 		goto alloc_skbs_failed;
