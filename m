Message-ID: <3BEF952D.9000306@humboldt.co.uk>
Date: Mon, 12 Nov 2001 09:23:57 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org,
	linux-fbdev-devel@lists.sourceforge.net
Subject: Scaling registers on r128
Content-Type: multipart/mixed;
 boundary="------------090709020207010402020702"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090709020207010402020702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch to aty128fb is experimental, and intended for the brave.

The attached patch turns on the panel scaling registers of the R128.
I've run this on my iBook2, and I've been able to display 640x480 and
800x600 modes on the panel successfully.

The panel sizes are currently hardwired on the iBook. This code will
benefit greatly from a reliable means to find the panel size.

This has revealed problems in the X server: if the XF86Config-4
specifies 800x600 and the current console is in 1024x768, the display is
broken. This looks like a generic problem in fbdevhw based Xservers, as
I saw something similar on 69030.

--
Adrian Cox   http://www.humboldt.co.uk/

--------------090709020207010402020702
Content-Type: text/plain;
 name="scaling_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scaling_patch"

===== drivers/video/aty128.h 1.3 vs edited =====
--- 1.3/drivers/video/aty128.h	Mon Jul  2 19:17:06 2001
+++ edited/drivers/video/aty128.h	Sat Nov 10 08:52:29 2001
@@ -48,6 +48,13 @@
 #define OVR_CLR					0x0230
 #define OVR_WID_LEFT_RIGHT			0x0234
 #define OVR_WID_TOP_BOTTOM			0x0238
+#define FP_CRTC_H_TOTAL_DISP         	    	0x0250
+#define FP_CRTC_V_TOTAL_DISP         	    	0x0254
+#define FP_GEN_CNTL                  	    	0x0284
+#define FP_HORZ_STRETCH              	    	0x028c
+#define FP_VERT_STRETCH              	    	0x0290
+#define FP_H_SYNC_STRT_WID           	    	0x02c4
+#define FP_V_SYNC_STRT_WID           	    	0x02c8
 #define LVDS_GEN_CNTL				0x02d0
 #define DDA_CONFIG				0x02e0
 #define DDA_ON_OFF				0x02e4
@@ -414,5 +421,30 @@
 #define PWR_MGT_SLOWDOWN_MCLK			0x00002000

 #define PMI_PMSCR_REG				0x60
+
+/* FP_HORZ_STRETCH constants */
+#define HORZ_STRETCH_RATIO_MASK     	    	0xffff
+#define HORZ_STRETCH_RATIO_SHIFT    	    	0
+#define HORZ_STRETCH_RATIO_MAX      	    	4096
+#define HORZ_PANEL_SIZE 	    	    	(0xff   << 16)
+#define HORZ_PANEL_SHIFT	    	    	16
+#define HORZ_STRETCH_PIXREP	    	    	(0	 << 25)
+#define HORZ_STRETCH_BLEND	    	    	(1	 << 25)
+#define HORZ_STRETCH_ENABLE	    	    	(1	 << 26)
+#define HORZ_FP_LOOP_STRETCH	    	    	(0x7	 << 27)
+#define HORZ_STRETCH_RESERVED	    	    	(1	 << 30)
+#define HORZ_AUTO_RATIO_FIX_EN      	    	(1	 << 31)
+
+/* FP_VERT_STRETCH constants */
+#define VERT_PANEL_SIZE 	    	    	(0x7ff <<  0)
+#define VERT_PANEL_SHIFT	    	    	0
+#define VERT_STRETCH_RATIO_MASK     	    	0x3ff
+#define VERT_STRETCH_RATIO_SHIFT    	    	11
+#define VERT_STRETCH_RATIO_MAX      	    	1024
+#define VERT_STRETCH_ENABLE	    	    	(1	<< 24)
+#define VERT_STRETCH_LINEREP	    	    	(0	<< 25)
+#define VERT_STRETCH_BLEND	    	    	(1	<< 25)
+#define VERT_AUTO_RATIO_EN	    	    	(1	<< 26)
+#define VERT_STRETCH_RESERVED	    	    	0xf8e00000

 #endif /* REG_RAGE128_H */
===== drivers/video/aty128fb.c 1.19 vs edited =====
--- 1.19/drivers/video/aty128fb.c	Mon Oct 22 01:27:37 2001
+++ edited/drivers/video/aty128fb.c	Sun Nov 11 10:15:28 2001
@@ -264,6 +264,9 @@
     u32 xoffset, yoffset;
     u32 vxres, vyres;
     u32 depth, bpp;
