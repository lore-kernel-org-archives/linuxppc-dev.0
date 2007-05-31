Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17B7DDDE3C
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 19:31:03 +1000 (EST)
Date: Thu, 31 May 2007 18:30:33 +0900 (JST)
Message-Id: <20070531.183033.-1300520557.kouish@swc.toshiba.co.jp>
Subject: [PATCH] of_serial: ignore unknown serial port
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

Current of_serial driver assumes unknown serial port to be 8250. But
this behavior may cause fatal problems when the serial port is not
8250. This patch corrects probe routine to ignore unknown serial port.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Cc: Arnd Bergmann <arnd@arndb.de>
---

Index: linux-powerpc-git/drivers/serial/of_serial.c
===================================================================
--- linux-powerpc-git.orig/drivers/serial/of_serial.c
+++ linux-powerpc-git/drivers/serial/of_serial.c
@@ -75,15 +75,13 @@ static int __devinit of_platform_serial_
 		goto out;
 
 	switch (port_type) {
-	case PORT_UNKNOWN:
-		dev_info(&ofdev->dev, "Unknown serial port found, "
-			"attempting to use 8250 driver\n");
-		/* fallthrough */
 	case PORT_8250 ... PORT_MAX_8250:
 		ret = serial8250_register_port(&port);
 		break;
 	default:
 		/* need to add code for these */
+	case PORT_UNKNOWN:
+		dev_info(&ofdev->dev, "Unknown serial port found, ignored\n");
 		ret = -ENODEV;
 		break;
 	}
