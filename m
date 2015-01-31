Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x22b.google.com (mail-yh0-x22b.google.com
 [IPv6:2607:f8b0:4002:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 507781A0E4F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:25 +1100 (AEDT)
Received: by mail-yh0-f43.google.com with SMTP id 29so12994578yhl.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:23 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 04/15] fbdev: radeon: replace PPC_OF with PPC
Date: Sat, 31 Jan 2015 21:47:34 +0800
Message-Id: <1422712065-9403-5-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Kevin Hao <haokexin@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PPC_OF is a ppc specific option which is used to mean that the
firmware device tree access functions are available. Since all the
ppc platforms have a device tree, it is aways set to 'y' for ppc.
So it makes no sense to keep a such option in the current kernel.
Replace it with PPC.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/video/fbdev/Kconfig              |  2 +-
 drivers/video/fbdev/aty/radeon_base.c    | 24 ++++++++++++------------
 drivers/video/fbdev/aty/radeon_monitor.c | 20 ++++++++++----------
 drivers/video/fbdev/aty/radeon_pm.c      | 16 ++++++++--------
 drivers/video/fbdev/aty/radeonfb.h       |  4 ++--
 5 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index f2c3fb7d0399..55161dd4b931 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1333,7 +1333,7 @@ config FB_RADEON
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_MACMODES if PPC_OF
+	select FB_MACMODES if PPC
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
 	  a framebuffer device.  There are both PCI and AGP versions.  You
diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 26d80a4486fb..01237c8fcdc6 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -74,7 +74,7 @@
 #include <asm/io.h>
 #include <linux/uaccess.h>
 
-#ifdef CONFIG_PPC_OF
+#ifdef CONFIG_PPC
 
 #include <asm/pci-bridge.h>
 #include "../macmodes.h"
@@ -83,7 +83,7 @@
 #include <asm/btext.h>
 #endif
 
-#endif /* CONFIG_PPC_OF */
+#endif /* CONFIG_PPC */
 
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
@@ -418,7 +418,7 @@ static int  radeon_find_mem_vbios(struct radeonfb_info *rinfo)
 }
 #endif
 
-#if defined(CONFIG_PPC_OF) || defined(CONFIG_SPARC)
+#if defined(CONFIG_PPC) || defined(CONFIG_SPARC)
 /*
  * Read XTAL (ref clock), SCLK and MCLK from Open Firmware device
  * tree. Hopefully, ATI OF driver is kind enough to fill these
@@ -448,7 +448,7 @@ static int radeon_read_xtal_OF(struct radeonfb_info *rinfo)
 
        	return 0;
 }
-#endif /* CONFIG_PPC_OF || CONFIG_SPARC */
+#endif /* CONFIG_PPC || CONFIG_SPARC */
 
 /*
  * Read PLL infos from chip registers
@@ -653,7 +653,7 @@ static void radeon_get_pllinfo(struct radeonfb_info *rinfo)
 	rinfo->pll.ref_div = INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK;
 
 
-#if defined(CONFIG_PPC_OF) || defined(CONFIG_SPARC)
+#if defined(CONFIG_PPC) || defined(CONFIG_SPARC)
 	/*
 	 * Retrieve PLL infos from Open Firmware first
 	 */
@@ -661,7 +661,7 @@ static void radeon_get_pllinfo(struct radeonfb_info *rinfo)
        		printk(KERN_INFO "radeonfb: Retrieved PLL infos from Open Firmware\n");
 		goto found;
 	}
-#endif /* CONFIG_PPC_OF || CONFIG_SPARC */
+#endif /* CONFIG_PPC || CONFIG_SPARC */
 
 	/*
 	 * Check out if we have an X86 which gave us some PLL informations
@@ -1910,7 +1910,7 @@ static int radeon_set_fbinfo(struct radeonfb_info *rinfo)
  * I put the card's memory at 0 in card space and AGP at some random high
  * local (0xe0000000 for now) that will be changed by XFree/DRI anyway
  */
-#ifdef CONFIG_PPC_OF
+#ifdef CONFIG_PPC
 #undef SET_MC_FB_FROM_APERTURE
 static void fixup_memory_mappings(struct radeonfb_info *rinfo)
 {
@@ -1984,7 +1984,7 @@ static void fixup_memory_mappings(struct radeonfb_info *rinfo)
 		((aper_base + aper_size - 1) & 0xffff0000) | (aper_base >> 16),
 		0xffff0000 | (agp_base >> 16));
 }
-#endif /* CONFIG_PPC_OF */
+#endif /* CONFIG_PPC */
 
 
 static void radeon_identify_vram(struct radeonfb_info *rinfo)
@@ -2236,7 +2236,7 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	    rinfo->family == CHIP_FAMILY_RS200)
 		rinfo->errata |= CHIP_ERRATA_PLL_DELAY;
 
-#if defined(CONFIG_PPC_OF) || defined(CONFIG_SPARC)
+#if defined(CONFIG_PPC) || defined(CONFIG_SPARC)
 	/* On PPC, we obtain the OF device-node pointer to the firmware
 	 * data for this chip
 	 */
