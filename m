Date: Fri, 21 May 1999 23:00:54 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        ecd@vger.rutgers.edu, Jakub Jelinek <jj@sunsite.ms.mff.cuni.cz>,
        "David S. Miller" <davem@dm.cobaltmicro.com>
Subject: atyfb clockchip probe
Message-ID: <Pine.LNX.4.10.9905212259160.25445-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



This patch allows to probe for the crystal frequency on ATI boards (14 or 29
MHz). It allows atyfb to work on Josh Huber's Powerbook G3. Please test!

--- linux-2.2.7ac2/drivers/video/atyfb.c.orig	Sat May  8 16:06:27 1999
+++ linux-2.2.7ac2/drivers/video/atyfb.c	Sat May  8 19:46:19 1999
@@ -326,9 +326,7 @@
 static void init_engine(const struct atyfb_par *par, struct fb_info_aty *info);
 static void aty_st_514(int offset, u8 val, const struct fb_info_aty *info);
 static void aty_st_pll(int offset, u8 val, const struct fb_info_aty *info);
-#if defined(__sparc__) || defined(DEBUG)
 static u8 aty_ld_pll(int offset, const struct fb_info_aty *info);
-#endif
 static void aty_set_crtc(const struct fb_info_aty *info,
 			 const struct crtc *crtc);
 static int aty_var_to_crtc(const struct fb_info_aty *info,
@@ -405,7 +403,7 @@
 static int default_pll __initdata = 0;
 static int default_mclk __initdata = 0;
 
-static const u32 ref_clk_per = 1000000000000ULL/14318180;
+static u32 ref_clk_per;
 
 #if defined(CONFIG_PPC)
 static int default_vmode __initdata = VMODE_NVRAM;
@@ -689,7 +687,6 @@
     aty_st_8(CLOCK_CNTL + 1, (offset << 2) & ~PLL_WR_EN, info);
 }
 
-#if defined(__sparc__) || defined(DEBUG)
 static u8 aty_ld_pll(int offset, const struct fb_info_aty *info)
 {
     u8 res;
@@ -702,7 +699,6 @@
     eieio();
     return res;
 }
-#endif
 
 #if defined(CONFIG_PPC)
 
@@ -2432,11 +2428,12 @@
     int j, k;
     struct fb_var_screeninfo var;
     struct display *disp;
-    const char *chipname = NULL, *ramname = NULL;
+    const char *chipname = NULL, *ramname = NULL, *xtal;
     int pll, mclk, gtb_memsize;
 #if defined(CONFIG_PPC)
     int sense;
 #endif
+    u8 pll_ref_div;
 
     info->aty_cmap_regs = (struct aty_cmap_regs *)(info->ati_regbase+0xc0);
     chip_id = aty_ld_le32(CONFIG_CHIP_ID, info);
@@ -2524,6 +2521,25 @@
 	}
     }
 
+    ref_clk_per = 1000000000000ULL/14318180;
+    xtal = "14.31818";
+    if (!(Gx == GX_CHIP_ID || Gx == CX_CHIP_ID || Gx == CT_CHIP_ID ||
+	  Gx == ET_CHIP_ID ||
+	  ((Gx == VT_CHIP_ID || Gx == GT_CHIP_ID) && !(Rev & 0x07))) &&
+	(pll_ref_div = aty_ld_pll(PLL_REF_DIV, info))) {
+	int diff1, diff2;
+	diff1 = 510*14/pll_ref_div-pll;
+	diff2 = 510*29/pll_ref_div-pll;
+	if (diff1 < 0)
+	    diff1 = -diff1;
+	if (diff2 < 0)
+	    diff2 = -diff2;
+	if (diff2 < diff1) {
+	    ref_clk_per = 1000000000000ULL/29498928;
+	    xtal = "29.498928";
+	}
+    }
+
     i = aty_ld_le32(MEM_CNTL, info);
     gtb_memsize = !(Gx == GX_CHIP_ID || Gx == CX_CHIP_ID || Gx == CT_CHIP_ID ||
 		    Gx == ET_CHIP_ID ||
@@ -2602,9 +2618,9 @@
     if (default_mclk)
 	mclk = default_mclk;
 
-    printk("%d%c %s, %d MHz PLL, %d Mhz MCLK\n", 
+    printk("%d%c %s, %s MHz XTAL %d MHz PLL, %d Mhz MCLK\n", 
     	   info->total_vram == 0x80000 ? 512 : (info->total_vram >> 20), 
-    	   info->total_vram == 0x80000 ? 'K' : 'M', ramname, pll, mclk);
+    	   info->total_vram == 0x80000 ? 'K' : 'M', ramname, xtal, pll, mclk);
 
     if (mclk < 44)
 	info->mem_refresh_rate = 0;	/* 000 = 10 Mhz - 43 Mhz */

Greetings,
--
Geert (Hacker@LinuxExpo)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
