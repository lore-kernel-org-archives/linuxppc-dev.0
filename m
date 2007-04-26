Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id C5943DDF60
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 04:27:10 +1000 (EST)
Message-ID: <4630F018.3010200@ru.mvista.com>
Date: Thu, 26 Apr 2007 22:31:52 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: arnd@arndb.de, Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Xilinx framebuffer device driver - 2nd version
Content-Type: multipart/mixed; boundary="------------010203010909090705090603"
Cc: rick.moleres@xilinx.com, linuxppc-embedded@ozlabs.org
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
--------------010203010909090705090603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add support for the video controller IP block included into Xilinx ML300 and
ML403 reference designs.

Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>
---

This patch relies on the "Patchset to establish sanity in Xilinx Virtex support" by Gran Likely to have
the frame buffer device registered on the platform bus. Without this patchset one needs to fill in
the struct platform_device and make sure platform_device_register() is called elsewhere.
The DCR access has been added but not tested - my targets are configured in the "memory mapped IO" way.
I would appreciate if those having the video controller registers accessible as DCRs
test the DCR mode.

This is the 2nd version that addresses what was pointed out by Arnd and Grant.
Please find the interdiff against the 1st version below, and the whole patch attached to this message
Comments are welcome.

Would be nice to get this driver into mainline for the 2.6.22.

Thanks,
Andrei

-----------------------------------------------------------------
Index: linux-2.6.20/drivers/video/Kconfig
===================================================================
--- linux-2.6.20.orig/drivers/video/Kconfig
+++ linux-2.6.20/drivers/video/Kconfig
@@ -1648,6 +1648,16 @@ config FB_XILINX_ROTATE
  	bool "Rotate display"
  	depends on FB_XILINX

+config FB_XILINX_SCR_HEIGHT
+	int "Screen height in mm"
+	depends on FB_XILINX
+	default 99
+
+config FB_XILINX_SCR_WIDTH
+	int "Screen width in mm"
+	depends on FB_XILINX
+	default 132
+
  config FB_VIRTUAL
  	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
  	depends on FB
Index: linux-2.6.20/drivers/video/xilinxfb.c
===================================================================
--- linux-2.6.20.orig/drivers/video/xilinxfb.c
+++ linux-2.6.20/drivers/video/xilinxfb.c
@@ -30,6 +30,7 @@
  #include <linux/platform_device.h>

  #include <asm/io.h>
+#include <syslib/virtex_devices.h>

  #define DRIVER_NAME		"xilinxfb"
  #define DRIVER_DESCRIPTION	"Xilinx TFT LCD frame buffer driver"
@@ -97,19 +98,18 @@ static struct fb_var_screeninfo xilinx_f
  	.blue =		{ 0, 8, 0 },
  	.transp =	{ 0, 0, 0 },

