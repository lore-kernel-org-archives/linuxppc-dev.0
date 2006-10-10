Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E50D967C97
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 07:09:43 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9AL9ft4006267
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:09:41 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9AL9fgj535528
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:09:41 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9AL9eI8006926
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:09:41 -0600
Date: Tue, 10 Oct 2006 16:09:40 -0500
To: akpm@osdl.org
Subject: [PATCH 12/21]: powerpc/cell spidernet incorrect offset
Message-ID: <20061010210940.GI4381@austin.ibm.com>
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


Bugfix -- the rx chain is in memory after the tx chain -- 
the offset being used was wrong, resulting in memory corruption
when the size of the rx and tx rings weren't exactly the same.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----

 drivers/net/spider_net.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:01:06.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:03:11.000000000 -0500
@@ -1628,8 +1628,10 @@ spider_net_open(struct net_device *netde
 	if (spider_net_init_chain(card, &card->tx_chain, card->descr,
 			PCI_DMA_TODEVICE, card->tx_desc))
 		goto alloc_tx_failed;
+
+	/* rx_chain is after tx_chain, so offset is descr + tx_count */
 	if (spider_net_init_chain(card, &card->rx_chain,
-			card->descr + card->rx_desc,
+			card->descr + card->tx_desc,
 			PCI_DMA_FROMDEVICE, card->rx_desc))
 		goto alloc_rx_failed;
 