@@ -2245,14 +2245,14 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 		printk(KERN_WARNING "radeonfb (%s): Cannot match card to OF node !\n",
 		       pci_name(rinfo->pdev));
 
-#endif /* CONFIG_PPC_OF || CONFIG_SPARC */
-#ifdef CONFIG_PPC_OF
+#endif /* CONFIG_PPC || CONFIG_SPARC */
+#ifdef CONFIG_PPC
 	/* On PPC, the firmware sets up a memory mapping that tends
 	 * to cause lockups when enabling the engine. We reconfigure
 	 * the card internal memory mappings properly
 	 */
 	fixup_memory_mappings(rinfo);
-#endif /* CONFIG_PPC_OF */
+#endif /* CONFIG_PPC */
 
 	/* Get VRAM size and type */
 	radeon_identify_vram(rinfo);
diff --git a/drivers/video/fbdev/aty/radeon_monitor.c b/drivers/video/fbdev/aty/radeon_monitor.c
index bc078d50d8f1..f1ce229de78d 100644
--- a/drivers/video/fbdev/aty/radeon_monitor.c
+++ b/drivers/video/fbdev/aty/radeon_monitor.c
@@ -55,7 +55,7 @@ static char *radeon_get_mon_name(int type)
 }
 
 
-#if defined(CONFIG_PPC_OF) || defined(CONFIG_SPARC)
+#if defined(CONFIG_PPC) || defined(CONFIG_SPARC)
 /*
  * Try to find monitor informations & EDID data out of the Open Firmware
  * device-tree. This also contains some "hacks" to work around a few machine
@@ -160,7 +160,7 @@ static int radeon_probe_OF_head(struct radeonfb_info *rinfo, int head_no,
 	}
         return MT_NONE;
 }
-#endif /* CONFIG_PPC_OF || CONFIG_SPARC */
+#endif /* CONFIG_PPC || CONFIG_SPARC */
 
 
 static int radeon_get_panel_info_BIOS(struct radeonfb_info *rinfo)
