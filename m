Return-Path: <John.Linn@xilinx.com>
Received: from outbound9-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DEA4EDE282
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Mar 2008 00:27:51 +1100 (EST)
Received: from outbound9-dub.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound9-dub-R.bigfish.com (Postfix) with ESMTP id 9173D520176
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 13:22:44 +0000 (UTC)
Received: from mail5-dub-R.bigfish.com (unknown [10.5.252.3])
	by outbound9-dub.bigfish.com (Postfix) with ESMTP id 757A41390050
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 13:22:44 +0000 (UTC)
Received: from mail5-dub (localhost.localdomain [127.0.0.1])
	by mail5-dub-R.bigfish.com (Postfix) with ESMTP id 9845BE8720
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 13:22:43 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail5-dub.bigfish.com (Postfix) with ESMTP id DAF0410C0073
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 13:22:41 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com) by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <John.Linn@xilinx.com>) id 1Ja9rt-000227-8W
	for linuxppc-dev@ozlabs.org; Fri, 14 Mar 2008 06:22:41 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] [RFC] [POWERPC] Xilinx: OF Serial: add support for
	8250console
Date: Fri, 14 Mar 2008 07:22:39 -0600
In-Reply-To: <20080313222932.4E6DAB900B1@mail80-dub.bigfish.com>
References: y <20080313222932.4E6DAB900B1@mail80-dub.bigfish.com>
From: "John Linn" <John.Linn@xilinx.com>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <20080314132241.DAF0410C0073@mail5-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I hosed up when I sent the patch from git so that it didn't show being
from me. Sorry about that.

I would appreciate any comments on this proposed patch.

Thanks,
John Linn

-----Original Message-----
From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org] On =
Behalf
Of y@xilinx.com
Sent: Thursday, March 13, 2008 4:30 PM
To: linuxppc-dev@ozlabs.org
Cc: John Linn
Subject: [PATCH] [RFC] [POWERPC] Xilinx: OF Serial: add support for
8250console

From: John Linn <john.linn@xilinx.com>

This change to the OF serial driver causes it to setup a console
which then gets the OF data and sets up the 8250 console. Prior to
this the uart was not setup in time for the 8250 console initialization
to work correct.

It appears that the kernel console uart depends on the bootstrap loader
to setup the uart (baud,etc.) prior to the kernel running. Without the
bootstrap loader uart working correctly, the kernel console uart doesn't
work either, is that expected?

Signed-off-by: <john.linn@xilinx.com>
---
 drivers/serial/8250.c      |   10 +++-
 drivers/serial/of_serial.c |  115
++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index f94109c..d8e211e 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2547,7 +2547,7 @@ static int serial8250_console_early_setup(void)
 }
=20
 static struct uart_driver serial8250_reg;
