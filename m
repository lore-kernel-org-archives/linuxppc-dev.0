Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 47B17B7BED
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Dec 2009 09:04:30 +1100 (EST)
To: Rolf Offermanns <roffermanns@sysgo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: TQM5200 + SM501 FB
MIME-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1259964226_319200"
Date: Fri, 04 Dec 2009 23:04:26 +0100
Message-Id: <20091204220426.ADD063F6E3@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multipart MIME message.

--==_Exmh_1259964226_319200
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <4B191B54.6030804@sysgo.com>
References: <4B191B54.6030804@sysgo.com>
Comments: In-reply-to Rolf Offermanns <roffermanns@sysgo.com>
   message dated "Fri, 04 Dec 2009 15:23:16 +0100."

Dear Rolf Offermanns,

In message <4B191B54.6030804@sysgo.com> you wrote:
> 
> does anyone has a working SM501 framebuffer on the STK5200 board? The 
> board itself works fine on the 2.6.32 kernel.

This is a pretty well supported configuration.


> I got a patch from TQ which used to work around 2.6.24 but it seems with 
> the unification of the "simple mpc5200" boards the sm501 support got lost.

Don't expect any real support from TQ on this; so far they never
spent any efforts on the arch/powerpc port of the TQM5200.

> I toyed around with the patch a bit and I got the driver to probe and 
> initialize the chip, but I don't get an output on the crt port and an 
> open() on /dev/fb0 or /dev/fb1 fails with "no device".

Did you check if you eventually have forgotten to enable Framebuffer
console in your kernel configuration? Make sure to set:

 Device Drivers  --->
   Character devices  --->
     [*] Virtual terminal
     [*]   Support for console on virtual terminal (NEW)

   ...
   Multifunction device drivers  ---> 
     <*> Support for Silicon Motion SM501

   ...
   Graphics support  --->
     <*> Support for frame buffer devices  --->
       [*]   Framebuffer foreign endianness support  --->
         Choice endianness support (Support for Big- and Little-Endian framebuffers)  --->
       ...
       <*>   Silicon Motion SM501 framebuffer support

     ...
     Console display driver support  --->
       [ ] VGA text console      (! disable VGA text console!)
       <*> Framebuffer Console support


