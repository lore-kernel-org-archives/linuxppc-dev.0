Return-Path: <dan@danny.cz>
Received: from eagle.danny.cz (unknown
 [IPv6:2a01:8c00:ffb3:160:222:15ff:fe86:f1bd])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 952C42C0087
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 22:41:55 +1000 (EST)
From: =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] add GXT4000P and GXT6500P support to the gxt4500 driver
Date: Wed, 12 Sep 2012 14:20:12 +0200
Message-Id: <1347452412-7129-1-git-send-email-dan@danny.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nico Macrionitis <acrux@cruxppc.org>, Giuseppe Coviello <cjg@cruxppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm reviving an old patch from 2009 that adds support for GXT4000P and GXT6500P
adapter to the gxt4500 driver.

See threads at http://marc.info/?l=linux-fbdev-devel&m=124345080216952&w=2
and https://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/072672.html
for more details.

This patch adds support for GXT4000P and GXT6500P cards found on some
IBM pSeries machines.
GXT4000P/6000P and GXT4500P/6500P  couples are  identical from
software's point of view and are based on the same  Raster Engine
(RC1000), except for a different reference clock for the PLL.
GXT6x00P models are equipped with an additional Geometry Engine
(GT1000) but this driver doesn't use it.

Signed-off-by: Nico Macrionitis <acrux@cruxppc.org>
Signed-off-by: Giuseppe Coviello <cjg@cruxppc.org>
Tested-by: Dan Horák <dan@danny.cz>
---
 drivers/video/Kconfig   |    8 +++++---
 drivers/video/gxt4500.c |   15 +++++++++++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0217f74..c89eb1e 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2167,14 +2167,16 @@ config FB_PNX4008_DUM_RGB
 	  Say Y here to enable support for PNX4008 RGB Framebuffer
 
 config FB_IBM_GXT4500
-	tristate "Framebuffer support for IBM GXT4500P adaptor"
+	tristate "Framebuffer support for IBM GXT4000P/4500P/6000P/6500P adaptors"
 	depends on FB && PPC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	---help---
-	  Say Y here to enable support for the IBM GXT4500P display
-	  adaptor, found on some IBM System P (pSeries) machines.
+	  Say Y here to enable support for the IBM GXT4000P/6000P and
+	  GXT4500P/6500P display adaptor based on Raster Engine RC1000,
+	  found on some IBM System P (pSeries) machines. This driver
+	  doesn't use Geometry Engine GT1000.
 
 config FB_PS3
 	tristate "PS3 GPU framebuffer driver"
diff --git a/drivers/video/gxt4500.c b/drivers/video/gxt4500.c
index 0fad23f..755c3e7 100644
--- a/drivers/video/gxt4500.c
+++ b/drivers/video/gxt4500.c
@@ -1,5 +1,6 @@
 /*
- * Frame buffer device for IBM GXT4500P and GXT6000P display adaptors
+ * Frame buffer device for IBM GXT4500P/6500P and GXT4000P/6000P
+ * display adaptors
  *
  * Copyright (C) 2006 Paul Mackerras, IBM Corp. <paulus@samba.org>
  */
@@ -14,6 +15,8 @@
 #include <linux/string.h>
 
 #define PCI_DEVICE_ID_IBM_GXT4500P	0x21c
+#define PCI_DEVICE_ID_IBM_GXT6500P	0x21b
+#define PCI_DEVICE_ID_IBM_GXT4000P	0x16e
 #define PCI_DEVICE_ID_IBM_GXT6000P	0x170
 
 /* GXT4500P registers */
@@ -173,6 +176,8 @@ static const struct fb_videomode defaultmode __devinitdata = {
 /* List of supported cards */
 enum gxt_cards {
 	GXT4500P,
+	GXT6500P,
+	GXT4000P,
 	GXT6000P
 };
 
@@ -182,6 +187,8 @@ static const struct cardinfo {
 	const char *cardname;
 } cardinfo[] = {
 	[GXT4500P] = { .refclk_ps = 9259, .cardname = "IBM GXT4500P" },
+	[GXT6500P] = { .refclk_ps = 9259, .cardname = "IBM GXT6500P" },
+	[GXT4000P] = { .refclk_ps = 40000, .cardname = "IBM GXT4000P" },
 	[GXT6000P] = { .refclk_ps = 40000, .cardname = "IBM GXT6000P" },
 };
 
@@ -736,6 +743,10 @@ static void __devexit gxt4500_remove(struct pci_dev *pdev)
 static const struct pci_device_id gxt4500_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4500P),
 	  .driver_data = GXT4500P },
+	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT6500P),
+	  .driver_data = GXT6500P },
+	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4000P),
+	  .driver_data = GXT4000P },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT6000P),
 	  .driver_data = GXT6000P },
 	{ 0 }
@@ -768,7 +779,7 @@ static void __exit gxt4500_exit(void)
 module_exit(gxt4500_exit);
 
 MODULE_AUTHOR("Paul Mackerras <paulus@samba.org>");
-MODULE_DESCRIPTION("FBDev driver for IBM GXT4500P/6000P");
+MODULE_DESCRIPTION("FBDev driver for IBM GXT4500P/6500P and GXT4000P/6000P");
 MODULE_LICENSE("GPL");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\"");
-- 
1.7.7.6