-static struct console serial8250_console =3D {
+struct console serial8250_console =3D {
 	.name		=3D "ttyS",
 	.write		=3D serial8250_console_write,
 	.device		=3D uart_console_device,
@@ -2558,13 +2558,19 @@ static struct console serial8250_console =3D {
 	.data		=3D &serial8250_reg,
 };
=20
-static int __init serial8250_console_init(void)
+int __init serial8250_console_init(void)
 {
 	serial8250_isa_init_ports();
 	register_console(&serial8250_console);
 	return 0;
 }
+
+/* when OF is being used with the 8250 console, the OF hooks in the=20
+   8250 console
+*/
+#if defined(CONFIG_SERIAL_8250_CONSOLE) &&
!defined(CONFIG_SERIAL_OF_PLATFORM)
 console_initcall(serial8250_console_init);
+#endif
=20
 int serial8250_find_port(struct uart_port *p)
 {
diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index a64d858..c80198b 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -13,9 +13,11 @@
 #include <linux/module.h>
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
+#include <linux/console.h>
=20
 #include <asm/of_platform.h>
 #include <asm/prom.h>
+#include <asm/io.h>
=20
 struct of_serial_info {
 	int type;
@@ -158,6 +160,119 @@ static void __exit of_platform_serial_exit(void)
 };
 module_exit(of_platform_serial_exit);
=20
+#if defined(CONFIG_SERIAL_8250_CONSOLE) &&
defined(CONFIG_SERIAL_OF_PLATFORM)
+
+/* when an 8250 console is being used and OF, the OF needs to
+   setup the uart before the 8250 console initializes
+*/
+extern struct console serial8250_console;
+extern int serial8250_console_init(void);
+extern int __init early_serial_console_setup(struct uart_port *port);
+static struct uart_port of_uart_port;
+
+static struct of_device_id __devinit uart_of_match[] =3D {
+	{ .type =3D "serial", .compatible =3D "ns16550", },
+	{},
+};
+
+/*
+ * Setup the console based on OF properties
+ */
+static int __init console_of_setup(struct device_node *np,
+					struct uart_port *port)
+{
+	struct resource resource;
+	const unsigned int *clk, *spd, *regshift;
+	int ret;
+
+	memset(port, 0, sizeof *port);
+	spd =3D of_get_property(np, "current-speed", NULL);
+	regshift =3D of_get_property(np, "reg-shift", NULL);
+	clk =3D of_get_property(np, "clock-frequency", NULL);
+	if (!clk) {
+		return -ENODEV;
+	}
+
+	ret =3D of_address_to_resource(np, 0, &resource);
+	if (ret) {
+		return ret;
+	}
+
+	spin_lock_init(&port->lock);
+	port->irq =3D irq_of_parse_and_map(np, 0);
+	port->iotype =3D UPIO_MEM;
+	port->type =3D PORT_16550;
+	port->uartclk =3D *clk;
+	port->flags =3D UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
+		| UPF_FIXED_PORT;
+	if (spd) {
+		port->custom_divisor =3D *clk / (16 * (*spd));
+	}
+
+	if (regshift) {
+		port->regshift =3D *regshift;
+		port->mapbase =3D resource.start + ((1 << *regshift) - 1);
+	} else {
+		port->mapbase =3D resource.start;
+	}
+	return 0;
+}
+
+static struct device_node __init *console_of_find_device(int id)
+{
+	struct device_node *np;
+        const struct of_device_id *matches =3D uart_of_match;
+
+	while (matches->compatible[0]) {
+		for_each_compatible_node(np, NULL, matches->compatible)
{
+			if (!of_match_node(matches, np))
+				continue;
+
+                        of_node_put(np);
+                        return np;
+		}
+		matches++;
+	}
+	return 0;
+}
+
+static int __init console_setup(struct console *co)
+{
+	struct device_node *np;
+
+	/* Find a matching uart port in the device tree */
+	np =3D console_of_find_device(co->index);
+	if (!np)
+		return -ENODEV;
+	=09
+	if (console_of_setup(np, &of_uart_port))
+		return -ENODEV;
+
+	/* registers mapped yet? */
+	if (!of_uart_port.membase) {
+		of_uart_port.membase =3D ioremap(of_uart_port.mapbase,
256);
+		if (of_uart_port.membase)
+			return -ENODEV;
+	}
+	return 0;
+}
+
+/* This function sets up the 8250 console by getting the OF data at=20
+   console init time and then setting up the 8250 uart and console.=20
+   This solves the problem of the OF uart not being setup in time=20
+   for the 8250 console to use it.
+*/
+static int __init of_console_init(void)
+{
+	console_setup(&serial8250_console);
+	early_serial_setup(&of_uart_port);=09
+	serial8250_console_init();=09
+	return 0;
+}
+
+console_initcall(of_console_init);
+#endif
+
 MODULE_AUTHOR("Arnd Bergmann <arnd@arndb.de>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Serial Port driver for Open Firmware platform
devices");
--=20
1.5.2.1



_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
