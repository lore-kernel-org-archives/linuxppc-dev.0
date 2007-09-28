Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 36226DE719
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:19:21 +1000 (EST)
Received: from pd4mr1so.prod.shaw.ca
	(pd4mr1so-qfe3.prod.shaw.ca [10.0.141.212]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP300IJ3C5YZW60@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:17:58 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd4mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP300MW4C5VGB40@pd4mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Sep 2007 12:17:56 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300GH0C5GK360@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:17:40 -0600 (MDT)
Date: Fri, 28 Sep 2007 12:17:49 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 11/18] Virtex: Port UARTLITE driver to of-platform-bus
In-reply-to: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070928181748.18608.62409.stgit@trillian.cg.shawcable.net>
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

 drivers/serial/uartlite.c |  101 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index ed13b9f..8f742e0 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -1,7 +1,8 @@
 /*
  * uartlite.c: Serial driver for Xilinx uartlite serial controller
  *
- * Peter Korsgaard <jacmet@sunsite.dk>
+ * Copyright (C) 2006 Peter Korsgaard <jacmet@sunsite.dk>
+ * Copyright (C) 2007 Secret Lab Technologies Ltd.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -17,6 +18,10 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <asm/io.h>
+#if defined(CONFIG_OF)
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#endif
 
 #define ULITE_NAME		"ttyUL"
 #define ULITE_MAJOR		204
@@ -382,8 +387,10 @@ static int __init ulite_console_setup(struct console *co, char *options)
 	port = &ulite_ports[co->index];
 
 	/* not initialized yet? */
-	if (!port->membase)
+	if (!port->membase) {
+		pr_debug("console on ttyUL%i not initialized\n", co->index);
 		return -ENODEV;
+	}
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -542,6 +549,72 @@ static struct platform_driver ulite_platform_driver = {
 };
 
 /* ---------------------------------------------------------------------
+ * OF bus bindings
+ */
+#if defined(CONFIG_OF)
+static int __devinit
+ulite_of_probe(struct of_device *op, const struct of_device_id *match)
+{
+	struct resource res;
+	const unsigned int *id;
+	int irq, rc;
+
+	dev_dbg(&op->dev, "%s(%p, %p)\n", __FUNCTION__, op, match);
+
+	rc = of_address_to_resource(op->node, 0, &res);
+	if (rc) {
+		dev_err(&op->dev, "invalide address\n");
+		return rc;
+	}
+
+	irq = irq_of_parse_and_map(op->node, 0);
+
+	id = of_get_property(op->node, "port-number", NULL);
+
+	return ulite_assign(&op->dev, id ? *id : -1, res.start, irq);
+}
+
+static int ulite_of_remove(struct of_device *op)
+{
+	return ulite_release(&op->dev);
+}
+
+/* Match table for of_platform binding */
+static struct of_device_id __devinit ulite_of_match[] = {
+	{ .type = "serial", .compatible = "xilinx,uartlite", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ulite_of_match);
+
+static struct of_platform_driver ulite_of_driver = {
+	.owner = THIS_MODULE,
+	.name = "uartlite",
+	.match_table = ulite_of_match,
+	.probe = ulite_of_probe,
+	.remove = ulite_of_remove,
+	.driver = {
+		.name = "uartlite",
+	},
+};
+
+/* Registration helpers to keep the number of #ifdefs to a minimum */
+static inline int __init ulite_of_register(void)
+{
+	pr_debug("uartlite: calling of_register_platform_driver()\n");
+	return of_register_platform_driver(&ulite_of_driver);
+}
+
+static inline void __init ulite_of_unregister(void)
+{
+	of_unregister_platform_driver(&ulite_of_driver);
+}
+#else /* CONFIG_OF */
+/* CONFIG_OF not enabled; do nothing helpers */
+static inline int __init ulite_of_register(void) { return 0; }
+static inline void __init ulite_of_unregister(void) { }
+#endif /* CONFIG_OF */
+
+/* ---------------------------------------------------------------------
  * Module setup/teardown
  */
 
@@ -549,20 +622,32 @@ int __init ulite_init(void)
 {
 	int ret;
 
-	ret = uart_register_driver(&ulite_uart_driver);
-	if (ret)
-		return ret;
+	pr_debug("uartlite: calling uart_register_driver()\n");
+	if ((ret = uart_register_driver(&ulite_uart_driver)) != 0)
+		goto err_uart;
 
-	ret = platform_driver_register(&ulite_platform_driver);
-	if (ret)
-		uart_unregister_driver(&ulite_uart_driver);
+	if ((ret = ulite_of_register()) != 0)
+		goto err_of;
 
+	pr_debug("uartlite: calling platform_driver_register()\n");
+	if ((ret = platform_driver_register(&ulite_platform_driver)) != 0)
+		goto err_plat;
+
+	return 0;
+
+err_plat:
+	ulite_of_unregister();
+err_of:
+	uart_unregister_driver(&ulite_uart_driver);
+err_uart:
+	printk(KERN_ERR "registering uartlite driver failed: err=%i", ret);
 	return ret;
 }
 
 void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
+	ulite_of_unregister();
 	uart_unregister_driver(&ulite_uart_driver);
 }
 
