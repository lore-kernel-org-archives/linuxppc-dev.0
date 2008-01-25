Return-Path: <geert@sonycom.com>
Message-Id: <20080125153107.237625092@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
Date: Fri, 25 Jan 2008 16:06:28 +0100
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 05/11] ps3fb: Kill ps3fb_res
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

ps3fb: kill ps3fb_res[], as all information it contains can be obtained in
some other way.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |  108 ++++++++++----------------------------------------
 1 file changed, 22 insertions(+), 86 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -134,42 +134,17 @@ static struct ps3fb_priv ps3fb;
 struct ps3fb_par {
 	u32 pseudo_palette[16];
 	int mode_id, new_mode_id;
-	int res_index;
 	unsigned int num_frames;	/* num of frame buffers */
 	unsigned int width;
 	unsigned int height;
+	unsigned int ddr_line_length;
+	unsigned int ddr_frame_size;
+	unsigned int xdr_frame_size;
 	unsigned long full_offset;	/* start of fullscreen DDR fb */
 	unsigned long fb_offset;	/* start of actual DDR fb */
 	unsigned long pan_offset;
 };
 
-struct ps3fb_res_table {
-	u32 xres;
-	u32 yres;
-	u32 xoff;
-	u32 yoff;
-	u32 type;
-};
-#define PS3FB_RES_FULL 1
-static const struct ps3fb_res_table ps3fb_res[] = {
-	/* res_x,y   margin_x,y  full */
-	{  720,  480,  72,  48 , 0},
-	{  720,  576,  72,  58 , 0},
-	{ 1280,  720,  78,  38 , 0},
-	{ 1920, 1080, 116,  58 , 0},
-	/* full mode */
-	{  720,  480,   0,   0 , PS3FB_RES_FULL},
-	{  720,  576,   0,   0 , PS3FB_RES_FULL},
-	{ 1280,  720,   0,   0 , PS3FB_RES_FULL},
-	{ 1920, 1080,   0,   0 , PS3FB_RES_FULL},
-	/* vesa: normally full mode */
-	{ 1280,  768,   0,   0 , 0},
-	{ 1280, 1024,   0,   0 , 0},
-	{ 1920, 1200,   0,   0 , 0},
-	{    0,    0,   0,   0 , 0} };
-
-/* default resolution */
-#define GPU_RES_INDEX	0		/* 720 x 480 */
 
 static const struct fb_videomode ps3fb_modedb[] = {
     /* 60 Hz broadcast modes (modes "1" to "5") */
@@ -295,37 +270,6 @@ module_param(ps3fb_mode, int, 0);
 
 static char *mode_option __devinitdata;
 
-static int ps3fb_get_res_table(u32 xres, u32 yres, int mode)
-{
-	int full_mode;
-	unsigned int i;
-	u32 x, y, f;
-
-	full_mode = (mode & PS3AV_MODE_FULL) ? PS3FB_RES_FULL : 0;
-	for (i = 0;; i++) {
-		x = ps3fb_res[i].xres;
-		y = ps3fb_res[i].yres;
-		f = ps3fb_res[i].type;
-
-		if (!x) {
-			pr_debug("ERROR: ps3fb_get_res_table()\n");
-			return -1;
-		}
-
-		if (full_mode == PS3FB_RES_FULL && f != PS3FB_RES_FULL)
-			continue;
-
-		if (x == xres && (yres == 0 || y == yres))
-			break;
-
-		x = x - 2 * ps3fb_res[i].xoff;
-		y = y - 2 * ps3fb_res[i].yoff;
-		if (x == xres && (yres == 0 || y == yres))
-			break;
-	}
-	return i;
-}
-
 static unsigned int ps3fb_find_mode(const struct fb_var_screeninfo *var,
 				    u32 *ddr_line_length, u32 *xdr_line_length)
 {
@@ -433,8 +377,7 @@ static void ps3fb_sync_image(struct devi
 static int ps3fb_sync(struct fb_info *info, u32 frame)
 {
 	struct ps3fb_par *par = info->par;
-	int i, error = 0;
-	u32 ddr_line_length, xdr_line_length;
+	int error = 0;
 	u64 ddr_base, xdr_base;
 
 	if (frame > par->num_frames - 1) {
@@ -444,16 +387,13 @@ static int ps3fb_sync(struct fb_info *in
 		goto out;
 	}
 
-	i = par->res_index;
-	xdr_line_length = info->fix.line_length;
-	ddr_line_length = ps3fb_res[i].xres * BPP;
-	xdr_base = frame * info->var.yres_virtual * xdr_line_length;
-	ddr_base = frame * ps3fb_res[i].yres * ddr_line_length;
+	xdr_base = frame * par->xdr_frame_size;
+	ddr_base = frame * par->ddr_frame_size;
 
 	ps3fb_sync_image(info->device, ddr_base + par->full_offset,
 			 ddr_base + par->fb_offset, xdr_base + par->pan_offset,
-			 par->width, par->height, ddr_line_length,
-			 xdr_line_length);
+			 par->width, par->height, par->ddr_line_length,
+			 info->fix.line_length);
 
 out:
 	return error;
@@ -572,8 +512,9 @@ static int ps3fb_set_par(struct fb_info 
 {
 	struct ps3fb_par *par = info->par;
 	unsigned int mode, ddr_line_length, xdr_line_length, lines, maxlines;
-	int i;
+	unsigned int ddr_xoff, ddr_yoff;
 	unsigned long offset;
+	const struct fb_videomode *vmode;
 	u64 dst;
 
 	dev_dbg(info->device, "xres:%d xv:%d yres:%d yv:%d clock:%d\n",
@@ -584,8 +525,7 @@ static int ps3fb_set_par(struct fb_info 
 	if (!mode)
 		return -EINVAL;
 
-	i = ps3fb_get_res_table(info->var.xres, info->var.yres, mode);
-	par->res_index = i;
+	vmode = ps3fb_default_mode(mode | PS3AV_MODE_FULL);
 
 	info->fix.smem_start = virt_to_abs(ps3fb.xdr_ea);
 	info->fix.smem_len = ps3fb.xdr_size;
@@ -595,9 +535,12 @@ static int ps3fb_set_par(struct fb_info 
 
 	info->screen_base = (char __iomem *)ps3fb.xdr_ea;
 
+	par->ddr_line_length = ddr_line_length;
+	par->ddr_frame_size = vmode->yres * ddr_line_length;
+	par->xdr_frame_size = info->var.yres_virtual * xdr_line_length;
+
 	par->num_frames = ps3fb.xdr_size /
-			  max(ps3fb_res[i].yres * ddr_line_length,
-			      info->var.yres_virtual * xdr_line_length);
+			  max(par->ddr_frame_size, par->xdr_frame_size);
 
 	/* Keep the special bits we cannot set using fb_var_screeninfo */
 	par->new_mode_id = (par->new_mode_id & ~PS3AV_MODE_MASK) | mode;
@@ -606,7 +549,9 @@ static int ps3fb_set_par(struct fb_info 
 	par->height = info->var.yres;
 
 	/* Start of the virtual frame buffer (relative to fullscreen) */
-	offset = ps3fb_res[i].yoff * ddr_line_length + ps3fb_res[i].xoff * BPP;
+	ddr_xoff = info->var.left_margin - vmode->left_margin;
+	ddr_yoff = info->var.upper_margin - vmode->upper_margin;
+	offset = ddr_yoff * ddr_line_length + ddr_xoff * BPP;
 
 	par->fb_offset = GPU_ALIGN_UP(offset);
 	par->full_offset = par->fb_offset - offset;
@@ -625,13 +570,13 @@ static int ps3fb_set_par(struct fb_info 
 	memset(ps3fb.xdr_ea, 0, ps3fb.xdr_size);
 
 	/* Clear DDR frame buffer memory */
-	lines = ps3fb_res[i].yres * par->num_frames;
+	lines = vmode->yres * par->num_frames;
 	if (par->full_offset)
 		lines++;
 	maxlines = ps3fb.xdr_size / ddr_line_length;
 	for (dst = 0; lines; dst += maxlines * ddr_line_length) {
 		unsigned int l = min(lines, maxlines);
-		ps3fb_sync_image(info->device, 0, dst, 0, ps3fb_res[i].xres, l,
+		ps3fb_sync_image(info->device, 0, dst, 0, vmode->xres, l,
 				 ddr_line_length, ddr_line_length);
 		lines -= l;
 	}
@@ -1052,14 +997,13 @@ static int __devinit ps3fb_probe(struct 
 	struct fb_info *info;
 	struct ps3fb_par *par;
 	int retval = -ENOMEM;
-	u32 xres, yres;
 	u64 ddr_lpar = 0;
 	u64 lpar_dma_control = 0;
 	u64 lpar_driver_info = 0;
 	u64 lpar_reports = 0;
 	u64 lpar_reports_size = 0;
 	u64 xdr_lpar;
-	int status, res_index;
+	int status;
 	struct task_struct *task;
 	unsigned long max_ps3fb_size;
 
@@ -1079,13 +1023,6 @@ static int __devinit ps3fb_probe(struct 
 		ps3fb_mode = ps3av_get_mode();
 	dev_dbg(&dev->core, "ps3fb_mode: %d\n", ps3fb_mode);
 
-	if (ps3fb_mode > 0 &&
-	    !ps3av_video_mode2res(ps3fb_mode, &xres, &yres)) {
-		res_index = ps3fb_get_res_table(xres, yres, ps3fb_mode);
-		dev_dbg(&dev->core, "res_index:%d\n", res_index);
-	} else
-		res_index = GPU_RES_INDEX;
-
 	atomic_set(&ps3fb.f_count, -1);	/* fbcon opens ps3fb */
 	atomic_set(&ps3fb.ext_flip, 0);	/* for flip with vsync */
 	init_waitqueue_head(&ps3fb.wait_vsync);
@@ -1158,7 +1095,6 @@ static int __devinit ps3fb_probe(struct 
 	par = info->par;
 	par->mode_id = ~ps3fb_mode;	/* != ps3fb_mode, to trigger change */
 	par->new_mode_id = ps3fb_mode;
-	par->res_index = res_index;
 	par->num_frames = 1;
 
 	info->screen_base = (char __iomem *)ps3fb.xdr_ea;

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
