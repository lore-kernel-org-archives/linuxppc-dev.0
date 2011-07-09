Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 086C7B6FD1
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Jul 2011 06:38:24 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <lethal@linux-sh.org>, <agust@denx.de>, <linuxppc-dev@ozlabs.org>,
	<linux-fbdev@vger.kernel.org>
Subject: [PATCH] [v2] drivers/video: use strings to specify the Freescale DIU
	monitor port
Date: Sat, 9 Jul 2011 15:38:14 -0500
Message-ID: <1310243894-2660-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of using ill-defined numbers (0, 1, and 2) for the monitor port, allow
the user to specify the port by name ("dvi", "lvds", or "dlvds").  This works
on the kernel command line, the module command-line, and the sysfs "monitor"
device.

Note that changing the monitor port does not currently work on the P1022DS,
because the code that talks to the PIXIS FPGA is broken.

Signed-off-by: Timur Tabi <timur@freescale.com>
Acked-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/platforms/512x/mpc512x_shared.c |   22 +++-----
 arch/powerpc/platforms/85xx/p1022_ds.c       |   47 ++++++++---------
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c   |   55 +++++++++----------
 arch/powerpc/sysdev/fsl_soc.h                |   25 ++++++---
 drivers/video/fsl-diu-fb.c                   |   74 +++++++++++++++++++-------
 5 files changed, 128 insertions(+), 95 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index e41ebbd..3dc62f9 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -66,8 +66,8 @@ struct fsl_diu_shared_fb {
 	bool		in_use;
 };
 
-unsigned int mpc512x_get_pixel_format(unsigned int bits_per_pixel,
-				      int monitor_port)
+u32 mpc512x_get_pixel_format(enum fsl_diu_monitor_port port,
+			     unsigned int bits_per_pixel)
 {
 	switch (bits_per_pixel) {
 	case 32:
@@ -80,11 +80,12 @@ unsigned int mpc512x_get_pixel_format(unsigned int bits_per_pixel,
 	return 0x00000400;
 }
 
-void mpc512x_set_gamma_table(int monitor_port, char *gamma_table_base)
+void mpc512x_set_gamma_table(enum fsl_diu_monitor_port port,
+			     char *gamma_table_base)
 {
 }
 
-void mpc512x_set_monitor_port(int monitor_port)
+void mpc512x_set_monitor_port(enum fsl_diu_monitor_port port)
 {
 }
 
@@ -182,14 +183,10 @@ void mpc512x_set_pixel_clock(unsigned int pixclock)
 	iounmap(ccm);
 }
 
-ssize_t mpc512x_show_monitor_port(int monitor_port, char *buf)
+enum fsl_diu_monitor_port
+mpc512x_valid_monitor_port(enum fsl_diu_monitor_port port)
 {
-	return sprintf(buf, "0 - 5121 LCD\n");
-}
-
-int mpc512x_set_sysfs_monitor_port(int val)
-{
-	return 0;
+	return FSL_DIU_PORT_DVI;
 }
 
 static struct fsl_diu_shared_fb __attribute__ ((__aligned__(8))) diu_shared_fb;
@@ -332,8 +329,7 @@ void __init mpc512x_setup_diu(void)
 	diu_ops.set_gamma_table		= mpc512x_set_gamma_table;
 	diu_ops.set_monitor_port	= mpc512x_set_monitor_port;
 	diu_ops.set_pixel_clock		= mpc512x_set_pixel_clock;
-	diu_ops.show_monitor_port	= mpc512x_show_monitor_port;
-	diu_ops.set_sysfs_monitor_port	= mpc512x_set_sysfs_monitor_port;
+	diu_ops.valid_monitor_port	= mpc512x_valid_monitor_port;
 	diu_ops.release_bootmem		= mpc512x_release_bootmem;
 #endif
 }
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 266b3aa..c01c727 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -93,8 +93,8 @@
  * The Area Descriptor is a 32-bit value that determine which bits in each
  * pixel are to be used for each color.
  */
