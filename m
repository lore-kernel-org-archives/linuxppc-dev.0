Return-Path: <tnt@246tNt.com>
Received: from outmx012.isp.belgacom.be (outmx012.isp.belgacom.be
	[195.238.3.70]) by ozlabs.org (Postfix) with ESMTP id DB85467A87
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 10:11:39 +1100 (EST)
Received: from outmx012.isp.belgacom.be (localhost [127.0.0.1])
	by outmx012.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2LNBYBq013746
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Mar 2005 00:11:34 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (72.155-200-80.adsl.skynet.be
	[80.200.155.72])
	by outmx012.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2LNBWdK013724
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Mar 2005 00:11:32 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from localhost.localdomain (246tNt-laptop.lan.ayanami.246tNt.com
	[10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP id 36EAA110E1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 00:09:17 +0100 (CET)
Message-ID: <5.20050322_000905.tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <0.20050322_000905.tnt@patchsend.246tNt.com>
References: <0.20050322_000905.tnt@patchsend.246tNt.com>
Date: Tue, 22 Mar 2005 00:09:17 +0100 (CET)
Subject: [PATCH 5/6] serial: Update mpc52xx_uart.c to use platform bus
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

serial: Update mpc52xx_uart.c to use platform bus

All Freescale MPC52xx related code now use new constants and
the platform bus for it's driver. This patch makes this driver
make use of that.


Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
diff -Nru a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
--- a/drivers/serial/mpc52xx_uart.c	2005-03-21 20:11:00 +01:00
+++ b/drivers/serial/mpc52xx_uart.c	2005-03-21 20:11:00 +01:00
@@ -18,7 +18,7 @@
  * Some of the code has been inspired/copied from the 2.4 code written
  * by Dale Farnsworth <dfarnsworth@mvista.com>.
  * 
- * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2004-2005 Sylvain Munaut <tnt@246tNt.com>
  * Copyright (C) 2003 MontaVista, Software, Inc.
  * 
  * This file is licensed under the terms of the GNU General Public License
@@ -26,33 +26,26 @@
  * kind, whether express or implied.
  */
  
-/* OCP Usage :
+/* Platform device Usage :
  *
- * This drivers uses the OCP model. To load the serial driver for one of the
- * PSCs, just add this to the core_ocp table :
+ * Since PSCs can have multiple function, the correct driver for each one
+ * is selected by calling mpc52xx_match_psc_function(...). The function
+ * handled by this driver is "uart".
  *
- * {
- * 	.vendor         = OCP_VENDOR_FREESCALE,
- * 	.function       = OCP_FUNC_PSC_UART,
- * 	.index          = 0,
- * 	.paddr          = MPC52xx_PSC1,
- * 	.irq            = MPC52xx_PSC1_IRQ,
- * 	.pm             = OCP_CPM_NA,
- * },
- *
- * This is for PSC1, replace the paddr and irq according to the PSC you want to
- * use. The driver all necessary registers to place the PSC in uart mode without
+ * The driver init all necessary registers to place the PSC in uart mode without
  * DCD. However, the pin multiplexing aren't changed and should be set either
  * by the bootloader or in the platform init code.
- * The index field must be equal to the PSC index ( e.g. 0 for PSC1, 1 for PSC2,
+ *
+ * The idx field must be equal to the PSC index ( e.g. 0 for PSC1, 1 for PSC2,
  * and so on). So the PSC1 is mapped to /dev/ttyS0, PSC2 to /dev/ttyS1 and so
  * on. But be warned, it's an ABSOLUTE REQUIREMENT ! This is needed mainly for
  * the console code : without this 1:1 mapping, at early boot time, when we are
  * parsing the kernel args console=ttyS?, we wouldn't know wich PSC it will be
- * mapped to because OCP stuff is not yet initialized.
+ * mapped to.
  */
 
 #include <linux/config.h>
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/serial.h>
@@ -61,7 +54,6 @@
 
 #include <asm/delay.h>
 #include <asm/io.h>
-#include <asm/ocp.h>
 
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
@@ -191,6 +183,13 @@
 mpc52xx_uart_startup(struct uart_port *port)
 {
 	struct mpc52xx_psc __iomem *psc = PSC(port);
+	int ret;
+
+	/* Request IRQ */
+	ret = request_irq(port->irq, mpc52xx_uart_int,
+		SA_INTERRUPT | SA_SAMPLE_RANDOM, "mpc52xx_psc_uart", port);
+	if (ret)
+		return ret;
 
 	/* Reset/activate the port, clear and enable interrupts */
 	out_8(&psc->command,MPC52xx_PSC_RST_RX);
@@ -225,6 +224,9 @@
 	
 	port->read_status_mask = 0; 
 	out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
+
+	/* Release interrupt */
+	free_irq(port->irq, port);
 }
 
 static void 
@@ -326,15 +328,21 @@
 		iounmap(port->membase);
 		port->membase = NULL;
 	}
+
+	release_mem_region(port->mapbase, MPC52xx_PSC_SIZE);
 }
 
 static int
 mpc52xx_uart_request_port(struct uart_port *port)
 {
 	if (port->flags & UPF_IOREMAP) /* Need to remap ? */
-		port->membase = ioremap(port->mapbase, sizeof(struct mpc52xx_psc));
-	
-	return port->membase != NULL ? 0 : -EBUSY;
+		port->membase = ioremap(port->mapbase, MPC52xx_PSC_SIZE);
+
+	if (!port->membase)
+		return -EINVAL;
+
+	return request_mem_region(port->mapbase, MPC52xx_PSC_SIZE,
+			"mpc52xx_psc_uart") != NULL ? 0 : -EBUSY;
 }
 
 static void
