Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 9ECBADE5FA
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 12:16:39 +1000 (EST)
Received: from pd3mr1so.prod.shaw.ca
	(pd3mr1so-qfe3.prod.shaw.ca [10.0.141.177]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP900GP1IAYM830@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 01 Oct 2007 20:16:10 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd3mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP9007OJIAVCD10@pd3mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 01 Oct 2007 20:16:08 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP900HA6IAV8QA0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 01 Oct 2007 20:16:07 -0600 (MDT)
Date: Mon, 01 Oct 2007 20:16:09 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v3 12/12] Uartlite: Let the console be initialized earlier
In-reply-to: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20071002021609.9579.5233.stgit@trillian.cg.shawcable.net>
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

By configuring it earlier we get console output sooner which is helpful
for debugging when the kernel crashes before the serial drivers are
initialized.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/serial/uartlite.c |   41 ++++++++++++++++++++++++++++++++++++++---
 1 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index 0904c2a..2b8404c 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -373,6 +373,31 @@ static void ulite_console_write(struct console *co, const char *s,
 		spin_unlock_irqrestore(&port->lock, flags);
 }
 
+#if defined(CONFIG_OF)
+static inline void __init ulite_console_of_find_device(int id)
+{
+	struct device_node *np;
+	struct resource res;
+	const unsigned int *of_id;
+	int rc;
+
+	for_each_compatible_node(np, NULL, "xilinx,uartlite") {
+		of_id = of_get_property(np, "port-number", NULL);
+		if ((!of_id) || (*of_id != id))
+			continue;
+
+		rc = of_address_to_resource(np, 0, &res);
+		if (rc)
+			continue;
+
+		ulite_ports[id].mapbase = res.start;
+		return;
+	}
+}
+#else /* CONFIG_OF */
+static inline void __init ulite_console_of_find_device(int id) { /* do nothing */ }
+#endif /* CONFIG_OF */
+
 static int __init ulite_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
@@ -386,10 +411,20 @@ static int __init ulite_console_setup(struct console *co, char *options)
 
 	port = &ulite_ports[co->index];
 
+	/* Check if it is an OF device */
+	if (!port->mapbase)
+		ulite_console_of_find_device(co->index);
+
+	/* Do we have a device now? */
+	if (!port->mapbase) {
+		pr_debug("console on ttyUL%i not present\n", co->index);
+		return -ENODEV;
+	}
+
 	/* not initialized yet? */
 	if (!port->membase) {
-		pr_debug("console on ttyUL%i not initialized\n", co->index);
-		return -ENODEV;
+		if (ulite_request_port(port))
+			return -ENODEV;
 	}
 
 	if (options)
@@ -461,7 +496,7 @@ static int __devinit ulite_assign(struct device *dev, int id, u32 base, int irq)
 		return -EINVAL;
 	}
 
-	if (ulite_ports[id].mapbase) {
+	if ((ulite_ports[id].mapbase) && (ulite_ports[id].mapbase != base)) {
 		dev_err(dev, "cannot assign to %s%i; it is already in use\n",
 			ULITE_NAME, id);
 		return -EBUSY;