@@ -499,11 +499,11 @@ void radeon_probe_screens(struct radeonfb_info *rinfo,
 		 * Old single head cards
 		 */
 		if (!rinfo->has_CRTC2) {
-#if defined(CONFIG_PPC_OF) || defined(CONFIG_SPARC)
+#if defined(CONFIG_PPC) || defined(CONFIG_SPARC)
 			if (rinfo->mon1_type == MT_NONE)
 				rinfo->mon1_type = radeon_probe_OF_head(rinfo, 0,
 									&rinfo->mon1_EDID);
-#endif /* CONFIG_PPC_OF || CONFIG_SPARC */
+#endif /* CONFIG_PPC || CONFIG_SPARC */
 #ifdef CONFIG_FB_RADEON_I2C
 			if (rinfo->mon1_type == MT_NONE)
 				rinfo->mon1_type =
@@ -548,11 +548,11 @@ void radeon_probe_screens(struct radeonfb_info *rinfo,
 		/*
 		 * Probe primary head (DVI or laptop internal panel)
 		 */
-#if defined(CONFIG_PPC_OF) || defined(CONFIG_SPARC)
+#if defined(CONFIG_PPC) || defined(CONFIG_SPARC)
 		if (rinfo->mon1_type == MT_NONE)
 			rinfo->mon1_type = radeon_probe_OF_head(rinfo, 0,
 								&rinfo->mon1_EDID);
-#endif /* CONFIG_PPC_OF || CONFIG_SPARC */
+#endif /* CONFIG_PPC || CONFIG_SPARC */
 #ifdef CONFIG_FB_RADEON_I2C
 		if (rinfo->mon1_type == MT_NONE)
 			rinfo->mon1_type = radeon_probe_i2c_connector(rinfo, ddc_dvi,
@@ -576,11 +576,11 @@ void radeon_probe_screens(struct radeonfb_info *rinfo,
 		/*
 		 * Probe secondary head (mostly VGA, can be DVI)
 		 */
-#if defined(CONFIG_PPC_OF) || defined(CONFIG_SPARC)
+#if defined(CONFIG_PPC) || defined(CONFIG_SPARC)
 		if (rinfo->mon2_type == MT_NONE)
 			rinfo->mon2_type = radeon_probe_OF_head(rinfo, 1,
 								&rinfo->mon2_EDID);
-#endif /* CONFIG_PPC_OF || defined(CONFIG_SPARC) */
+#endif /* CONFIG_PPC || defined(CONFIG_SPARC) */
 #ifdef CONFIG_FB_RADEON_I2C
 		if (rinfo->mon2_type == MT_NONE)
 			rinfo->mon2_type = radeon_probe_i2c_connector(rinfo, ddc_vga,
@@ -653,7 +653,7 @@ void radeon_probe_screens(struct radeonfb_info *rinfo,
  */
 static void radeon_fixup_panel_info(struct radeonfb_info *rinfo)
 {
-#ifdef CONFIG_PPC_OF
+#ifdef CONFIG_PPC
 	/*
 	 * LCD Flat panels should use fixed dividers, we enfore that on
 	 * PPC only for now...
@@ -676,7 +676,7 @@ static void radeon_fixup_panel_info(struct radeonfb_info *rinfo)
 		       (rinfo->panel_info.post_divider << 16),
 		       ppll_div_sel);
 	}
-#endif /* CONFIG_PPC_OF */
+#endif /* CONFIG_PPC */
 }
 
 
diff --git a/drivers/video/fbdev/aty/radeon_pm.c b/drivers/video/fbdev/aty/radeon_pm.c
index 46a12f1a93c3..1417542738fc 100644
--- a/drivers/video/fbdev/aty/radeon_pm.c
+++ b/drivers/video/fbdev/aty/radeon_pm.c
@@ -523,7 +523,7 @@ static void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
 	OUTPLL(pllVCLK_ECP_CNTL, tmp);
 
 	/* X doesn't do that ... hrm, we do on mobility && Macs */
-#ifdef CONFIG_PPC_OF
+#ifdef CONFIG_PPC
 	if (rinfo->is_mobility) {
 		tmp  = INPLL(pllMCLK_CNTL);
 		tmp &= ~(MCLK_CNTL__FORCE_MCLKA |
@@ -541,7 +541,7 @@ static void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
 		OUTPLL(pllMCLK_MISC, tmp);
 		radeon_msleep(15);
 	}
-#endif /* CONFIG_PPC_OF */
+#endif /* CONFIG_PPC */
 }
 
 #ifdef CONFIG_PM
@@ -1288,7 +1288,7 @@ static void radeon_pm_full_reset_sdram(struct radeonfb_info *rinfo)
        		radeon_pm_enable_dll_m10(rinfo);
 		radeon_pm_yclk_mclk_sync_m10(rinfo);
 
-#ifdef CONFIG_PPC_OF
+#ifdef CONFIG_PPC
 		if (rinfo->of_node != NULL) {
 			int size;
 
@@ -1298,7 +1298,7 @@ static void radeon_pm_full_reset_sdram(struct radeonfb_info *rinfo)
 			else
 				mrtable = default_mrtable;
 		}
-#endif /* CONFIG_PPC_OF */
+#endif /* CONFIG_PPC */
 
 		/* Program the SDRAM */
 		sdram_mode_reg = mrtable[0];
@@ -1943,7 +1943,7 @@ static void radeon_reinitialize_M10(struct radeonfb_info *rinfo)
 }
 #endif
 
-#ifdef CONFIG_PPC_OF
+#ifdef CONFIG_PPC
 #ifdef CONFIG_PPC_PMAC
 static void radeon_pm_m9p_reconfigure_mc(struct radeonfb_info *rinfo)
 {
@@ -2512,7 +2512,7 @@ static void radeon_reinitialize_QW(struct radeonfb_info *rinfo)
 }
 #endif /* 0 */
 
-#endif /* CONFIG_PPC_OF */
+#endif /* CONFIG_PPC */
 
 static void radeonfb_whack_power_state(struct radeonfb_info *rinfo, pci_power_t state)
 {
@@ -2793,7 +2793,7 @@ int radeonfb_pci_resume(struct pci_dev *pdev)
 	return rc;
 }
 
-#ifdef CONFIG_PPC_OF__disabled
+#ifdef CONFIG_PPC__disabled
 static void radeonfb_early_resume(void *data)
 {
         struct radeonfb_info *rinfo = data;
@@ -2803,7 +2803,7 @@ static void radeonfb_early_resume(void *data)
 	radeonfb_pci_resume(rinfo->pdev);
 	rinfo->no_schedule = 0;
 }
-#endif /* CONFIG_PPC_OF */
+#endif /* CONFIG_PPC */
 
 #endif /* CONFIG_PM */
 
diff --git a/drivers/video/fbdev/aty/radeonfb.h b/drivers/video/fbdev/aty/radeonfb.h
index cb846044f57c..039def41c920 100644
--- a/drivers/video/fbdev/aty/radeonfb.h
+++ b/drivers/video/fbdev/aty/radeonfb.h
@@ -20,7 +20,7 @@
 
 #include <asm/io.h>
 
-#if defined(CONFIG_PPC_OF) || defined(CONFIG_SPARC)
+#if defined(CONFIG_PPC) || defined(CONFIG_SPARC)
 #include <asm/prom.h>
 #endif
 
@@ -301,7 +301,7 @@ struct radeonfb_info {
 	unsigned long		fb_local_base;
 
 	struct pci_dev		*pdev;
-#if defined(CONFIG_PPC_OF) || defined(CONFIG_SPARC)
+#if defined(CONFIG_PPC) || defined(CONFIG_SPARC)
 	struct device_node	*of_node;
 #endif
 
-- 
1.9.3
