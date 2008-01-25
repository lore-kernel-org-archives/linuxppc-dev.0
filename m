Return-Path: <geert@sonycom.com>
Message-Id: <20080125153107.478948955@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
Date: Fri, 25 Jan 2008 16:06:32 +0100
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 09/11] ps3fb: Round up video modes
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

ps3fb: Round up arbitrary video modes until they fit (if possible)

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |  160 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 114 insertions(+), 46 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -276,29 +276,49 @@ static char *mode_option __devinitdata;
 static int ps3fb_cmp_mode(const struct fb_videomode *vmode,
 			  const struct fb_var_screeninfo *var)
 {
-	/* resolution + black border must match a native resolution */
-	if (vmode->left_margin + vmode->xres + vmode->right_margin !=
-	    var->left_margin + var->xres + var->right_margin ||
-	    vmode->upper_margin + vmode->yres + vmode->lower_margin !=
-	    var->upper_margin + var->yres + var->lower_margin)
+	long xres, yres, left_margin, right_margin, upper_margin, lower_margin;
+	long dx, dy;
+
+	/* maximum values */
+	if (var->xres > vmode->xres || var->yres > vmode->yres ||
+	    var->pixclock > vmode->pixclock ||
+	    var->hsync_len > vmode->hsync_len ||
+	    var->vsync_len > vmode->vsync_len)
 		return -1;
 
-	/* minimum limits for margins */
-	if (vmode->left_margin > var->left_margin ||
-	    vmode->right_margin > var->right_margin ||
-	    vmode->upper_margin > var->upper_margin ||
-	    vmode->lower_margin > var->lower_margin)
+	/* progressive/interlaced must match */
+	if ((var->vmode & FB_VMODE_MASK) != vmode->vmode)
 		return -1;
 
-	/* these fields must match exactly */
-	if (vmode->pixclock != var->pixclock ||
-	    vmode->hsync_len != var->hsync_len ||
-	    vmode->vsync_len != var->vsync_len ||
-	    vmode->sync != var->sync ||
-	    vmode->vmode != (var->vmode & FB_VMODE_MASK))
+	/* minimum resolution */
+	xres = max(var->xres, 1U);
+	yres = max(var->yres, 1U);
+
+	/* minimum margins */
+	left_margin = max(var->left_margin, vmode->left_margin);
+	right_margin = max(var->right_margin, vmode->right_margin);
+	upper_margin = max(var->upper_margin, vmode->upper_margin);
+	lower_margin = max(var->lower_margin, vmode->lower_margin);
+
+	/* resolution + margins may not exceed native parameters */
+	dx = ((long)vmode->left_margin + (long)vmode->xres +
+	      (long)vmode->right_margin) -
+	     (left_margin + xres + right_margin);
+	if (dx < 0)
 		return -1;
 
-	return 0;
+	dy = ((long)vmode->upper_margin + (long)vmode->yres +
+	      (long)vmode->lower_margin) -
+	     (upper_margin + yres + lower_margin);
+	if (dy < 0)
+		return -1;
+
+	/* exact match */
+	if (!dx && !dy)
+		return 0;
+
+	/* resolution difference */
+	return (vmode->xres - xres) * (vmode->yres - yres);
 }
 
 static const struct fb_videomode *ps3fb_native_vmode(enum ps3av_mode_num id)
