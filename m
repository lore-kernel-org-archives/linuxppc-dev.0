Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36DCEDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 11:44:32 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1G0iOIn020510
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:44:24 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1G0iO9l303890
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:44:24 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1G0iNLp027622
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:44:23 -0500
Date: Thu, 15 Feb 2007 18:44:23 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/12]: spidernet: compile break.
Message-ID: <20070216004423.GB8192@austin.ibm.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<45D3EAA7.80805@garzik.org>
	<1171525923.20192.243.camel@localhost.localdomain>
	<200702151141.49708.jens@de.ibm.com>
	<20070215171414.GU923@austin.ibm.com>
	<1171572392.5644.15.camel@localhost.localdomain>
	<20070216001857.GC923@austin.ibm.com>
	<20070216004325.GA8192@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070216004325.GA8192@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Subject: [PATCH 2/12]: spidernet: compile break.

As of 2.6.20-git4, the spider_net driver does not compile. 
This appears to be due to some archaic usage involving kobjects.

It also fixes a nasty double-free during ifdown of the interface.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

----
 drivers/net/spider_net.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6.20-git4/drivers/net/spider_net.c
===================================================================
--- linux-2.6.20-git4.orig/drivers/net/spider_net.c	2007-02-15 17:50:33.000000000 -0600
+++ linux-2.6.20-git4/drivers/net/spider_net.c	2007-02-15 17:52:04.000000000 -0600
@@ -1906,8 +1906,7 @@ spider_net_stop(struct net_device *netde
 	spider_net_write_reg(card, SPIDER_NET_GHIINT1MSK, 0);
 	spider_net_write_reg(card, SPIDER_NET_GHIINT2MSK, 0);
 
-	/* free_irq(netdev->irq, netdev);*/
-	free_irq(to_pci_dev(netdev->class_dev.dev)->irq, netdev);
+	free_irq(netdev->irq, netdev);
 
 	spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
 			     SPIDER_NET_DMA_TX_FEND_VALUE);
@@ -1919,8 +1918,6 @@ spider_net_stop(struct net_device *netde
 	spider_net_release_tx_chain(card, 1);
 	spider_net_free_rx_chain_contents(card);
 
-	spider_net_free_rx_chain_contents(card);
-
 	spider_net_free_chain(card, &card->tx_chain);
 	spider_net_free_chain(card, &card->rx_chain);
 
