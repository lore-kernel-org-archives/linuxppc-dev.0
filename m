Return-Path: <SRS0+86a1b39499f581948ba9+463+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 27E282BF0F
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2004 10:26:19 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1101280145.4511.4.camel@gaston>
References: <1101280145.4511.4.camel@gaston>
Content-Type: text/plain
Date: Mon, 29 Nov 2004 23:25:57 +0000
Message-Id: <1101770757.6960.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: fedora-ppc@lists.infradead.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep patch #5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

< Added fedora-ppc list to Cc, again. >

On Wed, 2004-11-24 at 18:09 +1100, Benjamin Herrenschmidt wrote:
> Ok, here's the 5th version of the sleep patch for ATI based albooks &
> iBook G4. Other machine users, please test too as it may cause
> regressions (or improvements) as well.
> 
> Not many changes since last version, I don't know why sometimes, the
> panel doesn't come back properly (though a new sleep cycle tends to fix
> it) and I have no fix for the USB issues. However, I added some hacks to
> the cache flush code based on what Apple does in Darwin that may help
> make the thing more robust, and I added a hook mecanism that allow the
> video to be restored _very_ early on wakeup, pretty much before
> everything else, thus making it easier to spot & debug crashes on
> wakeup.
> 
> There are still pending issues, like cpufreq on some machines will
> "think" it's running at full speed on wakeup while it's in fact running
> at slow speed (thankfully not the opposite), I will try to fix those in
> the next iteration.
> 
> http://gate.crashing.org/~benh/albook-ibookg4-sleep-5.diff

Fedora Core 3 kernels in yum repo at
ftp://ftp.uk.linux.org/pub/people/dwmw2/fc3-kernel-ppc/kernel*688*.rpm

I had to update the stack abuse patch to cope...

Suppose I ought to do those signal and single-stepping patches for ppc
too.

