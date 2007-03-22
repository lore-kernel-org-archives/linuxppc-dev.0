Return-Path: <ossthema@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1B74DDFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 03:59:21 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l2MGxH3A297282
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 16:59:17 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l2MGxHuC979170
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 17:59:17 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l2MGxGFk010418
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 17:59:17 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 1/2] ehea: fix for dynamic lpar support
Date: Thu, 22 Mar 2007 17:49:42 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703221749.42876.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch fixes bugs related to the probe / remove adapter
functionality (handling of OFDT nodes)

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
---


This patch applies on top of the netdev upstream branch for 2.6.22


diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index d593513..1fefb2d 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -39,7 +39,7 @@ #include <asm/abs_addr.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0052"
+#define DRV_VERSION	"EHEA_0053"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index a3c235e..8d94a85 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -2556,11 +2556,8 @@ static int ehea_setup_ports(struct ehea_
 	int i = 0;
 
 	lhea_dn = adapter->ebus_dev->ofdev.node;
-	do {
-		eth_dn = of_get_next_child(lhea_dn, eth_dn);
-		if (!eth_dn)
-			break;
-
+	while ((eth_dn = of_get_next_child(lhea_dn, eth_dn))) {
+		
 		dn_log_port_id = (u32*)get_property(eth_dn, "ibm,hea-port-no",
 						    NULL);
 		if (!dn_log_port_id) {
@@ -2577,9 +2574,7 @@ static int ehea_setup_ports(struct ehea_
 				  adapter->port[i]->netdev->name, 
 				  *dn_log_port_id);
 		i++;
-	} while (eth_dn);
-
-	of_node_put(lhea_dn);
+	};
 
 	/* Check for succesfully set up ports */
 	for (i = 0; i < EHEA_MAX_PORTS; i++)
@@ -2600,21 +2595,14 @@ static struct device_node *ehea_get_eth_
 	u32 *dn_log_port_id;
 
 	lhea_dn = adapter->ebus_dev->ofdev.node;
-	do {
-		eth_dn = of_get_next_child(lhea_dn, eth_dn);
-		if (!eth_dn)
-			break;
-
+	while ((eth_dn = of_get_next_child(lhea_dn, eth_dn))) {
+		
 		dn_log_port_id = (u32*)get_property(eth_dn, "ibm,hea-port-no",
 						    NULL);
-
 		if (dn_log_port_id)
 			if (*dn_log_port_id == logical_port_id)
 				return eth_dn;
-
-	} while (eth_dn);
-
-	of_node_put(lhea_dn);
+	};
 
 	return NULL;
 }
@@ -2650,6 +2638,8 @@ static ssize_t ehea_probe_port(struct de
 		
 	port = ehea_setup_single_port(adapter, logical_port_id, eth_dn);
 
+	of_node_put(eth_dn);
+
 	if (port) {
 		for (i=0; i < EHEA_MAX_PORTS; i++)
 			if (!adapter->port[i]) {
@@ -2725,6 +2715,11 @@ static int __devinit ehea_probe_adapter(
 	u64 *adapter_handle;
 	int ret;
 
+	if (!dev || !dev->ofdev.node) {
+		ehea_error("Invalid ibmebus device probed");
+		return -EINVAL;
+	}
+
 	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
 	if (!adapter) {
 		ret = -ENOMEM;
@@ -2767,6 +2762,7 @@ static int __devinit ehea_probe_adapter(
 	adapter->neq = ehea_create_eq(adapter,
 				      EHEA_NEQ, EHEA_MAX_ENTRIES_EQ, 1);
 	if (!adapter->neq) {
+		ret = -EIO;
 		dev_err(&dev->ofdev.dev, "NEQ creation failed");
 		goto out_free_res;
 	}
@@ -2783,10 +2779,13 @@ static int __devinit ehea_probe_adapter(
 	}
 
 	adapter->ehea_wq = create_workqueue("ehea_wq");
-	if (!adapter->ehea_wq)
+	if (!adapter->ehea_wq) {
+		ret = -EIO;
 		goto out_free_irq;
+	}
 
-	if (ehea_create_device_sysfs(dev))
+	ret = ehea_create_device_sysfs(dev);
+	if (ret)
 		goto out_kill_wq;
 
 	ret = ehea_setup_ports(adapter);
