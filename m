Return-Path: <tklein@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CCE4ADDDCA
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 01:52:14 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id n0LEq6lv089442
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 14:52:06 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id n0LEq6AD3535014
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 15:52:06 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n0LEq5fX026910
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 15:52:05 +0100
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 1/3] ehea: Use net_device_ops structure
From: Thomas Klein <tklein@de.ibm.com>
Date: Wed, 21 Jan 2009 15:49:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901211549.01120.tklein@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>, Hannes Hering <hering2@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <ossthema@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adapt to lately introduced net_device_ops structure.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>

---
diff -Nurp -X dontdiff linux-2.6.29/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- linux-2.6.29/drivers/net/ehea/ehea.h	2009-01-16 12:03:27.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea.h	2009-01-20 15:10:28.000000000 +0100
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0096"
+#define DRV_VERSION	"EHEA_0097"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff -Nurp -X dontdiff linux-2.6.29/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.29/drivers/net/ehea/ehea_main.c	2009-01-16 12:03:27.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2009-01-20 15:10:28.000000000 +0100
@@ -3069,6 +3069,22 @@ static void ehea_unregister_port(struct
 	of_device_unregister(&port->ofdev);
 }
 
+static const struct net_device_ops ehea_netdev_ops = {
+	.ndo_open		= ehea_open,
+	.ndo_stop		= ehea_stop,
+	.ndo_start_xmit		= ehea_start_xmit,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= ehea_netpoll,
+#endif
+	.ndo_get_stats		= ehea_get_stats,
+	.ndo_set_mac_address	= ehea_set_mac_addr,
+	.ndo_set_multicast_list	= ehea_set_multicast_list,
+	.ndo_change_mtu		= ehea_change_mtu,
+	.ndo_vlan_rx_register	= ehea_vlan_rx_register,
+	.ndo_vlan_rx_add_vid	= ehea_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= ehea_vlan_rx_kill_vid
+};
+
 struct ehea_port *ehea_setup_single_port(struct ehea_adapter *adapter,
 					 u32 logical_port_id,
 					 struct device_node *dn)
@@ -3121,19 +3137,9 @@ struct ehea_port *ehea_setup_single_port
 	/* initialize net_device structure */
 	memcpy(dev->dev_addr, &port->mac_addr, ETH_ALEN);
 
-	dev->open = ehea_open;
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	dev->poll_controller = ehea_netpoll;
-#endif
-	dev->stop = ehea_stop;
-	dev->hard_start_xmit = ehea_start_xmit;
-	dev->get_stats = ehea_get_stats;
-	dev->set_multicast_list = ehea_set_multicast_list;
-	dev->set_mac_address = ehea_set_mac_addr;
-	dev->change_mtu = ehea_change_mtu;
-	dev->vlan_rx_register = ehea_vlan_rx_register;
-	dev->vlan_rx_add_vid = ehea_vlan_rx_add_vid;
-	dev->vlan_rx_kill_vid = ehea_vlan_rx_kill_vid;
+	dev->netdev_ops = &ehea_netdev_ops;
+	ehea_set_ethtool_ops(dev);
+
 	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_TSO
 		      | NETIF_F_HIGHDMA | NETIF_F_IP_CSUM | NETIF_F_HW_VLAN_TX
 		      | NETIF_F_HW_VLAN_RX | NETIF_F_HW_VLAN_FILTER
@@ -3142,7 +3148,6 @@ struct ehea_port *ehea_setup_single_port
 	dev->watchdog_timeo = EHEA_WATCH_DOG_TIMEOUT;
 
 	INIT_WORK(&port->reset_task, ehea_reset_port);
-	ehea_set_ethtool_ops(dev);
 
 	ret = register_netdev(dev);
 	if (ret) {