--- linux/drivers/video/aty/radeon_base.c.stk	2004-11-29 15:46:08.118064048 +0000
+++ linux/drivers/video/aty/radeon_base.c	2004-11-29 15:50:19.362937880 +0000
@@ -1483,20 +1483,24 @@ static int radeonfb_set_par(struct fb_in
 {
 	struct radeonfb_info *rinfo = info->par;
 	struct fb_var_screeninfo *mode = &info->var;
-	struct radeon_regs newmode;
+	struct radeon_regs *newmode;
 	int hTotal, vTotal, hSyncStart, hSyncEnd,
 	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
 	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
 	u8 hsync_fudge_fp[] = {2, 2, 0, 0, 5, 5};
 	u32 sync, h_sync_pol, v_sync_pol, dotClock, pixClock;
 	int i, freq;
-        int format = 0;
+	int format = 0;
 	int nopllcalc = 0;
 	int hsync_start, hsync_fudge, bytpp, hsync_wid, vsync_wid;
 	int primary_mon = PRIMARY_MONITOR(rinfo);
 	int depth = var_to_depth(mode);
 	int use_rmx = 0;
 
+	newmode = kmalloc(sizeof(struct radeon_regs), GFP_KERNEL);
+	if (!newmode)
+		return -ENOMEM;
+
 	/* We always want engine to be idle on a mode switch, even
 	 * if we won't actually change the mode
 	 */
@@ -1536,9 +1540,9 @@ static int radeonfb_set_par(struct fb_in
 
 		if (rinfo->panel_info.use_bios_dividers) {
 			nopllcalc = 1;
-			newmode.ppll_div_3 = rinfo->panel_info.fbk_divider |
+			newmode->ppll_div_3 = rinfo->panel_info.fbk_divider |
 				(rinfo->panel_info.post_divider << 16);
-			newmode.ppll_ref_div = rinfo->panel_info.ref_divider;
+			newmode->ppll_ref_div = rinfo->panel_info.ref_divider;
 		}
 	}
 	dotClock = 1000000000 / pixClock;
@@ -1576,38 +1580,38 @@ static int radeonfb_set_par(struct fb_in
 
 	hsync_start = hSyncStart - 8 + hsync_fudge;
 
-	newmode.crtc_gen_cntl = CRTC_EXT_DISP_EN | CRTC_EN |
+	newmode->crtc_gen_cntl = CRTC_EXT_DISP_EN | CRTC_EN |
 				(format << 8);
 
 	/* Clear auto-center etc... */
-	newmode.crtc_more_cntl = rinfo->init_state.crtc_more_cntl;
-	newmode.crtc_more_cntl &= 0xfffffff0;
+	newmode->crtc_more_cntl = rinfo->init_state.crtc_more_cntl;
+	newmode->crtc_more_cntl &= 0xfffffff0;
 	
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
-		newmode.crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN;
+		newmode->crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN;
 		if (mirror)
-			newmode.crtc_ext_cntl |= CRTC_CRT_ON;
+			newmode->crtc_ext_cntl |= CRTC_CRT_ON;
 
-		newmode.crtc_gen_cntl &= ~(CRTC_DBL_SCAN_EN |
+		newmode->crtc_gen_cntl &= ~(CRTC_DBL_SCAN_EN |
 					   CRTC_INTERLACE_EN);
 	} else {
-		newmode.crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN |
+		newmode->crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN |
 					CRTC_CRT_ON;
 	}
 
-	newmode.dac_cntl = /* INREG(DAC_CNTL) | */ DAC_MASK_ALL | DAC_VGA_ADR_EN |
+	newmode->dac_cntl = /* INREG(DAC_CNTL) | */ DAC_MASK_ALL | DAC_VGA_ADR_EN |
 			   DAC_8BIT_EN;
 
-	newmode.crtc_h_total_disp = ((((hTotal / 8) - 1) & 0x3ff) |
+	newmode->crtc_h_total_disp = ((((hTotal / 8) - 1) & 0x3ff) |
 				     (((mode->xres / 8) - 1) << 16));
 
-	newmode.crtc_h_sync_strt_wid = ((hsync_start & 0x1fff) |
+	newmode->crtc_h_sync_strt_wid = ((hsync_start & 0x1fff) |
 					(hsync_wid << 16) | (h_sync_pol << 23));
 
-	newmode.crtc_v_total_disp = ((vTotal - 1) & 0xffff) |
+	newmode->crtc_v_total_disp = ((vTotal - 1) & 0xffff) |
 				    ((mode->yres - 1) << 16);
 
-	newmode.crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
+	newmode->crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
 					 (vsync_wid << 16) | (v_sync_pol  << 23));
 
 	if (!(info->flags & FBINFO_HWACCEL_DISABLED)) {
@@ -1616,18 +1620,18 @@ static int radeonfb_set_par(struct fb_in
  				& ~(0x3f)) >> 6;
 
 		/* Then, re-multiply it to get the CRTC pitch */
-		newmode.crtc_pitch = (rinfo->pitch << 3) / ((mode->bits_per_pixel + 1) / 8);
+		newmode->crtc_pitch = (rinfo->pitch << 3) / ((mode->bits_per_pixel + 1) / 8);
 	} else
-		newmode.crtc_pitch = (mode->xres_virtual >> 3);
+		newmode->crtc_pitch = (mode->xres_virtual >> 3);
 
-	newmode.crtc_pitch |= (newmode.crtc_pitch << 16);
+	newmode->crtc_pitch |= (newmode->crtc_pitch << 16);
 
 	/*
 	 * It looks like recent chips have a problem with SURFACE_CNTL,
 	 * setting SURF_TRANSLATION_DIS completely disables the
 	 * swapper as well, so we leave it unset now.
 	 */
-	newmode.surface_cntl = 0;
+	newmode->surface_cntl = 0;
 
 #if defined(__BIG_ENDIAN)
 
@@ -1637,28 +1641,28 @@ static int radeonfb_set_par(struct fb_in
 	 */
 	switch (mode->bits_per_pixel) {
 		case 16:
-			newmode.surface_cntl |= NONSURF_AP0_SWP_16BPP;
-			newmode.surface_cntl |= NONSURF_AP1_SWP_16BPP;
+			newmode->surface_cntl |= NONSURF_AP0_SWP_16BPP;
+			newmode->surface_cntl |= NONSURF_AP1_SWP_16BPP;
 			break;
 		case 24:	
 		case 32:
-			newmode.surface_cntl |= NONSURF_AP0_SWP_32BPP;
-			newmode.surface_cntl |= NONSURF_AP1_SWP_32BPP;
+			newmode->surface_cntl |= NONSURF_AP0_SWP_32BPP;
+			newmode->surface_cntl |= NONSURF_AP1_SWP_32BPP;
 			break;
 	}
 #endif
 
 	/* Clear surface registers */
 	for (i=0; i<8; i++) {
-		newmode.surf_lower_bound[i] = 0;
-		newmode.surf_upper_bound[i] = 0x1f;
-		newmode.surf_info[i] = 0;
+		newmode->surf_lower_bound[i] = 0;
+		newmode->surf_upper_bound[i] = 0x1f;
+		newmode->surf_info[i] = 0;
 	}
 
 	RTRACE("h_total_disp = 0x%x\t   hsync_strt_wid = 0x%x\n",
-		newmode.crtc_h_total_disp, newmode.crtc_h_sync_strt_wid);
+		newmode->crtc_h_total_disp, newmode->crtc_h_sync_strt_wid);
 	RTRACE("v_total_disp = 0x%x\t   vsync_strt_wid = 0x%x\n",
-		newmode.crtc_v_total_disp, newmode.crtc_v_sync_strt_wid);
+		newmode->crtc_v_total_disp, newmode->crtc_v_sync_strt_wid);
 
 	rinfo->bpp = mode->bits_per_pixel;
 	rinfo->depth = depth;
@@ -1667,13 +1671,13 @@ static int radeonfb_set_par(struct fb_in
 	RTRACE("freq = %lu\n", (unsigned long)freq);
 
 	/* We use PPLL_DIV_3 */
-	newmode.clk_cntl_index = 0x300;
+	newmode->clk_cntl_index = 0x300;
 
 	/* Calculate PPLL value if necessary */
 	if (!nopllcalc)
-		radeon_calc_pll_regs(rinfo, &newmode, freq);
+		radeon_calc_pll_regs(rinfo, newmode, freq);
 
-	newmode.vclk_ecp_cntl = rinfo->init_state.vclk_ecp_cntl;
+	newmode->vclk_ecp_cntl = rinfo->init_state.vclk_ecp_cntl;
 
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
 		unsigned int hRatio, vRatio;
@@ -1683,37 +1687,37 @@ static int radeonfb_set_par(struct fb_in
 		if (mode->yres > rinfo->panel_info.yres)
 			mode->yres = rinfo->panel_info.yres;
 
-		newmode.fp_horz_stretch = (((rinfo->panel_info.xres / 8) - 1)
+		newmode->fp_horz_stretch = (((rinfo->panel_info.xres / 8) - 1)
 					   << HORZ_PANEL_SHIFT);
-		newmode.fp_vert_stretch = ((rinfo->panel_info.yres - 1)
+		newmode->fp_vert_stretch = ((rinfo->panel_info.yres - 1)
 					   << VERT_PANEL_SHIFT);
 
 		if (mode->xres != rinfo->panel_info.xres) {
 			hRatio = round_div(mode->xres * HORZ_STRETCH_RATIO_MAX,
 					   rinfo->panel_info.xres);
-			newmode.fp_horz_stretch = (((((unsigned long)hRatio) & HORZ_STRETCH_RATIO_MASK)) |
-						   (newmode.fp_horz_stretch &
+			newmode->fp_horz_stretch = (((((unsigned long)hRatio) & HORZ_STRETCH_RATIO_MASK)) |
+						   (newmode->fp_horz_stretch &
 						    (HORZ_PANEL_SIZE | HORZ_FP_LOOP_STRETCH |
 						     HORZ_AUTO_RATIO_INC)));
-			newmode.fp_horz_stretch |= (HORZ_STRETCH_BLEND |
+			newmode->fp_horz_stretch |= (HORZ_STRETCH_BLEND |
 						    HORZ_STRETCH_ENABLE);
 			use_rmx = 1;
 		}
-		newmode.fp_horz_stretch &= ~HORZ_AUTO_RATIO;
+		newmode->fp_horz_stretch &= ~HORZ_AUTO_RATIO;
 
 		if (mode->yres != rinfo->panel_info.yres) {
 			vRatio = round_div(mode->yres * VERT_STRETCH_RATIO_MAX,
 					   rinfo->panel_info.yres);
-			newmode.fp_vert_stretch = (((((unsigned long)vRatio) & VERT_STRETCH_RATIO_MASK)) |
-						   (newmode.fp_vert_stretch &
+			newmode->fp_vert_stretch = (((((unsigned long)vRatio) & VERT_STRETCH_RATIO_MASK)) |
+						   (newmode->fp_vert_stretch &
 						   (VERT_PANEL_SIZE | VERT_STRETCH_RESERVED)));
-			newmode.fp_vert_stretch |= (VERT_STRETCH_BLEND |
+			newmode->fp_vert_stretch |= (VERT_STRETCH_BLEND |
 						    VERT_STRETCH_ENABLE);
 			use_rmx = 1;
 		}
-		newmode.fp_vert_stretch &= ~VERT_AUTO_RATIO_EN;
+		newmode->fp_vert_stretch &= ~VERT_AUTO_RATIO_EN;
 
-		newmode.fp_gen_cntl = (rinfo->init_state.fp_gen_cntl & (u32)
+		newmode->fp_gen_cntl = (rinfo->init_state.fp_gen_cntl & (u32)
 				       ~(FP_SEL_CRTC2 |
 					 FP_RMX_HVSYNC_CONTROL_EN |
 					 FP_DFP_SYNC_SEL |
@@ -1723,56 +1727,56 @@ static int radeonfb_set_par(struct fb_in
 					 FP_CRTC_USE_SHADOW_VEND |
 					 FP_CRT_SYNC_ALT));
 
-		newmode.fp_gen_cntl |= (FP_CRTC_DONT_SHADOW_VPAR |
+		newmode->fp_gen_cntl |= (FP_CRTC_DONT_SHADOW_VPAR |
 					FP_CRTC_DONT_SHADOW_HEND |
 					FP_PANEL_FORMAT);
 
 		if (IS_R300_VARIANT(rinfo) ||
 		    (rinfo->family == CHIP_FAMILY_R200)) {
-			newmode.fp_gen_cntl &= ~R200_FP_SOURCE_SEL_MASK;
+			newmode->fp_gen_cntl &= ~R200_FP_SOURCE_SEL_MASK;
 			if (use_rmx)
-				newmode.fp_gen_cntl |= R200_FP_SOURCE_SEL_RMX;
+				newmode->fp_gen_cntl |= R200_FP_SOURCE_SEL_RMX;
 			else
-				newmode.fp_gen_cntl |= R200_FP_SOURCE_SEL_CRTC1;
+				newmode->fp_gen_cntl |= R200_FP_SOURCE_SEL_CRTC1;
 		} else 
-			newmode.fp_gen_cntl |= FP_SEL_CRTC1;
+			newmode->fp_gen_cntl |= FP_SEL_CRTC1;
 
-		newmode.lvds_gen_cntl = rinfo->init_state.lvds_gen_cntl;
-		newmode.lvds_pll_cntl = rinfo->init_state.lvds_pll_cntl;
-		newmode.tmds_crc = rinfo->init_state.tmds_crc;
-		newmode.tmds_transmitter_cntl = rinfo->init_state.tmds_transmitter_cntl;
+		newmode->lvds_gen_cntl = rinfo->init_state.lvds_gen_cntl;
+		newmode->lvds_pll_cntl = rinfo->init_state.lvds_pll_cntl;
+		newmode->tmds_crc = rinfo->init_state.tmds_crc;
+		newmode->tmds_transmitter_cntl = rinfo->init_state.tmds_transmitter_cntl;
 
 		if (primary_mon == MT_LCD) {
-			newmode.lvds_gen_cntl |= (LVDS_ON | LVDS_BLON);
-			newmode.fp_gen_cntl &= ~(FP_FPON | FP_TMDS_EN);
+			newmode->lvds_gen_cntl |= (LVDS_ON | LVDS_BLON);
+			newmode->fp_gen_cntl &= ~(FP_FPON | FP_TMDS_EN);
 		} else {
 			/* DFP */
-			newmode.fp_gen_cntl |= (FP_FPON | FP_TMDS_EN);
-			newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST | TMDS_ICHCSEL) &
+			newmode->fp_gen_cntl |= (FP_FPON | FP_TMDS_EN);
+			newmode->tmds_transmitter_cntl = (TMDS_RAN_PAT_RST | TMDS_ICHCSEL) &
 							 ~(TMDS_PLLRST);
 			/* TMDS_PLL_EN bit is reversed on RV (and mobility) chips */
 			if (IS_R300_VARIANT(rinfo) ||
 			    (rinfo->family == CHIP_FAMILY_R200) || !rinfo->has_CRTC2)
-				newmode.tmds_transmitter_cntl &= ~TMDS_PLL_EN;
+				newmode->tmds_transmitter_cntl &= ~TMDS_PLL_EN;
 			else
-				newmode.tmds_transmitter_cntl |= TMDS_PLL_EN;
-			newmode.crtc_ext_cntl &= ~CRTC_CRT_ON;
+				newmode->tmds_transmitter_cntl |= TMDS_PLL_EN;
+			newmode->crtc_ext_cntl &= ~CRTC_CRT_ON;
 		}
 
-		newmode.fp_crtc_h_total_disp = (((rinfo->panel_info.hblank / 8) & 0x3ff) |
+		newmode->fp_crtc_h_total_disp = (((rinfo->panel_info.hblank / 8) & 0x3ff) |
 				(((mode->xres / 8) - 1) << 16));
-		newmode.fp_crtc_v_total_disp = (rinfo->panel_info.vblank & 0xffff) |
+		newmode->fp_crtc_v_total_disp = (rinfo->panel_info.vblank & 0xffff) |
 				((mode->yres - 1) << 16);
-		newmode.fp_h_sync_strt_wid = ((rinfo->panel_info.hOver_plus & 0x1fff) |
+		newmode->fp_h_sync_strt_wid = ((rinfo->panel_info.hOver_plus & 0x1fff) |
 				(hsync_wid << 16) | (h_sync_pol << 23));
-		newmode.fp_v_sync_strt_wid = ((rinfo->panel_info.vOver_plus & 0xfff) |
+		newmode->fp_v_sync_strt_wid = ((rinfo->panel_info.vOver_plus & 0xfff) |
 				(vsync_wid << 16) | (v_sync_pol  << 23));
 	}
 
 	/* do it! */
 	if (!rinfo->asleep) {
-		memcpy(&rinfo->state, &newmode, sizeof(newmode));
-		radeon_write_mode (rinfo, &newmode, 0);
+		memcpy(&rinfo->state, newmode, sizeof(*newmode));
+		radeon_write_mode (rinfo, newmode, 0);
 		/* (re)initialize the engine */
 		if (!(info->flags & FBINFO_HWACCEL_DISABLED))
 			radeonfb_engine_init (rinfo);
@@ -1792,6 +1796,7 @@ static int radeonfb_set_par(struct fb_in
 			     rinfo->depth, info->fix.line_length);
 #endif
 
+	kfree(newmode);
 	return 0;
 }
 

-- 
dwmw2