-	.activate =	FB_ACTIVATE_NOW,
-	.height = 	99,	/* in mm of NEC NL6448BC20-08 on ML300 */
-	.width =	132	/* in mm of NEC NL6448BC20-08 on ML300 */
+	.activate =	FB_ACTIVATE_NOW
  };

  struct xilinxfb_drvdata {

  	struct fb_info	info;		/* FB driver info record */

-	unsigned long	regs_phys;	/* phys. address of the control registers */
-	u32 		*regs;		/* virt. address of the control registers */
+	u32		regs_phys;	/* phys. address of the control registers */
+	u32 __iomem	*regs;		/* virt. address of the control registers */
+	u32		use_dcr;	/* (use_dcr) ? mtdcr() : out_be32(); */

-	unsigned char	*fb_virt;	/* virt. address of the frame buffer */
+	unsigned char __iomem	*fb_virt;	/* virt. address of the frame buffer */
  	dma_addr_t	fb_phys;	/* phys. address of the frame buffer */

  	u32		pseudo_palette[16];	/* Fake palette of 16 colors */
@@ -118,6 +118,12 @@ struct xilinxfb_drvdata {
  #define to_xilinxfb_drvdata(_info) \
  	container_of(_info, struct xilinxfb_drvdata, info)

+#define xilinx_fb_out_be32(driverdata, offset, val) \
+	if (driverdata->use_dcr) \
+		mtdcr(driverdata->regs_phys + offset, val); \
+	else \
+		out_be32(driverdata->regs + offset, val)
+
  static int
  xilinx_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
  	unsigned transp, struct fb_info *fbi)
@@ -153,14 +159,14 @@ xilinx_fb_blank(int blank_mode, struct f
  	switch (blank_mode) {
  	case VESA_NO_BLANKING:
  		/* turn on panel */
-		out_be32(drvdata->regs + REG_CTRL, REG_CTRL_DEFAULT);
+		xilinx_fb_out_be32(drvdata, REG_CTRL, REG_CTRL_DEFAULT);
  		break;

  	case VESA_VSYNC_SUSPEND:
  	case VESA_HSYNC_SUSPEND:
  	case VESA_POWERDOWN:
  		/* turn off panel */
-		out_be32(drvdata->regs + REG_CTRL, 0);
+		xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
  	default:
  		break;

@@ -193,6 +199,8 @@ static struct fb_ops xilinxfb_ops =
  static int
  xilinxfb_drv_probe(struct device *dev)
  {
+	struct platform_device *pdev;
+	struct xilinxfb_platform_data *pdata;
  	struct xilinxfb_drvdata *drvdata;
  	struct resource *regs_res;
  	int retval;
@@ -200,32 +208,41 @@ xilinxfb_drv_probe(struct device *dev)
  	if (!dev)
  		return -EINVAL;

-	drvdata = kmalloc(sizeof(struct xilinxfb_drvdata), GFP_KERNEL);
+	pdev = to_platform_device(dev);
+	pdata = (struct xilinxfb_platform_data *)pdev->dev.platform_data;
+
+	if (pdata == NULL) {
+		printk(KERN_ERR "Couldn't find platform data.\n");
+		return -EFAULT;
+	}
+
+	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
  	if (!drvdata) {
  		printk(KERN_ERR "Couldn't allocate device private record\n");
  		return -ENOMEM;
  	}
-	memset((void*)drvdata, 0, sizeof(struct xilinxfb_drvdata));
  	dev_set_drvdata(dev, (void *)drvdata);

  	/* Map the control registers in */
-	regs_res = platform_get_resource(to_platform_device(dev),
-			IORESOURCE_IO, 0);
+	regs_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
  	if (!regs_res || (regs_res->end - regs_res->start + 1 < 8)) {
  		printk(KERN_ERR "Couldn't get registers resource\n");
  		retval = -EFAULT;
  		goto failed1;
  	}

-	if (!request_mem_region(regs_res->start, 8, DRIVER_NAME)) {
-		printk(KERN_ERR "Couldn't lock memory region at 0x%08lX\n",
-			regs_res->start);
-		retval = -EBUSY;
-		goto failed1;
+	drvdata->use_dcr = pdata->use_dcr;
+	if (!drvdata->use_dcr) {
+		if (!request_mem_region(regs_res->start, 8, DRIVER_NAME)) {
+			printk(KERN_ERR
+			       "Couldn't lock memory region at 0x%08X\n",
+			       regs_res->start);
+			retval = -EBUSY;
+			goto failed1;
+		}
+		drvdata->regs = (u32 __iomem*) ioremap(regs_res->start, 8);
  	}
-
  	drvdata->regs_phys = regs_res->start;
-	drvdata->regs = (u32 *) ioremap(regs_res->start, 8);

  	/* Allocate the framebuffer memory */
  	drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(FB_SIZE),
@@ -240,10 +257,10 @@ xilinxfb_drv_probe(struct device *dev)
  	memset((void *) drvdata->fb_virt, 0, FB_SIZE);

  	/* Tell the hardware where the frame buffer is */
-	out_be32(drvdata->regs + REG_FB_ADDR, drvdata->fb_phys);
+	xilinx_fb_out_be32(drvdata, REG_FB_ADDR, drvdata->fb_phys);

  	/* Turn on the display */
-	out_be32(drvdata->regs + REG_CTRL, REG_CTRL_DEFAULT);
+	xilinx_fb_out_be32(drvdata, REG_CTRL, REG_CTRL_DEFAULT);

  	/* Fill struct fb_info */
  	drvdata->info.screen_base = drvdata->fb_virt;
@@ -260,6 +277,8 @@ xilinxfb_drv_probe(struct device *dev)
  	}

  	drvdata->info.flags = FBINFO_DEFAULT;
+	xilinx_fb_var.height = pdata->screen_height_mm;
+	xilinx_fb_var.width = pdata->screen_width_mm;
  	drvdata->info.var = xilinx_fb_var;

  	/* Register new frame buffer */
@@ -279,8 +298,8 @@ failed3:
  		drvdata->fb_phys);

  	/* Turn off the display */
-	out_be32(drvdata->regs + REG_CTRL, 0);
-	iounmap(drvdata->regs);
+	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
+	if (!drvdata->use_dcr) iounmap(drvdata->regs);

  failed2:
  	release_mem_region(regs_res->start, 8);
@@ -314,8 +333,8 @@ xilinxfb_drv_remove(struct device *dev)
  		drvdata->fb_phys);

  	/* Turn off the display */
-	out_be32(drvdata->regs + REG_CTRL, 0);
-	iounmap(drvdata->regs);
+	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
+	if (!drvdata->use_dcr) iounmap(drvdata->regs);

  	release_mem_region(drvdata->regs_phys, 8);

Index: linux-2.6.20/arch/ppc/syslib/virtex_devices.c
===================================================================
--- linux-2.6.20.orig/arch/ppc/syslib/virtex_devices.c
+++ linux-2.6.20/arch/ppc/syslib/virtex_devices.c
@@ -90,6 +90,18 @@ struct plat_serial8250_port virtex_seria
  };


+/* ML300/403 reference design framebuffer driver platform data table */
+static struct xilinxfb_platform_data xilinxfb_pdata = {
+#if defined(XPAR_TFT_0_USE_DCR) && (XPAR_TFT_0_USE_DCR != 0)
+	.use_dcr = 1,
+#else
+	.use_dcr = 0,
+#endif
+	.screen_height_mm = CONFIG_FB_XILINX_SCR_HEIGHT,
+	.screen_width_mm = CONFIG_FB_XILINX_SCR_WIDTH,
+};
+
+
  struct platform_device virtex_platform_devices[] = {
  	/* UARTLITE instances */
  #if defined(XPAR_UARTLITE_0_BASEADDR)
@@ -127,6 +139,7 @@ struct platform_device virtex_platform_d
  	{
  		.name		= "xilinxfb",
  		.id		= 0,
+		.dev.platform_data = &xilinxfb_pdata,
  		.num_resources	= 1,
  		.resource = (struct resource[]) {
  			{
Index: linux-2.6.20/arch/ppc/syslib/virtex_devices.h
===================================================================
--- linux-2.6.20.orig/arch/ppc/syslib/virtex_devices.h
+++ linux-2.6.20/arch/ppc/syslib/virtex_devices.h
@@ -13,6 +13,13 @@

  #include <linux/platform_device.h>

+/* ML300/403 reference design framebuffer driver platform data struct */
+struct xilinxfb_platform_data {
+	u32 use_dcr;
+	u32 screen_height_mm;
+	u32 screen_width_mm;
+};
+
  void __init virtex_early_serial_map(void);

  /* Prototype for device fixup routine.  Implement this routine in the

--------------010203010909090705090603
Content-Type: text/x-patch;
 name="ppc32-xilinx_fb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc32-xilinx_fb.patch"

Add support for the video controller IP block included into Xilinx ML300 and
ML403 reference designs.

 arch/ppc/syslib/virtex_devices.c |   13 +
 arch/ppc/syslib/virtex_devices.h |    7 
 drivers/video/Kconfig            |   25 ++
 drivers/video/Makefile           |    1 
 drivers/video/xilinxfb.c         |  377 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 423 insertions(+)

Index: linux-2.6.20/drivers/video/Kconfig
===================================================================
--- linux-2.6.20.orig/drivers/video/Kconfig
+++ linux-2.6.20/drivers/video/Kconfig
@@ -1633,6 +1633,31 @@ config FB_PS3_DEFAULT_SIZE_M
 	  The default value can be overridden on the kernel command line
 	  using the "ps3fb" option (e.g. "ps3fb=9M");
 
+config FB_XILINX
+	tristate "Xilinx frame buffer support"
+	depends on FB && XILINX_VIRTEX
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	---help---
+	  Include support for the Xilinx ML300/ML403 reference design
+	  framebuffer. ML300 carries a 640*480 LCD display on the board,
+	  ML403 uses a standard DB15 VGA connector.
+
+config FB_XILINX_ROTATE
+	bool "Rotate display"
+	depends on FB_XILINX
+
+config FB_XILINX_SCR_HEIGHT
+	int "Screen height in mm"
+	depends on FB_XILINX
+	default 99
+
+config FB_XILINX_SCR_WIDTH
+	int "Screen width in mm"
+	depends on FB_XILINX
+	default 132
+
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
Index: linux-2.6.20/drivers/video/Makefile
===================================================================
--- linux-2.6.20.orig/drivers/video/Makefile
+++ linux-2.6.20/drivers/video/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_FB_PNX4008_DUM_RGB)  += pnx
 obj-$(CONFIG_FB_IBM_GXT4500)	  += gxt4500.o
 obj-$(CONFIG_FB_PS3)		  += ps3fb.o
 obj-$(CONFIG_FB_SM501)            += sm501fb.o
+obj-$(CONFIG_FB_XILINX)           += xilinxfb.o
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_VESA)             += vesafb.o
Index: linux-2.6.20/drivers/video/xilinxfb.c
===================================================================
--- /dev/null
+++ linux-2.6.20/drivers/video/xilinxfb.c
@@ -0,0 +1,377 @@
+/*
+ * xilinxfb.c
+ *
+ * Xilinx TFT LCD frame buffer driver
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2007 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+/*
+ * This driver was based on au1100fb.c by MontaVista rewritten for 2.6
+ * by Embedded Alley Solutions <source@embeddedalley.com>, which in turn
+ * was based on skeletonfb.c, Skeleton for a frame buffer device by
+ * Geert Uytterhoeven.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/version.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+
+#include <asm/io.h>
+#include <syslib/virtex_devices.h>
+
+#define DRIVER_NAME		"xilinxfb"
+#define DRIVER_DESCRIPTION	"Xilinx TFT LCD frame buffer driver"
+
+/*
+ * The interface to the framebuffer is nice and simple.  There are two
+ * control registers.  The first tells the LCD interface where in memory
+ * the frame buffer is (only the 11 most significant bits are used, so
+ * don't start thinking about scrolling).  The second allows the LCD to
+ * be turned on or off as well as rotated 180 degrees.
+ */
+#define NUM_REGS	2
+#define REG_FB_ADDR	0
+#define REG_CTRL	1
+#define REG_CTRL_ENABLE	 0x0001
+#define REG_CTRL_ROTATE	 0x0002
+#if defined(CONFIG_FB_XILINX_ROTATE)
+#define REG_CTRL_DEFAULT (REG_CTRL_ENABLE | REG_CTRL_ROTATE)
+#else
+#define REG_CTRL_DEFAULT (REG_CTRL_ENABLE)
+#endif				/* CONFIG_FB_XILINX_ROTATE */
+
+/*
+ * The hardware only handles a single mode: 640x480 24 bit true
+ * color. Each pixel gets a word (32 bits) of memory.  Within each word,
+ * the 8 most significant bits are ignored, the next 8 bits are the red
+ * level, the next 8 bits are the green level and the 8 least
+ * significant bits are the blue level.  Each row of the LCD uses 1024
+ * words, but only the first 640 pixels are displayed with the other 384
+ * words being ignored.  There are 480 rows.
+ */
+#define BYTES_PER_PIXEL	4
+#define BITS_PER_PIXEL	(BYTES_PER_PIXEL * 8)
+#define XRES		640
+#define YRES		480
+#define XRES_VIRTUAL	1024
+#define YRES_VIRTUAL	YRES
+#define LINE_LENGTH	(XRES_VIRTUAL * BYTES_PER_PIXEL)
+#define FB_SIZE		(YRES_VIRTUAL * LINE_LENGTH)
+
+#define PALETTE_ENTRIES_NO	16	/* passed to fb_alloc_cmap() */
+
+/*
+ * Here are the default fb_fix_screeninfo and fb_var_screeninfo structures
+ */
+static struct fb_fix_screeninfo xilinx_fb_fix __initdata = {
+	.id =		"Xilinx",
+	.type =		FB_TYPE_PACKED_PIXELS,
+	.visual =	FB_VISUAL_TRUECOLOR,
+	.smem_len =	FB_SIZE,
+	.line_length =	LINE_LENGTH,
+	.accel =	FB_ACCEL_NONE
+};
+
+static struct fb_var_screeninfo xilinx_fb_var __initdata = {
+	.xres =			XRES,
+	.yres =			YRES,
+	.xres_virtual =		XRES_VIRTUAL,
+	.yres_virtual =		YRES_VIRTUAL,
+
+	.bits_per_pixel =	BITS_PER_PIXEL,
+
+	.red =		{ 16, 8, 0 },
+	.green =	{ 8, 8, 0 },
+	.blue =		{ 0, 8, 0 },
+	.transp =	{ 0, 0, 0 },
+
+	.activate =	FB_ACTIVATE_NOW
+};
+
+struct xilinxfb_drvdata {
+
+	struct fb_info	info;		/* FB driver info record */
+
+	u32		regs_phys;	/* phys. address of the control registers */
+	u32 __iomem	*regs;		/* virt. address of the control registers */
+	u32		use_dcr;	/* (use_dcr) ? mtdcr() : out_be32(); */
+
+	unsigned char __iomem	*fb_virt;	/* virt. address of the frame buffer */
+	dma_addr_t	fb_phys;	/* phys. address of the frame buffer */
+
+	u32		pseudo_palette[16];	/* Fake palette of 16 colors */
+};
+
+#define to_xilinxfb_drvdata(_info) \
+	container_of(_info, struct xilinxfb_drvdata, info)
+
+#define xilinx_fb_out_be32(driverdata, offset, val) \
+	if (driverdata->use_dcr) \
+		mtdcr(driverdata->regs_phys + offset, val); \
+	else \
+		out_be32(driverdata->regs + offset, val)
+
+static int
+xilinx_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
+	unsigned transp, struct fb_info *fbi)
+{
+	u32 *palette = fbi->pseudo_palette;
+
+	if (regno >= PALETTE_ENTRIES_NO)
+		return -EINVAL;
+
+	if (fbi->var.grayscale) {
+		/* Convert color to grayscale.
+		 * grayscale = 0.30*R + 0.59*G + 0.11*B */
+		red = green = blue =
+			(red * 77 + green * 151 + blue * 28 + 127) >> 8;
+	}
+
+	/* fbi->fix.visual is always FB_VISUAL_TRUECOLOR */
+
+	/* We only handle 8 bits of each color. */
+	red >>= 8;
+	green >>= 8;
+	blue >>= 8;
+	palette[regno] = (red << 16) | (green << 8) | blue;
+
+	return 0;
+}
+
+static int
+xilinx_fb_blank(int blank_mode, struct fb_info *fbi)
+{
+	struct xilinxfb_drvdata *drvdata = to_xilinxfb_drvdata(fbi);
+
+	switch (blank_mode) {
+	case VESA_NO_BLANKING:
+		/* turn on panel */
+		xilinx_fb_out_be32(drvdata, REG_CTRL, REG_CTRL_DEFAULT);
+		break;
+
+	case VESA_VSYNC_SUSPEND:
+	case VESA_HSYNC_SUSPEND:
+	case VESA_POWERDOWN:
+		/* turn off panel */
+		xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
+	default:
+		break;
+
+	}
+	return 0; /* success */
+}
+
+static int
+xilinx_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
+{
+	if (var->xoffset != 0 || var->yoffset != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct fb_ops xilinxfb_ops =
+{
+	.owner			= THIS_MODULE,
+	.fb_setcolreg		= xilinx_fb_setcolreg,
+	.fb_blank		= xilinx_fb_blank,
+	.fb_pan_display		= xilinx_fb_pan_display,
+	.fb_fillrect		= cfb_fillrect,
+	.fb_copyarea		= cfb_copyarea,
+	.fb_imageblit		= cfb_imageblit,
+};
+
+/* === The device driver === */
+
+static int
+xilinxfb_drv_probe(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct xilinxfb_platform_data *pdata;
+	struct xilinxfb_drvdata *drvdata;
+	struct resource *regs_res;
+	int retval;
+
+	if (!dev)
+		return -EINVAL;
+
+	pdev = to_platform_device(dev);
+	pdata = (struct xilinxfb_platform_data *)pdev->dev.platform_data;
+
+	if (pdata == NULL) {
+		printk(KERN_ERR "Couldn't find platform data.\n");
+		return -EFAULT;
+	}
+
+	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata) {
+		printk(KERN_ERR "Couldn't allocate device private record\n");
+		return -ENOMEM;
+	}
+	dev_set_drvdata(dev, (void *)drvdata);
+
+	/* Map the control registers in */
+	regs_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!regs_res || (regs_res->end - regs_res->start + 1 < 8)) {
+		printk(KERN_ERR "Couldn't get registers resource\n");
+		retval = -EFAULT;
+		goto failed1;
+	}
+
+	drvdata->use_dcr = pdata->use_dcr;
+	if (!drvdata->use_dcr) {
+		if (!request_mem_region(regs_res->start, 8, DRIVER_NAME)) {
+			printk(KERN_ERR
+			       "Couldn't lock memory region at 0x%08X\n",
+			       regs_res->start);
+			retval = -EBUSY;
+			goto failed1;
+		}
+		drvdata->regs = (u32 __iomem*) ioremap(regs_res->start, 8);
+	}
+	drvdata->regs_phys = regs_res->start;
+
+	/* Allocate the framebuffer memory */
+	drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(FB_SIZE),
+				&drvdata->fb_phys, GFP_KERNEL);
+	if (!drvdata->fb_virt) {
+		printk(KERN_ERR "Could not allocate frame buffer memory\n");
+		retval = -ENOMEM;
+		goto failed2;
+	}
+
+	/* Clear (turn to black) the framebuffer */
+	memset((void *) drvdata->fb_virt, 0, FB_SIZE);
+
+	/* Tell the hardware where the frame buffer is */
+	xilinx_fb_out_be32(drvdata, REG_FB_ADDR, drvdata->fb_phys);
+
+	/* Turn on the display */
+	xilinx_fb_out_be32(drvdata, REG_CTRL, REG_CTRL_DEFAULT);
+
+	/* Fill struct fb_info */
+	drvdata->info.screen_base = drvdata->fb_virt;
+	drvdata->info.fbops = &xilinxfb_ops;
+	drvdata->info.fix = xilinx_fb_fix;
+	drvdata->info.fix.smem_start = drvdata->fb_phys;
+	drvdata->info.pseudo_palette = drvdata->pseudo_palette;
+
+	if (fb_alloc_cmap(&drvdata->info.cmap, PALETTE_ENTRIES_NO, 0) < 0) {
+		printk(KERN_ERR "Fail to allocate colormap (%d entries)\n",
+			PALETTE_ENTRIES_NO);
+		retval = -EFAULT;
+		goto failed3;
+	}
+
+	drvdata->info.flags = FBINFO_DEFAULT;
+	xilinx_fb_var.height = pdata->screen_height_mm;
+	xilinx_fb_var.width = pdata->screen_width_mm;
+	drvdata->info.var = xilinx_fb_var;
+
+	/* Register new frame buffer */
+	if (register_framebuffer(&drvdata->info) < 0) {
+		printk(KERN_ERR "Could not register frame buffer\n");
+		retval = -EINVAL;
+		goto failed4;
+	}
+
+	return 0;	/* success */
+
+failed4:
+	fb_dealloc_cmap(&drvdata->info.cmap);
+
+failed3:
+	dma_free_coherent(dev, PAGE_ALIGN(FB_SIZE), drvdata->fb_virt,
+		drvdata->fb_phys);
+
+	/* Turn off the display */
+	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
+	if (!drvdata->use_dcr) iounmap(drvdata->regs);
+
+failed2:
+	release_mem_region(regs_res->start, 8);
+
+failed1:
+	kfree(drvdata);
+	dev_set_drvdata(dev, NULL);
+
+	return retval;
+}
+
+static int
+xilinxfb_drv_remove(struct device *dev)
+{
+	struct xilinxfb_drvdata *drvdata;
+
+	if (!dev)
+		return -ENODEV;
+
+	drvdata = (struct xilinxfb_drvdata *) dev_get_drvdata(dev);
+
+#if !defined(CONFIG_FRAMEBUFFER_CONSOLE) && defined(CONFIG_LOGO)
+	xilinx_fb_blank(VESA_POWERDOWN, &drvdata->info);
+#endif
+
+	unregister_framebuffer(&drvdata->info);
+
+	fb_dealloc_cmap(&drvdata->info.cmap);
+
+	dma_free_coherent(dev, PAGE_ALIGN(FB_SIZE), drvdata->fb_virt,
+		drvdata->fb_phys);
+
+	/* Turn off the display */
+	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
+	if (!drvdata->use_dcr) iounmap(drvdata->regs);
+
+	release_mem_region(drvdata->regs_phys, 8);
+
+	kfree(drvdata);
+	dev_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+
+static struct device_driver xilinxfb_driver = {
+	.name		= DRIVER_NAME,
+	.bus		= &platform_bus_type,
+
+	.probe		= xilinxfb_drv_probe,
+	.remove		= xilinxfb_drv_remove
+};
+
+static int __init
+xilinxfb_init(void)
+{
+	/*
+	 * No kernel boot options used,
+	 * so we just need to register the driver
+	 */
+	return driver_register(&xilinxfb_driver);
+}
+
+static void __exit
+xilinxfb_cleanup(void)
+{
+	driver_unregister(&xilinxfb_driver);
+}
+
+module_init(xilinxfb_init);
+module_exit(xilinxfb_cleanup);
+
+MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_LICENSE("GPL");
Index: linux-2.6.20/arch/ppc/syslib/virtex_devices.c
===================================================================
--- linux-2.6.20.orig/arch/ppc/syslib/virtex_devices.c
+++ linux-2.6.20/arch/ppc/syslib/virtex_devices.c
@@ -90,6 +90,18 @@ struct plat_serial8250_port virtex_seria
 };
 
 
+/* ML300/403 reference design framebuffer driver platform data table */
+static struct xilinxfb_platform_data xilinxfb_pdata = {
+#if defined(XPAR_TFT_0_USE_DCR) && (XPAR_TFT_0_USE_DCR != 0)
+	.use_dcr = 1,
+#else
+	.use_dcr = 0,
+#endif
+	.screen_height_mm = CONFIG_FB_XILINX_SCR_HEIGHT,
+	.screen_width_mm = CONFIG_FB_XILINX_SCR_WIDTH,
+};
+
+
 struct platform_device virtex_platform_devices[] = {
 	/* UARTLITE instances */
 #if defined(XPAR_UARTLITE_0_BASEADDR)
@@ -127,6 +139,7 @@ struct platform_device virtex_platform_d
 	{
 		.name		= "xilinxfb",
 		.id		= 0,
+		.dev.platform_data = &xilinxfb_pdata,
 		.num_resources	= 1,
 		.resource = (struct resource[]) {
 			{
Index: linux-2.6.20/arch/ppc/syslib/virtex_devices.h
===================================================================
--- linux-2.6.20.orig/arch/ppc/syslib/virtex_devices.h
+++ linux-2.6.20/arch/ppc/syslib/virtex_devices.h
@@ -13,6 +13,13 @@
 
 #include <linux/platform_device.h>
 
+/* ML300/403 reference design framebuffer driver platform data struct */
+struct xilinxfb_platform_data {
+	u32 use_dcr;
+	u32 screen_height_mm;
+	u32 screen_width_mm;
+};
+
 void __init virtex_early_serial_map(void);
 
 /* Prototype for device fixup routine.  Implement this routine in the

--------------010203010909090705090603--