@@ -354,7 +362,7 @@
 	if ( (ser->irq != port->irq) ||
 	     (ser->io_type != SERIAL_IO_MEM) ||
 	     (ser->baud_base != port->uartclk)  || 
-	     // FIXME Should check addresses/irq as well ?
+	     (ser->iomem_base != (void*)port->mapbase) ||
 	     (ser->hub6 != 0 ) )
 		return -EINVAL;
 
@@ -630,7 +638,7 @@
 {
 	struct uart_port *port = &mpc52xx_uart_ports[co->index];
 
-	int baud = 9600;
+	int baud = CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
@@ -643,14 +651,12 @@
 	spin_lock_init(&port->lock);
 	port->uartclk	= __res.bi_ipbfreq / 2; /* Look at CTLR doc */
 	port->ops	= &mpc52xx_uart_ops;
-	port->mapbase	= MPC52xx_PSCx(co->index);
+	port->mapbase	= MPC52xx_PA(MPC52xx_PSCx_OFFSET(co->index+1));
 
-		/* We ioremap ourself */
-	port->membase = ioremap(port->mapbase, sizeof(struct mpc52xx_psc));
-	if (port->membase == NULL) {
-		release_mem_region(port->mapbase, sizeof(struct mpc52xx_psc));
-		return -EBUSY;
-	}
+	/* We ioremap ourself */
+	port->membase = ioremap(port->mapbase, MPC52xx_PSC_SIZE);
+	if (port->membase == NULL)
+		return -EINVAL;
 
 	/* Setup the port parameters accoding to options */
 	if (options)
@@ -707,26 +713,32 @@
 
 
 /* ======================================================================== */
-/* OCP Driver                                                               */
+/* Platform Driver                                                          */
 /* ======================================================================== */
 
 static int __devinit
-mpc52xx_uart_probe(struct ocp_device *ocp)
+mpc52xx_uart_probe(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res = pdev->resource;
+
 	struct uart_port *port = NULL;
-	int idx, ret;
+	int i, idx, ret;
 
-	/* Get the corresponding port struct */
-	idx = ocp->def->index;
+	/* Check validity & presence */
+	idx = pdev->id;
 	if (idx < 0 || idx >= MPC52xx_PSC_MAXNUM)
 		return -EINVAL;
-	
-	port = &mpc52xx_uart_ports[idx];
+
+	if (!mpc52xx_match_psc_function(idx,"uart"))
+		return -ENODEV;
 
 	/* Init the port structure */
+	port = &mpc52xx_uart_ports[idx];
+
+	memset(port, 0x00, sizeof(struct uart_port));
+
 	spin_lock_init(&port->lock);
-	port->mapbase	= ocp->def->paddr;
-	port->irq	= ocp->def->irq;
 	port->uartclk	= __res.bi_ipbfreq / 2; /* Look at CTLR doc */
 	port->fifosize	= 255; /* Should be 512 ! But it can't be */
 	                       /* stored in a unsigned char       */
@@ -735,95 +747,65 @@
 			  ( uart_console(port) ? 0 : UPF_IOREMAP );
 	port->line	= idx;
 	port->ops	= &mpc52xx_uart_ops;
-	port->read_status_mask = 0;
-	
-	/* Requests the mem & irqs */
-	/* Unlike other serial drivers, we reserve the resources here, so we
-	 * can detect early if multiple drivers uses the same PSC. Special
-	 * care must be taken with the console PSC
-	 */
-	ret = request_irq(
-		port->irq, mpc52xx_uart_int,
-		SA_INTERRUPT | SA_SAMPLE_RANDOM, "mpc52xx_psc_uart", port);
-	if (ret)
-		goto error;
 
-	ret = request_mem_region(port->mapbase, sizeof(struct mpc52xx_psc),
-	                         "mpc52xx_psc_uart") != NULL ? 0 : -EBUSY;
-	if (ret)
-		goto free_irq;
+	/* Search for IRQ and mapbase */
+	for (i=0 ; i<pdev->num_resources ; i++, res++) {
+		if (res->flags & IORESOURCE_MEM)
+			port->mapbase = res->start;
+		else if (res->flags & IORESOURCE_IRQ)
+			port->irq = res->start;
+	}
+	if (!port->irq || !port->mapbase)
+		return -EINVAL;
 
 	/* Add the port to the uart sub-system */
 	ret = uart_add_one_port(&mpc52xx_uart_driver, port);
-	if (ret)
-		goto release_mem;
-
-	ocp_set_drvdata(ocp, (void*)port);
-
-	return 0;
-
-
-free_irq:
-	free_irq(port->irq, mpc52xx_uart_int);
-
-release_mem:
-	release_mem_region(port->mapbase, sizeof(struct mpc52xx_psc));
-
-error:
-	if (uart_console(port))
-		printk(	"mpc52xx_uart.c: Error during resource alloction for "
-			"the console port !!! Check that the console PSC is "
-			"not used by another OCP driver !!!\n" );
+	if (!ret)
+		dev_set_drvdata(dev, (void*)port);
 
 	return ret;
 }
 
-static void
-mpc52xx_uart_remove(struct ocp_device *ocp)
+static int
+mpc52xx_uart_remove(struct device *dev)
 {
-	struct uart_port *port = (struct uart_port *) ocp_get_drvdata(ocp);
+	struct uart_port *port = (struct uart_port *) dev_get_drvdata(dev);
 
-	ocp_set_drvdata(ocp, NULL);
+	dev_set_drvdata(dev, NULL);
 
-	if (port) {
+	if (port)
 		uart_remove_one_port(&mpc52xx_uart_driver, port);
-		release_mem_region(port->mapbase, sizeof(struct mpc52xx_psc));
-		free_irq(port->irq, mpc52xx_uart_int);
-	}
+
+	return 0;
 }
 
 #ifdef CONFIG_PM
 static int
-mpc52xx_uart_suspend(struct ocp_device *ocp, u32 state)
+mpc52xx_uart_suspend(struct device *dev, u32 state, u32 level)
 {
-	struct uart_port *port = (struct uart_port *) ocp_get_drvdata(ocp);
+	struct uart_port *port = (struct uart_port *) dev_get_drvdata(dev);
 
-	uart_suspend_port(&mpc52xx_uart_driver, port);
+	if (sport && level == SUSPEND_DISABLE)
+		uart_suspend_port(&mpc52xx_uart_driver, port);
 
 	return 0;
 }
 
 static int
-mpc52xx_uart_resume(struct ocp_device *ocp)
+mpc52xx_uart_resume(struct device *dev, u32 level)
 {
-	struct uart_port *port = (struct uart_port *) ocp_get_drvdata(ocp);
+	struct uart_port *port = (struct uart_port *) dev_get_drvdata(dev);
 
-	uart_resume_port(&mpc52xx_uart_driver, port);
+	if (port && level == RESUME_ENABLE)
+		uart_resume_port(&mpc52xx_uart_driver, port);
 
 	return 0;
 }
 #endif
 
-static struct ocp_device_id mpc52xx_uart_ids[] __devinitdata = {
-	{ .vendor = OCP_VENDOR_FREESCALE, .function = OCP_FUNC_PSC_UART },
-	{ .vendor = OCP_VENDOR_INVALID /* Terminating entry */ }
-};
-
-MODULE_DEVICE_TABLE(ocp, mpc52xx_uart_ids);
-
-static struct ocp_driver mpc52xx_uart_ocp_driver = {
-	.name		= "mpc52xx_psc_uart",
-	.id_table	= mpc52xx_uart_ids,
+static struct device_driver mpc52xx_uart_platform_driver = {
+	.name		= "mpc52xx-psc",
+	.bus		= &platform_bus_type,
 	.probe		= mpc52xx_uart_probe,
 	.remove		= mpc52xx_uart_remove,
 #ifdef CONFIG_PM
@@ -845,10 +827,11 @@
 	printk(KERN_INFO "Serial: MPC52xx PSC driver\n");
 
 	ret = uart_register_driver(&mpc52xx_uart_driver);
-	if (ret)
-		return ret;
-
-	ret = ocp_register_driver(&mpc52xx_uart_ocp_driver);
+	if (ret == 0) {
+		ret = driver_register(&mpc52xx_uart_platform_driver);
+		if (ret)
+			uart_unregister_driver(&mpc52xx_uart_driver);
+	}
 
 	return ret;
 }
@@ -856,7 +839,7 @@
 static void __exit
 mpc52xx_uart_exit(void)
 {
-	ocp_unregister_driver(&mpc52xx_uart_ocp_driver);
+	driver_unregister(&mpc52xx_uart_platform_driver);
 	uart_unregister_driver(&mpc52xx_uart_driver);
 }
