Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 696BCDDF19
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 04:32:54 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6HIWp5n011677
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 14:32:51 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6HIWjkA190764
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6HIWjas013390
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:45 -0600
Message-Id: <20070717182620.417567000@linux.vnet.ibm.com>>
References: <20070717181547.310201000@linux.vnet.ibm.com>>
Date: Tue, 17 Jul 2007 13:15:48 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 01/14] Use resource_size_t for serial port IO addresses
In-Reply-To: <20070717181547.310201000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
Cc: David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At present, various parts of the serial code use unsigned long to
define resource addresses.  This is a problem, because some 32-bit
platforms have physical addresses larger than 32-bits, and have mmio
serial uarts located above the 4GB point.

This patch changes the type of mapbase in both struct uart_port and
struct plat_serial8250_port to resource_size_t, which can be
configured to be 64 bits on such platforms.  The mapbase in
serial_struct can't safely be changed, because that structure is user
visible.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 drivers/serial/8250.c        |    5 +++--
 drivers/serial/8250_early.c  |   16 +++++++++-------
 drivers/serial/serial_core.c |    9 +++++----
 include/linux/serial_8250.h  |    2 +-
 include/linux/serial_core.h  |    2 +-
 5 files changed, 19 insertions(+), 15 deletions(-)

--- linux-2.6.orig/include/linux/serial_core.h
+++ linux-2.6/include/linux/serial_core.h
@@ -284,7 +284,7 @@ struct uart_port {
 	const struct uart_ops	*ops;
 	unsigned int		custom_divisor;
 	unsigned int		line;			/* port index */
-	unsigned long		mapbase;		/* for ioremap */
+	resource_size_t		mapbase;		/* for ioremap */
 	struct device		*dev;			/* parent device */
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		unused[3];
--- linux-2.6.orig/drivers/serial/serial_core.c
+++ linux-2.6/drivers/serial/serial_core.c
@@ -626,7 +626,7 @@ static int uart_get_info(struct uart_sta
 	tmp.hub6	    = port->hub6;
 	tmp.io_type         = port->iotype;
 	tmp.iomem_reg_shift = port->regshift;
-	tmp.iomem_base      = (void *)port->mapbase;
+	tmp.iomem_base      = (void *)(unsigned long)port->mapbase;
 
 	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
 		return -EFAULT;
@@ -1666,10 +1666,11 @@ static int uart_line_info(char *buf, str
 		return 0;
 
 	mmio = port->iotype >= UPIO_MEM;
-	ret = sprintf(buf, "%d: uart:%s %s%08lX irq:%d",
+	ret = sprintf(buf, "%d: uart:%s %s%08llX irq:%d",
 			port->line, uart_type(port),
 			mmio ? "mmio:0x" : "port:",
-			mmio ? port->mapbase : (unsigned long) port->iobase,
+			mmio ? (unsigned long long)port->mapbase
+		             : (unsigned long long) port->iobase,
 			port->irq);
 
 	if (port->type == PORT_UNKNOWN) {
@@ -2063,7 +2064,7 @@ uart_report_port(struct uart_driver *drv
 	case UPIO_TSI:
 	case UPIO_DWAPB:
 		snprintf(address, sizeof(address),
-			 "MMIO 0x%lx", port->mapbase);
+			 "MMIO 0x%llx", (unsigned long long)port->mapbase);
 		break;
 	default:
 		strlcpy(address, "*unknown*", sizeof(address));
--- linux-2.6.orig/drivers/serial/8250_early.c
+++ linux-2.6/drivers/serial/8250_early.c
@@ -145,8 +145,9 @@ static int __init parse_options(struct e
 		port->mapbase = simple_strtoul(options + 5, &options, 0);
 		port->membase = ioremap(port->mapbase, mapsize);
 		if (!port->membase) {
-			printk(KERN_ERR "%s: Couldn't ioremap 0x%lx\n",
-				__FUNCTION__, port->mapbase);
+			printk(KERN_ERR "%s: Couldn't ioremap 0x%llx\n",
+				__FUNCTION__,
+			       (unsigned long long)port->mapbase);
 			return -ENOMEM;
 		}
 		mmio = 1;
@@ -168,9 +169,10 @@ static int __init parse_options(struct e
 			device->baud);
 	}
 
-	printk(KERN_INFO "Early serial console at %s 0x%lx (options '%s')\n",
+	printk(KERN_INFO "Early serial console at %s 0x%llx (options '%s')\n",
 		mmio ? "MMIO" : "I/O port",
-		mmio ? port->mapbase : (unsigned long) port->iobase,
+		mmio ? (unsigned long long) port->mapbase
+	             : (unsigned long long) port->iobase,
 		device->options);
 	return 0;
 }
@@ -236,10 +238,10 @@ static int __init early_uart_console_swi
 	mmio = (port->iotype == UPIO_MEM);
 	line = serial8250_start_console(port, device->options);
 	if (line < 0)
-		printk("No ttyS device at %s 0x%lx for console\n",
+		printk("No ttyS device at %s 0x%llx for console\n",
 			mmio ? "MMIO" : "I/O port",
-			mmio ? port->mapbase :
-			    (unsigned long) port->iobase);
+			mmio ? (unsigned long long) port->mapbase
+		             : (unsigned long long) port->iobase);
 
 	unregister_console(&early_uart_console);
 	if (mmio)
--- linux-2.6.orig/include/linux/serial_8250.h
+++ linux-2.6/include/linux/serial_8250.h
@@ -20,7 +20,7 @@
 struct plat_serial8250_port {
 	unsigned long	iobase;		/* io base address */
 	void __iomem	*membase;	/* ioremap cookie or NULL */
-	unsigned long	mapbase;	/* resource base */
+	resource_size_t	mapbase;	/* resource base */
 	unsigned int	irq;		/* interrupt number */
 	unsigned int	uartclk;	/* UART clock rate */
 	unsigned char	regshift;	/* register shift */
--- linux-2.6.orig/drivers/serial/8250.c
+++ linux-2.6/drivers/serial/8250.c
@@ -2664,8 +2664,9 @@ static int __devinit serial8250_probe(st
 		ret = serial8250_register_port(&port);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
-				"(IO%lx MEM%lx IRQ%d): %d\n", i,
-				p->iobase, p->mapbase, p->irq, ret);
+				"(IO%lx MEM%llx IRQ%d): %d\n", i,
+				p->iobase, (unsigned long long)p->mapbase,
+				p->irq, ret);
 		}
 	}
 	return 0;

-- 
