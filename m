Return-Path: <nathael.pajani@ed3l.fr>
Received: from smtp2-g19.free.fr (smtp2-g19.free.fr [212.27.42.28])
	by ozlabs.org (Postfix) with ESMTP id 7DABEDDF3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 21:56:44 +1000 (EST)
Message-ID: <48C7B602.9040404@ed3l.fr>
Date: Wed, 10 Sep 2008 13:56:50 +0200
From: Nathael Pajani <nathael.pajani@ed3l.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, matthias.fuchs@esd-electronics.com
Subject: Re: SM722 (Lynx3DM+) framebuffer driver
References: <200609271226.06115.matthias.fuchs@esd-electronics.com>
In-Reply-To: <200609271226.06115.matthias.fuchs@esd-electronics.com>
Content-Type: multipart/mixed; boundary="------------050006080202000908040104"
Reply-To: nathael.pajani@ed3l.fr
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050006080202000908040104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi !
I know your mail is quite old, but this might still prove useful....
and did you find a solution ?
Do you finally have a driver ? I'm interested in whatever information you have, 
even the links to 2.4 kernel code, or code for SM712 chips. Anything at all in 
fact, so I may try to improve my driver.

I have this device (Silicon Motion SM722 Lynx3DM+) on a powerPC board from ACTIS 
Computers.

You'll find attached a patch with the SMI driver I made.
It's not as good as it should be, be I have a usable display, being able to use 
xorg, and it's as much as I managed without a vgabios (which they provide for 
x86 arch only).
Note also that uboot on the board does some chip init, so this driver alone may 
not be useful if you don't already have something.

Note also that for my brain's sake I removed parts handling LynxEM chips from 
the original code (which was mainly for mips VR5701-SG2 with LynxEM+).

Have fun, and thank you if you can send in some useful stuff.
++++

-- 
Nathaël PAJANI
ED3L - Etude et Développement - Linux et Logiciels Libres
Adresse :
    25 av. Alexandre Godard
    69150 Décines-Charpieu
    FRANCE
Mail : nathael.pajani@ed3l.fr
Tel : 06 19 35 33 91
Internet : http://www.ed3l.fr

--------------050006080202000908040104
Content-Type: text/x-patch;
 name="diff_2.6.26_smi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff_2.6.26_smi.patch"

diff --git a/Makefile b/Makefile
index e3c5eb6..7d6a733 100644
--- a/Makefile
+++ b/Makefile
@@ -2,6 +2,7 @@ VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 26
 EXTRAVERSION =
+# Comment added to have git-diff include these lines in the diff.
 NAME = Rotary Wombat
 
 # *DOCUMENTATION*
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e0c5f96..950a92c 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1418,6 +1418,20 @@ config FB_ATY_BACKLIGHT
 	help
 	  Say Y here if you want to control the backlight of your display.
 
+config FB_SMI
+	tristate "SMI - Silicon Motion SM722 support (Lynx 3DM+) (EXPERIMENTAL)"
+	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_TILEBLITTING
+	select FB_SVGALIB
+	select VGASTATE
+	select FONT_8x16 if FRAMEBUFFER_CONSOLE
+	select FB_MACMODES if PPC
+	help
+	  Say Y here if you want to support the SMI Lynx 3DM+ chip : SM722
+
 config FB_S3
 	tristate "S3 Trio/Virge support"
 	depends on FB && PCI
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 04bca35..d457bb3 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_FB_KYRO)             += kyro/
 obj-$(CONFIG_FB_SAVAGE)		  += savage/
 obj-$(CONFIG_FB_GEODE)		  += geode/
 obj-$(CONFIG_FB_MBX)		  += mbx/
+obj-$(CONFIG_FB_SMI)              += smi/
 obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o
 obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
 obj-$(CONFIG_FB_CONTROL)          += controlfb.o
