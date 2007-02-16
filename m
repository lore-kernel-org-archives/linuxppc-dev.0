Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B1F01DDDF8
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 11:50:50 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1G0ojGA026842
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:50:45 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1G0ojVE250060
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:50:45 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1G0ojR7001757
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:50:45 -0500
Date: Thu, 15 Feb 2007 18:50:44 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 7/12] spidernet: move medium variable into card struct
Message-ID: <20070216005044.GG8192@austin.ibm.com>
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


This moves the medium variable into the spidernet card structure.
It renames the GMII_ variables to BCM54XX specific ones.

Signed-off-by: Jens Osterkamp <jens@de.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |   14 +++++++-------
 drivers/net/spider_net.h |    2 ++
 2 files changed, 9 insertions(+), 7 deletions(-)

Index: linux-2.6.20-git4/drivers/net/spider_net.c
===================================================================
--- linux-2.6.20-git4.orig/drivers/net/spider_net.c	2007-02-15 17:55:19.000000000 -0600
+++ linux-2.6.20-git4/drivers/net/spider_net.c	2007-02-15 17:57:55.000000000 -0600
@@ -1909,26 +1909,26 @@ static void spider_net_link_phy(unsigned
 
 		pr_info("%s: link is down trying to bring it up\n", card->netdev->name);
 
-		switch (phy->medium) {
-		case GMII_COPPER:
+		switch (card->medium) {
+		case BCM54XX_COPPER:
 			/* enable fiber with autonegotiation first */
 			if (phy->def->ops->enable_fiber)
 				phy->def->ops->enable_fiber(phy, 1);
-			phy->medium = GMII_FIBER;
+			card->medium = BCM54XX_FIBER;
 			break;
 
-		case GMII_FIBER:
+		case BCM54XX_FIBER:
 			/* fiber didn't come up, try to disable fiber autoneg */
 			if (phy->def->ops->enable_fiber)
 				phy->def->ops->enable_fiber(phy, 0);
-			phy->medium = GMII_UNKNOWN;
+			card->medium = BCM54XX_UNKNOWN;
 			break;
 
-		case GMII_UNKNOWN:
+		case BCM54XX_UNKNOWN:
 			/* copper, fiber with and without failed,
 			 * retry from beginning */
 			spider_net_setup_aneg(card);
-			phy->medium = GMII_COPPER;
+			card->medium = BCM54XX_COPPER;
 			break;
 		}
 
Index: linux-2.6.20-git4/drivers/net/spider_net.h
===================================================================
--- linux-2.6.20-git4.orig/drivers/net/spider_net.h	2007-02-15 17:54:57.000000000 -0600
+++ linux-2.6.20-git4/drivers/net/spider_net.h	2007-02-15 17:57:55.000000000 -0600
@@ -444,6 +444,8 @@ struct spider_net_card {
 	struct pci_dev *pdev;
 	struct mii_phy phy;
 
+	int medium;
+
 	void __iomem *regs;
 
 	struct spider_net_descr_chain tx_chain;
