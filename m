Message-ID: <3A782739.63582B86@convergence.de>
Date: Wed, 31 Jan 2001 15:54:49 +0100
From: Andreas Hundt <andi@convergence.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: r128 DRI driver now fully functional on PPC
References: <3A76769B.87242FAA@valinux.com> <19341226052133.13170@mailhost.mipsys.com>
Content-Type: multipart/mixed;
 boundary="------------193FC5D8792CB1DE256486FD"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------193FC5D8792CB1DE256486FD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

> >
> >I've just committed the last of the updates required to get full hardware
> >accelerated 3D rendering with the ATI Rage 128 on PowerPC.  Many thanks
> >to Paul
> >Mackerras for allowing me to hack away on his machine over the last week!
> >
> >The code is available on the ati-pcigart-0-0-1-branch in the DRI CVS
> >repository.  Please feel free to check it out and report any problems you
> >have.
>
> I've done a first try and encountered a show-stopper (on this machine).
> The machine is a PowerBook G3 with a r128 M3 (mobility), 8Mb video mem.
> The issues are:
>
>  - DRI support works only in 16 and 24/32 bits. However, 16 bits is
> broken with UseFBDev and I can't use it without fbdev (see below). The
> colors are screwed up (but the server works. I didn't yet try 3D since I
> have not yet compiled a GL app to test with). 15 bits works fine with the
> kernel driver but it's unuspported for DRI.
> I beleive the aty128fb kernel driver need to be fixed for 16 bits.
>

I fixed this ages ago (screwed up colors and 16 bit support).
Read the README for details. thanks.

--
Andreas Hundt                              andi@convergence.de
Convergence Integrated Media GmbH          http://www.convergence.de
Rosenthaler Str. 51                        fon: +49(0)30-72 62 06 50
D-10178 Berlin                             fax: +49(0)30-72 62 06 55




--------------193FC5D8792CB1DE256486FD
Content-Type: text/plain; charset=us-ascii;
 name="README.atyfb_patch_2.4.0-andi"
Content-Disposition: inline;
 filename="README.atyfb_patch_2.4.0-andi"
Content-Transfer-Encoding: 7bit


Hi,

this patch is for linux-2.4.0-test12-pre4,
I included the full source file if you cannot use the patch.

It would be great if this patch would be included in the mainstream kernel.

Apply this patch this way:

1. copy it to linux/drivers/video/
2. change to that directory
3. type "patch -p0 < aty128fb_patch_2.4.0-andi"

--------------------------------------------------------------------
README:


This patch fixes/changes the following:

- driver now supports RGB565 16-bit mode

- pannig works now, allows correct dublebuffering, without jittering screen.

- FB_ACTIVATE_NOW and FB_ACTIVATE_VBL are now supported, CRTC_OFFSET_CNTL
  register is set correctly. aty128fb only accepted FB_ACTIVATE_NOW before
  but acted always like FB_ACTIVATE_VBL.
  This fix eliminates flickering in ClanLib (and other fbdev applications)
  when using doublebuffering.

- no more messed up colors in modes > 8 bpp. driver no longer uses hardware
  palette in modes > 8bpp, sets fbcon palette correctly instead.

- removed powerpc mmio endian conversion, since it is already done by
  readl() and writel() kernel functions

without this patch games like ClanBomber are a mess and unplayable.


--------------193FC5D8792CB1DE256486FD
Content-Type: text/plain; charset=us-ascii;
 name="aty128fb_patch_2.4.0-andi"
Content-Disposition: inline;
 filename="aty128fb_patch_2.4.0-andi"
Content-Transfer-Encoding: 7bit

--- aty128fb.c.orig	Mon Dec  4 17:30:03 2000
+++ aty128fb.c	Sat Dec  9 01:15:19 2000
@@ -432,36 +432,18 @@
 };
 #endif /* CONFIG_PMAC_BACKLIGHT */

-    /*
-     * Functions to read from/write to the mmio registers
-     *	- endian conversions may possibly be avoided by
-     *    using the other register aperture. TODO.
-     */
 static inline u32
 _aty_ld_le32(volatile unsigned int regindex,
                               const struct fb_info_aty128 *info)
 {
-    u32 val;
-
-#if defined(__powerpc__)
-    asm("lwbrx %0,%1,%2;eieio" : "=r"(val) : "b"(regindex), "r"(info->regbase));
-#else
-    val = readl (info->regbase + regindex);
-#endif
-
-    return val;
+    return  readl (info->regbase + regindex);
 }

 static inline void
 _aty_st_le32(volatile unsigned int regindex, u32 val,
                                const struct fb_info_aty128 *info)
 {
-#if defined(__powerpc__)
-    asm("stwbrx %0,%1,%2;eieio" : : "r"(val), "b"(regindex),
-                "r"(info->regbase) : "memory");
-#else
     writel (val, info->regbase + regindex);
-#endif
 }

 static inline u8
@@ -707,6 +689,7 @@
 		GMC_WRITE_MASK_SET);

     wait_for_fifo(8, info);
+
     /* clear the line drawing registers */
     aty_st_le32(DST_BRES_ERR, 0);
     aty_st_le32(DST_BRES_INC, 0);
@@ -735,7 +718,7 @@
     if (bpp <= 8)
 	return DST_8BPP;
     else if (bpp <= 16)
-        return DST_15BPP;
+        return DST_16BPP;
     else if (bpp <= 24)
 	return DST_24BPP;
     else if (bpp <= 32)
@@ -880,8 +863,12 @@
     crtc->pitch = vxres >> 3;

     crtc->offset = 0;
