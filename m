Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0251DDFCD
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 19:33:23 +1000 (EST)
Date: Thu, 31 May 2007 18:33:04 +0900 (JST)
Message-Id: <200705310933.l4V9X4Pl009909@toshiba.co.jp>
Subject: [PATCH] of_serial: add port type checking
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, of_serial driver supports only 8250 compatible ports, but
prepares that others can easily be added. Yet unregister routine
assumes port is 8250. This patch corrects unregister routine to check
port type.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Cc: Arnd Bergmann <arnd@arndb.de>
---

Index: linux-powerpc-git/drivers/serial/of_serial.c
===================================================================
--- linux-powerpc-git.orig/drivers/serial/of_serial.c
+++ linux-powerpc-git/drivers/serial/of_serial.c
@@ -17,6 +17,11 @@
 #include <asm/of_platform.h>
 #include <asm/prom.h>
 
+struct of_serial_info {
+	int type;
+	int line;
+};
+
 /*
  * Fill a struct uart_port for a given device node
  */
@@ -62,6 +67,7 @@ static int __devinit of_platform_serial_
 static int __devinit of_platform_serial_probe(struct of_device *ofdev,
 						const struct of_device_id *id)
 {
+	struct of_serial_info *info;
 	struct uart_port port;
 	int port_type;
 	int ret;
@@ -69,6 +75,10 @@ static int __devinit of_platform_serial_
 	if (of_find_property(ofdev->node, "used-by-rtas", NULL))
 		return -EBUSY;
 
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (info == NULL)
+		return -ENOMEM;
+
 	port_type = (unsigned long)id->data;
 	ret = of_platform_serial_setup(ofdev, port_type, &port);
 	if (ret)
@@ -88,9 +98,12 @@ static int __devinit of_platform_serial_
 	if (ret < 0)
 		goto out;
 
-	ofdev->dev.driver_data = (void *)(unsigned long)ret;
+	info->type = port_type;
+	info->line = ret;
+	ofdev->dev.driver_data = info;
 	return 0;
 out:
+	kfree(info);
 	irq_dispose_mapping(port.irq);
 	return ret;
 }
@@ -100,8 +113,16 @@ out:
  */
 static int of_platform_serial_remove(struct of_device *ofdev)
 {
-	int line = (unsigned long)ofdev->dev.driver_data;
-	serial8250_unregister_port(line);
+	struct of_serial_info *info = ofdev->dev.driver_data;
+	switch (info->type) {
+	case PORT_8250 ... PORT_MAX_8250:
+		serial8250_unregister_port(info->line);
+		break;
+	default:
+		/* need to add code for these */
+		break;
+	}
+	kfree(info);
 	return 0;
 }
 