diff --git a/drivers/video/smi/Makefile b/drivers/video/smi/Makefile
new file mode 100644
index 0000000..3611c1b
--- /dev/null
+++ b/drivers/video/smi/Makefile
@@ -0,0 +1,9 @@
+#
+# Makefile for LynxEM+/EM4+(Silicon Motion Inc.) fb driver for VR5701-SG2
+# under Linux.
+#
+
+obj-$(CONFIG_FB_SM)	+= smifb.o
+
+smifb-objs	:= smi_base.o smi_hw.o 
+
diff --git a/drivers/video/smi/smi_base.c b/drivers/video/smi/smi_base.c
new file mode 100644
index 0000000..79f1989
--- /dev/null
+++ b/drivers/video/smi/smi_base.c
@@ -0,0 +1,384 @@
+/*
+ * drivers/video/smi/smi_base.c
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * Modifications: Nathael Pajani <nathael.pajani@ed3l.fr>
+ *   Port to linux 2.6.22-rc5 for powerpc based board xcom9347
+ *   with MPC8347E processor and LYNX_3DM+ graphic chip.
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/selection.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/console.h>
+#include "../console/fbcon.h"
+#include "smifb.h"
+#include "smi_hw.h"
+
+#define pr_debug(fmt,arg...) printk(KERN_INFO fmt,##arg)
+
+
+/*
+ * Card Identification
+ *
+ */
+static struct pci_device_id smifb_pci_tbl[] __devinitdata = {
+	{PCI_VENDOR_ID_SMI, PCI_DEVICE_ID_SMI_LYNX_3DM, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, /* Lynx 3DM/3DM+/3DM4+ */
+	{0,}			/* terminate list */
+};
+
+MODULE_DEVICE_TABLE(pci, smifb_pci_tbl);
+
+static struct fb_var_screeninfo smifb_default_var = {
+	.xres = 1024,
+	.yres = 768,
+	.xres_virtual = 1024,
+	.yres_virtual = 768,
+	.xoffset = 0,
+	.yoffset = 0,
+	.bits_per_pixel = 8,
+	.grayscale = 0,
+	.red = {5, 3, 0},  /* offset, mask */
+	.green = {2, 3, 0},
+	.blue = {0, 2, 0},
+	.transp = {0, 0, 0},
+	.nonstd = 0,
+	.activate = FB_ACTIVATE_NOW,
+	.height = -1,
+	.width = -1,
+	.accel_flags = 0,
+	.pixclock = 15727,
+	.left_margin = 168,
+	.right_margin = 0,
+	.upper_margin = 22,
+	.lower_margin = 0,
+	.hsync_len = 104,
+	.vsync_len = 6,
+	.sync = FB_SYNC_HOR_HIGH_ACT,
+	.vmode = FB_VMODE_NONINTERLACED,
+	.rotate = 0,
+};
+
+static char drvrname[] = "Video driver for SMI Lynx 3DM+";
+
+
+/*
+ *
+ * framebuffer operations
+ *
+ */
+static int smifb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
+{
+	struct smifb_info *sinfo = (struct smifb_info *)info;
+
+	pr_debug("smifb: smifb_get_fix\n");
+	fix->smem_start = sinfo->fb_base_phys;
+	fix->smem_len = sinfo->fbsize;
+	fix->mmio_start = sinfo->dpr_base_phys;
+	fix->mmio_len = sinfo->dpport_size;
+
+	fix->xpanstep = 0;	/* FIXME: no xpanstep for now */
+	fix->ypanstep = 0;	/* FIXME: no ypanstep for now */
+	fix->ywrapstep = 0;	/* FIXME: no ywrap for now */
+
+	return 0;
+}
+
+/*
+static int smifb_open(struct fb_info *info, int user);
+static int smifb_release(struct fb_info *info, int user);
+static int smifb_check_var(struct fb_var_screeninfo *var, struct fb_info *info);
+static int smifb_set_par(struct fb_info *info);
+
+static int smifb_blank(int blank, struct fb_info *info)
+{
+	return 0;
+}
+static int smifb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
+*/
+
+static int smifb_setcolreg(unsigned regno, unsigned red, unsigned green,
+		unsigned blue, unsigned transp, struct fb_info *info)
+{
+	if (regno > 15)
+		return 1;
+
+	((u8 *)(info->pseudo_palette))[regno] = ((red & 0x07) << 5) | ((green & 0x07) << 2) | (blue & 0x3);
+	return 0;
+}
+/*
+static int smifb_sync(struct fb_info *info)
+{
+	return 0;
+}
+
+static int smifb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg);
+*/
+/*
+ * Initialization helper functions
+ *
+ */
+/* kernel interface */
+static struct fb_ops smifb_ops = {
+	.owner = THIS_MODULE,
+/*	.fb_open = smifb_open,
+	.fb_release = smifb_release,
+	.fb_check_var = smifb_check_var,
+	.fb_set_par = smifb_set_par, */
+	.fb_setcolreg = smifb_setcolreg,
+/*	.fb_blank = smifb_blank,
+	.fb_pan_display = smifb_pan_display, */
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+	.fb_cursor = soft_cursor,
+/*	.fb_sync = smifb_sync,
+	.fb_ioctl = smifb_ioctl, */
+};
+
+static struct fb_fix_screeninfo smifb_fix = {
+	.id = "smifb",
+	.type = FB_TYPE_PACKED_PIXELS,
+	.visual = FB_VISUAL_TRUECOLOR,
+	.line_length = 1024 * 2,
+	.accel = FB_ACCEL_NONE,
+};
+
+static u32 colreg[17];
+
+/* NATH: dump registers for debug */
+static ssize_t dump_regs(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pci_dev* fbdev = to_pci_dev(dev);
+	struct smifb_info* sinfo;
+
+	if (!fbdev)
+		return -ENODEV;
+	sinfo = (struct smifb_info*)pci_get_drvdata(fbdev);
+	if (!sinfo)
+		return -ENODEV;
+
+	smi_print_moderegs( sinfo );
+
+	return 0;
+}
+
+static DEVICE_ATTR(dumpregs, 0666, dump_regs, NULL);
+
+static int smifb_create_dump_file(struct pci_dev *dev)
+{
+	printk("smifb: creating dump command file in sysfs\n");
+	return device_create_file( &dev->dev, &dev_attr_dumpregs );
+}
+
+static void smifb_remove_reset_file(struct pci_dev *dev)
+{
+	device_remove_file( &dev->dev, &dev_attr_dumpregs );
+}
+
+/*
+ * PCI bus
+ *
+ */
+static int __devinit smifb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
+{
+	int len;
+	int res;
+	u16 cmd;
+	struct smifb_info *sinfo;
+	struct fb_info *info;
+	int i = 0;
+
+	pr_debug("smifb: vendor id        0x%04x\n", pd->vendor);
+	pr_debug("smifb: device id        0x%04x\n", pd->device);
+
+	pr_debug("smifb: base0 start addr 0x%08x\n", (unsigned int)pci_resource_start(pd, 0));
+	pr_debug("smifb: base0 end   addr 0x%08x\n", (unsigned int)pci_resource_end(pd, 0));
+	pr_debug("smifb: base0 region len 0x%08x\n", (unsigned int)pci_resource_len(pd, 0));
+	pr_debug("smifb: base0 flags      0x%08x\n", (unsigned int)pci_resource_flags(pd, 0));
+
+	/* Allocate memory resources */
+	sinfo = kmalloc(sizeof(struct smifb_info), GFP_KERNEL);
+	if (!sinfo) {
+		goto err_out;
+	}
+	memset(sinfo, 0, sizeof(struct smifb_info));
+
+	/* Driver name */
+	sinfo->drvr_name = drvrname;
+
+	/* Set up PCI */
+	sinfo->pd = pd;
+	sinfo->base_phys = pci_resource_start(sinfo->pd, 0);	/* PCI device base address */
+	len = pci_resource_len(sinfo->pd, 0);
+	pr_debug("smifb: PCI ressource len = 0x%08lx\n", (long unsigned int)len);
+	/* Reserve PCI I/O and memory resources */
+	if (!request_mem_region(sinfo->base_phys, len, "smifb")) {
+		printk(KERN_ERR "cannot reserve FrameBuffer and MMIO region\n");
+		goto err_out_kfree;
+	}
+
+	if ((res = pci_enable_device(sinfo->pd)) < 0) {
+		printk(KERN_ERR "smifb: failed to enable -- err %d\n", res);
+		goto err_out_free_base;
+	}
+
+	/* Set MEM and IO */
+	pci_read_config_word(pd, PCI_COMMAND, &cmd);
+	cmd |= (PCI_COMMAND_MEMORY | PCI_COMMAND_IO);
+	pci_write_config_word(pd, PCI_COMMAND, cmd);
+
+
+	sinfo->base = ioremap(sinfo->base_phys, len);	/* FB+DPD+DPR+VPR+CPR+MMIO */
+	if (!sinfo->base) {
+		goto err_out_free_base;
+	}
+	
+	/* Set up memory pointers */
+	sinfo->dpport = (caddr_t) (sinfo->base + LYNX3DM_DPPORT_BASE_OFFSET);
+	sinfo->dpr = (caddr_t) (sinfo->base + LYNX3DM_DP_BASE_OFFSET);
+	sinfo->vpr = (caddr_t) (sinfo->base + LYNX3DM_VP_BASE_OFFSET);
+	sinfo->cpr = (caddr_t) (sinfo->base + LYNX3DM_CP_BASE_OFFSET);
+	sinfo->mmio = (caddr_t) (sinfo->base + LYNX3DM_IO_BASE_OFFSET);
+	sinfo->fb_base = (caddr_t) (sinfo->base + LYNX3DM_FB_BASE_OFFSET);
+
+	pr_debug("smifb: sinfo->dpport = 0x%08x\n", (uint32_t) sinfo->dpport);
+	pr_debug("smifb: sinfo->dpr    = 0x%08x, sinfo->vpr   = 0x%08x\n", (unsigned int)sinfo->dpr, (unsigned int)sinfo->vpr);
+	pr_debug("smifb: sinfo->cpr    = 0x%08x, sinfo->mmio  = 0x%08x\n", (unsigned int)sinfo->cpr, (unsigned int)sinfo->mmio);
+
+	sinfo->fbsize = 8 * 1024 * 1024;
+	sinfo->fb_base_phys = sinfo->base_phys + LYNX3DM_FB_BASE_OFFSET;
+
+	pr_debug("smifb: sinfo->fb_base_phys = 0x%08x\n", (unsigned int)sinfo->fb_base_phys);
+	pr_debug("smifb: sinfo->fbsize = 0x%08x\n", (unsigned int)sinfo->fbsize);
+	pr_debug("smifb: sinfo->base = 0x%08x\n", (unsigned int)sinfo->base);
+	pr_debug("smifb: sinfo->fb_base = 0x%08x\n", (unsigned int)sinfo->fb_base);
+
+	/* Clear frame buffer */
+	for (i=0; i<sinfo->fbsize/4; i++) {
+		*((uint32_t*)(sinfo->fb_base + i*4)) = 0;
+	}
+
+	smi_print_moderegs( sinfo );
+
+	/* Set up driver */
+	info = &(sinfo->info);
+	smifb_get_fix(&smifb_fix, -1, info);
+
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &smifb_ops;
+	info->var = smifb_default_var;
+	info->fix = smifb_fix;
+	info->pseudo_palette = colreg;
+	info->screen_base = sinfo->fb_base;
+
+	/* Set up the chip registers */
+	smi_set_moderegs(sinfo, &smifb_default_var);
+
+	if (register_framebuffer(&sinfo->info) < 0) {
+		goto err_out_iounmap;
+	}
+	pci_set_drvdata(pd, sinfo);
+
+	smifb_create_dump_file( pd );
+
+	printk(KERN_INFO "smifb: " "framebuffer (%s)\n", sinfo->drvr_name);
+
+	return 0;
+
+err_out_iounmap:
+	iounmap(sinfo->base);
+err_out_free_base:
+	release_mem_region(sinfo->base_phys, len);
+err_out_kfree:
+	kfree(sinfo);
+err_out:
+	return -ENODEV;
+}
+
+static void __devexit smifb_remove(struct pci_dev *pd)
+{
+	struct smifb_info *sinfo = pci_get_drvdata(pd);
+	pr_debug("smifb: smifb_remove\n");
+
+	if (!sinfo)
+		return;
+
+	smifb_remove_reset_file( pd );
+
+	unregister_framebuffer(&sinfo->info);
+
+	/* stop the lynx chip */
+	release_mem_region(sinfo->base_phys, pci_resource_len(sinfo->pd, 0));
+	kfree(sinfo);
+	pci_set_drvdata(pd, NULL);
+}
+
+
+static struct pci_driver smifb_driver = {
+	.name = "smifb",
+	.id_table = smifb_pci_tbl,
+	.probe = smifb_probe,
+	.remove = __devexit_p(smifb_remove),
+};
+
+
+/*
+ * Driver initialization
+ */
+static int __init smifb_setup(char *options)
+{
+	pr_debug("smifb: setup\n");
+
+	if (!options || !*options) {
+		pr_debug("smifb: no options given.\n");
+		return 0;
+	}
+
+	pr_debug("smifb: no options supported yet.\n");
+	return 0;
+}
+
+int __init smifb_init(void)
+{
+	char *option = NULL;
+
+	pr_debug("smifb: smifb_init\n");
+
+	if (fb_get_options("smifb", &option))
+		return -ENODEV;
+	smifb_setup(option);
+
+	return pci_register_driver(&smifb_driver);
+}
+
+
+static void __exit smifb_exit(void)
+{
+	pci_unregister_driver(&smifb_driver);
+}
+
+module_init(smifb_init);
+module_exit(smifb_exit);
+
+
+MODULE_AUTHOR("Sergey Podstavin");
+MODULE_DESCRIPTION("Framebuffer driver for Silicon Motion Lynx 3DM+");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/smi/smi_hw.c b/drivers/video/smi/smi_hw.c
new file mode 100644
index 0000000..b71792a
--- /dev/null
+++ b/drivers/video/smi/smi_hw.c
@@ -0,0 +1,629 @@
+/*
+ * drivers/video/smi/smi_hw.c
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver for VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include "smifb.h"
+#include "smi_hw.h"
+
+#define pr_debug(fmt,arg...) printk(KERN_INFO fmt,arg)
+
+void smi_print_moderegs(struct smifb_info *sinfo)
+{
+	unsigned int xres = 0, hStart = 0, right_margin = 0, hTotal = 0, hsync_len = 0;
+	unsigned int yres = 0, vStart = 0, lower_margin = 0, vTotal = 0, vsync_len = 0;
+
+	unsigned int wchar = 8;
+	unsigned int val = 0, overflow_07 = 0, overflow_30 = 0;
+
+	unsigned int i = 0;
+
+	printk("\n\n\tBegin dump of regs\n\n");
+
+	pr_debug("smifb: sinfo->dpport = 0x%08x\n", (uint32_t) sinfo->dpport);
+	pr_debug("smifb: sinfo->dpr    = 0x%08x, sinfo->vpr   = 0x%08x\n", (unsigned int)sinfo->dpr, (unsigned int)sinfo->vpr);
+	pr_debug("smifb: sinfo->cpr    = 0x%08x, sinfo->mmio  = 0x%08x\n", (unsigned int)sinfo->cpr, (unsigned int)sinfo->mmio);
+
+	/* Drawing Engine Control Registers */
+	printk(" DPR_00 Source Y or K2               : 0x%04x\n",  (in_le32((unsigned*)(sinfo->dpr+0x00))&0x3fff));
+	printk(" DPR_02 Source X or K1               : 0x%04x\n", ((in_le32((unsigned*)(sinfo->dpr+0x00))&0x3fff0000)>>16));
+	printk(" DPR_04 Destination Y or Start Y     : 0x%04x\n",  (in_le32((unsigned*)(sinfo->dpr+0x04))&0x3fff));
+	printk(" DPR_06 Destination X or Start X     : 0x%04x\n", ((in_le32((unsigned*)(sinfo->dpr+0x04))&0x0fff0000)>>16));
+	printk(" DPR_08 Dimension Y or Error Term    : 0x%04x\n",  (in_le32((unsigned*)(sinfo->dpr+0x08))&0x3fff));
+	printk(" DPR_0A Dimension X or Vector Length : 0x%04x\n", ((in_le32((unsigned*)(sinfo->dpr+0x08))&0x0fff0000)>>16));
+	printk(" DPR_0C ROP and Miscellaneous Ctrl   : 0x%04x\n",  (in_le32((unsigned*)(sinfo->dpr+0x0C))&0xffff));
+	printk(" DPR_0E DE Commands and Ctrl         : 0x%04x\n", ((in_le32((unsigned*)(sinfo->dpr+0x0C))&0xffff0000)>>16));
+	printk(" DPR_10 Source Row Pitch             : 0x%04x\n",  (in_le32((unsigned*)(sinfo->dpr+0x10))&0x0fff));
+	printk(" DPR_12 Destination Row Picth        : 0x%04x\n", ((in_le32((unsigned*)(sinfo->dpr+0x10))&0x0fff0000)>>16));
+	printk(" DPR_14 Foreground Colors            : 0x%08x\n", in_le32((unsigned*)(sinfo->dpr+0x14))&0x00ffffff);
+	printk(" DPR_18 Background Colors            : 0x%08x\n", in_le32((unsigned*)(sinfo->dpr+0x18))&0x00ffffff);
+	printk(" DPR_1C Stretch Source Height Y      : 0x%04x\n",  (in_le32((unsigned*)(sinfo->dpr+0x1C))&0x0fff));
+	printk(" DPR_1E DE Data/Loc Format Select    : 0x%04x\n", ((in_le32((unsigned*)(sinfo->dpr+0x1C))&0x7fbf0000)>>16));
+	printk(" DPR_20 Color Compare                : 0x%08x\n", in_le32((unsigned*)(sinfo->dpr+0x20))&0x00ffffff);
+	printk(" DPR_24 Color Compare Mask           : 0x%08x\n", in_le32((unsigned*)(sinfo->dpr+0x24))&0x00ffffff);
+	printk(" DPR_28 Bit Mask                     : 0x%04x\n",  (in_le32((unsigned*)(sinfo->dpr+0x28))&0xffff));
+	printk(" DPR_2A Byte Mask Enable             : 0x%04x\n", ((in_le32((unsigned*)(sinfo->dpr+0x28))&0xffff0000)>>16));
+	printk(" DPR_2C Scisors Left and Control     : 0x%04x\n",  (in_le32((unsigned*)(sinfo->dpr+0x2C))&0x3fff));
+	printk(" DPR_2E Scisors Top                  : 0x%04x\n", ((in_le32((unsigned*)(sinfo->dpr+0x2C))&0x0fff0000)>>16));
+	printk(" DPR_30 Scisors Right                : 0x%04x\n",  (in_le32((unsigned*)(sinfo->dpr+0x30))&0x0fff));
+	printk(" DPR_32 Scisors Bottom               : 0x%04x\n", ((in_le32((unsigned*)(sinfo->dpr+0x30))&0x0fff0000)>>16));
+	printk(" DPR_34 Mono Pattern Low             : 0x%08x\n", in_le32((unsigned*)(sinfo->dpr+0x34)));
+	printk(" DPR_38 Mono Pattern High            : 0x%08x\n", in_le32((unsigned*)(sinfo->dpr+0x38)));
+	printk(" DPR_3C XY Addr Dst & Src ...        : 0x%08x\n", in_le32((unsigned*)(sinfo->dpr+0x3C))&0x0fff0fff);
+	printk(" DPR_40 Source Base Address          : 0x%08x\n", in_le32((unsigned*)(sinfo->dpr+0x40))&0x000fffff);
+	printk(" DPR_44 Destination Base Address     : 0x%08x\n", in_le32((unsigned*)(sinfo->dpr+0x44))&0x000fffff);
+
+	/* Video Processor Control Registers */
+	printk(" VPR_00 Miscellaneous Graphics and Video Control      : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x00)));
+	printk(" VPR_04 Color Keys                                    : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x04)));
+	printk(" VPR_08 Color Key Masks                               : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x08)));
+	printk(" VPR_0C Data Src Start Addr for Ext Graphics Modes    : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x0C)));
+	printk(" VPR_10 Data Src Width and Off for Ext Graphics Modes : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x10)));
+	printk(" VPR_14 Video Window I Left and Top Boundaries        : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x14)));
+	printk(" VPR_18 Video Window I Right and Bottom Boundaries    : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x18)));
+	printk(" VPR_1C Video Window I Source Start Address           : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x1C)));
+	printk(" VPR_20 Video Window I Source Width and Offset        : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x20)));
+	printk(" VPR_24 Video Window I Stretch Factor                 : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x24)));
+	printk(" VPR_28 Video Window II Left and Top Boundaries       : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x28)));
+	printk(" VPR_2C Video Window II Right and Bottom Boundaries   : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x2C)));
+	printk(" VPR_30 Video Window II Source Start Address          : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x30)));
+	printk(" VPR_34 Video Window II Source Width and Offset       : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x34)));
+	printk(" VPR_38 Video Window II Stretch Factor                : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x38)));
+	printk(" VPR_3C Graphics and Video Controll II                : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x3C)));
+	printk(" VPR_40 Graphic Scale Factor                          : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x40)));
+	printk(" VPR_54 FIFO Priority Control                         : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x54)));
+	printk(" VPR_58 FIFO Empty Request level Control              : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x58)));
+	printk(" VPR_5C YUV to RGB Conversion Constant                : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x5C)));
+	printk(" VPR_60 Current Scan Line Position                    : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x60)));
+	printk(" VPR_64 Signature Analyzer Control and Status         : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x64)));
+	printk(" VPR_68 Video Window I Stretch Factor                 : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x68)));
+	printk(" VPR_6C Video Window II Stretch Factor                : 0x%08x\n", in_le32((unsigned*)(sinfo->vpr+0x6C)));
+
+	/* Capture Processor Control Registers */
+	printk(" CPR_00 Capture Port Control                        : 0x%08x\n", in_le32((unsigned*)(sinfo->cpr+0x00)));
+	printk(" CPR_04 Video Source Clipping Control               : 0x%08x\n", in_le32((unsigned*)(sinfo->cpr+0x04)));
+	printk(" CPR_08 Video Source Capture Size Control           : 0x%08x\n", in_le32((unsigned*)(sinfo->cpr+0x08)));
+	printk(" CPR_0C Capture Port Buffer I Source Start Address  : 0x%08x\n", in_le32((unsigned*)(sinfo->cpr+0x0C)));
+	printk(" CPR_10 Capture Port Buffer II Source Start Address : 0x%08x\n", in_le32((unsigned*)(sinfo->cpr+0x10)));
+	printk(" CPR_14 Capture Port Source Offset Address          : 0x%08x\n", in_le32((unsigned*)(sinfo->cpr+0x14)));
+	printk(" CPR_18 Capture FIFO Empty Request level Control    : 0x%08x\n", in_le32((unsigned*)(sinfo->cpr+0x18)));
+
+	printk("\n\n");
+
+	printk("mmio @ 0x%08x.\n", (unsigned int)sinfo->mmio);
+	printk("smi_vga_misc_read : %02x\n", smi_vga_misc_read(sinfo->mmio));
+	printk("smi_feature_ctrl_read : %02x\n", smi_feature_ctrl_read(sinfo->mmio));
+	val = smi_status0_read(sinfo->mmio);
+	printk("Input status registers : 0x%02x, 0x%02x\n", val, smi_status1_read(sinfo->mmio));
+	if (val & 0x10) {
+		printk("  Color Display detected.\n");
+	}
+
+	printk("\nSEQUENCER.");
+	for (i = 0; i <= 0x04; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_sequencer_read(sinfo->mmio, i));
+	}
+
+	printk("\nCRT CONTROLLER.");
+	for (i = 0; i <= 0x18; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_crtc_read(sinfo->mmio, i));
+	}
+	for (i = 0x30; i <= 0x4D; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_crtc_read(sinfo->mmio, i));
+	}
+
+	printk("\nGRAPHICS CONTROLLER.");
+	for (i = 0; i <= 0x08; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_graphics_read(sinfo->mmio, i));
+	}
+
+	printk("\nATTRIBUTE CONTROLLER.");
+	for (i = 0; i <= 0x14; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_attribute_read(sinfo->mmio, i));
+	}
+
+	printk("\nSYSTEM CONTROL.");
+	printk("\n\t10|  -- -- -- --  --");
+	for (i = 0x15; i <= 0x1F; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_ext_sysctrl_read(sinfo->mmio, i));
+	}
+
+	printk("\nPOWER DOWN CONTROL.");
+	for (i = 0x20; i <= 0x24; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_ext_powerctrl_read(sinfo->mmio, i));
+	}
+
+	printk("\nFLAT PANEL CONTROL.");
+	for (i = 0x30; i <= 0x34; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_ext_flatpanel_read(sinfo->mmio, i));
+	}
+	printk(" -- -- --  -- -- -- --  -- --");
+	for (i = 0x3E; i <= 0x4E; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_ext_flatpanel_read(sinfo->mmio, i));
+	}
+	printk(" --");
+	for (i = 0x50; i <= 0x5A; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_ext_flatpanel_read(sinfo->mmio, i));
+	}
+	for (i = 0xA0; i <= 0xAF; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_ext_flatpanel_read(sinfo->mmio, i));
+	}
+	
+	printk("\nMEMORY CONTROL.");
+	for (i = 0x60; i <= 0x61; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_ext_memctrl_read(sinfo->mmio, i));
+	}
+	printk("\n\t70|  -- -- -- --  -- -- %02x", smi_ext_memctrl_read(sinfo->mmio, 0x76));
+
+	printk("\nCLOCK CONTROL.\n");
+	printk("\t60|  -- -- -- --  --");
+	for (i = 0x65; i <= 0x6F; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_ext_clkctrl_read(sinfo->mmio, i));
+	}
+
+	printk("\nGENERAL PURPOSE REGS.");
+	for (i = 0x70; i <= 0x75; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_ext_gp_read(sinfo->mmio, i));
+	}
+
+	printk("\nPOP-UP ICON and HARDWARE CURSOR.");
+	for (i = 0x80; i <= 0x93; i++) {
+		if (!(i % 16))
+			printk("\n\t%02x|", i);
+		if (!(i % 4))
+			printk(" ");
+		printk(" %02x", smi_ext_cursor_read(sinfo->mmio, i));
+	}
+
+	printk("\n\n\tEnd dump of regs\n\n");
+
+	printk("\n\tBegin display values traduction\n\n");
+
+	xres = ((smi_crtc_read(sinfo->mmio, SMI_CRTx01_H_DISPLAY_END) + 1) * wchar); /* hDisplay */
+	hStart = ((smi_crtc_read(sinfo->mmio, SMI_CRTx04_H_SYNC_START) + 0) * wchar);
+	hTotal = ((smi_crtc_read(sinfo->mmio, SMI_CRTx00_H_TOTAL) + 5) * wchar);
+	val = ((smi_crtc_read(sinfo->mmio, SMI_CRTx05_H_SYNC_END) & 0x80) >> 2 );
+	val |= (smi_crtc_read(sinfo->mmio, SMI_CRTx03_H_BLANK_END) & 0x1f);
+	right_margin = (val * wchar);
+	hsync_len = ((smi_crtc_read(sinfo->mmio, SMI_CRTx05_H_SYNC_END) & 0x1f) * wchar);
+
+	overflow_30 = smi_crtc_read(sinfo->mmio, SMI_CRTx30_MODE_EN);
+	overflow_07 = smi_crtc_read(sinfo->mmio, SMI_CRTx07_OVERFLOW_VERT);
+	val = ( ((overflow_07 & 0x02) << (8-1)) | ((overflow_07 & 0x40) << (9-6)) );
+	val |= ((overflow_30 & 0x04) << (10-2));
+	val |= smi_crtc_read(sinfo->mmio, SMI_CRTx12_V_DISPLAY_END);
+	yres = (val + 1);
+	val = ( ((overflow_07 & 0x04) << (8-2)) | ((overflow_07 & 0x80) << (9-7)) );
+	val |= ((overflow_30 & 0x01) << (10-0));
+	vStart = (smi_crtc_read(sinfo->mmio, SMI_CRTx10_V_SYNC_START) | val);
+	val = ( ((overflow_07 & 0x01) << (8-0)) | ((overflow_07 & 0x20) << (9-5)) );
+	val |= ((overflow_30 & 0x08) << (10-3));
+	vTotal = (smi_crtc_read(sinfo->mmio, SMI_CRTx06_V_TOTAL) | val);
+	lower_margin = smi_crtc_read(sinfo->mmio, SMI_CRTx16_V_BLANK_END);
+	vsync_len = (smi_crtc_read(sinfo->mmio, SMI_CRTx11_V_SYNC_END) & 0x0f);
+
+	printk("Horizontal values, in pixclocks\n");
+	printk(" xres = %d\n", xres);
+	printk(" hTotal = %d\n", hTotal);
+	printk(" left_margin (hTotal - hStart - hsync_len) = %d\n", (hTotal - hStart - hsync_len));
+	printk(" right_margin = %d\n", right_margin);
+	printk(" computed right_margin (hStart - xres) = %d\n", (hStart - xres));
+	printk(" hStart = %d\n", hStart);
+	printk(" hsync_len = %d\n", hsync_len);
+
+	printk("Vertical values, in pixclocks\n");
+	printk(" yres = %d\n", yres);
+	printk(" vTotal = %d\n", vTotal);
+	printk(" upper_margin (vTotal - vStart - vsync_len) = %d\n", (vTotal - vStart - vsync_len));
+	printk(" lower_margin = %d\n", lower_margin);
+	printk(" computed lower_margin (vStart - yres) = %d\n", (vStart - yres));
+	printk(" vStart = %d\n", vStart);
+	printk(" vsync_len = %d\n", vsync_len);
+
+	printk("\n\tEnd display values traduction\n\n");
+
+}
+
+
+/*
+ * set mode registers
+ */
+void smi_set_moderegs(struct smifb_info* sinfo, struct fb_var_screeninfo* fbinfo)
+{
+	unsigned int bpp = 0, width = 0, height = 0;
+	unsigned int hDisplay = 0, hStart = 0, hEnd = 0, hTotal = 0;
+	unsigned int vDisplay = 0, vStart = 0, vEnd = 0, vTotal = 0;
+	unsigned int wchar = 8, hchar = 16;
+	unsigned int mode = SMI_USE_GRAPH;
+
+	struct vpr_regs* vpr;
+	struct dpr_regs* dpr;
+
+	unsigned int tmp = 0;
+	unsigned int val = 0;
+
+	bpp = fbinfo->bits_per_pixel;
+
+	/* horizontal params all in pixclock */
+	width = fbinfo->xres_virtual;
+	hDisplay = fbinfo->xres;
+	hStart = (hDisplay + fbinfo->right_margin); /* h-blank start */
+	hEnd = (hStart + fbinfo->hsync_len); /* h-sync end */
+	hTotal = (hEnd + fbinfo->left_margin); /* hsync to hsync */
+
+	/* vertical params */
+	height = fbinfo->yres_virtual;
+	vDisplay = fbinfo->yres; /* number of lines */
+	vStart = (vDisplay + fbinfo->lower_margin); /* v-sync pulse start */
+	vEnd = (vStart + fbinfo->vsync_len); /* v-sync end */
+	vTotal = (vEnd + fbinfo->upper_margin); /* number of scanlines (v-blank end) */
+
+
+	printk("smi_set_moderegs, values in pixclocks\n");
+	pr_debug("bpp = %d, width = %d, height = %d\n", bpp, width, height);
+	pr_debug("hDisplay = %d, hStart = %d, hEnd = %d, hTotal = %d\n", hDisplay, hStart, hEnd, hTotal);
+	pr_debug("vDisplay = %d, vStart = %d, vEnd = %d, vTotal = %d\n", vDisplay, vStart, vEnd, vTotal);
+
+	/**********************************************************************/
+	/* Zero chip memory */
+	memset(sinfo->vpr, 0, sizeof(struct vpr_regs));
+	memset(sinfo->dpr, 0, sizeof(struct dpr_regs));
+	memset(sinfo->cpr, 0, sizeof(struct cpr_regs));
+
+	pr_debug("smi_nath : smi_vga_misc_read : %02x\n", smi_vga_misc_read(sinfo->mmio));
+	pr_debug("smi_nath : smi_feature_ctrl_read : %02x\n", smi_feature_ctrl_read(sinfo->mmio));
+
+	/* Set the chip in color mode and unlock the registers */
+	tmp = ( 0x0c | SMI_MISC_ENABLE_WRITE | SMI_MISC_COLOR_MODE );
+	if (fbinfo->sync & FB_SYNC_HOR_HIGH_ACT)
+		tmp |= 0x40;
+	if (fbinfo->sync & FB_SYNC_VERT_HIGH_ACT)
+		tmp |= 0x80;
+	smi_vga_misc_write(sinfo->mmio, tmp);
+
+	/* Enable access to SMI Extended regs */
+	smi_unlock_extended_regs(sinfo->mmio);
+
+	printk("smi_set_moderegs, enabling display\n");
+	/* Enable display */
+	tmp = ((bpp == 8) ? 0x00 : 0x40);
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRx31_VIRT_REFRESH, (0x83 | tmp)); /* No auto-shutdown, CRT and LCD */ 
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRx33_POWER_CURSOR_CTRL, 0x05); /* default, CRT VGA unlocked, LVDS off */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRx34_ON_OFF_SEQ, 0x80); /* default */
+	/* At least 0 in bit 7 in order to allow writting to CRT 00-07 regs, the right value will be set up later */
+	tmp = smi_crtc_read(sinfo->mmio, SMI_CRTx11_V_SYNC_END);
+	smi_crtc_write(sinfo->mmio, SMI_CRTx11_V_SYNC_END, (tmp & ~0x80));
+
+	printk("smi_set_moderegs, setting up mmio regs\n");
+	/**********************************************************************/
+	/* Sequencer */
+	smi_sequencer_write(sinfo->mmio, SMI_SEQx00_RESET, 0x03); /* Normal operating mode */
+	tmp = ((wchar == 9) ? 0x00 : 0x01);
+	smi_sequencer_write(sinfo->mmio, SMI_SEQx01_CLK_MODE, tmp); /* 8 or 9 dots wide char clock */
+	smi_sequencer_write(sinfo->mmio, SMI_SEQx02_EN_WR_PLANE, 0x0F); /* Allow write to all map planes */
+	smi_sequencer_write(sinfo->mmio, SMI_SEQx03_CHAR_MAP_SEL, 0x00);
+	smi_sequencer_write(sinfo->mmio, SMI_SEQx04_MEM_MODE, 0x0e); /* Sequential addressing of all 256K */
+
+	/**********************************************************************/
+	/* CRTC Controller */
+	/* Horizontal display, the following values are in character clocks */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx00_H_TOTAL, (hTotal/wchar - 5));  /* Horizontal Total */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx01_H_DISPLAY_END, (hDisplay/wchar - 1));  /* Horizontal Display End */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx02_H_BLANK_START, (hDisplay/wchar - 1));  /* Horizontal Blank Start */
+	val = (fbinfo->right_margin / wchar);
+	tmp = (val & 0x1f);
+	smi_crtc_write(sinfo->mmio, SMI_CRTx03_H_BLANK_END, (0x00 | tmp)); /* Blank Pulse Width*/
+	smi_crtc_write(sinfo->mmio, SMI_CRTx04_H_SYNC_START, (hStart/wchar));  /* Horizontal Sync Pulse Start */
+	tmp = ( (val & 0x20) << (7-5) );
+	val = ((fbinfo->hsync_len / wchar) & 0x1f);
+	smi_crtc_write(sinfo->mmio, SMI_CRTx05_H_SYNC_END, (tmp | 0x00 | val));  /* Sync Pulse Width */
+	
+	/* Vertical display, the following values are in scan lines */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx06_V_TOTAL, (vTotal & 0xff));  /* Vertical Total 8 LSB bits*/
+	smi_crtc_write(sinfo->mmio, SMI_CRTx12_V_DISPLAY_END, ((vDisplay - 1) & 0xff));  /* Vertical Display End */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx15_V_BLANK_START, ((vDisplay - 1) & 0xff));  /* Vertical Blank Start */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx16_V_BLANK_END, (fbinfo->lower_margin & 0xff));  /* Vertical Blank End */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx10_V_SYNC_START, (vStart & 0xff));  /* Vertical Sync Pulse Start */
+	val = (fbinfo->vsync_len & 0x0f);
+	smi_crtc_write(sinfo->mmio, SMI_CRTx11_V_SYNC_END, (0x00 | val));  /* Vertical Sync Pulse Width */
+	tmp = ( ((vTotal & 0x200) >> (9-5)) | ((vTotal & 0x100) >> (8-0)) ); /* 06_V_TOTAL */
+	tmp |= ( (((vDisplay - 1) & 0x200) >> (9-6)) | (((vDisplay - 1) & 0x100) >> (8-1)) ); /* 12_V_DISPLAY_END */
+	tmp |= ( ((vDisplay - 1) & 0x100) >> (8-3) ); /* 15_V_BLANK_START */
+	tmp |= ( ((vStart & 0x200) >> (9-7)) | ((vStart & 0x100) >> (8-2)) ); /* 10_V_SYNC_START */
+	tmp |= ( (0xfff & 0x100) >> (8-4) ); /* 18_LINE_COMPARE */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx07_OVERFLOW_VERT, (0x00 | tmp));  /* Overflow Vertical */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx08_PRESET_ROW_SCAN, 0x00);  /* Preset Row Scan */
+	tmp = ( (vDisplay & 0x200) >> (9-5) ); /* 15_V_BLANK_START */
+	tmp |= ( (0xfff & 0x200) >> (9-6) ); /* 18_LINE_COMPARE */
+	val = ((hchar - 1) & 0x1f);
+	smi_crtc_write(sinfo->mmio, SMI_CRTx09_MAX_SCAN_LINE, (0x00 | tmp | val));  /* Maximum Scan Line */
+
+	smi_crtc_write(sinfo->mmio, SMI_CRTx0C_DISP_START_ADDR_H, 0x00);  /* Display Start Address (19 bits) = 0x00000 */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx0D_DISP_START_ADDR_L, 0x00);
+	smi_crtc_write(sinfo->mmio, SMI_CRTx0A_CURSOR_START, 0x20);  /* No cursor */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx0B_CURSOR_END, 0x00);
+	smi_crtc_write(sinfo->mmio, SMI_CRTx0E_CURSOR_ADDR_H, 0x00);
+	smi_crtc_write(sinfo->mmio, SMI_CRTx0F_CURSOR_ADDR_L, 0x00);
+	tmp = ((width * bpp / 64) & 0xff);
+	smi_crtc_write(sinfo->mmio, SMI_CRTx13_OFFSET, 0xff);  /* Offset */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx14_UNDERLINE_LOC, (0x40));  /* Underline Location */
+	tmp = ((bpp == 8) ? 0x04 : 0x00);
+	smi_crtc_write(sinfo->mmio, SMI_CRTx17_MODE_CTRL, (0xa3));  /* CRT Mode Control */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx18_LINE_COMPARE, 0xff);  /* Line Compare */
+	
+	/* Extended SMI CRT */
+	tmp = ((vTotal & 0x400) >> (10-3)); /* 06_V_TOTAL */
+	tmp |= (((vDisplay - 1) & 0x400) >> (10-2)); /* 12_V_DISPLAY_END */
+	tmp |= ((vDisplay & 0x400) >> (10-1)); /* 15_V_BLANK_START */
+	tmp |= ((vStart & 0x400) >> (10-0)); /* 10_V_SYNC_START */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx30_MODE_EN, (0x00 | tmp));  /* CRTC Overflow and Interlace Mode Enable */
+	smi_crtc_write(sinfo->mmio, SMI_CRTx31_INTL_RETRACE, 0x00);
+	smi_crtc_write(sinfo->mmio, SMI_CRTx35_V_EXP_CONST_L, 0x00);
+	smi_crtc_write(sinfo->mmio, SMI_CRTx36_V_EXP_CONST_H, 0x00);
+
+	/* Shadow registers */
+	smi_crtc_write(sinfo->mmio, SMI_SVRx40_H_TOTAL, (hTotal/wchar - 5));  /* Horizontal Total */
+	smi_crtc_write(sinfo->mmio, SMI_SVRx41_H_BLANK_START, (hDisplay/wchar - 1));  /* Horizontal Blank Start */
+	val = (fbinfo->right_margin / wchar);
+	tmp = (val & 0x1f);
+	smi_crtc_write(sinfo->mmio, SMI_SVRx42_H_BLANK_END, tmp);  /* Horizontal Blank End */
+	smi_crtc_write(sinfo->mmio, SMI_SVRx43_H_RETRACE_START, (hStart/wchar));  /* Horizontal Retrace Start */
+	tmp = ( (val & 0x20) << (7-5) );
+	val = ((fbinfo->hsync_len / wchar) & 0x1f);
+	smi_crtc_write(sinfo->mmio, SMI_SVRx44_H_RETRACE_END, (tmp | 0x00 | val));  /* Horizontal Retrace End */
+	smi_crtc_write(sinfo->mmio, SMI_SVRx45_V_TOTAL, (vTotal & 0xff));  /* Vertical Total */
+	smi_crtc_write(sinfo->mmio, SMI_SVRx46_V_BLANK_START, ((vDisplay - 1) & 0xff));  /* Vertical Blank Start */
+	smi_crtc_write(sinfo->mmio, SMI_SVRx47_V_BLANK_END, (fbinfo->lower_margin & 0xff));  /* Vertical Blank End */
+	smi_crtc_write(sinfo->mmio, SMI_SVRx48_V_RETRACE_START, (vStart & 0xff));  /* Vertical Retrace Start */
+	smi_crtc_write(sinfo->mmio, SMI_SVRx49_V_RETRACE_END, (fbinfo->vsync_len & 0x0f));  /* Vertical Retrace End */
+	tmp =  ( ((vStart         & 0x200) >> (9-7)) | ((vStart         & 0x100) >> (8-2)) );
+	tmp |= ( (((vDisplay - 1) & 0x200) >> (9-6)) | (((vDisplay - 1) & 0x100) >> (8-1)) );
+	tmp |= ( ((vTotal         & 0x200) >> (9-5)) | ((vTotal         & 0x100) >> (8-0)) );
+	tmp |= ( ((vDisplay - 1) & 0x100) >> (8-3) );
+	smi_crtc_write(sinfo->mmio, SMI_SVRx4A_V_OVERFLOW, tmp);  /* Vertical Overflow */
+	tmp = ( ((vDisplay - 1) & 0x200) >> (9-5) );
+	smi_crtc_write(sinfo->mmio, SMI_SVRx4B_MAX_SCAN_LINE, tmp);  /* Maximum Scan Line */
+	smi_crtc_write(sinfo->mmio, SMI_SVRx4C_H_DISPLAY_END, (hDisplay/wchar - 1));  /* Horizontal Display End */
+	smi_crtc_write(sinfo->mmio, SMI_SVRx4D_V_DISPLAY_END, ((vDisplay - 1) & 0xff));  /* Vertical Display End */
+
+
+	/**********************************************************************/
+	/* Graphics Controller */
+	smi_graphics_write(sinfo->mmio, SMI_GRx00_SET_RESET, 0x00);
+	smi_graphics_write(sinfo->mmio, SMI_GRx01_EN_SET_RESET, 0x00);
+	smi_graphics_write(sinfo->mmio, SMI_GRx02_COLOR_COMPARE, 0x00);
+	smi_graphics_write(sinfo->mmio, SMI_GRx03_DATA_ROTATE, 0x00);
+	smi_graphics_write(sinfo->mmio, SMI_GRx04_READ_PLANE_SEL, 0x00);
+	smi_graphics_write(sinfo->mmio, SMI_GRx05_MODE, 0x40);  /* Graphics Mode, FIXME: bpp dependant ? */
+	smi_graphics_write(sinfo->mmio, SMI_GRx06_MISC, (0x04 | mode));  /* Graphics Misc */
+	smi_graphics_write(sinfo->mmio, SMI_GRx07_COLOR_DONT_CARE, 0x0f);  /* Color don't care plane */
+	smi_graphics_write(sinfo->mmio, SMI_GRx08_BIT_MASK, 0xff);  /* Bit Mask */
+	
+	
+	/**********************************************************************/
+	/* Attribute Controller */
+	for (tmp = 0; tmp <= 0x0f; tmp++) {
+		smi_attribute_write(sinfo->mmio, SMI_ATTRx_PAL(tmp), tmp);
+	}
+	tmp = ((bpp == 8) ? 0x40 : 0x00);
+	smi_attribute_write(sinfo->mmio, SMI_ATTRx10_MODE, (0x00 | mode | tmp));  /* Attr Mode Ctrl */
+	smi_attribute_write(sinfo->mmio, SMI_ATTRx11_OVERSCAN_COLOR, 0x00);
+	smi_attribute_write(sinfo->mmio, SMI_ATTRx12_COLOR_PLANE_EN, 0x0f);
+	smi_attribute_write(sinfo->mmio, SMI_ATTRx13_H_PIX_PANNING, 0x00);
+	smi_attribute_write(sinfo->mmio, SMI_ATTRx14_COLOR_SELECT, 0x00);
+	
+	
+	/**********************************************************************/
+	/* System Control */
+	smi_ext_sysctrl_write(sinfo->mmio, SMI_SCRx15_PCI_MISC_CTRL, 0x8a);  /* PCI Misc Ctrl */
+	smi_ext_sysctrl_write(sinfo->mmio, SMI_SCRx17_GRAPH_COMMAND_1, 0x22);  /* General Graphics Command 1 */
+	smi_ext_sysctrl_write(sinfo->mmio, SMI_SCRx18_GRAPH_COMMAND_2, 0x11);  /* General Graphics Command 2 */
+	smi_ext_sysctrl_write(sinfo->mmio, SMI_SCRx19_INTR_EN_MASK_1, 0x00);  /* Interrupt Enable and Mask 1 */
+	smi_ext_sysctrl_write(sinfo->mmio, SMI_SCRx1B_INTR_EN_MASK_2, 0x00);  /* Interrupt Enable and Mask 2 */
+	smi_ext_sysctrl_write(sinfo->mmio, SMI_SCRx1F_INTR_MASK_HARD_EN, 0x00);  /* Intr Mask and HW Intr Enable */
+	
+
+	/**********************************************************************/
+	/* Power Down Control */
+	smi_ext_powerctrl_write(sinfo->mmio, SMI_PDRx20_CTRL, 0xc4);  /* Power Down Control */
+	smi_ext_powerctrl_write(sinfo->mmio, SMI_PDRx21_BLOCKS_DISABLE, 0x30);  /* Functionnal Blocks Disable Ctrl */
+	smi_ext_powerctrl_write(sinfo->mmio, SMI_PDRx22_LCD_PANEL_CTRL, 0x02);  /* LCD Panel Control Select */
+	smi_ext_powerctrl_write(sinfo->mmio, SMI_PDRx23_ACT_DETECT, 0x01);  /* Activity Detection Control */
+	smi_ext_powerctrl_write(sinfo->mmio, SMI_PDRx24_REG_SELECT, 0x01);  /* Power Down Register Select */
+	
+	
+	/**********************************************************************/
+	/* Flat Pannel */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRx30_FP_TYPE_SEL, 0xa8);  /* Flat Panel Type Select : TFT */
+	tmp = ((bpp == 8) ? 0x00 : 0x40);
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRx31_VIRT_REFRESH, (0x02 | tmp)); /* Enable CRT */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRx32_DESPE_CTRL, 0x04);
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRx33_POWER_CURSOR_CTRL, 0x05);
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRx34_ON_OFF_SEQ, 0x80);
+	/* Use CRT, not LCD interface */
+	for (tmp = 0x3E; tmp <= 0x5A; tmp++) {
+		smi_ext_flatpanel_write(sinfo->mmio, tmp, 0x00);
+	}
+	/* Panel Video */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxA0_HW_CTRL, 0x00);  /* Panel HW Video Control */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxA1_COLOR_KEY_L, 0x00);  /* Color Key */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxA2_COLOR_KEY_H, 0x00);
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxA3_COLOR_KEY_MASK_L, 0x00);  /* Color Key Mask */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxA4_COLOR_KEY_MASK_H, 0x00);
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxA5_RED_CONST, 0x00);  /* Red Constant */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxA6_GREEN_CONST, 0x00);  /* Green Constant */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxA7_BLUE_CONST, 0x00);  /* Blue Constant */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxA8_TOP_BOUND, 0x00);  /* Top Boundary */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxA9_LEFT_BOUND, 0x00);  /* Left Boundary */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxAA_BOT_BOUND, 0x00);  /* Bottom Boundary */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxAB_RIGHT_BOUND, 0x00);  /* Right Boundary */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxAC_TOP_LEFT_OVER, 0x00);  /* Top and Left Boundary Overflow */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxAD_BOT_RIGHT_OVER, 0x00);  /* Bottom and Right Boundary Overflow */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxAE_V_STRETCH, 0x00);  /* Vertical Stretch Factor */
+	smi_ext_flatpanel_write(sinfo->mmio, SMI_FPRxAF_H_STRETCH, 0x00);  /* horizontal Stretch Factor */
+	
+	
+	/**********************************************************************/
+	/* Memory Control */
+	smi_ext_memctrl_write(sinfo->mmio, SMI_MCRx60_CTRL, 0x01);  /* Memory Ctrl */
+	smi_ext_memctrl_write(sinfo->mmio, SMI_MCRx61_BANK_ADDR_HIGH, 0x00);
+	smi_ext_memctrl_write(sinfo->mmio, SMI_MCRx76_TYPE_TIME_CTRL, 0x3f);  /* Memory Type and Timing Ctrl */
+	
+	
+	/**********************************************************************/
+	/* Clock Control */
+	smi_ext_clkctrl_write(sinfo->mmio, SMI_CCRx65_TV_ENC, 0x00);  /* TV Encoder Control */
+	smi_ext_clkctrl_write(sinfo->mmio, SMI_CCRx66_RAM_CTRL, 0x03);  /* RAM Control and Funcion On/Off */
+	smi_ext_clkctrl_write(sinfo->mmio, SMI_CCRx68_CLK_CTRL_1, 0x50);  /* Clock Control 1 */
+	smi_ext_clkctrl_write(sinfo->mmio, SMI_CCRx69_CLK_CTRL_2, 0x03);  /* Clock Control 2 */
+	smi_ext_clkctrl_write(sinfo->mmio, SMI_CCRx6A_MCLK_NUM, 0x0c);  /* MCLK Numerator */
+	smi_ext_clkctrl_write(sinfo->mmio, SMI_CCRx6B_MCLK_DEN, 0x02);  /* MCLK Denominator */
+	smi_ext_clkctrl_write(sinfo->mmio, SMI_CCRx6C_VCLK_NUM, 0x97);  /* VCLK Numerator */
+	smi_ext_clkctrl_write(sinfo->mmio, SMI_CCRx6D_VCLK_DEN, 0x22);  /* VCLK Denominator */
+	smi_ext_clkctrl_write(sinfo->mmio, SMI_CCRx6E_VCLK2_NUM, 0x09);  /* VCLK2 Numerator */
+	smi_ext_clkctrl_write(sinfo->mmio, SMI_CCRx6F_VCLK2_DEN, 0x02);  /* VCLK2 Denominator */
+	
+	
+	/**********************************************************************/
+	/* General Purpose Regs */
+	for (tmp = 0x70; tmp <= 0x75; tmp++) {
+		smi_ext_gp_write(sinfo->mmio, tmp, 0x00);
+	}
+	
+	/**********************************************************************/
+	/* Pop-up Icon and Hardware Cursor */
+	for (tmp = 0x80; tmp <= 0x93; tmp++) {
+		smi_ext_cursor_write(sinfo->mmio, tmp, 0x00);
+	}
+
+	
+
+	/**********************************************************************/
+	/* 2D and Video Registers */
+
+	printk("smi_set_moderegs, setting up memmory mapped regs\n");
+
+	vpr = (struct vpr_regs*)sinfo->vpr;
+	dpr = (struct dpr_regs*)sinfo->dpr;
+
+	/**********************************************************************/
+	/* Drawing engine Control Regs */
+	out_le16( &(dpr->dpr10_src_pitch), width); /* Source Row Pitch */
+	out_le16( &(dpr->dpr12_dst_pitch), width); /* Destination Row Pitch */
+	out_le32( &(dpr->dpr14_fg), 0x00000000); /* FG color */
+	out_le32( &(dpr->dpr18_bg), 0x00000000); /* BG color */
+	switch (bpp) {
+		case 8: val = 0x00; break;
+		case 16: val = 0x01; break;
+		case 24: val = 0x11; break;
+		case 32: val = 0x10; break;
+		default: printk(KERN_ERR "smifb: error, unsupported bit depth");
+	}
+	out_le16( &(dpr->dpr1E_DE_format_sel), (0x0005 | (val << 4))); /* DE Data and Location Format Sel */
+	out_le32( &(dpr->dpr20_col_compare), 0x00); /* Color Compare */
+	out_le32( &(dpr->dpr24_col_comp_mask), 0xffffffff); /* Color Compare Mask */
+	out_le16( &(dpr->dpr28_bit_mask), 0xffff); /* Bit Mask */
+	out_le16( &(dpr->dpr2A_byte_mask_en), 0xffff); /* Bit Mask */
+	out_le32( &(dpr->dpr34_mono_pat_low), 0x00000000); /* Mono Pattern Low */
+	out_le32( &(dpr->dpr38_mono_pat_high), 0x00000000); /* Mono Pattern High */
+	out_le16( &(dpr->dpr3C_xy_src), width); /* XY Addressing Source Window Width */
+	out_le16( &(dpr->dpr3E_xy_dst), width); /* XY Addressing Destination Window Width */
+	out_le32( &(dpr->dpr40_src_base_addr), 0x00); /* Source Base Address */
+	out_le32( &(dpr->dpr44_dst_base_addr), 0x00); /* Destination Base Address */
+
+
+	/**********************************************************************/
+	/* Video Processor Control Regs */
+	switch (bpp) {
+		case 8: val = VPR00_FMT_8P; break; /* 101 for 8 bit 3-3-2 RGB */
+		case 15: val = VPR00_FMT_15P; break; /* 001 for 15 bit 5-5-5 RGB */
+		case 16: val = VPR00_FMT_16P; break; /* 010 for 16 bit 5-6-5 RGB */
+		case 24: val = VPR00_FMT_24P; break; /* 100 for 24 bit 8-8-8 RGB */
+		case 32: val = VPR00_FMT_32P; break; /* 011 for 32 bit x-8-8-8 RGB */
+		/*FIXME: Needs to support 8bit index and YUV 4:2:2 */
+		default: printk(KERN_ERR "smifb: error, unsupported bit depth");
+	}
+	tmp = ((val << 16) | (val << 8) | (val << 0));
+	out_le32( &(vpr->vpr00_misc), (0x0008 | tmp)); /* Misc Graphics and Video Control : Use Window I */
+	tmp = (width * bpp / 64);
+	out_le32( &(vpr->vpr10_data_width_extgm), (((tmp + 2) << 16) | tmp )); /* Data Src Width and Offset */
+	/* Set up Window I */
+	out_le32( &(vpr->win1.top_left_bound), 0x00); /* Video Win Top Left Bound */
+	out_le32( &(vpr->win1.bot_right_bound), (((height & 0x07ff)<<16)|(width & 0x07ff))); /* Video Win BotRight Bound */
+	out_le32( &(vpr->win1.src_addr), 0x00); /* Video Window Source Start Address */
+	out_le16( &(vpr->win1.src_offset), (width * bpp / 64)); /* Video Window Source Offset */
+	out_le16( &(vpr->win1.src_line_width), (width * bpp / 64)); /* Video Window Source Width */
+	out_le32( &(vpr->win1.stretch), 0x00); /* Video Window Stretch Factor */
+
+	out_le32( &(vpr->vpr54_fifo_prio), 0x07216543); /* FIFO Priority Control */
+	out_le32( &(vpr->vpr58_fifo_req_level), 0x00000444); /* FIFO Empty Request level Control */
+	out_le32( &(vpr->vpr5C_yuv_to_rgb), 0x000000); /* YUV to RGB Conversion Constant */
+
+}
diff --git a/drivers/video/smi/smi_hw.h b/drivers/video/smi/smi_hw.h
new file mode 100644
index 0000000..93599a5
--- /dev/null
+++ b/drivers/video/smi/smi_hw.h
@@ -0,0 +1,672 @@
+/*
+ * drivers/video/smi/smi_hw.h
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * Modifications: Nathael Pajani <nathael.pajani@ed3l.fr>
+ *   Port to linux 2.6.22-rc5 for powerpc based board xcom9347
+ *   with MPC8347E processor and LYNX_3DM+ graphic chip.
+ *   All pages are numbere according to the
+ *   	Lynx3DM+ Databook - Version 0.8 -  Last updated 05/21/02
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __SMI_HW_H__
+#define __SMI_HW_H__
+
+#include "smifb.h"
+
+#define PCI_VENDOR_ID_SMI		0x126f
+#define PCI_DEVICE_ID_SMI_LYNX_3DM	0x0720
+
+
+#define LYNX3DM_DP_BASE_OFFSET		0x000000   /* 2D/3D Port Regs */
+#define LYNX3DM_DPREG_REGION_SIZE	(2*1024)
+#define LYNX3DM_VP_BASE_OFFSET		0x000800   /* Video Port Regs */
+#define LYNX3DM_VPREG_REGION_SIZE	(2*1024)
+#define LYNX3DM_CP_BASE_OFFSET		0x001000   /* Vidcap port Regs */
+#define LYNX3DM_CPREG_REGION_SIZE	(2*1024)
+/* ... There are many others, not supported yet. */
+
+#define LYNX3DM_IO_BASE_OFFSET		0x0c0000   /* Acces to STD VGA Regs and Extended SMI Regs */
+#define LYNX3DM_MMIO_REGION_SIZE	(256*1024)
+
+#define LYNX3DM_DPPORT_BASE_OFFSET	0x100000   /* Acces to Additionnal DE Data Port */
+#define LYNX3DM_DPPORT_REGION_SIZE	(1024*1024)
+
+#define LYNX3DM_FB_BASE_OFFSET		0x200000   /* Frame Buffer Base offset */
+#define LYNX3DM_FB_SIZE			(30*1024*1024)
+
+
+
+/* Display all the register values */
+extern void smi_print_moderegs(struct smifb_info *sinfo);
+
+/* Try to set up the chip's registers according to the given video mode */
+extern void smi_set_moderegs(struct smifb_info *sinfo, struct fb_var_screeninfo *video_mode);
+
+
+struct dpr_regs {
+	uint16_t dpr00_src_y;          /* 0x00 Source Y or K2 */
+	uint16_t dpr02_src_x;          /* 0x02 Source X or K1 */
+	uint16_t dpr04_dst_y;          /* 0x04 Destination Y or Start Y */
+	uint16_t dpr06_dst_x;          /* 0x06 Destination X or Start X */
+	uint16_t dpr08_dim_y;          /* 0x08 Dimension Y or Error Term */
+	uint16_t dpr0A_dim_x;          /* 0x0A Dimension X or Vector Length */
+	uint16_t dpr0C_ROP_misc_ctrl;  /* 0x0C ROP and Misc Control */
+	uint16_t dpr0E_DE_cmd_ctrl;    /* 0x0E Drawing Engine Commands and Control */
+	uint16_t dpr10_src_pitch;      /* 0x10 Source Row Pitch */
+	uint16_t dpr12_dst_pitch;      /* 0x12 Destination Row Pitch */
+                                              
+	uint32_t dpr14_fg;             /* 0x14 FG color */
+	uint32_t dpr18_bg;             /* 0x18 BG color */
+                                              
+	uint16_t dpr1C_stretch_y;      /* 0x1C Stretch Source Height Y */
+	uint16_t dpr1E_DE_format_sel;  /* 0x1E Drawing Engine DataFormat and Location Format Select */
+                                              
+	uint32_t dpr20_col_compare;    /* 0x20 Color Compare */
+	uint32_t dpr24_col_comp_mask;  /* 0x24 Color Compare Mask */
+                                              
+	uint16_t dpr28_bit_mask;       /* 0x28 Bit Mask */
+	uint16_t dpr2A_byte_mask_en;   /* 0x2A Byte Mask Enable */
+	uint16_t dpr2C_scisors_left;   /* 0x2C Scisors Left and Control */
+	uint16_t dpr2E_scisors_top;    /* 0x2E Scisors Top */
+	uint16_t dpr30_scisors_right;  /* 0x30 Scisors Right */
+	uint16_t dpr32_scisors_bot;    /* 0x32 Scisors Bottom */
+                                              
+	uint32_t dpr34_mono_pat_low;   /* 0x34 Mono Pattern Low */
+	uint32_t dpr38_mono_pat_high;  /* 0x38 Mono Pattern High */
+	uint16_t dpr3C_xy_src;         /* 0x3C XY Addressing Source Window Width */
+	uint16_t dpr3E_xy_dst;         /* 0x3E XY Addressing Destination Window Width */
+	uint32_t dpr40_src_base_addr;  /* 0x40 Source Base Address */
+	uint32_t dpr44_dst_base_addr;  /* 0x44 Destination Base Address */
+} __attribute__ ((packed));
+
+/* video window formats - I=indexed, P=packed */
+#define VPR00_FMT_8I          0x00
+#define VPR00_FMT_15P         0x01
+#define VPR00_FMT_16P         0x02
+#define VPR00_FMT_32P         0x03
+#define VPR00_FMT_24P         0x04
+#define VPR00_FMT_8P          0x05
+#define VPR00_FMT_YUV422      0x06
+#define VPR00_FMT_YUV420      0x07
+
+struct vpr_window {
+	uint32_t top_left_bound;   /* Video Window Top Left Boundary */
+	uint32_t bot_right_bound;      /* Video Window Bottom Right Boundary */
+	uint32_t src_addr;         /* Video Window Source Start Address */
+	uint16_t src_offset;       /* Video Window Source Offset */
+	uint16_t src_line_width;   /* Video Window Source Line Width */
+	uint32_t stretch;          /* Video Window Stretch Factor */
+} __attribute__ ((packed));
+	
+struct vpr_regs {
+	uint32_t vpr00_misc;               /* 0x00 Miscellaneous Graphics and Video Control */
+
+	uint32_t vpr04_col_key;            /* 0x04 Color Keys */
+	uint32_t vpr08_col_masks;          /* 0x08 Color Key Masks */
+
+	uint32_t vpr0C_data_addr_extgm;    /* 0x0C Data Source Start Address for Extended Graphics Modes */
+	uint32_t vpr10_data_width_extgm;   /* 0x10 Data Source Width and Offset for Extended Graphics Modes */
+
+	struct vpr_window win1;            /* 0x14 - 0x24 */
+	struct vpr_window win2;            /* 0x28 - 0x38 */
+
+	uint32_t vpr3C_gv_ctrl2;           /* 0x3C Graphics and Video Controll II */
+	uint32_t vpr40_scale;              /* 0x40 Graphic Scale Factor */
+	uint32_t vpr44_data_src_addr;      /* 0x44 */
+	uint32_t vpr48_win1_chroma_addr;   /* 0x48 */
+	uint32_t vpr4C_win2_chroma_addr;   /* 0x4C */
+	uint32_t vpr50_sub_pic_src_addr;   /* 0x50 */
+	uint32_t vpr54_fifo_prio;          /* 0x54 FIFO Priority Control */
+	uint32_t vpr58_fifo_req_level;     /* 0x58 FIFO Empty Request level Control */
+	uint32_t vpr5C_yuv_to_rgb;         /* 0x5C YUV to RGB Conversion Constant */
+	uint32_t vpr60_read_scan_line;     /* 0x60 Current Scan Line Position */
+	uint32_t vpr64_signature_cs;       /* 0x64 Signature Analyzer Control and Status */
+	uint32_t empty1[2];
+	uint32_t vpr_subpic_color[16];     /* 0x70 - 0xAC Sub Picture Color Look Up Register 0 to F */
+	uint32_t vprB0_subpic_topleft;     /* 0xB0 Sub Picture Top/Left Boundary */
+	uint32_t vprB4_subpic_botright;    /* 0xB4 Sub Picture Bottom/Right Boundary */
+	uint32_t vprB8_subpic_src_addr;    /* 0xB8 Sub Picture Source Data Address Offset and Line Width */
+	uint32_t empty2[1];
+	uint32_t vprC0_win1_uv_scale;      /* 0xC0 Video Window 1 U/V Scale Factor */
+	uint32_t vprC4_win2_scale;         /* 0xC4 Video Window 2 Scale Factor */
+} __attribute__ ((packed));
+
+struct cpr_regs {
+	uint32_t cpr00_cp_ctrl;        /* 0x00 Capture Port Control */
+	uint16_t cpr04_src_topclip;    /* 0x04 Video Source Clipping Control */
+	uint16_t cpr06_src_leftclip;   /* 0x06 Video Source Clipping Control */
+	uint16_t cpr08_cap_height;     /* 0x08 Video Source Capture Size Control */
+	uint16_t cpr0A_cap_width;      /* 0x0A Video Source Capture Size Control */
+	uint32_t cpr0C_buff1_start;    /* 0x0C Capture Port Buffer 1 Source Start Address */
+	uint32_t cpr10_buff2_start;    /* 0x10 Capture Port Buffer 2 Source Start Address */
+	uint32_t cpr14_src_off_addr;   /* 0x14 Capture Port Source Offset Address */
+	uint32_t cpr18_fifo_req_lvl;   /* 0x18 Capture FIFO Empty Request Level Control */
+} __attribute__ ((packed));
+
+
+
+#define MMIO_OUT8(p, r, d)	(((volatile uint8_t *)(p))[r] = (d))
+#define MMIO_IN8(p, r)		(((volatile uint8_t *)(p))[(r)])
+
+static inline uint8_t VGA_READ8(uint8_t* base, unsigned int reg)
+{
+	return MMIO_IN8(base, reg);
+}
+
+static inline void VGA_WRITE8(uint8_t* base, unsigned int reg, uint8_t data)
+{
+	MMIO_OUT8(base, reg, data);
+}
+
+
+#define SMI_USE_TEXT   0x00
+#define SMI_USE_GRAPH  0x01
+
+
+/**********************************************************/
+/*        PCI IO mapped registers offsets                 */
+/*  NOTE :                                                */
+/* monochrome emulation = 3Bx, color emulation = 3Dx      */
+/*                                                        */
+/**********************************************************/
+
+/* Misc register ******************************************/
+#define SMI_MISC_RD     0x3cc   /* Misc (read address) */
+#define SMI_MISC_WR     0x3c2   /* misc (write address) */
+#define SMI_MISC_COLOR_MODE      0x01 /* 0 = monochrome and acces of 3?x regs at 3Bx (hex) */
+                                      /* 1 = color      and acces of 3?x regs at 3Dx (hex) */
+#define SMI_MISC_ENABLE_WRITE    0x02 /* Enable Video RAM access from CPU */
+
+static inline uint8_t smi_vga_misc_read(uint8_t* base)
+{
+	return VGA_READ8(base, SMI_MISC_RD);
+}
+static inline void smi_vga_misc_write(uint8_t* base, uint8_t val)
+{
+	BUG_ON( !(val & SMI_MISC_COLOR_MODE) ); /* See NOTE, offsets defined using color mode */
+	VGA_WRITE8(base, SMI_MISC_WR, val);
+}
+
+/* Input status register ******************************************/
+#define SMI_ISR0_RD     0x3c2   /* Input status reg 0 (rd only) */
+#define SMI_ISR1_RD     0x3da   /* Input status reg 1 (rd only) */ 
+static inline uint8_t smi_status0_read(uint8_t* base)
+{
+	return VGA_READ8(base, SMI_ISR0_RD);
+}
+static inline uint8_t smi_status1_read(uint8_t* base)
+{
+	return VGA_READ8(base, SMI_ISR1_RD);
+}
+
+/* Extended regs write protect register ******************************************/
+#define SMI_LOCK_REG    0x3c3   /* unlock/lock ext crt reg */
+#define SMI_LOCK_REG_PROTECT 0xA0
+#define SMI_LOCK_REG_WRITE_EN 0x40
+static inline void smi_unlock_extended_regs(uint8_t* base)
+{
+	VGA_WRITE8(base, SMI_LOCK_REG, SMI_LOCK_REG_WRITE_EN);
+}
+static inline void smi_lock_extended_regs(uint8_t* base)
+{
+	VGA_WRITE8(base, SMI_LOCK_REG, SMI_LOCK_REG_PROTECT);
+}
+
+/* Feature Control register ******************************************/
+#define SMI_FCR_RD      0x3ca   /* Feature control register (read) */
+#define SMI_FCR_WR      0x3da   /* Feature control register (write) */
+static inline uint8_t smi_feature_ctrl_read(uint8_t* base)
+{
+	return VGA_READ8(base, SMI_FCR_RD);
+}
+static inline void smi_feature_ctrl_write(uint8_t* base, uint8_t val)
+{
+	VGA_WRITE8(base, SMI_FCR_WR, val);
+}
+
+
+/* RAMDAC Registers *****************************************/
+#define SMI_DAC_MASK    0x3c6   /* DAC mask register */
+#define SMI_DAC_RD_ADDR 0x3c7   /* DAC address read register (write only)*/
+#define SMI_DAC_STATUS  0x3c7   /* DAC status register (read only)*/
+#define SMI_DAC_WR_ADDR 0x3c8   /* DAC address write register */
+#define SMI_DAC_DATA    0x3c9   /* DAC data register.*/
+/* FIXME add support for RAMDAC */
+
+
+
+
+/**********************************************************************/
+/* Standard VGA registers */
+/**********************************************************************/
+
+/**********************************************************************/
+/* Sequencer */
+#define SMI_SEQ_INDEX   0x3c4   /* Sequencer index reg */
+#define SMI_SEQ_DATA    0x3c5   /* Sequencer data reg */
+
+#define SMI_SEQx00_RESET          0x00  /* Reset */
+#define SMI_SEQx01_CLK_MODE       0x01  /* Clocking Mode */
+#define SMI_SEQx02_EN_WR_PLANE    0x02  /* Enable Write Plane */
+#define SMI_SEQx03_CHAR_MAP_SEL   0x03  /* Character Map Select */
+#define SMI_SEQx04_MEM_MODE       0x04  /* Memory Mode */
+#define SMI_SEQX_MAX  0x04
+
+static inline uint8_t smi_sequencer_read(uint8_t * base, uint8_t index)
+{
+	BUG_ON( index > SMI_SEQX_MAX );
+	VGA_WRITE8(base, SMI_SEQ_INDEX, index);
+	return VGA_READ8(base, SMI_SEQ_DATA);
+}
+static inline void smi_sequencer_write(uint8_t * base, uint8_t index, uint8_t data)
+{
+	BUG_ON( index > SMI_SEQX_MAX );
+	VGA_WRITE8(base, SMI_SEQ_INDEX, index);
+	VGA_WRITE8(base, SMI_SEQ_DATA, data);
+}
+
+
+/**********************************************************************/
+/* CRTC Controller */
+#define SMI_CRT_INDEX  0x3d4   /* CRTC controller index reg */
+#define SMI_CRT_DATA   0x3d5   /* CRTC controller data reg */
+
+#define SMI_CRTx00_H_TOTAL           0x00  /* Horizontal Total */
+#define SMI_CRTx01_H_DISPLAY_END     0x01  /* Horizontal Display End */
+#define SMI_CRTx02_H_BLANK_START     0x02  /* Horizontal Blank Start */
+#define SMI_CRTx03_H_BLANK_END       0x03  /* Horizontal Blank End */
+#define SMI_CRTx04_H_SYNC_START      0x04  /* Horizontal Sync Pulse Start */
+#define SMI_CRTx05_H_SYNC_END        0x05  /* Horizontal Sync Pulse End */
+
+#define SMI_CRTx06_V_TOTAL           0x06  /* Vertical Total */
+#define SMI_CRTx12_V_DISPLAY_END     0x12  /* Vertical Display End */
+#define SMI_CRTx15_V_BLANK_START     0x15  /* Vertical Blank Start */
+#define SMI_CRTx16_V_BLANK_END       0x16  /* Vertical Blank End */
+#define SMI_CRTx10_V_SYNC_START      0x10  /* Vertical Sync Pulse Start */
+#define SMI_CRTx11_V_SYNC_END        0x11  /* Vertical Sync Pulse End */
+
+#define SMI_CRTx07_OVERFLOW_VERT     0x07  /* Overflow Vertical */
+#define SMI_CRTx08_PRESET_ROW_SCAN   0x08  /* Preset Row Scan */
+#define SMI_CRTx09_MAX_SCAN_LINE     0x09  /* Maximum Scan Line */
+#define SMI_CRTx0C_DISP_START_ADDR_H 0x0C  /* Display Start Address High */
+#define SMI_CRTx0D_DISP_START_ADDR_L 0x0D  /* Display Start Address Low */
+#define SMI_CRTx0A_CURSOR_START      0x0A  /* Cursor Start Scan Line */
+#define SMI_CRTx0B_CURSOR_END        0x0B  /* Cursor End Scan Line */
+#define SMI_CRTx0E_CURSOR_ADDR_H     0x0E  /* Cursor Start Address High */
+#define SMI_CRTx0F_CURSOR_ADDR_L     0x0F  /* Cursor Start Address Low */
+#define SMI_CRTx13_OFFSET            0x13  /* Offset */
+#define SMI_CRTx14_UNDERLINE_LOC     0x14  /* Underline Location */
+#define SMI_CRTx17_MODE_CTRL         0x17  /* CRT Mode Control */
+#define SMI_CRTx18_LINE_COMPARE      0x18  /* Line Compare */
+
+#define SMI_CRTx22_GRAPH_DATA_READBACK    0x22  /* Graphics Controller Data Latches Readback */
+#define SMI_CRTx24_ATTR_TOGGLE_READBACK   0x24  /* Attribute Controller Toggle Readback */
+#define SMI_CRTx26_ATTR_INDEX_READBACK    0x26  /* Attribute Controller Index Readback */
+
+/* Extended SMI CRT */
+#define SMI_CRTx30_MODE_EN           0x30  /* CRTC Overflow and Interlace Mode Enable */
+#define SMI_CRTx31_INTL_RETRACE      0x31  /* Interlace Retrace */
+#define SMI_CRTx32_TV_V_START        0x32  /* TV Vertical Display Enable Start */
+#define SMI_CRTx33_TV_V_END_H        0x33  /* TV Vertical Display Enable End High */
+#define SMI_CRTx34_TV_V_END_L        0x34  /* TV Vertical Display Enable End Low */
+#define SMI_CRTx35_V_EXP_CONST_L     0x35  /* Vertical Screen Expansion DDA Control Constant Low */
+#define SMI_CRTx36_V_EXP_CONST_H     0x36  /* Vertical Screen Expansion DDA Control Constant High */
+#define SMI_CRTx37_TEST_SEL          0x37  /* Hardware/VGA Test Selection */
+#define SMI_CRTx38_TV_EQ_PULSE       0x38  /* TV Equalization Pulse Control */
+#define SMI_CRTx39_TV_SER_PULSE      0x39  /* TV Serration Pulse Control */
+#define SMI_CRTx3A_TV_TIMING         0x3A  /* TV Total Timing Control for the Internal TV Encoder */
+#define SMI_CRTx3B_MISC_LOCK_1       0x3B  /* Miscellaneous Lock 1 */
+#define SMI_CRTx3C_MISC_LOCK_2       0x3C  /* Miscellaneous Lock 2 */
+#define SMI_CRTx3D_SCRATCH_BITS      0x3D  /* Scratch Register Bits */
+#define SMI_CRTx3E_SCRATCH_BITS      0x3E  /* Scratch Register Bits FIXME, said to be 3?4 in doc */
+#define SMI_CRTx3F_SCRATCH_BITS      0x3F  /* Scratch Register Bits FIXME, said to be 3?4 in doc */
+/* CRTx9E - CRTxAD  :  Screen Centering - Not supported Yet */
+
+/* Extended SMI Shadow -- Use with caution... read Documentation for this when using both CRT and TV */
+#define SMI_SVRx40_H_TOTAL           0x40  /* Shadow VGA Horizontal Total */
+#define SMI_SVRx41_H_BLANK_START     0x41  /* Shadow VGA Horizontal Blank Start */
+#define SMI_SVRx42_H_BLANK_END       0x42  /* Shadow VGA Horizontal Blank End */
+#define SMI_SVRx43_H_RETRACE_START   0x43  /* Shadow VGA Horizontal Retrace Start */
+#define SMI_SVRx44_H_RETRACE_END     0x44  /* Shadow VGA Horizontal Retrace End */
+#define SMI_SVRx45_V_TOTAL           0x45  /* Shadow VGA Vertical Total */
+#define SMI_SVRx46_V_BLANK_START     0x46  /* Shadow VGA Vertical Blank End */
+#define SMI_SVRx47_V_BLANK_END       0x47  /* Shadow VGA Vertical Blank End */
+#define SMI_SVRx48_V_RETRACE_START   0x48  /* Shadow VGA Vertical Retrace Start */
+#define SMI_SVRx49_V_RETRACE_END     0x49  /* Shadow VGA Vertical Retrace End */
+#define SMI_SVRx4A_V_OVERFLOW        0x4A  /* Shadow VGA Vertical Overflow */
+#define SMI_SVRx4B_MAX_SCAN_LINE     0x4B  /* Shadow VGA Maximum Scan Line */
+#define SMI_SVRx4C_H_DISPLAY_END     0x4C  /* Shadow VGA Horizontal Display End */
+#define SMI_SVRx4D_V_DISPLAY_END     0x4D  /* Shadow VGA Vertical Display End */
+#define SMI_CRTX_MAX  0x4D
+
+static inline uint8_t smi_crtc_read(uint8_t * base, uint8_t index)
+{
+	BUG_ON( index > SMI_CRTX_MAX );
+	VGA_WRITE8(base, SMI_CRT_INDEX, index);
+	return VGA_READ8(base, SMI_CRT_DATA);
+}
+static inline void smi_crtc_write(uint8_t * base, uint8_t index, uint8_t data)
+{
+	BUG_ON( index > SMI_CRTX_MAX );
+	VGA_WRITE8(base, SMI_CRT_INDEX, index);
+	VGA_WRITE8(base, SMI_CRT_DATA, data);
+}
+
+
+/**********************************************************************/
+/* Graphics Controller */
+#define SMI_GR_INDEX   0x3ce   /* Graphic controller index reg */
+#define SMI_GR_DATA    0x3cf   /* Graphic controller data reg */
+
+#define SMI_GRx00_SET_RESET         0x00  /* Set/Reset */
+#define SMI_GRx01_EN_SET_RESET      0x01  /* Enable Set/Reset */
+#define SMI_GRx02_COLOR_COMPARE     0x02  /* Color Compare */
+#define SMI_GRx03_DATA_ROTATE       0x03  /* Data Rotate */
+#define SMI_GRx04_READ_PLANE_SEL    0x04  /* Read Plane Select */
+#define SMI_GRx05_MODE              0x05  /* Graphics Mode */
+#define SMI_GRx06_MISC              0x06  /* Graphics Misc */
+#define SMI_GRx07_COLOR_DONT_CARE   0x07  /* Color don't care plane */
+#define SMI_GRx08_BIT_MASK          0x08  /* Bit Mask */
+#define SMI_GRX_MAX  0x08
+
+static inline uint8_t smi_graphics_read(uint8_t * base, uint8_t index)
+{
+	BUG_ON( index > SMI_GRX_MAX );
+	VGA_WRITE8(base, SMI_GR_INDEX, index);
+	return VGA_READ8(base, SMI_GR_DATA);
+}
+
+static inline void smi_graphics_write(uint8_t * base, uint8_t index, uint8_t data)
+{
+	BUG_ON( index > SMI_GRX_MAX );
+	VGA_WRITE8(base, SMI_GR_INDEX, index);
+	VGA_WRITE8(base, SMI_GR_DATA, data);
+}
+
+
+
+/**********************************************************************/
+/* Attribute Controller */
+#define SMI_ATTR_INDEX  0x3c0   /* attributes index reg */
+#define SMI_ATTR_DATA   0x3c1   /* attributes read data reg */
+#define SMI_ATTR_FLIP_FLOP 0x3da  /* flip-flop */
+
+#define SMI_ATTRx_PAL(x)            (0x00 + (x))  /* Palette */
+#define SMI_ATTRx10_MODE              0x10  /* Attribute Mode Control */
+#define SMI_ATTRx11_OVERSCAN_COLOR    0x11  /* Overscan Color */
+#define SMI_ATTRx12_COLOR_PLANE_EN    0x12  /* Color Plane Enable */
+#define SMI_ATTRx13_H_PIX_PANNING     0x13  /* Horizontal Pixel Panning */
+#define SMI_ATTRx14_COLOR_SELECT      0x14  /* Color Select */
+#define SMI_ATTRX_MAX  0x14
+
+static inline uint8_t smi_attribute_read(uint8_t * base, uint8_t index)
+{
+	BUG_ON( index > SMI_ATTRX_MAX );
+	(void)VGA_READ8(base, SMI_ATTR_FLIP_FLOP);   /* reset flip-flop */
+	VGA_WRITE8(base, SMI_ATTR_INDEX, index);
+	return VGA_READ8(base, SMI_ATTR_DATA);
+}
+
+static inline void smi_attribute_write(uint8_t * base, uint8_t index, uint8_t data)
+{
+	BUG_ON( index > SMI_ATTRX_MAX );
+	(void)VGA_READ8(base, SMI_ATTR_FLIP_FLOP);   /* reset flip-flop */
+	VGA_WRITE8(base, SMI_ATTR_INDEX, index);
+	VGA_WRITE8(base, SMI_ATTR_DATA, data);
+}
+
+
+
+
+/**********************************************************************/
+/* Extended SMI registers */
+/**********************************************************************/
+
+#define SMI_EXT_INDEX   0x3c4   /* SMI Extended registers index reg */
+#define SMI_EXT_DATA    0x3c5   /* SMI Extended registers data reg */
+
+/**********************************************************************/
+/* System Control */
+#define SMI_SCRX_MIN  0x15
+#define SMI_SCRx15_PCI_MISC_CTRL      0x15  /* PCI Miscellaneous Control */
+#define SMI_SCRx16_DE_VP_STATUS       0x16  /* Status for Drawing Engine and Video Processor */
+#define SMI_SCRx17_GRAPH_COMMAND_1    0x17  /* General Graphics Command Register 1 */
+#define SMI_SCRx18_GRAPH_COMMAND_2    0x18  /* General Graphics Command Register 2 */
+#define SMI_SCRx19_INTR_EN_MASK_1     0x19  /* Interrupt Enable and Mask 1 */
+#define SMI_SCRx1A_INTR_STATUS_1      0x1A  /* Interrupt Status */
+#define SMI_SCRx1B_INTR_EN_MASK_2     0x1B  /* Interrupt Enable and Mask 2 */
+#define SMI_SCRx1C_INTR_STATUS_2      0x1C  /* Interrupt Status */
+#define SMI_SCRx1F_INTR_MASK_HARD_EN  0x1F  /* Interrupt Mask and Hardware Interrupt Enable */
+#define SMI_SCRX_MAX  0x1F
+
+static inline uint8_t smi_ext_sysctrl_read(uint8_t * base, uint8_t index)
+{
+	BUG_ON( (index < SMI_SCRX_MIN) || (index > SMI_SCRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	return VGA_READ8(base, SMI_EXT_DATA);
+}
+static inline void smi_ext_sysctrl_write(uint8_t * base, uint8_t index, uint8_t data)
+{
+	BUG_ON( (index < SMI_SCRX_MIN) || (index > SMI_SCRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	VGA_WRITE8(base, SMI_EXT_DATA, data);
+}
+
+/**********************************************************************/
+/* Power Down Control */
+#define SMI_PDRX_MIN  0x20
+#define SMI_PDRx20_CTRL               0x20  /* Power Down Control for Memory, Flat Panel, PLL, and Video Port */
+#define SMI_PDRx21_BLOCKS_DISABLE     0x21  /* Functionnal Blocks Disable Control */
+#define SMI_PDRx22_LCD_PANEL_CTRL     0x22  /* LCD Panel Control Select */
+#define SMI_PDRx23_ACT_DETECT         0x23  /* Activity Detection Control */
+#define SMI_PDRx24_REG_SELECT         0x24  /* Power Down Register Select */
+#define SMI_PDRX_MAX  0x24
+
+static inline uint8_t smi_ext_powerctrl_read(uint8_t * base, uint8_t index)
+{
+	BUG_ON( (index < SMI_PDRX_MIN) || (index > SMI_PDRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	return VGA_READ8(base, SMI_EXT_DATA);
+}
+static inline void smi_ext_powerctrl_write(uint8_t * base, uint8_t index, uint8_t data)
+{
+	BUG_ON( (index < SMI_PDRX_MIN) || (index > SMI_PDRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	VGA_WRITE8(base, SMI_EXT_DATA, data);
+}
+
+/**********************************************************************/
+/* Flat Pannel */
+#define SMI_FPRX_MIN  0x30
+#define SMI_FPRx30_FP_TYPE_SEL        0x30  /* Flat Panel Type Select */
+#define SMI_FPRx31_VIRT_REFRESH       0x31  /* Virtual Refresh and Auto Shut Down Control */
+#define SMI_FPRx32_DESPE_CTRL         0x32  /* Dithering Engine Select, Polarity, and Expansion Control */
+#define SMI_FPRx33_POWER_CURSOR_CTRL  0x33  /* Panel Power Sequence and LCD Character/Cursor Blink Control */
+#define SMI_FPRx34_ON_OFF_SEQ         0x34  /* LCD Panel ON/OFF Sequence Select and DSTN LCD Control */
+
+#define SMI_FPRx3E_PANEL_HEIGHT_H     0x3E  /* DSTN LCD Panel Height - High */
+#define SMI_FPRx3F_PANEL_HEIGHT_L     0x3F  /* DSTN LCD Panel Height - Low  */
+
+#define SMI_FPRx40_RFIFO1_ADDR_L      0x40  /* Read FIFO1 Start Address Low for LCD Frame Buffer */
+#define SMI_FPRx41_RFIFO1_ADDR_H      0x41  /* Read FIFO1 Start Address High for LCD Frame Buffer */
+#define SMI_FPRx42_RFIFO2_ADDR_L      0x42  /* Read FIFO2 Start Address Low for LCD Frame Buffer */
+#define SMI_FPRx43_RFIFO2_ADDR_H      0x43  /* Read FIFO2 Start Address High for LCD Frame Buffer */
+#define SMI_FPRx44_RFIFO1_OFFSET      0x44  /* Read FIFO1 Offset Value of LCD Frame Buffer */
+#define SMI_FPRx45_RFIFO1_OVER_ADDR   0x45  /* Read FIFO1 Address Offset for LCD Frame Buffer Overflow */
+#define SMI_FPRx46_W_ADDR_L           0x46  /* Write Start Address Low of LCD Frame Buffer */
+#define SMI_FPRx47_W_ADDR_H           0x47  /* Write Start Address High of LCD Frame Buffer */
+#define SMI_FPRx48_W_OFFSET           0x48  /* Write Offset Value of LCD Frame Buffer */
+#define SMI_FPRx49_W_OVERFLOW         0x49  /* LCD Frame Buffer Write Overflow */
+#define SMI_FPRx4A_RW_REQ_LEVEL       0x4A  /* LCD Read and Write FIFOs Request Level Control */
+#define SMI_FPRx4B_RFIFO2_OFFSET      0x4B  /* Read FIFO2 Offset Value of LCD Frame Buffer */
+#define SMI_FPRx4C_RFIFO2_OVER_ADDR   0x4C  /* Read FIFO Offset Value of LCD Frame Buffer Overflow */
+#define SMI_FPRx4D_FIFO_MSB           0x4D  /* MSB Read FIFO Address */
+#define SMI_FPRx4E_LCD2_CTRL          0x4E  /* LCD2 Control Register */
+
+#define SMI_FPRx50_VR_OVERFLOW_1      0x50  /* LCD Overflow Register 1 for Virtual Refresh */
+#define SMI_FPRx51_VR_OVERFLOW_2      0x51  /* LCD Overflow Register 2 for Virtual Refresh */
+#define SMI_FPRx52_VR_H_TOTAL         0x52  /* LCD horizontal Total for Virtual Refresh */
+#define SMI_FPRx53_VR_H_DISP_EN       0x53  /* LCD horizontal Display Enable for Virtual Refresh */
+#define SMI_FPRx54_VR_H_SYNC_START    0x54  /* LCD horizontal Sync Start for Virtual Refresh */
+#define SMI_FPRx55_VR_V_TOTAL         0x55  /* LCD Vertical Total for Virtual Refresh */
+#define SMI_FPRx56_VR_V_DISP_EN       0x56  /* LCD Vertical Display Enable for Virtual Refresh */
+#define SMI_FPRx57_VR_V_SYNC_START    0x57  /* LCD Vertical Sync Start for Virtual Refresh */
+#define SMI_FPRx58_EMI_CTRL           0x58  /* EMI Control Register */
+#define SMI_FPRx59_M_SIGNAL           0x59  /* Panel M-Signal Control Register */
+#define SMI_FPRx5A_SYNC_PULSE_WIDTH   0x5A  /* SYNC Pulse-widths Adjustment */
+
+#define SMI_FPRxA0_HW_CTRL            0xA0  /* Panel HW Video Control */
+#define SMI_FPRxA1_COLOR_KEY_L        0xA1  /* Panel Video Color Key Low */
+#define SMI_FPRxA2_COLOR_KEY_H        0xA2  /* Panel Video Color Key High */
+#define SMI_FPRxA3_COLOR_KEY_MASK_L   0xA3  /* Panel Video Color Key Mask Low */
+#define SMI_FPRxA4_COLOR_KEY_MASK_H   0xA4  /* Panel Video Color Key Mask High */
+#define SMI_FPRxA5_RED_CONST          0xA5  /* Panel Video Red Constant */
+#define SMI_FPRxA6_GREEN_CONST        0xA6  /* Panel Video Green Constant */
+#define SMI_FPRxA7_BLUE_CONST         0xA7  /* Panel Video Blue Constant */
+#define SMI_FPRxA8_TOP_BOUND          0xA8  /* Panel Video Top Boundary */
+#define SMI_FPRxA9_LEFT_BOUND         0xA9  /* Panel Video Left Boundary */
+#define SMI_FPRxAA_BOT_BOUND          0xAA  /* Panel Video Bottom Boundary */
+#define SMI_FPRxAB_RIGHT_BOUND        0xAB  /* Panel Video Right Boundary */
+#define SMI_FPRxAC_TOP_LEFT_OVER      0xAC  /* Panel Video Top and Left Boundary Overflow */
+#define SMI_FPRxAD_BOT_RIGHT_OVER     0xAD  /* Panel Video Bottom and Right Boundary Overflow */
+#define SMI_FPRxAE_V_STRETCH          0xAE  /* Panel Video Vertical Stretch Factor */
+#define SMI_FPRxAF_H_STRETCH          0xAF  /* Panel Video horizontal Stretch Factor */
+#define SMI_FPRX_MAX  0xAF
+
+static inline uint8_t smi_ext_flatpanel_read(uint8_t * base, uint8_t index)
+{
+	BUG_ON( (index < SMI_FPRX_MIN) || (index > SMI_FPRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	return VGA_READ8(base, SMI_EXT_DATA);
+}
+static inline void smi_ext_flatpanel_write(uint8_t * base, uint8_t index, uint8_t data)
+{
+	BUG_ON( (index < SMI_FPRX_MIN) || (index > SMI_FPRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	VGA_WRITE8(base, SMI_EXT_DATA, data);
+}
+
+/**********************************************************************/
+/* Memory Control */
+#define SMI_MCRX_MIN  0x60
+#define SMI_MCRx60_CTRL               0x60  /* Memory Control */
+#define SMI_MCRx61_BANK_ADDR_HIGH     0x61  /* Memory Bank Address High */
+#define SMI_MCRx76_TYPE_TIME_CTRL     0x76  /* Memory Type and Timing Control */
+#define SMI_MCRX_MAX  0x76
+
+static inline uint8_t smi_ext_memctrl_read(uint8_t * base, uint8_t index)
+{
+	BUG_ON( (index < SMI_MCRX_MIN) || (index > SMI_MCRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	return VGA_READ8(base, SMI_EXT_DATA);
+}
+static inline void smi_ext_memctrl_write(uint8_t * base, uint8_t index, uint8_t data)
+{
+	BUG_ON( (index < SMI_MCRX_MIN) || (index > SMI_MCRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	VGA_WRITE8(base, SMI_EXT_DATA, data);
+}
+
+/**********************************************************************/
+/* Clock Control */
+#define SMI_CCRX_MIN  0x65
+#define SMI_CCRx65_TV_ENC             0x65  /* TV Encoder Control */
+#define SMI_CCRx66_RAM_CTRL           0x66  /* RAM Control and Funcion On/Off */
+/* SMI_CCRx67 is for test purpose only */
+#define SMI_CCRx68_CLK_CTRL_1         0x68  /* Clock Control 1 */
+#define SMI_CCRx69_CLK_CTRL_2         0x69  /* Clock Control 2 */
+#define SMI_CCRx6A_MCLK_NUM           0x6A  /* MCLK Numerator */
+#define SMI_CCRx6B_MCLK_DEN           0x6B  /* MCLK Denominator */
+#define SMI_CCRx6C_VCLK_NUM           0x6C  /* VCLK Numerator */
+#define SMI_CCRx6D_VCLK_DEN           0x6D  /* VCLK Denominator */
+#define SMI_CCRx6E_VCLK2_NUM          0x6E  /* VCLK2 Numerator */
+#define SMI_CCRx6F_VCLK2_DEN          0x6F  /* VCLK2 Denominator */
+/* SMI_CCRx7A - SMI_CCRx7C are for TV and RAMDAC Testing Power */
+/* SMI_CCRx7D is for TV and RAMDAC Testing */
+#define SMI_CCRX_MAX  0x6F
+
+static inline uint8_t smi_ext_clkctrl_read(uint8_t * base, uint8_t index)
+{
+	BUG_ON( (index < SMI_CCRX_MIN) || (index > SMI_CCRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	return VGA_READ8(base, SMI_EXT_DATA);
+}
+static inline void smi_ext_clkctrl_write(uint8_t * base, uint8_t index, uint8_t data)
+{
+	BUG_ON( (index < SMI_CCRX_MIN) || (index > SMI_CCRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	VGA_WRITE8(base, SMI_EXT_DATA, data);
+}
+
+/**********************************************************************/
+/* General Purpose Regs */
+#define SMI_GPRX_MIN  0x70
+#define SMI_GPRx70_SCRATCH_1          0x70  /* Scratch Pad Register 1 */
+#define SMI_GPRx71_SCRATCH_2          0x71  /* Scratch Pad Register 2 */
+#define SMI_GPRx72_USER_1             0x72  /* User Defined Register 1 for DDC2/I2C */
+#define SMI_GPRx73_USER_2             0x73  /* User Defined Register 2 */
+#define SMI_GPRx74_SCRATCH_3          0x74  /* Scratch Pad Register 3 */
+#define SMI_GPRx75_SCRATCH_4          0x75  /* Scratch Pad Register 4 */
+#define SMI_GPRX_MAX 0x75
+
+static inline uint8_t smi_ext_gp_read(uint8_t * base, uint8_t index)
+{
+	BUG_ON( (index < SMI_GPRX_MIN) || (index > SMI_GPRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	return VGA_READ8(base, SMI_EXT_DATA);
+}
+static inline void smi_ext_gp_write(uint8_t * base, uint8_t index, uint8_t data)
+{
+	BUG_ON( (index < SMI_GPRX_MIN) || (index > SMI_GPRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	VGA_WRITE8(base, SMI_EXT_DATA, data);
+}
+
+/**********************************************************************/
+/* Pop-up Icon and Hardware Cursor */
+#define SMI_PHRX_MIN  0x80
+#define SMI_PHRx80_PATERN_L           0x80  /* Pop-up Icon and Hardware Cursor Pattern Location Low */
+#define SMI_PHRx81_EN_PATERN_H        0x81  /* Hardware Cursor Enable & PI/HWC Pattern Location High */
+
+#define SMI_POPx82_POP_CTRL           0x82  /* Pop-up Icon Control */
+/* SMI_POPx83 is reserved */
+#define SMI_POPx84_POP_COLOR_1        0x84  /* Pop-up Icon Color 1 */
+#define SMI_POPx85_POP_COLOR_2        0x85  /* Pop-up Icon Color 2 */
+#define SMI_POPx86_POP_COLOR_3        0x86  /* Pop-up Icon Color 3 */
+#define SMI_POPx90_POP_X_L            0x90  /* Pop-up Icon Start X Low */
+#define SMI_POPx91_POP_X_H            0x91  /* Pop-up Icon Start X High */
+#define SMI_POPx92_POP_Y_L            0x92  /* Pop-up Icon Start Y Low */
+#define SMI_POPx93_POP_Y_H            0x93  /* Pop-up Icon Start Y High */
+
+#define SMI_HCRx88_HC_X_L             0x88  /* Hardware Cursor Upper Left X Position Low */
+#define SMI_HCRx89_HC_X_H             0x89  /* Hardware Cursor Upper Left X Position High */
+#define SMI_HCRx8A_HC_Y_L             0x8A  /* Hardware Cursor Upper Left Y Position Low */
+#define SMI_HCRx8B_HC_Y_H             0x8B  /* Hardware Cursor Upper Left Y Position High */
+#define SMI_HCRx8C_HC_FOREGROUND      0x8C  /* Hardware Cursor Foreground Color */
+#define SMI_HCRx8D_HC_BACKGROUND      0x8D  /* Hardware Cursor Background Color */
+#define SMI_PHRX_MAX  0x93
+
+static inline uint8_t smi_ext_cursor_read(uint8_t * base, uint8_t index)
+{
+	BUG_ON( (index < SMI_PHRX_MIN) || (index > SMI_PHRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	return VGA_READ8(base, SMI_EXT_DATA);
+}
+static inline void smi_ext_cursor_write(uint8_t * base, uint8_t index, uint8_t data)
+{
+	BUG_ON( (index < SMI_PHRX_MIN) || (index > SMI_PHRX_MAX) );
+	VGA_WRITE8(base, SMI_EXT_INDEX, index);
+	VGA_WRITE8(base, SMI_EXT_DATA, data);
+}
+
+
+#endif				/* __SMI_HW_H__ */
+
diff --git a/drivers/video/smi/smifb.h b/drivers/video/smi/smifb.h
new file mode 100644
index 0000000..7b761cc
--- /dev/null
+++ b/drivers/video/smi/smifb.h
@@ -0,0 +1,64 @@
+/*
+ * drivers/video/smi/smifb.h
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __SMIFB_H__
+#define __SMIFB_H__
+
+typedef struct {
+	unsigned char red, green, blue, transp;
+} smi_cfb8_cmap_t;
+
+struct smifb_info {
+	struct fb_info info;	/* kernel framebuffer info */
+	const char *drvr_name;	/* Silicon Motion hardware board type */
+	struct pci_dev *pd;	/* descripbe the PCI device */
+	unsigned long base_phys;	/* physical base address                  */
+
+	/* PCI base physical addresses */
+	unsigned long fb_base_phys;	/* physical Frame Buffer base address                  */
+	unsigned long dpr_base_phys;	/* physical Drawing Processor base address             */
+	unsigned long vpr_base_phys;	/* physical Video Processor base address               */
+	unsigned long cpr_base_phys;	/* physical Capture Processor base address             */
+	unsigned long mmio_base_phys;	/* physical MMIO space (VGA + SMI regs ?) base address */
+	unsigned long dpport_base_phys;	/* physical Drawing Processor Data Port base address   */
+	int dpport_size;	/* size of Drawin Processor Data Port memory space     */
+
+	/* PCI base virtual addresses */
+	caddr_t base;		/* address of base */
+	caddr_t fb_base;	/* address of frame buffer base */
+	caddr_t dpr;		/* Drawing Processor Registers  */
+	caddr_t vpr;		/* Video Processor Registers    */
+	caddr_t cpr;		/* Capture Processor Registers  */
+	caddr_t mmio;		/* Memory Mapped I/O Port       */
+	caddr_t dpport;		/* Drawing Processor Data       */
+
+	int fbsize;		/* Frame-Buffer memory size */
+
+	/* some flags */
+	int flag;
+
+	/* current mode */
+	int bpp, depth;
+	u32 visual;
+	int xres, yres, pitch;
+	int pixclock;
+
+	/* current pipe */
+	int pipe;
+
+	/* initial parameters */
+	struct fb_var_screeninfo* initial_fb_var;
+
+};
+
+#endif				/* __SMIFB_H__ */

--------------050006080202000908040104--
