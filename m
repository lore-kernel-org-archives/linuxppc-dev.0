Message-ID: <3A7ACBA6.D0F8EF16@iiic.ethz.ch>
Date: Fri, 02 Feb 2001 16:00:54 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Brad Douglas <brad@neruo.com>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, andi@convergence.de,
        benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu, geert@linux-m68k.org,
        Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [linux-fbdev] Re: r128 DRI driver now fully functional
References: <142B99D154AF@vcnet.vc.cvut.cz>
Content-Type: multipart/mixed;
 boundary="------------B0638311E315623FE1305CC2"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------B0638311E315623FE1305CC2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Petr Vandrovec wrote:
>
> On 31 Jan 01 at 19:53, Michel Dänzer wrote:
> > > The disadvantage is that if you change the palette, the text colors
> > > don't change until you redraw the screen (or switch VC back-and-forth).
> > > That's why I decided to use the hardware palette in directcolor modes.
> >
> > I don't mind using the hardware palette if you (or anyone) tell me how to
> > get RGB565 working with that. :)
>
> It depends on how your hardware works:
>
> If it uses palette entries 0-31 for R/B and 0-63 for G, program
> dispsw_data pointed array (pseudo_palette) with
>
> for (i = 0; i < 16; i++) arr[i] = i * ((1 << 11) | (1 << 5) | 1);
>
> and your setcolreg should program r,g,b fields for regno register.
>
> If your hardware uses entries 0,8,16,24...248 for R/B and
> 0,4,8,12,... for G, things are worse:
>
> program pseudo_palette with same 'arr[i] = i * ((1 << 11) | (1 << 5) | 1);'
>
> But setcolreg is much worse:

[...]

Thanks Petr, that was the final hint. :)

The attached patch against 2.4.1 works for me, now I can use both 555 and 565
with aty128fb, so both depth 15 and 16 work in X with UseFBDev.


> I think that you should create 3x256 (or 3x64) array which will mirror
> DAC state, as otherwise you have to do too many ops to set
> one register...

Such an array was already present in aty128fb.


> Also do not forget that you must use only low 16 color registers (regno
> on input to setcolreg) for text console, as others (16-31/16-63) are not
> saved/restored by console palette handling code.

Does my patch handle this fine?


Looking forward to comments and suggestions. Andi, does this fix your color
problems in 16 bit?


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member
--------------B0638311E315623FE1305CC2
Content-Type: text/plain; charset=us-ascii;
 name="aty128fb-16bit.diff"
Content-Disposition: inline;
 filename="aty128fb-16bit.diff"
Content-Transfer-Encoding: 7bit

--- drivers/video/aty128fb.c.orig	Sun Jan 14 03:53:57 2001
+++ drivers/video/aty128fb.c	Fri Feb  2 15:37:51 2001
@@ -251,7 +251,7 @@
     u32 offset, offset_cntl;
     u32 xoffset, yoffset;
     u32 vxres, vyres;
-    u32 bpp;
+    u32 depth, bpp;
 };

 struct aty128_pll {
@@ -379,7 +379,7 @@
 static void do_wait_for_fifo(u16 entries, struct fb_info_aty128 *info);
 static void wait_for_fifo(u16 entries, struct fb_info_aty128 *info);
 static void wait_for_idle(struct fb_info_aty128 *info);
-static u32 bpp_to_depth(u32 bpp);
+static u32 depth_to_dst(u32 depth);

 #ifdef FBCON_HAS_CFB8
 static struct display_switch fbcon_aty128_8;
@@ -698,7 +698,7 @@
 		GMC_SRC_CLIP_DEFAULT			|
 		GMC_DST_CLIP_DEFAULT			|
 		GMC_BRUSH_SOLIDCOLOR			|
-		(bpp_to_depth(par->crtc.bpp) << 8)	|
+		(depth_to_dst(par->crtc.depth) << 8)	|
 		GMC_SRC_DSTCOLOR			|
 		GMC_BYTE_ORDER_MSB_TO_LSB		|
 		GMC_DP_CONVERSION_TEMP_6500		|
@@ -731,17 +731,19 @@
 }


-/* convert bpp values to their register representation */
+/* convert depth values to their register representation */
 static u32