-    crtc->offset_cntl = 0;

+    if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW)
+        crtc->offset_cntl = 0x00010000;
+    else
+        crtc->offset_cntl = 0;
+
     crtc->vxres = vxres;
     crtc->vyres = vyres;
     crtc->xoffset = xoffset;
@@ -912,10 +899,10 @@
     case CRTC_PIX_WIDTH_15BPP:
     case CRTC_PIX_WIDTH_16BPP:
 	var->bits_per_pixel = 16;
-	var->red.offset = 10;
+	var->red.offset = 11;
 	var->red.length = 5;
 	var->green.offset = 5;
-	var->green.length = 5;
+	var->green.length = 6;
 	var->blue.offset = 0;
 	var->blue.length = 5;
 	var->transp.offset = 0;
@@ -1363,7 +1350,7 @@

     aty128_encode_var(var, &par, info);

-    if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
+    if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_TEST)
 	return 0;

     oldxres = display->var.xres;
@@ -1527,7 +1514,7 @@
     par->crtc.xoffset = xoffset;
     par->crtc.yoffset = yoffset;

-    offset = ((yoffset * par->crtc.vxres + xoffset) * par->crtc.bpp) >> 6;
+    offset = ((yoffset * par->crtc.vxres + xoffset) * par->crtc.bpp) >> 3;

     aty_st_le32(CRTC_OFFSET, offset);

@@ -2217,69 +2204,52 @@

     /* initialize gamma ramp for hi-color+ */

-    if ((info->current_par.crtc.bpp > 8) && (regno == 0)) {
+    if (info->current_par.crtc.bpp > 8) {
         int i;

-        if (info->chip_gen == rage_M3)
-            aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) & ~DAC_PALETTE_ACCESS_CNTL);
+        aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) & ~DAC_PALETTE_ACCESS_CNTL);

-        for (i=16; i<256; i++) {
+        for (i=0; i<256; i++) {
             aty_st_8(PALETTE_INDEX, i);
             col = (i << 16) | (i << 8) | i;
             aty_st_le32(PALETTE_DATA, col);
         }
-
-        if (info->chip_gen == rage_M3) {
-            aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) | DAC_PALETTE_ACCESS_CNTL);
-
-            for (i=16; i<256; i++) {
-                aty_st_8(PALETTE_INDEX, i);
-                col = (i << 16) | (i << 8) | i;
-                aty_st_le32(PALETTE_DATA, col);
-            }
-        }
     }
+    else {
+        /* initialize palette */

-    /* initialize palette */
-
-    if (info->chip_gen == rage_M3)
-        aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) & ~DAC_PALETTE_ACCESS_CNTL);
+        if (info->chip_gen == rage_M3)
+            aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) & ~DAC_PALETTE_ACCESS_CNTL);

-    if (info->current_par.crtc.bpp == 16)
-        aty_st_8(PALETTE_INDEX, (regno << 3));
-    else
         aty_st_8(PALETTE_INDEX, regno);
-    col = (red << 16) | (green << 8) | blue;
-    aty_st_le32(PALETTE_DATA, col);
-    if (info->chip_gen == rage_M3) {
-    	aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) | DAC_PALETTE_ACCESS_CNTL);
-        if (info->current_par.crtc.bpp == 16)
-            aty_st_8(PALETTE_INDEX, (regno << 3));
-        else
-            aty_st_8(PALETTE_INDEX, regno);
+        col = (red << 16) | (green << 8) | blue;
         aty_st_le32(PALETTE_DATA, col);
+        if (info->chip_gen == rage_M3) {
+            aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) | DAC_PALETTE_ACCESS_CNTL);
+	    aty_st_8(PALETTE_INDEX, regno);
+	    aty_st_le32(PALETTE_DATA, col);
+	}
     }

     if (regno < 16)
 	switch (info->current_par.crtc.bpp) {
 #ifdef FBCON_HAS_CFB16
 	case 9 ... 16:
-	    info->fbcon_cmap.cfb16[regno] = (regno << 10) | (regno << 5) |
-                regno;
+	    info->fbcon_cmap.cfb16[regno] =   ( ((red   & 0xF8) << 8) |
+	                                        ((green & 0xFC) << 3) |
+	                                        ((blue  & 0xF8) >> 3) );
 	    break;
 #endif
 #ifdef FBCON_HAS_CFB24
 	case 17 ... 24:
-	    info->fbcon_cmap.cfb24[regno] = (regno << 16) | (regno << 8) |
-		regno;
+	    info->fbcon_cmap.cfb24[regno] = (red << 16) | (green << 8) |
+		blue;
 	    break;
 #endif
 #ifdef FBCON_HAS_CFB32
 	case 25 ... 32: {
-            u32 i;
-
-            i = (regno << 8) | regno;
-            info->fbcon_cmap.cfb32[regno] = (i << 16) | i;
+	    info->fbcon_cmap.cfb24[regno] = 0xFF000000 | (red << 16) |
+	                                    (green << 8) | blue;
 	    break;
         }
 #endif
@@ -2378,7 +2348,7 @@

     wait_for_fifo(2, info);
     aty_st_le32(DP_DATATYPE, save_dp_datatype);
-    aty_st_le32(DP_CNTL, save_dp_cntl);
+    aty_st_le32(DP_CNTL, save_dp_cntl);
 }


@@ -2635,3 +2605,4 @@
     }
 }
 #endif /* MODULE */
+

--------------193FC5D8792CB1DE256486FD--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
