Date: Wed, 7 Nov 2001 21:15:51 -0500 (EST)
From: Daniel Berlin <dan@cgsoftware.com>
To: <linuxppc-dev@lists.linuxppc.org>, <ajoshi@unixbox.com>,
	<benh@kernel.crashing.org>
Subject: [PATCH]: Make radeonfb work alot better with new powerbooks
Message-ID: <Pine.LNX.4.33.0111072026090.30759-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch makes the radeonfb work a lot better on the rev b powerbooks.
It's against benh's latest, as of last night.
Fixed/added:
1. Any other mode besides 640x480 was absurdly slow. Unusable, in fact.
It now is pretty darn quick, and completely usable.
2. It would default to 640x480, rather than 1152x768, on rev b powerbooks.
3. It would also determine that we had no monitor, and no display panel,
because it couldn't read the video bios that doesn't exist in the
powerbooks.
In reality, the LCD is on the DVI port.
So for rev b powerbooks, we go ahead and say so, and let it detect
the flat panel size/stretching/etc.
4. It would assume blanking meant blanking the crt. It will now turn off
the lcd as well.
5. It now supports the backlevel lighting control. It's the same on the
rage128 and the radeon, so i copied and renamed the routines from
aty128fb.c

It *shouldn't* have any problems on a normal radeon powermac, but i don't
have one to try it out on.

Hopefully, this is useful for someone besides me.
--Dan

diff -rupwBb ./radeon.h ../../benh/drivers/video/radeon.h
--- ./radeon.h	Wed Nov  7 09:54:02 2001
+++ ../../benh/drivers/video/radeon.h	Wed Nov  7 20:25:10 2001
@@ -523,6 +523,9 @@
 #define LVDS_PANEL_TYPE				   (1 << 2)
 #define LVDS_PANEL_FORMAT			   (1 << 3)
 #define LVDS_EN					   (1 << 7)
+#define LVDS_BL_MOD_LEVEL_MASK			   0x0000ff00
+#define LVDS_BL_MOD_LEVEL_SHIFT			   8
+#define LVDS_BL_MOD_EN				   (1 << 16)
 #define LVDS_DIGON				   (1 << 18)
 #define LVDS_BLON				   (1 << 19)
 #define LVDS_SEL_CRTC2				   (1 << 23)
diff -rupwBb ./radeonfb.c ../../benh/drivers/video/radeonfb.c
--- ./radeonfb.c	Wed Nov  7 09:54:03 2001
+++ ../../benh/drivers/video/radeonfb.c	Wed Nov  7 20:30:51 2001
@@ -41,8 +41,16 @@
 #include <linux/pci.h>

 #include <asm/io.h>
-#if defined(__powerpc__)
+#ifdef CONFIG_PPC
 #include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <video/macmodes.h>
+#ifdef CONFIG_NVRAM
+#include <linux/nvram.h>
+#endif
+#endif
+#ifdef CONFIG_PMAC_BACKLIGHT
+#include <asm/backlight.h>
 #endif

 #include <video/fbcon.h>
@@ -547,6 +555,10 @@ static char fontname[40] __initdata;
 static char *mode_option __initdata;
 static char noaccel __initdata = 0;
 static char panel_yres __initdata = 0;
+#ifdef CONFIG_PPC
+static int default_vmode __initdata = VMODE_1024_768_60;
+static int default_cmode __initdata = CMODE_8;
+#endif

 #ifdef FBCON_HAS_CFB8
 static struct display_switch fbcon_radeon8;
@@ -613,6 +625,15 @@ static struct fb_ops radeon_fb_ops = {
 	fb_pan_display:		radeonfb_pan_display,
 	fb_ioctl:		radeonfb_ioctl,
 };
