Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 4E7CEDE22D
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 12:16:06 +1000 (EST)
Received: from pd4mr1so.prod.shaw.ca
	(pd4mr1so-qfe3.prod.shaw.ca [10.0.141.212]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP900AJQIATUUF0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 01 Oct 2007 20:16:05 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd4mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP900LABIASCE30@pd4mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 01 Oct 2007 20:16:04 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP9008XIIA83LE0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 01 Oct 2007 20:15:44 -0600 (MDT)
Date: Mon, 01 Oct 2007 20:15:44 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v3 07/12] Uartlite: change name of ports to ulite_ports
In-reply-to: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20071002021544.9579.60044.stgit@trillian.cg.shawcable.net>
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

Changed to match naming convention used in the rest of the module

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/serial/uartlite.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index 59b674a..ae05a67 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -46,7 +46,7 @@
 #define ULITE_CONTROL_IE	0x10
 
 
-static struct uart_port ports[ULITE_NR_UARTS];
+static struct uart_port ulite_ports[ULITE_NR_UARTS];
 
 static int ulite_receive(struct uart_port *port, int stat)
 {
@@ -329,7 +329,7 @@ static void ulite_console_putchar(struct uart_port *port, int ch)
 static void ulite_console_write(struct console *co, const char *s,
 				unsigned int count)
 {
-	struct uart_port *port = &ports[co->index];
+	struct uart_port *port = &ulite_ports[co->index];
 	unsigned long flags;
 	unsigned int ier;
 	int locked = 1;
@@ -366,7 +366,7 @@ static int __init ulite_console_setup(struct console *co, char *options)
 	if (co->index < 0 || co->index >= ULITE_NR_UARTS)
 		return -EINVAL;
 
-	port = &ports[co->index];
+	port = &ulite_ports[co->index];
 
 	/* not initialized yet? */
 	if (!port->membase)
@@ -420,7 +420,7 @@ static int __devinit ulite_probe(struct platform_device *pdev)
 	if (pdev->id < 0 || pdev->id >= ULITE_NR_UARTS)
 		return -EINVAL;
 
-	if (ports[pdev->id].membase)
+	if (ulite_ports[pdev->id].membase)
 		return -EBUSY;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -431,7 +431,7 @@ static int __devinit ulite_probe(struct platform_device *pdev)
 	if (!res2)
 		return -ENODEV;
 
-	port = &ports[pdev->id];
+	port = &ulite_ports[pdev->id];
 
 	port->fifosize	= 16;
 	port->regshift	= 2;
