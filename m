Return-Path: <SRS0+bd14105a136047a0bf47+1413+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32EB0DDFA4
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 14:58:18 +1000 (EST)
Subject: [PATCH] Handle reg-shift property for of_serial ports
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Sat, 07 Jul 2007 00:58:28 -0400
Message-Id: <1183784308.3066.16.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The MV64660 has reg-shift==2 for its otherwise 16550-compatible uarts.
While the bootwrapper copes with this, of_serial.c doesn't. (The udbg
code doesn't either, but I'll fix that later).

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index 7ffdaea..0761ff9 100644
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


-- 
dwmw2
