Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 00BBDDE80A
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 12:16:55 +1000 (EST)
Received: from pd2mr2so.prod.shaw.ca
	(pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP900GVFIAUZGA0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 01 Oct 2007 20:16:06 -0600 (MDT)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
	by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP900MRVIASC740@pd2mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 01 Oct 2007 20:16:05 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP900DG5IAGHG01@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 01 Oct 2007 20:15:52 -0600 (MDT)
Date: Mon, 01 Oct 2007 20:15:54 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v3 09/12] Uartlite: Separate the bus binding from the driver
	proper
In-reply-to: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20071002021554.9579.53909.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Separate the bus binding code from the driver structure allocation code in
preparation for adding the of_platform_bus bindings needed by arch/powerpc

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/serial/uartlite.c |   99 ++++++++++++++++++++++++++++++---------------
 1 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index 10e0da9..c00a627 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -413,59 +413,90 @@ static struct uart_driver ulite_uart_driver = {
 #endif
 };
 
-static int __devinit ulite_probe(struct platform_device *pdev)
+static int __devinit ulite_assign(struct device *dev, int id, u32 base, int irq)
 {
-	struct resource *res, *res2;
 	struct uart_port *port;
+	int rc;
 
-	if (pdev->id < 0 || pdev->id >= ULITE_NR_UARTS)
+	/* if id = -1; then scan for a free id and use that */
+	if (id < 0) {
+		for (id = 0; id < ULITE_NR_UARTS; id++)
+			if (ulite_ports[id].mapbase == 0)
+				break;
+	}
+	if (id < 0 || id >= ULITE_NR_UARTS) {
+		dev_err(dev, "%s%i too large\n", ULITE_NAME, id);
 		return -EINVAL;
+	}
 
-	if (ulite_ports[pdev->id].membase)
+	if (ulite_ports[id].mapbase) {
+		dev_err(dev, "cannot assign to %s%i; it is already in use\n",
+			ULITE_NAME, id);
 		return -EBUSY;
+	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	port = &ulite_ports[id];
 
-	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res2)
-		return -ENODEV;
+	spin_lock_init(&port->lock);
+	port->fifosize = 16;
+	port->regshift = 2;
+	port->iotype = UPIO_MEM;
+	port->iobase = 1; /* mark port in use */
+	port->mapbase = base;
+	port->membase = NULL;
+	port->ops = &ulite_ops;
+	port->irq = irq;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->dev = dev;
+	port->type = PORT_UNKNOWN;
+	port->line = id;
+
+	dev_set_drvdata(dev, port);
+
+	/* Register the port */
+	rc = uart_add_one_port(&ulite_uart_driver, port);
+	if (rc) {
+		dev_err(dev, "uart_add_one_port() failed; err=%i\n", rc);
+		port->mapbase = 0;
+		dev_set_drvdata(dev, NULL);
+		return rc;
+	}
 
-	port = &ulite_ports[pdev->id];
+	return 0;
+}
 
-	port->fifosize	= 16;
-	port->regshift	= 2;
-	port->iotype	= UPIO_MEM;
-	port->iobase	= 1; /* mark port in use */
-	port->mapbase	= res->start;
-	port->membase	= NULL;
-	port->ops	= &ulite_ops;
-	port->irq	= res2->start;
-	port->flags	= UPF_BOOT_AUTOCONF;
-	port->dev	= &pdev->dev;
-	port->type	= PORT_UNKNOWN;
-	port->line	= pdev->id;
+static int __devinit ulite_release(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	int rc = 0;
 
-	uart_add_one_port(&ulite_uart_driver, port);
-	platform_set_drvdata(pdev, port);
+	if (port) {
+		rc = uart_remove_one_port(&ulite_uart_driver, port);
+		dev_set_drvdata(dev, NULL);
+		port->mapbase = 0;
+	}
 
-	return 0;
+	return rc;
 }
 
-static int ulite_remove(struct platform_device *pdev)
+static int __devinit ulite_probe(struct platform_device *pdev)
 {
-	struct uart_port *port = platform_get_drvdata(pdev);
+	struct resource *res, *res2;
 
-	platform_set_drvdata(pdev, NULL);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
 
-	if (port)
-		uart_remove_one_port(&ulite_uart_driver, port);
+	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res2)
+		return -ENODEV;
 
-	/* mark port as free */
-	port->membase = NULL;
+	return ulite_assign(&pdev->dev, pdev->id, res->start, res2->start);
+}
 
-	return 0;
+static int ulite_remove(struct platform_device *pdev)
+{
+	return ulite_release(&pdev->dev);
 }
 
 static struct platform_driver ulite_platform_driver = {
