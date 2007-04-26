Return-Path: <osstklei@de.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36D7FDDF1D
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 19:56:19 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l3Q9uEQG087702
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 09:56:14 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3Q9uET32756848
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:56:14 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3Q9uDYC028186
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:56:14 +0100
From: Thomas Klein <osstklei@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 1/2] ehea: fix for sysfs entries
Date: Thu, 26 Apr 2007 11:56:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200704261156.13487.osstklei@de.ibm.com>
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

Create symbolic link from each logical port to ehea driver

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


This patch applies on top of the netdev upstream branch for 2.6.22



diff -Nurp -X dontdiff linux-2.6.21/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- linux-2.6.21/drivers/net/ehea/ehea.h	2007-04-26 10:07:59.000000000 +0200
+++ patched_kernel/drivers/net/ehea/ehea.h	2007-04-26 11:15:25.000000000 +0200
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0055"
+#define DRV_VERSION	"EHEA_0057"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
diff -Nurp -X dontdiff linux-2.6.21/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.21/drivers/net/ehea/ehea_main.c	2007-04-26 10:07:59.000000000 +0200
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-04-26 11:15:25.000000000 +0200
@@ -78,6 +78,28 @@ MODULE_PARM_DESC(sq_entries, " Number of
 		 __MODULE_STRING(EHEA_DEF_ENTRIES_SQ) ")");
 MODULE_PARM_DESC(use_mcs, " 0:NAPI, 1:Multiple receive queues, Default = 1 ");
 
+static int port_name_cnt = 0;
+
+static int __devinit ehea_probe_adapter(struct ibmebus_dev *dev,
+                                        const struct of_device_id *id);
+
+static int __devexit ehea_remove(struct ibmebus_dev *dev);
+
+static struct of_device_id ehea_device_table[] = {
+	{
+		.name = "lhea",
+		.compatible = "IBM,lhea",
+	},
+	{},
+};
+
+static struct ibmebus_driver ehea_driver = {
+	.name = "ehea",
+	.id_table = ehea_device_table,
+	.probe = ehea_probe_adapter,
+	.remove = ehea_remove,
+};
+
 void ehea_dump(void *adr, int len, char *msg) {
 	int x;
 	unsigned char *deb = adr;
@@ -2361,6 +2383,34 @@ static void __devinit logical_port_relea
 	of_node_put(port->ofdev.node);
 }
 
+static int ehea_driver_sysfs_add(struct device *dev,
+                                 struct device_driver *driver)
+{
+	int ret;
+
+	ret = sysfs_create_link(&driver->kobj, &dev->kobj,
+				kobject_name(&dev->kobj));
+	if (ret == 0) {
+		ret = sysfs_create_link(&dev->kobj, &driver->kobj,
+					"driver");
+		if (ret)
+			sysfs_remove_link(&driver->kobj,
+					  kobject_name(&dev->kobj));
+	}
+	return ret;
+}
+
+static void ehea_driver_sysfs_remove(struct device *dev,
+                                     struct device_driver *driver)
+{
+	struct device_driver *drv = driver;
+
+	if (drv) {
+		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
+		sysfs_remove_link(&dev->kobj, "driver");
+	}
+}
+
 static struct device *ehea_register_port(struct ehea_port *port,
 					 struct device_node *dn)
 {
@@ -2368,8 +2418,9 @@ static struct device *ehea_register_port
 
 	port->ofdev.node = of_node_get(dn);
 	port->ofdev.dev.parent = &port->adapter->ebus_dev->ofdev.dev;
+	port->ofdev.dev.bus = &ibmebus_bus_type;
 
-	sprintf(port->ofdev.dev.bus_id, "port%d", port->logical_port_id);
+	sprintf(port->ofdev.dev.bus_id, "port%d", port_name_cnt++);
 	port->ofdev.dev.release = logical_port_release;
 
 	ret = of_device_register(&port->ofdev);
@@ -2384,8 +2435,16 @@ static struct device *ehea_register_port
 		goto out_unreg_of_dev;
 	}
 
+	ret = ehea_driver_sysfs_add(&port->ofdev.dev, &ehea_driver.driver);
+	if (ret) {
+		ehea_error("failed to register sysfs driver link");
+		goto out_rem_dev_file;
+	}
+
 	return &port->ofdev.dev;
 
+out_rem_dev_file:
+	device_remove_file(&port->ofdev.dev, &dev_attr_log_port_id);
 out_unreg_of_dev:
 	of_device_unregister(&port->ofdev);
 out:
@@ -2394,6 +2453,7 @@ out:
 
 static void ehea_unregister_port(struct ehea_port *port)
 {
+	ehea_driver_sysfs_remove(&port->ofdev.dev, &ehea_driver.driver);
 	device_remove_file(&port->ofdev.dev, &dev_attr_log_port_id);
 	of_device_unregister(&port->ofdev);
 }
@@ -2838,21 +2898,6 @@ static int check_module_parm(void)
 	return ret;
 }
 
-static struct of_device_id ehea_device_table[] = {
-	{
-		.name = "lhea",
-		.compatible = "IBM,lhea",
-	},
-	{},
-};
-
-static struct ibmebus_driver ehea_driver = {
-	.name = "ehea",
-	.id_table = ehea_device_table,
-	.probe = ehea_probe_adapter,
-	.remove = ehea_remove,
-};
-
 int __init ehea_module_init(void)
 {
 	int ret;
