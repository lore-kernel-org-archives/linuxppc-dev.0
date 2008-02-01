Return-Path: <ossthema@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2170CDDEAB
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 01:37:47 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m11Ebh77297014
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Feb 2008 14:37:43 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m11EbhJj1659112
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Feb 2008 15:37:43 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m11Ebgcx030806
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Feb 2008 15:37:43 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] ehea: fix sysfs link compile problem
Date: Fri, 1 Feb 2008 15:37:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802011537.42578.ossthema@de.ibm.com>
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

Due to changes in the struct device_driver there is no direct
access to its kobj any longer. The kobj was used to create
sysfs links between eHEA ethernet devices and the driver.
This patch removes the affected sysfs links to resolve
the build problems.

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>


---
 drivers/net/ehea/ehea_main.c |   37 -------------------------------------
 1 files changed, 0 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index 869e160..9a3fd81 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -2804,34 +2804,6 @@ static void __devinit logical_port_release(struct device *dev)
 	of_node_put(port->ofdev.node);
 }
 
-static int ehea_driver_sysfs_add(struct device *dev,
-				 struct device_driver *driver)
-{
-	int ret;
-
-	ret = sysfs_create_link(&driver->kobj, &dev->kobj,
-				kobject_name(&dev->kobj));
-	if (ret == 0) {
-		ret = sysfs_create_link(&dev->kobj, &driver->kobj,
-					"driver");
-		if (ret)
-			sysfs_remove_link(&driver->kobj,
-					  kobject_name(&dev->kobj));
-	}
-	return ret;
-}
-
-static void ehea_driver_sysfs_remove(struct device *dev,
-				     struct device_driver *driver)
-{
-	struct device_driver *drv = driver;
-
-	if (drv) {
-		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
-		sysfs_remove_link(&dev->kobj, "driver");
-	}
-}
-
 static struct device *ehea_register_port(struct ehea_port *port,
 					 struct device_node *dn)
 {
@@ -2856,16 +2828,8 @@ static struct device *ehea_register_port(struct ehea_port *port,
 		goto out_unreg_of_dev;
 	}
 
-	ret = ehea_driver_sysfs_add(&port->ofdev.dev, &ehea_driver.driver);
-	if (ret) {
-		ehea_error("failed to register sysfs driver link");
-		goto out_rem_dev_file;
-	}
-
 	return &port->ofdev.dev;
 
-out_rem_dev_file:
-	device_remove_file(&port->ofdev.dev, &dev_attr_log_port_id);
 out_unreg_of_dev:
 	of_device_unregister(&port->ofdev);
 out:
@@ -2874,7 +2838,6 @@ out:
 
 static void ehea_unregister_port(struct ehea_port *port)
 {
-	ehea_driver_sysfs_remove(&port->ofdev.dev, &ehea_driver.driver);
 	device_remove_file(&port->ofdev.dev, &dev_attr_log_port_id);
 	of_device_unregister(&port->ofdev);
 }
-- 
1.5.2
