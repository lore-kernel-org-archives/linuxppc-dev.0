Subject: [PATCH] ATY128 M3 Mirroring Fixes
From: Owen Stampflee <owen@stampflee.com>
To: linuxppc-dev@lists.linuxppc.org,
	linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-qM2uEXoDfIiAJhEJi86v"
Message-Id: <1055379126.1005.10.camel@marble.lan.stampflee.com>
Mime-Version: 1.0
Date: 11 Jun 2003 17:54:43 -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-qM2uEXoDfIiAJhEJi86v
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit


This patch enables and configures the 2nd CRTC/PLL/DDA which gives
crystal clear output on my Dual USB iBook / ViewSonic A70F. Previously,
straight lines looked like a sin graph.

It's not finished, as there are few values hardcoded, but more testing
on other Apple laptops / Monitors and I'm looking for feedback.

Thanks,
Owen

PS - against 2.4.21-rc6-ben0

--
Owen Stampflee - owen@stampflee.com - http://www.stampflee.com
GnuPG Fingerprint: EDE6 48EC 4E65 BE83 D405Â  B091 B170 8AF0 F875 65E0
Download My Public Key: http://www.stampflee.com/owen.asc

--=-qM2uEXoDfIiAJhEJi86v
Content-Disposition: attachment; filename=aty128-mirror-fixes.patch
Content-Type: text/plain; name=aty128-mirror-fixes.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- aty128fb.c.orig	2003-06-11 17:36:57.000000000 -0700
+++ aty128fb.c	2003-06-11 17:34:37.000000000 -0700
@@ -286,6 +286,13 @@
     struct aty128_crtc crtc;
     struct aty128_pll pll;
     struct aty128_ddafifo fifo_reg;
+
+#ifdef CONFIG_PMAC_PBOOK
+    struct aty128_crtc crtc2;
+    struct aty128_pll pll2;
+    struct aty128_ddafifo fifo_reg2;
+#endif
+
     u32 accel_flags;
 };

@@ -799,10 +806,32 @@
     aty_st_le32(CRTC_PITCH, crtc->pitch);
     aty_st_le32(CRTC_OFFSET, crtc->offset);
     aty_st_le32(CRTC_OFFSET_CNTL, crtc->offset_cntl);
+
     /* Disable ATOMIC updating.  Is this the right place? */
     aty_st_pll(PPLL_CNTL, aty_ld_pll(PPLL_CNTL) & ~(0x00030000));
 }

+#ifdef CONFIG_PMAC_PBOOK
+static void
+aty128_set_crtc2(const struct aty128_crtc *crtc,
+	const struct fb_info_aty128 *info)
+{
+
+    aty_st_le32(CRTC2_GEN_CNTL, crtc->gen_cntl);
+
+    /* FIXME - Hardcoded */
+    aty_st_le32(CRTC2_H_TOTAL_DISP, crtc->h_total & ~0xf | 0xa);
+    aty_st_le32(CRTC2_H_SYNC_STRT_WID, crtc->h_sync_strt_wid & ~0xff | 0x10 );
+
+    aty_st_le32(CRTC2_V_TOTAL_DISP, crtc->v_total);
+    aty_st_le32(CRTC2_V_SYNC_STRT_WID, crtc->v_sync_strt_wid);
+    aty_st_le32(CRTC2_PITCH, crtc->pitch);
+    aty_st_le32(CRTC2_OFFSET, crtc->offset);
+    aty_st_le32(CRTC2_OFFSET_CNTL, crtc->offset_cntl);
+
+}
+#endif
+

 static int
 aty128_var_to_crtc(const struct fb_var_screeninfo *var,
@@ -1066,9 +1095,11 @@
 {
     if (on) {
 	aty_st_le32(CRTC_EXT_CNTL, aty_ld_le32(CRTC_EXT_CNTL) | CRT_CRTC_ON);
-	aty_st_le32(DAC_CNTL, (aty_ld_le32(DAC_CNTL) | DAC_PALETTE2_SNOOP_EN));
-    } else
+	aty_st_le32(DAC_CNTL, (aty_ld_le32(DAC_CNTL) |
+			DAC_PALETTE2_SNOOP_EN | DAC_CLK_SEL));
+    } else {
 	aty_st_le32(CRTC_EXT_CNTL, aty_ld_le32(CRTC_EXT_CNTL) & ~CRT_CRTC_ON);
+    }
 }

 static void
@@ -1153,6 +1184,47 @@
 #endif
 }

