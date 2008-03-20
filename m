Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DDB25DE00C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 01:44:05 +1100 (EST)
Received: from outbound6-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound6-sin-R.bigfish.com (Postfix) with ESMTP id 1B1CDA3B209
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:44:03 +0000 (UTC)
Received: from mail148-sin-R.bigfish.com (unknown [10.3.40.3])
	by outbound6-sin.bigfish.com (Postfix) with ESMTP id 04919C78053
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:44:03 +0000 (UTC)
Received: from mail148-sin (localhost.localdomain [127.0.0.1])
	by mail148-sin-R.bigfish.com (Postfix) with ESMTP id E6A8C10780AF
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:44:02 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail148-sin.bigfish.com (Postfix) with ESMTP id 3063517C005D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:44:02 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com) by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <linnj@wolfgang-pc.public.xilinx.com>)
	id 1JcLzt-0005hF-Fk
	for linuxppc-dev@ozlabs.org; Thu, 20 Mar 2008 07:44:01 -0700
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart 16550.
Date: Thu, 20 Mar 2008 07:43:51 -0700
In-Reply-To: <12060242324116-git-send-email-john.linn@xilinx.com>
References: <12060242324116-git-send-email-john.linn@xilinx.com>
Message-Id: <20080320144402.3063517C005D@mail148-sin.bigfish.com>
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Xilinx 16550 uart core is not a standard 16550, because it uses
word-based addressing rather than byte-based addressing.  As a result,
it is not compatible with the open firmware 'ns16550' compatible
binding.  This code introduces new bindings, which pass the correct
register base and regshift properties to the uart driver to enable
this core to be used.  Doing this cleanly required some refactoring of
the existing code.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Signed-off-by: John Linn <john.linn@xilinx.com>
---
 drivers/serial/of_serial.c |   47 ++++++++++++++++++++++++++++++-------------
 1 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index 2efb892..910c94f 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -20,13 +20,15 @@
 struct of_serial_info {
 	int type;
 	int line;
+	int regshift;
+	int regoffset;
 };
 
 /*
  * Fill a struct uart_port for a given device node
  */
 static int __devinit of_platform_serial_setup(struct of_device *ofdev,
-					int type, struct uart_port *port)
+					struct of_serial_info *info, struct uart_port *port)
 {
 	struct resource resource;
 	struct device_node *np = ofdev->node;
@@ -48,17 +50,16 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 	}
 
 	spin_lock_init(&port->lock);
-	port->mapbase = resource.start;
+	port->mapbase = resource.start + info->regoffset;
 	port->irq = irq_of_parse_and_map(np, 0);
 	port->iotype = UPIO_MEM;
-	port->type = type;
+	port->type = info->type;
+	port->regshift = info->regshift;
 	port->uartclk = *clk;
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
 		| UPF_FIXED_PORT;
 	port->dev = &ofdev->dev;
-	/* If current-speed was set, then try not to change it. */
-	if (spd)
-		port->custom_divisor = *clk / (16 * (*spd));
+	port->custom_divisor = *clk / (16 * (*spd));
 
 	return 0;
 }
@@ -81,8 +82,9 @@ static int __devinit of_platform_serial_probe(struct of_device *ofdev,
 	if (info == NULL)
 		return -ENOMEM;
 
-	port_type = (unsigned long)id->data;
-	ret = of_platform_serial_setup(ofdev, port_type, &port);
+	memcpy(info, id->data, sizeof(struct of_serial_info));
+	port_type = info->type;
+	ret = of_platform_serial_setup(ofdev, info, &port);
 	if (ret)
 		goto out;
 
@@ -100,7 +102,6 @@ static int __devinit of_platform_serial_probe(struct of_device *ofdev,
 	if (ret < 0)
 		goto out;
 
-	info->type = port_type;
 	info->line = ret;
 	ofdev->dev.driver_data = info;
 	return 0;
@@ -128,15 +129,33 @@ static int of_platform_serial_remove(struct of_device *ofdev)
 	return 0;
 }
 
+static struct of_serial_info __devinitdata ns8250_info = { .type = PORT_8250 };
+static struct of_serial_info __devinitdata ns16450_info = { .type = PORT_16450 };
+static struct of_serial_info __devinitdata ns16550_info = { .type = PORT_16550 };
+static struct of_serial_info __devinitdata ns16750_info = { .type = PORT_16750 };
+static struct of_serial_info __devinitdata xilinx_16550_info = {
+	.type = PORT_16550,
+	.regshift = 2,
+	.regoffset = 3,
+};
+static struct of_serial_info __devinitdata unknown_info = { .type = PORT_UNKNOWN };
+
 /*
  * A few common types, add more as needed.
  */
 static struct of_device_id __devinitdata of_platform_serial_table[] = {
-	{ .type = "serial", .compatible = "ns8250",   .data = (void *)PORT_8250, },
-	{ .type = "serial", .compatible = "ns16450",  .data = (void *)PORT_16450, },
-	{ .type = "serial", .compatible = "ns16550",  .data = (void *)PORT_16550, },
-	{ .type = "serial", .compatible = "ns16750",  .data = (void *)PORT_16750, },
-	{ .type = "serial",			      .data = (void *)PORT_UNKNOWN, },
+	{ .type = "serial", .compatible = "ns8250",   .data = &ns8250_info, },
+	{ .type = "serial", .compatible = "ns16450",  .data = &ns16450_info, },
+	{ .type = "serial", .compatible = "ns16550",  .data = &ns16550_info, },
+	{ .type = "serial", .compatible = "ns16750",  .data = &ns16750_info, },
+	{ .type = "serial", .compatible = "xlnx,opb-uart16550-1.00.c", .data = &xilinx_16550_info, },
+	{ .type = "serial", .compatible = "xlnx,opb-uart16550-1.00.d", .data = &xilinx_16550_info, },
+	{ .type = "serial", .compatible = "xlnx,opb-uart16550-1.00.e", .data = &xilinx_16550_info, },
+	{ .type = "serial", .compatible = "xlnx,plb-uart16550-1.00.c", .data = &xilinx_16550_info, },
+	{ .type = "serial", .compatible = "xlnx,xps-uart16550-1.00.a", .data = &xilinx_16550_info, },
+	{ .type = "serial", .compatible = "xlnx,xps-uart16550-2.00.a", .data = &xilinx_16550_info, },
+	{ .type = "serial", .compatible = "xlnx,xps-uart16550-2.00.b", .data = &xilinx_16550_info, },
+	{ .type = "serial",			      .data = &unknown_info, },
 	{ /* end of list */ },
 };
 
-- 
1.5.2.1