+#ifdef CONFIG_PMAC_BACKLIGHT
+static int radeon_set_backlight_enable(int on, int level, void* data);
+static int radeon_set_backlight_level(int level, void* data);
+
+static struct backlight_controller radeon_backlight_controller = {
+	radeon_set_backlight_enable,
+	radeon_set_backlight_level
+};
+#endif /* CONFIG_PMAC_BACKLIGHT */


 static struct pci_driver radeonfb_driver = {
@@ -843,8 +864,17 @@ static int radeonfb_pci_register (struct
 	radeon_get_pllinfo(rinfo, bios_seg);

 	RTRACE("radeonfb: probed %s %dk videoram\n", (rinfo->ram_type), (rinfo->video_ram/1024));
-
+#if !defined(__powerpc__)
 	radeon_get_moninfo(rinfo);
+#else
+	if (machine_is_compatible ("PowerBook3,3")) {
+		RTRACE("radeonfb: This is a powerbook, setting display mode to LCD\n");
+		rinfo->dviDisp_type = MT_LCD;
+	} else {
+		radeon_get_moninfo(rinfo);
+	}
+
+#endif
 	if ((rinfo->dviDisp_type == MT_DFP) || (rinfo->dviDisp_type == MT_LCD) ||
 	    (rinfo->crtDisp_type == MT_DFP)) {
 		if (!radeon_get_dfpinfo(rinfo)) {
@@ -908,6 +937,10 @@ static int radeonfb_pci_register (struct
 		/* initialize the engine */
 		radeon_engine_init (rinfo);
 	}
+#ifdef CONFIG_PMAC_BACKLIGHT
+	if (rinfo->dviDisp_type == MT_LCD)
+		register_backlight_controller(&radeon_backlight_controller, rinfo, "ati");
+#endif /* CONFIG_PMAC_BACKLIGHT */

 	printk ("radeonfb: ATI %s %s %d MB\n", rinfo->name, rinfo->ram_type,
 		(rinfo->video_ram/(1024*1024)));
@@ -1121,7 +1154,7 @@ static void radeon_get_moninfo (struct r
 		/* primary DVI port */
 		if (tmp & 0x08)
 			rinfo->dviDisp_type = MT_DFP;
-		else if (tmp & 0x4)
+		else if (tmp & 0x04)
 			rinfo->dviDisp_type = MT_LCD;
 		else if (tmp & 0x200)
 			rinfo->dviDisp_type = MT_CRT;
@@ -1172,7 +1205,12 @@ static int radeon_get_dfpinfo (struct ra
 			rinfo->panel_xres = 640; break;
 		case 600:
 			rinfo->panel_xres = 800; break;
-		case 786:
+	case 768:
+#ifdef CONFIG_PPC
+	if (machine_is_compatible("PowerBook3,3"))
+		rinfo->panel_xres = 1152; break;
+	else
+#endif
 			rinfo->panel_xres = 1024; break;
 		case 1024:
 			rinfo->panel_xres = 1280; break;
@@ -1241,6 +1279,8 @@ static void radeon_engine_init (struct r

 	/* disable 3D engine */
 	OUTREG(RB3D_CNTL, 0);
+	OUTREG(MC_FB_LOCATION, 0xffff0000);
+	OUTREG(MC_AGP_LOCATION, 0xffff0000);

 	radeon_engine_reset ();

@@ -1326,6 +1366,15 @@ static int __devinit radeon_init_disp (s
         disp = &rinfo->disp;

         disp->var = radeonfb_default_var;
+#ifdef CONFIG_PPC
+	if (machine_is_compatible("PowerBook3,3"))
+	{
+		default_vmode = VMODE_1152_768_60;
+		default_cmode = CMODE_8;
+		if (mac_vmode_to_var(default_vmode, default_cmode, &disp->var))
+			disp->var = radeonfb_default_var;
+	}
+#endif
         info->disp = disp;

         radeon_set_dispsw (rinfo, disp);
@@ -1333,7 +1382,7 @@ static int __devinit radeon_init_disp (s
 	if (noaccel)
 	        disp->scrollmode = SCROLL_YREDRAW;
 	else
-		disp->scrollmode = 0;
+		disp->scrollmode = SCROLL_YNOMOVE;

         rinfo->currcon_display = disp;

@@ -1353,8 +1402,20 @@ static int radeon_init_disp_var (struct
                               NULL, 0, NULL, 8);
         else
 #endif
+#ifdef CONFIG_PPC
+		if (machine_is_compatible("PowerBook3,3"))
+		{
+			default_vmode = VMODE_1152_768_60;
+			default_cmode = CMODE_8;
+			if (mac_vmode_to_var(default_vmode, default_cmode, &rinfo->disp.var))
+				rinfo->disp.var = radeonfb_default_var;
+		}
+		else
+#endif
+		{
                 fb_find_mode (&rinfo->disp.var, &rinfo->info, "640x480-8@60",
                               NULL, 0, NULL, 0);
+		}

 	if (noaccel)
 		rinfo->disp.var.accel_flags &= ~FB_ACCELF_TEXT;
@@ -1528,7 +1589,7 @@ static int radeonfb_get_fix (struct fb_f
         fix->type_aux = disp->type_aux;
         fix->visual = disp->visual;

-        fix->xpanstep = 1;
+        fix->xpanstep = 8;
         fix->ypanstep = 1;
         fix->ywrapstep = 0;

@@ -1537,9 +1598,9 @@ static int radeonfb_get_fix (struct fb_f
         fix->mmio_start = rinfo->mmio_base_phys;
         fix->mmio_len = RADEON_REGSIZE;
 	if (noaccel)
-	        fix->accel = FB_ACCEL_NONE;
+	        fix->accel &= ~FB_ACCELF_TEXT;
 	else
-		fix->accel = 40;	/* XXX */
+		fix->accel |= FB_ACCELF_TEXT;	/* XXX */

         return 0;
 }
@@ -1681,7 +1742,7 @@ static int radeonfb_set_var (struct fb_v
                 if (noaccel)
                         disp->scrollmode = SCROLL_YREDRAW;
                 else
-                        disp->scrollmode = 0;
+                        disp->scrollmode = SCROLL_YNOMOVE;

                 if (info && info->changevar)
                         info->changevar(con);
@@ -1771,6 +1832,60 @@ static int radeonfb_ioctl (struct inode
 {
 	return -EINVAL;
 }
+#ifdef CONFIG_PMAC_BACKLIGHT
+static int backlight_conv[] = {
+	0xff, 0xc0, 0xb5, 0xaa, 0x9f, 0x94, 0x89, 0x7e,
+	0x73, 0x68, 0x5d, 0x52, 0x47, 0x3c, 0x31, 0x24
+};
+
+/* We turn off the LCD completely instead of just dimming the backlight.
+ * This provides greater power saving and the display is useless without
+ * backlight anyway
+ */
+#define BACKLIGHT_LVDS_OFF
+/* That one prevents proper CRT output with LCD off */
+#undef BACKLIGHT_DAC_OFF
+
+static int
+radeon_set_backlight_enable(int on, int level, void* data)
+{
+	struct radeonfb_info *rinfo = (struct radeonfb_info *)data;
+	unsigned int reg = INREG(LVDS_GEN_CNTL);
+
+	reg |= LVDS_BL_MOD_EN | LVDS_BLON;
+	if (on && level > BACKLIGHT_OFF) {
+		reg &= ~LVDS_BL_MOD_LEVEL_MASK;
+		reg |= (backlight_conv[level] << LVDS_BL_MOD_LEVEL_SHIFT);
+#ifdef BACKLIGHT_LVDS_OFF
+		reg |= LVDS_ON | LVDS_EN;
+		reg &= ~LVDS_DISPLAY_DIS;
+#endif
+		OUTREG(LVDS_GEN_CNTL, reg);
+#ifdef BACKLIGHT_DAC_OFF
+		OUTREG(DAC_CNTL, INREG(DAC_CNTL) & (~DAC_PDWN));
+#endif
+	} else {
+		reg &= ~LVDS_BL_MOD_LEVEL_MASK;
+		reg |= (backlight_conv[0] << LVDS_BL_MOD_LEVEL_SHIFT);
+#ifdef BACKLIGHT_LVDS_OFF
+		reg &= ~(LVDS_ON | LVDS_EN);
+		reg |= LVDS_DISPLAY_DIS;
+#endif
+		OUTREG(LVDS_GEN_CNTL, reg);
+#ifdef BACKLIGHT_DAC_OFF
+		OUTREG(DAC_CNTL, INREG(DAC_CNTL) | DAC_PDWN);
+#endif
+	}
+
+	return 0;
+}
+
+static int
+radeon_set_backlight_level(int level, void* data)
+{
+	return radeon_set_backlight_enable(1, level, data);
+}
+#endif /* CONFIG_PMAC_BACKLIGHT */


 static int radeonfb_switch (int con, struct fb_info *info)
@@ -1830,10 +1945,17 @@ static void radeonfb_blank (int blank, s
 {
         struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
         u32 val = INREG(CRTC_EXT_CNTL);
+        u32 val2 = INREG (LVDS_GEN_CNTL);
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	if (blank)
+		set_backlight_enable(0);
+#endif /* CONFIG_PMAC_BACKLIGHT */

         /* reset it */
         val &= ~(CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS |
                  CRTC_VSYNC_DIS);
+	val2 &= ~(LVDS_DISPLAY_DIS);

         switch (blank) {
                 case VESA_NO_BLANKING:
@@ -1845,12 +1967,20 @@ static void radeonfb_blank (int blank, s
                         val |= (CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS);
                         break;
                 case VESA_POWERDOWN:
+		val2 |= (LVDS_DISPLAY_DIS);
                         val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS |
                                 CRTC_HSYNC_DIS);
                         break;
         }
-
+	if (rinfo->dviDisp_type == MT_LCD)
+		OUTREG(LVDS_GEN_CNTL, val2);
+	else
         OUTREG(CRTC_EXT_CNTL, val);
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	if (!blank)
+		set_backlight_enable(1);
+#endif
 }

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