+#ifdef CONFIG_PMAC_PBOOK
+static void
+aty128_set_pll2(struct aty128_pll *pll, const struct fb_info_aty128 *info)
+{
+    u32 div;
+
+    unsigned char post_conv[] =	/* register values for post dividers */
+        { 2, 0, 1, 4, 2, 2, 6, 2, 3, 2, 2, 2, 7 };
+
+    /* reset PLL */
+    aty_st_pll(P2PLL_CNTL,
+		aty_ld_pll(P2PLL_CNTL) | PPLL_RESET | PPLL_ATOMIC_UPDATE_EN);
+
+    /* write the reference divider */
+    aty_pll_wait_readupdate(info);
+    aty_st_pll(P2PLL_REF_DIV, info->constants.ref_divider & 0x3ff);
+    aty_pll_writeupdate(info);
+
+    div = aty_ld_pll(P2PLL_DIV_0);
+    div &= ~XPLL_FB_DIV_MASK;
+    div |= pll->feedback_divider;
+    div |= post_conv[pll->post_divider] << 16;
+
+    /* write feedback and post dividers */
+    aty_pll_wait_readupdate(info);
+    aty_st_pll(P2PLL_DIV_0, div);
+    aty_pll_writeupdate(info);
+
+    aty_pll_wait_readupdate(info);
+    aty_st_pll(HTOTAL_CNTL, 0);	/* no horiz crtc adjustment */
+    aty_pll_writeupdate(info);
+
+
+    /* clear the reset, just in case */
+    aty_st_pll(P2PLL_CNTL, aty_ld_pll(P2PLL_CNTL) & ~PPLL_RESET);
+
+}
+#endif
+
+
+

 static int
 aty128_var_to_pll(u32 period_in_ps, struct aty128_pll *pll,
@@ -1215,6 +1287,16 @@
     aty_st_le32(DDA_ON_OFF, dsp->dda_on_off);
 }

+#ifdef CONFIG_PMAC_PBOOK
+static void
+aty128_set_fifo2(const struct aty128_ddafifo *dsp,
+			const struct fb_info_aty128 *info)
+{
+    /* FIXME - Hardcoded */
+    aty_st_le32(DDA2_CONFIG, 0x010502aa);
+    aty_st_le32(DDA2_ON_OFF, 0x11805a74);
+}
+#endif

 static int
 aty128_ddafifo(struct aty128_ddafifo *dsp,
@@ -1308,6 +1390,14 @@
     aty128_set_pll(&par->pll, info);
     aty128_set_fifo(&par->fifo_reg, info);

+#ifdef CONFIG_PMAC_PBOOK
+    if(info->chip_gen == rage_M3) {
+       aty128_set_crtc2(&par->crtc2, info);
+       aty128_set_pll2(&par->pll2, info);
+       aty128_set_fifo2(&par->fifo_reg2, info);
+    }
+#endif
+
     config = aty_ld_le32(CONFIG_CNTL) & ~3;

 #if defined(__BIG_ENDIAN)
@@ -1378,6 +1468,18 @@
     if ((err = aty128_ddafifo(&par->fifo_reg, &par->pll, par->crtc.depth, info)))
 	return err;

+#ifdef CONFIG_PMAC_PBOOK
+
+    if ((err = aty128_var_to_crtc(var, &par->crtc2, info)))
+	return err;
+
+    if ((err = aty128_var_to_pll(var->pixclock, &par->pll2, info)))
+	return err;
+
+    if ((err = aty128_ddafifo(&par->fifo_reg2, &par->pll2, par->crtc2.depth, info)))
+	return err;
+#endif
+
     if (var->accel_flags & FB_ACCELF_TEXT)
 	par->accel_flags = FB_ACCELF_TEXT;
     else
@@ -1722,7 +1824,7 @@
      */

     if (info->chip_gen == rage_M3) {
-#if 0
+#ifdef CONFIG_PMAC_PBOOK
         aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) | DAC_PALETTE_ACCESS_CNTL);
         aty_st_8(PALETTE_INDEX, regno);
         aty_st_le32(PALETTE_DATA, (red<<16)|(green<<8)|blue);
@@ -1766,6 +1868,7 @@
 	    fontname[i] = 0;
 	} else if (!strncmp(this_opt, "noaccel", 7)) {
 	    noaccel = 1;
+
 #ifdef CONFIG_PMAC_PBOOK
         } else if (!strncmp(this_opt, "lcd:", 4)) {
             default_lcd_on = simple_strtoul(this_opt+4, NULL, 0);
--- aty128.h.orig	2003-06-11 17:37:11.000000000 -0700
+++ aty128.h	2003-06-11 16:27:54.000000000 -0700
@@ -258,7 +258,7 @@
 #define PLL_TEST_CNTL				0x0013
 #define P2PLL_CNTL				0x002a
 #define P2PLL_REF_DIV				0x002b
-#define P2PLL_DIV_0				0x002b
+#define P2PLL_DIV_0				0x002c
 #define POWER_MANAGEMENT			0x002f

 #define PPLL_RESET				0x01

--=-qM2uEXoDfIiAJhEJi86v--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