-bpp_to_depth(u32 bpp)
+depth_to_dst(u32 depth)
 {
-    if (bpp <= 8)
+    if (depth <= 8)
 	return DST_8BPP;
-    else if (bpp <= 16)
+    else if (depth <= 15)
         return DST_15BPP;
-    else if (bpp <= 24)
+    else if (depth == 16)
+        return DST_16BPP;
+    else if (depth <= 24)
 	return DST_24BPP;
-    else if (bpp <= 32)
+    else if (depth <= 32)
 	return DST_32BPP;

     return -EINVAL;
@@ -779,7 +781,7 @@
 			struct aty128_crtc *crtc,
 			const struct fb_info_aty128 *info)
 {
-    u32 xres, yres, vxres, vyres, xoffset, yoffset, bpp;
+    u32 xres, yres, vxres, vyres, xoffset, yoffset, bpp, dst;
     u32 left, right, upper, lower, hslen, vslen, sync, vmode;
     u32 h_total, h_disp, h_sync_strt, h_sync_wid, h_sync_pol;
     u32 v_total, v_disp, v_sync_strt, v_sync_wid, v_sync_pol, c_sync;
@@ -804,6 +806,11 @@
     sync  = var->sync;
     vmode = var->vmode;

+    if (bpp != 16)
+	depth = bpp;
+    else
+	depth = (var->green.length == 6) ? 16 : 15;
+
     /* check for mode eligibility
      * accept only non interlaced modes */
     if ((vmode & FB_VMODE_MASK) != FB_VMODE_NONINTERLACED)
@@ -819,17 +826,17 @@
     if (vyres < yres + yoffset)
 	vyres = yres + yoffset;

-    /* convert bpp into ATI register depth */
-    depth = bpp_to_depth(bpp);
+    /* convert depth into ATI register depth */
+    dst = depth_to_dst(depth);

     /* make sure we didn't get an invalid depth */
-    if (depth == -EINVAL) {
-        printk(KERN_ERR "aty128fb: Invalid depth\n");
+    if (dst == -EINVAL) {
+        printk(KERN_ERR "aty128fb: Invalid depth or RGBA\n");
         return -EINVAL;
     }

-    /* convert depth to bpp */
-    bytpp = mode_bytpp[depth];
+    /* convert register depth to bytes per pixel */
+    bytpp = mode_bytpp[dst];

     /* make sure there is enough video ram for the mode */
     if ((u32)(vxres * vyres * bytpp) > info->vram_size) {
@@ -870,7 +877,7 @@

     c_sync = sync & FB_SYNC_COMP_HIGH_ACT ? (1 << 4) : 0;

-    crtc->gen_cntl = 0x3000000L | c_sync | (depth << 8);
+    crtc->gen_cntl = 0x3000000L | c_sync | (dst << 8);

     crtc->h_total = h_total | (h_disp << 16);
     crtc->v_total = v_total | (v_disp << 16);
@@ -889,6 +896,7 @@
     crtc->vyres = vyres;
     crtc->xoffset = xoffset;
     crtc->yoffset = yoffset;
+    crtc->depth = depth;
     crtc->bpp = bpp;

     return 0;
@@ -896,7 +904,7 @@


 static int
-aty128_bpp_to_var(int pix_width, struct fb_var_screeninfo *var)
+aty128_pix_width_to_var(int pix_width, struct fb_var_screeninfo *var)
 {

     /* fill in pixel info */
@@ -913,7 +921,6 @@
 	var->transp.length = 0;
 	break;
     case CRTC_PIX_WIDTH_15BPP:
-    case CRTC_PIX_WIDTH_16BPP:
 	var->bits_per_pixel = 16;
 	var->red.offset = 10;
 	var->red.length = 5;
@@ -924,6 +931,17 @@
 	var->transp.offset = 0;
 	var->transp.length = 0;
 	break;
+    case CRTC_PIX_WIDTH_16BPP:
+	var->bits_per_pixel = 16;
+	var->red.offset = 11;
+	var->red.length = 5;
+	var->green.offset = 5;
+	var->green.length = 6;
+	var->blue.offset = 0;
+	var->blue.length = 5;
+	var->transp.offset = 0;
+	var->transp.length = 0;
+	break;
     case CRTC_PIX_WIDTH_24BPP:
         var->bits_per_pixel = 24;
         var->red.offset = 16;
@@ -992,7 +1010,7 @@
             (v_sync_pol ? 0 : FB_SYNC_VERT_HIGH_ACT) |
             (c_sync ? FB_SYNC_COMP_HIGH_ACT : 0);

-    aty128_bpp_to_var(pix_width, var);
+    aty128_pix_width_to_var(pix_width, var);

     var->xres = xres;
     var->yres = yres;
@@ -1117,7 +1135,7 @@
 static int
 aty128_ddafifo(struct aty128_ddafifo *dsp,
 		const struct aty128_pll *pll,
-		u32 bpp,
+		u32 depth,
 		const struct fb_info_aty128 *info)
 {
     const struct aty128_meminfo *m = info->mem;
@@ -1125,11 +1143,10 @@
     u32 fifo_width = info->constants.fifo_width;
     u32 fifo_depth = info->constants.fifo_depth;
     s32 x, b, p, ron, roff;
-    u32 n, d;
+    u32 n, d, bpp;

-    /* 15bpp is really 16bpp */
-    if (bpp == 15)
-	bpp = 16;
+    /* round up to multiple of 8 */
+    bpp = (depth+7) & ~7;

     n = xclk * fifo_width;
     d = pll->vclk * bpp;
@@ -1210,10 +1227,10 @@
     config = aty_ld_le32(CONFIG_CNTL) & ~3;

 #if defined(__BIG_ENDIAN)
-    if (par->crtc.bpp >= 24)
-	config |= 2;	/* make aperture do 32 byte swapping */
-    else if (par->crtc.bpp > 8)
-	config |= 1;	/* make aperture do 16 byte swapping */
+    if (par->crtc.bpp == 32)
+	config |= 2;	/* make aperture do 32 bit swapping */
+    else if (par->crtc.bpp == 16)
+	config |= 1;	/* make aperture do 16 bit swapping */
 #endif

     aty_st_le32(CONFIG_CNTL, config);
@@ -1268,7 +1285,7 @@
     if ((err = aty128_var_to_pll(var->pixclock, &par->pll, info)))
 	return err;

-    if ((err = aty128_ddafifo(&par->fifo_reg, &par->pll, par->crtc.bpp, info)))
+    if ((err = aty128_ddafifo(&par->fifo_reg, &par->pll, par->crtc.depth, info)))
 	return err;

     if (var->accel_flags & FB_ACCELF_TEXT)
@@ -1336,7 +1353,7 @@
     struct fb_info_aty128 *info = (struct fb_info_aty128 *)fb;
     struct aty128fb_par par;
     struct display *display;
-    int oldxres, oldyres, oldvxres, oldvyres, oldbpp, oldaccel;
+    int oldxres, oldyres, oldvxres, oldvyres, oldbpp, oldgreen, oldaccel;
     int accel, err;

     display = (con >= 0) ? &fb_display[con] : fb->disp;
@@ -1381,10 +1398,12 @@
     oldvxres = display->var.xres_virtual;
     oldvyres = display->var.yres_virtual;
     oldbpp = display->var.bits_per_pixel;
+    oldgreen = display->var.green.length;
     oldaccel = display->var.accel_flags;
     display->var = *var;
     if (oldxres != var->xres || oldyres != var->yres ||
 	oldvxres != var->xres_virtual || oldvyres != var->yres_virtual ||
+	oldgreen != var->green.length ||
 	oldbpp != var->bits_per_pixel || oldaccel != var->accel_flags) {

 	struct fb_fix_screeninfo fix;
@@ -1415,7 +1434,7 @@
     if (!info->fb_info.display_fg || info->fb_info.display_fg->vc_num == con)
 	aty128_set_par(&par, info);

-    if (oldbpp != var->bits_per_pixel) {
+    if (oldbpp != var->bits_per_pixel || oldgreen != var->green.length) {
 	if ((err = fb_alloc_cmap(&display->cmap, 0, 0)))
 	    return err;
 	do_install_cmap(con, &info->fb_info);
@@ -1436,7 +1455,6 @@
 	break;
 #endif
 #ifdef FBCON_HAS_CFB16
-    case 15:
     case 16:
 	disp->dispsw = accel ? &fbcon_aty128_16 : &fbcon_cfb16;
 	disp->dispsw_data = info->fbcon_cmap.cfb16;
@@ -1478,7 +1496,7 @@
     fix->type        = FB_TYPE_PACKED_PIXELS;
     fix->type_aux    = 0;
     fix->line_length = (par->crtc.vxres * par->crtc.bpp) >> 3;
-    fix->visual      = par->crtc.bpp <= 8 ? FB_VISUAL_PSEUDOCOLOR
+    fix->visual      = par->crtc.bpp == 8 ? FB_VISUAL_PSEUDOCOLOR
                                           : FB_VISUAL_DIRECTCOLOR;
     fix->ywrapstep = 0;
     fix->xpanstep  = 8;
@@ -1537,7 +1555,10 @@
     par->crtc.xoffset = xoffset;
     par->crtc.yoffset = yoffset;

-    offset = ((yoffset * par->crtc.vxres + xoffset) * par->crtc.bpp) >> 6;
+    offset = ((yoffset * par->crtc.vxres + xoffset)*(par->crtc.bpp >> 3)) & ~7;
+
+    if (par->crtc.bpp == 24)
+	offset += 8 * (offset % 3); /* Must be multiple of 8 and 3 */

     aty_st_le32(CRTC_OFFSET, offset);

@@ -1553,17 +1574,34 @@
 aty128fb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
 			struct fb_info *info)
 {
-#if 1
+#if 0
     fb_copy_cmap(&info->cmap, cmap, kspc ? 0 : 2);
 #else
-    struct fb_info_aty128 fb = (struct fb_info_aty128 *)info;
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)info;

     if (con == fb->currcon) /* current console? */
 	return fb_get_cmap(cmap, kspc, aty128_getcolreg, info);
     else if (fb_display[con].cmap.len) /* non default colormap? */
 	fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
     else {
+#if 1
+	int size;
+
+	switch (fb->current_par.crtc.depth) {
+	case 8:
+		size = 256;
+		break;
+	case 16:
+		size = 64;
+		break;
+	default:
+		size = 32;
+		break;	/* possible problems in kernel code without this */
+	}
+#else
 	int size = (fb_display[con].var.bits_per_pixel <= 8) ? 256 : 32;
+#endif
+
 	fb_copy_cmap(fb_default_cmap(size), cmap, kspc ? 0 : 2);
     }
 #endif
@@ -1589,7 +1627,24 @@
 	disp = info->disp;

     if (!disp->cmap.len) {      /* no colormap allocated? */
-        int size = (disp->var.bits_per_pixel <= 8) ? 256 : 32;
+#if 1
+	int size;
+
+	switch (fb->current_par.crtc.depth) {
+	case 8:
+		size = 256;
+		break;
+	case 16:
+		size = 64;
+		break;
+	default:
+		size = 32;
+		break;	/* possible problems in kernel code without this */
+	}
+#else
+	int size = (disp->var.bits_per_pixel <= 8) ? 256 : 32;
+#endif
+
 	if ((err = fb_alloc_cmap(&disp->cmap, size, 0)))
 	    return err;
     }
@@ -2211,6 +2266,7 @@
 {
     struct fb_info_aty128 *info = (struct fb_info_aty128 *)fb;
     u32 col;
+    u_int palreg;

     if (regno > 255)
 	return 1;
@@ -2233,7 +2289,7 @@
         if (info->chip_gen == rage_M3)
             aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) & ~DAC_PALETTE_ACCESS_CNTL);

-        for (i=16; i<256; i++) {
+        for (i=0; i<256; i++) {
             aty_st_8(PALETTE_INDEX, i);
             col = (i << 16) | (i << 8) | i;
             aty_st_le32(PALETTE_DATA, col);
@@ -2242,7 +2298,7 @@
         if (info->chip_gen == rage_M3) {
             aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) | DAC_PALETTE_ACCESS_CNTL);

-            for (i=16; i<256; i++) {
+            for (i=0; i<256; i++) {
                 aty_st_8(PALETTE_INDEX, i);
                 col = (i << 16) | (i << 8) | i;
                 aty_st_le32(PALETTE_DATA, col);
@@ -2256,27 +2312,41 @@
         aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) & ~DAC_PALETTE_ACCESS_CNTL);

     if (info->current_par.crtc.bpp == 16)
-        aty_st_8(PALETTE_INDEX, (regno << 3));
+    {
+        palreg = regno << 3;
+        if (info->current_par.crtc.depth == 16 && regno >= 32)
+	{
+        	palreg -= 252;
+		col = (info->palette[regno >> 1].red << 16) | (green << 8) | info->palette[regno >> 1].blue;
+	}
+	else
+		col = (red << 16) | (green << 8) | blue;
+    }
     else
-        aty_st_8(PALETTE_INDEX, regno);
-    col = (red << 16) | (green << 8) | blue;
+    {
+	palreg = regno;
+	col = (red << 16) | (green << 8) | blue;
+    }
+
+    aty_st_8(PALETTE_INDEX, palreg);
     aty_st_le32(PALETTE_DATA, col);
     if (info->chip_gen == rage_M3) {
     	aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) | DAC_PALETTE_ACCESS_CNTL);
-        if (info->current_par.crtc.bpp == 16)
-            aty_st_8(PALETTE_INDEX, (regno << 3));
-        else
-            aty_st_8(PALETTE_INDEX, regno);
+        aty_st_8(PALETTE_INDEX, palreg);
         aty_st_le32(PALETTE_DATA, col);
     }

     if (regno < 16)
-	switch (info->current_par.crtc.bpp) {
+	switch (info->current_par.crtc.depth) {
 #ifdef FBCON_HAS_CFB16
-	case 9 ... 16:
+	case 9 ... 15:
 	    info->fbcon_cmap.cfb16[regno] = (regno << 10) | (regno << 5) |
                 regno;
 	    break;
+	case 16:
+	    info->fbcon_cmap.cfb16[regno] = (regno << 11) | (regno << 6) |
+                regno;
+	    break;
 #endif
 #ifdef FBCON_HAS_CFB24
 	case 17 ... 24:
@@ -2309,7 +2379,24 @@
     if (fb_display[con].cmap.len)
 	fb_set_cmap(&fb_display[con].cmap, 1, aty128_setcolreg, info);
     else {
-	int size = (fb_display[con].var.bits_per_pixel <= 8) ? 256 : 16;
+#if 1
+	int size;
+
+	switch (fb->current_par.crtc.depth) {
+	case 8:
+		size = 256;
+		break;
+	case 16:
+		size = 64;
+		break;
+	default:
+		size = 32;
+		break;	/* possible problems in kernel code without this */
+	}
+#else
+	int size = (fb_display[con].var.bits_per_pixel <= 8) ? 256 : 32;
+#endif
+
 	fb_set_cmap(fb_default_cmap(size), 1, aty128_setcolreg, info);
     }
 }
@@ -2356,18 +2443,18 @@
 		u_int width, u_int height,
 		struct fb_info_aty128 *info)
 {
-    u32 save_dp_datatype, save_dp_cntl, bppval;
+    u32 save_dp_datatype, save_dp_cntl, dstval;

     if (!width || !height)
         return;

-    bppval = bpp_to_depth(info->current_par.crtc.bpp);
-    if (bppval == DST_24BPP) {
+    dstval = depth_to_dst(info->current_par.crtc.depth);
+    if (dstval == DST_24BPP) {
         srcx *= 3;
         dstx *= 3;
         width *= 3;
-    } else if (bppval == -EINVAL) {
-        printk("aty128fb: invalid depth\n");
+    } else if (dstval == -EINVAL) {
+        printk("aty128fb: invalid depth or RGBA\n");
         return;
     }

@@ -2379,7 +2466,7 @@
     aty_st_le32(SRC_Y_X, (srcy << 16) | srcx);
     aty_st_le32(DP_MIX, ROP3_SRCCOPY | DP_SRC_RECT);
     aty_st_le32(DP_CNTL, DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM);
-    aty_st_le32(DP_DATATYPE, save_dp_datatype | bppval | SRC_DSTCOLOR);
+    aty_st_le32(DP_DATATYPE, save_dp_datatype | dstval | SRC_DSTCOLOR);

     aty_st_le32(DST_Y_X, (dsty << 16) | dstx);
     aty_st_le32(DST_HEIGHT_WIDTH, (height << 16) | width);

--------------B0638311E315623FE1305CC2--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
