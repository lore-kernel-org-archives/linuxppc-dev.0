Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A246DDDF9
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 07:29:41 +1000 (EST)
Subject: [PATCH] ibm_newemac: Don't call dev_mc_add() before device is
	registered
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Content-Type: text/plain
Date: Mon, 18 Aug 2008 07:29:23 +1000
Message-Id: <1219008563.28339.15.camel@pasglop>
Mime-Version: 1.0
Cc: netdev <netdev@vger.kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We must not call dev_mc_add() from within our HW configure which happens
before we initialize and register the netdev. Do it in open() instead.

Thanks to Sebastian Siewior for tracking it down. 

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This fixes an uninitialized spinlock warning (and possibly more).

Please apply.

Cheers,
Ben.

Index: linux-work/drivers/net/ibm_newemac/core.c
===================================================================
--- linux-work.orig/drivers/net/ibm_newemac/core.c	2008-08-14 13:36:10.000000000 +1000
+++ linux-work/drivers/net/ibm_newemac/core.c	2008-08-14 13:42:10.000000000 +1000
@@ -663,9 +663,6 @@ static int emac_configure(struct emac_in
 	if (emac_phy_gpcs(dev->phy.mode))
 		emac_mii_reset_phy(&dev->phy);
 
-	/* Required for Pause packet support in EMAC */
-	dev_mc_add(ndev, default_mcast_addr, sizeof(default_mcast_addr), 1);
-
 	return 0;
 }
 
@@ -1150,6 +1147,9 @@ static int emac_open(struct net_device *
 	} else
 		netif_carrier_on(dev->ndev);
 
+	/* Required for Pause packet support in EMAC */
+	dev_mc_add(ndev, default_mcast_addr, sizeof(default_mcast_addr), 1);
+
 	emac_configure(dev);
 	mal_poll_add(dev->mal, &dev->commac);
 	mal_enable_tx_channel(dev->mal, dev->mal_tx_chan);


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
