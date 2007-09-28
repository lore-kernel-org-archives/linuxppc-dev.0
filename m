Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 27E35DE21A
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:19:14 +1000 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP300ERVC6EH460@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:18:14 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP300K4JC668A40@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Sep 2007 12:18:14 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300FDTC656C32@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:18:05 -0600 (MDT)
Date: Fri, 28 Sep 2007 12:18:14 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 15/18] Sysace: Move structure allocation from bus binding into
	common code
In-reply-to: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070928181813.18608.95432.stgit@trillian.cg.shawcable.net>
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

Split the determination of device registers/irqs/etc from the actual
allocation and initialization of the device structure.  This cleans
up the code a bit in preparation to add an of_platform bus binding

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/block/xsysace.c |   99 +++++++++++++++++++++++++++++------------------
 1 files changed, 61 insertions(+), 38 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index b104476..555939b 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1033,7 +1033,7 @@ static int __devinit ace_setup(struct ace_device *ace)
 	if (ace->irq != NO_IRQ)
 		free_irq(ace->irq, ace);
       err_ioremap:
-	printk(KERN_INFO "xsysace: error initializing device at 0x%lx\n",
+	dev_info(ace->dev, "xsysace: error initializing device at 0x%lx\n",
 	       ace->physaddr);
 	return -ENOMEM;
 }
@@ -1056,68 +1056,91 @@ static void __devexit ace_teardown(struct ace_device *ace)
 	iounmap(ace->baseaddr);
 }
 
-/* ---------------------------------------------------------------------
- * Platform Bus Support
- */
-
-static int __devinit ace_probe(struct platform_device *dev)
+static int __devinit
+ace_alloc(struct device *dev, int id, unsigned long physaddr,
+	  int irq, int bus_width)
 {
 	struct ace_device *ace;
-	int i;
+	int rc;
+	dev_dbg(dev, "ace_alloc(%p)\n", dev);
 
-	dev_dbg(&dev->dev, "ace_probe(%p)\n", dev);
+	if (!physaddr) {
+		rc = -ENODEV;
+		goto err_noreg;
+	}
 
-	/*
-	 * Allocate the ace device structure
-	 */
+	/* Allocate and initialize the ace device structure */
 	ace = kzalloc(sizeof(struct ace_device), GFP_KERNEL);
-	if (!ace)
+	if (!ace) {
+		rc = -ENOMEM;
 		goto err_alloc;
-
-	ace->dev = &dev->dev;
-	ace->id = dev->id;
-	ace->irq = NO_IRQ;
-
-	for (i = 0; i < dev->num_resources; i++) {
-		if (dev->resource[i].flags & IORESOURCE_MEM)
-			ace->physaddr = dev->resource[i].start;
-		if (dev->resource[i].flags & IORESOURCE_IRQ)
-			ace->irq = dev->resource[i].start;
 	}
 
-	/* FIXME: Should get bus_width from the platform_device struct */
-	ace->bus_width = 1;
-
-	platform_set_drvdata(dev, ace);
+	ace->dev = dev;
+	ace->id = id;
+	ace->physaddr = physaddr;
+	ace->irq = irq;
+	ace->bus_width = bus_width;
 
-	/* Call the bus-independant setup code */
-	if (ace_setup(ace) != 0)
+	/* Call the setup code */
+	if ((rc = ace_setup(ace)) != 0)
 		goto err_setup;
 
+	dev_set_drvdata(dev, ace);
 	return 0;
 
       err_setup:
-	platform_set_drvdata(dev, NULL);
+	dev_set_drvdata(dev, NULL);
 	kfree(ace);
       err_alloc:
-	printk(KERN_ERR "xsysace: could not initialize device\n");
-	return -ENOMEM;
+      err_noreg:
+	dev_err(dev, "could not initialize device, err=%i\n", rc);
+	return rc;
 }
 
-/*
- * Platform bus remove() method
- */
-static int __devexit ace_remove(struct platform_device *dev)
+static void __devexit ace_free(struct device *dev)
 {
-	struct ace_device *ace =  platform_get_drvdata(dev);
-	dev_dbg(&dev->dev, "ace_remove(%p)\n", dev);
+	struct ace_device *ace = dev_get_drvdata(dev);
+	dev_dbg(dev, "ace_free(%p)\n", dev);
 
 	if (ace) {
 		ace_teardown(ace);
-		platform_set_drvdata(dev, NULL);
+		dev_set_drvdata(dev, NULL);
 		kfree(ace);
 	}
+}
+
+/* ---------------------------------------------------------------------
+ * Platform Bus Support
+ */
+
+static int __devinit ace_probe(struct platform_device *dev)
+{
+	unsigned long physaddr = 0;
+	int bus_width = 1; /* FIXME: should not be hard coded */
+	int id = dev->id;
+	int irq = NO_IRQ;
+	int i;
+
+	dev_dbg(&dev->dev, "ace_probe(%p)\n", dev);
+
+	for (i = 0; i < dev->num_resources; i++) {
+		if (dev->resource[i].flags & IORESOURCE_MEM)
+			physaddr = dev->resource[i].start;
+		if (dev->resource[i].flags & IORESOURCE_IRQ)
+			irq = dev->resource[i].start;
+	}
+
+	/* Call the bus-independant setup code */
+	return ace_alloc(&dev->dev, id, physaddr, irq, bus_width);
+}
 
+/*
+ * Platform bus remove() method
+ */
+static int __devexit ace_remove(struct platform_device *dev)
+{
+	ace_free(&dev->dev);
 	return 0;
 }
 
