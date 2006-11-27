Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id C8F7C6824F
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:21:31 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/2] [POWERPC] Add of_platform_bus support to mpc52xx psc uart
	driver
Date: Mon, 27 Nov 2006 14:21:02 -0700
Message-Id: <11646624633070-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11646624631843-git-send-email-grant.likely@secretlab.ca>
References: <1164662462514-git-send-email-grant.likely@secretlab.ca>
	<11646624631843-git-send-email-grant.likely@secretlab.ca>
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Needed to support mpc52xx boards in arch/powerpc.  This patch
retains the platform_bus support when compiling for arch/ppc,
but uses the of_platform bindings for arch/powerpc.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 drivers/serial/mpc52xx_uart.c |  353 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 337 insertions(+), 16 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 8e24133..6dd579e 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -16,7 +16,9 @@
  * Some of the code has been inspired/copied from the 2.4 code written
  * by Dale Farnsworth <dfarnsworth@mvista.com>.
  *
- * Copyright (C) 2004-2005 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2006 Secret Lab Technologies Ltd.
+ *                    Grant Likely <grant.likely@secretlab.ca>
+ * Copyright (C) 2004-2006 Sylvain Munaut <tnt@246tNt.com>
  * Copyright (C) 2003 MontaVista, Software, Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
@@ -42,7 +44,24 @@
  * will be mapped to.
  */
 
-#include <linux/platform_device.h>
+/* OF Platform device Usage :
+ *
+ * This driver is only used for PSCs configured in uart mode.  The device
+ * tree will have a node for each PSC in uart mode w/ device_type = "serial"
+ * and "mpc52xx-psc-uart" in the compatible string
+ *
+ * By default, PSC devices are enumerated in the order they are found.  However
+ * a particular PSC number can be forces by adding 'device_no = <port#>'
+ * to the device node.
+ *
+ * The driver init all necessary registers to place the PSC in uart mode without
+ * DCD. However, the pin multiplexing aren't changed and should be set either
+ * by the bootloader or in the platform init code.
+ */
+
+#undef DEBUG
+
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/serial.h>
@@ -52,6 +71,12 @@ #include <linux/console.h>
 #include <asm/delay.h>
 #include <asm/io.h>
 
+#if defined(CONFIG_PPC_MERGE)
+#include <asm/of_platform.h>
+#else
+#include <linux/platform_device.h>
+#endif
+
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
 
@@ -78,6 +103,12 @@ static struct uart_port mpc52xx_uart_por
 	 *        it's cleared, then a memset(...,0,...) should be added to
 	 *        the console_init
 	 */
+#if defined(CONFIG_PPC_MERGE)
+/* lookup table for matching device nodes to index numbers */
+static struct device_node *mpc52xx_uart_nodes[MPC52xx_PSC_MAXNUM];
+
+static void mpc52xx_uart_of_enumerate(void);
+#endif
 
 #define PSC(port) ((struct mpc52xx_psc __iomem *)((port)->membase))
 
@@ -94,6 +125,14 @@ #else
 #define uart_console(port)	(0)
 #endif
 
+#if defined(CONFIG_PPC_MERGE)
+static struct of_device_id mpc52xx_uart_of_match[] = {
+	{ .type = "serial", .compatible = "mpc52xx-psc-uart", },
+	{ .type = "serial", .compatible = "mpc5200-psc", }, /* Efika only! */
+	{},
+};
+#endif
+
 
 /* ======================================================================== */
 /* UART operations                                                          */
@@ -330,7 +369,7 @@ mpc52xx_uart_release_port(struct uart_po
 		port->membase = NULL;
 	}
 
-	release_mem_region(port->mapbase, MPC52xx_PSC_SIZE);
+	release_mem_region(port->mapbase, sizeof(struct mpc52xx_psc));
 }
 
 static int
