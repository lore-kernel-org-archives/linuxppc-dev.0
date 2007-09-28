Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 271F1DE26E
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:19:23 +1000 (EST)
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300LMAC61TW30@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:18:01 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP30032YC60P080@pd2mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Sep 2007 12:18:01 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300MW0C5ZGOJ3@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:18:00 -0600 (MDT)
Date: Fri, 28 Sep 2007 12:18:08 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 14/18] Sysace: Use the established platform bus api
In-reply-to: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070928181807.18608.86548.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

SystemACE uses the platform bus binding, but it doesn't use the
platform bus API.  Move to using the correct API for consistency
sake.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/block/xsysace.c |   48 +++++++++++++++++++++++++++++------------------
 1 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 3ede0b6..b104476 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1060,13 +1060,12 @@ static void __devexit ace_teardown(struct ace_device *ace)
  * Platform Bus Support
  */
 
-static int __devinit ace_probe(struct device *device)
+static int __devinit ace_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(device);
 	struct ace_device *ace;
 	int i;
 
-	dev_dbg(device, "ace_probe(%p)\n", device);
+	dev_dbg(&dev->dev, "ace_probe(%p)\n", dev);
 
 	/*
 	 * Allocate the ace device structure
@@ -1075,7 +1074,7 @@ static int __devinit ace_probe(struct device *device)
 	if (!ace)
 		goto err_alloc;
 
-	ace->dev = device;
+	ace->dev = &dev->dev;
 	ace->id = dev->id;
 	ace->irq = NO_IRQ;
 
@@ -1089,7 +1088,7 @@ static int __devinit ace_probe(struct device *device)
 	/* FIXME: Should get bus_width from the platform_device struct */
 	ace->bus_width = 1;
 
-	dev_set_drvdata(&dev->dev, ace);
+	platform_set_drvdata(dev, ace);
 
 	/* Call the bus-independant setup code */
 	if (ace_setup(ace) != 0)
@@ -1098,7 +1097,7 @@ static int __devinit ace_probe(struct device *device)
 	return 0;
 
       err_setup:
-	dev_set_drvdata(&dev->dev, NULL);
+	platform_set_drvdata(dev, NULL);
 	kfree(ace);
       err_alloc:
 	printk(KERN_ERR "xsysace: could not initialize device\n");
@@ -1108,25 +1107,27 @@ static int __devinit ace_probe(struct device *device)
 /*
  * Platform bus remove() method
  */
-static int __devexit ace_remove(struct device *device)
+static int __devexit ace_remove(struct platform_device *dev)
 {
-	struct ace_device *ace = dev_get_drvdata(device);
-
-	dev_dbg(device, "ace_remove(%p)\n", device);
+	struct ace_device *ace =  platform_get_drvdata(dev);
+	dev_dbg(&dev->dev, "ace_remove(%p)\n", dev);
 
 	if (ace) {
 		ace_teardown(ace);
+		platform_set_drvdata(dev, NULL);
 		kfree(ace);
 	}
 
 	return 0;
 }
 
-static struct device_driver ace_driver = {
-	.name = "xsysace",
-	.bus = &platform_bus_type,
+static struct platform_driver ace_platform_driver = {
 	.probe = ace_probe,
 	.remove = __devexit_p(ace_remove),
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "xsysace",
+	},
 };
 
 /* ---------------------------------------------------------------------
@@ -1134,20 +1135,31 @@ static struct device_driver ace_driver = {
  */
 static int __init ace_init(void)
 {
+	int rc;
+
 	ace_major = register_blkdev(ace_major, "xsysace");
 	if (ace_major <= 0) {
-		printk(KERN_WARNING "xsysace: register_blkdev() failed\n");
-		return ace_major;
+		rc = -ENOMEM;
+		goto err_blk;
 	}
 
-	pr_debug("Registering Xilinx SystemACE driver, major=%i\n", ace_major);
-	return driver_register(&ace_driver);
+	if ((rc = platform_driver_register(&ace_platform_driver)) != 0)
+		goto err_plat;
+
+	pr_info("Xilinx SystemACE device driver, major=%i\n", ace_major);
+	return 0;
+
+      err_plat:
+	unregister_blkdev(ace_major, "xsysace");
+      err_blk:
+	printk(KERN_ERR "xsysace: registration failed; err=%i\n", rc);
+	return rc;
 }
 
 static void __exit ace_exit(void)
 {
 	pr_debug("Unregistering Xilinx SystemACE driver\n");
-	driver_unregister(&ace_driver);
+	platform_driver_unregister(&ace_platform_driver);
 	unregister_blkdev(ace_major, "xsysace");
 }
 
