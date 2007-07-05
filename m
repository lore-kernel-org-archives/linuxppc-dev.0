Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DAAFDDDF2D
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:48 +1000 (EST)
Message-Id: <20070705170236.697308000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:45 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 12/35] pasemi_mac: Enable LLTX
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Enable LLTX on pasemi_mac: we're already doing sufficient locking
in the driver to enable it.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: netdev-2.6/drivers/net/pasemi_mac.c
===================================================================
--- netdev-2.6.orig/drivers/net/pasemi_mac.c
+++ netdev-2.6/drivers/net/pasemi_mac.c
@@ -1239,7 +1239,7 @@ pasemi_mac_probe(struct pci_dev *pdev, c
 	dev->set_multicast_list = pasemi_mac_set_rx_mode;
 	dev->weight = 64;
 	dev->poll = pasemi_mac_poll;
-	dev->features = NETIF_F_HW_CSUM;
+	dev->features = NETIF_F_HW_CSUM | NETIF_F_LLTX;
 
 	err = pasemi_mac_map_regs(mac);
 	if (err)

--
