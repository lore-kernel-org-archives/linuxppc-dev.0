Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BBC61DDF29
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:48 +1000 (EST)
Message-Id: <20070705170234.763784000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:38 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 05/35] pasemi_mac: Clean TX ring in poll
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Clean the TX ring in the poll call, to avoid sitting on mapped buffers
for a long time. NFS doesn't seem to like it much, for example.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: netdev-2.6/drivers/net/pasemi_mac.c
===================================================================
--- netdev-2.6.orig/drivers/net/pasemi_mac.c
+++ netdev-2.6/drivers/net/pasemi_mac.c
@@ -1052,6 +1052,7 @@ static int pasemi_mac_poll(struct net_de
 	int pkts, limit = min(*budget, dev->quota);
 	struct pasemi_mac *mac = netdev_priv(dev);
 
+	pasemi_mac_clean_tx(mac);
 	pkts = pasemi_mac_clean_rx(mac, limit);
 
 	dev->quota -= pkts;

--