Please find attached below a patch which fixes some issues (but we
don't consider it clean enough for inclusion into mainline yet), and a
known to be working config file. [Kudos to Anatolij for providing
this.]

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What was sliced bread the greatest thing since?


--==_Exmh_1259964226_319200
Content-Type: application/x-patch ; name="0001-sm501-support-SM501-on-TQM5200.patch"
Content-Description: 0001-sm501-support-SM501-on-TQM5200.patch
Content-Disposition: attachment; filename="0001-sm501-support-SM501-on-TQM5200.patch"

>From e503a4524ac714f0336ab0a7c02f92ae488e4940 Mon Sep 17 00:00:00 2001
From: Anatolij Gustschin <agust@denx.de>
Date: Tue, 7 Oct 2009 14:45:16 +0200
Subject: [PATCH] sm501: support SM501 on TQM5200

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/mfd/sm501.c     |   40 ++++++++++++++++++++++++++++++++++++++++
 drivers/video/sm501fb.c |   12 +++++++++++-
 2 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 0cc5eef..970fa89 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -27,6 +27,13 @@
 
 #include <asm/io.h>
 
+#if defined(CONFIG_PPC_MPC52xx)
+#undef readl
+#undef writel
+#define readl(addr)		__do_readl_be((addr))
+#define writel(val, addr)	__do_writel_be((val), (addr))
+#endif
+
 struct sm501_device {
 	struct list_head		list;
 	struct platform_device		pdev;
@@ -1378,12 +1385,14 @@ static int __devinit sm501_init_dev(struct sm501_devdata *sm)
 			sm501_register_gpio(sm);
 	}
 
+#if !defined(CONFIG_PPC_MPC52xx) /* prevent crash on tqm5200 */
 	if (pdata->gpio_i2c != NULL && pdata->gpio_i2c_nr > 0) {
 		if (!sm501_gpio_isregistered(sm))
 			dev_err(sm->dev, "no gpio available for i2c gpio.\n");
 		else
 			sm501_register_gpio_i2c(sm, pdata);
 	}
+#endif
 
 	ret = sm501_check_clocks(sm);
 	if (ret) {
@@ -1417,7 +1426,9 @@ static int __devinit sm501_plat_probe(struct platform_device *dev)
 	ret = platform_get_irq(dev, 0);
 	if (ret < 0) {
 		dev_err(&dev->dev, "failed to get irq resource\n");
+#if !defined(CONFIG_PPC_MPC52xx) /* we do not need irq on tqm5200 for fbdev */
 		goto err_res;
+#endif
 	}
 	sm->irq = ret;
 
@@ -1748,8 +1759,37 @@ static struct platform_driver sm501_plat_driver = {
 	.resume		= sm501_plat_resume,
 };
 
+#if defined(CONFIG_PPC_MPC52xx)
+/* define sm501 resources on tqm5200 */
+#define SM501_FB_BASE	0xe0000000
+#define SM501_FB_SIZE	0x00800000
+#define SM501_IO_BASE	0xe3e00000
+#define SM501_IO_SIZE	0x00200000
+#define SM501_FB_END	((SM501_FB_BASE) + (SM501_FB_SIZE) - 1)
+#define SM501_IO_END	((SM501_IO_BASE) + (SM501_IO_SIZE) - 1)
+
+static struct resource sm501_device0_resources[] = {
+	[0] = {.start = SM501_FB_BASE, .end = SM501_FB_END, .flags = IORESOURCE_MEM,},
+	[1] = {.start = SM501_IO_BASE, .end = SM501_IO_END, .flags = IORESOURCE_MEM,},
+};
+
+static struct platform_device sm501_device0 = {
+	.name = "sm501",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(sm501_device0_resources),
+	.resource = sm501_device0_resources,
+};
+
+static struct platform_device *sm501_mfd_devices[] __initdata = {
+	&sm501_device0,
+};
+#endif
+
 static int __init sm501_base_init(void)
 {
+#if defined(CONFIG_PPC_MPC52xx)
+	platform_add_devices(sm501_mfd_devices, ARRAY_SIZE(sm501_mfd_devices));
+#endif
 	platform_driver_register(&sm501_plat_driver);
 	return pci_register_driver(&sm501_pci_driver);
 }
diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index 924d794..6b65ecd 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -43,6 +43,13 @@
 
 #define NR_PALETTE	256
 
+#if defined(CONFIG_PPC_MPC52xx)
+#undef readl
+#undef writel
+#define readl(addr)		__do_readl_be((addr))
+#define writel(val, addr)	__do_writel_be((val), (addr))
+#endif
+
 enum sm501_controller {
 	HEAD_CRT	= 0,
 	HEAD_PANEL	= 1,
@@ -1487,6 +1494,9 @@ static int sm501fb_init_fb(struct fb_info *fb,
 
 	fb->fbops = &par->ops;
 	fb->flags = FBINFO_FLAG_DEFAULT |
+#if defined(CONFIG_PPC_MPC52xx)
+		FBINFO_FOREIGN_ENDIAN |
+#endif
 		FBINFO_HWACCEL_XPAN | FBINFO_HWACCEL_YPAN;
 
 	/* fixed data */
@@ -1519,7 +1529,7 @@ static int sm501fb_init_fb(struct fb_info *fb,
 			fb->var.yres_virtual = fb->var.yres;
 		} else {
 			ret = fb_find_mode(&fb->var, fb,
-					   NULL, NULL, 0, NULL, 8);
+					   "640x480@60", NULL, 0, NULL, 16);
 
 			if (ret == 0 || ret == 4) {
 				dev_err(info->dev,
-- 
1.5.6.3


--==_Exmh_1259964226_319200
Content-Type: application/x-gzip ; name="config-tqm5200-sm501.gz"
Content-Description: config-tqm5200-sm501.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config-tqm5200-sm501.gz"

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
--==_Exmh_1259964226_319200--
