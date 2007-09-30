Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 2A196DDEC4
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 08:41:55 +1000 (EST)
Received: from pd4mr3so.prod.shaw.ca
	(pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP7000M0DPUTI90@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:41:54 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP700H8MDPUY210@pd4mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 30 Sep 2007 16:41:54 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP700MCJDPPRP21@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:41:49 -0600 (MDT)
Date: Sun, 30 Sep 2007 16:41:49 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2 3/7] Uartlite: Add macro for uartlite device name
In-reply-to: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070930224147.1871.16384.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Changed to make the following OF_platform bus binding patch a wee bit cleaner

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/serial/uartlite.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index ae05a67..10e0da9 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <asm/io.h>
 
+#define ULITE_NAME		"ttyUL"
 #define ULITE_MAJOR		204
 #define ULITE_MINOR		187
 #define ULITE_NR_UARTS		4
@@ -381,7 +382,7 @@ static int __init ulite_console_setup(struct console *co, char *options)
 static struct uart_driver ulite_uart_driver;
 
 static struct console ulite_console = {
-	.name	= "ttyUL",
+	.name	= ULITE_NAME,
 	.write	= ulite_console_write,
 	.device	= uart_console_device,
 	.setup	= ulite_console_setup,
@@ -403,7 +404,7 @@ console_initcall(ulite_console_init);
 static struct uart_driver ulite_uart_driver = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "uartlite",
-	.dev_name	= "ttyUL",
+	.dev_name	= ULITE_NAME,
 	.major		= ULITE_MAJOR,
 	.minor		= ULITE_MINOR,
 	.nr		= ULITE_NR_UARTS,
