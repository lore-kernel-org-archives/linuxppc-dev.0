Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 84D0EDDF16
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 06:09:38 +1100 (EST)
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org,
	jwboyer@linux.vnet.ibm.com
Subject: [PATCH] [POWERPC] Xilinx: Serial: Adding 8250 console support to OF
	serial
Date: Mon, 17 Mar 2008 12:09:14 -0700
Message-Id: <20080317190924.3B2C0A4807A@mail109-dub.bigfish.com>
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This change adds code to serial_of.c to support the 8250 console.
Initialization was added to get the UART data from the device tree
and setup the UART and console for the 8250.

The cmd line was not being used for the baud rate and is still not
being used as the speed for the uart is being pulled from the UART
properties in the device tree. The input clock frequency for the
UART must be specified in the device tree so the baud rate generator
can be setup.

<Signed-off-by: John Linn <john.linn@xilinx.com>

---

Please pull this patch for 2.6.26.
---
 drivers/serial/8250.c      |   20 ++++++--
 drivers/serial/of_serial.c |  128 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index f94109c..7b32af1 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2366,7 +2366,7 @@ serial8250_type(struct uart_port *port)
 	return uart_config[type].name;
 }
 
-static struct uart_ops serial8250_pops = {
+struct uart_ops serial8250_pops = {
 	.tx_empty	= serial8250_tx_empty,
 	.set_mctrl	= serial8250_set_mctrl,
 	.get_mctrl	= serial8250_get_mctrl,
@@ -2519,10 +2519,13 @@ serial8250_console_write(struct console *co, const char *s, unsigned int count)
 static int __init serial8250_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
+
+#ifndef CONFIG_SERIAL_OF_PLATFORM
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+#endif
 
 	/*
 	 * Check whether an invalid uart number has been specified, and
@@ -2535,10 +2538,13 @@ static int __init serial8250_console_setup(struct console *co, char *options)
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
 
+#ifndef CONFIG_SERIAL_OF_PLATFORM
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-
 	return uart_set_options(port, co, baud, parity, bits, flow);
+#else
+	return 0;
+#endif
 }
 
 static int serial8250_console_early_setup(void)
@@ -2547,7 +2553,7 @@ static int serial8250_console_early_setup(void)
 }
 
 static struct uart_driver serial8250_reg;
-static struct console serial8250_console = {
+struct console serial8250_console = {
 	.name		= "ttyS",
 	.write		= serial8250_console_write,
 	.device		= uart_console_device,
@@ -2558,13 +2564,19 @@ static struct console serial8250_console = {
 	.data		= &serial8250_reg,
 };
 
-static int __init serial8250_console_init(void)
+int __init serial8250_console_init(void)
 {
 	serial8250_isa_init_ports();
 	register_console(&serial8250_console);
 	return 0;
 }
+
+/* when OF is being used with the 8250 console, the OF hooks in the 
+   8250 console
+*/
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(CONFIG_SERIAL_OF_PLATFORM)
 console_initcall(serial8250_console_init);
+#endif
 
 int serial8250_find_port(struct uart_port *p)
 {
diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index a64d858..eed245a 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -13,9 +13,11 @@
 #include <linux/module.h>
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
+#include <linux/console.h>
 
 #include <asm/of_platform.h>
 #include <asm/prom.h>
+#include <asm/io.h>
 
 struct of_serial_info {
 	int type;
@@ -158,6 +160,132 @@ static void __exit of_platform_serial_exit(void)
 };
 module_exit(of_platform_serial_exit);
 
+#if defined(CONFIG_SERIAL_8250_CONSOLE)
+
+/* when an 8250 console is being used and OF, the OF needs to
+   setup the uart before the 8250 console initializes
+*/
+extern struct console serial8250_console;
+extern int serial8250_console_init(void);
+extern int early_serial_console_setup(struct uart_port *);
+extern struct uart_ops serial8250_pops;
+
+static struct uart_port of_uart_port;
+
+static struct of_device_id __devinit uart_of_match[] = {
+	{ .type = "serial", .compatible = "ns16550", },
+	{},
+};
+
+static unsigned int *spd;
+
+/*
+ * Setup the uart based on OF properties
+ */
+static int __init uart_of_setup(struct device_node *np,
+					struct uart_port *port)
+{
+	struct resource resource;
+	const unsigned int *clk, *regshift;
+	int ret;
+
+	memset(port, 0, sizeof *port);
+	spd = of_get_property(np, "current-speed", NULL);
+	regshift = of_get_property(np, "reg-shift", NULL);
+	clk = of_get_property(np, "clock-frequency", NULL);
+	if (!clk) {
+		return -ENODEV;
+	}
+
+	ret = of_address_to_resource(np, 0, &resource);
+	if (ret) {
+		return ret;
+	}
+
+	spin_lock_init(&port->lock);
+	port->irq = irq_of_parse_and_map(np, 0);
+	port->iotype = UPIO_MEM;
+	port->type = PORT_16550;
+	port->uartclk = *clk;
+	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
+		| UPF_FIXED_PORT;
+	if (!spd)
+		*spd = 9600;
+		
+	port->custom_divisor = *clk / (16 * (*spd));
+
+	if (regshift) {
+		port->regshift = *regshift;
+		port->mapbase = resource.start + ((1 << *regshift) - 1);
+	} else {
+		port->mapbase = resource.start;
+	}
+	return 0;
+}
+
+static struct device_node __init *console_of_find_device(int id)
+{
+	struct device_node *np;
+        const struct of_device_id *matches = uart_of_match;
+
+	while (matches->compatible[0]) {
+		for_each_compatible_node(np, NULL, matches->compatible) {
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
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	/* Find a matching uart port in the device tree */
+	np = console_of_find_device(co->index);
+	if (!np)
+		return -ENODEV;
+		
+	if (uart_of_setup(np, &of_uart_port))
+		return -ENODEV;
+
+	/* registers mapped yet? */
+	if (!of_uart_port.membase) {
+		of_uart_port.membase = ioremap(of_uart_port.mapbase, 64);
+		if (!of_uart_port.membase)
+			return -ENODEV;
+	}
+
+	of_uart_port.ops = &serial8250_pops;
+	uart_set_options(&of_uart_port, co, *spd, parity, bits, flow);
+
+	return 0;
+}
+
+/* This function sets up the 8250 console by getting the OF data at 
+   console init time and then setting up the 8250 uart and console. 
+   This solves the problem of the OF uart not being setup in time 
+   for the 8250 console to use it.
+*/
+static int __init of_console_init(void)
+{
+	if (!console_setup(&serial8250_console)) {
+		early_serial_setup(&of_uart_port);	
+		serial8250_console_init();	
+	}
+	return 0;
+}
+
+console_initcall(of_console_init);
+#endif
+
 MODULE_AUTHOR("Arnd Bergmann <arnd@arndb.de>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Serial Port driver for Open Firmware platform devices");
-- 
1.5.2.1
