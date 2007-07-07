Return-Path: <SRS0+bd14105a136047a0bf47+1413+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86C8CDE172
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 02:56:56 +1000 (EST)
Subject: [PATCH 1/2] Add 'sparse16550' to of_serial.c and handle
	'reg-shift' property.
From: David Woodhouse <dwmw2@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200707071410.14998.arnd@arndb.de>
References: <1183784308.3066.16.camel@shinybook.infradead.org>
	<200707071410.14998.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 07 Jul 2007 12:57:40 -0400
Message-Id: <1183827460.3066.72.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some boards have UARTs which are mostly compatible with a 16550, but
with registers spaced more widely. This isn't strictly compatible with
ns16550, so introduce a new 'compatible' type for it: sparse16550. The
'reg-shift' property indicates how far the registers are separated.

Also, reorder the match table to favour better modes if a device claims
compatibility with both 8250 and 16550, for example.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index 7ffdaea..6ae1b5e 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -25,12 +25,13 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 {
 	struct resource resource;
 	struct device_node *np = ofdev->node;
-	const unsigned int *clk, *spd;
+	const unsigned int *clk, *spd, *rs;
 	int ret;
 
 	memset(port, 0, sizeof *port);
 	spd = of_get_property(np, "current-speed", NULL);
 	clk = of_get_property(np, "clock-frequency", NULL);
+	rs = of_get_property(np, "reg-shift", NULL);
 	if (!clk) {
 		dev_warn(&ofdev->dev, "no clock-frequency property set\n");
 		return -ENODEV;
@@ -48,6 +49,8 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 	port->iotype = UPIO_MEM;
 	port->type = type;
 	port->uartclk = *clk;
+	if (rs)
+		port->regshift = *rs;
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
 		| UPF_FIXED_PORT;
 	port->dev = &ofdev->dev;
@@ -111,11 +114,12 @@ static int of_platform_serial_remove(struct of_device *ofdev)
  * A few common types, add more as needed.
  */
 static struct of_device_id __devinitdata of_platform_serial_table[] = {
-	{ .type = "serial", .compatible = "ns8250",   .data = (void *)PORT_8250, },
-	{ .type = "serial", .compatible = "ns16450",  .data = (void *)PORT_16450, },
-	{ .type = "serial", .compatible = "ns16550",  .data = (void *)PORT_16550, },
-	{ .type = "serial", .compatible = "ns16750",  .data = (void *)PORT_16750, },
-	{ .type = "serial",			      .data = (void *)PORT_UNKNOWN, },
+	{ .type = "serial", .compatible = "sparse16550", .data = (void *)PORT_16550, },
+	{ .type = "serial", .compatible = "ns16750",     .data = (void *)PORT_16750, },
+	{ .type = "serial", .compatible = "ns16550",     .data = (void *)PORT_16550, },
+	{ .type = "serial", .compatible = "ns16450",     .data = (void *)PORT_16450, },
+	{ .type = "serial", .compatible = "ns8250",      .data = (void *)PORT_8250, },
+	{ .type = "serial",			         .data = (void *)PORT_UNKNOWN, },
 	{ /* end of list */ },
 };
 

-- 
dwmw2
