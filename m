Date: Wed, 4 Sep 2002 21:58:56 +0200
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Xilinx TFT interface driver
Message-ID: <20020904195856.GJ781@mind.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7iMSBzlTiPOCCT2k"
From: p2@mind.be (Peter 'p2' De Schrijver)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Attached you will find a patch implementing a Linux framebuffer driver
for the Xilinx TFT interface. It was tested on a Xilinx Virtex2Pro
implementation.

Comments welcome,

Peter.

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=xtft-patch

diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/drivers/video/Config.in linuxppc_2_4_xseg2.new.clean2/drivers/video/Config.in
--- linuxppc_2_4_clean/drivers/video/Config.in	2002-07-20 12:03:22.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/drivers/video/Config.in	2002-09-01 17:10:29.000000000 +0200
@@ -216,6 +216,10 @@
    if [ "$CONFIG_NINO" = "y" ]; then
       bool '  TMPTX3912/PR31700 frame buffer support' CONFIG_FB_TX3912
    fi
+
+   if [ "$CONFIG_XSEG2" = "y" ]; then
+   	  bool '  Xilinx TFT core framebuffer support' CONFIG_FB_XILINX_TFT
+   fi
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
       tristate '  Virtual Frame Buffer support (ONLY FOR TESTING!)' CONFIG_FB_VIRTUAL
    fi
@@ -377,7 +381,8 @@
 	   "$CONFIG_FB_FM2" = "y" -o "$CONFIG_FB_SGIVW" = "y" -o \
 	   "$CONFIG_FB_RADEON" = "y" -o "$CONFIG_FB_PVR2" = "y" -o \
 	   "$CONFIG_FB_3DFX" = "y" -o "$CONFIG_FB_SIS" = "y" -o \
-	   "$CONFIG_FB_VOODOO1" = "y" -o "$CONFIG_FB_CYBER2000" = "y" ]; then
+	   "$CONFIG_FB_VOODOO1" = "y" -o "$CONFIG_FB_CYBER2000" = "y" -o \
+	   "$CONFIG_FB_XILINX_TFT" = "y" ]; then
 	 define_tristate CONFIG_FBCON_CFB32 y
       else
 	 if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/drivers/video/Makefile linuxppc_2_4_xseg2.new.clean2/drivers/video/Makefile
--- linuxppc_2_4_clean/drivers/video/Makefile	2002-07-20 12:03:24.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/drivers/video/Makefile	2002-09-01 16:33:47.000000000 +0200
@@ -89,7 +89,7 @@
 obj-$(CONFIG_FB_MAXINE)           += maxinefb.o
 obj-$(CONFIG_FB_TX3912)           += tx3912fb.o
 obj-$(CONFIG_FB_RPX)              += rpxfb.o
-
+obj-$(CONFIG_FB_XILINX_TFT)       += xilinx_tft.o

 subdir-$(CONFIG_FB_MATROX)	  += matrox
 ifeq ($(CONFIG_FB_MATROX),y)
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/drivers/video/fbmem.c linuxppc_2_4_xseg2.new.clean2/drivers/video/fbmem.c
--- linuxppc_2_4_clean/drivers/video/fbmem.c	2002-07-20 12:03:53.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/drivers/video/fbmem.c	2002-09-04 21:24:39.000000000 +0200
@@ -136,6 +136,7 @@
 extern int pvr2fb_setup(char*);
 extern int sstfb_init(void);
 extern int sstfb_setup(char*);
