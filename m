To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: A few questions.
References: <87k738ph42.fsf@hades.nocrew.org>
	<1075545982.4501.93.camel@gaston>
From: Stefan Berndtsson <stefan@nocrew.org>
Date: Sat, 31 Jan 2004 16:44:18 +0100
In-Reply-To: <1075545982.4501.93.camel@gaston> (Benjamin Herrenschmidt's
 message of "Sat, 31 Jan 2004 21:46:23 +1100")
Message-ID: <8765esp1gt.fsf@hades.nocrew.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-=-=

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sat, 2004-01-31 at 21:06, Stefan Berndtsson wrote:
>> First question:
>>
>> What is the status of m3mirror:ing with an ibook2 (600MHz from 2001)
>> using a 2.6 kernel? There was some patch sent out a long time ago, but
>> I couldn't get it to apply in any sensible way.
>
> That doesn't quite work yet. Someday, somebody (me ?) has to
> spend the time & dedication to setup the second output properly
> once for all =P

Ok, in the meantime, I took a patch for 2.4 and brutally stuffed it into
a 2.6.2-rc1-ben1. With some minor tweaking it now seems it actually works.

I assume the patch is much too specific and unfit to go in a proper kernel
release, but it's included below anyway.

/Stefan


--=-=-=
Content-Disposition: attachment; filename=aty128-m3mirror-2.6.diff
Content-Description: M3-Mirror patch for 2.6

diff -ur linux-2.6.2-rc1-ben1-orig/drivers/video/aty/aty128fb.c linux-2.6.2-rc1-ben1/drivers/video/aty/aty128fb.c
--- linux-2.6.2-rc1-ben1-orig/drivers/video/aty/aty128fb.c	2003-10-14 09:28:07.000000000 +0200
+++ linux-2.6.2-rc1-ben1/drivers/video/aty/aty128fb.c	2004-01-31 16:29:58.000000000 +0100
@@ -312,6 +312,11 @@
 	struct aty128_crtc crtc;
 	struct aty128_pll pll;
 	struct aty128_ddafifo fifo_reg;
+#ifdef CONFIG_PMAC_PBOOK
+        struct aty128_crtc crtc2;
+        struct aty128_pll pll2;
+        struct aty128_ddafifo fifo_reg2;
+#endif
 	u32 accel_flags;
 	struct aty128_constants constants;  /* PLL and others      */
 	void *regbase;                      /* remapped mmio       */
@@ -740,6 +745,28 @@
 	aty_st_pll(PPLL_CNTL, aty_ld_pll(PPLL_CNTL) & ~(0x00030000));
 }

+#ifdef CONFIG_PMAC_PBOOK
+/* Program the CRTC2 registers */
+static void
+aty128_set_crtc2(const struct aty128_crtc *crtc,
+		const struct aty128fb_par *par)
+{
+	aty_st_le32(CRTC2_GEN_CNTL, crtc->gen_cntl);
+
+	/* FIXME - Hardcodec */
+	aty_st_le32(CRTC2_H_TOTAL_DISP, crtc->h_total & ~0xf | 0xa);
+	aty_st_le32(CRTC2_H_SYNC_STRT_WID,
+		    crtc->h_sync_strt_wid & ~0xff | 0x10);
+
+	aty_st_le32(CRTC2_V_TOTAL_DISP, crtc->v_total);
+	aty_st_le32(CRTC2_V_SYNC_STRT_WID, crtc->v_sync_strt_wid);
+	aty_st_le32(CRTC2_PITCH, crtc->pitch);
+	aty_st_le32(CRTC2_OFFSET, crtc->offset);
+	aty_st_le32(CRTC2_OFFSET_CNTL, crtc->offset_cntl);
+	/* Disable ATOMIC updating.  Is this the right place? */
+	aty_st_pll(PPLL_CNTL, aty_ld_pll(PPLL_CNTL) & ~(0x00030000));
+}
+#endif

 static int
 aty128_var_to_crtc(const struct fb_var_screeninfo *var,
@@ -997,7 +1024,7 @@
 {
 	if (on) {
 		aty_st_le32(CRTC_EXT_CNTL, aty_ld_le32(CRTC_EXT_CNTL) | CRT_CRTC_ON);
-		aty_st_le32(DAC_CNTL, (aty_ld_le32(DAC_CNTL) | DAC_PALETTE2_SNOOP_EN));
+		aty_st_le32(DAC_CNTL, (aty_ld_le32(DAC_CNTL) | DAC_PALETTE2_SNOOP_EN | DAC_CLK_SEL));
 	} else
 		aty_st_le32(CRTC_EXT_CNTL, aty_ld_le32(CRTC_EXT_CNTL) & ~CRT_CRTC_ON);
 }
@@ -1069,6 +1096,45 @@
 	aty_st_pll(PPLL_CNTL, aty_ld_pll(PPLL_CNTL) & ~PPLL_RESET);
 }

