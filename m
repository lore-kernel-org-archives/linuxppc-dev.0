Message-ID: <3A2BEAB0.3056A043@nexus-tech.net>
Date: Mon, 04 Dec 2000 14:04:16 -0500
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: lcd823.c color macros
Content-Type: multipart/mixed;
 boundary="------------8C9F5AAD39FA85CD118B252A"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------8C9F5AAD39FA85CD118B252A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I don't think the following 2 macros (defined in lcd823.c) work for 8
bit color (bit_code = 3).

#define NBITS(bit_code)     (1 << (bit_code))
#define NCOLORS(bit_code)   (1 << NBITS(bit_code))

I'm not sure why this appears to work, although I haven't actually
tested it on real hardware.

I added 2 new members to the panel_info struct for specifying bpp and
colors. Attached is the patch for HHL CDK 1.2, kernel version 2.2.14.

Kyle.
--------------8C9F5AAD39FA85CD118B252A
Content-Type: text/plain; charset=us-ascii;
 name="lcd823patch"
Content-Disposition: inline;
 filename="lcd823patch"
Content-Transfer-Encoding: 7bit

--- lcd823.c.orig	Mon Dec  4 13:53:38 2000
+++ lcd823.c	Mon Dec  4 13:58:56 2000
@@ -59,6 +59,9 @@
     u_char	vl_vpw;		/* Vertical sync pulse width */
     u_char	vl_lcdac;	/* LCD AC timing */
     u_char	vl_wbf;		/* Wait between frames */
+
+    u_char      vl_bpp;         /* bits per pixel */
+    ushort      vl_colors;      /* colors */
 } vidinfo_t;

 #define NEC_TFT
@@ -73,7 +76,7 @@
  */
 static vidinfo_t panel_info = {
     640, 480, 132, 99, CFG_HIGH, CFG_HIGH, CFG_LOW, CFG_LOW, CFG_HIGH,
-    3, 0, 0, 1, 1, 144, 2, 0, 33
+    3, 0, 0, 1, 1, 144, 2, 0, 33, 8, 256
 };
 #endif

@@ -84,13 +87,10 @@
  */
 static vidinfo_t panel_info = {
     320, 240, 0, 0, CFG_HIGH, CFG_HIGH, CFG_HIGH, CFG_HIGH, CFG_HIGH,
-    3, 0, 0, 1, 1, 15, 4, 0, 3
+    3, 0, 0, 1, 1, 15, 4, 0, 3, 8, 256
 };
 #endif

-#define NBITS(bit_code)		(1 << (bit_code))
-#define NCOLORS(bit_code)	(1 << NBITS(bit_code))
-
 static struct fb_info fb_info;
 static struct display display;
 static int currcon = 0;
@@ -152,7 +152,7 @@
     if (fb_display[con].cmap.len != 0)
 	cmap = &fb_display[con].cmap;
     else
-	cmap = fb_default_cmap(NCOLORS(panel_info.vl_bpix));
+	cmap = fb_default_cmap(panel_info.vl_colors);

     fb_set_cmap(cmap, 1, lcd823_setcolreg, info);
 }
@@ -219,7 +219,7 @@
 	var->width = panel_info.vl_width;
 	var->height = panel_info.vl_height;

-	var->bits_per_pixel = NBITS(panel_info.vl_bpix);
+	var->bits_per_pixel = panel_info.vl_bpp;
 	var->grayscale = (panel_info.vl_clor == 0);
 	var->red.length = var->green.length = var->blue.length = 4;
     } else {
@@ -235,7 +235,7 @@
 {
     if ((var->xres != panel_info.vl_col)
 	|| (var->yres != panel_info.vl_row)
-	|| (var->bits_per_pixel != NBITS(panel_info.vl_bpix))
+	|| (var->bits_per_pixel != panel_info.vl_bpp)
 	|| (var->grayscale && panel_info.vl_clor)
 	|| ((var->grayscale == 0) && (panel_info.vl_clor == 0)))
     {
@@ -256,7 +256,7 @@
     if (panel_info.vl_bpix == 1)
 	return -EINVAL;

-    if ((cmap->start + cmap->len) > NCOLORS(panel_info.vl_bpix))
+    if ((cmap->start + cmap->len) > panel_info.vl_colors)
 	return -EINVAL;

     /* FIXME:  why can con be -1? */
@@ -266,7 +266,7 @@
     if (fb_display[con].cmap.len)
 	src_cmap = &fb_display[con].cmap;
     else
-	src_cmap = fb_default_cmap(NCOLORS(panel_info.vl_bpix));
+	src_cmap = fb_default_cmap(panel_info.vl_colors);
     fb_copy_cmap(src_cmap, cmap, kspc ? 0 : 2);

     return 0;
@@ -281,11 +281,11 @@
     if (panel_info.vl_bpix == 1)
 	return -EINVAL;

-    if ((cmap->start + cmap->len) > NCOLORS(panel_info.vl_bpix))
+    if ((cmap->start + cmap->len) > panel_info.vl_colors)
 	return -EINVAL;

     if (fb_display[con].cmap.len == 0) {
-        int size = NCOLORS(panel_info.vl_bpix);
+        int size = panel_info.vl_colors;
         if ((err = fb_alloc_cmap(&fb_display[con].cmap, size, 0)))
             return err;
     }
@@ -392,7 +392,7 @@
  */
 __initfunc(void lcd_fb_setpage(unsigned long *memory_page_addr))
 {
-    lcd_fb_line_length = (panel_info.vl_col * NBITS(panel_info.vl_bpix)) / 8;
+    lcd_fb_line_length = (panel_info.vl_col * panel_info.vl_bpp) / 8;
     lcd_fb_size = lcd_fb_line_length * panel_info.vl_row;

     /* Round up to nearest full page */

--------------8C9F5AAD39FA85CD118B252A--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
