Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 2DA2F67CC2
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 11:34:55 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-dev@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, nd@bplan-gmbh.de
Subject: [PATCH 4/5] Move mpc52xx-psc uart driver to of_device from
	platform_device
Date: Mon,  6 Nov 2006 17:34:24 -0700
Message-Id: <11628596761676-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11628596761680-git-send-email-grant.likely@secretlab.ca>
References: <11628596653052-git-send-email-grant.likely@secretlab.ca>
	<11628596751096-git-send-email-grant.likely@secretlab.ca>
	<11628596753992-git-send-email-grant.likely@secretlab.ca>
	<11628596761680-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As part of the transition to arch/powerpc, this patch moves the mpc5200 PSC
driver over to the OF platform bus infrastructure.

This patch is not acceptable for mainline as-is because it breaks arch/ppc
support for the mpc52xx.  More rework is needed to allow it to compile for
either arch (or alternately, fork the driver)

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/serial/mpc52xx_uart.c |  154 ++++++++++++++++++++++++++++------------
 1 files changed, 108 insertions(+), 46 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 29c9300..17d7934 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -42,7 +42,8 @@
  * will be mapped to.
  */
 
-#include <linux/platform_device.h>
+#define DEBUG
+
 #include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/serial.h>
@@ -51,6 +52,7 @@ #include <linux/console.h>
 
 #include <asm/delay.h>
 #include <asm/io.h>
+#include <asm/of_device.h>
 
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
@@ -330,7 +332,7 @@ mpc52xx_uart_release_port(struct uart_po
 		port->membase = NULL;
 	}
 
-	release_mem_region(port->mapbase, MPC52xx_PSC_SIZE);
+	release_mem_region(port->mapbase, sizeof(struct mpc52xx_psc));
 }
 
 static int