@@ -339,12 +378,13 @@ mpc52xx_uart_request_port(struct uart_po
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
@@ -561,13 +601,18 @@ mpc52xx_console_get_options(struct uart_
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned char mr1;
 
+	pr_debug("mpc52xx_console_get_options(port=%p)\n", port);
+
 	/* Read the mode registers */
 	out_8(&psc->command,MPC52xx_PSC_SEL_MODE_REG_1);
 	mr1 = in_8(&psc->mode);
 
 	/* CT{U,L}R are write-only ! */
-	*baud = __res.bi_baudrate ?
-		__res.bi_baudrate : CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;
+	*baud = CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;
+#if !defined(CONFIG_PPC_MERGE)
+	if (__res.bi_baudrate)
+		*baud = __res.bi_baudrate;
+#endif
 
 	/* Parse them */
 	switch (mr1 & MPC52xx_PSC_MODE_BITS_MASK) {
@@ -620,6 +665,7 @@ mpc52xx_console_write(struct console *co
 	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
 }
 
+#if !defined(CONFIG_PPC_MERGE)
 static int __init
 mpc52xx_console_setup(struct console *co, char *options)
 {
@@ -654,6 +700,78 @@ mpc52xx_console_setup(struct console *co
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
+#else
+
+static int __init
+mpc52xx_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port = &mpc52xx_uart_ports[co->index];
+	struct device_node *np = mpc52xx_uart_nodes[co->index];
+	unsigned int ipb_freq;
+	struct resource res;
+	int ret;
+
+	int baud = CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	pr_debug("mpc52xx_console_setup co=%p, co->index=%i, options=%s\n",
+		 co, co->index, options);
+
+	if ((co->index < 0) || (co->index > MPC52xx_PSC_MAXNUM)) {
+		pr_debug("PSC%x out of range\n", co->index);
+		return -EINVAL;
+	}
+
+	if (!np) {
+		pr_debug("PSC%x not found in device tree\n", co->index);
+		return -EINVAL;
+	}
+
+	pr_debug("Console on ttyPSC%x is %s\n",
+	         co->index, mpc52xx_uart_nodes[co->index]->full_name);
+
+	/* Fetch register locations */
+	if ((ret = of_address_to_resource(np, 0, &res)) != 0) {
+		pr_debug("Could not get resources for PSC%x\n", co->index);
+		return ret;
+	}
+
+	/* Search for bus-frequency property in this node or a parent */
+	if ((ipb_freq = mpc52xx_find_ipb_freq(np)) == 0) {
+		pr_debug("Could not find IPB bus frequency!\n");
+		return -EINVAL;
+	}
+
+	/* Basic port init. Needed since we use some uart_??? func before
+	 * real init for early access */
+	spin_lock_init(&port->lock);
+	port->uartclk	= ipb_freq / 2;
+	port->ops	= &mpc52xx_uart_ops;
+	port->mapbase = res.start;
+	port->membase = ioremap(res.start, sizeof(struct mpc52xx_psc));
+	port->irq = irq_of_parse_and_map(np, 0);
+
+	if (port->membase == NULL)
+		return -EINVAL;
+
+	pr_debug("mpc52xx-psc uart at %lx, mapped to %p, irq=%x, freq=%i\n",
+	         port->mapbase, port->membase, port->irq, port->uartclk);
+
+	/* Setup the port parameters accoding to options */
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	else
+		mpc52xx_console_get_options(port, &baud, &parity, &bits, &flow);
+
+	pr_debug("Setting console parameters: %i %i%c1 flow=%c\n",
+	         baud, bits, parity, flow);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+#endif /* defined(CONFIG_PPC_MERGE) */
+
 
 static struct uart_driver mpc52xx_uart_driver;
 
@@ -671,6 +789,7 @@ static struct console mpc52xx_console = 
 static int __init
 mpc52xx_console_init(void)
 {
+	mpc52xx_uart_of_enumerate();
 	register_console(&mpc52xx_console);
 	return 0;
 }
@@ -698,6 +817,7 @@ static struct uart_driver mpc52xx_uart_d
 };
 
 
+#if !defined(CONFIG_PPC_MERGE)
 /* ======================================================================== */
 /* Platform Driver                                                          */
 /* ======================================================================== */
@@ -721,8 +841,6 @@ mpc52xx_uart_probe(struct platform_devic
 	/* Init the port structure */
 	port = &mpc52xx_uart_ports[idx];
 
-	memset(port, 0x00, sizeof(struct uart_port));
-
 	spin_lock_init(&port->lock);
 	port->uartclk	= __res.bi_ipbfreq / 2; /* Look at CTLR doc */
 	port->fifosize	= 512;
@@ -731,6 +849,7 @@ mpc52xx_uart_probe(struct platform_devic
 			  ( uart_console(port) ? 0 : UPF_IOREMAP );
 	port->line	= idx;
 	port->ops	= &mpc52xx_uart_ops;
+	port->dev	= &dev->dev;
 
 	/* Search for IRQ and mapbase */
 	for (i=0 ; i<dev->num_resources ; i++, res++) {
@@ -787,6 +906,7 @@ mpc52xx_uart_resume(struct platform_devi
 }
 #endif
 
+
 static struct platform_driver mpc52xx_uart_platform_driver = {
 	.probe		= mpc52xx_uart_probe,
 	.remove		= mpc52xx_uart_remove,
@@ -798,6 +918,184 @@ #endif
 		.name	= "mpc52xx-psc",
 	},
 };
+#endif /* !defined(CONFIG_PPC_MERGE) */
+
+
+#if defined(CONFIG_PPC_MERGE)
+/* ======================================================================== */
+/* OF Platform Driver                                                       */
+/* ======================================================================== */
+
+static int __devinit
+mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
+{
+	int idx = -1;
+	unsigned int ipb_freq;
+	struct uart_port *port = NULL;
+	struct resource res;
+	int ret;
+
+	dev_dbg(&op->dev, "mpc52xx_uart_probe(op=%p, match=%p)\n", op, match);
+
+	/* Check validity & presence */
+	for (idx = 0; idx < MPC52xx_PSC_MAXNUM; idx++)
+		if (mpc52xx_uart_nodes[idx] == op->node)
+			break;
+	if (idx >= MPC52xx_PSC_MAXNUM)
+		return -EINVAL;
+	pr_debug("Found %s assigned to ttyPSC%x\n",
+	         mpc52xx_uart_nodes[idx]->full_name, idx);
+
+	/* Search for bus-frequency property in this node or a parent */
+	if ((ipb_freq = mpc52xx_find_ipb_freq(op->node)) == 0) {
+		dev_dbg(&op->dev, "Could not find IPB bus frequency!\n");
+		return -EINVAL;
+	}
+
+	/* Init the port structure */
+	port = &mpc52xx_uart_ports[idx];
+
+	spin_lock_init(&port->lock);
+	port->uartclk	= ipb_freq / 2;
+	port->fifosize	= 512;
+	port->iotype	= UPIO_MEM;
+	port->flags	= UPF_BOOT_AUTOCONF |
+			  ( uart_console(port) ? 0 : UPF_IOREMAP );
+	port->line	= idx;
+	port->ops	= &mpc52xx_uart_ops;
+	port->dev	= &op->dev;
+
+	/* Search for IRQ and mapbase */
+	if ((ret = of_address_to_resource(op->node, 0, &res)) != 0)
+		return ret;
+
+	port->mapbase = res.start;
+	port->irq = irq_of_parse_and_map(op->node, 0);
+
+	dev_dbg(&op->dev, "mpc52xx-psc uart at %lx, irq=%x, freq=%i\n",
+	        port->mapbase, port->irq, port->uartclk);
+
+	if ((port->irq==NO_IRQ) || !port->mapbase) {
+		printk(KERN_ERR "Could not allocate resources for PSC\n");
+		return -EINVAL;
+	}
+
+	/* Add the port to the uart sub-system */
+	ret = uart_add_one_port(&mpc52xx_uart_driver, port);
+	if (!ret)
+		dev_set_drvdata(&op->dev, (void*)port);
+
+	return ret;
+}
+
+static int
+mpc52xx_uart_of_remove(struct of_device *op)
+{
+	struct uart_port *port = dev_get_drvdata(&op->dev);
+	dev_set_drvdata(&op->dev, NULL);
+
+	if (port)
+		uart_remove_one_port(&mpc52xx_uart_driver, port);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int
+mpc52xx_uart_of_suspend(struct of_device *op, pm_message_t state)
+{
+	struct uart_port *port = (struct uart_port *) dev_get_drvdata(&op->dev);
+
+	if (port)
+		uart_suspend_port(&mpc52xx_uart_driver, port);
+
+	return 0;
+}
+
+static int
+mpc52xx_uart_of_resume(struct of_device *op)
+{
+	struct uart_port *port = (struct uart_port *) dev_get_drvdata(&op->dev);
+
+	if (port)
+		uart_resume_port(&mpc52xx_uart_driver, port);
+
+	return 0;
+}
+#endif
+
+static void
+mpc52xx_uart_of_assign(struct device_node *np, int idx)
+{
+	int free_idx = -1;
+	int i;
+
+	/* Find the first free node */
+	for (i = 0; i < MPC52xx_PSC_MAXNUM; i++) {
+		if (mpc52xx_uart_nodes[i] == NULL) {
+			free_idx = i;
+			break;
+		}
+	}
+
+	if ((idx < 0) || (idx >= MPC52xx_PSC_MAXNUM))
+		idx = free_idx;
+
+	if (idx < 0)
+		return; /* No free slot; abort */
+
+	/* If the slot is already occupied, then swap slots */
+	if (mpc52xx_uart_nodes[idx] && (free_idx != -1))
+		mpc52xx_uart_nodes[free_idx] = mpc52xx_uart_nodes[idx];
+	mpc52xx_uart_nodes[i] = np;
+}
+
+static void
+mpc52xx_uart_of_enumerate(void)
+{
+	static int enum_done = 0;
+	struct device_node *np;
+	const unsigned int *devno;
+	int i;
+
+	if (enum_done)
+		return;
+
+	for_each_node_by_type(np, "serial") {
+		if (!of_match_node(mpc52xx_uart_of_match, np))
+			continue;
+
+		/* Is a particular device number requested? */
+		devno = get_property(np, "device_no", NULL);
+		mpc52xx_uart_of_assign(of_node_get(np), devno ? *devno : -1);
+	}
+
+	enum_done = 1;
+
+	for (i = 0; i < MPC52xx_PSC_MAXNUM; i++) {
+		if (mpc52xx_uart_nodes[i])
+			pr_debug("%s assigned to ttyPSC%x\n",
+			         mpc52xx_uart_nodes[i]->full_name, i);
+	}
+}
+
+MODULE_DEVICE_TABLE(of, mpc52xx_uart_of_match);
+
+static struct of_platform_driver mpc52xx_uart_of_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "mpc52xx-psc-uart",
+	.match_table	= mpc52xx_uart_of_match,
+	.probe		= mpc52xx_uart_of_probe,
+	.remove		= mpc52xx_uart_of_remove,
+#ifdef CONFIG_PM
+	.suspend	= mpc52xx_uart_of_suspend,
+	.resume		= mpc52xx_uart_of_resume,
+#endif
+	.driver		= {
+		.name	= "mpc52xx-psc-uart",
+	},
+};
+#endif /* defined(CONFIG_PPC_MERGE) */
 
 
 /* ======================================================================== */
@@ -809,22 +1107,45 @@ mpc52xx_uart_init(void)
 {
 	int ret;
 
-	printk(KERN_INFO "Serial: MPC52xx PSC driver\n");
+	printk(KERN_INFO "Serial: MPC52xx PSC UART driver\n");
 
-	ret = uart_register_driver(&mpc52xx_uart_driver);
-	if (ret == 0) {
-		ret = platform_driver_register(&mpc52xx_uart_platform_driver);
-		if (ret)
-			uart_unregister_driver(&mpc52xx_uart_driver);
+	if ((ret = uart_register_driver(&mpc52xx_uart_driver)) != 0) {
+		printk(KERN_ERR "%s: uart_register_driver failed (%i)\n",
+		       __FILE__, ret);
+		return ret;
 	}
 
-	return ret;
+#if defined(CONFIG_PPC_MERGE)
+	mpc52xx_uart_of_enumerate();
+
+	ret = of_register_platform_driver(&mpc52xx_uart_of_driver);
+	if (ret) {
+		printk(KERN_ERR "%s: of_register_platform_driver failed (%i)\n",
+		       __FILE__, ret);
+		uart_unregister_driver(&mpc52xx_uart_driver);
+		return ret;
+	}
+#else
+	ret = platform_driver_register(&mpc52xx_uart_platform_driver);
+	if (ret) {
+		printk(KERN_ERR "%s: platform_driver_register failed (%i)\n",
+		       __FILE__, ret);
+		uart_unregister_driver(&mpc52xx_uart_driver);
+		return ret;
+	}
+#endif
+
+	return 0;
 }
 
 static void __exit
 mpc52xx_uart_exit(void)
 {
+#if defined(CONFIG_PPC_MERGE)
+	of_unregister_platform_driver(&mpc52xx_uart_of_driver);
+#else
 	platform_driver_unregister(&mpc52xx_uart_platform_driver);
+#endif
 	uart_unregister_driver(&mpc52xx_uart_driver);
 }
 
-- 
1.4.3.rc2.g0503
