Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (shawidc-mo1.cg.shawcable.net
	[24.71.223.10]) by ozlabs.org (Postfix) with ESMTP id B1A06DDED2
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 09:51:49 +1000 (EST)
Received: from pd4mr3so.prod.shaw.ca
	(pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JKX000LYRLYVP40@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 09 Jul 2007 17:51:34 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JKX00A41RLTR1H0@pd4mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 09 Jul 2007 17:51:30 -0600 (MDT)
Received: from trillian.secretlab.ca ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JKX001G1RLSWZB0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 09 Jul 2007 17:51:29 -0600 (MDT)
Date: Mon, 09 Jul 2007 17:51:05 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] xilinxfb: Parameterize xilinxfb platform device registration
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Message-id: <20070709235105.4826.79342.stgit@trillian>
Content-type: text/plain; charset=utf-8; format=fixed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch allows multiple xilinxfb devices to be registered and used

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
cc: Andrei Konovalov <akonovalov@ru.mvista.com>
---

 arch/ppc/syslib/virtex_devices.c |   38 +++++++++++++++++++++++++-------------
 1 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
index 83f978f..9b473cf 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -152,6 +152,21 @@
 	}, \
 }
 
+/*
+ * ML300/ML403 Video Device: shortcut macro for single instance
+ */
+#define XPAR_TFT(num) { \
+	.name = "xilinxfb", \
+	.id = num, \
+	.num_resources = 1, \
+	.resource = (struct resource[]) { \
+		{ \
+			.start = XPAR_TFT_##num##_BASEADDR, \
+			.end = XPAR_TFT_##num##_BASEADDR+7, \
+			.flags = IORESOURCE_IO, \
+		}, \
+	}, \
+}
 
 /* UART 8250 driver platform data table */
 struct plat_serial8250_port virtex_serial_platform_data[] = {
@@ -274,20 +289,17 @@ struct platform_device virtex_platform_devices[] = {
 #endif
 #endif
 
-	/* ML300/403 reference design framebuffer */
 #if defined(XPAR_TFT_0_BASEADDR)
-	{
-		.name		= "xilinxfb",
-		.id		= 0,
-		.num_resources	= 1,
-		.resource = (struct resource[]) {
-			{
-				.start	= XPAR_TFT_0_BASEADDR,
-				.end	= XPAR_TFT_0_BASEADDR+7,
-				.flags	= IORESOURCE_IO,
-			},
-		},
-	},
+	XPAR_TFT(0),
+#endif
+#if defined(XPAR_TFT_1_BASEADDR)
+	XPAR_TFT(1),
+#endif
+#if defined(XPAR_TFT_2_BASEADDR)
+	XPAR_TFT(2),
+#endif
+#if defined(XPAR_TFT_3_BASEADDR)
+	XPAR_TFT(3),
 #endif
 };
 