@@ -339,12 +341,13 @@ mpc52xx_uart_request_port(struct uart_po
 	int err;
 
 	if (port->flags & UPF_IOREMAP) /* Need to remap ? */
-		port->membase = ioremap(port->mapbase, MPC52xx_PSC_SIZE);
+		port->membase = ioremap(port->mapbase,
+		                        sizeof(struct mpc52xx_psc));
 
 	if (!port->membase)
 		return -EINVAL;
 
-	err = request_mem_region(port->mapbase, MPC52xx_PSC_SIZE,
+	err = request_mem_region(port->mapbase, sizeof(struct mpc52xx_psc),
 			"mpc52xx_psc_uart") != NULL ? 0 : -EBUSY;
 
 	if (err && (port->flags & UPF_IOREMAP)) {
@@ -371,7 +374,7 @@ mpc52xx_uart_verify_port(struct uart_por
 
 	if ( (ser->irq != port->irq) ||
 	     (ser->io_type != SERIAL_IO_MEM) ||
-	     (ser->baud_base != port->uartclk)  ||
+	     (ser->baud_base != port->uartclk) ||
 	     (ser->iomem_base != (void*)port->mapbase) ||
 	     (ser->hub6 != 0 ) )
 		return -EINVAL;
@@ -561,13 +564,13 @@ mpc52xx_console_get_options(struct uart_
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned char mr1;
 
+	pr_debug("mpc52xx_console_get_options(port=%p)\n", port);
 	/* Read the mode registers */
 	out_8(&psc->command,MPC52xx_PSC_SEL_MODE_REG_1);
 	mr1 = in_8(&psc->mode);
 
 	/* CT{U,L}R are write-only ! */
-	*baud = __res.bi_baudrate ?
-		__res.bi_baudrate : CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;
+	*baud = CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;
 
 	/* Parse them */
 	switch (mr1 & MPC52xx_PSC_MODE_BITS_MASK) {
@@ -604,10 +607,10 @@ mpc52xx_console_write(struct console *co
 	for (i = 0; i < count; i++, s++) {
 		/* Line return handling */
 		if (*s == '\n')
-			out_8(&psc->mpc52xx_psc_buffer_8, '\r');
+			out_8(&psc->buffer.buffer_8, '\r');
 
 		/* Send the char */
-		out_8(&psc->mpc52xx_psc_buffer_8, *s);
+		out_8(&psc->buffer.buffer_8, *s);
 
 		/* Wait the TX buffer to be empty */
 		j = 20000;	/* Maximum wait */
@@ -624,33 +627,74 @@ static int __init
 mpc52xx_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port = &mpc52xx_uart_ports[co->index];
+	struct device_node *np = NULL;
+	struct device_node *np_idx;
+	const void *pp = NULL;
+	struct resource res;
+	int index = 0;
+	int ret;
 
 	int baud = CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
 
-	if (co->index < 0 || co->index >= MPC52xx_PSC_MAXNUM)
+	pr_debug("mpc52xx_console_setup co=%p, options=%s, index=%i\n",
+		 co, options, co->index);
+
+	while ((np = of_find_compatible_node(np, "serial", "mpc52xx-psc"))) {
+		if (index == co->index)
+			break;
+		index++;
+	}
+
+	if (!np) {
+		pr_debug("PSC%x not found in device tree\n", co->index);
+		return -EINVAL;
+	}
+
+	/* Fetch register locations */
+	if ((ret = of_address_to_resource(np, 0, &res)) != 0) {
+		pr_debug("Could not get resources for PSC%x\n", index);
+		return ret;
+	}
+
+	/* Search for bus-frequency property in this node or a parent */
+	np_idx = np;
+	while (np_idx) {
+		if ((pp = get_property(np_idx, "bus-frequency", NULL)) != NULL)
+			break;
+		np_idx = of_get_parent(np_idx);
+	}
+	if (!pp) {
+		pr_debug("Could not find bus-frequency property!\n");
 		return -EINVAL;
+	}
 
 	/* Basic port init. Needed since we use some uart_??? func before
 	 * real init for early access */
 	spin_lock_init(&port->lock);
-	port->uartclk	= __res.bi_ipbfreq / 2; /* Look at CTLR doc */
+	port->uartclk	= *(const u32*)pp / 2;
 	port->ops	= &mpc52xx_uart_ops;
-	port->mapbase	= MPC52xx_PA(MPC52xx_PSCx_OFFSET(co->index+1));
+	port->mapbase = res.start;
+	port->membase = ioremap(res.start, sizeof(struct mpc52xx_psc));
+	port->irq = irq_of_parse_and_map(np, 0);
 
-	/* We ioremap ourself */
-	port->membase = ioremap(port->mapbase, MPC52xx_PSC_SIZE);
 	if (port->membase == NULL)
 		return -EINVAL;
 
+	pr_debug("mpc52xx_psc at %lx mapped to %p; irq=%x freq=%i\n",
+	         port->mapbase, port->membase, port->irq, port->uartclk);
+
 	/* Setup the port parameters accoding to options */
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
 		mpc52xx_console_get_options(port, &baud, &parity, &bits, &flow);
 
+	pr_debug("Setting console parameters: %i %i%c1 flow=%c\n",
+	         baud, bits, parity, flow);
+
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
@@ -703,28 +747,23 @@ static struct uart_driver mpc52xx_uart_d
 /* ======================================================================== */
 
 static int __devinit
-mpc52xx_uart_probe(struct platform_device *dev)
+mpc52xx_uart_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct resource *res = dev->resource;
-
+	static int idx = 0;
 	struct uart_port *port = NULL;
-	int i, idx, ret;
+	struct resource res;
+	int ret;
+
+	dev_dbg(&op->dev, "mpc52xx_uart_probe(op=%p, match=%p)\n", op, match);
 
 	/* Check validity & presence */
-	idx = dev->id;
-	if (idx < 0 || idx >= MPC52xx_PSC_MAXNUM)
+	if (idx >= MPC52xx_PSC_MAXNUM)
 		return -EINVAL;
 
-	if (!mpc52xx_match_psc_function(idx,"uart"))
-		return -ENODEV;
-
 	/* Init the port structure */
 	port = &mpc52xx_uart_ports[idx];
 
-	memset(port, 0x00, sizeof(struct uart_port));
-
 	spin_lock_init(&port->lock);
-	port->uartclk	= __res.bi_ipbfreq / 2; /* Look at CTLR doc */
 	port->fifosize	= 512;
 	port->iotype	= UPIO_MEM;
 	port->flags	= UPF_BOOT_AUTOCONF |
@@ -733,29 +772,36 @@ mpc52xx_uart_probe(struct platform_devic
 	port->ops	= &mpc52xx_uart_ops;
 
 	/* Search for IRQ and mapbase */
-	for (i=0 ; i<dev->num_resources ; i++, res++) {
-		if (res->flags & IORESOURCE_MEM)
-			port->mapbase = res->start;
-		else if (res->flags & IORESOURCE_IRQ)
-			port->irq = res->start;
-	}
-	if (!port->irq || !port->mapbase)
+	if ((ret = of_address_to_resource(op->node, 0, &res)) != 0)
+		return ret;
+
+	port->mapbase = res.start;
+	port->membase = ioremap(res.start, sizeof(struct mpc52xx_psc));
+	port->irq = irq_of_parse_and_map(op->node, 0);
+
+	dev_dbg(&op->dev, "mpc52xx-psc UART at %lx. mapped to %p, irq %x\n",
+	         port->mapbase, port->membase, port->irq);
+
+	//if (!port->irq || !port->mapbase) {
+	if (!port->mapbase) {
+		printk(KERN_ERR "Could not allocate resources for PSC\n");
 		return -EINVAL;
+	}
 
 	/* Add the port to the uart sub-system */
 	ret = uart_add_one_port(&mpc52xx_uart_driver, port);
 	if (!ret)
-		platform_set_drvdata(dev, (void*)port);
+		dev_set_drvdata(&op->dev, (void*)port);
 
+	idx++;
 	return ret;
 }
 
 static int
-mpc52xx_uart_remove(struct platform_device *dev)
+mpc52xx_uart_remove(struct of_device *op)
 {
-	struct uart_port *port = (struct uart_port *) platform_get_drvdata(dev);
-
-	platform_set_drvdata(dev, NULL);
+	struct uart_port *port = dev_get_drvdata(&op->dev);
+	dev_set_drvdata(&op->dev, NULL);
 
 	if (port)
 		uart_remove_one_port(&mpc52xx_uart_driver, port);
@@ -787,7 +833,19 @@ mpc52xx_uart_resume(struct platform_devi
 }
 #endif
 
-static struct platform_driver mpc52xx_uart_platform_driver = {
+static struct of_device_id mpc52xx_uart_match[] = {
+	{
+		.name = "serial",
+		.compatible = "mpc52xx-psc",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpc52xx_uart_match);
+
+static struct of_platform_driver mpc52xx_uart_of_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "mpc52xx-uart",
+	.match_table	= mpc52xx_uart_match,
 	.probe		= mpc52xx_uart_probe,
 	.remove		= mpc52xx_uart_remove,
 #ifdef CONFIG_PM
@@ -811,20 +869,24 @@ mpc52xx_uart_init(void)
 
 	printk(KERN_INFO "Serial: MPC52xx PSC driver\n");
 
-	ret = uart_register_driver(&mpc52xx_uart_driver);
-	if (ret == 0) {
-		ret = platform_driver_register(&mpc52xx_uart_platform_driver);
-		if (ret)
-			uart_unregister_driver(&mpc52xx_uart_driver);
+	if ((ret = uart_register_driver(&mpc52xx_uart_driver)) != 0) {
+		printk(KERN_ERR "Could not register mpc52xx uart driver\n");
+		return ret;
+	}
+
+	if ((ret = of_register_driver(&mpc52xx_uart_of_driver)) != 0) {
+		printk(KERN_ERR "Could not register mpc52xx of driver\n");
+		uart_unregister_driver(&mpc52xx_uart_driver);
+		return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static void __exit
 mpc52xx_uart_exit(void)
 {
-	platform_driver_unregister(&mpc52xx_uart_platform_driver);
+	of_unregister_driver(&mpc52xx_uart_of_driver);
 	uart_unregister_driver(&mpc52xx_uart_driver);
 }
 
-- 
1.4.3.rc2.g0503
