Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B425667BCE
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 07:22:35 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9ALMX3G003154
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:22:33 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9ALMUC1354782
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:22:30 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9ALMUwo005441
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:22:30 -0600
Date: Tue, 10 Oct 2006 16:22:29 -0500
To: akpm@osdl.org
Subject: [PATCH 20/21]: powerpc/cell spidernet release all descrs
Message-ID: <20061010212229.GQ4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Bugfix: rx descriptor release function fails to visit
the last entry while walking receive descriptor ring.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:37:40.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:40:56.000000000 -0500
@@ -358,7 +358,7 @@ spider_net_free_rx_chain_contents(struct
 	struct spider_net_descr *descr;
 
 	descr = card->rx_chain.head;
-	while (descr->next != card->rx_chain.head) {
+	do {
 		if (descr->skb) {
 			dev_kfree_skb(descr->skb);
 			pci_unmap_single(card->pdev, descr->buf_addr,
@@ -366,7 +366,7 @@ spider_net_free_rx_chain_contents(struct
 					 PCI_DMA_BIDIRECTIONAL);
 		}
 		descr = descr->next;
-	}
+	} while (descr != card->rx_chain.head);
 }
 
 /**
