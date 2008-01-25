Return-Path: <geert@sonycom.com>
Message-Id: <20080125153107.360334647@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
Date: Fri, 25 Jan 2008 16:06:30 +0100
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 07/11] ps3fb: Add support for configurable black borders
Sender: geert <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: Allow all video modes where the visible resolution plus the black
borders matches a native resolution

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
--
 drivers/video/ps3fb.c |   69 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 20 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -270,32 +270,57 @@ module_param(ps3fb_mode, int, 0);
 
 static char *mode_option __devinitdata;
 
-static unsigned int ps3fb_find_mode(const struct fb_var_screeninfo *var,
+static int ps3fb_cmp_mode(const struct fb_videomode *vmode,
+			  const struct fb_var_screeninfo *var)
+{
+	/* resolution + black border must match a native resolution */
+	if (vmode->left_margin + vmode->xres + vmode->right_margin !=
+	    var->left_margin + var->xres + var->right_margin ||
+	    vmode->upper_margin + vmode->yres + vmode->lower_margin !=
+	    var->upper_margin + var->yres + var->lower_margin)
+		return -1;
+
+	/* minimum limits for margins */
+	if (vmode->left_margin > var->left_margin ||
+	    vmode->right_margin > var->right_margin ||
+	    vmode->upper_margin > var->upper_margin ||
+	    vmode->lower_margin > var->lower_margin)
+		return -1;
+
+	/* these fields must match exactly */
+	if (vmode->pixclock != var->pixclock ||
+	    vmode->hsync_len != var->hsync_len ||
+	    vmode->vsync_len != var->vsync_len ||
+	    vmode->sync != var->sync ||
+	    vmode->vmode != (var->vmode & FB_VMODE_MASK))
+		return -1;
+
+	return 0;
+}
+
+static unsigned int ps3fb_find_mode(struct fb_var_screeninfo *var,
 				    u32 *ddr_line_length, u32 *xdr_line_length)
 {
-	unsigned int i, fi, mode;
+	unsigned int i, mode;
 
-	for (i = 0; i < ARRAY_SIZE(ps3fb_modedb); i++)
-		if (var->xres == ps3fb_modedb[i].xres &&
-		    var->yres == ps3fb_modedb[i].yres &&
-		    var->pixclock == ps3fb_modedb[i].pixclock &&
-		    var->hsync_len == ps3fb_modedb[i].hsync_len &&
-		    var->vsync_len == ps3fb_modedb[i].vsync_len &&
-		    var->left_margin == ps3fb_modedb[i].left_margin &&
-		    var->right_margin == ps3fb_modedb[i].right_margin &&
-		    var->upper_margin == ps3fb_modedb[i].upper_margin &&
-		    var->lower_margin == ps3fb_modedb[i].lower_margin &&
-		    var->sync == ps3fb_modedb[i].sync &&
-		    (var->vmode & FB_VMODE_MASK) == ps3fb_modedb[i].vmode)
+	for (i = PS3AV_MODE_1080P50; i < ARRAY_SIZE(ps3fb_modedb); i++)
+		if (!ps3fb_cmp_mode(&ps3fb_modedb[i], var))
 			goto found;
 
 	pr_debug("ps3fb_find_mode: mode not found\n");
 	return 0;
 
 found:
-	/* Cropped broadcast modes use the full line length */
-	fi = i < PS3AV_MODE_1080P50 ? i + PS3AV_MODE_WUXGA : i;
-	*ddr_line_length = ps3fb_modedb[fi].xres * BPP;
+	*ddr_line_length = ps3fb_modedb[i].xres * BPP;
+
+	if (!var->xres) {
+		var->xres = 1;
+		var->right_margin--;
+	}
+	if (!var->yres) {
+		var->yres = 1;
+		var->lower_margin--;
+	}
 
 	if (ps3_compare_firmware_version(1, 9, 0) >= 0) {
 		*xdr_line_length = GPU_ALIGN_UP(max(var->xres,
@@ -305,10 +330,14 @@ found:
 	} else
 		*xdr_line_length = *ddr_line_length;
 
-	/* Full broadcast modes have the full mode bit set */
 	mode = i+1;
-	if (mode > PS3AV_MODE_WUXGA)
-		mode = (mode - PS3AV_MODE_WUXGA) | PS3AV_MODE_FULL;
+	if (mode > PS3AV_MODE_WUXGA) {
+		mode -= PS3AV_MODE_WUXGA;
+		/* Full broadcast modes have the full mode bit set */
+		if (ps3fb_modedb[i].xres == var->xres &&
+		    ps3fb_modedb[i].yres == var->yres)
+			mode |= PS3AV_MODE_FULL;
+	}
 
 	pr_debug("ps3fb_find_mode: mode %u\n", mode);
 

-- 
With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
