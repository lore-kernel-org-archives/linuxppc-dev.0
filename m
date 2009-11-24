Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id 2C3BDB6F08
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 21:22:51 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: greg@kroah.com,
 devicetree-discuss@lists.ozlabs.org
Subject: [PATCH] tty/of_serial: add missing ns16550a id
Date: Tue, 24 Nov 2009 10:22:41 +0000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200911241022.41078.arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Simek <monstr@monstr.eu>

Many boards have a bug-free ns16550 compatible serial port, which we should
register as PORT_16550A. This introduces a new value "ns16550a" for the
compatible property of of_serial to let a firmware choose that model instead
of using the crippled PORT_16550 mode.

Reported-by: Alon Ziv <alonz@nolaviz.org>
Signed-off-by: Michal Simek <monstr@monstr.eu>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
Please apply to the tty tree for 2.6.33

--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -161,6 +161,7 @@ static int of_platform_serial_remove(struct of_device *ofdev)
 static struct of_device_id __devinitdata of_platform_serial_table[] = {
 	{ .type = "serial", .compatible = "ns8250",   .data = (void *)PORT_8250, },
 	{ .type = "serial", .compatible = "ns16450",  .data = (void *)PORT_16450, },
+	{ .type = "serial", .compatible = "ns16550a", .data = (void *)PORT_16550A, },
 	{ .type = "serial", .compatible = "ns16550",  .data = (void *)PORT_16550, },
 	{ .type = "serial", .compatible = "ns16750",  .data = (void *)PORT_16750, },
 	{ .type = "serial", .compatible = "ns16850",  .data = (void *)PORT_16850, },
