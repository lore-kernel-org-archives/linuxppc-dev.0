Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 983EFDE53F
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:18:29 +1000 (EST)
Received: from pd2mr3so.prod.shaw.ca
	(pd2mr3so-qfe3.prod.shaw.ca [10.0.141.108]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP3008CLC6P4G10@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:18:25 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd2mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP3006WGC6OAW50@pd2mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Sep 2007 12:18:25 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300GJ0C6OK360@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:18:24 -0600 (MDT)
Date: Fri, 28 Sep 2007 12:18:33 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 18/18] xsysace: Add of_platform_bus binding
In-reply-to: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070928181832.18608.54023.stgit@trillian.cg.shawcable.net>
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

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/block/xsysace.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 296d567..a68301a 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -91,6 +91,10 @@
 #include <linux/blkdev.h>
 #include <linux/hdreg.h>
 #include <linux/platform_device.h>
+#if defined(CONFIG_OF)
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#endif
 
 MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
 MODULE_DESCRIPTION("Xilinx SystemACE device driver");
@@ -1158,6 +1162,85 @@ static struct platform_driver ace_platform_driver = {
 };
 
 /* ---------------------------------------------------------------------
+ * OF_Platform Bus Support
+ */
+
+#if defined(CONFIG_OF)
+static int __devinit
+ace_of_probe(struct of_device *op, const struct of_device_id *match)
+{
+	struct resource res;
+	unsigned long physaddr;
+	const u32 *id;
+	int irq, bus_width, rc;
+
+	dev_dbg(&op->dev, "ace_of_probe(%p, %p)\n", op, match);
+
+	/* device id */
+	id = of_get_property(op->node, "port-number", NULL);
+
+	/* physaddr */
+	rc = of_address_to_resource(op->node, 0, &res);
+	if (rc) {
+		dev_err(&op->dev, "invalid address\n");
+		return rc;
+	}
+	physaddr = res.start;
+
+	/* irq */
+	irq = irq_of_parse_and_map(op->node, 0);
+
+	/* bus width */
+	bus_width = ACE_BUS_WIDTH_16;
+	if (of_find_property(op->node, "8-bit", NULL))
+		bus_width = ACE_BUS_WIDTH_8;
+
+	/* Call the bus-independant setup code */
+	return ace_alloc(&op->dev, id ? *id : 0, physaddr, irq, bus_width);
+}
+
+static int __devexit ace_of_remove(struct of_device *op)
+{
+	ace_free(&op->dev);
+	return 0;
+}
+
+/* Match table for of_platform binding */
+static struct of_device_id __devinit ace_of_match[] = {
+	{ .compatible = "xilinx,xsysace", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ace_of_match);
+
+static struct of_platform_driver ace_of_driver = {
+	.owner = THIS_MODULE,
+	.name = "xsysace",
+	.match_table = ace_of_match,
+	.probe = ace_of_probe,
+	.remove = ace_of_remove,
+	.driver = {
+		.name = "xsysace",
+	},
+};
+
+/* Registration helpers to keep the number of #ifdefs to a minimum */
+static int __init ace_of_register(void)
+{
+	pr_debug("xsysace: registering OF binding\n");
+	return of_register_platform_driver(&ace_of_driver);
+}
+
+static void __exit ace_of_unregister(void)
+{
+	of_unregister_platform_driver(&ace_of_driver);
+}
+#else /* CONFIG_OF */
+/* CONFIG_OF not enabled; do nothing helpers */
+static int __init ace_of_register(void) { return 0 }
+static void __exit ace_of_unregister(void) { }
+#endif /* CONFIG_OF */
+
+/* ---------------------------------------------------------------------
  * Module init/exit routines
  */
 static int __init ace_init(void)
@@ -1170,6 +1253,9 @@ static int __init ace_init(void)
 		goto err_blk;
 	}
 
+	if ((rc = ace_of_register()) != 0)
+		goto err_of;
+
 	pr_debug("xsysace: registering platform binding\n");
 	if ((rc = platform_driver_register(&ace_platform_driver)) != 0)
 		goto err_plat;
@@ -1178,6 +1264,8 @@ static int __init ace_init(void)
 	return 0;
 
       err_plat:
+	ace_of_unregister();
+      err_of:
 	unregister_blkdev(ace_major, "xsysace");
       err_blk:
 	printk(KERN_ERR "xsysace: registration failed; err=%i\n", rc);
@@ -1188,6 +1276,7 @@ static void __exit ace_exit(void)
 {
 	pr_debug("Unregistering Xilinx SystemACE driver\n");
 	platform_driver_unregister(&ace_platform_driver);
+	ace_of_unregister();
 	unregister_blkdev(ace_major, "xsysace");
 }
 
