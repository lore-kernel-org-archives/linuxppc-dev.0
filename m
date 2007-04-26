Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A6CAFDDF29
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 19:56:48 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l3Q9ui1k278292
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 09:56:44 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3Q9uilO3580026
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 11:56:44 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3Q9uh9K001415
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 11:56:44 +0200
From: Thomas Klein <osstklei@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 2/2] ehea: fix for dlpar support
Date: Thu, 26 Apr 2007 11:56:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200704261156.43524.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Certain resources may only be allocated when first logical port is available,
and must be removed when last logical port has been removed.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


This patch applies on top of the netdev upstream branch for 2.6.22


diff -Nurp -X dontdiff linux-2.6.21/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- linux-2.6.21/drivers/net/ehea/ehea.h	2007-04-26 11:21:33.000000000 +0200
+++ patched_kernel/drivers/net/ehea/ehea.h	2007-04-26 11:23:16.000000000 +0200
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0057"
+#define DRV_VERSION	"EHEA_0058"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
diff -Nurp -X dontdiff linux-2.6.21/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.21/drivers/net/ehea/ehea_main.c	2007-04-26 11:21:33.000000000 +0200
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-04-26 11:23:16.000000000 +0200
@@ -2130,6 +2130,28 @@ static int ehea_clean_all_portres(struct
 	return ret;
 }
 
+static void ehea_remove_adapter_mr (struct ehea_adapter *adapter)
+{
+	int i;
+
+	for (i=0; i < EHEA_MAX_PORTS; i++)
+		if (adapter->port[i])
+			return;
+
+	ehea_rem_mr(&adapter->mr);
+}
+
+static int ehea_add_adapter_mr (struct ehea_adapter *adapter)
+{
+	int i;
+
+	for (i=0; i < EHEA_MAX_PORTS; i++)
+		if (adapter->port[i])
+			return 0;
+
+	return ehea_reg_kernel_mr(adapter, &adapter->mr);
+}
+
 static int ehea_up(struct net_device *dev)
 {
 	int ret, i;
@@ -2580,7 +2602,6 @@ static int ehea_setup_ports(struct ehea_
 	struct device_node *eth_dn = NULL;
 
 	u32 *dn_log_port_id;
-	int port_setup_ok = 0;
 	int i = 0;
 
 	lhea_dn = adapter->ebus_dev->ofdev.node;
@@ -2594,6 +2615,12 @@ static int ehea_setup_ports(struct ehea_
 			continue;
 		}
 
+		if (ehea_add_adapter_mr(adapter)) {
+			ehea_error("creating MR failed");
+			of_node_put(eth_dn);
+			return -EIO;
+		}
+
 		adapter->port[i] = ehea_setup_single_port(adapter,
 							  *dn_log_port_id,
 							  eth_dn);
@@ -2601,18 +2628,13 @@ static int ehea_setup_ports(struct ehea_
 			ehea_info("%s -> logical port id #%d",
 				  adapter->port[i]->netdev->name,
 				  *dn_log_port_id);
+		else
+			ehea_remove_adapter_mr(adapter);
+
 		i++;
 	};
 
-	/* Check for succesfully set up ports */
-	for (i = 0; i < EHEA_MAX_PORTS; i++)
-		if (adapter->port[i])
-			port_setup_ok++;
-
-	if (port_setup_ok)
-		return 0;	/* At least some ports are setup correctly */
-
-	return -EINVAL;
+	return 0;
 }
 
 static struct device_node *ehea_get_eth_dn(struct ehea_adapter *adapter,
@@ -2664,6 +2686,11 @@ static ssize_t ehea_probe_port(struct de
 		return -EINVAL;
 	}
 
+	if (ehea_add_adapter_mr(adapter)) {
+		ehea_error("creating MR failed");
+		return -EIO;
+	}
+
 	port = ehea_setup_single_port(adapter, logical_port_id, eth_dn);
 
 	of_node_put(eth_dn);
@@ -2677,8 +2704,10 @@ static ssize_t ehea_probe_port(struct de
 
 		ehea_info("added %s (logical port id=%d)", port->netdev->name,
 			  logical_port_id);
-	} else
+	} else {
+		ehea_remove_adapter_mr(adapter);
 		return -EIO;
+	}
 
 	return (ssize_t) count;
 }
@@ -2713,6 +2742,8 @@ static ssize_t ehea_remove_port(struct d
 		return -EINVAL;
 	}
 
+	ehea_remove_adapter_mr(adapter);
+
 	return (ssize_t) count;
 }
 
@@ -2773,18 +2804,13 @@ static int __devinit ehea_probe_adapter(
 
 	dev->ofdev.dev.driver_data = adapter;
 
-	ret = ehea_reg_kernel_mr(adapter, &adapter->mr);
-	if (ret) {
-		dev_err(&dev->ofdev.dev, "reg_mr_adapter failed\n");
-		goto out_free_ad;
-	}
 
 	/* initialize adapter and ports */
 	/* get adapter properties */
 	ret = ehea_sense_adapter_attr(adapter);
 	if (ret) {
 		dev_err(&dev->ofdev.dev, "sense_adapter_attr failed: %d", ret);
-		goto out_free_res;
+		goto out_free_ad;
 	}
 
 	adapter->neq = ehea_create_eq(adapter,
@@ -2792,7 +2818,7 @@ static int __devinit ehea_probe_adapter(
 	if (!adapter->neq) {
 		ret = -EIO;
 		dev_err(&dev->ofdev.dev, "NEQ creation failed");
-		goto out_free_res;
+		goto out_free_ad;
 	}
 
 	tasklet_init(&adapter->neq_tasklet, ehea_neq_tasklet,
@@ -2837,9 +2863,6 @@ out_free_irq:
 out_kill_eq:
 	ehea_destroy_eq(adapter->neq);
 
-out_free_res:
-	ehea_rem_mr(&adapter->mr);
-
 out_free_ad:
 	kfree(adapter);
 out:
@@ -2865,7 +2888,7 @@ static int __devexit ehea_remove(struct 
 	tasklet_kill(&adapter->neq_tasklet);
 
 	ehea_destroy_eq(adapter->neq);
-	ehea_rem_mr(&adapter->mr);
+	ehea_remove_adapter_mr(adapter);
 	kfree(adapter);
 	return 0;
 }
