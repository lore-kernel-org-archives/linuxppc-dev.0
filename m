Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CC1C7DE294
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 02:56:23 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id m2PFuIl1390310
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 15:56:18 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m2PFuHcj2142448
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 16:56:17 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m2PFuG6U001057
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 16:56:17 +0100
From: Thomas Klein <osstklei@de.ibm.com>
To: stable@kernel.org
Subject: [PATCH 2.6.24-stable] ehea: Fix IPv6 support
Date: Tue, 25 Mar 2008 16:56:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200803251656.16065.osstklei@de.ibm.com>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	Hannes Hering <hering2@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Indicate that HEA calculates IPv4 checksums only

Signed-off-by: Thomas Klein <tklein@de.ibm.com>

---
diff -Nurp linux-2.6.24.4.org/drivers/net/ehea/ehea.h linux-2.6.24.4/drivers/net/ehea/ehea.h
--- linux-2.6.24.4.org/drivers/net/ehea/ehea.h	2008-03-25 12:42:18.000000000 +0100
+++ linux-2.6.24.4/drivers/net/ehea/ehea.h	2008-03-25 13:13:29.000000000 +0100
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0083"
+#define DRV_VERSION	"EHEA_0083a"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff -Nurp linux-2.6.24.4.org/drivers/net/ehea/ehea_main.c linux-2.6.24.4/drivers/net/ehea/ehea_main.c
--- linux-2.6.24.4.org/drivers/net/ehea/ehea_main.c	2008-03-25 12:42:18.000000000 +0100
+++ linux-2.6.24.4/drivers/net/ehea/ehea_main.c	2008-03-25 13:13:12.000000000 +0100
@@ -2945,7 +2945,7 @@ struct ehea_port *ehea_setup_single_port
 	dev->vlan_rx_add_vid = ehea_vlan_rx_add_vid;
 	dev->vlan_rx_kill_vid = ehea_vlan_rx_kill_vid;
 	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_TSO
-		      | NETIF_F_HIGHDMA | NETIF_F_HW_CSUM | NETIF_F_HW_VLAN_TX
+		      | NETIF_F_HIGHDMA | NETIF_F_IP_CSUM | NETIF_F_HW_VLAN_TX
 		      | NETIF_F_HW_VLAN_RX | NETIF_F_HW_VLAN_FILTER
 		      | NETIF_F_LLTX;
 	dev->tx_timeout = &ehea_tx_watchdog;
