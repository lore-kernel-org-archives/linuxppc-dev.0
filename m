From: hollis@austin.ibm.com
Date: Wed, 23 Jan 2002 13:20:10 -0600
To: linuxppc-dev@lists.linuxppc.org
Cc: sdi@remote.org
Subject: RFC: vesafb
Message-ID: <20020123192010.GP510@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NqSa+Xr3J/G6Hhls"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--NqSa+Xr3J/G6Hhls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch allows vesafb to work on PPC. vesafb does surprisingly
little with the BIOS (which I thought was the whole point of VESA). With some
ifdef's I'm able to use it as sort of a VGA offb -- the firmware initializes
the card, and the driver just uses it and never mucks with it.

This patch allows me to get an 800x600x8 console on the Thinkpad 850, and
640x480x8 on the Carolina machines. More interestingly it allows X to work on
the Thinkpad, which currently doesn't work and has never worked in >16 colors.
It should also work on the 7020 (Sven?), which uses the Weitek 9100 card and
currently is driverless.

This patch is only for PReP, which is probably the only place it's really
useful (since CHRP and PMac have offb), but would be easy enough to add to.

Comments?

-Hollis

--NqSa+Xr3J/G6Hhls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vesafb-ppc.diff"

===== drivers/video/Config.in 1.12 vs edited =====
--- 1.12/drivers/video/Config.in	Thu Dec  6 11:36:15 2001
+++ edited/drivers/video/Config.in	Tue Jan 22 11:16:00 2002
@@ -73,6 +73,7 @@
       bool '  Chips 65550 display support' CONFIG_FB_CT65550
       bool '  IMS Twin Turbo display support' CONFIG_FB_IMSTT
       dep_bool '  S3 Trio display support' CONFIG_FB_S3TRIO $CONFIG_ALL_PPC
+      bool '  VESA VGA graphics console' CONFIG_FB_VESA
       tristate '  VGA 16-color graphics console' CONFIG_FB_VGA16
       if [ "$CONFIG_8xx" = "y" ]; then
 	 dep_tristate '  RPX LCD display support' CONFIG_FB_RPX $CONFIG_RPXLITE
===== drivers/video/vesafb.c 1.6 vs edited =====
--- 1.6/drivers/video/vesafb.c	Fri Nov 16 14:45:58 2001
+++ edited/drivers/video/vesafb.c	Tue Jan 22 15:14:35 2002
@@ -23,7 +23,9 @@
 #include <linux/init.h>

 #include <asm/io.h>
-#include <asm/mtrr.h>
+#ifdef __i386__
+#  include <asm/mtrr.h>
+#endif /* __i386__ */

 #include <video/fbcon.h>
 #include <video/fbcon-cfb8.h>
@@ -109,6 +111,7 @@
 static int vesafb_pan_display(struct fb_var_screeninfo *var, int con,
                               struct fb_info *info)
 {
+#ifdef __i386__
 	int offset;

 	if (!ypan)
@@ -131,6 +134,9 @@
                   "d" (offset >> 16),   /* EDX */
                   "D" (&pmi_start));    /* EDI */
 	return 0;
+#else
+	return -EINVAL;
+#endif
 }

 static int vesafb_update_var(int con, struct fb_info *info)
@@ -304,11 +310,13 @@
 {
 	struct { u_char blue, green, red, pad; } entry;

+#ifdef __i386__
 	if (pmi_setpal) {
 		entry.red   = red   >> 10;
 		entry.green = green >> 10;
 		entry.blue  = blue  >> 10;
 		entry.pad   = 0;
+
 	        __asm__ __volatile__(
                 "call *(%%esi)"
                 : /* no return value */
@@ -318,7 +326,9 @@
                   "d" (regno),          /* EDX */
                   "D" (&entry),         /* EDI */
                   "S" (&pmi_pal));      /* ESI */
-	} else {
+	} else
+#endif /* __i386__ */
+	{
 		/* without protected mode interface, try VGA registers... */
 		outb_p(regno,       dac_reg);
 		outb_p(red   >> 10, dac_val);
@@ -464,6 +474,7 @@
 			inverse=1;
 		else if (! strcmp(this_opt, "redraw"))
 			ypan=0;
+#ifdef __i386__
 		else if (! strcmp(this_opt, "ypan"))
 			ypan=1;
 		else if (! strcmp(this_opt, "ywrap"))
@@ -474,6 +485,7 @@
 			pmi_setpal=1;
 		else if (! strcmp(this_opt, "mtrr"))
 			mtrr=1;
+#endif /* __i386__ */
 		else if (!strncmp(this_opt, "font:", 5))
 			strcpy(fb_info.fontname, this_opt+5);
 	}
@@ -541,6 +553,13 @@
 	printk(KERN_INFO "vesafb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
 	       video_width, video_height, video_bpp, video_linelength, screen_info.pages);

+	vesafb_defined.xres=video_width;
+	vesafb_defined.yres=video_height;
+	vesafb_defined.xres_virtual=video_width;
+	vesafb_defined.yres_virtual=video_size / video_linelength;
+	vesafb_defined.bits_per_pixel=video_bpp;
+
+#ifdef __i386__
 	if (screen_info.vesapm_seg) {
 		printk(KERN_INFO "vesafb: protected mode interface info at %04x:%04x\n",
 		       screen_info.vesapm_seg,screen_info.vesapm_off);
@@ -572,16 +591,12 @@
 		}
 	}