-static unsigned int p1022ds_get_pixel_format(unsigned int bits_per_pixel,
-	int monitor_port)
+static u32 p1022ds_get_pixel_format(enum fsl_diu_monitor_port port,
+				    unsigned int bits_per_pixel)
 {
 	switch (bits_per_pixel) {
 	case 32:
@@ -118,7 +118,8 @@ static unsigned int p1022ds_get_pixel_format(unsigned int bits_per_pixel,
  * On some boards, the gamma table for some ports may need to be modified.
  * This is not the case on the P1022DS, so we do nothing.
 */
-static void p1022ds_set_gamma_table(int monitor_port, char *gamma_table_base)
+static void p1022ds_set_gamma_table(enum fsl_diu_monitor_port port,
+				    char *gamma_table_base)
 {
 }
 
@@ -126,7 +127,7 @@ static void p1022ds_set_gamma_table(int monitor_port, char *gamma_table_base)
  * p1022ds_set_monitor_port: switch the output to a different monitor port
  *
  */
-static void p1022ds_set_monitor_port(int monitor_port)
+static void p1022ds_set_monitor_port(enum fsl_diu_monitor_port port)
 {
 	struct device_node *pixis_node;
 	void __iomem *pixis;
@@ -145,19 +146,21 @@ static void p1022ds_set_monitor_port(int monitor_port)
 	}
 	brdcfg1 = pixis + 9;	/* BRDCFG1 is at offset 9 in the ngPIXIS */
 
-	switch (monitor_port) {
-	case 0: /* DVI */
+	switch (port) {
+	case FSL_DIU_PORT_DVI:
+		printk(KERN_INFO "%s:%u\n", __func__, __LINE__);
 		/* Enable the DVI port, disable the DFP and the backlight */
 		clrsetbits_8(brdcfg1, PX_BRDCFG1_DFPEN | PX_BRDCFG1_BACKLIGHT,
 			     PX_BRDCFG1_DVIEN);
 		break;
-	case 1: /* Single link LVDS */
+	case FSL_DIU_PORT_LVDS:
+		printk(KERN_INFO "%s:%u\n", __func__, __LINE__);
 		/* Enable the DFP port, disable the DVI and the backlight */
 		clrsetbits_8(brdcfg1, PX_BRDCFG1_DVIEN | PX_BRDCFG1_BACKLIGHT,
 			     PX_BRDCFG1_DFPEN);
 		break;
 	default:
-		pr_err("p1022ds: unsupported monitor port %i\n", monitor_port);
+		pr_err("p1022ds: unsupported monitor port %i\n", port);
 	}
 
 	iounmap(pixis);
@@ -214,23 +217,18 @@ void p1022ds_set_pixel_clock(unsigned int pixclock)
 }
 
 /**
- * p1022ds_show_monitor_port: show the current monitor
- *
- * This function returns a string indicating whether the current monitor is
- * set to DVI or LVDS.
- */
-ssize_t p1022ds_show_monitor_port(int monitor_port, char *buf)
-{
-	return sprintf(buf, "%c0 - DVI\n%c1 - Single link LVDS\n",
-		monitor_port == 0 ? '*' : ' ', monitor_port == 1 ? '*' : ' ');
-}
-
-/**
- * p1022ds_set_sysfs_monitor_port: set the monitor port for sysfs
+ * p1022ds_valid_monitor_port: set the monitor port for sysfs
  */
-int p1022ds_set_sysfs_monitor_port(int val)
+enum fsl_diu_monitor_port
+p1022ds_valid_monitor_port(enum fsl_diu_monitor_port port)
 {
-	return val < 2 ? val : 0;
+	switch (port) {
+	case FSL_DIU_PORT_DVI:
+	case FSL_DIU_PORT_LVDS:
+		return port;
+	default:
+		return FSL_DIU_PORT_DVI; /* Dual-link LVDS is not supported */
+	}
 }
 
 #endif
@@ -305,8 +303,7 @@ static void __init p1022_ds_setup_arch(void)
 	diu_ops.set_gamma_table		= p1022ds_set_gamma_table;
 	diu_ops.set_monitor_port	= p1022ds_set_monitor_port;
 	diu_ops.set_pixel_clock		= p1022ds_set_pixel_clock;
-	diu_ops.show_monitor_port	= p1022ds_show_monitor_port;
-	diu_ops.set_sysfs_monitor_port	= p1022ds_set_sysfs_monitor_port;
+	diu_ops.valid_monitor_port	= p1022ds_valid_monitor_port;
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 74e018e..13fa9a6 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -152,10 +152,10 @@ machine_device_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);
 	(c2 << AD_COMP_2_SHIFT) | (c1 << AD_COMP_1_SHIFT) | \
 	(c0 << AD_COMP_0_SHIFT) | (size << AD_PIXEL_S_SHIFT))
 
-unsigned int mpc8610hpcd_get_pixel_format(unsigned int bits_per_pixel,
-						int monitor_port)
+u32 mpc8610hpcd_get_pixel_format(enum fsl_diu_monitor_port port,
+				 unsigned int bits_per_pixel)
 {
-	static const unsigned long pixelformat[][3] = {
+	static const u32 pixelformat[][3] = {
 		{
 			MAKE_AD(3, 0, 2, 1, 3, 8, 8, 8, 8),
 			MAKE_AD(4, 2, 0, 1, 2, 8, 8, 8, 0),
@@ -170,7 +170,8 @@ unsigned int mpc8610hpcd_get_pixel_format(unsigned int bits_per_pixel,
 	unsigned int arch_monitor;
 
 	/* The DVI port is mis-wired on revision 1 of this board. */
-	arch_monitor = ((*pixis_arch == 0x01) && (monitor_port == 0))? 0 : 1;
+	arch_monitor =
+		((*pixis_arch == 0x01) && (port == FSL_DIU_PORT_DVI)) ? 0 : 1;
 
 	switch (bits_per_pixel) {
 	case 32:
@@ -185,10 +186,11 @@ unsigned int mpc8610hpcd_get_pixel_format(unsigned int bits_per_pixel,
 	}
 }
 
-void mpc8610hpcd_set_gamma_table(int monitor_port, char *gamma_table_base)
+void mpc8610hpcd_set_gamma_table(enum fsl_diu_monitor_port port,
+				 char *gamma_table_base)
 {
 	int i;
-	if (monitor_port == 2) {		/* dual link LVDS */
+	if (port == FSL_DIU_PORT_DLVDS) {
 		for (i = 0; i < 256*3; i++)
 			gamma_table_base[i] = (gamma_table_base[i] << 2) |
 					 ((gamma_table_base[i] >> 6) & 0x03);
@@ -199,17 +201,21 @@ void mpc8610hpcd_set_gamma_table(int monitor_port, char *gamma_table_base)
 #define PX_BRDCFG0_DLINK	(1 << 4)
 #define PX_BRDCFG0_DIU_MASK	(PX_BRDCFG0_DVISEL | PX_BRDCFG0_DLINK)
 
-void mpc8610hpcd_set_monitor_port(int monitor_port)
+void mpc8610hpcd_set_monitor_port(enum fsl_diu_monitor_port port)
 {
-	static const u8 bdcfg[] = {
-		PX_BRDCFG0_DVISEL | PX_BRDCFG0_DLINK,
-		PX_BRDCFG0_DLINK,
-		0,
-	};
-
-	if (monitor_port < 3)
+	switch (port) {
+	case FSL_DIU_PORT_DVI:
 		clrsetbits_8(pixis_bdcfg0, PX_BRDCFG0_DIU_MASK,
-			     bdcfg[monitor_port]);
+			     PX_BRDCFG0_DVISEL | PX_BRDCFG0_DLINK);
+		break;
+	case FSL_DIU_PORT_LVDS:
+		clrsetbits_8(pixis_bdcfg0, PX_BRDCFG0_DIU_MASK,
+			     PX_BRDCFG0_DLINK);
+		break;
+	case FSL_DIU_PORT_DLVDS:
+		clrbits8(pixis_bdcfg0, PX_BRDCFG0_DIU_MASK);
+		break;
+	}
 }
 
 /**
@@ -262,20 +268,10 @@ void mpc8610hpcd_set_pixel_clock(unsigned int pixclock)
 	iounmap(guts);
 }
 
-ssize_t mpc8610hpcd_show_monitor_port(int monitor_port, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE,
-			"%c0 - DVI\n"
-			"%c1 - Single link LVDS\n"
-			"%c2 - Dual link LVDS\n",
-			monitor_port == 0 ? '*' : ' ',
-			monitor_port == 1 ? '*' : ' ',
-			monitor_port == 2 ? '*' : ' ');
-}
-
-int mpc8610hpcd_set_sysfs_monitor_port(int val)
+enum fsl_diu_monitor_port
+mpc8610hpcd_valid_monitor_port(enum fsl_diu_monitor_port port)
 {
-	return val < 3 ? val : 0;
+	return port;
 }
 
 #endif
@@ -307,8 +303,7 @@ static void __init mpc86xx_hpcd_setup_arch(void)
 	diu_ops.set_gamma_table		= mpc8610hpcd_set_gamma_table;
 	diu_ops.set_monitor_port	= mpc8610hpcd_set_monitor_port;
 	diu_ops.set_pixel_clock		= mpc8610hpcd_set_pixel_clock;
-	diu_ops.show_monitor_port	= mpc8610hpcd_show_monitor_port;
-	diu_ops.set_sysfs_monitor_port	= mpc8610hpcd_set_sysfs_monitor_port;
+	diu_ops.valid_monitor_port	= mpc8610hpcd_valid_monitor_port;
 #endif
 
 	pixis_node = of_find_compatible_node(NULL, NULL, "fsl,fpga-pixis");
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 2ece02b..c6d0073 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -22,15 +22,24 @@ struct device_node;
 extern void fsl_rstcr_restart(char *cmd);
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
+
+/* The different ports that the DIU can be connected to */
+enum fsl_diu_monitor_port {
+	FSL_DIU_PORT_DVI,	/* DVI */
+	FSL_DIU_PORT_LVDS,	/* Single-link LVDS */
+	FSL_DIU_PORT_DLVDS	/* Dual-link LVDS */
+};
+
 struct platform_diu_data_ops {
-	unsigned int (*get_pixel_format) (unsigned int bits_per_pixel,
-		int monitor_port);
-	void (*set_gamma_table) (int monitor_port, char *gamma_table_base);
-	void (*set_monitor_port) (int monitor_port);
-	void (*set_pixel_clock) (unsigned int pixclock);
-	ssize_t (*show_monitor_port) (int monitor_port, char *buf);
-	int (*set_sysfs_monitor_port) (int val);
-	void (*release_bootmem) (void);
+	u32 (*get_pixel_format)(enum fsl_diu_monitor_port port,
+		unsigned int bpp);
+	void (*set_gamma_table)(enum fsl_diu_monitor_port port,
+		char *gamma_table_base);
+	void (*set_monitor_port)(enum fsl_diu_monitor_port port);
+	void (*set_pixel_clock)(unsigned int pixclock);
+	enum fsl_diu_monitor_port (*valid_monitor_port)
+		(enum fsl_diu_monitor_port port);
+	void (*release_bootmem)(void);
 };
 
 extern struct platform_diu_data_ops diu_ops;
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index bedf5be..6762976 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -31,8 +31,6 @@
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
 
-#include <linux/of_platform.h>
-
 #include <sysdev/fsl_soc.h>
 #include <linux/fsl-diu-fb.h>
 #include "edid.h"
@@ -183,7 +181,8 @@ static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
 
 static char *fb_mode = "1024x768-32@60";
 static unsigned long default_bpp = 32;
-static int monitor_port;
+static enum fsl_diu_monitor_port monitor_port;
+static char *monitor_string;
 
 #if defined(CONFIG_NOT_COHERENT_CACHE)
 static u8 *coherence_data;
@@ -201,7 +200,7 @@ struct fsl_diu_data {
 	void *dummy_aoi_virt;
 	unsigned int irq;
 	int fb_enabled;
-	int monitor_port;
+	enum fsl_diu_monitor_port monitor_port;
 };
 
 struct mfb_info {
@@ -282,6 +281,37 @@ static struct diu_hw dr = {
 static struct diu_pool pool;
 
 /**
+ * fsl_diu_name_to_port - convert a port name to a monitor port enum
+ *
+ * Takes the name of a monitor port ("dvi", "lvds", or "dlvds") and returns
+ * the enum fsl_diu_monitor_port that corresponds to that string.
+ *
+ * For compatibility with older versions, a number ("0", "1", or "2") is also
+ * supported.
+ *
+ * If the string is unknown, DVI is assumed.
+ *
+ * If the particular port is not supported by the platform, another port
+ * (platform-specific) is chosen instead.
+ */
+static enum fsl_diu_monitor_port fsl_diu_name_to_port(const char *s)
+{
+	enum fsl_diu_monitor_port port = FSL_DIU_PORT_DVI;
+	unsigned long val;
+
+	if (s) {
+		if (!strict_strtoul(s, 10, &val) && (val <= 2))
+			port = (enum fsl_diu_monitor_port) val;
+		else if (strncmp(s, "lvds", 4) == 0)
+			port = FSL_DIU_PORT_LVDS;
+		else if (strncmp(s, "dlvds", 5) == 0)
+			port = FSL_DIU_PORT_DLVDS;
+	}
+
+	return diu_ops.valid_monitor_port(port);
+}
+
+/**
  * fsl_diu_alloc - allocate memory for the DIU
  * @size: number of bytes to allocate
  * @param: returned physical address of memory
@@ -847,9 +877,8 @@ static int fsl_diu_set_par(struct fb_info *info)
 		}
 	}
 
-	ad->pix_fmt =
-		diu_ops.get_pixel_format(var->bits_per_pixel,
-					 machine_data->monitor_port);
+	ad->pix_fmt = diu_ops.get_pixel_format(machine_data->monitor_port,
+					       var->bits_per_pixel);
 	ad->addr    = cpu_to_le32(info->fix.smem_start);
 	ad->src_size_g_alpha = cpu_to_le32((var->yres_virtual << 12) |
 				var->xres_virtual) | mfbi->g_alpha;
@@ -1455,16 +1484,12 @@ static void free_buf(struct device *dev, struct diu_addr *buf, u32 size,
 static ssize_t store_monitor(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
-	int old_monitor_port;
-	unsigned long val;
+	enum fsl_diu_monitor_port old_monitor_port;
 	struct fsl_diu_data *machine_data =
 		container_of(attr, struct fsl_diu_data, dev_attr);
 
-	if (strict_strtoul(buf, 10, &val))
-		return 0;
-
 	old_monitor_port = machine_data->monitor_port;
-	machine_data->monitor_port = diu_ops.set_sysfs_monitor_port(val);
+	machine_data->monitor_port = fsl_diu_name_to_port(buf);
 
 	if (old_monitor_port != machine_data->monitor_port) {
 		/* All AOIs need adjust pixel format
@@ -1484,7 +1509,17 @@ static ssize_t show_monitor(struct device *device,
 {
 	struct fsl_diu_data *machine_data =
 		container_of(attr, struct fsl_diu_data, dev_attr);
-	return diu_ops.show_monitor_port(machine_data->monitor_port, buf);
+
+	switch (machine_data->monitor_port) {
+	case FSL_DIU_PORT_DVI:
+		return sprintf(buf, "DVI\n");
+	case FSL_DIU_PORT_LVDS:
+		return sprintf(buf, "Single-link LVDS\n");
+	case FSL_DIU_PORT_DLVDS:
+		return sprintf(buf, "Dual-link LVDS\n");
+	}
+
+	return 0;
 }
 
 static int __devinit fsl_diu_probe(struct platform_device *ofdev)
@@ -1708,8 +1743,7 @@ static int __init fsl_diu_setup(char *options)
 		if (!*opt)
 			continue;
 		if (!strncmp(opt, "monitor=", 8)) {
-			if (!strict_strtoul(opt + 8, 10, &val) && (val <= 2))
-				monitor_port = val;
+			monitor_port = fsl_diu_name_to_port(opt + 8);
 		} else if (!strncmp(opt, "bpp=", 4)) {
 			if (!strict_strtoul(opt + 4, 10, &val))
 				default_bpp = val;
@@ -1762,6 +1796,8 @@ static int __init fsl_diu_init(void)
 	if (fb_get_options("fslfb", &option))
 		return -ENODEV;
 	fsl_diu_setup(option);
+#else
+	monitor_port = fsl_diu_name_to_port(monitor_string);
 #endif
 	printk(KERN_INFO "Freescale DIU driver\n");
 
@@ -1828,7 +1864,7 @@ MODULE_PARM_DESC(mode,
 	"Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
 module_param_named(bpp, default_bpp, ulong, 0);
 MODULE_PARM_DESC(bpp, "Specify bit-per-pixel if not specified mode");
-module_param_named(monitor, monitor_port, int, 0);
-MODULE_PARM_DESC(monitor,
-	"Specify the monitor port (0, 1 or 2) if supported by the platform");
+module_param_named(monitor, monitor_string, charp, 0);
+MODULE_PARM_DESC(monitor, "Specify the monitor port "
+	"(\"dvi\", \"lvds\", or \"dlvds\") if supported by the platform");
 
-- 
1.7.4.4