+#ifdef CONFIG_PMAC_PBOOK
+static void
+aty128_set_pll2(struct aty128_pll *pll, const struct aty128fb_par *par)
+{
+	u32 div;
+
+	unsigned char post_conv[] =	/* register values for post dividers */
+        { 2, 0, 1, 4, 2, 2, 6, 2, 3, 2, 2, 2, 7 };
+
+	/* select PPLL_DIV_3 */
+	aty_st_le32(CLOCK_CNTL_INDEX, aty_ld_le32(CLOCK_CNTL_INDEX) | (3 << 8));
+
+	/* reset PLL */
+	aty_st_pll(P2PLL_CNTL,
+		   aty_ld_pll(P2PLL_CNTL) | PPLL_RESET | PPLL_ATOMIC_UPDATE_EN);
+
+	/* write the reference divider */
+	aty_pll_wait_readupdate(par);
+	aty_st_pll(P2PLL_REF_DIV, par->constants.ref_divider & 0x3ff);
+	aty_pll_writeupdate(par);
+
+	div = aty_ld_pll(P2PLL_DIV_0);
+	div &= ~XPLL_FB_DIV_MASK;
+	div |= pll->feedback_divider;
+	div |= post_conv[pll->post_divider] << 16;
+
+	/* write feedback and post dividers */
+	aty_pll_wait_readupdate(par);
+	aty_st_pll(P2PLL_DIV_0, div);
+	aty_pll_writeupdate(par);
+
+	aty_pll_wait_readupdate(par);
+	aty_st_pll(HTOTAL_CNTL, 0);	/* no horiz crtc adjustment */
+	aty_pll_writeupdate(par);
+
+	/* clear the reset, just in case */
+	aty_st_pll(P2PLL_CNTL, aty_ld_pll(P2PLL_CNTL) & ~PPLL_RESET);
+}
+#endif

 static int
 aty128_var_to_pll(u32 period_in_ps, struct aty128_pll *pll,
@@ -1130,6 +1196,16 @@
 	aty_st_le32(DDA_ON_OFF, dsp->dda_on_off);
 }

+#ifdef CONFIG_PMAC_PBOOK
+static void
+aty128_set_fifo2(const struct aty128_ddafifo *dsp,
+		 const struct aty128fb_par *par)
+{
+        /* FIXME - Hardcoded */
+	aty_st_le32(DDA2_CONFIG, 0x010502aa);
+	aty_st_le32(DDA2_ON_OFF, 0x11805a74);
+ }
+#endif

 static int
 aty128_ddafifo(struct aty128_ddafifo *dsp,
@@ -1245,6 +1321,9 @@
 	if (par->chip_gen == rage_M3) {
 		aty128_set_crt_enable(par, par->crt_on);
 		aty128_set_lcd_enable(par, par->lcd_on);
+		aty128_set_crtc2(&par->crtc2, par);
+		aty128_set_pll2(&par->pll2, par);
+		aty128_set_fifo2(&par->fifo_reg2, par);
 	}
 #endif
 	if (par->accel_flags & FB_ACCELF_TEXT)
@@ -1282,6 +1361,17 @@
 	if ((err = aty128_ddafifo(&fifo_reg, &pll, crtc.depth, par)))
 		return err;

+#ifdef CONFIG_PMAC_PBOOK
+	if ((err = aty128_var_to_crtc(var, &par->crtc2, par)))
+		return err;
+
+	if ((err = aty128_var_to_pll(var->pixclock, &par->pll2, par)))
+		return err;
+
+	if ((err = aty128_ddafifo(&par->fifo_reg2, &par->pll2, par->crtc2.depth, par)))
+		return err;
+#endif
+
 	par->crtc = crtc;
 	par->pll = pll;
 	par->fifo_reg = fifo_reg;
@@ -1370,7 +1460,7 @@
 	      struct aty128fb_par *par)
 {
 	if (par->chip_gen == rage_M3) {
-#if 0
+#if CONFIG_PMAC_PBOOK
 		/* Note: For now, on M3, we set palette on both heads, which may
 		 * be useless. Can someone with a M3 check this ?
 		 *
diff -ur linux-2.6.2-rc1-ben1-orig/include/video/aty128.h linux-2.6.2-rc1-ben1/include/video/aty128.h
--- linux-2.6.2-rc1-ben1-orig/include/video/aty128.h	2002-07-24 22:04:54.000000000 +0200
+++ linux-2.6.2-rc1-ben1/include/video/aty128.h	2004-01-31 15:19:02.000000000 +0100
@@ -258,7 +258,7 @@
 #define PLL_TEST_CNTL				0x0013
 #define P2PLL_CNTL				0x002a
 #define P2PLL_REF_DIV				0x002b
-#define P2PLL_DIV_0				0x002b
+#define P2PLL_DIV_0				0x002c
 #define POWER_MANAGEMENT			0x002f

 #define PPLL_RESET				0x01

--=-=-=--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