-	vesafb_defined.xres=video_width;
-	vesafb_defined.yres=video_height;
-	vesafb_defined.xres_virtual=video_width;
-	vesafb_defined.yres_virtual=video_size / video_linelength;
-	vesafb_defined.bits_per_pixel=video_bpp;
-
 	if (ypan && vesafb_defined.yres_virtual > video_height) {
 		printk(KERN_INFO "vesafb: scrolling: %s using protected mode interface, yres_virtual=%d\n",
 		       (ypan > 1) ? "ywrap" : "ypan",vesafb_defined.yres_virtual);
-	} else {
+	} else
+#endif /* __i386__ */
+	{
 		printk(KERN_INFO "vesafb: scrolling: redraw\n");
 		vesafb_defined.yres_virtual = video_height;
 		ypan = 0;
@@ -634,6 +649,7 @@
 	 * region already (FIXME) */
 	request_region(0x3c0, 32, "vesafb");

+#ifdef __i386__
 	if (mtrr) {
 		int temp_size = video_size;
 		/* Find the largest power-of-two */
@@ -645,7 +661,8 @@
 			temp_size >>= 1;
 		}
 	}
-
+#endif
+
 	strcpy(fb_info.modename, "VESA VGA");
 	fb_info.changevar = NULL;
 	fb_info.node = -1;
===== arch/ppc/platforms/prep_setup.c 1.68 vs edited =====
--- 1.68/arch/ppc/platforms/prep_setup.c	Thu Jan 17 14:34:06 2002
+++ edited/arch/ppc/platforms/prep_setup.c	Wed Jan 23 10:30:30 2002
@@ -287,6 +287,45 @@
 }
 #endif /* CONFIG_SOUND_CS4232 */

+/*
+ * Fill out screen_info according to the residual data. This allows us to use
+ * at least vesafb.
+ */
+static void __init
+prep_init_vesa(void)
+{
+#if defined(CONFIG_PREP_RESIDUAL)
+	PPC_DEVICE *vgadev;
+
+	vgadev = residual_find_device(~0, NULL, DisplayController, SVGAController,
+									-1, 0);
+	if (vgadev != NULL) {
+		PnP_TAG_PACKET *pkt;
+
+		pkt = PnP_find_large_vendor_packet(
+				(unsigned char *)&res->DevicePnPHeap[vgadev->AllocatedOffset],
+				0x04, 0); /* 0x04 = Display Tag */
+		if (pkt != NULL) {
+			unsigned char *ptr = (unsigned char *)pkt;
+
+			if (ptr[4]) {
+				/* graphics mode */
+				screen_info.orig_video_isVGA = VIDEO_TYPE_VLFB;
+
+				screen_info.lfb_depth = ptr[4] * 8;
+
+				screen_info.lfb_width = swab16(*(short *)(ptr+6));
+				screen_info.lfb_height = swab16(*(short *)(ptr+8));
+				screen_info.lfb_linelength = swab16(*(short *)(ptr+10));
+
+				screen_info.lfb_base = swab32(*(long *)(ptr+12));
+				screen_info.lfb_size = swab32(*(long *)(ptr+20)) / 65536;
+			}
+		}
+	}
+#endif /* CONFIG_PREP_RESIDUAL */
+}
+
 static void __init
 prep_setup_arch(void)
 {
@@ -353,6 +392,8 @@
 #ifdef CONFIG_SOUND_CS4232
 	prep_init_sound();
 #endif /* CONFIG_SOUND_CS4232 */
+
+	prep_init_vesa();

 	/*print_residual_device_info();*/

===== arch/ppc/kernel/setup.c 1.95 vs edited =====
--- 1.95/arch/ppc/kernel/setup.c	Tue Jan  8 03:02:38 2002
+++ edited/arch/ppc/kernel/setup.c	Wed Jan 23 10:10:33 2002
@@ -99,7 +99,7 @@
 int ucache_bsize;

 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_FB_VGA16) || \
-    defined(CONFIG_FB_VGA16_MODULE)
+    defined(CONFIG_FB_VGA16_MODULE) || defined(CONFIG_FB_VESA)
 struct screen_info screen_info = {
 	0, 25,			/* orig-x, orig-y */
 	0,			/* unused */

--NqSa+Xr3J/G6Hhls--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