+extern int xtftfb_init(void);

 static struct {
 	const char *name;
@@ -227,6 +228,10 @@
 #ifdef CONFIG_FB_VOODOO1
 	{ "sst", sstfb_init, sstfb_setup },
 #endif
+#ifdef CONFIG_FB_XILINX_TFT
+     { "xilinxtft", xtftfb_init, NULL },
+#endif
+

 	/*
 	 * Generic drivers that are used as fallbacks
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/drivers/video/xilinx_tft.c linuxppc_2_4_xseg2.new.clean2/drivers/video/xilinx_tft.c
--- linuxppc_2_4_clean/drivers/video/xilinx_tft.c	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc_2_4_xseg2.new.clean2/drivers/video/xilinx_tft.c	2002-09-04 20:43:45.000000000 +0200
@@ -0,0 +1,286 @@
+/*
+ * xilinx_tft.c: A driver for Xilinx TFT screen interface core
+ *
+ * Copyright 2002 Mind NV
+ *
+ * http://www.mind.be/
+ *
+ * Author : Peter De Schrijver (p2@mind.be)
+ *
+ * This software may be used and distributed according to the terms of
+ * the GNU General Public License (GPL) version 2, incorporated herein by
+ * reference. Drivers based on or derived from this code fall under the GPL
+ * and must retain the authorship, copyright and this license notice. This
+ * file is not a complete program and may only be used when the entire
+ * operating system is licensed under the GPL.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+
+#include <asm/uaccess.h>
+#include <asm/setup.h>
+#include <asm/segment.h>
+#include <asm/system.h>
+#include <linux/fb.h>
+#include <linux/module.h>
+#include <asm/pgtable.h>
+
+#include <video/fbcon.h>
+#include <video/fbcon-cfb32.h>
+
+#define TFT_FB_PHYS_ADDR 	0x30000000
+#define TFT_BASE_ADDR	(0xE0020000 + 0x80 * 4)
+#define TFT_CFG	  		(0xE0020000 + 0x81 * 4)
+
+static int xtftfb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info);
+static int xtftfb_get_var(struct fb_var_screeninfo *var, int con,struct fb_info *info);
+static int xtftfb_set_var(struct fb_var_screeninfo *var, int con,struct fb_info *info);
+static int xtftfb_get_cmap(struct fb_cmap *cmap,int kspc,int con,struct fb_info *info);
+static int xtftfb_set_cmap(struct fb_cmap *cmap,int kspc,int con,struct fb_info *info);
+
+
+
+static int currcon = 0;
+
+static struct fb_ops xtftfb_ops = {
+	owner: 		THIS_MODULE,
+	fb_get_fix:	xtftfb_get_fix,
+	fb_get_var: xtftfb_get_var,
+	fb_set_var: xtftfb_set_var,
+	fb_get_cmap: xtftfb_get_cmap,
+	fb_set_cmap: xtftfb_set_cmap,
+};
+
+static struct fb_var_screeninfo xtft_default_var = {
+	xres: 640,
+    yres: 480,
+	xres_virtual: 1024,
+	yres_virtual: 480,
+	xoffset:    0,
+	yoffset:	0,
+	bits_per_pixel: 32,
+	grayscale: 0,
+	transp:	{24, 8, 0},
+	red:	{16, 8, 0},
+	green:  {8, 8, 0},
+	blue:	{0, 8, 0},
+	nonstd: 0,
+	activate: 0,
+	height:	  -1,
+	width:	  -1,
+	accel_flags:    0,
+};
+
+static struct fb_fix_screeninfo xtft_fix = {
+	id:		"XilinxTFT",
+	type: 	FB_TYPE_PACKED_PIXELS,
+	visual: FB_VISUAL_TRUECOLOR,
+	line_length: 4096,
+	accel:      FB_ACCEL_NONE
+};
+
+static struct fb_info fb_info;
+static struct display disp;
+
+static int xtftfb_getcolreg(unsigned        regno,
+						   unsigned 	  *red,
+						   unsigned 	  *green,
+						   unsigned 	  *blue,
+						   unsigned 	  *transp,
+						   struct fb_info *fb) {
+
+		if (regno > 256) return 1;
+
+		*transp=((unsigned int *)(fb->disp->dispsw_data))[regno]>>
+				 fb->var.transp.offset;
+		*red=((unsigned int *)(fb->disp->dispsw_data))[regno]
+				>>fb->var.red.offset & (~(1<<fb->var.red.offset));
+		*green=((unsigned int *)(fb->disp->dispsw_data))[regno]
+				>>fb->var.green.offset & (~(1<<fb->var.green.offset));
+		*blue=((unsigned int *)(fb->disp->dispsw_data))[regno]
+				>>fb->var.blue.offset & (~(1<<fb->var.blue.offset));
+
+		return 0;
+}
+
+static int xtftfb_setcolreg(unsigned        regno,
+						   unsigned 	   red,
+						   unsigned 	   green,
+						   unsigned 	   blue,
+						   unsigned 	   transp,
+						   struct fb_info *fb) {
+
+	if (regno > 256) return 1;
+
+	((unsigned int *)fb->disp->dispsw_data)[regno]=
+							     (transp << fb->var.transp.offset)
+							   | (red << fb->var.red.offset)
+							   | (green << fb->var.green.offset)
+							   | (blue << fb->var.blue.offset);
+	return 0;
+}
+
+static int xtftfb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info) {
+
+	*fix=info->fix;
+
+	return 0;
+
+}
+
+static int xtftfb_get_var(struct fb_var_screeninfo *var, int con, struct fb_info *info) {
+
+	*var = info->var;
+
+	return 0;
+
+}
+
+static int xtftfb_set_var(struct fb_var_screeninfo *var, int con, struct fb_info *info) {
+
+	struct display *disp;
+
+	if(con >= 0)
+		disp = &fb_display[con];
+	else
+		disp = info->disp;
+
+	if(var->xres != 640 || var->yres != 480 ||
+	   var->xres_virtual != 1024 ||
+	   var->yres_virtual != 480 ||
+	   var->bits_per_pixel != 32 || var->grayscale != 0) {
+			return -EINVAL;
+	}
+
+
+	if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
+		info->var = *var;
+		if (info->changevar)
+			(*info->changevar)(con);
+	}
+	return 0;
+}
+
+static int xtftfb_get_cmap(struct fb_cmap *cmap, int kspc, int con, struct fb_info *fb) {
+
+	struct display *d=(con<0) ? fb->disp : fb_display + con;
+
+	if(con == currcon) {
+		return fb_get_cmap(cmap, kspc, xtftfb_getcolreg, fb);
+	} else if(d->cmap.len) {
+		fb_copy_cmap(&d->cmap, cmap, kspc ? 0 : 2);
+	} else {
+		fb_copy_cmap(fb_default_cmap(256), cmap, kspc ? 0 : 2);
+	}
+
+	return 0;
+
+}
+
+static int xtftfb_set_cmap(struct fb_cmap *cmap, int kspc, int con, struct fb_info *fb) {
+
+	struct display *d=(con<0) ? fb->disp : fb_display + con;
+
+	if(con == currcon) {
+		return fb_set_cmap(cmap, kspc, xtftfb_setcolreg, fb);
+	} else {
+		fb_copy_cmap(cmap, &d->cmap, kspc ? 0 : 1);
+	}
+
+	return 0;
+
+}
+
+static int xtftfbcon_switch(int con, struct fb_info *info) {
+
+
+	if(currcon != -1)
+		memcpy(&fb_display[currcon].var, &info->var, sizeof(struct fb_var_screeninfo));
+
+	memcpy(&info->var, &fb_display[con].var,sizeof(struct fb_var_screeninfo));
+
+
+	currcon = con;
+
+	return 0;
+
+}
+
+static int xtftfbcon_updatevar(int con, struct fb_info *info) {
+
+	return (con < 0) ? -EINVAL : 0;
+
+}
+
+static void xtftfbcon_blank(int blank_mode, struct fb_info *info) {
+
+	return ;
+
+}
+
+int __init xtftfb_init(void) {
+
+	*(unsigned int *)TFT_BASE_ADDR=TFT_FB_PHYS_ADDR;
+
+	xtft_fix.smem_start=ioremap(TFT_FB_PHYS_ADDR, 1024*480*4);
+	xtft_fix.smem_len=1024*480*4;
+
+	disp.var=xtft_default_var;
+	disp.screen_base=(char *)xtft_fix.smem_start;
+
+    disp.visual = xtft_fix.visual;
+    disp.type = xtft_fix.type;
+    disp.type_aux = xtft_fix.type_aux;
+    disp.ypanstep = xtft_fix.ypanstep;
+    disp.ywrapstep = xtft_fix.ywrapstep;
+    disp.line_length = xtft_fix.line_length;
+    disp.can_soft_blank = 0;
+    disp.inverse = 0;
+
+	disp.dispsw = &fbcon_cfb32;
+	disp.dispsw_data = (void *)kmalloc(16 * sizeof(u32), GFP_KERNEL);
+	if(disp.dispsw_data == NULL)
+		return -1;
+	memset(disp.dispsw_data, 0, 16 * sizeof(u32));
+
+	*(unsigned int *)TFT_CFG=0x1;
+
+	disp.scrollmode = SCROLL_YREDRAW;
+
+	strcpy (fb_info.modename, xtft_fix.id);
+    fb_info.node = -1;
+    fb_info.flags = FBINFO_FLAG_DEFAULT;
+
+	fb_info.var = xtft_default_var;
+	fb_info.fix = xtft_fix;
+
+	fb_info.fbops = &xtftfb_ops;
+
+	fb_info.screen_base = (char *)xtft_fix.smem_start;
+	fb_info.disp = &disp;
+    fb_info.changevar = NULL;
+    fb_info.switch_con = xtftfbcon_switch;
+    fb_info.updatevar = xtftfbcon_updatevar;
+    fb_info.blank = xtftfbcon_blank;
+    fb_info.pseudo_palette = NULL; /* ??? */
+    fb_info.par = NULL;
+
+	if(register_framebuffer(&fb_info) < 0)
+		return -EINVAL;
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n",
+			GET_FB_IDX(fb_info.node), fb_info.modename);
+
+	return 0;
+
+}
+
+

--7iMSBzlTiPOCCT2k--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
