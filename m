Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 35A02DE4D5
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:18:21 +1000 (EST)
Received: from pd2mr4so.prod.shaw.ca
	(pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP300AV5C4WX1B0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:17:20 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP300GTEC4VU760@pd2mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Sep 2007 12:17:20 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300MURC4VGOJ3@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:17:19 -0600 (MDT)
Date: Fri, 28 Sep 2007 12:17:28 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 08/18] Uartlite: Add macro for uartlite device name
In-reply-to: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070928181726.18608.73695.stgit@trillian.cg.shawcable.net>
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

Changed to make the OF bus binding a wee bit cleaner

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/40x/Kconfig |    4 ++--
 drivers/serial/uartlite.c          |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 1aae0e6..44f08dd 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -65,8 +65,8 @@ config XILINX_VIRTEX_GENERIC_BOARD
 	bool "Generic Xilinx Virtex board"
 	depends on 40x
 	default y
-	select VIRTEX_II_PRO
-	select VIRTEX_4_FX
+	select XILINX_VIRTEX_II_PRO
+	select XILINX_VIRTEX_4_FX
 	help
 	  This option enables generic support for Xilinx Virtex based boards.
 
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
