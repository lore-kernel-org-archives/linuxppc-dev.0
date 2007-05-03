Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id DBCC5DDD04
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 May 2007 03:24:10 +1000 (EST)
Message-ID: <463A1BEC.4040700@ru.mvista.com>
Date: Thu, 03 May 2007 21:29:16 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Xilinx framebuffer device driver - 3d version
References: <463A1B58.8000804@ru.mvista.com>
In-Reply-To: <463A1B58.8000804@ru.mvista.com>
Content-Type: multipart/mixed; boundary="------------060006050800040705020502"
Cc: Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060006050800040705020502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Andrei Konovalov wrote:
> Add support for the video controller IP block included into Xilinx ML300
> and ML403 reference designs.
> 
> Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>
> 
> -----
> The driver has been tested with Xilinx ML300 and ML403 reference designs.
> 
> The two first version has been posted to linuxppc-embedded, and this
> version tries to address all the comments and criticism received.
> 
> The platform device registration for Xilinx ML300 and ML403
> moved into separate patch (will be posted to linuxppc-embedded
> in couple minutes).

Here is the platform device registration part.


Thanks,
Andrei

--------------060006050800040705020502
Content-Type: text/x-patch;
 name="ppc32-enable-xilinx_fb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc32-enable-xilinx_fb.patch"

Index: linux-2.6.20/arch/ppc/platforms/4xx/xilinx_ml403.c
===================================================================
--- linux-2.6.20.orig/arch/ppc/platforms/4xx/xilinx_ml403.c
+++ linux-2.6.20/arch/ppc/platforms/4xx/xilinx_ml403.c
@@ -118,3 +118,20 @@ platform_init(unsigned long r3, unsigned
 #endif
 }
 
+static struct xilinxfb_platform_data xilinxfb_ml403_pdata = {
+	.rotate_screen = 0,
+	.screen_height_mm = -1,
+	.screen_width_mm = -1,
+};
+
+int __init virtex_device_fixup(struct platform_device *dev)
+{
+	if (strcmp(dev->name, "xilinxfb") == 0) {
+		if (dev->id != 0) /* paranoic */
+			return 1;
+		dev->dev.platform_data = &xilinxfb_ml403_pdata;
+		return 0;
+	}
+	return 0;
+}
+
Index: linux-2.6.20/arch/ppc/platforms/4xx/xilinx_ml300.c
===================================================================
--- linux-2.6.20.orig/arch/ppc/platforms/4xx/xilinx_ml300.c
+++ linux-2.6.20/arch/ppc/platforms/4xx/xilinx_ml300.c
@@ -116,3 +116,20 @@ platform_init(unsigned long r3, unsigned
 #endif
 }
 
+static struct xilinxfb_platform_data xilinxfb_ml300_pdata = {
+	.rotate_screen = 1,
+	.screen_height_mm = 99,
+	.screen_width_mm = 132,
+};
+
+int __init virtex_device_fixup(struct platform_device *dev)
+{
+	if (strcmp(dev->name, "xilinxfb") == 0) {
+		if (dev->id != 0) /* paranoic */
+			return 1;
+		dev->dev.platform_data = &xilinxfb_ml300_pdata;
+		return 0;
+	}
+	return 0;
+}
+
Index: linux-2.6.20/arch/ppc/syslib/virtex_devices.c
===================================================================
--- linux-2.6.20.orig/arch/ppc/syslib/virtex_devices.c
+++ linux-2.6.20/arch/ppc/syslib/virtex_devices.c
@@ -71,7 +71,23 @@
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
 
+ 
 /* UART 8250 driver platform data table */
 struct plat_serial8250_port virtex_serial_platform_data[] = {
 #if defined(XPAR_UARTNS550_0_BASEADDR)
@@ -146,20 +162,12 @@ struct platform_device virtex_platform_d
 	XPAR_SYSACE(1),
 #endif
 
-	/* ML300/403 reference design framebuffer */
+	/* ML300/ML403 reference design framebuffer */
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
 #endif
 };
 

--------------060006050800040705020502--
