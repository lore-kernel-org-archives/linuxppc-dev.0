Date: Tue, 16 Mar 1999 13:00:24 -0500 (EST)
From: abew <awhite@dartmouth.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: PB G3 Video (for the developers)
In-Reply-To: <Pine.LNX.4.03.9903160948410.31092-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.3.96.990316125051.3874B-100000@hamish.dartmouth.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > MacOS display is /pci/ATY,RageLTPro
> > atyfb: 3D RAGE LT PRO [0x4c50 rev 0xdc] 4M SGRAM, 135 MHz PLL, 100 Mhz
>                          ^^^^^^
> I.e. LP_CHIP_ID

Yup.  Figured that much out.

> 
> Please use the `-u' option of diff next time so we can see contexts. And in
> which order have you diffed the files?

OK, sorry... I haven't dealt much with diffs.  Here is a 
'diff -u ORIG NEW' from the top of the linux source tree:

Oh, and I totally understand that time is short for many of us right now;
obviously this isn't too urgent.  It really would be nice if eventually
all PB G3 users could take advantage of their video hardware in Linux,
though.  Anyways, here ya go:


--- drivers/video/atyfb.c.orig  Tue Mar 16 12:54:10 1999
+++ drivers/video/atyfb.c       Tue Mar 16 12:55:02 1999
@@ -326,7 +326,8 @@
 static void init_engine(const struct atyfb_par *par, struct fb_info_aty
*info);
 static void aty_st_514(int offset, u8 val, const struct fb_info_aty
*info);
 static void aty_st_pll(int offset, u8 val, const struct fb_info_aty
*info);
-#if defined(__sparc__) || defined(DEBUG)
+#if 1
+/*#if defined(__sparc__) || defined(DEBUG) */
 static u8 aty_ld_pll(int offset, const struct fb_info_aty *info);
 #endif
 static void aty_set_crtc(const struct fb_info_aty *info,
@@ -690,7 +691,8 @@
     aty_st_8(CLOCK_CNTL + 1, (offset << 2) & ~PLL_WR_EN, info);
 }
 
-#if defined(__sparc__) || defined(DEBUG)
+#if 1
+/*#if defined(__sparc__) || defined(DEBUG) */
 static u8 aty_ld_pll(int offset, const struct fb_info_aty *info)
 {
     u8 res;
@@ -1473,6 +1475,9 @@
 static void aty_set_pll_ct(const struct fb_info_aty *info,
                           const struct pll_ct *pll)
 {
+
+    return;
+
     aty_st_pll(PLL_REF_DIV, pll->pll_ref_div, info);
     aty_st_pll(PLL_GEN_CNTL, pll->pll_gen_cntl, info);
     aty_st_pll(MCLK_FB_DIV, pll->mclk_fb_div, info);
@@ -1614,7 +1619,7 @@
         (Gx == GV_CHIP_ID) || (Gx == GW_CHIP_ID) || (Gx == GZ_CHIP_ID) ||
         (Gx == LG_CHIP_ID) || (Gx == GB_CHIP_ID) || (Gx == GD_CHIP_ID) ||
         (Gx == GI_CHIP_ID) || (Gx == GP_CHIP_ID) || (Gx == GQ_CHIP_ID) ||
-        (Gx == VU_CHIP_ID)) && (info->ram_type >= SDRAM))
+        (Gx == VU_CHIP_ID) || (Gx == LP_CHIP_ID)) && (info->ram_type >=
SDRAM))
        pll_gen_cntl = 0x04;
     else
        pll_gen_cntl = 0x84;
@@ -2356,7 +2361,7 @@
                if (Gx == GT_CHIP_ID || Gx == GU_CHIP_ID || Gx ==
GV_CHIP_ID ||
                    Gx == GW_CHIP_ID || Gx == GZ_CHIP_ID || Gx ==
LG_CHIP_ID ||
                    Gx == GB_CHIP_ID || Gx == GD_CHIP_ID || Gx ==
GI_CHIP_ID ||
-                   Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID)
+                   Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID || Gx ==
LP_CHIP_ID)
                        tmp |= 0x2;
                aty_st_8(DAC_CNTL, tmp, info);
                aty_st_8(DAC_MASK, 0xff, info);
@@ -2503,10 +2508,13 @@
                       Gx == GI_CHIP_ID || Gx == GP_CHIP_ID ||
                       Gx == GQ_CHIP_ID || Gx == LB_CHIP_ID ||
                       Gx == LD_CHIP_ID || Gx == LG_CHIP_ID ||
-                      Gx == LI_CHIP_ID || Gx == LP_CHIP_ID) {
+                      Gx == LI_CHIP_ID) {
                /* RAGE PRO or LT PRO */
                pll = 230;
                mclk = 100;
+           } else if (Gx == LP_CHIP_ID) {
+               mclk = 100;
+               pll = 135;
            } else {
                /* other RAGE */
                pll = 135;
@@ -2641,15 +2649,19 @@
 
 #if defined(CONFIG_PPC)
     if (default_vmode == VMODE_NVRAM) {
-       default_vmode = nvram_read_byte(NV_VMODE);
-       if (default_vmode <= 0 || default_vmode > VMODE_MAX)
-           default_vmode = VMODE_CHOOSE;
+        if (Gx == LP_CHIP_ID) {
+           default_vmode = VMODE_1024_768_60;
+        } else {
+           default_vmode = nvram_read_byte(NV_VMODE);
+           if (default_vmode <= 0 || default_vmode > VMODE_MAX)
+               default_vmode = VMODE_CHOOSE;
+       }
     }
     if (default_vmode == VMODE_CHOOSE) {
-       if (Gx == LG_CHIP_ID)
+      if (Gx == LG_CHIP_ID || Gx == LP_CHIP_ID) {
            /* G3 PowerBook with 1024x768 LCD */
            default_vmode = VMODE_1024_768_60;
-       else {
+       } else {
            sense = read_aty_sense(info);
            default_vmode = mac_map_monitor_sense(sense);
        }
@@ -3372,7 +3384,7 @@
     if (Gx == GT_CHIP_ID || Gx == GU_CHIP_ID || Gx == GV_CHIP_ID ||
        Gx == GW_CHIP_ID || Gx == GZ_CHIP_ID || Gx == LG_CHIP_ID ||
        Gx == GB_CHIP_ID || Gx == GD_CHIP_ID || Gx == GI_CHIP_ID ||
-       Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID)
+       Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID || Gx == LP_CHIP_ID)
        i |= 0x2;       /*DAC_CNTL|0x2 turns off the extra brightness for
gt*/
     aty_st_8(DAC_CNTL, i, info);
     aty_st_8(DAC_MASK, 0xff, info);


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