+#ifdef CONFIG_PMAC_PBOOK
+    u32 hstretch, vstretch;
+#endif
 };

 struct aty128_pll {
@@ -324,6 +327,7 @@
     int	pm_reg;
     int crt_on, lcd_on;
     u32 save_lcd_gen_cntl;
+    int panel_width, panel_height;
 #endif
 };

@@ -797,9 +801,21 @@
     aty_st_le32(CRTC_OFFSET_CNTL, crtc->offset_cntl);
     /* Disable ATOMIC updating.  Is this the right place? */
     aty_st_pll(PPLL_CNTL, aty_ld_pll(PPLL_CNTL) & ~(0x00030000));
+    /* Program the FP registers - currently only on Powerbooks out of caution
+       and a lack of hardware to experiment on */
+#ifdef CONFIG_PMAC_PBOOK
+    if (info->panel_width)
+    {
+    	aty_st_le32(FP_CRTC_H_TOTAL_DISP, crtc->h_total);
+	aty_st_le32(FP_H_SYNC_STRT_WID, crtc->h_sync_strt_wid);
+	aty_st_le32(FP_CRTC_V_TOTAL_DISP, crtc->v_total);
+	aty_st_le32(FP_V_SYNC_STRT_WID, crtc->v_sync_strt_wid);
+    	aty_st_le32(FP_HORZ_STRETCH, crtc->hstretch);
+	aty_st_le32(FP_VERT_STRETCH, crtc->vstretch);
+    }
+#endif
 }

-
 static int
 aty128_var_to_crtc(const struct fb_var_screeninfo *var,
 			struct aty128_crtc *crtc,
@@ -922,6 +938,38 @@
     crtc->depth = depth;
     crtc->bpp = bpp;

+#ifdef CONFIG_PMAC_PBOOK
+    if (info->panel_width)
+    {
+    	u32 hratio, vratio;
+	hratio = round_div(HORZ_STRETCH_RATIO_MAX * xres, info->panel_width);
+	vratio = round_div(VERT_STRETCH_RATIO_MAX * yres, info->panel_height);
+    	crtc->hstretch = aty_ld_le32(FP_HORZ_STRETCH);
+	crtc->vstretch = aty_ld_le32(FP_VERT_STRETCH);
+	printk("stretch before 0x%08x 0x%08x\n", crtc->hstretch, crtc->vstretch);
+	crtc->hstretch = ((hratio & HORZ_STRETCH_RATIO_MASK) <<
+	    	    	    	    	HORZ_STRETCH_RATIO_SHIFT) |
+			(crtc->hstretch & (HORZ_PANEL_SIZE |
+			    HORZ_FP_LOOP_STRETCH |
+			    HORZ_STRETCH_RESERVED));
+	crtc->hstretch &= ~HORZ_AUTO_RATIO_FIX_EN;
+	if (hratio == HORZ_STRETCH_RATIO_MAX)
+	    crtc->hstretch &= ~(HORZ_STRETCH_BLEND | HORZ_STRETCH_ENABLE);
+	else
+	    crtc->hstretch |= (HORZ_STRETCH_BLEND | HORZ_STRETCH_ENABLE);
+	crtc->vstretch = ((vratio & VERT_STRETCH_RATIO_MASK) <<
+	    	    	    	    	VERT_STRETCH_RATIO_SHIFT) |
+			 (crtc->vstretch & (VERT_PANEL_SIZE |
+			    	            VERT_STRETCH_RESERVED));
+	crtc->vstretch &= ~VERT_AUTO_RATIO_EN;
+	if (vratio == VERT_STRETCH_RATIO_MAX)
+	    crtc->vstretch &= ~(VERT_STRETCH_BLEND | VERT_STRETCH_ENABLE);
+	else
+	    crtc->vstretch |= (VERT_STRETCH_BLEND | VERT_STRETCH_ENABLE);
+	printk("stretch after 0x%08x 0x%08x\n", crtc->hstretch, crtc->vstretch);
+    }
+#endif
+
     return 0;
 }

@@ -1876,8 +1924,16 @@
 	    /* PowerBook Firewire (Pismo), iBook Dual USB */
 	    if (machine_is_compatible("PowerBook3,1") ||
 	    	machine_is_compatible("PowerBook4,1"))
+	    {
 		default_vmode = VMODE_1024_768_60;
-
+#ifdef CONFIG_PMAC_PBOOK
+    	    	/* Once we have proper panel probing this can be
+		   removed -- APC */
+		printk("Setting panel_width to 1024\n");
+    	    	info->panel_width = 1024;
+		info->panel_height = 768;
+#endif
+    	    }
 	    /* PowerBook Titanium */
 	    if (machine_is_compatible("PowerBook3,2"))
 		default_vmode = VMODE_1152_768_60;

--------------090709020207010402020702--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