@@ -324,33 +344,96 @@ static const struct fb_videomode *ps3fb_
 static unsigned int ps3fb_find_mode(struct fb_var_screeninfo *var,
 				    u32 *ddr_line_length, u32 *xdr_line_length)
 {
-	unsigned int id;
+	unsigned int id, best_id;
+	int diff, best_diff;
 	const struct fb_videomode *vmode;
+	long gap;
 
+	best_id = 0;
+	best_diff = INT_MAX;
+	pr_debug("%s: wanted %u [%u] %u x %u [%u] %u\n", __func__,
+		 var->left_margin, var->xres, var->right_margin,
+		 var->upper_margin, var->yres, var->lower_margin);
 	for (id = PS3AV_MODE_480I; id <= PS3AV_MODE_WUXGA; id++) {
 		vmode = ps3fb_native_vmode(id);
-		if (!ps3fb_cmp_mode(vmode, var))
-			goto found;
+		diff = ps3fb_cmp_mode(vmode, var);
+		pr_debug("%s: mode %u: %u [%u] %u x %u [%u] %u: diff = %d\n",
+			 __func__, id, vmode->left_margin, vmode->xres,
+			 vmode->right_margin, vmode->upper_margin,
+			 vmode->yres, vmode->lower_margin, diff);
+		if (diff < 0)
+			continue;
+		if (diff < best_diff) {
+			best_id = id;
+			if (!diff)
+				break;
+			best_diff = diff;
+		}
 	}
 
-	pr_debug("%s: mode not found\n", __func__);
-	return 0;
+	if (!best_id) {
+		pr_debug("%s: no suitable mode found\n", __func__);
+		return 0;
+	}
+
+	id = best_id;
+	vmode = ps3fb_native_vmode(id);
 
-found:
 	*ddr_line_length = vmode->xres * BPP;
 
-	if (!var->xres) {
+	/* minimum resolution */
+	if (!var->xres)
 		var->xres = 1;
-		var->right_margin--;
-	}
-	if (!var->yres) {
+	if (!var->yres)
 		var->yres = 1;
-		var->lower_margin--;
-	}
+
+	/* minimum virtual resolution */
+	if (var->xres_virtual < var->xres)
+		var->xres_virtual = var->xres;
+	if (var->yres_virtual < var->yres)
+		var->yres_virtual = var->yres;
+
+	/* minimum margins */
+	if (var->left_margin < vmode->left_margin)
+		var->left_margin = vmode->left_margin;
+	if (var->right_margin < vmode->right_margin)
+		var->right_margin = vmode->right_margin;
+	if (var->upper_margin < vmode->upper_margin)
+		var->upper_margin = vmode->upper_margin;
+	if (var->lower_margin < vmode->lower_margin)
+		var->lower_margin = vmode->lower_margin;
+
+	/* extra margins */
+	gap = ((long)vmode->left_margin + (long)vmode->xres +
+	       (long)vmode->right_margin) -
+	      ((long)var->left_margin + (long)var->xres +
+	       (long)var->right_margin);
+	if (gap > 0) {
+		var->left_margin += gap/2;
+		var->right_margin += (gap+1)/2;
+		pr_debug("%s: rounded up H to %u [%u] %u\n", __func__,
+			 var->left_margin, var->xres, var->right_margin);
+	}
+
+	gap = ((long)vmode->upper_margin + (long)vmode->yres +
+	       (long)vmode->lower_margin) -
+	      ((long)var->upper_margin + (long)var->yres +
+	       (long)var->lower_margin);
+	if (gap > 0) {
+		var->upper_margin += gap/2;
+		var->lower_margin += (gap+1)/2;
+		pr_debug("%s: rounded up V to %u [%u] %u\n", __func__,
+			 var->upper_margin, var->yres, var->lower_margin);
+	}
+
+	/* fixed fields */
+	var->pixclock = vmode->pixclock;
+	var->hsync_len = vmode->hsync_len;
+	var->vsync_len = vmode->vsync_len;
+	var->sync = vmode->sync;
 
 	if (ps3_compare_firmware_version(1, 9, 0) >= 0) {
-		*xdr_line_length = GPU_ALIGN_UP(max(var->xres,
-						    var->xres_virtual) * BPP);
+		*xdr_line_length = GPU_ALIGN_UP(var->xres_virtual * BPP);
 		if (*xdr_line_length > GPU_MAX_LINE_LENGTH)
 			*xdr_line_length = GPU_MAX_LINE_LENGTH;
 	} else
@@ -465,22 +548,11 @@ static int ps3fb_check_var(struct fb_var
 	u32 xdr_line_length, ddr_line_length;
 	int mode;
 
-	dev_dbg(info->device, "var->xres:%u info->var.xres:%u\n", var->xres,
-		info->var.xres);
-	dev_dbg(info->device, "var->yres:%u info->var.yres:%u\n", var->yres,
-		info->var.yres);
-
-	/* FIXME For now we do exact matches only */
 	mode = ps3fb_find_mode(var, &ddr_line_length, &xdr_line_length);
 	if (!mode)
 		return -EINVAL;
 
 	/* Virtual screen */
-	if (var->xres_virtual < var->xres)
-		var->xres_virtual = var->xres;
-	if (var->yres_virtual < var->yres)
-		var->yres_virtual = var->yres;
-
 	if (var->xres_virtual > xdr_line_length / BPP) {
 		dev_dbg(info->device,
 			"Horizontal virtual screen size too large\n");
@@ -549,10 +621,6 @@ static int ps3fb_set_par(struct fb_info 
 	const struct fb_videomode *vmode;
 	u64 dst;
 
-	dev_dbg(info->device, "xres:%d xv:%d yres:%d yv:%d clock:%d\n",
-		info->var.xres, info->var.xres_virtual,
-		info->var.yres, info->var.yres_virtual, info->var.pixclock);
-
 	mode = ps3fb_find_mode(&info->var, &ddr_line_length, &xdr_line_length);
 	if (!mode)
 		return -EINVAL;

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
