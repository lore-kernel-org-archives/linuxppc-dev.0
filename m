Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 2E309DE122
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:18:29 +1000 (EST)
Received: from pd4mr1so.prod.shaw.ca
	(pd4mr1so-qfe3.prod.shaw.ca [10.0.141.212]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP3008AHC5F4J10@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:17:39 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd4mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP300MKYC5EH340@pd4mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Sep 2007 12:17:39 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300MAHC5AGQG3@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:17:34 -0600 (MDT)
Date: Fri, 28 Sep 2007 12:17:43 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 10/18] Uartlite: improve in-code comments
In-reply-to: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070928181740.18608.67126.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/serial/uartlite.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index c00a627..ed13b9f 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -23,9 +23,13 @@
 #define ULITE_MINOR		187
 #define ULITE_NR_UARTS		4
 
-/* For register details see datasheet:
-   http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf
-*/
+/* ---------------------------------------------------------------------
+ * Register definitions
+ *
+ * For register details see datasheet:
+ * http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf
+ */
+
 #define ULITE_RX		0x00
 #define ULITE_TX		0x04
 #define ULITE_STATUS		0x08
@@ -49,6 +53,10 @@
 
 static struct uart_port ulite_ports[ULITE_NR_UARTS];
 
+/* ---------------------------------------------------------------------
+ * Core UART driver operations
+ */
+
 static int ulite_receive(struct uart_port *port, int stat)
 {
 	struct tty_struct *tty = port->info->tty;
@@ -308,6 +316,10 @@ static struct uart_ops ulite_ops = {
 	.verify_port	= ulite_verify_port
 };
 
+/* ---------------------------------------------------------------------
+ * Console driver operations
+ */
+
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
 static void ulite_console_wait_tx(struct uart_port *port)
 {
@@ -413,6 +425,19 @@ static struct uart_driver ulite_uart_driver = {
 #endif
 };
 
+/* ---------------------------------------------------------------------
+ * Port assignment functions (mapping devices to uart_port structures)
+ */
+
+/** ulite_assign: register a uartlite device with the driver
+ *
+ * @dev: pointer to device structure
+ * @id: requested id number.  Pass -1 for automatic port assignment
+ * @base: base address of uartlite registers
+ * @irq: irq number for uartlite
+ *
+ * Returns: 0 on success, <0 otherwise
+ */
 static int __devinit ulite_assign(struct device *dev, int id, u32 base, int irq)
 {
 	struct uart_port *port;
@@ -465,6 +490,10 @@ static int __devinit ulite_assign(struct device *dev, int id, u32 base, int irq)
 	return 0;
 }
 
+/** ulite_release: register a uartlite device with the driver
+ *
+ * @dev: pointer to device structure
+ */
 static int __devinit ulite_release(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
@@ -479,6 +508,10 @@ static int __devinit ulite_release(struct device *dev)
 	return rc;
 }
 
+/* ---------------------------------------------------------------------
+ * Platform bus binding
+ */
+
 static int __devinit ulite_probe(struct platform_device *pdev)
 {
 	struct resource *res, *res2;
@@ -508,6 +541,10 @@ static struct platform_driver ulite_platform_driver = {
 		   },
 };
 
+/* ---------------------------------------------------------------------
+ * Module setup/teardown
+ */
+
 int __init ulite_init(void)
 {
 	int ret;
