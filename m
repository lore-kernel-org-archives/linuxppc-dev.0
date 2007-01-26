Return-Path: <jens@de.ibm.com>
From: Jens Osterkamp <jens@de.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] of_serial : set custom divisor computed from device tree
	values
Date: Fri, 26 Jan 2007 18:22:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701261822.21284.jens@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Small fix to Arnds of_serial driver which computes the custom divisor
from the device tree values.

Signed-off-by: Jens Osterkamp <jens@de.ibm.com>

Index: linux-2.6.20-rc5/drivers/serial/of_serial.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/serial/of_serial.c
+++ linux-2.6.20-rc5/drivers/serial/of_serial.c
@@ -50,9 +50,8 @@ static int __devinit of_platform_serial_
  port->uartclk = *clk;
  port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP;
  port->dev = &ofdev->dev;
-/* if (spd) // FIXME: how to set?
-  port->speed = spd;
-*/
+ port->custom_divisor = *clk / (16 * (*spd));
+
  return 0;
 }
 
