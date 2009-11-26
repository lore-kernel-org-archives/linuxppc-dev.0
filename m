Return-Path: <Kari.Davidsson@marel.com>
Received: from mail.marel.is (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id B00FE1007D5
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 02:13:21 +1100 (EST)
Message-ID: <4B0E9AA1.8030906@marel.com>
Date: Thu, 26 Nov 2009 15:11:29 +0000
From: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: fsl diu, edid info and i2c platform data
References: <4B0E9203.7040208@marel.com>
In-Reply-To: <4B0E9203.7040208@marel.com>
Content-Type: multipart/mixed; boundary="------------070501090403000001050406"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--------------070501090403000001050406
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 8bit

Forgot the patch.


K�ri Dav��sson wrote:
> Hi,
> 
> I am messing about with the fsl-diu-fb.c which handles the display on mpc512x platforms.
> The display panels we are using provide EDID information and I would like to use that to setup
> the display modes etc. The current fsl-diu-fb.c is hard coding display modes into the driver.
> 
> I have started this and it is working more or less but I appreciate all input from more knowledgeable people
> about how to do this "correctly" with the aim that others could benefit.
> I have the feeling I am not approaching this correctly.
> 
> One option I was looking into was to use platform data for the i2c edid driver, e.g. for the platform to provide
> default fb_mode. But I have a big problem on how to attach the platform data to the i2cedid driver.
> I tried few options and while I think using code like :
> 
>      np = of_find_compatible_node( NULL, NULL, "vesa,edid" );
>      if( np )
>      {
>          struct i2c_client * tsc2007 = NULL;
> 
>          //        tsc2007 = of_find_i2c_device_by_node( np );
>          if( tsc2007 )
>          {
>              tsc2007->dev.platform_data = &v39_edid_data;
>              put_device( &tsc2007->dev );
>          }
>          of_node_put( np );
>      }
> 
> is the correct way to do it. The function of_find_i2c_device_by_node() hangs the kernel.
> 
> Attached is the patch as I have it now. It compiles and works on our custom mpc5121 board for two different LCD panels.
> 
> rg
> kd
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

--------------070501090403000001050406
Content-Type: text/x-diff; name="edid.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="edid.patch"

diff --git a/arch/powerpc/boot/dts/v39.dts b/arch/powerpc/boot/dts/v39.dts
new file mode 100644
index 0000000..c5a5eec
--- /dev/null
+++ b/arch/powerpc/boot/dts/v39.dts
@@ -0,0 +1,285 @@
+/*
+ * V39 Device Tree Source
+ *
+ * Copyright 2009 Marel ehf.
+ * Copyright 2007,2008 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "v39";
+	compatible = "marel,v39";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,5121@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <0x20>;	// 32 bytes
+			i-cache-line-size = <0x20>;	// 32 bytes
+			d-cache-size = <0x8000>;	// L1, 32K
+			i-cache-size = <0x8000>;	// L1, 32K
+			timebase-frequency = <49500000>;// 49.5 MHz (csb/4)
+			bus-frequency = <198000000>;	// 198 MHz csb bus
+			clock-frequency = <396000000>;	// 396 MHz ppc core
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;	// 256MB at 0
+	};
+
+	mbx@20000000 {
+		compatible = "fsl,mpc5121-mbx";
+		reg = <0x20000000 0x4000>;
+		interrupts = <66 0x8>;
+		interrupt-parent = < &ipic >;
+	};
+
+	sram@30000000 {
+		compatible = "fsl,mpc5121-sram";
+		reg = <0x30000000 0x20000>;		// 128K at 0x30000000
+	};
+
+	soc@80000000 {
+		compatible = "fsl,mpc5121-immr";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		ranges = <0x0 0x80000000 0x400000>;
+		reg = <0x80000000 0x400000>;
+		bus-frequency = <66000000>;	// 66 MHz ips bus
+
+
+		// IPIC
+		// interrupts cell = <intr #, sense>
+		// sense values match linux IORESOURCE_IRQ_* defines:
+		// sense == 8: Level, low assertion
+		// sense == 2: Edge, high-to-low change
+		//
+		ipic: interrupt-controller@c00 {
+			compatible = "fsl,mpc5121-ipic", "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0xc00 0x100>;
+		};
+
+		rtc@a00 {	// Real time clock
+			compatible = "fsl,mpc5121-rtc";
+			reg = <0xa00 0x100>;
+			interrupts = <79 0x8 80 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		clock@f00 {	// Clock control
+			compatible = "fsl,mpc5121-clock";
+			reg = <0xf00 0x100>;
+		};
+
+/*
+		gpio@1100 {
+			compatible = "fsl,mpc5121-gpio";
+			reg = <0x1100 0x100>;
+			interrupts = <78 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+*/
+
+		mscan@1300 {
+			compatible = "fsl,mpc5121-mscan";
+			cell-index = <0>;
+			interrupts = <12 0x8>;
+			interrupt-parent = < &ipic >;
+			reg = <0x1300 0x80>;
+			clock-ipb;
+		};
+
+		mscan@1380 {
+			compatible = "fsl,mpc5121-mscan";
+			cell-index = <1>;
+			interrupts = <13 0x8>;
+			interrupt-parent = < &ipic >;
+			reg = <0x1380 0x80>;
+			clock-ipb;
+		};
+
+		edidbus: i2c@1700 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			cell-index = <0>;
+			reg = <0x1700 0x20>;
+			interrupts = <9 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl5200-clocking;
+			edid: edid@50 {
+				compatible = "vesa,edid";
+				reg = <0x50>;
+			};
+		};
+
+		i2c@1720 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			cell-index = <1>;
+			reg = <0x1720 0x20>;
+			interrupts = <10 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl5200-clocking;
+		};
+
+		i2c@1740 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			cell-index = <2>;
+			reg = <0x1740 0x20>;
+			interrupts = <11 0x8>;
+			interrupt-parent = < &ipic >;
+			fsl5200-clocking;
+			ts@49 {
+				compatible = "bb,tsc2007";
+				reg = <0x49>;
+				interrupts = <17 0x8>; // IRQ1 (17)
+				interrupt-parent = < &ipic >;
+		                device_type="tsc";
+			};
+
+		};
+
+		i2ccontrol@1760 {
+			compatible = "fsl,mpc5121-i2c-ctrl";
+			reg = <0x1760 0x8>;
+		};
+
+		axe@2000 {
+			compatible = "fsl,mpc5121-axe";
+			reg = <0x2000 0x100>;
+			interrupts = <42 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		display@2100 {
+			device_type = "display";
+			compatible = "fsl,diu";
+			reg = <0x2100 0x100>;
+			interrupts = <64 0x8>;
+			interrupt-parent = < &ipic >;
+			edid = < &edidbus >;
+		};
+
+		mdio@2800 {
+			compatible = "fsl,mpc5121-fec-mdio";
+			reg = <0x2800 0x800>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy: ethernet-phy@0 {
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@2800 {
+			device_type = "network";
+			compatible = "fsl,mpc5121-fec";
+			reg = <0x2800 0x800>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <4 0x8>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy >;
+			fsl,align-tx-packets = <4>;
+		};
+
+		// 5121e has two dr usb modules
+		// USB1 using external ULPI PHY
+		usb@3000 {
+			compatible = "fsl,mpc5121-usb2-dr", "fsl-usb2-dr";
+			reg = <0x3000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = < &ipic >;
+			interrupts = <43 0x8>;
+			dr_mode = "otg";
+			phy_type = "ulpi";
+			port1;
+		};
+
+		// USB0 using internal UTMI PHY
+		usb@4000 {
+			compatible = "fsl,mpc5121-usb2-dr", "fsl-usb2-dr";
+			reg = <0x4000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = < &ipic >;
+			interrupts = <44 0x8>;
+			dr_mode = "otg";
+			phy_type = "utmi_wide";
+			port0;
+		};
+
+		// IO control
+		ioctl@a000 {
+			compatible = "fsl,mpc5121-ioctl";
+			reg = <0xA000 0x1000>;
+		};
+
+		// 512x PSCs are not 52xx PSC compatible
+		// PSC3 serial port A aka ttyPSC0
+		serial@11300 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			// Logical port assignment needed until driver
+			// learns to use aliases
+			port-number = <0>;
+			cell-index = <3>;
+			reg = <0x11300 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = < &ipic >;
+			rx-fifo-size = <16>;
+			tx-fifo-size = <16>;
+		};
+
+		// PSC4 serial port B aka ttyPSC1
+		serial@11400 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			// Logical port assignment needed until driver
+			// learns to use aliases
+			port-number = <1>;
+			cell-index = <4>;
+			reg = <0x11400 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = < &ipic >;
+			rx-fifo-size = <16>;
+			tx-fifo-size = <16>;
+		};
+
+		pscfifo@11f00 {
+			compatible = "fsl,mpc5121-psc-fifo";
+			reg = <0x11f00 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		dma@14000 {
+			compatible = "fsl,mpc5121-dma2", "fsl,mpc512x-dma2", "mpc512x-dma2";
+			reg = <0x14000 0x1800>;
+			interrupts = <65 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
+	};
+};
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 188e1ba..672d962 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -218,6 +218,15 @@ config FB_MODE_HELPERS
 	  your driver does not take advantage of this feature, choosing Y will
 	  just increase the kernel size by about 5K.
 
+config I2CEDID
+	bool "Encapsulate EDID functions with i2c driver"
+	depends on I2C
+	default n
+	---help---
+	  This helps with automatic probing of the EDID information from 
+	  of tree. Can probably help others where instantiation of the EDID
+	  instantiation could be factored out of the console driver.
+
 config FB_TILEBLITTING
        bool "Enable Tile Blitting Support"
        depends on FB
@@ -1827,6 +1836,8 @@ config FB_FSL_DIU
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select PPC_LIB_RHEAP
+	select I2CEDID
+	select FB_DDC
 	---help---
 	  Framebuffer driver for the Freescale SoC DIU
 
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 80232e1..c3c5a3d 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -4,6 +4,7 @@
 
 # Each configuration option enables a list of files.
 
+obj-$(CONFIG_I2CEDID) += i2cedid.o
 obj-$(CONFIG_VGASTATE)            += vgastate.o
 obj-y                             += fb_notify.o
 obj-$(CONFIG_FB)                  += fb.o
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 72d68b3..f6fcbae 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -35,6 +35,7 @@
 
 #include <sysdev/fsl_soc.h>
 #include "fsl-diu-fb.h"
+#include "i2cedid.h"
 
 /*
  * These parameters give default parameters
@@ -44,8 +45,8 @@
  */
 static struct fb_videomode __devinitdata fsl_diu_default_mode = {
 	.refresh	= 60,
-	.xres		= 1024,
-	.yres		= 768,
+	.xres		= 640,
+	.yres		= 480,
 	.pixclock	= 15385,
 	.left_margin	= 160,
 	.right_margin	= 24,
@@ -57,132 +58,9 @@ static struct fb_videomode __devinitdata fsl_diu_default_mode = {
 	.vmode		= FB_VMODE_NONINTERLACED
 };
 
-static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
-	{
-		.name		= "1024x768-60",
-		.refresh	= 60,
-		.xres		= 1024,
-		.yres		= 768,
-		.pixclock	= 15385,
-		.left_margin	= 160,
-		.right_margin	= 24,
-		.upper_margin	= 29,
-		.lower_margin	= 3,
-		.hsync_len	= 136,
-		.vsync_len	= 6,
-		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED
-	},
-	{
-		.name		= "1024x768-70",
-		.refresh	= 70,
-		.xres		= 1024,
-		.yres		= 768,
-		.pixclock	= 16886,
-		.left_margin	= 3,
-		.right_margin	= 3,
-		.upper_margin	= 2,
-		.lower_margin	= 2,
-		.hsync_len	= 40,
-		.vsync_len	= 18,
-		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED
-	},
-	{
-		.name		= "1024x768-75",
-		.refresh	= 75,
-		.xres		= 1024,
-		.yres		= 768,
-		.pixclock	= 15009,
-		.left_margin	= 3,
-		.right_margin	= 3,
-		.upper_margin	= 2,
-		.lower_margin	= 2,
-		.hsync_len	= 80,
-		.vsync_len	= 32,
-		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED
-	},
-	{
-		.name		= "1280x1024-60",
-		.refresh	= 60,
-		.xres		= 1280,
-		.yres		= 1024,
-		.pixclock	= 9375,
-		.left_margin	= 38,
-		.right_margin	= 128,
-		.upper_margin	= 2,
-		.lower_margin	= 7,
-		.hsync_len	= 216,
-		.vsync_len	= 37,
-		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED
-	},
-	{
-		.name		= "1280x1024-70",
-		.refresh	= 70,
-		.xres		= 1280,
-		.yres		= 1024,
-		.pixclock	= 9380,
-		.left_margin	= 6,
-		.right_margin	= 6,
-		.upper_margin	= 4,
-		.lower_margin	= 4,
-		.hsync_len	= 60,
-		.vsync_len	= 94,
-		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED
-	},
-	{
-		.name		= "1280x1024-75",
-		.refresh	= 75,
-		.xres		= 1280,
-		.yres		= 1024,
-		.pixclock	= 9380,
-		.left_margin	= 6,
-		.right_margin	= 6,
-		.upper_margin	= 4,
-		.lower_margin	= 4,
-		.hsync_len	= 60,
-		.vsync_len	= 15,
-		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED
-	},
-	{
-		.name		= "320x240",		/* for AOI only */
-		.refresh	= 60,
-		.xres		= 320,
-		.yres		= 240,
-		.pixclock	= 15385,
-		.left_margin	= 0,
-		.right_margin	= 0,
-		.upper_margin	= 0,
-		.lower_margin	= 0,
-		.hsync_len	= 0,
-		.vsync_len	= 0,
-		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED
-	},
-	{
-		.name		= "1280x480-60",
-		.refresh	= 60,
-		.xres		= 1280,
-		.yres		= 480,
-		.pixclock	= 18939,
-		.left_margin	= 353,
-		.right_margin	= 47,
-		.upper_margin	= 39,
-		.lower_margin	= 4,
-		.hsync_len	= 8,
-		.vsync_len	= 2,
-		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED
-	},
-};
-
-static char *fb_mode = "1024x768-32@60";
+static char *fb_mode = "640x480-32@60";
 static unsigned long default_bpp = 32;
-static int monitor_port;
+static int monitor_port = 0;
 
 #if defined(CONFIG_NOT_COHERENT_CACHE)
 static u8 *coherence_data;
@@ -325,7 +203,7 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 	struct fsl_diu_data *machine_data = mfbi->parent;
 	int res = 0;
 
-	pr_debug("enable_panel index %d\n", mfbi->index);
+	printk(KERN_INFO "enable_panel index %d\n", mfbi->index);
 	if (mfbi->type != MFB_TYPE_OFF) {
 		switch (mfbi->index) {
 		case 0:				/* plane 0 */
@@ -704,8 +582,8 @@ static void update_lcdc(struct fb_info *info)
 	out_be32(&hw->gamma, pool.gamma.paddr);
 	out_be32(&hw->cursor, pool.cursor.paddr);
 
-	out_be32(&hw->bgnd, 0x007F7F7F); 	/* BGND */
-	out_be32(&hw->bgnd_wb, 0); 		/* BGND_WB */
+	out_be32(&hw->bgnd, 0x00000000); 	/* BGND */
+	out_be32(&hw->bgnd_wb, 0x00000000);	/* BGND_WB */
 	out_be32(&hw->disp_size, (var->yres << 16 | var->xres));
 						/* DISP SIZE */
 	pr_debug("DIU xres: %d\n", var->xres);
@@ -1172,18 +1050,12 @@ static int __devinit install_fb(struct fb_info *info)
 {
 	int rc;
 	struct mfb_info *mfbi = info->par;
-	const char *aoi_mode, *init_aoi_mode = "320x240";
 
 	if (init_fbinfo(info))
 		return -EINVAL;
 
-	if (mfbi->index == 0)	/* plane 0 */
-		aoi_mode = fb_mode;
-	else
-		aoi_mode = init_aoi_mode;
-	pr_debug("mode used = %s\n", aoi_mode);
-	rc = fb_find_mode(&info->var, info, aoi_mode, fsl_diu_mode_db,
-	     ARRAY_SIZE(fsl_diu_mode_db), &fsl_diu_default_mode, default_bpp);
+	pr_debug("mode used = %s\n", edid_fbmodetxt);
+	rc = fb_find_mode(&info->var, info, edid_fbmodetxt, edid_fbmonspec->modedb, edid_fbmonspec->modedb_len, &fsl_diu_default_mode, default_bpp);
 
 	switch (rc) {
 	case 1:
@@ -1428,6 +1300,8 @@ static int __devinit fsl_diu_probe(struct of_device *ofdev,
 	struct resource res;
 	struct fsl_diu_data *machine_data;
 
+    printk(KERN_INFO "The mode %s \n", edid_fbmodetxt );
+
 	machine_data = kzalloc(sizeof(struct fsl_diu_data), GFP_KERNEL);
 	if (!machine_data)
 		return -ENOMEM;
@@ -1700,6 +1574,7 @@ static int __init fsl_diu_init(void)
 	if (!coherence_data)
 		return -ENOMEM;
 #endif
+
 	ret = of_register_platform_driver(&fsl_diu_driver);
 	if (ret) {
 		printk(KERN_ERR
diff --git a/drivers/video/i2cedid.c b/drivers/video/i2cedid.c
new file mode 100644
index 0000000..ae5cd1f
--- /dev/null
+++ b/drivers/video/i2cedid.c
@@ -0,0 +1,102 @@
+/* Copyright 2009 Marel ehf. All Rights Reserverd.
+ *
+ * Author Kári Davíðsson <karidav@marel.is>
+ *
+ * Of platform driver for edid reading.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/list.h>
+#include <linux/fb.h>
+#include "i2cedid.h"
+#include "edid.h"
+
+static char fb_modexx[100];
+static struct fb_monspecs i2cedid_monspec;
+static struct fb_var_screeninfo i2cedid_screeninfo;
+
+struct fb_monspecs * edid_fbmonspec;
+EXPORT_SYMBOL( edid_fbmodespec );
+
+char * edid_fbmodetxt = &fb_modexx[0];
+EXPORT_SYMBOL( edid_fbmodetxt );
+
+static int __devinit i2cedid_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+    char tblock[EDID_LENGTH];
+    s32 read = 0;
+
+    while( read < EDID_LENGTH)
+    {
+        s32 res;
+        res = i2c_smbus_read_i2c_block_data( client, read, EDID_LENGTH, &tblock[read]);
+        if( res > 0 )
+        {
+            read += res;
+        }
+    }
+
+    fb_edid_to_monspecs( &tblock[0], &i2cedid_monspec); 
+
+    if( fb_parse_edid( &tblock[0], &i2cedid_screeninfo ) != 0 )
+    {
+        printk(KERN_WARNING "Unable to parse edid information\n");
+        return -ENODEV;
+    }
+
+    edid_fbmonspec = &i2cedid_monspec;
+
+    snprintf( &fb_modexx[0], sizeof(fb_modexx), "%dx%d-%d@%d", i2cedid_monspec.modedb[0].xres, i2cedid_monspec.modedb[0].yres, 32, i2cedid_monspec.modedb[0].refresh);
+    printk( KERN_INFO "fb_mode set to %s %d\n", fb_modexx, i2cedid_monspec.modedb[0].pixclock);
+
+
+
+    return 0;
+}
+
+static int __devexit i2cedid_remove(struct i2c_client *client)
+{
+    edid_fbmonspec = NULL;
+    fb_destroy_modedb( i2cedid_monspec.modedb );
+    memset( &i2cedid_monspec, 0, sizeof(i2cedid_monspec) );
+
+    return 0;
+}
+
+static struct i2c_device_id i2cedid_idtable[] = {
+    { "edid", 0 },
+    { },
+};
+
+MODULE_DEVICE_TABLE(i2c, i2cedid_idtable);
+
+static struct i2c_driver i2cedid_driver = {
+    .driver = {
+        .owner = THIS_MODULE,
+        .name = "edid",
+     },
+    .id_table   = i2cedid_idtable,
+	.probe  	= i2cedid_probe,
+	.remove 	= __devexit_p(i2cedid_remove),
+};
+
+static int __init i2cedid_init( void )
+{
+	return i2c_add_driver(&i2cedid_driver);
+}
+
+static void __exit i2cedid_exit( void )
+{
+    i2c_del_driver(&i2cedid_driver);
+}
+
+module_init( i2cedid_init );
+module_exit( i2cedid_exit );
+
+MODULE_AUTHOR( "Kári Davíðsson <karidav@marel.is>" );
+MODULE_DESCRIPTION( "I2C driver encapsulation for OF integration." );
+MODULE_LICENSE( "GPL" );
+
diff --git a/drivers/video/i2cedid.h b/drivers/video/i2cedid.h
new file mode 100644
index 0000000..4845201
--- /dev/null
+++ b/drivers/video/i2cedid.h
@@ -0,0 +1,14 @@
+/* Copyright 2009 Marel ehf. All Rights Reserverd.
+ *
+ * Author Kári Davíðsson <karidav@marel.is>
+ *
+ * Header file to Of platform driver for edid reading.
+ */
+
+#ifndef __I2CEDID_H__
+#define __I2CEDID_H__
+
+extern struct fb_monspecs * edid_fbmonspec;
+extern char * edid_fbmodetxt;
+
+#endif /* __I2CEDID_H__ */

--------------070501090403000001050406--
