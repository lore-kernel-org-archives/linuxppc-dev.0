Return-Path: <osstklei@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 176C4DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 23:55:52 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m2JCtk31201156
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 12:55:46 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m2JCtjWJ2261238
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 12:55:45 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m2JCtjoq004060
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 12:55:45 GMT
From: Thomas Klein <osstklei@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] ehea: Fix IPv6 support
Date: Wed, 19 Mar 2008 13:55:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200803191355.44266.osstklei@de.ibm.com>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	Hannes Hering <hering2@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
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
diff -Nurp -X dontdiff linux-2.6.25-rc6/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- linux-2.6.25-rc6/drivers/net/ehea/ehea.h	2008-03-17 00:32:14.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea.h	2008-03-19 08:58:07.000000000 +0100
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0087"
+#define DRV_VERSION	"EHEA_0089"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff -Nurp -X dontdiff linux-2.6.25-rc6/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.25-rc6/drivers/net/ehea/ehea_main.c	2008-03-17 00:32:14.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2008-03-19 08:58:07.000000000 +0100
@@ -3108,7 +3108,7 @@ struct ehea_port *ehea_setup_single_port
 	dev->vlan_rx_add_vid = ehea_vlan_rx_add_vid;
 	dev->vlan_rx_kill_vid = ehea_vlan_rx_kill_vid;
 	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_TSO
-		      | NETIF_F_HIGHDMA | NETIF_F_HW_CSUM | NETIF_F_HW_VLAN_TX
+		      | NETIF_F_HIGHDMA | NETIF_F_IP_CSUM | NETIF_F_HW_VLAN_TX
 		      | NETIF_F_HW_VLAN_RX | NETIF_F_HW_VLAN_FILTER
 		      | NETIF_F_LLTX;
 	dev->tx_timeout = &ehea_tx_watchdog;
