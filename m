Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F3F767A6B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2005 12:49:25 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 12:48:51 +1100
Message-Id: <1106012932.4533.46.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] radeonfb: massive update of PM code
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch is a quite massive update to radeonfb. It adds the ability to reboot
from scratch the various chip models used on the recent powermac laptops, adds
a bunch of new chips (including R420 support, untested), plus various fixes
here or there including LCD & flat panel blanking, abuse of stack usage in
radeonfb_set_par(), and finally, adapts the PM code to the recent powermac
changes.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/radeon_monitor.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_monitor.c	2004-11-22 11:50:27.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_monitor.c	2005-01-17 13:49:30.011589712 +1100
@@ -1,11 +1,6 @@
 #include "radeonfb.h"
 #include "../edid.h"
 
-#ifdef CONFIG_PPC_OF
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#endif /* CONFIG_PPC_OF */
-
 static struct fb_var_screeninfo radeonfb_default_var = {
 	.xres		= 640,
 	.yres		= 480,
@@ -64,9 +59,11 @@
  * models with broken OF probing by hard-coding known EDIDs for some Mac
  * laptops internal LVDS panel. (XXX: not done yet)
  */
-static int __devinit radeon_parse_montype_prop(struct device_node *dp, u8 **out_EDID, int hdno)
+static int __devinit radeon_parse_montype_prop(struct device_node *dp, u8 **out_EDID,
+					       int hdno)
 {
-        static char *propnames[] = { "DFP,EDID", "LCD,EDID", "EDID", "EDID1", "EDID2",  NULL };
+        static char *propnames[] = { "DFP,EDID", "LCD,EDID", "EDID",
+				     "EDID1", "EDID2",  NULL };
 	u8 *pedid = NULL;
 	u8 *pmt = NULL;
 	u8 *tmp;
@@ -122,7 +119,7 @@
 
 	RTRACE("radeon_probe_OF_head\n");
 
-        dp = pci_device_to_OF_node(rinfo->pdev);
+        dp = rinfo->of_node;
         while (dp == NULL)
 		return MT_NONE;
 
@@ -502,8 +499,9 @@
 #endif /* CONFIG_PPC_OF */
 #ifdef CONFIG_FB_RADEON_I2C
 			if (rinfo->mon1_type == MT_NONE)
-				rinfo->mon1_type = radeon_probe_i2c_connector(rinfo, ddc_dvi,
-								      &rinfo->mon1_EDID);
+				rinfo->mon1_type =
+					radeon_probe_i2c_connector(rinfo, ddc_dvi,
+								   &rinfo->mon1_EDID);
 			if (rinfo->mon1_type == MT_NONE)
 				rinfo->mon1_type =
 					radeon_probe_i2c_connector(rinfo, ddc_vga,
@@ -545,7 +543,8 @@
 		 */
 #ifdef CONFIG_PPC_OF
 		if (rinfo->mon1_type == MT_NONE)
-			rinfo->mon1_type = radeon_probe_OF_head(rinfo, 0, &rinfo->mon1_EDID);
+			rinfo->mon1_type = radeon_probe_OF_head(rinfo, 0,
+								&rinfo->mon1_EDID);
 #endif /* CONFIG_PPC_OF */
 #ifdef CONFIG_FB_RADEON_I2C
 		if (rinfo->mon1_type == MT_NONE)
@@ -572,7 +571,8 @@
 		 */
 #ifdef CONFIG_PPC_OF
 		if (rinfo->mon2_type == MT_NONE)
-			rinfo->mon2_type = radeon_probe_OF_head(rinfo, 1, &rinfo->mon2_EDID);
+			rinfo->mon2_type = radeon_probe_OF_head(rinfo, 1,
+								&rinfo->mon2_EDID);
 #endif /* CONFIG_PPC_OF */
 #ifdef CONFIG_FB_RADEON_I2C
 		if (rinfo->mon2_type == MT_NONE)
@@ -814,9 +814,10 @@
 	 * Now build modedb from EDID
 	 */
 	if (rinfo->mon1_EDID) {
-		rinfo->mon1_modedb = fb_create_modedb(rinfo->mon1_EDID,
-						      &rinfo->mon1_dbsize);
-		fb_get_monitor_limits(rinfo->mon1_EDID, &rinfo->info->monspecs);
+		fb_edid_to_monspecs(rinfo->mon1_EDID, &rinfo->info->monspecs);
+		fb_videomode_to_modelist(rinfo->info->monspecs.modedb,
+					 rinfo->info->monspecs.modedb_len,
+					 &rinfo->info->modelist);
 	}
 
 	
Index: linux-work/include/video/radeon.h
===================================================================
--- linux-work.orig/include/video/radeon.h	2004-11-22 11:50:58.000000000 +1100
+++ linux-work/include/video/radeon.h	2005-01-17 13:49:30.025587584 +1100
@@ -21,6 +21,7 @@
 #define PAD_AGPINPUT_DELAY                     0x0164  
 #define PAD_CTLR_STRENGTH                      0x0168  
 #define PAD_CTLR_UPDATE                        0x016C
+#define PAD_CTLR_MISC                          0x0aa0
 #define AGP_CNTL                               0x0174
 #define BM_STATUS                              0x0160
 #define CAP0_TRIG_CNTL			       0x0950
@@ -68,18 +69,26 @@
 #define DAC_CNTL2                              0x007c
 #define CRTC_GEN_CNTL                          0x0050  
 #define MEM_CNTL                               0x0140  
+#define MC_CNTL                                0x0140  
 #define EXT_MEM_CNTL                           0x0144  
+#define MC_TIMING_CNTL                         0x0144  
 #define MC_AGP_LOCATION                        0x014C  
 #define MEM_IO_CNTL_A0                         0x0178  
+#define MEM_REFRESH_CNTL                       0x0178
 #define MEM_INIT_LATENCY_TIMER                 0x0154  
+#define MC_INIT_GFX_LAT_TIMER                  0x0154  
 #define MEM_SDRAM_MODE_REG                     0x0158  
 #define AGP_BASE                               0x0170  
 #define MEM_IO_CNTL_A1                         0x017C  
+#define MC_READ_CNTL_AB                        0x017C  
 #define MEM_IO_CNTL_B0                         0x0180
+#define MC_INIT_MISC_LAT_TIMER                 0x0180
 #define MEM_IO_CNTL_B1                         0x0184
+#define MC_IOPAD_CNTL                          0x0184
 #define MC_DEBUG                               0x0188
 #define MC_STATUS                              0x0150  
 #define MEM_IO_OE_CNTL                         0x018C  
+#define MC_CHIP_IO_OE_CNTL_AB                  0x018C  
 #define MC_FB_LOCATION                         0x0148  
 #define HOST_PATH_CNTL                         0x0130  
 #define MEM_VGA_WP_SEL                         0x0038  
@@ -385,6 +394,13 @@
 #define TMDS_CRC			       0x02a0
 #define TMDS_TRANSMITTER_CNTL		       0x02a4
 #define MPP_TB_CONFIG            	       0x01c0
+#define PAMAC0_DLY_CNTL                        0x0a94
+#define PAMAC1_DLY_CNTL                        0x0a98
+#define PAMAC2_DLY_CNTL                        0x0a9c
+#define FW_CNTL                                0x0118
+#define FCP_CNTL                               0x0910
+#define VGA_DDA_ON_OFF                         0x02ec
+#define TV_MASTER_CNTL                         0x0800
 
 //#define BASE_CODE			       0x0f0b
 #define BIOS_0_SCRATCH			       0x0010
@@ -418,7 +434,7 @@
 #define PPLL_DIV_3                                 0x0007
 #define VCLK_ECP_CNTL                              0x0008
 #define HTOTAL_CNTL                                0x0009
-#define X_MPLL_REF_FB_DIV                          0x000a
+#define M_SPLL_REF_FB_DIV                          0x000a
 #define AGP_PLL_CNTL                               0x000b
 #define SPLL_CNTL                                  0x000c
 #define SCLK_CNTL                                  0x000d
@@ -497,6 +513,8 @@
 #define CFG_VGA_RAM_EN                             0x00000100
 #define CFG_ATI_REV_ID_MASK			   (0xf << 16)
 #define CFG_ATI_REV_A11				   (0 << 16)
+#define CFG_ATI_REV_A12				   (1 << 16)
+#define CFG_ATI_REV_A13				   (2 << 16)
 
 /* CRTC_EXT_CNTL bit constants */
 #define VGA_ATI_LINEAR                             0x00000008
@@ -573,9 +591,17 @@
 /* FP_GEN_CNTL bit constants */
 #define FP_FPON					   (1 << 0)
 #define FP_TMDS_EN				   (1 << 2)
+#define FP_PANEL_FORMAT                            (1 << 3)
 #define FP_EN_TMDS				   (1 << 7)
 #define FP_DETECT_SENSE				   (1 << 8)
+#define R200_FP_SOURCE_SEL_MASK                    (3 << 10)
+#define R200_FP_SOURCE_SEL_CRTC1                   (0 << 10)
+#define R200_FP_SOURCE_SEL_CRTC2                   (1 << 10)
+#define R200_FP_SOURCE_SEL_RMX                     (2 << 10)
+#define R200_FP_SOURCE_SEL_TRANS                   (3 << 10)
+#define FP_SEL_CRTC1				   (0 << 13)
 #define FP_SEL_CRTC2				   (1 << 13)
+#define FP_USE_VGA_HSYNC                           (1 << 14)
 #define FP_CRTC_DONT_SHADOW_HPAR		   (1 << 15)
 #define FP_CRTC_DONT_SHADOW_VPAR		   (1 << 16)
 #define FP_CRTC_DONT_SHADOW_HEND		   (1 << 17)
@@ -671,6 +697,7 @@
 #define DAC_CMP_OUTPUT                             (1 <<  7)
 
 /* DAC_CNTL2 bit constants */   
+#define DAC2_EXPAND_MODE			   (1 << 14)
 #define DAC2_CMP_EN                                (1 << 7)
 #define DAC2_PALETTE_ACCESS_CNTL                   (1 << 5)
 
@@ -697,6 +724,11 @@
 #define MEM_ARBITER_STATUS_BUSY                    0x00400000
 #define MEM_REQ_UNLOCK                             0x00000000
 #define MEM_REQ_LOCK                               0x00800000
+#define MEM_NUM_CHANNELS_MASK 			   0x00000001
+#define MEM_USE_B_CH_ONLY                          0x00000002
+#define RV100_MEM_HALF_MODE                        0x00000008
+#define R300_MEM_NUM_CHANNELS_MASK                 0x00000003
+#define R300_MEM_USE_CD_CH_ONLY                    0x00000004
 
 
 /* RBBM_SOFT_RESET bit constants */
@@ -963,9 +995,11 @@
 
 #define MC_IND_INDEX                           0x01F8
 #define MC_IND_DATA                            0x01FC
-#define MEM_REFRESH_CNTL                       0x0178
 
-// CLK_PIN_CNTL
+/* PAD_CTLR_STRENGTH */
+#define PAD_MANUAL_OVERRIDE		0x80000000
+
+// pllCLK_PIN_CNTL
 #define CLK_PIN_CNTL__OSC_EN_MASK                          0x00000001L
 #define CLK_PIN_CNTL__OSC_EN                               0x00000001L
 #define CLK_PIN_CNTL__XTL_LOW_GAIN_MASK                    0x00000004L
@@ -991,32 +1025,32 @@
 #define CLK_PIN_CNTL__XTALIN_ALWAYS_ONb                    0x00080000L
 #define CLK_PIN_CNTL__PWRSEQ_DELAY_MASK                    0xff000000L
 
-// CLK_PWRMGT_CNTL_M6
-#define	CLK_PWRMGT_CNTL_M6__MPLL_PWRMGT_OFF__SHIFT         0x00000000
-#define	CLK_PWRMGT_CNTL_M6__SPLL_PWRMGT_OFF__SHIFT         0x00000001
-#define	CLK_PWRMGT_CNTL_M6__PPLL_PWRMGT_OFF__SHIFT         0x00000002
-#define	CLK_PWRMGT_CNTL_M6__P2PLL_PWRMGT_OFF__SHIFT        0x00000003
-#define	CLK_PWRMGT_CNTL_M6__MCLK_TURNOFF__SHIFT            0x00000004
-#define	CLK_PWRMGT_CNTL_M6__SCLK_TURNOFF__SHIFT            0x00000005
-#define	CLK_PWRMGT_CNTL_M6__PCLK_TURNOFF__SHIFT            0x00000006
-#define	CLK_PWRMGT_CNTL_M6__P2CLK_TURNOFF__SHIFT           0x00000007
-#define	CLK_PWRMGT_CNTL_M6__MC_CH_MODE__SHIFT              0x00000008
-#define	CLK_PWRMGT_CNTL_M6__TEST_MODE__SHIFT               0x00000009
-#define	CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN__SHIFT          0x0000000a
-#define	CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE__SHIFT      0x0000000c
-#define	CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT__SHIFT         0x0000000d
-#define	CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT__SHIFT       0x0000000f
-#define	CLK_PWRMGT_CNTL_M6__MC_BUSY__SHIFT                 0x00000010
-#define	CLK_PWRMGT_CNTL_M6__MC_INT_CNTL__SHIFT             0x00000011
-#define	CLK_PWRMGT_CNTL_M6__MC_SWITCH__SHIFT               0x00000012
-#define	CLK_PWRMGT_CNTL_M6__DLL_READY__SHIFT               0x00000013
-#define	CLK_PWRMGT_CNTL_M6__DISP_PM__SHIFT                 0x00000014
-#define	CLK_PWRMGT_CNTL_M6__DYN_STOP_MODE__SHIFT           0x00000015
-#define	CLK_PWRMGT_CNTL_M6__CG_NO1_DEBUG__SHIFT            0x00000018
-#define	CLK_PWRMGT_CNTL_M6__TVPLL_PWRMGT_OFF__SHIFT        0x0000001e
-#define	CLK_PWRMGT_CNTL_M6__TVCLK_TURNOFF__SHIFT           0x0000001f
+// pllCLK_PWRMGT_CNTL
+#define	CLK_PWRMGT_CNTL__MPLL_PWRMGT_OFF__SHIFT         0x00000000
+#define	CLK_PWRMGT_CNTL__SPLL_PWRMGT_OFF__SHIFT         0x00000001
+#define	CLK_PWRMGT_CNTL__PPLL_PWRMGT_OFF__SHIFT         0x00000002
+#define	CLK_PWRMGT_CNTL__P2PLL_PWRMGT_OFF__SHIFT        0x00000003
+#define	CLK_PWRMGT_CNTL__MCLK_TURNOFF__SHIFT            0x00000004
+#define	CLK_PWRMGT_CNTL__SCLK_TURNOFF__SHIFT            0x00000005
+#define	CLK_PWRMGT_CNTL__PCLK_TURNOFF__SHIFT            0x00000006
+#define	CLK_PWRMGT_CNTL__P2CLK_TURNOFF__SHIFT           0x00000007
+#define	CLK_PWRMGT_CNTL__MC_CH_MODE__SHIFT              0x00000008
+#define	CLK_PWRMGT_CNTL__TEST_MODE__SHIFT               0x00000009
+#define	CLK_PWRMGT_CNTL__GLOBAL_PMAN_EN__SHIFT          0x0000000a
+#define	CLK_PWRMGT_CNTL__ENGINE_DYNCLK_MODE__SHIFT      0x0000000c
+#define	CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT__SHIFT         0x0000000d
+#define	CLK_PWRMGT_CNTL__DISP_DYN_STOP_LAT__SHIFT       0x0000000f
+#define	CLK_PWRMGT_CNTL__MC_BUSY__SHIFT                 0x00000010
+#define	CLK_PWRMGT_CNTL__MC_INT_CNTL__SHIFT             0x00000011
+#define	CLK_PWRMGT_CNTL__MC_SWITCH__SHIFT               0x00000012
+#define	CLK_PWRMGT_CNTL__DLL_READY__SHIFT               0x00000013
+#define	CLK_PWRMGT_CNTL__DISP_PM__SHIFT                 0x00000014
+#define	CLK_PWRMGT_CNTL__DYN_STOP_MODE__SHIFT           0x00000015
+#define	CLK_PWRMGT_CNTL__CG_NO1_DEBUG__SHIFT            0x00000018
+#define	CLK_PWRMGT_CNTL__TVPLL_PWRMGT_OFF__SHIFT        0x0000001e
+#define	CLK_PWRMGT_CNTL__TVCLK_TURNOFF__SHIFT           0x0000001f
 
-// P2PLL_CNTL
+// pllP2PLL_CNTL
 #define P2PLL_CNTL__P2PLL_RESET_MASK                       0x00000001L
 #define P2PLL_CNTL__P2PLL_RESET                            0x00000001L
 #define P2PLL_CNTL__P2PLL_SLEEP_MASK                       0x00000002L
@@ -1041,7 +1075,7 @@
 #define P2PLL_CNTL__P2PLL_DISABLE_AUTO_RESET_MASK          0x00080000L
 #define P2PLL_CNTL__P2PLL_DISABLE_AUTO_RESET               0x00080000L
 
-// PIXCLKS_CNTL
+// pllPIXCLKS_CNTL
 #define	PIXCLKS_CNTL__PIX2CLK_SRC_SEL__SHIFT               0x00000000
 #define	PIXCLKS_CNTL__PIX2CLK_INVERT__SHIFT                0x00000004
 #define	PIXCLKS_CNTL__PIX2CLK_SRC_INVERT__SHIFT            0x00000005
@@ -1055,31 +1089,29 @@
 #define	PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb__SHIFT        0x0000000f
 
 
-// PIXCLKS_CNTL
+// pllPIXCLKS_CNTL
 #define PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK                 0x00000003L
-#define PIXCLKS_CNTL__PIX2CLK_INVERT_MASK                  0x00000010L
 #define PIXCLKS_CNTL__PIX2CLK_INVERT                       0x00000010L
-#define PIXCLKS_CNTL__PIX2CLK_SRC_INVERT_MASK              0x00000020L
 #define PIXCLKS_CNTL__PIX2CLK_SRC_INVERT                   0x00000020L
-#define PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb_MASK              0x00000040L
 #define PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb                   0x00000040L
-#define PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb_MASK          0x00000080L
 #define PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb               0x00000080L
-#define PIXCLKS_CNTL__PIXCLK_TV_SRC_SEL_MASK               0x00000100L
 #define PIXCLKS_CNTL__PIXCLK_TV_SRC_SEL                    0x00000100L
-#define PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb_MASK         0x00000800L
 #define PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb              0x00000800L
-#define PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb_MASK            0x00001000L
 #define PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb                 0x00001000L
-#define PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb_MASK      0x00002000L
 #define PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb           0x00002000L
-#define PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb_MASK          0x00004000L
 #define PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb               0x00004000L
-#define PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb_MASK          0x00008000L
 #define PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb               0x00008000L
+#define PIXCLKS_CNTL__DISP_TVOUT_PIXCLK_TV_ALWAYS_ONb      (1 << 9)
+#define PIXCLKS_CNTL__R300_DVOCLK_ALWAYS_ONb               (1 << 10)
+#define PIXCLKS_CNTL__R300_PIXCLK_DVO_ALWAYS_ONb           (1 << 13)
+#define PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb         (1 << 16)
+#define PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb           (1 << 17)
+#define PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb              (1 << 18)
+#define PIXCLKS_CNTL__R300_P2G2CLK_DAC_ALWAYS_ONb          (1 << 19)
+#define PIXCLKS_CNTL__R300_DISP_DAC_PIXCLK_DAC2_BLANK_OFF  (1 << 23)
 
 
-// P2PLL_DIV_0
+// pllP2PLL_DIV_0
 #define P2PLL_DIV_0__P2PLL_FB_DIV_MASK                     0x000007ffL
 #define P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W_MASK            0x00008000L
 #define P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W                 0x00008000L
@@ -1087,124 +1119,97 @@
 #define P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_R                 0x00008000L
 #define P2PLL_DIV_0__P2PLL_POST_DIV_MASK                   0x00070000L
 
-// SCLK_CNTL_M6
-#define SCLK_CNTL_M6__SCLK_SRC_SEL_MASK                    0x00000007L
-#define SCLK_CNTL_M6__CP_MAX_DYN_STOP_LAT_MASK             0x00000008L
-#define SCLK_CNTL_M6__CP_MAX_DYN_STOP_LAT                  0x00000008L
-#define SCLK_CNTL_M6__HDP_MAX_DYN_STOP_LAT_MASK            0x00000010L
-#define SCLK_CNTL_M6__HDP_MAX_DYN_STOP_LAT                 0x00000010L
-#define SCLK_CNTL_M6__TV_MAX_DYN_STOP_LAT_MASK             0x00000020L
-#define SCLK_CNTL_M6__TV_MAX_DYN_STOP_LAT                  0x00000020L
-#define SCLK_CNTL_M6__E2_MAX_DYN_STOP_LAT_MASK             0x00000040L
-#define SCLK_CNTL_M6__E2_MAX_DYN_STOP_LAT                  0x00000040L
-#define SCLK_CNTL_M6__SE_MAX_DYN_STOP_LAT_MASK             0x00000080L
-#define SCLK_CNTL_M6__SE_MAX_DYN_STOP_LAT                  0x00000080L
-#define SCLK_CNTL_M6__IDCT_MAX_DYN_STOP_LAT_MASK           0x00000100L
-#define SCLK_CNTL_M6__IDCT_MAX_DYN_STOP_LAT                0x00000100L
-#define SCLK_CNTL_M6__VIP_MAX_DYN_STOP_LAT_MASK            0x00000200L
-#define SCLK_CNTL_M6__VIP_MAX_DYN_STOP_LAT                 0x00000200L
-#define SCLK_CNTL_M6__RE_MAX_DYN_STOP_LAT_MASK             0x00000400L
-#define SCLK_CNTL_M6__RE_MAX_DYN_STOP_LAT                  0x00000400L
-#define SCLK_CNTL_M6__PB_MAX_DYN_STOP_LAT_MASK             0x00000800L
-#define SCLK_CNTL_M6__PB_MAX_DYN_STOP_LAT                  0x00000800L
-#define SCLK_CNTL_M6__TAM_MAX_DYN_STOP_LAT_MASK            0x00001000L
-#define SCLK_CNTL_M6__TAM_MAX_DYN_STOP_LAT                 0x00001000L
-#define SCLK_CNTL_M6__TDM_MAX_DYN_STOP_LAT_MASK            0x00002000L
-#define SCLK_CNTL_M6__TDM_MAX_DYN_STOP_LAT                 0x00002000L
-#define SCLK_CNTL_M6__RB_MAX_DYN_STOP_LAT_MASK             0x00004000L
-#define SCLK_CNTL_M6__RB_MAX_DYN_STOP_LAT                  0x00004000L
-#define SCLK_CNTL_M6__FORCE_DISP2_MASK                     0x00008000L
-#define SCLK_CNTL_M6__FORCE_DISP2                          0x00008000L
-#define SCLK_CNTL_M6__FORCE_CP_MASK                        0x00010000L
-#define SCLK_CNTL_M6__FORCE_CP                             0x00010000L
-#define SCLK_CNTL_M6__FORCE_HDP_MASK                       0x00020000L
-#define SCLK_CNTL_M6__FORCE_HDP                            0x00020000L
-#define SCLK_CNTL_M6__FORCE_DISP1_MASK                     0x00040000L
-#define SCLK_CNTL_M6__FORCE_DISP1                          0x00040000L
-#define SCLK_CNTL_M6__FORCE_TOP_MASK                       0x00080000L
-#define SCLK_CNTL_M6__FORCE_TOP                            0x00080000L
-#define SCLK_CNTL_M6__FORCE_E2_MASK                        0x00100000L
-#define SCLK_CNTL_M6__FORCE_E2                             0x00100000L
-#define SCLK_CNTL_M6__FORCE_SE_MASK                        0x00200000L
-#define SCLK_CNTL_M6__FORCE_SE                             0x00200000L
-#define SCLK_CNTL_M6__FORCE_IDCT_MASK                      0x00400000L
-#define SCLK_CNTL_M6__FORCE_IDCT                           0x00400000L
-#define SCLK_CNTL_M6__FORCE_VIP_MASK                       0x00800000L
-#define SCLK_CNTL_M6__FORCE_VIP                            0x00800000L
-#define SCLK_CNTL_M6__FORCE_RE_MASK                        0x01000000L
-#define SCLK_CNTL_M6__FORCE_RE                             0x01000000L
-#define SCLK_CNTL_M6__FORCE_PB_MASK                        0x02000000L
-#define SCLK_CNTL_M6__FORCE_PB                             0x02000000L
-#define SCLK_CNTL_M6__FORCE_TAM_MASK                       0x04000000L
-#define SCLK_CNTL_M6__FORCE_TAM                            0x04000000L
-#define SCLK_CNTL_M6__FORCE_TDM_MASK                       0x08000000L
-#define SCLK_CNTL_M6__FORCE_TDM                            0x08000000L
-#define SCLK_CNTL_M6__FORCE_RB_MASK                        0x10000000L
-#define SCLK_CNTL_M6__FORCE_RB                             0x10000000L
-#define SCLK_CNTL_M6__FORCE_TV_SCLK_MASK                   0x20000000L
-#define SCLK_CNTL_M6__FORCE_TV_SCLK                        0x20000000L
-#define SCLK_CNTL_M6__FORCE_SUBPIC_MASK                    0x40000000L
-#define SCLK_CNTL_M6__FORCE_SUBPIC                         0x40000000L
-#define SCLK_CNTL_M6__FORCE_OV0_MASK                       0x80000000L
-#define SCLK_CNTL_M6__FORCE_OV0                            0x80000000L
+// pllSCLK_CNTL
+#define SCLK_CNTL__SCLK_SRC_SEL_MASK                    0x00000007L
+#define SCLK_CNTL__CP_MAX_DYN_STOP_LAT                  0x00000008L
+#define SCLK_CNTL__HDP_MAX_DYN_STOP_LAT                 0x00000010L
+#define SCLK_CNTL__TV_MAX_DYN_STOP_LAT                  0x00000020L
+#define SCLK_CNTL__E2_MAX_DYN_STOP_LAT                  0x00000040L
+#define SCLK_CNTL__SE_MAX_DYN_STOP_LAT                  0x00000080L
+#define SCLK_CNTL__IDCT_MAX_DYN_STOP_LAT                0x00000100L
+#define SCLK_CNTL__VIP_MAX_DYN_STOP_LAT                 0x00000200L
+#define SCLK_CNTL__RE_MAX_DYN_STOP_LAT                  0x00000400L
+#define SCLK_CNTL__PB_MAX_DYN_STOP_LAT                  0x00000800L
+#define SCLK_CNTL__TAM_MAX_DYN_STOP_LAT                 0x00001000L
+#define SCLK_CNTL__TDM_MAX_DYN_STOP_LAT                 0x00002000L
+#define SCLK_CNTL__RB_MAX_DYN_STOP_LAT                  0x00004000L
+#define SCLK_CNTL__DYN_STOP_LAT_MASK                     0x00007ff8
+#define SCLK_CNTL__FORCE_DISP2                          0x00008000L
+#define SCLK_CNTL__FORCE_CP                             0x00010000L
+#define SCLK_CNTL__FORCE_HDP                            0x00020000L
+#define SCLK_CNTL__FORCE_DISP1                          0x00040000L
+#define SCLK_CNTL__FORCE_TOP                            0x00080000L
+#define SCLK_CNTL__FORCE_E2                             0x00100000L
+#define SCLK_CNTL__FORCE_SE                             0x00200000L
+#define SCLK_CNTL__FORCE_IDCT                           0x00400000L
+#define SCLK_CNTL__FORCE_VIP                            0x00800000L
+#define SCLK_CNTL__FORCE_RE                             0x01000000L
+#define SCLK_CNTL__FORCE_PB                             0x02000000L
+#define SCLK_CNTL__FORCE_TAM                            0x04000000L
+#define SCLK_CNTL__FORCE_TDM                            0x08000000L
+#define SCLK_CNTL__FORCE_RB                             0x10000000L
+#define SCLK_CNTL__FORCE_TV_SCLK                        0x20000000L
+#define SCLK_CNTL__FORCE_SUBPIC                         0x40000000L
+#define SCLK_CNTL__FORCE_OV0                            0x80000000L
+#define SCLK_CNTL__R300_FORCE_VAP                       (1<<21)
+#define SCLK_CNTL__R300_FORCE_SR                        (1<<25)
+#define SCLK_CNTL__R300_FORCE_PX                        (1<<26)
+#define SCLK_CNTL__R300_FORCE_TX                        (1<<27)
+#define SCLK_CNTL__R300_FORCE_US                        (1<<28)
+#define SCLK_CNTL__R300_FORCE_SU                        (1<<30)
+#define SCLK_CNTL__FORCEON_MASK                         0xffff8000L
+
+// pllSCLK_CNTL2
+#define SCLK_CNTL2__R300_TCL_MAX_DYN_STOP_LAT           (1<<10)
+#define SCLK_CNTL2__R300_GA_MAX_DYN_STOP_LAT            (1<<11)
+#define SCLK_CNTL2__R300_CBA_MAX_DYN_STOP_LAT           (1<<12)
+#define SCLK_CNTL2__R300_FORCE_TCL                      (1<<13)
+#define SCLK_CNTL2__R300_FORCE_CBA                      (1<<14)
+#define SCLK_CNTL2__R300_FORCE_GA                       (1<<15)
 
 // SCLK_MORE_CNTL
-#define SCLK_MORE_CNTL__DISPREGS_MAX_DYN_STOP_LAT_MASK     0x00000001L
 #define SCLK_MORE_CNTL__DISPREGS_MAX_DYN_STOP_LAT          0x00000001L
-#define SCLK_MORE_CNTL__MC_GUI_MAX_DYN_STOP_LAT_MASK       0x00000002L
 #define SCLK_MORE_CNTL__MC_GUI_MAX_DYN_STOP_LAT            0x00000002L
-#define SCLK_MORE_CNTL__MC_HOST_MAX_DYN_STOP_LAT_MASK      0x00000004L
 #define SCLK_MORE_CNTL__MC_HOST_MAX_DYN_STOP_LAT           0x00000004L
-#define SCLK_MORE_CNTL__FORCE_DISPREGS_MASK                0x00000100L
 #define SCLK_MORE_CNTL__FORCE_DISPREGS                     0x00000100L
-#define SCLK_MORE_CNTL__FORCE_MC_GUI_MASK                  0x00000200L
 #define SCLK_MORE_CNTL__FORCE_MC_GUI                       0x00000200L
-#define SCLK_MORE_CNTL__FORCE_MC_HOST_MASK                 0x00000400L
 #define SCLK_MORE_CNTL__FORCE_MC_HOST                      0x00000400L
-#define SCLK_MORE_CNTL__STOP_SCLK_EN_MASK                  0x00001000L
 #define SCLK_MORE_CNTL__STOP_SCLK_EN                       0x00001000L
-#define SCLK_MORE_CNTL__STOP_SCLK_A_MASK                   0x00002000L
 #define SCLK_MORE_CNTL__STOP_SCLK_A                        0x00002000L
-#define SCLK_MORE_CNTL__STOP_SCLK_B_MASK                   0x00004000L
 #define SCLK_MORE_CNTL__STOP_SCLK_B                        0x00004000L
-#define SCLK_MORE_CNTL__STOP_SCLK_C_MASK                   0x00008000L
 #define SCLK_MORE_CNTL__STOP_SCLK_C                        0x00008000L
-#define SCLK_MORE_CNTL__HALF_SPEED_SCLK_MASK               0x00010000L
 #define SCLK_MORE_CNTL__HALF_SPEED_SCLK                    0x00010000L
-#define SCLK_MORE_CNTL__IO_CG_VOLTAGE_DROP_MASK            0x00020000L
 #define SCLK_MORE_CNTL__IO_CG_VOLTAGE_DROP                 0x00020000L
-#define SCLK_MORE_CNTL__TVFB_SOFT_RESET_MASK               0x00040000L
 #define SCLK_MORE_CNTL__TVFB_SOFT_RESET                    0x00040000L
-#define SCLK_MORE_CNTL__VOLTAGE_DROP_SYNC_MASK             0x00080000L
 #define SCLK_MORE_CNTL__VOLTAGE_DROP_SYNC                  0x00080000L
-#define SCLK_MORE_CNTL__VOLTAGE_DELAY_SEL_MASK             0x00300000L
-#define SCLK_MORE_CNTL__IDLE_DELAY_HALF_SCLK_MASK          0x00400000L
 #define SCLK_MORE_CNTL__IDLE_DELAY_HALF_SCLK               0x00400000L
-#define SCLK_MORE_CNTL__AGP_BUSY_HALF_SCLK_MASK            0x00800000L
 #define SCLK_MORE_CNTL__AGP_BUSY_HALF_SCLK                 0x00800000L
 #define SCLK_MORE_CNTL__CG_SPARE_RD_C_MASK                 0xff000000L
+#define SCLK_MORE_CNTL__FORCEON                            0x00000700L
 
-// MCLK_CNTL_M6
-#define MCLK_CNTL_M6__MCLKA_SRC_SEL_MASK                   0x00000007L
-#define MCLK_CNTL_M6__YCLKA_SRC_SEL_MASK                   0x00000070L
-#define MCLK_CNTL_M6__MCLKB_SRC_SEL_MASK                   0x00000700L
-#define MCLK_CNTL_M6__YCLKB_SRC_SEL_MASK                   0x00007000L
-#define MCLK_CNTL_M6__FORCE_MCLKA_MASK                     0x00010000L
-#define MCLK_CNTL_M6__FORCE_MCLKA                          0x00010000L
-#define MCLK_CNTL_M6__FORCE_MCLKB_MASK                     0x00020000L
-#define MCLK_CNTL_M6__FORCE_MCLKB                          0x00020000L
-#define MCLK_CNTL_M6__FORCE_YCLKA_MASK                     0x00040000L
-#define MCLK_CNTL_M6__FORCE_YCLKA                          0x00040000L
-#define MCLK_CNTL_M6__FORCE_YCLKB_MASK                     0x00080000L
-#define MCLK_CNTL_M6__FORCE_YCLKB                          0x00080000L
-#define MCLK_CNTL_M6__FORCE_MC_MASK                        0x00100000L
-#define MCLK_CNTL_M6__FORCE_MC                             0x00100000L
-#define MCLK_CNTL_M6__FORCE_AIC_MASK                       0x00200000L
-#define MCLK_CNTL_M6__FORCE_AIC                            0x00200000L
-#define MCLK_CNTL_M6__MRDCKA0_SOUTSEL_MASK                 0x03000000L
-#define MCLK_CNTL_M6__MRDCKA1_SOUTSEL_MASK                 0x0c000000L
-#define MCLK_CNTL_M6__MRDCKB0_SOUTSEL_MASK                 0x30000000L
-#define MCLK_CNTL_M6__MRDCKB1_SOUTSEL_MASK                 0xc0000000L
+// MCLK_CNTL
+#define MCLK_CNTL__MCLKA_SRC_SEL_MASK                   0x00000007L
+#define MCLK_CNTL__YCLKA_SRC_SEL_MASK                   0x00000070L
+#define MCLK_CNTL__MCLKB_SRC_SEL_MASK                   0x00000700L
+#define MCLK_CNTL__YCLKB_SRC_SEL_MASK                   0x00007000L
+#define MCLK_CNTL__FORCE_MCLKA_MASK                     0x00010000L
+#define MCLK_CNTL__FORCE_MCLKA                          0x00010000L
+#define MCLK_CNTL__FORCE_MCLKB_MASK                     0x00020000L
+#define MCLK_CNTL__FORCE_MCLKB                          0x00020000L
+#define MCLK_CNTL__FORCE_YCLKA_MASK                     0x00040000L
+#define MCLK_CNTL__FORCE_YCLKA                          0x00040000L
+#define MCLK_CNTL__FORCE_YCLKB_MASK                     0x00080000L
+#define MCLK_CNTL__FORCE_YCLKB                          0x00080000L
+#define MCLK_CNTL__FORCE_MC_MASK                        0x00100000L
+#define MCLK_CNTL__FORCE_MC                             0x00100000L
+#define MCLK_CNTL__FORCE_AIC_MASK                       0x00200000L
+#define MCLK_CNTL__FORCE_AIC                            0x00200000L
+#define MCLK_CNTL__MRDCKA0_SOUTSEL_MASK                 0x03000000L
+#define MCLK_CNTL__MRDCKA1_SOUTSEL_MASK                 0x0c000000L
+#define MCLK_CNTL__MRDCKB0_SOUTSEL_MASK                 0x30000000L
+#define MCLK_CNTL__MRDCKB1_SOUTSEL_MASK                 0xc0000000L
+#define MCLK_CNTL__R300_DISABLE_MC_MCLKA                (1 << 21)
+#define MCLK_CNTL__R300_DISABLE_MC_MCLKB                (1 << 21)
 
 // MCLK_MISC
 #define MCLK_MISC__SCLK_SOURCED_FROM_MPLL_SEL_MASK         0x00000003L
@@ -1238,19 +1243,14 @@
 
 // VCLK_ECP_CNTL
 #define VCLK_ECP_CNTL__VCLK_SRC_SEL_MASK                   0x00000003L
-#define VCLK_ECP_CNTL__VCLK_INVERT_MASK                    0x00000010L
 #define VCLK_ECP_CNTL__VCLK_INVERT                         0x00000010L
-#define VCLK_ECP_CNTL__PIXCLK_SRC_INVERT_MASK              0x00000020L
 #define VCLK_ECP_CNTL__PIXCLK_SRC_INVERT                   0x00000020L
-#define VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb_MASK              0x00000040L
 #define VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb                   0x00000040L
-#define VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb_MASK          0x00000080L
 #define VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb               0x00000080L
 #define VCLK_ECP_CNTL__ECP_DIV_MASK                        0x00000300L
-#define VCLK_ECP_CNTL__ECP_FORCE_ON_MASK                   0x00040000L
 #define VCLK_ECP_CNTL__ECP_FORCE_ON                        0x00040000L
-#define VCLK_ECP_CNTL__SUBCLK_FORCE_ON_MASK                0x00080000L
 #define VCLK_ECP_CNTL__SUBCLK_FORCE_ON                     0x00080000L
+#define VCLK_ECP_CNTL__R300_DISP_DAC_PIXCLK_DAC_BLANK_OFF  (1<<23)
 
 // PLL_PWRMGT_CNTL
 #define PLL_PWRMGT_CNTL__MPLL_TURNOFF_MASK                 0x00000001L
@@ -1282,54 +1282,54 @@
 #define PLL_PWRMGT_CNTL__SU_SUSTAIN_DISABLE                0x00080000L
 #define PLL_PWRMGT_CNTL__TCL_BYPASS_DISABLE_MASK           0x00100000L
 #define PLL_PWRMGT_CNTL__TCL_BYPASS_DISABLE                0x00100000L
-#define PLL_PWRMGT_CNTL__TCL_CLOCK_ACTIVE_RD_MASK          0x00200000L
+#define PLL_PWRMGT_CNTL__TCL_CLOCK_CTIVE_RD_MASK          0x00200000L
 #define PLL_PWRMGT_CNTL__TCL_CLOCK_ACTIVE_RD               0x00200000L
 #define PLL_PWRMGT_CNTL__CG_NO2_DEBUG_MASK                 0xff000000L
 
-// CLK_PWRMGT_CNTL_M6
-#define CLK_PWRMGT_CNTL_M6__MPLL_PWRMGT_OFF_MASK           0x00000001L
-#define CLK_PWRMGT_CNTL_M6__MPLL_PWRMGT_OFF                0x00000001L
-#define CLK_PWRMGT_CNTL_M6__SPLL_PWRMGT_OFF_MASK           0x00000002L
-#define CLK_PWRMGT_CNTL_M6__SPLL_PWRMGT_OFF                0x00000002L
-#define CLK_PWRMGT_CNTL_M6__PPLL_PWRMGT_OFF_MASK           0x00000004L
-#define CLK_PWRMGT_CNTL_M6__PPLL_PWRMGT_OFF                0x00000004L
-#define CLK_PWRMGT_CNTL_M6__P2PLL_PWRMGT_OFF_MASK          0x00000008L
-#define CLK_PWRMGT_CNTL_M6__P2PLL_PWRMGT_OFF               0x00000008L
-#define CLK_PWRMGT_CNTL_M6__MCLK_TURNOFF_MASK              0x00000010L
-#define CLK_PWRMGT_CNTL_M6__MCLK_TURNOFF                   0x00000010L
-#define CLK_PWRMGT_CNTL_M6__SCLK_TURNOFF_MASK              0x00000020L
-#define CLK_PWRMGT_CNTL_M6__SCLK_TURNOFF                   0x00000020L
-#define CLK_PWRMGT_CNTL_M6__PCLK_TURNOFF_MASK              0x00000040L
-#define CLK_PWRMGT_CNTL_M6__PCLK_TURNOFF                   0x00000040L
-#define CLK_PWRMGT_CNTL_M6__P2CLK_TURNOFF_MASK             0x00000080L
-#define CLK_PWRMGT_CNTL_M6__P2CLK_TURNOFF                  0x00000080L
-#define CLK_PWRMGT_CNTL_M6__MC_CH_MODE_MASK                0x00000100L
-#define CLK_PWRMGT_CNTL_M6__MC_CH_MODE                     0x00000100L
-#define CLK_PWRMGT_CNTL_M6__TEST_MODE_MASK                 0x00000200L
-#define CLK_PWRMGT_CNTL_M6__TEST_MODE                      0x00000200L
-#define CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN_MASK            0x00000400L
-#define CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN                 0x00000400L
-#define CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE_MASK        0x00001000L
-#define CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE             0x00001000L
-#define CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT_MASK           0x00006000L
-#define CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT_MASK         0x00008000L
-#define CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT              0x00008000L
-#define CLK_PWRMGT_CNTL_M6__MC_BUSY_MASK                   0x00010000L
-#define CLK_PWRMGT_CNTL_M6__MC_BUSY                        0x00010000L
-#define CLK_PWRMGT_CNTL_M6__MC_INT_CNTL_MASK               0x00020000L
-#define CLK_PWRMGT_CNTL_M6__MC_INT_CNTL                    0x00020000L
-#define CLK_PWRMGT_CNTL_M6__MC_SWITCH_MASK                 0x00040000L
-#define CLK_PWRMGT_CNTL_M6__MC_SWITCH                      0x00040000L
-#define CLK_PWRMGT_CNTL_M6__DLL_READY_MASK                 0x00080000L
-#define CLK_PWRMGT_CNTL_M6__DLL_READY                      0x00080000L
-#define CLK_PWRMGT_CNTL_M6__DISP_PM_MASK                   0x00100000L
-#define CLK_PWRMGT_CNTL_M6__DISP_PM                        0x00100000L
-#define CLK_PWRMGT_CNTL_M6__DYN_STOP_MODE_MASK             0x00e00000L
-#define CLK_PWRMGT_CNTL_M6__CG_NO1_DEBUG_MASK              0x3f000000L
-#define CLK_PWRMGT_CNTL_M6__TVPLL_PWRMGT_OFF_MASK          0x40000000L
-#define CLK_PWRMGT_CNTL_M6__TVPLL_PWRMGT_OFF               0x40000000L
-#define CLK_PWRMGT_CNTL_M6__TVCLK_TURNOFF_MASK             0x80000000L
-#define CLK_PWRMGT_CNTL_M6__TVCLK_TURNOFF                  0x80000000L
+// CLK_PWRMGT_CNTL
+#define CLK_PWRMGT_CNTL__MPLL_PWRMGT_OFF_MASK           0x00000001L
+#define CLK_PWRMGT_CNTL__MPLL_PWRMGT_OFF                0x00000001L
+#define CLK_PWRMGT_CNTL__SPLL_PWRMGT_OFF_MASK           0x00000002L
+#define CLK_PWRMGT_CNTL__SPLL_PWRMGT_OFF                0x00000002L
+#define CLK_PWRMGT_CNTL__PPLL_PWRMGT_OFF_MASK           0x00000004L
+#define CLK_PWRMGT_CNTL__PPLL_PWRMGT_OFF                0x00000004L
+#define CLK_PWRMGT_CNTL__P2PLL_PWRMGT_OFF_MASK          0x00000008L
+#define CLK_PWRMGT_CNTL__P2PLL_PWRMGT_OFF               0x00000008L
+#define CLK_PWRMGT_CNTL__MCLK_TURNOFF_MASK              0x00000010L
+#define CLK_PWRMGT_CNTL__MCLK_TURNOFF                   0x00000010L
+#define CLK_PWRMGT_CNTL__SCLK_TURNOFF_MASK              0x00000020L
+#define CLK_PWRMGT_CNTL__SCLK_TURNOFF                   0x00000020L
+#define CLK_PWRMGT_CNTL__PCLK_TURNOFF_MASK              0x00000040L
+#define CLK_PWRMGT_CNTL__PCLK_TURNOFF                   0x00000040L
+#define CLK_PWRMGT_CNTL__P2CLK_TURNOFF_MASK             0x00000080L
+#define CLK_PWRMGT_CNTL__P2CLK_TURNOFF                  0x00000080L
+#define CLK_PWRMGT_CNTL__MC_CH_MODE_MASK                0x00000100L
+#define CLK_PWRMGT_CNTL__MC_CH_MODE                     0x00000100L
+#define CLK_PWRMGT_CNTL__TEST_MODE_MASK                 0x00000200L
+#define CLK_PWRMGT_CNTL__TEST_MODE                      0x00000200L
+#define CLK_PWRMGT_CNTL__GLOBAL_PMAN_EN_MASK            0x00000400L
+#define CLK_PWRMGT_CNTL__GLOBAL_PMAN_EN                 0x00000400L
+#define CLK_PWRMGT_CNTL__ENGINE_DYNCLK_MODE_MASK        0x00001000L
+#define CLK_PWRMGT_CNTL__ENGINE_DYNCLK_MODE             0x00001000L
+#define CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT_MASK           0x00006000L
+#define CLK_PWRMGT_CNTL__DISP_DYN_STOP_LAT_MASK         0x00008000L
+#define CLK_PWRMGT_CNTL__DISP_DYN_STOP_LAT              0x00008000L
+#define CLK_PWRMGT_CNTL__MC_BUSY_MASK                   0x00010000L
+#define CLK_PWRMGT_CNTL__MC_BUSY                        0x00010000L
+#define CLK_PWRMGT_CNTL__MC_INT_CNTL_MASK               0x00020000L
+#define CLK_PWRMGT_CNTL__MC_INT_CNTL                    0x00020000L
+#define CLK_PWRMGT_CNTL__MC_SWITCH_MASK                 0x00040000L
+#define CLK_PWRMGT_CNTL__MC_SWITCH                      0x00040000L
+#define CLK_PWRMGT_CNTL__DLL_READY_MASK                 0x00080000L
+#define CLK_PWRMGT_CNTL__DLL_READY                      0x00080000L
+#define CLK_PWRMGT_CNTL__DISP_PM_MASK                   0x00100000L
+#define CLK_PWRMGT_CNTL__DISP_PM                        0x00100000L
+#define CLK_PWRMGT_CNTL__DYN_STOP_MODE_MASK             0x00e00000L
+#define CLK_PWRMGT_CNTL__CG_NO1_DEBUG_MASK              0x3f000000L
+#define CLK_PWRMGT_CNTL__TVPLL_PWRMGT_OFF_MASK          0x40000000L
+#define CLK_PWRMGT_CNTL__TVPLL_PWRMGT_OFF               0x40000000L
+#define CLK_PWRMGT_CNTL__TVCLK_TURNOFF_MASK             0x80000000L
+#define CLK_PWRMGT_CNTL__TVCLK_TURNOFF                  0x80000000L
 
 // BUS_CNTL1
 #define BUS_CNTL1__PMI_IO_DISABLE_MASK                     0x00000001L
@@ -1876,53 +1876,63 @@
 #define MDLL_RDCKB__MRDCKB1_BP_SEL_MASK                    0x80000000L
 #define MDLL_RDCKB__MRDCKB1_BP_SEL                         0x80000000L
 
-#define pllVCLK_ECP_CNTL                            0x0008
-#define pllDISP_TEST_MACRO_RW_WRITE                 0x001A
-#define pllDISP_TEST_MACRO_RW_READ                  0x001B
-#define pllDISP_TEST_MACRO_RW_DATA                  0x001C
-#define pllDISP_TEST_MACRO_RW_CNTL                  0x001D
-#define pllPIXCLKS_CNTL                             0x002D
+#define MDLL_R300_RDCK__MRDCKA_SLEEP                       0x00000001L
+#define MDLL_R300_RDCK__MRDCKA_RESET                       0x00000002L
+#define MDLL_R300_RDCK__MRDCKB_SLEEP                       0x00000004L
+#define MDLL_R300_RDCK__MRDCKB_RESET                       0x00000008L
+#define MDLL_R300_RDCK__MRDCKC_SLEEP                       0x00000010L
+#define MDLL_R300_RDCK__MRDCKC_RESET                       0x00000020L
+#define MDLL_R300_RDCK__MRDCKD_SLEEP                       0x00000040L
+#define MDLL_R300_RDCK__MRDCKD_RESET                       0x00000080L
+
+#define pllCLK_PIN_CNTL                             0x0001
+#define pllPPLL_CNTL                                0x0002
+#define pllPPLL_REF_DIV                             0x0003
 #define pllPPLL_DIV_0                               0x0004
 #define pllPPLL_DIV_1                               0x0005
 #define pllPPLL_DIV_2                               0x0006
 #define pllPPLL_DIV_3                               0x0007
+#define pllVCLK_ECP_CNTL                            0x0008
 #define pllHTOTAL_CNTL                              0x0009
-#define pllPLL_TEST_CNTL_M6                         0x0013
-#define pllP2PLL_DIV_0                              0x002C
-#define pllHTOTAL2_CNTL                             0x002E
-#define pllCLK_PIN_CNTL                             0x0001
-#define pllPPLL_CNTL                                0x0002
-#define pllPPLL_REF_DIV                             0x0003
-#define pllSPLL_CNTL                                0x000C
-#define pllSPLL_AUX_CNTL                            0x0024
-#define pllSCLK_CNTL_M6                             0x000D
+#define pllM_SPLL_REF_FB_DIV                        0x000A
 #define pllAGP_PLL_CNTL                             0x000B
+#define pllSPLL_CNTL                                0x000C
+#define pllSCLK_CNTL                                0x000D
+#define pllMPLL_CNTL                                0x000E
+#define pllMDLL_CKO                                 0x000F
+#define pllMDLL_RDCKA                               0x0010
+#define pllMDLL_RDCKB                               0x0011
+#define pllMCLK_CNTL                                0x0012
+#define pllPLL_TEST_CNTL                            0x0013
+#define pllCLK_PWRMGT_CNTL                          0x0014
+#define pllPLL_PWRMGT_CNTL                          0x0015
+#define pllCG_TEST_MACRO_RW_WRITE                   0x0016
+#define pllCG_TEST_MACRO_RW_READ                    0x0017
+#define pllCG_TEST_MACRO_RW_DATA                    0x0018
+#define pllCG_TEST_MACRO_RW_CNTL                    0x0019
+#define pllDISP_TEST_MACRO_RW_WRITE                 0x001A
+#define pllDISP_TEST_MACRO_RW_READ                  0x001B
+#define pllDISP_TEST_MACRO_RW_DATA                  0x001C
+#define pllDISP_TEST_MACRO_RW_CNTL                  0x001D
+#define pllSCLK_CNTL2                               0x001E
+#define pllMCLK_MISC                                0x001F
 #define pllTV_PLL_FINE_CNTL                         0x0020
 #define pllTV_PLL_CNTL                              0x0021
 #define pllTV_PLL_CNTL1                             0x0022
 #define pllTV_DTO_INCREMENTS                        0x0023
+#define pllSPLL_AUX_CNTL                            0x0024
+#define pllMPLL_AUX_CNTL                            0x0025
 #define pllP2PLL_CNTL                               0x002A
 #define pllP2PLL_REF_DIV                            0x002B
+#define pllP2PLL_DIV_0                              0x002C
+#define pllPIXCLKS_CNTL                             0x002D
+#define pllHTOTAL2_CNTL                             0x002E
 #define pllSSPLL_CNTL                               0x0030
 #define pllSSPLL_REF_DIV                            0x0031
 #define pllSSPLL_DIV_0                              0x0032
 #define pllSS_INT_CNTL                              0x0033
 #define pllSS_TST_CNTL                              0x0034
 #define pllSCLK_MORE_CNTL                           0x0035
-#define pllCLK_PWRMGT_CNTL_M6                       0x0014
-#define pllPLL_PWRMGT_CNTL                          0x0015
-#define pllM_SPLL_REF_FB_DIV                        0x000A
-#define pllMPLL_CNTL                                0x000E
-#define pllMPLL_AUX_CNTL                            0x0025
-#define pllMDLL_CKO                                 0x000F
-#define pllMDLL_RDCKA                               0x0010
-#define pllMDLL_RDCKB                               0x0011
-#define pllMCLK_CNTL_M6                             0x0012
-#define pllMCLK_MISC                                0x001F
-#define pllCG_TEST_MACRO_RW_WRITE                   0x0016
-#define pllCG_TEST_MACRO_RW_READ                    0x0017
-#define pllCG_TEST_MACRO_RW_DATA                    0x0018
-#define pllCG_TEST_MACRO_RW_CNTL                    0x0019
 
 #define ixMC_PERF_CNTL                             0x0000
 #define ixMC_PERF_SEL                              0x0001
@@ -1945,7 +1955,29 @@
 #define ixMC_BIST_CTRL                             0x0012
 #define ixREG_COLLAR_WRITE                         0x0013
 #define ixREG_COLLAR_READ                          0x0014
-
+#define ixR300_MC_IMP_CNTL                         0x0018
+#define ixR300_MC_CHP_IO_CNTL_A0                   0x0019
+#define ixR300_MC_CHP_IO_CNTL_A1                   0x001a
+#define ixR300_MC_CHP_IO_CNTL_B0                   0x001b
+#define ixR300_MC_CHP_IO_CNTL_B1                   0x001c
+#define ixR300_MC_CHP_IO_CNTL_C0                   0x001d
+#define ixR300_MC_CHP_IO_CNTL_C1                   0x001e
+#define ixR300_MC_CHP_IO_CNTL_D0                   0x001f
+#define ixR300_MC_CHP_IO_CNTL_D1                   0x0020
+#define ixR300_MC_IMP_CNTL_0                       0x0021
+#define ixR300_MC_ELPIDA_CNTL                      0x0022
+#define ixR300_MC_CHP_IO_OE_CNTL_CD                0x0023
+#define ixR300_MC_READ_CNTL_CD                     0x0024
+#define ixR300_MC_MC_INIT_WR_LAT_TIMER             0x0025
+#define ixR300_MC_DEBUG_CNTL                       0x0026
+#define ixR300_MC_BIST_CNTL_0                      0x0028
+#define ixR300_MC_BIST_CNTL_1                      0x0029
+#define ixR300_MC_BIST_CNTL_2                      0x002a
+#define ixR300_MC_BIST_CNTL_3                      0x002b
+#define ixR300_MC_BIST_CNTL_4                      0x002c
+#define ixR300_MC_BIST_CNTL_5                      0x002d
+#define ixR300_MC_IMP_STATUS                       0x002e
+#define ixR300_MC_DLL_CNTL                         0x002f
 #define NB_TOM                                     0x15C
 
 
Index: linux-work/drivers/video/aty/radeon_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_base.c	2005-01-17 13:24:18.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_base.c	2005-01-17 13:49:30.043584848 +1100
@@ -1,5 +1,7 @@
+
 /*
- *	drivers/video/radeonfb.c
+ *	drivers/video/aty/radeon_base.c
+ *
  *	framebuffer driver for ATI Radeon chipset video boards
  *
  *	Copyright 2003	Ben. Herrenschmidt <benh@kernel.crashing.org>
@@ -75,7 +77,6 @@
 
 #ifdef CONFIG_PPC_OF
 
-#include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include "../macmodes.h"
 
@@ -150,8 +151,10 @@
 	CHIP_DEF(PCI_CHIP_RV250_Ig,	RV250,	CHIP_HAS_CRTC2),
 	/* Mobility 9100 IGP (U3) */
 	CHIP_DEF(PCI_CHIP_RS300_5835,	RS300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RS350_7835,	RS300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
 	/* 9100 IGP (A5) */
 	CHIP_DEF(PCI_CHIP_RS300_5834,	RS300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP),
+	CHIP_DEF(PCI_CHIP_RS350_7834,	RS300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP),
 	/* Mobility 9200 (M9+) */
 	CHIP_DEF(PCI_CHIP_RV280_5C61,	RV280,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
 	CHIP_DEF(PCI_CHIP_RV280_5C63,	RV280,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
@@ -194,6 +197,33 @@
 	CHIP_DEF(PCI_CHIP_R350_NI,	R350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R360_NJ,	R350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R350_NK,	R350,	CHIP_HAS_CRTC2),
+	/* Newer stuff */ 
+	CHIP_DEF(PCI_CHIP_RV380_3E50,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV380_3E54,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV380_3150,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV380_3154,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV370_5B60,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV370_5B62,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV370_5B64,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV370_5B65,	RV380,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV370_5460,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV370_5464,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R420_JH,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JI,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JJ,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JK,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JL,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JM,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JN,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R420_JP,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UH,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UI,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UJ,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UK,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UQ,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UR,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UT,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_5D57,	R420,	CHIP_HAS_CRTC2),
 	/* Original Radeon/7200 */
 	CHIP_DEF(PCI_CHIP_RADEON_QD,	RADEON,	0),
 	CHIP_DEF(PCI_CHIP_RADEON_QE,	RADEON,	0),
@@ -233,6 +263,7 @@
 static char *mode_option;
 static char *monitor_layout;
 static int noaccel = 0;
+static int default_dynclk = -2;
 static int nomodeset = 0;
 static int ignore_edid = 0;
 static int mirror = 0;
@@ -290,7 +321,8 @@
                                                                                                           
 	rom = pci_map_rom(dev, &rom_size);
 	if (!rom) {
-		printk(KERN_ERR "radeonfb: ROM failed to map\n");
+		printk(KERN_ERR "radeonfb (%s): ROM failed to map\n",
+		       pci_name(rinfo->pdev));
 		return -ENOMEM;
 	}
 	
@@ -298,8 +330,8 @@
 
 	/* Very simple test to make sure it appeared */
 	if (BIOS_IN16(0) != 0xaa55) {
-		printk(KERN_ERR "radeonfb: Invalid ROM signature %x should be 0xaa55\n",
-		       BIOS_IN16(0));
+		printk(KERN_ERR "radeonfb (%s): Invalid ROM signature %x should be"
+		       "0xaa55\n", pci_name(rinfo->pdev), BIOS_IN16(0));
 		goto failed;
 	}
 	/* Look for the PCI data to check the ROM type */
@@ -330,8 +362,8 @@
 	 * } pci_data_t;
 	 */
 	if (BIOS_IN32(dptr) !=  (('R' << 24) | ('I' << 16) | ('C' << 8) | 'P')) {
-		printk(KERN_WARNING "radeonfb: PCI DATA signature in ROM incorrect: %08x\n",
-		       BIOS_IN32(dptr));
+		printk(KERN_WARNING "radeonfb (%s): PCI DATA signature in ROM"
+		       "incorrect: %08x\n", pci_name(rinfo->pdev), BIOS_IN32(dptr));
 		goto anyway;
 	}
 	rom_type = BIOS_IN8(dptr + 0x14);
@@ -398,14 +430,11 @@
  */
 static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
 {
-	struct device_node *dp;
+	struct device_node *dp = rinfo->of_node;
 	u32 *val;
 
-	dp = pci_device_to_OF_node(rinfo->pdev);
-	if (dp == NULL) {
-		printk(KERN_WARNING "radeonfb: Cannot match card to OF node !\n");
+	if (dp == NULL)
 		return -ENODEV;
-	}
 	val = (u32 *) get_property(dp, "ATY,RefCLK", NULL);
 	if (!val || !*val) {
 		printk(KERN_WARNING "radeonfb: No ATY,RefCLK property !\n");
@@ -488,20 +517,20 @@
 		denom = 1;
 		break;
 	case 1:
-		n = ((INPLL(X_MPLL_REF_FB_DIV) >> 16) & 0xff);
-		m = (INPLL(X_MPLL_REF_FB_DIV) & 0xff);
+		n = ((INPLL(M_SPLL_REF_FB_DIV) >> 16) & 0xff);
+		m = (INPLL(M_SPLL_REF_FB_DIV) & 0xff);
 		num = 2*n;
 		denom = 2*m;
 		break;
 	case 2:
-		n = ((INPLL(X_MPLL_REF_FB_DIV) >> 8) & 0xff);
-		m = (INPLL(X_MPLL_REF_FB_DIV) & 0xff);
+		n = ((INPLL(M_SPLL_REF_FB_DIV) >> 8) & 0xff);
+		m = (INPLL(M_SPLL_REF_FB_DIV) & 0xff);
 		num = 2*n;
 		denom = 2*m;
         break;
 	}
 
-	ppll_div_sel = INREG(CLOCK_CNTL_INDEX + 1) & 0x3;
+	ppll_div_sel = INREG8(CLOCK_CNTL_INDEX + 1) & 0x3;
 
 	n = (INPLL(PPLL_DIV_0 + ppll_div_sel) & 0x7ff);
 	m = (INPLL(PPLL_REF_DIV) & 0x3ff);
@@ -545,7 +574,7 @@
 		return -1;
 	}
 
-	tmp = INPLL(X_MPLL_REF_FB_DIV);
+	tmp = INPLL(M_SPLL_REF_FB_DIV);
 	ref_div = INPLL(PPLL_REF_DIV) & 0x3ff;
 
 	Ns = (tmp & 0xff0000) >> 16;
@@ -625,7 +654,7 @@
 		rinfo->pll.ref_clk = 2700;
 		break;
 	}
-	rinfo->pll.ref_div = INPLL(PPLL_REF_DIV) & 0x3ff;
+	rinfo->pll.ref_div = INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK;
 
 
 #ifdef CONFIG_PPC_OF
@@ -906,10 +935,11 @@
 }
 
 
-static int radeon_screen_blank (struct radeonfb_info *rinfo, int blank, int mode_switch)
+int radeon_screen_blank(struct radeonfb_info *rinfo, int blank, int mode_switch)
 {
         u32 val;
 	u32 tmp_pix_clks;
+	int unblank = 0;
 
 	if (rinfo->lock_blank)
 		return 0;
@@ -920,9 +950,6 @@
         val &= ~(CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS |
                  CRTC_VSYNC_DIS);
         switch (blank) {
-	case FB_BLANK_UNBLANK:
-	case FB_BLANK_NORMAL:
-		break;
 	case FB_BLANK_VSYNC_SUSPEND:
 		val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS);
 		break;
@@ -933,42 +960,51 @@
 		val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS |
 			CRTC_HSYNC_DIS);
 		break;
+	case FB_BLANK_NORMAL:
+		val |= CRTC_DISPLAY_DIS;
+		break;
+	case FB_BLANK_UNBLANK:
+	default:
+		unblank = 1;
         }
 	OUTREG(CRTC_EXT_CNTL, val);
 
 
 	switch (rinfo->mon1_type) {
 	case MT_DFP:
-		if (mode_switch)
-			break;
-		if (blank == FB_BLANK_UNBLANK ||
-		    blank == FB_BLANK_NORMAL)
+		if (unblank)
 			OUTREGP(FP_GEN_CNTL, (FP_FPON | FP_TMDS_EN),
 				~(FP_FPON | FP_TMDS_EN));
-		else
+		else {	
+			if (mode_switch || blank == FB_BLANK_NORMAL)
+				break;
 			OUTREGP(FP_GEN_CNTL, 0, ~(FP_FPON | FP_TMDS_EN));
+		}
 		break;
 	case MT_LCD:
+		del_timer_sync(&rinfo->lvds_timer);
 		val = INREG(LVDS_GEN_CNTL);
-		if (blank == FB_BLANK_UNBLANK ||
-		    blank == FB_BLANK_NORMAL) {
+		if (unblank) {
 			u32 target_val = (val & ~LVDS_DISPLAY_DIS) | LVDS_BLON | LVDS_ON
-				| LVDS_ON | (rinfo->init_state.lvds_gen_cntl & LVDS_DIGON);
+				| LVDS_EN | (rinfo->init_state.lvds_gen_cntl
+					     & (LVDS_DIGON | LVDS_BL_MOD_EN));
 			if ((val ^ target_val) == LVDS_DISPLAY_DIS)
 				OUTREG(LVDS_GEN_CNTL, target_val);
 			else if ((val ^ target_val) != 0) {
-				del_timer_sync(&rinfo->lvds_timer);
-				OUTREG(LVDS_GEN_CNTL, target_val & ~LVDS_ON);
+				OUTREG(LVDS_GEN_CNTL, target_val
+				       & ~(LVDS_ON | LVDS_BL_MOD_EN));
 				rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
-				rinfo->init_state.lvds_gen_cntl |= target_val & LVDS_STATE_MASK;
+				rinfo->init_state.lvds_gen_cntl |=
+					target_val & LVDS_STATE_MASK;
 				if (mode_switch) {
-					msleep(rinfo->panel_info.pwr_delay);
+					radeon_msleep(rinfo->panel_info.pwr_delay);
 					OUTREG(LVDS_GEN_CNTL, target_val);
 				}
 				else {
 					rinfo->pending_lvds_gen_cntl = target_val;
 					mod_timer(&rinfo->lvds_timer,
-						jiffies + msecs_to_jiffies(rinfo->panel_info.pwr_delay));
+					   jiffies +
+					   msecs_to_jiffies(rinfo->panel_info.pwr_delay));
 				}
 			}
 		} else {
@@ -976,7 +1012,7 @@
 			OUTREG(LVDS_GEN_CNTL, val);
 
 			/* We don't do a full switch-off on a simple mode switch */
-			if (mode_switch)
+			if (mode_switch || blank == FB_BLANK_NORMAL)
 				break;
 
 			/* Asic bug, when turning off LVDS_ON, we have to make sure
@@ -985,8 +1021,16 @@
 			tmp_pix_clks = INPLL(PIXCLKS_CNTL);
 			if (rinfo->is_mobility || rinfo->is_IGP)
 				OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
-			val &= ~(LVDS_BLON | LVDS_ON);
+			val &= ~(LVDS_BL_MOD_EN);
+			OUTREG(LVDS_GEN_CNTL, val);
+			udelay(100);
+			val &= ~(LVDS_ON | LVDS_EN);
 			OUTREG(LVDS_GEN_CNTL, val);
+			val &= ~LVDS_DIGON;
+			rinfo->pending_lvds_gen_cntl = val;
+			mod_timer(&rinfo->lvds_timer,
+				  jiffies +
+				  msecs_to_jiffies(rinfo->panel_info.pwr_delay));
 			rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
 			rinfo->init_state.lvds_gen_cntl |= val & LVDS_STATE_MASK;
 			if (rinfo->is_mobility || rinfo->is_IGP)
@@ -1003,16 +1047,14 @@
 	return (blank == FB_BLANK_NORMAL) ? -EINVAL : 0;
 }
 
-int radeonfb_blank (int blank, struct fb_info *info)
+static int radeonfb_blank (int blank, struct fb_info *info)
 {
         struct radeonfb_info *rinfo = info->par;
 
 	if (rinfo->asleep)
 		return 0;
 		
-	radeon_screen_blank(rinfo, blank, 0);
-
-	return 0;
+	return radeon_screen_blank(rinfo, blank, 0);
 }
 
 static int radeonfb_setcolreg (unsigned regno, unsigned red, unsigned green,
@@ -1097,7 +1139,7 @@
 }
 
 
-static void radeon_save_state (struct radeonfb_info *rinfo, struct radeon_regs *save)
+void radeon_save_state (struct radeonfb_info *rinfo, struct radeon_regs *save)
 {
 	/* CRTC regs */
 	save->crtc_gen_cntl = INREG(CRTC_GEN_CNTL);
@@ -1121,8 +1163,14 @@
 	save->fp_vert_stretch = INREG(FP_VERT_STRETCH);
 	save->lvds_gen_cntl = INREG(LVDS_GEN_CNTL);
 	save->lvds_pll_cntl = INREG(LVDS_PLL_CNTL);
-	save->tmds_crc = INREG(TMDS_CRC);	save->tmds_transmitter_cntl = INREG(TMDS_TRANSMITTER_CNTL);
+	save->tmds_crc = INREG(TMDS_CRC);
+	save->tmds_transmitter_cntl = INREG(TMDS_TRANSMITTER_CNTL);
 	save->vclk_ecp_cntl = INPLL(VCLK_ECP_CNTL);
+
+	/* PLL regs */
+	save->clk_cntl_index = INREG(CLOCK_CNTL_INDEX) & ~0x3f;
+	save->ppll_div_3 = INPLL(PPLL_DIV_3);
+	save->ppll_ref_div = INPLL(PPLL_REF_DIV);
 }
 
 
@@ -1134,19 +1182,22 @@
 
 	/* Workaround from XFree */
 	if (rinfo->is_mobility) {
-	        /* A temporal workaround for the occational blanking on certain laptop panels. 
-	           This appears to related to the PLL divider registers (fail to lock?).  
-		   It occurs even when all dividers are the same with their old settings.  
-	           In this case we really don't need to fiddle with PLL registers. 
-	           By doing this we can avoid the blanking problem with some panels.
-	        */
+	        /* A temporal workaround for the occational blanking on certain laptop
+		 * panels. This appears to related to the PLL divider registers
+		 * (fail to lock?). It occurs even when all dividers are the same
+		 * with their old settings. In this case we really don't need to
+		 * fiddle with PLL registers. By doing this we can avoid the blanking
+		 * problem with some panels.
+	         */
 		if ((mode->ppll_ref_div == (INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK)) &&
 		    (mode->ppll_div_3 == (INPLL(PPLL_DIV_3) &
 					  (PPLL_POST3_DIV_MASK | PPLL_FB3_DIV_MASK)))) {
-			/* We still have to force a switch to PPLL div 3 thanks to
+			/* We still have to force a switch to selected PPLL div thanks to
 			 * an XFree86 driver bug which will switch it away in some cases
 			 * even when using UseFDev */
-			OUTREGP(CLOCK_CNTL_INDEX, PPLL_DIV_SEL_MASK, ~PPLL_DIV_SEL_MASK);
+			OUTREGP(CLOCK_CNTL_INDEX,
+				mode->clk_cntl_index & PPLL_DIV_SEL_MASK,
+				~PPLL_DIV_SEL_MASK);
             		return;
 		}
 	}
@@ -1159,8 +1210,10 @@
 		PPLL_RESET | PPLL_ATOMIC_UPDATE_EN | PPLL_VGA_ATOMIC_UPDATE_EN,
 		~(PPLL_RESET | PPLL_ATOMIC_UPDATE_EN | PPLL_VGA_ATOMIC_UPDATE_EN));
 
-	/* Switch to PPLL div 3 */
-	OUTREGP(CLOCK_CNTL_INDEX, PPLL_DIV_SEL_MASK, ~PPLL_DIV_SEL_MASK);
+	/* Switch to selected PPLL divider */
+	OUTREGP(CLOCK_CNTL_INDEX,
+		mode->clk_cntl_index & PPLL_DIV_SEL_MASK,
+		~PPLL_DIV_SEL_MASK);
 
 	/* Set PPLL ref. div */
 	if (rinfo->family == CHIP_FAMILY_R300 ||
@@ -1205,7 +1258,7 @@
 		~(PPLL_RESET | PPLL_SLEEP | PPLL_ATOMIC_UPDATE_EN | PPLL_VGA_ATOMIC_UPDATE_EN));
 
 	/* We may want some locking ... oh well */
-       	msleep(5);
+       	radeon_msleep(5);
 
 	/* Switch back VCLK source to PPLL */
 	OUTPLLP(VCLK_ECP_CNTL, VCLK_SRC_SEL_PPLLCLK, ~VCLK_SRC_SEL_MASK);
@@ -1218,21 +1271,17 @@
 {
 	struct radeonfb_info *rinfo = (struct radeonfb_info *)data;
 
-	radeon_fifo_wait(3);
+	radeon_engine_idle();
 
 	OUTREG(LVDS_GEN_CNTL, rinfo->pending_lvds_gen_cntl);
-	if (rinfo->pending_pixclks_cntl) {
-		OUTPLL(PIXCLKS_CNTL, rinfo->pending_pixclks_cntl);
-		rinfo->pending_pixclks_cntl = 0;
-	}
 }
 
 /*
  * Apply a video mode. This will apply the whole register set, including
  * the PLL registers, to the card
  */
-static void radeon_write_mode (struct radeonfb_info *rinfo,
-                               struct radeon_regs *mode)
+void radeon_write_mode (struct radeonfb_info *rinfo, struct radeon_regs *mode,
+			int regs_only)
 {
 	int i;
 	int primary_mon = PRIMARY_MONITOR(rinfo);
@@ -1240,10 +1289,8 @@
 	if (nomodeset)
 		return;
 
-	del_timer_sync(&rinfo->lvds_timer);
-
-	radeon_screen_blank(rinfo, FB_BLANK_POWERDOWN, 1);
-	msleep(100);
+	if (!regs_only)
+		radeon_screen_blank(rinfo, FB_BLANK_NORMAL, 0);
 
 	radeon_fifo_wait(31);
 	for (i=0; i<10; i++)
@@ -1285,7 +1332,8 @@
 		OUTREG(TMDS_TRANSMITTER_CNTL, mode->tmds_transmitter_cntl);
 	}
 
-	radeon_screen_blank(rinfo, FB_BLANK_UNBLANK, 1);
+	if (!regs_only)
+		radeon_screen_blank(rinfo, FB_BLANK_UNBLANK, 0);
 
 	radeon_fifo_wait(2);
 	OUTPLL(VCLK_ECP_CNTL, mode->vclk_ecp_cntl);
@@ -1396,6 +1444,16 @@
 	       rinfo->pll.ref_div, rinfo->pll.ref_clk,
 	       pll_output_freq);
 
+	/* If we fall through the bottom, try the "default value"
+	   given by the terminal post_div->bitvalue */
+	if ( !post_div->divider ) {
+		post_div = &post_divs[post_div->bitvalue];
+		pll_output_freq = post_div->divider * freq;
+	}
+	RTRACE("ref_div = %d, ref_clk = %d, output_freq = %d\n",
+	       rinfo->pll.ref_div, rinfo->pll.ref_clk,
+	       pll_output_freq);
+
 	fb_div = round_div(rinfo->pll.ref_div*pll_output_freq,
 				  rinfo->pll.ref_clk);
 	regs->ppll_ref_div = rinfo->pll.ref_div;
@@ -1406,22 +1464,27 @@
 	RTRACE("ppll_div_3 = 0x%x\n", regs->ppll_div_3);
 }
 
-int radeonfb_set_par(struct fb_info *info)
+static int radeonfb_set_par(struct fb_info *info)
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
+	int use_rmx = 0;
+
+	newmode = kmalloc(sizeof(struct radeon_regs), GFP_KERNEL);
+	if (!newmode)
+		return -ENOMEM;
 
 	/* We always want engine to be idle on a mode switch, even
 	 * if we won't actually change the mode
@@ -1462,9 +1525,9 @@
 
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
@@ -1502,38 +1565,38 @@
 
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
@@ -1542,18 +1605,18 @@
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
 
@@ -1563,28 +1626,28 @@
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
@@ -1592,10 +1655,14 @@
 	RTRACE("pixclock = %lu\n", (unsigned long)pixClock);
 	RTRACE("freq = %lu\n", (unsigned long)freq);
 
+	/* We use PPLL_DIV_3 */
+	newmode->clk_cntl_index = 0x300;
+
+	/* Calculate PPLL value if necessary */
 	if (!nopllcalc)
-		radeon_calc_pll_regs(rinfo, &newmode, freq);
+		radeon_calc_pll_regs(rinfo, newmode, freq);
 
-	newmode.vclk_ecp_cntl = rinfo->init_state.vclk_ecp_cntl;
+	newmode->vclk_ecp_cntl = rinfo->init_state.vclk_ecp_cntl;
 
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
 		unsigned int hRatio, vRatio;
@@ -1605,35 +1672,37 @@
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
+			use_rmx = 1;
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
+			use_rmx = 1;
 		}
-		newmode.fp_vert_stretch &= ~VERT_AUTO_RATIO_EN;
+		newmode->fp_vert_stretch &= ~VERT_AUTO_RATIO_EN;
 
-		newmode.fp_gen_cntl = (rinfo->init_state.fp_gen_cntl & (u32)
+		newmode->fp_gen_cntl = (rinfo->init_state.fp_gen_cntl & (u32)
 				       ~(FP_SEL_CRTC2 |
 					 FP_RMX_HVSYNC_CONTROL_EN |
 					 FP_DFP_SYNC_SEL |
@@ -1643,46 +1712,56 @@
 					 FP_CRTC_USE_SHADOW_VEND |
 					 FP_CRT_SYNC_ALT));
 
-		newmode.fp_gen_cntl |= (FP_CRTC_DONT_SHADOW_VPAR |
-					FP_CRTC_DONT_SHADOW_HEND);
-
-		newmode.lvds_gen_cntl = rinfo->init_state.lvds_gen_cntl;
-		newmode.lvds_pll_cntl = rinfo->init_state.lvds_pll_cntl;
-		newmode.tmds_crc = rinfo->init_state.tmds_crc;
-		newmode.tmds_transmitter_cntl = rinfo->init_state.tmds_transmitter_cntl;
+		newmode->fp_gen_cntl |= (FP_CRTC_DONT_SHADOW_VPAR |
+					FP_CRTC_DONT_SHADOW_HEND |
+					FP_PANEL_FORMAT);
+
+		if (IS_R300_VARIANT(rinfo) ||
+		    (rinfo->family == CHIP_FAMILY_R200)) {
+			newmode->fp_gen_cntl &= ~R200_FP_SOURCE_SEL_MASK;
+			if (use_rmx)
+				newmode->fp_gen_cntl |= R200_FP_SOURCE_SEL_RMX;
+			else
+				newmode->fp_gen_cntl |= R200_FP_SOURCE_SEL_CRTC1;
+		} else 
+			newmode->fp_gen_cntl |= FP_SEL_CRTC1;
+
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
-			if ((rinfo->family == CHIP_FAMILY_R300) ||
-			    (rinfo->family == CHIP_FAMILY_R350) ||
-			    (rinfo->family == CHIP_FAMILY_RV350) ||
+			if (IS_R300_VARIANT(rinfo) ||
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
-		radeon_write_mode (rinfo, &newmode);
+		memcpy(&rinfo->state, newmode, sizeof(*newmode));
+		radeon_write_mode (rinfo, newmode, 0);
 		/* (re)initialize the engine */
 		if (!(info->flags & FBINFO_HWACCEL_DISABLED))
 			radeonfb_engine_init (rinfo);
@@ -1702,6 +1781,7 @@
 			     rinfo->depth, info->fix.line_length);
 #endif
 
+	kfree(newmode);
 	return 0;
 }
 
@@ -1811,12 +1891,14 @@
 	if (on && (level > BACKLIGHT_OFF)) {
 		lvds_gen_cntl &= ~LVDS_DISPLAY_DIS;
 		if (!(lvds_gen_cntl & LVDS_BLON) || !(lvds_gen_cntl & LVDS_ON)) {
-			lvds_gen_cntl |= LVDS_BLON /* | LVDS_EN | LVDS_DIGON */;
+			lvds_gen_cntl |= (rinfo->init_state.lvds_gen_cntl & LVDS_DIGON);
+			lvds_gen_cntl |= LVDS_BLON | LVDS_EN;
 			OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
 			lvds_gen_cntl &= ~LVDS_BL_MOD_LEVEL_MASK;
 			lvds_gen_cntl |= (conv_table[level] <<
 					  LVDS_BL_MOD_LEVEL_SHIFT);
 			lvds_gen_cntl |= LVDS_ON;
+			lvds_gen_cntl |= (rinfo->init_state.lvds_gen_cntl & LVDS_BL_MOD_EN);
 			rinfo->pending_lvds_gen_cntl = lvds_gen_cntl;
 			mod_timer(&rinfo->lvds_timer,
 				  jiffies + msecs_to_jiffies(rinfo->panel_info.pwr_delay));
@@ -1836,13 +1918,18 @@
 		tmpPixclksCntl = INPLL(PIXCLKS_CNTL);
 		if (rinfo->is_mobility || rinfo->is_IGP)
 			OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
-		lvds_gen_cntl &= ~LVDS_BL_MOD_LEVEL_MASK;
+		lvds_gen_cntl &= ~(LVDS_BL_MOD_LEVEL_MASK | LVDS_BL_MOD_EN);
 		lvds_gen_cntl |= (conv_table[0] <<
 				  LVDS_BL_MOD_LEVEL_SHIFT);
 		lvds_gen_cntl |= LVDS_DISPLAY_DIS;
 		OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
-		lvds_gen_cntl &= ~(LVDS_ON | LVDS_BLON /* | LVDS_EN | LVDS_DIGON */);
+		udelay(100);
+		lvds_gen_cntl &= ~(LVDS_ON | LVDS_EN);
 		OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
+		lvds_gen_cntl &= ~(LVDS_DIGON);
+		rinfo->pending_lvds_gen_cntl = lvds_gen_cntl;
+		mod_timer(&rinfo->lvds_timer,
+			  jiffies + msecs_to_jiffies(rinfo->panel_info.pwr_delay));
 		if (rinfo->is_mobility || rinfo->is_IGP)
 			OUTPLL(PIXCLKS_CNTL, tmpPixclksCntl);
 	}
@@ -1872,7 +1959,7 @@
  * local (0xe0000000 for now) that will be changed by XFree/DRI anyway
  */
 #ifdef CONFIG_PPC_OF
-#undef SET_MC_FB_FROM_APERTURE
+#define SET_MC_FB_FROM_APERTURE
 static void fixup_memory_mappings(struct radeonfb_info *rinfo)
 {
 	u32 save_crtc_gen_cntl, save_crtc2_gen_cntl = 0;
@@ -1925,10 +2012,12 @@
 	OUTREG(DISPLAY_BASE_ADDR, aper_base);
 	if (rinfo->has_CRTC2)
 		OUTREG(CRTC2_DISPLAY_BASE_ADDR, aper_base);
+	OUTREG(OV0_BASE_ADDR, aper_base);
 #else
 	OUTREG(DISPLAY_BASE_ADDR, 0);
 	if (rinfo->has_CRTC2)
 		OUTREG(CRTC2_DISPLAY_BASE_ADDR, 0);
+	OUTREG(OV0_BASE_ADDR, 0);
 #endif
 	mdelay(100);
 
@@ -1946,6 +2035,100 @@
 #endif /* CONFIG_PPC_OF */
 
 
+static void radeon_identify_vram(struct radeonfb_info *rinfo)
+{
+	u32 tmp;
+
+	/* framebuffer size */
+        if ((rinfo->family == CHIP_FAMILY_RS100) ||
+            (rinfo->family == CHIP_FAMILY_RS200) ||
+            (rinfo->family == CHIP_FAMILY_RS300)) {
+          u32 tom = INREG(NB_TOM);
+          tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
+ 
+ 		radeon_fifo_wait(6);
+          OUTREG(MC_FB_LOCATION, tom);
+          OUTREG(DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
+          OUTREG(CRTC2_DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
+          OUTREG(OV0_BASE_ADDR, (tom & 0xffff) << 16);
+ 
+          /* This is supposed to fix the crtc2 noise problem. */
+          OUTREG(GRPH2_BUFFER_CNTL, INREG(GRPH2_BUFFER_CNTL) & ~0x7f0000);
+ 
+          if ((rinfo->family == CHIP_FAMILY_RS100) ||
+              (rinfo->family == CHIP_FAMILY_RS200)) {
+             /* This is to workaround the asic bug for RMX, some versions
+                of BIOS dosen't have this register initialized correctly.
+             */
+             OUTREGP(CRTC_MORE_CNTL, CRTC_H_CUTOFF_ACTIVE_EN,
+                     ~CRTC_H_CUTOFF_ACTIVE_EN);
+          }
+        } else {
+          tmp = INREG(CONFIG_MEMSIZE);
+        }
+
+	/* mem size is bits [28:0], mask off the rest */
+	rinfo->video_ram = tmp & CONFIG_MEMSIZE_MASK;
+
+	/*
+	 * Hack to get around some busted production M6's
+	 * reporting no ram
+	 */
+	if (rinfo->video_ram == 0) {
+		switch (rinfo->pdev->device) {
+	       	case PCI_CHIP_RADEON_LY:
+		case PCI_CHIP_RADEON_LZ:
+	       		rinfo->video_ram = 8192 * 1024;
+	       		break;
+	       	default:
+	       		break;
+		}
+	}
+
+
+	/*
+	 * Now try to identify VRAM type
+	 */
+	if (rinfo->is_IGP || (rinfo->family >= CHIP_FAMILY_R300) ||
+	    (INREG(MEM_SDRAM_MODE_REG) & (1<<30)))
+		rinfo->vram_ddr = 1;
+	else
+		rinfo->vram_ddr = 0;
+
+	tmp = INREG(MEM_CNTL);
+	if (IS_R300_VARIANT(rinfo)) {
+		tmp &=  R300_MEM_NUM_CHANNELS_MASK;
+		switch (tmp) {
+		case 0:  rinfo->vram_width = 64; break;
+		case 1:  rinfo->vram_width = 128; break;
+		case 2:  rinfo->vram_width = 256; break;
+		default: rinfo->vram_width = 128; break;
+		}
+	} else if ((rinfo->family == CHIP_FAMILY_RV100) ||
+		   (rinfo->family == CHIP_FAMILY_RS100) ||
+		   (rinfo->family == CHIP_FAMILY_RS200)){
+		if (tmp & RV100_MEM_HALF_MODE)
+			rinfo->vram_width = 32;
+		else
+			rinfo->vram_width = 64;
+	} else {
+		if (tmp & MEM_NUM_CHANNELS_MASK)
+			rinfo->vram_width = 128;
+		else
+			rinfo->vram_width = 64;
+	}
+
+	/* This may not be correct, as some cards can have half of channel disabled 
+	 * ToDo: identify these cases
+	 */
+
+	RTRACE("radeonfb (%s): Found %ldk of %s %d bits wide videoram\n",
+	       pci_name(rinfo->pdev),
+	       rinfo->video_ram / 1024,
+	       rinfo->vram_ddr ? "DDR" : "SDRAM",
+	       rinfo->vram_width);
+}
+
 /*
  * Sysfs
  */
@@ -2011,7 +2194,6 @@
 {
 	struct fb_info *info;
 	struct radeonfb_info *rinfo;
-	u32 tmp;
 	int ret;
 
 	RTRACE("radeonfb_pci_register BEGIN\n");
@@ -2019,13 +2201,15 @@
 	/* Enable device in PCI config */
 	ret = pci_enable_device(pdev);
 	if (ret < 0) {
-		printk(KERN_ERR "radeonfb: Cannot enable PCI device\n");
+		printk(KERN_ERR "radeonfb (%s): Cannot enable PCI device\n",
+		       pci_name(pdev));
 		goto err_out;
 	}
 
 	info = framebuffer_alloc(sizeof(struct radeonfb_info), &pdev->dev);
 	if (!info) {
-		printk (KERN_ERR "radeonfb: could not allocate memory\n");
+		printk (KERN_ERR "radeonfb (%s): could not allocate memory\n",
+			pci_name(pdev));
 		ret = -ENOMEM;
 		goto err_disable;
 	}
@@ -2054,121 +2238,39 @@
 	/* request the mem regions */
 	ret = pci_request_regions(pdev, "radeonfb");
 	if (ret < 0) {
-		printk( KERN_ERR "radeonfb: cannot reserve PCI regions."
-			"  Someone already got them?\n");
+		printk( KERN_ERR "radeonfb (%s): cannot reserve PCI regions."
+			"  Someone already got them?\n", pci_name(rinfo->pdev));
 		goto err_release_fb;
 	}
 
 	/* map the regions */
 	rinfo->mmio_base = ioremap(rinfo->mmio_base_phys, RADEON_REGSIZE);
 	if (!rinfo->mmio_base) {
-		printk(KERN_ERR "radeonfb: cannot map MMIO\n");
+		printk(KERN_ERR "radeonfb (%s): cannot map MMIO\n", pci_name(rinfo->pdev));
 		ret = -EIO;
 		goto err_release_pci;
 	}
 
+	rinfo->fb_local_base = INREG(MC_FB_LOCATION) << 16;
+
+#ifdef CONFIG_PPC_OF
+	/* On PPC, we obtain the OF device-node pointer to the firmware
+	 * data for this chip
+	 */
+	rinfo->of_node = pci_device_to_OF_node(pdev);
+	if (rinfo->of_node == NULL)
+		printk(KERN_WARNING "radeonfb (%s): Cannot match card to OF node !\n",
+		       pci_name(rinfo->pdev));
+
 	/* On PPC, the firmware sets up a memory mapping that tends
 	 * to cause lockups when enabling the engine. We reconfigure
 	 * the card internal memory mappings properly
 	 */
-#ifdef CONFIG_PPC_OF
 	fixup_memory_mappings(rinfo);
-#else	
-	rinfo->fb_local_base = INREG(MC_FB_LOCATION) << 16;
 #endif /* CONFIG_PPC_OF */
 
-	/* framebuffer size */
-        if ((rinfo->family == CHIP_FAMILY_RS100) ||
-            (rinfo->family == CHIP_FAMILY_RS200) ||
-            (rinfo->family == CHIP_FAMILY_RS300)) {
-          u32 tom = INREG(NB_TOM);
-          tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
- 
- 		radeon_fifo_wait(6);
-          OUTREG(MC_FB_LOCATION, tom);
-          OUTREG(DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
-          OUTREG(CRTC2_DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
-          OUTREG(OV0_BASE_ADDR, (tom & 0xffff) << 16);
- 
-          /* This is supposed to fix the crtc2 noise problem. */
-          OUTREG(GRPH2_BUFFER_CNTL, INREG(GRPH2_BUFFER_CNTL) & ~0x7f0000);
- 
-          if ((rinfo->family == CHIP_FAMILY_RS100) ||
-              (rinfo->family == CHIP_FAMILY_RS200)) {
-             /* This is to workaround the asic bug for RMX, some versions
-                of BIOS dosen't have this register initialized correctly.
-             */
-             OUTREGP(CRTC_MORE_CNTL, CRTC_H_CUTOFF_ACTIVE_EN,
-                     ~CRTC_H_CUTOFF_ACTIVE_EN);
-          }
-        } else {
-          tmp = INREG(CONFIG_MEMSIZE);
-        }
-
-	/* mem size is bits [28:0], mask off the rest */
-	rinfo->video_ram = tmp & CONFIG_MEMSIZE_MASK;
-
-	/* ram type */
-	tmp = INREG(MEM_SDRAM_MODE_REG);
-	switch ((MEM_CFG_TYPE & tmp) >> 30) {
-       	case 0:
-       		/* SDR SGRAM (2:1) */
-       		strcpy(rinfo->ram_type, "SDR SGRAM");
-       		rinfo->ram.ml = 4;
-       		rinfo->ram.mb = 4;
-       		rinfo->ram.trcd = 1;
-       		rinfo->ram.trp = 2;
-       		rinfo->ram.twr = 1;
-       		rinfo->ram.cl = 2;
-       		rinfo->ram.loop_latency = 16;
-       		rinfo->ram.rloop = 16;
-       		break;
-       	case 1:
-       		/* DDR SGRAM */
-       		strcpy(rinfo->ram_type, "DDR SGRAM");
-       		rinfo->ram.ml = 4;
-       		rinfo->ram.mb = 4;
-       		rinfo->ram.trcd = 3;
-       		rinfo->ram.trp = 3;
-       		rinfo->ram.twr = 2;
-       		rinfo->ram.cl = 3;
-       		rinfo->ram.tr2w = 1;
-       		rinfo->ram.loop_latency = 16;
-       		rinfo->ram.rloop = 16;
-		break;
-       	default:
-       		/* 64-bit SDR SGRAM */
-       		strcpy(rinfo->ram_type, "SDR SGRAM 64");
-       		rinfo->ram.ml = 4;
-       		rinfo->ram.mb = 8;
-       		rinfo->ram.trcd = 3;
-       		rinfo->ram.trp = 3;
-       		rinfo->ram.twr = 1;
-       		rinfo->ram.cl = 3;
-       		rinfo->ram.tr2w = 1;
-       		rinfo->ram.loop_latency = 17;
-       		rinfo->ram.rloop = 17;
-		break;
-	}
-
-	/*
-	 * Hack to get around some busted production M6's
-	 * reporting no ram
-	 */
-	if (rinfo->video_ram == 0) {
-		switch (pdev->device) {
-	       	case PCI_CHIP_RADEON_LY:
-		case PCI_CHIP_RADEON_LZ:
-	       		rinfo->video_ram = 8192 * 1024;
-	       		break;
-	       	default:
-			printk (KERN_ERR "radeonfb: no video RAM reported\n");
-			ret = -ENXIO;
-			goto err_unmap_rom;
-		}
-	}
-
-	RTRACE("radeonfb: probed %s %ldk videoram\n", (rinfo->ram_type), (rinfo->video_ram/1024));
+	/* Get VRAM size and type */
+	radeon_identify_vram(rinfo);
 
 	rinfo->mapped_vram = min_t(unsigned long, MAX_MAPPED_VRAM, rinfo->video_ram);
 
@@ -2181,12 +2283,13 @@
 	if (rinfo->fb_base)
 		memset_io(rinfo->fb_base, 0, rinfo->mapped_vram);
 	else {
-		printk (KERN_ERR "radeonfb: cannot map FB\n");
+		printk (KERN_ERR "radeonfb (%s): cannot map FB\n", pci_name(rinfo->pdev));
 		ret = -EIO;
 		goto err_unmap_rom;
 	}
 
-	RTRACE("radeonfb: mapped %ldk videoram\n", rinfo->mapped_vram/1024);
+	RTRACE("radeonfb (%s): mapped %ldk videoram\n", pci_name(rinfo->pdev),
+	       rinfo->mapped_vram/1024);
 
 	/*
 	 * Check for required workaround for PLL accesses
@@ -2253,21 +2356,22 @@
 	 * so we can restore this upon __exit
 	 */
 	radeon_save_state (rinfo, &rinfo->init_state);
+	memcpy(&rinfo->state, &rinfo->init_state, sizeof(struct radeon_regs));
 
 	pci_set_drvdata(pdev, info);
 
-	/* Enable PM on mobility chips */
-	if (rinfo->is_mobility) {
-		/* Find PM registers in config space */
-		rinfo->pm_reg = pci_find_capability(pdev, PCI_CAP_ID_PM);
-		/* Enable dynamic PM of chip clocks */
-		radeon_pm_enable_dynamic_mode(rinfo);
-		printk("radeonfb: Power Management enabled for Mobility chipsets\n");
-	}
+	/* Setup Power Management capabilities */
+	if (default_dynclk < -1) {
+		/* -2 is special: means  ON on mobility chips and do not change on others */
+		radeonfb_pm_init(rinfo, rinfo->is_mobility ? 1 : -1);
+	} else
+		radeonfb_pm_init(rinfo, default_dynclk);
 
+	/* Register with fbdev layer */
 	ret = register_framebuffer(info);
 	if (ret < 0) {
-		printk (KERN_ERR "radeonfb: could not register framebuffer\n");
+		printk (KERN_ERR "radeonfb (%s): could not register framebuffer\n",
+			pci_name(rinfo->pdev));
 		goto err_unmap_fb;
 	}
 
@@ -2286,8 +2390,7 @@
 	}
 #endif
 
-	printk ("radeonfb: %s %s %ld MB\n", rinfo->name, rinfo->ram_type,
-		(rinfo->video_ram/(1024*1024)));
+	printk ("radeonfb (%s): %s\n", pci_name(rinfo->pdev), rinfo->name);
 
 	if (rinfo->bios_seg)
 		radeon_unmap_ROM(rinfo, pdev);
@@ -2330,12 +2433,14 @@
         if (!rinfo)
                 return;
  
+	radeonfb_pm_exit(rinfo);
+
 	/* restore original state
 	 * 
 	 * Doesn't quite work yet, possibly because of the PPC hacking
 	 * I do on startup, disable for now. --BenH
 	 */
-        radeon_write_mode (rinfo, &rinfo->init_state);
+        radeon_write_mode (rinfo, &rinfo->init_state, 1);
  
 	del_timer_sync(&rinfo->lvds_timer);
 
@@ -2442,6 +2547,8 @@
 MODULE_DESCRIPTION("framebuffer driver for ATI Radeon chipset");
 MODULE_LICENSE("GPL");
 module_param(noaccel, bool, 0);
+module_param(default_dynclk, int, -2);
+MODULE_PARM_DESC(default_dynclk, "int: -2=enable on mobility only,-1=do not change,0=off,1=on");
 MODULE_PARM_DESC(noaccel, "bool: disable acceleration");
 module_param(nomodeset, bool, 0);
 MODULE_PARM_DESC(nomodeset, "bool: disable actual setting of video mode");
Index: linux-work/drivers/video/aty/radeon_pm.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_pm.c	2004-11-22 11:50:27.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_pm.c	2005-01-17 13:49:30.069580896 +1100
@@ -1,207 +1,449 @@
+/*
+ *	drivers/video/aty/radeon_pm.c
+ *
+ *	Copyright 2003,2004 Ben. Herrenschmidt <benh@kernel.crashing.org>
+ *	Copyright 2004 Paul Mackerras <paulus@samba.org>
+ *
+ *	This is the power management code for ATI radeon chipsets. It contains
+ *	some dynamic clock PM enable/disable code similar to what X.org does,
+ *	some D2-state (APM-style) sleep/wakeup code for use on some PowerMacs,
+ *	and the necessary bits to re-initialize from scratch a few chips found
+ *	on PowerMacs as well. The later could be extended to more platforms
+ *	provided the memory controller configuration code be made more generic,
+ *	and you can get the proper mode register commands for your RAMs.
+ *	Those things may be found in the BIOS image...
+ */
+
 #include "radeonfb.h"
 
 #include <linux/console.h>
 #include <linux/agp_backend.h>
 
-/*
- * Currently, only PowerMac do D2 state
- */
-#define CONFIG_RADEON_HAS_D2	CONFIG_PPC_PMAC
-
-#ifdef CONFIG_RADEON_HAS_D2
-/*
- * On PowerMac, we assume any mobility chip based machine does D2
- */
 #ifdef CONFIG_PPC_PMAC
-static inline int radeon_suspend_to_d2(struct radeonfb_info *rinfo, u32 state)
-{
-	return rinfo->is_mobility;
-}
-#else
-static inline int radeon_suspend_to_d2(struct radeonfb_info *rinfo, u32 state)
-{
-	return 0;
-}
+#include <asm/processor.h>
+#include <asm/prom.h>
+#include <asm/pmac_feature.h>
 #endif
 
-#endif /* CONFIG_RADEON_HAS_D2 */
-
-/*
- * Radeon M6, M7 and M9 Power Management code. This code currently
- * only supports the mobile chips in D2 mode, that is typically what
- * is used on Apple laptops, it's based from some informations provided
- * by ATI along with hours of tracing of MacOS drivers.
- * 
- * New version of this code almost totally rewritten by ATI, many thanks
- * for their support.
- */
+#include "ati_ids.h"
 
 void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
 {
+	u32 tmp;
 
-	u32 sclk_cntl;
-	u32 mclk_cntl;
-	u32 sclk_more_cntl;
-	
-	u32 vclk_ecp_cntl;
-	u32 pixclks_cntl;
-
-	/* Mobility chips only, untested on M9+/M10/11 */
-	if (!rinfo->is_mobility)
+	/* RV100 */
+	if ((rinfo->family == CHIP_FAMILY_RV100) && (!rinfo->is_mobility)) {
+		if (rinfo->has_CRTC2) {
+			tmp = INPLL(pllSCLK_CNTL);
+			tmp &= ~SCLK_CNTL__DYN_STOP_LAT_MASK;
+			tmp |= SCLK_CNTL__CP_MAX_DYN_STOP_LAT | SCLK_CNTL__FORCEON_MASK;
+			OUTPLL(pllSCLK_CNTL, tmp);
+		}
+		tmp = INPLL(pllMCLK_CNTL);
+		tmp |= (MCLK_CNTL__FORCE_MCLKA |
+		        MCLK_CNTL__FORCE_MCLKB |
+		        MCLK_CNTL__FORCE_YCLKA |
+		        MCLK_CNTL__FORCE_YCLKB |
+			MCLK_CNTL__FORCE_AIC |
+			MCLK_CNTL__FORCE_MC);
+                OUTPLL(pllMCLK_CNTL, tmp);
+		return;
+	}					 
+	/* R100 */
+	if (!rinfo->has_CRTC2) {
+                tmp = INPLL(pllSCLK_CNTL);
+                tmp |= (SCLK_CNTL__FORCE_CP	| SCLK_CNTL__FORCE_HDP	|
+			SCLK_CNTL__FORCE_DISP1	| SCLK_CNTL__FORCE_TOP	|
+                        SCLK_CNTL__FORCE_E2	| SCLK_CNTL__FORCE_SE 	|
+			SCLK_CNTL__FORCE_IDCT	| SCLK_CNTL__FORCE_VIP	|
+			SCLK_CNTL__FORCE_RE	| SCLK_CNTL__FORCE_PB 	|
+			SCLK_CNTL__FORCE_TAM	| SCLK_CNTL__FORCE_TDM	|
+                        SCLK_CNTL__FORCE_RB);
+                OUTPLL(pllSCLK_CNTL, tmp);
 		return;
-	if (rinfo->family > CHIP_FAMILY_RV250)
+	}
+	/* RV350 (M10) */
+	if (rinfo->family == CHIP_FAMILY_RV350) {
+                /* for RV350/M10, no delays are required. */
+                tmp = INPLL(pllSCLK_CNTL2);
+                tmp |= (SCLK_CNTL2__R300_FORCE_TCL |
+                        SCLK_CNTL2__R300_FORCE_GA  |
+			SCLK_CNTL2__R300_FORCE_CBA);
+                OUTPLL(pllSCLK_CNTL2, tmp);
+
+                tmp = INPLL(pllSCLK_CNTL);
+                tmp |= (SCLK_CNTL__FORCE_DISP2		| SCLK_CNTL__FORCE_CP		|
+                        SCLK_CNTL__FORCE_HDP		| SCLK_CNTL__FORCE_DISP1	|
+                        SCLK_CNTL__FORCE_TOP		| SCLK_CNTL__FORCE_E2		|
+                        SCLK_CNTL__R300_FORCE_VAP	| SCLK_CNTL__FORCE_IDCT    	|
+			SCLK_CNTL__FORCE_VIP		| SCLK_CNTL__R300_FORCE_SR	|
+			SCLK_CNTL__R300_FORCE_PX	| SCLK_CNTL__R300_FORCE_TX	|
+			SCLK_CNTL__R300_FORCE_US	| SCLK_CNTL__FORCE_TV_SCLK	|
+                        SCLK_CNTL__R300_FORCE_SU	| SCLK_CNTL__FORCE_OV0);
+                OUTPLL(pllSCLK_CNTL, tmp);
+
+                tmp = INPLL(pllSCLK_MORE_CNTL);
+		tmp |= (SCLK_MORE_CNTL__FORCE_DISPREGS	| SCLK_MORE_CNTL__FORCE_MC_GUI	|
+			SCLK_MORE_CNTL__FORCE_MC_HOST);
+                OUTPLL(pllSCLK_MORE_CNTL, tmp);
+		
+		tmp = INPLL(pllMCLK_CNTL);
+		tmp |= (MCLK_CNTL__FORCE_MCLKA |
+		        MCLK_CNTL__FORCE_MCLKB |
+		        MCLK_CNTL__FORCE_YCLKA |
+		        MCLK_CNTL__FORCE_YCLKB |
+			MCLK_CNTL__FORCE_MC);
+                OUTPLL(pllMCLK_CNTL, tmp);
+
+                tmp = INPLL(pllVCLK_ECP_CNTL);
+                tmp &= ~(VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb  | 
+                         VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb | 
+			 VCLK_ECP_CNTL__R300_DISP_DAC_PIXCLK_DAC_BLANK_OFF);
+                OUTPLL(pllVCLK_ECP_CNTL, tmp);
+
+                tmp = INPLL(pllPIXCLKS_CNTL);
+                tmp &= ~(PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__DISP_TVOUT_PIXCLK_TV_ALWAYS_ONb	| 
+			 PIXCLKS_CNTL__R300_DVOCLK_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__R300_PIXCLK_DVO_ALWAYS_ONb	| 
+			 PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb	| 
+			 PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb	| 
+			 PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb		| 
+			 PIXCLKS_CNTL__R300_DISP_DAC_PIXCLK_DAC2_BLANK_OFF); 
+                OUTPLL(pllPIXCLKS_CNTL, tmp);
+
 		return;
+	}
 	
+	/* Default */
+
 	/* Force Core Clocks */
-	sclk_cntl = INPLL( pllSCLK_CNTL_M6);
-	sclk_cntl |= 	SCLK_CNTL_M6__FORCE_CP|
-			SCLK_CNTL_M6__FORCE_HDP|
-			SCLK_CNTL_M6__FORCE_DISP1|
-			SCLK_CNTL_M6__FORCE_DISP2|
-			SCLK_CNTL_M6__FORCE_TOP|
-			SCLK_CNTL_M6__FORCE_E2|
-			SCLK_CNTL_M6__FORCE_SE|
-			SCLK_CNTL_M6__FORCE_IDCT|
-			SCLK_CNTL_M6__FORCE_VIP|
-			SCLK_CNTL_M6__FORCE_RE|
-			SCLK_CNTL_M6__FORCE_PB|
-			SCLK_CNTL_M6__FORCE_TAM|
-			SCLK_CNTL_M6__FORCE_TDM|
-			SCLK_CNTL_M6__FORCE_RB|
-			SCLK_CNTL_M6__FORCE_TV_SCLK|
-			SCLK_CNTL_M6__FORCE_SUBPIC|
-			SCLK_CNTL_M6__FORCE_OV0;
-    	OUTPLL( pllSCLK_CNTL_M6, sclk_cntl);
-	
-	
-	
-	sclk_more_cntl = INPLL(pllSCLK_MORE_CNTL);
-	sclk_more_cntl |= 	SCLK_MORE_CNTL__FORCE_DISPREGS|
-				SCLK_MORE_CNTL__FORCE_MC_GUI|
-				SCLK_MORE_CNTL__FORCE_MC_HOST;	
-	OUTPLL(pllSCLK_MORE_CNTL, sclk_more_cntl);
-	
-	/* Force Display clocks	*/
-	vclk_ecp_cntl = INPLL( pllVCLK_ECP_CNTL);
-	vclk_ecp_cntl &= ~(	VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb |
-			 	VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb);
+	tmp = INPLL(pllSCLK_CNTL);
+	tmp |= (SCLK_CNTL__FORCE_CP | SCLK_CNTL__FORCE_E2);
 
-	OUTPLL( pllVCLK_ECP_CNTL, vclk_ecp_cntl);
-	
-	pixclks_cntl = INPLL( pllPIXCLKS_CNTL);
-	pixclks_cntl &= ~(	PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb |
-			 	PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb|
-				PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb |
-				PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb|
-				PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb|
-				PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb|
-				PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb);
-						
- 	OUTPLL( pllPIXCLKS_CNTL, pixclks_cntl);
+	/* XFree doesn't do that case, but we had this code from Apple and it
+	 * seem necessary for proper suspend/resume operations
+	 */
+	if (rinfo->is_mobility) {
+		tmp |= 	SCLK_CNTL__FORCE_HDP|
+			SCLK_CNTL__FORCE_DISP1|
+			SCLK_CNTL__FORCE_DISP2|
+			SCLK_CNTL__FORCE_TOP|
+			SCLK_CNTL__FORCE_SE|
+			SCLK_CNTL__FORCE_IDCT|
+			SCLK_CNTL__FORCE_VIP|
+			SCLK_CNTL__FORCE_PB|
+			SCLK_CNTL__FORCE_RE|
+			SCLK_CNTL__FORCE_TAM|
+			SCLK_CNTL__FORCE_TDM|
+			SCLK_CNTL__FORCE_RB|
+			SCLK_CNTL__FORCE_TV_SCLK|
+			SCLK_CNTL__FORCE_SUBPIC|
+			SCLK_CNTL__FORCE_OV0;
+	}
+	else if (rinfo->family == CHIP_FAMILY_R300 ||
+		   rinfo->family == CHIP_FAMILY_R350) {
+		tmp |=  SCLK_CNTL__FORCE_HDP   |
+			SCLK_CNTL__FORCE_DISP1 |
+			SCLK_CNTL__FORCE_DISP2 |
+			SCLK_CNTL__FORCE_TOP   |
+			SCLK_CNTL__FORCE_IDCT  |
+			SCLK_CNTL__FORCE_VIP;
+	}
+    	OUTPLL(pllSCLK_CNTL, tmp);
+	radeon_msleep(16);
+
+	if (rinfo->family == CHIP_FAMILY_R300 || rinfo->family == CHIP_FAMILY_R350) {
+		tmp = INPLL(pllSCLK_CNTL2);
+		tmp |=  SCLK_CNTL2__R300_FORCE_TCL |
+			SCLK_CNTL2__R300_FORCE_GA  |
+			SCLK_CNTL2__R300_FORCE_CBA;
+		OUTPLL(pllSCLK_CNTL2, tmp);
+		radeon_msleep(16);
+	}
+
+	tmp = INPLL(pllCLK_PIN_CNTL);
+	tmp &= ~CLK_PIN_CNTL__SCLK_DYN_START_CNTL;
+	OUTPLL(pllCLK_PIN_CNTL, tmp);
+	radeon_msleep(15);
+
+	if (rinfo->is_IGP) {
+		/* Weird  ... X is _un_ forcing clocks here, I think it's
+		 * doing backward. Imitate it for now...
+		 */
+		tmp = INPLL(pllMCLK_CNTL);
+		tmp &= ~(MCLK_CNTL__FORCE_MCLKA |
+			 MCLK_CNTL__FORCE_YCLKA);
+		OUTREG(pllMCLK_CNTL, tmp);
+		radeon_msleep(16);
+	}
+	/* Hrm... same shit, X doesn't do that but I have to */
+	else if (rinfo->is_mobility) {
+		tmp = INPLL(pllMCLK_CNTL);
+		tmp |= (MCLK_CNTL__FORCE_MCLKA |  
+			MCLK_CNTL__FORCE_MCLKB |
+			MCLK_CNTL__FORCE_YCLKA |
+			MCLK_CNTL__FORCE_YCLKB);
+		OUTPLL(pllMCLK_CNTL, tmp);
+		radeon_msleep(16);
+
+		tmp = INPLL(pllMCLK_MISC);
+		tmp &= 	~(MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT|
+			  MCLK_MISC__IO_MCLK_MAX_DYN_STOP_LAT|
+			  MCLK_MISC__MC_MCLK_DYN_ENABLE|
+			  MCLK_MISC__IO_MCLK_DYN_ENABLE);
+		OUTPLL(pllMCLK_MISC, tmp);
+		radeon_msleep(15);
+	}
 
-	/* Force Memory Clocks */
-	mclk_cntl = INPLL( pllMCLK_CNTL_M6);
-	mclk_cntl &= ~(	MCLK_CNTL_M6__FORCE_MCLKA |  
-			MCLK_CNTL_M6__FORCE_MCLKB |
-			MCLK_CNTL_M6__FORCE_YCLKA |
-			MCLK_CNTL_M6__FORCE_YCLKB );
-    	OUTPLL( pllMCLK_CNTL_M6, mclk_cntl);
+	if (rinfo->is_mobility) {
+		tmp = INPLL(pllSCLK_MORE_CNTL);
+		tmp |= 	SCLK_MORE_CNTL__FORCE_DISPREGS|
+			SCLK_MORE_CNTL__FORCE_MC_GUI|
+			SCLK_MORE_CNTL__FORCE_MC_HOST;	
+		OUTPLL(pllSCLK_MORE_CNTL, tmp);
+		radeon_msleep(16);
+	}
+	
+	tmp = INPLL(pllPIXCLKS_CNTL);
+	tmp &= ~(PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb |
+		 PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb|
+		 PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb |
+		 PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb|
+		 PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb|
+		 PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb|
+		 PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb);
+ 	OUTPLL(pllPIXCLKS_CNTL, tmp);
+	radeon_msleep(16);
+
+	tmp = INPLL( pllVCLK_ECP_CNTL);
+	tmp &= ~(VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb |
+		 VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb);
+	OUTPLL( pllVCLK_ECP_CNTL, tmp);
+	radeon_msleep(16);
 }
 
 void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
 {
-	u32 clk_pwrmgt_cntl;
-	u32 sclk_cntl;
-	u32 sclk_more_cntl;
-	u32 clk_pin_cntl;
-	u32 pixclks_cntl;
-	u32 vclk_ecp_cntl;
-	u32 mclk_cntl;
-	u32 mclk_misc;
+	u32 tmp;
 
-	/* Mobility chips only, untested on M9+/M10/11 */
-	if (!rinfo->is_mobility)
+	/* R100 */
+	if (!rinfo->has_CRTC2) {
+                tmp = INPLL(pllSCLK_CNTL);
+
+		if ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) > CFG_ATI_REV_A13)
+                    tmp &= ~(SCLK_CNTL__FORCE_CP	| SCLK_CNTL__FORCE_RB);
+                tmp &= ~(SCLK_CNTL__FORCE_HDP		| SCLK_CNTL__FORCE_DISP1 |
+			 SCLK_CNTL__FORCE_TOP		| SCLK_CNTL__FORCE_SE   |
+			 SCLK_CNTL__FORCE_IDCT		| SCLK_CNTL__FORCE_RE   |
+			 SCLK_CNTL__FORCE_PB		| SCLK_CNTL__FORCE_TAM  |
+			 SCLK_CNTL__FORCE_TDM);
+                OUTPLL(pllSCLK_CNTL, tmp);
 		return;
-	if (rinfo->family > CHIP_FAMILY_RV250)
-		return;
-	
-	/* Set Latencies */
-	clk_pwrmgt_cntl = INPLL( pllCLK_PWRMGT_CNTL_M6);
-	
-	clk_pwrmgt_cntl &= ~(	 CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE_MASK|
-				 CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT_MASK|
-				 CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT_MASK|
-				 CLK_PWRMGT_CNTL_M6__DYN_STOP_MODE_MASK);
-	/* Mode 1 */
-	clk_pwrmgt_cntl = 	CLK_PWRMGT_CNTL_M6__MC_CH_MODE|
-				CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE | 
-				(1<<CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT__SHIFT) |
-				(0<<CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT__SHIFT)|
-				(0<<CLK_PWRMGT_CNTL_M6__DYN_STOP_MODE__SHIFT);
-
-	OUTPLL( pllCLK_PWRMGT_CNTL_M6, clk_pwrmgt_cntl);
-						
+	}
 
-	clk_pin_cntl = INPLL( pllCLK_PIN_CNTL);
-	clk_pin_cntl |= CLK_PIN_CNTL__SCLK_DYN_START_CNTL;
-	 
-	OUTPLL( pllCLK_PIN_CNTL, clk_pin_cntl);
+	/* M10 */
+	if (rinfo->family == CHIP_FAMILY_RV350) {
+		tmp = INPLL(pllSCLK_CNTL2);
+		tmp &= ~(SCLK_CNTL2__R300_FORCE_TCL |
+			 SCLK_CNTL2__R300_FORCE_GA  |
+			 SCLK_CNTL2__R300_FORCE_CBA);
+		tmp |=  (SCLK_CNTL2__R300_TCL_MAX_DYN_STOP_LAT |
+			 SCLK_CNTL2__R300_GA_MAX_DYN_STOP_LAT  |
+			 SCLK_CNTL2__R300_CBA_MAX_DYN_STOP_LAT);
+		OUTPLL(pllSCLK_CNTL2, tmp);
+
+		tmp = INPLL(pllSCLK_CNTL);
+		tmp &= ~(SCLK_CNTL__FORCE_DISP2 | SCLK_CNTL__FORCE_CP      |
+			 SCLK_CNTL__FORCE_HDP   | SCLK_CNTL__FORCE_DISP1   |
+			 SCLK_CNTL__FORCE_TOP   | SCLK_CNTL__FORCE_E2      |
+			 SCLK_CNTL__R300_FORCE_VAP | SCLK_CNTL__FORCE_IDCT |
+			 SCLK_CNTL__FORCE_VIP   | SCLK_CNTL__R300_FORCE_SR |
+			 SCLK_CNTL__R300_FORCE_PX | SCLK_CNTL__R300_FORCE_TX |
+			 SCLK_CNTL__R300_FORCE_US | SCLK_CNTL__FORCE_TV_SCLK |
+			 SCLK_CNTL__R300_FORCE_SU | SCLK_CNTL__FORCE_OV0);
+		tmp |= SCLK_CNTL__DYN_STOP_LAT_MASK;
+		OUTPLL(pllSCLK_CNTL, tmp);
+
+		tmp = INPLL(pllSCLK_MORE_CNTL);
+		tmp &= ~SCLK_MORE_CNTL__FORCEON;
+		tmp |=  SCLK_MORE_CNTL__DISPREGS_MAX_DYN_STOP_LAT |
+			SCLK_MORE_CNTL__MC_GUI_MAX_DYN_STOP_LAT |
+			SCLK_MORE_CNTL__MC_HOST_MAX_DYN_STOP_LAT;
+		OUTPLL(pllSCLK_MORE_CNTL, tmp);
+
+		tmp = INPLL(pllVCLK_ECP_CNTL);
+		tmp |= (VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb |
+			VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb);   
+		OUTPLL(pllVCLK_ECP_CNTL, tmp);
+
+		tmp = INPLL(pllPIXCLKS_CNTL);
+		tmp |= (PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb         |
+			PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb     |
+			PIXCLKS_CNTL__DISP_TVOUT_PIXCLK_TV_ALWAYS_ONb |
+			PIXCLKS_CNTL__R300_DVOCLK_ALWAYS_ONb            |   
+			PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb    |
+			PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb       |
+			PIXCLKS_CNTL__R300_PIXCLK_DVO_ALWAYS_ONb        | 
+			PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb     |
+			PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb     |
+			PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb      |
+			PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb        |
+			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb           |
+			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb);
+		OUTPLL(pllPIXCLKS_CNTL, tmp);
+
+		tmp = INPLL(pllMCLK_MISC);
+		tmp |= (MCLK_MISC__MC_MCLK_DYN_ENABLE |
+			MCLK_MISC__IO_MCLK_DYN_ENABLE);
+		OUTPLL(pllMCLK_MISC, tmp);
+
+		tmp = INPLL(pllMCLK_CNTL);
+		tmp |= (MCLK_CNTL__FORCE_MCLKA | MCLK_CNTL__FORCE_MCLKB);
+		tmp &= ~(MCLK_CNTL__FORCE_YCLKA  |
+			 MCLK_CNTL__FORCE_YCLKB  |
+			 MCLK_CNTL__FORCE_MC);
+
+		/* Some releases of vbios have set DISABLE_MC_MCLKA
+		 * and DISABLE_MC_MCLKB bits in the vbios table.  Setting these
+		 * bits will cause H/W hang when reading video memory with dynamic
+		 * clocking enabled.
+		 */
+		if ((tmp & MCLK_CNTL__R300_DISABLE_MC_MCLKA) &&
+		    (tmp & MCLK_CNTL__R300_DISABLE_MC_MCLKB)) {
+			/* If both bits are set, then check the active channels */
+			tmp = INPLL(pllMCLK_CNTL);
+			if (rinfo->vram_width == 64) {
+			    if (INREG(MEM_CNTL) & R300_MEM_USE_CD_CH_ONLY)
+				tmp &= ~MCLK_CNTL__R300_DISABLE_MC_MCLKB;
+			    else
+				tmp &= ~MCLK_CNTL__R300_DISABLE_MC_MCLKA;
+			} else {
+			    tmp &= ~(MCLK_CNTL__R300_DISABLE_MC_MCLKA |
+				     MCLK_CNTL__R300_DISABLE_MC_MCLKB);
+			}
+		}
+		OUTPLL(pllMCLK_CNTL, tmp);
+		return;
+	}
 
-	/* Enable Dyanmic mode for SCLK */
+	/* R300 */
+	if (rinfo->family == CHIP_FAMILY_R300 || rinfo->family == CHIP_FAMILY_R350) {
+		tmp = INPLL(pllSCLK_CNTL);
+		tmp &= ~(SCLK_CNTL__R300_FORCE_VAP);
+		tmp |= SCLK_CNTL__FORCE_CP;
+		OUTPLL(pllSCLK_CNTL, tmp);
+		radeon_msleep(15);
+
+		tmp = INPLL(pllSCLK_CNTL2);
+		tmp &= ~(SCLK_CNTL2__R300_FORCE_TCL |
+			 SCLK_CNTL2__R300_FORCE_GA  |
+			 SCLK_CNTL2__R300_FORCE_CBA);
+		OUTPLL(pllSCLK_CNTL2, tmp);
+	}
 
-	sclk_cntl = INPLL( pllSCLK_CNTL_M6);	
-	sclk_cntl &= SCLK_CNTL_M6__SCLK_SRC_SEL_MASK;
-	sclk_cntl |= SCLK_CNTL_M6__FORCE_VIP;		
+	/* Others */
 
-	OUTPLL( pllSCLK_CNTL_M6, sclk_cntl);
+	tmp = INPLL( pllCLK_PWRMGT_CNTL);
+	tmp &= ~(CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT_MASK|
+		 CLK_PWRMGT_CNTL__DISP_DYN_STOP_LAT_MASK|
+		 CLK_PWRMGT_CNTL__DYN_STOP_MODE_MASK);
+	tmp |= CLK_PWRMGT_CNTL__ENGINE_DYNCLK_MODE_MASK |
+	       (0x01 << CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT__SHIFT);
+	OUTPLL( pllCLK_PWRMGT_CNTL, tmp);
+	radeon_msleep(15);
+
+	tmp = INPLL(pllCLK_PIN_CNTL);
+	tmp |= CLK_PIN_CNTL__SCLK_DYN_START_CNTL;
+	OUTPLL(pllCLK_PIN_CNTL, tmp);
+	radeon_msleep(15);
 
+	/* When DRI is enabled, setting DYN_STOP_LAT to zero can cause some R200 
+	 * to lockup randomly, leave them as set by BIOS.
+	 */
+	tmp = INPLL(pllSCLK_CNTL);	
+	tmp &= ~SCLK_CNTL__FORCEON_MASK;	
 
-	sclk_more_cntl = INPLL(pllSCLK_MORE_CNTL);
-	sclk_more_cntl &= ~(SCLK_MORE_CNTL__FORCE_DISPREGS);
-				                    
-	OUTPLL(pllSCLK_MORE_CNTL, sclk_more_cntl);
+	/*RAGE_6::A11 A12 A12N1 A13, RV250::A11 A12, R300*/
+	if ((rinfo->family == CHIP_FAMILY_RV250 &&
+	     ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) < CFG_ATI_REV_A13)) || 
+	    ((rinfo->family == CHIP_FAMILY_RV100) &&
+	     ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) <= CFG_ATI_REV_A13))) {
+		tmp |= SCLK_CNTL__FORCE_CP;
+		tmp |= SCLK_CNTL__FORCE_VIP;
+	}
+	OUTPLL(pllSCLK_CNTL, tmp);
+	radeon_msleep(15);
 
+	if ((rinfo->family == CHIP_FAMILY_RV200) ||
+	    (rinfo->family == CHIP_FAMILY_RV250) ||
+	    (rinfo->family == CHIP_FAMILY_RV280)) {
+		tmp = INPLL(pllSCLK_MORE_CNTL);
+		tmp &= ~SCLK_MORE_CNTL__FORCEON;
+
+		/* RV200::A11 A12 RV250::A11 A12 */
+		if (((rinfo->family == CHIP_FAMILY_RV200) ||
+		     (rinfo->family == CHIP_FAMILY_RV250)) &&
+		    ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) < CFG_ATI_REV_A13))
+			tmp |= SCLK_MORE_CNTL__FORCEON;
+		    
+		OUTPLL(pllSCLK_MORE_CNTL, tmp);
+		radeon_msleep(15);
+	}
 	
-	/* Enable Dynamic mode for PIXCLK & PIX2CLK */
 
-	pixclks_cntl = INPLL( pllPIXCLKS_CNTL);
-	
-	pixclks_cntl|=  PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb | 
-			PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb|
-			PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb|
-			PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb|
-			PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb|
-			PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb|
-			PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb;
+	/* RV200::A11 A12, RV250::A11 A12 */
+	if (((rinfo->family == CHIP_FAMILY_RV200) ||
+	     (rinfo->family == CHIP_FAMILY_RV250)) &&
+	    ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) < CFG_ATI_REV_A13)) {
+		tmp = INPLL(pllPLL_PWRMGT_CNTL);
+		tmp |= PLL_PWRMGT_CNTL__TCL_BYPASS_DISABLE;
+		OUTREG(pllPLL_PWRMGT_CNTL, tmp);
+		radeon_msleep(15);
+	}
 
-	OUTPLL( pllPIXCLKS_CNTL, pixclks_cntl);
+	tmp = INPLL(pllPIXCLKS_CNTL);
+	tmp |=  PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb | 
+		PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb|
+		PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb|
+		PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb|
+		PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb|
+		PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb|
+		PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb;
+	OUTPLL(pllPIXCLKS_CNTL, tmp);
+	radeon_msleep(15);
 		
-		
-	vclk_ecp_cntl = INPLL( pllVCLK_ECP_CNTL);
-	
-	vclk_ecp_cntl|=  VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb | 
-			 VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb;
-
-	OUTPLL( pllVCLK_ECP_CNTL, vclk_ecp_cntl);
+	tmp = INPLL(pllVCLK_ECP_CNTL);
+	tmp |=  VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb | 
+		VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb;
+	OUTPLL(pllVCLK_ECP_CNTL, tmp);
+
+	/* X doesn't do that ... hrm, we do on mobility && Macs */
+#ifdef CONFIG_PPC_OF
+	if (rinfo->is_mobility) {
+		tmp  = INPLL(pllMCLK_CNTL);
+		tmp &= ~(MCLK_CNTL__FORCE_MCLKA |
+			 MCLK_CNTL__FORCE_MCLKB |
+			 MCLK_CNTL__FORCE_YCLKA |
+			 MCLK_CNTL__FORCE_YCLKB);
+		OUTPLL(pllMCLK_CNTL, tmp);
+		radeon_msleep(15);
 
-
-	/* Enable Dynamic mode for MCLK	*/
-
-	mclk_cntl  = INPLL( pllMCLK_CNTL_M6);
-	mclk_cntl |= 	MCLK_CNTL_M6__FORCE_MCLKA|  
-			MCLK_CNTL_M6__FORCE_MCLKB|	
-			MCLK_CNTL_M6__FORCE_YCLKA|
-			MCLK_CNTL_M6__FORCE_YCLKB;
-			
-    	OUTPLL( pllMCLK_CNTL_M6, mclk_cntl);
-
-	mclk_misc = INPLL(pllMCLK_MISC);
-	mclk_misc |= 	MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT|
+		tmp = INPLL(pllMCLK_MISC);
+		tmp |= 	MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT|
 			MCLK_MISC__IO_MCLK_MAX_DYN_STOP_LAT|
 			MCLK_MISC__MC_MCLK_DYN_ENABLE|
-			MCLK_MISC__IO_MCLK_DYN_ENABLE;	
-	
-	OUTPLL(pllMCLK_MISC, mclk_misc);
+			MCLK_MISC__IO_MCLK_DYN_ENABLE;
+		OUTPLL(pllMCLK_MISC, tmp);
+		radeon_msleep(15);
+	}
+#endif /* CONFIG_PPC_OF */
 }
 
 #ifdef CONFIG_PM
@@ -218,7 +460,7 @@
 	return INREG( MC_IND_DATA);
 }
 
-static void radeon_pm_save_regs(struct radeonfb_info *rinfo)
+static void radeon_pm_save_regs(struct radeonfb_info *rinfo, int saving_for_d3)
 {
 	rinfo->save_regs[0] = INPLL(PLL_PWRMGT_CNTL);
 	rinfo->save_regs[1] = INPLL(CLK_PWRMGT_CNTL);
@@ -233,7 +475,6 @@
 	rinfo->save_regs[9] = INREG(DISP_MISC_CNTL);
 	rinfo->save_regs[10] = INREG(DISP_PWR_MAN);
 	rinfo->save_regs[11] = INREG(LVDS_GEN_CNTL);
-	rinfo->save_regs[12] = INREG(LVDS_PLL_CNTL);
 	rinfo->save_regs[13] = INREG(TV_DAC_CNTL);
 	rinfo->save_regs[14] = INREG(BUS_CNTL1);
 	rinfo->save_regs[15] = INREG(CRTC_OFFSET_CNTL);
@@ -256,6 +497,93 @@
 	rinfo->save_regs[31] = INREG(DISPLAY_BASE_ADDR);
 	rinfo->save_regs[32] = INREG(MC_AGP_LOCATION);
 	rinfo->save_regs[33] = INREG(CRTC2_DISPLAY_BASE_ADDR);
+
+	rinfo->save_regs[34] = INPLL(SCLK_MORE_CNTL);
+	rinfo->save_regs[35] = INREG(MEM_SDRAM_MODE_REG);
+	rinfo->save_regs[36] = INREG(BUS_CNTL);
+	rinfo->save_regs[39] = INREG(RBBM_CNTL);
+	rinfo->save_regs[40] = INREG(DAC_CNTL);
+	rinfo->save_regs[41] = INREG(HOST_PATH_CNTL);
+	rinfo->save_regs[37] = INREG(MPP_TB_CONFIG);
+	rinfo->save_regs[38] = INREG(FCP_CNTL);
+
+	if (rinfo->is_mobility) {
+		rinfo->save_regs[12] = INREG(LVDS_PLL_CNTL);
+		rinfo->save_regs[43] = INPLL(pllSSPLL_CNTL);
+		rinfo->save_regs[44] = INPLL(pllSSPLL_REF_DIV);
+		rinfo->save_regs[45] = INPLL(pllSSPLL_DIV_0);
+		rinfo->save_regs[90] = INPLL(pllSS_INT_CNTL);	
+		rinfo->save_regs[91] = INPLL(pllSS_TST_CNTL);	
+		rinfo->save_regs[81] = INREG(LVDS_GEN_CNTL);
+	}
+
+	if (rinfo->family >= CHIP_FAMILY_RV200) {
+		rinfo->save_regs[42] = INREG(MEM_REFRESH_CNTL);
+		rinfo->save_regs[46] = INREG(MC_CNTL);
+		rinfo->save_regs[47] = INREG(MC_INIT_GFX_LAT_TIMER);
+		rinfo->save_regs[48] = INREG(MC_INIT_MISC_LAT_TIMER);
+		rinfo->save_regs[49] = INREG(MC_TIMING_CNTL);
+		rinfo->save_regs[50] = INREG(MC_READ_CNTL_AB);
+		rinfo->save_regs[51] = INREG(MC_IOPAD_CNTL);
+		rinfo->save_regs[52] = INREG(MC_CHIP_IO_OE_CNTL_AB);
+		rinfo->save_regs[53] = INREG(MC_DEBUG);
+	}
+	rinfo->save_regs[54] = INREG(PAMAC0_DLY_CNTL);
+	rinfo->save_regs[55] = INREG(PAMAC1_DLY_CNTL);
+	rinfo->save_regs[56] = INREG(PAD_CTLR_MISC);
+	rinfo->save_regs[57] = INREG(FW_CNTL);
+
+	if (rinfo->family >= CHIP_FAMILY_R300) {
+		rinfo->save_regs[58] = INMC(rinfo, ixR300_MC_MC_INIT_WR_LAT_TIMER);
+		rinfo->save_regs[59] = INMC(rinfo, ixR300_MC_IMP_CNTL);
+		rinfo->save_regs[60] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_C0);
+		rinfo->save_regs[61] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_C1);
+		rinfo->save_regs[62] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_D0);
+		rinfo->save_regs[63] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_D1);
+		rinfo->save_regs[64] = INMC(rinfo, ixR300_MC_BIST_CNTL_3);
+		rinfo->save_regs[65] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_A0);
+		rinfo->save_regs[66] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_A1);
+		rinfo->save_regs[67] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_B0);
+		rinfo->save_regs[68] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_B1);
+		rinfo->save_regs[69] = INMC(rinfo, ixR300_MC_DEBUG_CNTL);
+		rinfo->save_regs[70] = INMC(rinfo, ixR300_MC_DLL_CNTL);
+		rinfo->save_regs[71] = INMC(rinfo, ixR300_MC_IMP_CNTL_0);
+		rinfo->save_regs[72] = INMC(rinfo, ixR300_MC_ELPIDA_CNTL);
+		rinfo->save_regs[96] = INMC(rinfo, ixR300_MC_READ_CNTL_CD);
+	} else {
+		rinfo->save_regs[59] = INMC(rinfo, ixMC_IMP_CNTL);
+		rinfo->save_regs[65] = INMC(rinfo, ixMC_CHP_IO_CNTL_A0);
+		rinfo->save_regs[66] = INMC(rinfo, ixMC_CHP_IO_CNTL_A1);
+		rinfo->save_regs[67] = INMC(rinfo, ixMC_CHP_IO_CNTL_B0);
+		rinfo->save_regs[68] = INMC(rinfo, ixMC_CHP_IO_CNTL_B1);
+		rinfo->save_regs[71] = INMC(rinfo, ixMC_IMP_CNTL_0);
+	}
+
+	rinfo->save_regs[73] = INPLL(pllMPLL_CNTL);
+	rinfo->save_regs[74] = INPLL(pllSPLL_CNTL);
+	rinfo->save_regs[75] = INPLL(pllMPLL_AUX_CNTL);
+	rinfo->save_regs[76] = INPLL(pllSPLL_AUX_CNTL);
+	rinfo->save_regs[77] = INPLL(pllM_SPLL_REF_FB_DIV);
+	rinfo->save_regs[78] = INPLL(pllAGP_PLL_CNTL);
+	rinfo->save_regs[79] = INREG(PAMAC2_DLY_CNTL);
+
+	rinfo->save_regs[80] = INREG(OV0_BASE_ADDR);
+	rinfo->save_regs[82] = INREG(FP_GEN_CNTL);
+	rinfo->save_regs[83] = INREG(FP2_GEN_CNTL);
+	rinfo->save_regs[84] = INREG(TMDS_CNTL);
+	rinfo->save_regs[85] = INREG(TMDS_TRANSMITTER_CNTL);
+	rinfo->save_regs[86] = INREG(DISP_OUTPUT_CNTL);
+	rinfo->save_regs[87] = INREG(DISP_HW_DEBUG);
+	rinfo->save_regs[88] = INREG(TV_MASTER_CNTL);
+	rinfo->save_regs[89] = INPLL(pllP2PLL_REF_DIV);
+	rinfo->save_regs[92] = INPLL(pllPPLL_DIV_0);
+	rinfo->save_regs[93] = INPLL(pllPPLL_CNTL);
+	rinfo->save_regs[94] = INREG(GRPH_BUFFER_CNTL);
+	rinfo->save_regs[95] = INREG(GRPH2_BUFFER_CNTL);
+	rinfo->save_regs[96] = INREG(HDP_DEBUG);
+	rinfo->save_regs[97] = INPLL(pllMDLL_CKO);
+	rinfo->save_regs[98] = INPLL(pllMDLL_RDCKA);
+	rinfo->save_regs[99] = INPLL(pllMDLL_RDCKB);
 }
 
 static void radeon_pm_restore_regs(struct radeonfb_info *rinfo)
@@ -270,12 +598,15 @@
 	OUTPLL(VCLK_ECP_CNTL, rinfo->save_regs[5]);
 	OUTPLL(PIXCLKS_CNTL, rinfo->save_regs[6]);
 	OUTPLL(MCLK_MISC, rinfo->save_regs[7]);
-	
+	if (rinfo->family == CHIP_FAMILY_RV350)
+		OUTPLL(SCLK_MORE_CNTL, rinfo->save_regs[34]);
+
 	OUTREG(SURFACE_CNTL, rinfo->save_regs[29]);
 	OUTREG(MC_FB_LOCATION, rinfo->save_regs[30]);
 	OUTREG(DISPLAY_BASE_ADDR, rinfo->save_regs[31]);
 	OUTREG(MC_AGP_LOCATION, rinfo->save_regs[32]);
 	OUTREG(CRTC2_DISPLAY_BASE_ADDR, rinfo->save_regs[33]);
+	OUTREG(CONFIG_MEMSIZE, rinfo->video_ram);
 
 	OUTREG(DISP_MISC_CNTL, rinfo->save_regs[9]);
 	OUTREG(DISP_PWR_MAN, rinfo->save_regs[10]);
@@ -287,10 +618,8 @@
 	OUTREG(AGP_CNTL, rinfo->save_regs[16]);
 	OUTREG(CRTC_GEN_CNTL, rinfo->save_regs[17]);
 	OUTREG(CRTC2_GEN_CNTL, rinfo->save_regs[18]);
-
-	// wait VBL before that one  ?
 	OUTPLL(P2PLL_CNTL, rinfo->save_regs[8]);
-	
+
 	OUTREG(GPIOPAD_A, rinfo->save_regs[19]);
 	OUTREG(GPIOPAD_EN, rinfo->save_regs[20]);
 	OUTREG(GPIOPAD_MASK, rinfo->save_regs[21]);
@@ -319,30 +648,32 @@
 
 static void radeon_pm_program_v2clk(struct radeonfb_info *rinfo)
 {
-	/* we use __INPLL and _OUTPLL and do the locking ourselves... */
-	unsigned long flags;
-	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	/* Set v2clk to 65MHz */
-  	__OUTPLL(pllPIXCLKS_CNTL,
-  		__INPLL(rinfo, pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
+	if (rinfo->family <= CHIP_FAMILY_RV280) {
+		OUTPLL(pllPIXCLKS_CNTL,
+			 __INPLL(rinfo, pllPIXCLKS_CNTL)
+			 & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
 	 
-  	__OUTPLL(pllP2PLL_REF_DIV, 0x0000000c);
-	__OUTPLL(pllP2PLL_CNTL, 0x0000bf00);
-	__OUTPLL(pllP2PLL_DIV_0, 0x00020074 | P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W);
+		OUTPLL(pllP2PLL_REF_DIV, 0x0000000c);
+		OUTPLL(pllP2PLL_CNTL, 0x0000bf00);
+	} else {
+		OUTPLL(pllP2PLL_REF_DIV, 0x0000000c);
+		INPLL(pllP2PLL_REF_DIV);
+		OUTPLL(pllP2PLL_CNTL, 0x0000a700);
+	}
+
+	OUTPLL(pllP2PLL_DIV_0, 0x00020074 | P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W);
 	
-	__OUTPLL(pllP2PLL_CNTL,
-		__INPLL(rinfo, pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_SLEEP);
+	OUTPLL(pllP2PLL_CNTL, INPLL(pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_SLEEP);
 	mdelay(1);
 
-	__OUTPLL(pllP2PLL_CNTL,
-		__INPLL(rinfo, pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_RESET);
+	OUTPLL(pllP2PLL_CNTL, INPLL(pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_RESET);
 	mdelay( 1);
 
-  	__OUTPLL(pllPIXCLKS_CNTL,
-  		(__INPLL(rinfo, pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK)
+  	OUTPLL(pllPIXCLKS_CNTL,
+  		(INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK)
   		| (0x03 << PIXCLKS_CNTL__PIX2CLK_SRC_SEL__SHIFT));
 	mdelay( 1);	
-	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 }
 
 static void radeon_pm_low_current(struct radeonfb_info *rinfo)
@@ -350,8 +681,12 @@
 	u32 reg;
 
 	reg  = INREG(BUS_CNTL1);
-	reg &= ~BUS_CNTL1_MOBILE_PLATFORM_SEL_MASK;
-	reg |= BUS_CNTL1_AGPCLK_VALID | (1<<BUS_CNTL1_MOBILE_PLATFORM_SEL_SHIFT);
+	if (rinfo->family <= CHIP_FAMILY_RV280) {
+		reg &= ~BUS_CNTL1_MOBILE_PLATFORM_SEL_MASK;
+		reg |= BUS_CNTL1_AGPCLK_VALID | (1<<BUS_CNTL1_MOBILE_PLATFORM_SEL_SHIFT);
+	} else {
+		reg |= 0x4080;
+	}
 	OUTREG(BUS_CNTL1, reg);
 	
 	reg  = INPLL(PLL_PWRMGT_CNTL);
@@ -400,35 +735,42 @@
 	u32 tmp;
 	
 	/* Force Core Clocks */
-	sclk_cntl = INPLL( pllSCLK_CNTL_M6);
-	sclk_cntl |= 	SCLK_CNTL_M6__IDCT_MAX_DYN_STOP_LAT|
-			SCLK_CNTL_M6__VIP_MAX_DYN_STOP_LAT|
-			SCLK_CNTL_M6__RE_MAX_DYN_STOP_LAT|
-			SCLK_CNTL_M6__PB_MAX_DYN_STOP_LAT|
-			SCLK_CNTL_M6__TAM_MAX_DYN_STOP_LAT|
-			SCLK_CNTL_M6__TDM_MAX_DYN_STOP_LAT|
-			SCLK_CNTL_M6__RB_MAX_DYN_STOP_LAT|
+	sclk_cntl = INPLL( pllSCLK_CNTL);
+	sclk_cntl |= 	SCLK_CNTL__IDCT_MAX_DYN_STOP_LAT|
+			SCLK_CNTL__VIP_MAX_DYN_STOP_LAT|
+			SCLK_CNTL__RE_MAX_DYN_STOP_LAT|
+			SCLK_CNTL__PB_MAX_DYN_STOP_LAT|
+			SCLK_CNTL__TAM_MAX_DYN_STOP_LAT|
+			SCLK_CNTL__TDM_MAX_DYN_STOP_LAT|
+			SCLK_CNTL__RB_MAX_DYN_STOP_LAT|
 			
-			SCLK_CNTL_M6__FORCE_DISP2|
-			SCLK_CNTL_M6__FORCE_CP|
-			SCLK_CNTL_M6__FORCE_HDP|
-			SCLK_CNTL_M6__FORCE_DISP1|
-			SCLK_CNTL_M6__FORCE_TOP|
-			SCLK_CNTL_M6__FORCE_E2|
-			SCLK_CNTL_M6__FORCE_SE|
-			SCLK_CNTL_M6__FORCE_IDCT|
-			SCLK_CNTL_M6__FORCE_VIP|
+			SCLK_CNTL__FORCE_DISP2|
+			SCLK_CNTL__FORCE_CP|
+			SCLK_CNTL__FORCE_HDP|
+			SCLK_CNTL__FORCE_DISP1|
+			SCLK_CNTL__FORCE_TOP|
+			SCLK_CNTL__FORCE_E2|
+			SCLK_CNTL__FORCE_SE|
+			SCLK_CNTL__FORCE_IDCT|
+			SCLK_CNTL__FORCE_VIP|
 			
-			SCLK_CNTL_M6__FORCE_RE|
-			SCLK_CNTL_M6__FORCE_PB|
-			SCLK_CNTL_M6__FORCE_TAM|
-			SCLK_CNTL_M6__FORCE_TDM|
-			SCLK_CNTL_M6__FORCE_RB|
-			SCLK_CNTL_M6__FORCE_TV_SCLK|
-			SCLK_CNTL_M6__FORCE_SUBPIC|
-			SCLK_CNTL_M6__FORCE_OV0;
+			SCLK_CNTL__FORCE_PB|
+			SCLK_CNTL__FORCE_TAM|
+			SCLK_CNTL__FORCE_TDM|
+			SCLK_CNTL__FORCE_RB|
+			SCLK_CNTL__FORCE_TV_SCLK|
+			SCLK_CNTL__FORCE_SUBPIC|
+			SCLK_CNTL__FORCE_OV0;
+	if (rinfo->family <= CHIP_FAMILY_RV280)
+		sclk_cntl |= SCLK_CNTL__FORCE_RE;
+	else
+		sclk_cntl |= SCLK_CNTL__SE_MAX_DYN_STOP_LAT |
+			SCLK_CNTL__E2_MAX_DYN_STOP_LAT |
+			SCLK_CNTL__TV_MAX_DYN_STOP_LAT |
+			SCLK_CNTL__HDP_MAX_DYN_STOP_LAT |
+			SCLK_CNTL__CP_MAX_DYN_STOP_LAT;
 
-	OUTPLL( pllSCLK_CNTL_M6, sclk_cntl);
+	OUTPLL( pllSCLK_CNTL, sclk_cntl);
 
 	sclk_more_cntl = INPLL(pllSCLK_MORE_CNTL);
 	sclk_more_cntl |= 	SCLK_MORE_CNTL__FORCE_DISPREGS |
@@ -438,18 +780,19 @@
 	OUTPLL(pllSCLK_MORE_CNTL, sclk_more_cntl);		
 
 	
-	mclk_cntl = INPLL( pllMCLK_CNTL_M6);
-	mclk_cntl &= ~(	MCLK_CNTL_M6__FORCE_MCLKA |  
-			MCLK_CNTL_M6__FORCE_MCLKB |
-			MCLK_CNTL_M6__FORCE_YCLKA | 
-			MCLK_CNTL_M6__FORCE_YCLKB | 
-			MCLK_CNTL_M6__FORCE_MC
+	mclk_cntl = INPLL( pllMCLK_CNTL);
+	mclk_cntl &= ~(	MCLK_CNTL__FORCE_MCLKA |  
+			MCLK_CNTL__FORCE_MCLKB |
+			MCLK_CNTL__FORCE_YCLKA | 
+			MCLK_CNTL__FORCE_YCLKB | 
+			MCLK_CNTL__FORCE_MC
 		      );	
-    	OUTPLL( pllMCLK_CNTL_M6, mclk_cntl);
+    	OUTPLL( pllMCLK_CNTL, mclk_cntl);
 	
 	/* Force Display clocks	*/
 	vclk_ecp_cntl = INPLL( pllVCLK_ECP_CNTL);
-	vclk_ecp_cntl &= ~(VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb |VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb);
+	vclk_ecp_cntl &= ~(VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb
+			   | VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb);
 	vclk_ecp_cntl |= VCLK_ECP_CNTL__ECP_FORCE_ON;
 	OUTPLL( pllVCLK_ECP_CNTL, vclk_ecp_cntl);
 	
@@ -480,26 +823,27 @@
 						
 	OUTPLL( pllPLL_PWRMGT_CNTL, pll_pwrmgt_cntl);
 	
-	clk_pwrmgt_cntl	 = INPLL( pllCLK_PWRMGT_CNTL_M6);
+	clk_pwrmgt_cntl	 = INPLL( pllCLK_PWRMGT_CNTL);
 	
-	clk_pwrmgt_cntl &= ~(	CLK_PWRMGT_CNTL_M6__MPLL_PWRMGT_OFF|
-				CLK_PWRMGT_CNTL_M6__SPLL_PWRMGT_OFF|
-				CLK_PWRMGT_CNTL_M6__PPLL_PWRMGT_OFF|
-				CLK_PWRMGT_CNTL_M6__P2PLL_PWRMGT_OFF|
-				CLK_PWRMGT_CNTL_M6__MCLK_TURNOFF|
-				CLK_PWRMGT_CNTL_M6__SCLK_TURNOFF|
-				CLK_PWRMGT_CNTL_M6__PCLK_TURNOFF|
-				CLK_PWRMGT_CNTL_M6__P2CLK_TURNOFF|
-				CLK_PWRMGT_CNTL_M6__TVPLL_PWRMGT_OFF|
-				CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN|
-				CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE|
-				CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT_MASK|
-				CLK_PWRMGT_CNTL_M6__CG_NO1_DEBUG_MASK			
+	clk_pwrmgt_cntl &= ~(	CLK_PWRMGT_CNTL__MPLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL__SPLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL__PPLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL__P2PLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL__MCLK_TURNOFF|
+				CLK_PWRMGT_CNTL__SCLK_TURNOFF|
+				CLK_PWRMGT_CNTL__PCLK_TURNOFF|
+				CLK_PWRMGT_CNTL__P2CLK_TURNOFF|
+				CLK_PWRMGT_CNTL__TVPLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL__GLOBAL_PMAN_EN|
+				CLK_PWRMGT_CNTL__ENGINE_DYNCLK_MODE|
+				CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT_MASK|
+				CLK_PWRMGT_CNTL__CG_NO1_DEBUG_MASK			
 			);
 						
-	clk_pwrmgt_cntl |= CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN | CLK_PWRMGT_CNTL_M6__DISP_PM;
+	clk_pwrmgt_cntl |= CLK_PWRMGT_CNTL__GLOBAL_PMAN_EN 
+		| CLK_PWRMGT_CNTL__DISP_PM;
 	
-	OUTPLL( pllCLK_PWRMGT_CNTL_M6, clk_pwrmgt_cntl);	
+	OUTPLL( pllCLK_PWRMGT_CNTL, clk_pwrmgt_cntl);	
 	
 	clk_pin_cntl = INPLL( pllCLK_PIN_CNTL);
 	
@@ -510,12 +854,19 @@
 	OUTPLL( pllMCLK_MISC, tmp);
 	
 	/* AGP PLL control */
-	OUTREG(BUS_CNTL1, INREG(BUS_CNTL1) |  BUS_CNTL1__AGPCLK_VALID);
+	if (rinfo->family <= CHIP_FAMILY_RV280) {
+		OUTREG(BUS_CNTL1, INREG(BUS_CNTL1) |  BUS_CNTL1__AGPCLK_VALID);
+
+		OUTREG(BUS_CNTL1,
+		       (INREG(BUS_CNTL1) & ~BUS_CNTL1__MOBILE_PLATFORM_SEL_MASK)
+		       | (2<<BUS_CNTL1__MOBILE_PLATFORM_SEL__SHIFT));	// 440BX
+	} else {
+		OUTREG(BUS_CNTL1, INREG(BUS_CNTL1));
+		OUTREG(BUS_CNTL1, (INREG(BUS_CNTL1) & ~0x4000) | 0x8000);
+	}
 
-	OUTREG(BUS_CNTL1,
-		(INREG(BUS_CNTL1) & ~BUS_CNTL1__MOBILE_PLATFORM_SEL_MASK)
-		| (2<<BUS_CNTL1__MOBILE_PLATFORM_SEL__SHIFT));	// 440BX
-	OUTREG(CRTC_OFFSET_CNTL, (INREG(CRTC_OFFSET_CNTL) & ~CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC_OUT_EN));
+	OUTREG(CRTC_OFFSET_CNTL, (INREG(CRTC_OFFSET_CNTL)
+				  & ~CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC_OUT_EN));
 	
 	clk_pin_cntl &= ~CLK_PIN_CNTL__CG_CLK_TO_OUTPIN;
 	clk_pin_cntl |= CLK_PIN_CNTL__XTALIN_ALWAYS_ONb;	
@@ -547,16 +898,16 @@
 				DISP_MISC_CNTL__SOFT_RESET_DIG_TMDS|
 				DISP_MISC_CNTL__SOFT_RESET_TV);
 	
-	OUTREG(DISP_MISC_CNTL, disp_mis_cntl);					
+	OUTREG(DISP_MISC_CNTL, disp_mis_cntl);
 						
 	disp_pwr_man = INREG(DISP_PWR_MAN);
 	
 	disp_pwr_man &= ~(	DISP_PWR_MAN__DISP_PWR_MAN_D3_CRTC_EN	| 
-						DISP_PWR_MAN__DISP2_PWR_MAN_D3_CRTC2_EN |
-						DISP_PWR_MAN__DISP_PWR_MAN_DPMS_MASK|		
-						DISP_PWR_MAN__DISP_D3_RST|
-						DISP_PWR_MAN__DISP_D3_REG_RST
-					);
+				DISP_PWR_MAN__DISP2_PWR_MAN_D3_CRTC2_EN |
+				DISP_PWR_MAN__DISP_PWR_MAN_DPMS_MASK|
+				DISP_PWR_MAN__DISP_D3_RST|
+				DISP_PWR_MAN__DISP_D3_REG_RST
+				);
 	
 	disp_pwr_man |= DISP_PWR_MAN__DISP_D3_GRPH_RST|
 					DISP_PWR_MAN__DISP_D3_SUBPIC_RST|
@@ -571,27 +922,29 @@
 	
 	OUTREG(DISP_PWR_MAN, disp_pwr_man);					
 							
-	clk_pwrmgt_cntl = INPLL( pllCLK_PWRMGT_CNTL_M6);
+	clk_pwrmgt_cntl = INPLL( pllCLK_PWRMGT_CNTL);
 	pll_pwrmgt_cntl = INPLL( pllPLL_PWRMGT_CNTL) ;
 	clk_pin_cntl 	= INPLL( pllCLK_PIN_CNTL);
 	disp_pwr_man	= INREG(DISP_PWR_MAN);
 		
 	
 	/* D2 */
-	clk_pwrmgt_cntl |= CLK_PWRMGT_CNTL_M6__DISP_PM;
+	clk_pwrmgt_cntl |= CLK_PWRMGT_CNTL__DISP_PM;
 	pll_pwrmgt_cntl |= PLL_PWRMGT_CNTL__MOBILE_SU | PLL_PWRMGT_CNTL__SU_SCLK_USE_BCLK;
 	clk_pin_cntl	|= CLK_PIN_CNTL__XTALIN_ALWAYS_ONb;
-	disp_pwr_man 	&= ~(DISP_PWR_MAN__DISP_PWR_MAN_D3_CRTC_EN_MASK | DISP_PWR_MAN__DISP2_PWR_MAN_D3_CRTC2_EN_MASK);							
-						
+	disp_pwr_man 	&= ~(DISP_PWR_MAN__DISP_PWR_MAN_D3_CRTC_EN_MASK
+			     | DISP_PWR_MAN__DISP2_PWR_MAN_D3_CRTC2_EN_MASK);
 
-	OUTPLL( pllCLK_PWRMGT_CNTL_M6, clk_pwrmgt_cntl);
+	OUTPLL( pllCLK_PWRMGT_CNTL, clk_pwrmgt_cntl);
 	OUTPLL( pllPLL_PWRMGT_CNTL, pll_pwrmgt_cntl);
 	OUTPLL( pllCLK_PIN_CNTL, clk_pin_cntl);
 	OUTREG(DISP_PWR_MAN, disp_pwr_man);
 
 	/* disable display request & disable display */
-	OUTREG( CRTC_GEN_CNTL, (INREG( CRTC_GEN_CNTL) & ~CRTC_GEN_CNTL__CRTC_EN) | CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B);
-	OUTREG( CRTC2_GEN_CNTL, (INREG( CRTC2_GEN_CNTL) & ~CRTC2_GEN_CNTL__CRTC2_EN) | CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B);
+	OUTREG( CRTC_GEN_CNTL, (INREG( CRTC_GEN_CNTL) & ~CRTC_GEN_CNTL__CRTC_EN)
+		| CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B);
+	OUTREG( CRTC2_GEN_CNTL, (INREG( CRTC2_GEN_CNTL) & ~CRTC2_GEN_CNTL__CRTC2_EN)
+		| CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B);
 
 	mdelay(17);				   
 
@@ -601,17 +954,15 @@
 {
 	u32 mc_chp_io_cntl_a1, mc_chp_io_cntl_b1;
 
-	mc_chp_io_cntl_a1 = INMC( rinfo, ixMC_CHP_IO_CNTL_A1) & ~MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA_MASK;
-	mc_chp_io_cntl_b1 = INMC( rinfo, ixMC_CHP_IO_CNTL_B1) & ~MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB_MASK;
-
-	OUTMC( rinfo, ixMC_CHP_IO_CNTL_A1, mc_chp_io_cntl_a1 | (1<<MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA__SHIFT));
-	OUTMC( rinfo, ixMC_CHP_IO_CNTL_B1, mc_chp_io_cntl_b1 | (1<<MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB__SHIFT));
-
-	/* Wassup ? This doesn't seem to be defined, let's hope we are ok this way --BenH */
-#ifdef MCLK_YCLK_SYNC_ENABLE
-	mc_chp_io_cntl_a1 |= (2<<MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA__SHIFT);
-	mc_chp_io_cntl_b1 |= (2<<MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB__SHIFT);
-#endif
+	mc_chp_io_cntl_a1 = INMC( rinfo, ixMC_CHP_IO_CNTL_A1)
+		& ~MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA_MASK;
+	mc_chp_io_cntl_b1 = INMC( rinfo, ixMC_CHP_IO_CNTL_B1)
+		& ~MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB_MASK;
+
+	OUTMC( rinfo, ixMC_CHP_IO_CNTL_A1, mc_chp_io_cntl_a1
+	       | (1<<MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA__SHIFT));
+	OUTMC( rinfo, ixMC_CHP_IO_CNTL_B1, mc_chp_io_cntl_b1
+	       | (1<<MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB__SHIFT));
 
 	OUTMC( rinfo, ixMC_CHP_IO_CNTL_A1, mc_chp_io_cntl_a1);
 	OUTMC( rinfo, ixMC_CHP_IO_CNTL_B1, mc_chp_io_cntl_b1);
@@ -619,25 +970,70 @@
 	mdelay( 1);
 }
 
-static void radeon_pm_program_mode_reg(struct radeonfb_info *rinfo, u16 value, u8 delay_required)
+static void radeon_pm_yclk_mclk_sync_m10(struct radeonfb_info *rinfo)
+{
+	u32 mc_chp_io_cntl_a1, mc_chp_io_cntl_b1;
+
+	mc_chp_io_cntl_a1 = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_A1)
+		& ~MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA_MASK;
+	mc_chp_io_cntl_b1 = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_B1)
+		& ~MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB_MASK;
+
+	OUTMC( rinfo, ixR300_MC_CHP_IO_CNTL_A1,
+	       mc_chp_io_cntl_a1 | (1<<MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA__SHIFT));
+	OUTMC( rinfo, ixR300_MC_CHP_IO_CNTL_B1,
+	       mc_chp_io_cntl_b1 | (1<<MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB__SHIFT));
+
+	OUTMC( rinfo, ixR300_MC_CHP_IO_CNTL_A1, mc_chp_io_cntl_a1);
+	OUTMC( rinfo, ixR300_MC_CHP_IO_CNTL_B1, mc_chp_io_cntl_b1);
+
+	mdelay( 1);
+}
+
+static void radeon_pm_program_mode_reg(struct radeonfb_info *rinfo, u16 value,
+				       u8 delay_required)
 {  
 	u32 mem_sdram_mode;
 
 	mem_sdram_mode  = INREG( MEM_SDRAM_MODE_REG);
 
 	mem_sdram_mode &= ~MEM_SDRAM_MODE_REG__MEM_MODE_REG_MASK;
-	mem_sdram_mode |= (value<<MEM_SDRAM_MODE_REG__MEM_MODE_REG__SHIFT) | MEM_SDRAM_MODE_REG__MEM_CFG_TYPE;
+	mem_sdram_mode |= (value<<MEM_SDRAM_MODE_REG__MEM_MODE_REG__SHIFT)
+		| MEM_SDRAM_MODE_REG__MEM_CFG_TYPE;
 	OUTREG( MEM_SDRAM_MODE_REG, mem_sdram_mode);
+	if (delay_required >= 2)
+		mdelay(1);
 
 	mem_sdram_mode |=  MEM_SDRAM_MODE_REG__MEM_SDRAM_RESET;
 	OUTREG( MEM_SDRAM_MODE_REG, mem_sdram_mode);
+	if (delay_required >= 2)
+		mdelay(1);
 
 	mem_sdram_mode &= ~MEM_SDRAM_MODE_REG__MEM_SDRAM_RESET;
 	OUTREG( MEM_SDRAM_MODE_REG, mem_sdram_mode);
+	if (delay_required >= 2)
+		mdelay(1);
 
-	if (delay_required == 1)
-		while( (INREG( MC_STATUS) & (MC_STATUS__MEM_PWRUP_COMPL_A | MC_STATUS__MEM_PWRUP_COMPL_B) ) == 0 )
-			{ }; 	
+	if (delay_required) {
+		do {
+			if (delay_required >= 2)
+				mdelay(1);
+		} while ((INREG(MC_STATUS)
+			  & (MC_STATUS__MEM_PWRUP_COMPL_A |
+			     MC_STATUS__MEM_PWRUP_COMPL_B)) == 0);
+	}
+}
+
+static void radeon_pm_m10_program_mode_wait(struct radeonfb_info *rinfo)
+{
+	int cnt;
+
+	for (cnt = 0; cnt < 100; ++cnt) {
+		mdelay(1);
+		if (INREG(MC_STATUS) & (MC_STATUS__MEM_PWRUP_COMPL_A
+					| MC_STATUS__MEM_PWRUP_COMPL_B))
+			break;
+	}
 }
 
 
@@ -646,126 +1042,274 @@
 #define DLL_RESET_DELAY 	5
 #define DLL_SLEEP_DELAY		1
 
-	u32 DLL_CKO_Value = INPLL(pllMDLL_CKO)   | MDLL_CKO__MCKOA_SLEEP |  MDLL_CKO__MCKOA_RESET;
-	u32 DLL_CKA_Value = INPLL(pllMDLL_RDCKA) | MDLL_RDCKA__MRDCKA0_SLEEP | MDLL_RDCKA__MRDCKA1_SLEEP | MDLL_RDCKA__MRDCKA0_RESET | MDLL_RDCKA__MRDCKA1_RESET;
-	u32 DLL_CKB_Value = INPLL(pllMDLL_RDCKB) | MDLL_RDCKB__MRDCKB0_SLEEP | MDLL_RDCKB__MRDCKB1_SLEEP | MDLL_RDCKB__MRDCKB0_RESET | MDLL_RDCKB__MRDCKB1_RESET;
+	u32 cko = INPLL(pllMDLL_CKO)   | MDLL_CKO__MCKOA_SLEEP
+		| MDLL_CKO__MCKOA_RESET;
+	u32 cka = INPLL(pllMDLL_RDCKA) | MDLL_RDCKA__MRDCKA0_SLEEP
+		| MDLL_RDCKA__MRDCKA1_SLEEP | MDLL_RDCKA__MRDCKA0_RESET
+		| MDLL_RDCKA__MRDCKA1_RESET;
+	u32 ckb = INPLL(pllMDLL_RDCKB) | MDLL_RDCKB__MRDCKB0_SLEEP
+		| MDLL_RDCKB__MRDCKB1_SLEEP | MDLL_RDCKB__MRDCKB0_RESET
+		| MDLL_RDCKB__MRDCKB1_RESET;
 
 	/* Setting up the DLL range for write */
-	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
-	OUTPLL(pllMDLL_RDCKA,  	DLL_CKA_Value);
-	OUTPLL(pllMDLL_RDCKB,	DLL_CKB_Value);
-
-	mdelay( DLL_RESET_DELAY);
+	OUTPLL(pllMDLL_CKO,   	cko);
+	OUTPLL(pllMDLL_RDCKA,  	cka);
+	OUTPLL(pllMDLL_RDCKB,	ckb);
+
+	mdelay(DLL_RESET_DELAY*2);
+
+	cko &= ~(MDLL_CKO__MCKOA_SLEEP | MDLL_CKO__MCKOB_SLEEP);
+	OUTPLL(pllMDLL_CKO, cko);
+	mdelay(DLL_SLEEP_DELAY);
+	cko &= ~(MDLL_CKO__MCKOA_RESET | MDLL_CKO__MCKOB_RESET);
+	OUTPLL(pllMDLL_CKO, cko);
+	mdelay(DLL_RESET_DELAY);
+
+	cka &= ~(MDLL_RDCKA__MRDCKA0_SLEEP | MDLL_RDCKA__MRDCKA1_SLEEP);
+	OUTPLL(pllMDLL_RDCKA, cka);
+	mdelay(DLL_SLEEP_DELAY);
+	cka &= ~(MDLL_RDCKA__MRDCKA0_RESET | MDLL_RDCKA__MRDCKA1_RESET);
+	OUTPLL(pllMDLL_RDCKA, cka);
+	mdelay(DLL_RESET_DELAY);
+
+	ckb &= ~(MDLL_RDCKB__MRDCKB0_SLEEP | MDLL_RDCKB__MRDCKB1_SLEEP);
+	OUTPLL(pllMDLL_RDCKB, ckb);
+	mdelay(DLL_SLEEP_DELAY);
+	ckb &= ~(MDLL_RDCKB__MRDCKB0_RESET | MDLL_RDCKB__MRDCKB1_RESET);
+	OUTPLL(pllMDLL_RDCKB, ckb);
+	mdelay(DLL_RESET_DELAY);
 
-	/* Channel A */
-
-	/* Power Up */
-	DLL_CKO_Value &= ~(MDLL_CKO__MCKOA_SLEEP );
-	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
-	mdelay( DLL_SLEEP_DELAY);  		
-   
-	DLL_CKO_Value &= ~(MDLL_CKO__MCKOA_RESET );
-	OUTPLL(pllMDLL_CKO,	DLL_CKO_Value);
-	mdelay( DLL_RESET_DELAY);  		
-
-	/* Power Up */
-	DLL_CKA_Value &= ~(MDLL_RDCKA__MRDCKA0_SLEEP );
-	OUTPLL(pllMDLL_RDCKA,  	DLL_CKA_Value);
-	mdelay( DLL_SLEEP_DELAY);  		
-
-	DLL_CKA_Value &= ~(MDLL_RDCKA__MRDCKA0_RESET );
-	OUTPLL(pllMDLL_RDCKA,	DLL_CKA_Value);
-	mdelay( DLL_RESET_DELAY);  		
-
-	/* Power Up */
-	DLL_CKA_Value &= ~(MDLL_RDCKA__MRDCKA1_SLEEP);
-	OUTPLL(pllMDLL_RDCKA,	DLL_CKA_Value);
-	mdelay( DLL_SLEEP_DELAY);  		
-
-	DLL_CKA_Value &= ~(MDLL_RDCKA__MRDCKA1_RESET);
-	OUTPLL(pllMDLL_RDCKA,	DLL_CKA_Value);
-	mdelay( DLL_RESET_DELAY);  		
 
+#undef DLL_RESET_DELAY 
+#undef DLL_SLEEP_DELAY
+}
 
-	/* Channel B */
+static void radeon_pm_enable_dll_m10(struct radeonfb_info *rinfo)
+{  
+	u32 dll_value;
+	u32 dll_sleep_mask = 0;
+	u32 dll_reset_mask = 0;
+	u32 mc;
 
-	/* Power Up */
-	DLL_CKO_Value &= ~(MDLL_CKO__MCKOB_SLEEP );
-	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
-	mdelay( DLL_SLEEP_DELAY);  		
-   
-	DLL_CKO_Value &= ~(MDLL_CKO__MCKOB_RESET );
-	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
-	mdelay( DLL_RESET_DELAY);  		
+#define DLL_RESET_DELAY 	5
+#define DLL_SLEEP_DELAY		1
 
-	/* Power Up */
-	DLL_CKB_Value &= ~(MDLL_RDCKB__MRDCKB0_SLEEP);
-	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
-	mdelay( DLL_SLEEP_DELAY);  		
+	OUTMC(rinfo, ixR300_MC_DLL_CNTL, rinfo->save_regs[70]);
+	mc = INREG(MC_CNTL);
+	/* Check which channels are enabled */
+	switch (mc & 0x3) {
+	case 1:
+		if (mc & 0x4)
+			break;
+	case 2:
+		dll_sleep_mask |= MDLL_R300_RDCK__MRDCKB_SLEEP;
+		dll_reset_mask |= MDLL_R300_RDCK__MRDCKB_RESET;
+	case 0:
+		dll_sleep_mask |= MDLL_R300_RDCK__MRDCKA_SLEEP;
+		dll_reset_mask |= MDLL_R300_RDCK__MRDCKA_RESET;
+	}
+	switch (mc & 0x3) {
+	case 1:
+		if (!(mc & 0x4))
+			break;
+	case 2:
+		dll_sleep_mask |= MDLL_R300_RDCK__MRDCKD_SLEEP;
+		dll_reset_mask |= MDLL_R300_RDCK__MRDCKD_RESET;
+		dll_sleep_mask |= MDLL_R300_RDCK__MRDCKC_SLEEP;
+		dll_reset_mask |= MDLL_R300_RDCK__MRDCKC_RESET;
+	}
 
-	DLL_CKB_Value &= ~(MDLL_RDCKB__MRDCKB0_RESET);
-	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
-	mdelay( DLL_RESET_DELAY);  		
+	dll_value = INPLL(pllMDLL_RDCKA);
 
 	/* Power Up */
-	DLL_CKB_Value &= ~(MDLL_RDCKB__MRDCKB1_SLEEP);
-	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
+	dll_value &= ~(dll_sleep_mask);
+	OUTPLL(pllMDLL_RDCKA, dll_value);
 	mdelay( DLL_SLEEP_DELAY);  		
 
-	DLL_CKB_Value &= ~(MDLL_RDCKB__MRDCKB1_RESET);
-	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
+	dll_value &= ~(dll_reset_mask);
+	OUTPLL(pllMDLL_RDCKA, dll_value);
 	mdelay( DLL_RESET_DELAY);  		
 
 #undef DLL_RESET_DELAY 
 #undef DLL_SLEEP_DELAY
 }
 
+
 static void radeon_pm_full_reset_sdram(struct radeonfb_info *rinfo)
 {
-	u32 crtcGenCntl, crtcGenCntl2, memRefreshCntl, crtc_more_cntl, fp_gen_cntl, fp2_gen_cntl;
+	u32 crtcGenCntl, crtcGenCntl2, memRefreshCntl, crtc_more_cntl,
+		fp_gen_cntl, fp2_gen_cntl;
  
 	crtcGenCntl  = INREG( CRTC_GEN_CNTL);
 	crtcGenCntl2 = INREG( CRTC2_GEN_CNTL);
 
-	memRefreshCntl 	= INREG( MEM_REFRESH_CNTL);
 	crtc_more_cntl 	= INREG( CRTC_MORE_CNTL);
 	fp_gen_cntl 	= INREG( FP_GEN_CNTL);
 	fp2_gen_cntl 	= INREG( FP2_GEN_CNTL);
  
 
-	OUTREG( CRTC_MORE_CNTL, 	0);
-	OUTREG( FP_GEN_CNTL, 	0);
-	OUTREG( FP2_GEN_CNTL, 	0);
+	OUTREG( CRTC_MORE_CNTL, 0);
+	OUTREG( FP_GEN_CNTL, 0);
+	OUTREG( FP2_GEN_CNTL,0);
  
 	OUTREG( CRTC_GEN_CNTL,  (crtcGenCntl | CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B) );
 	OUTREG( CRTC2_GEN_CNTL, (crtcGenCntl2 | CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B) );
   
-	/* Disable refresh */
-	OUTREG( MEM_REFRESH_CNTL, memRefreshCntl | MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+	/* This is the code for the Aluminium PowerBooks M10 */
+	if (rinfo->family == CHIP_FAMILY_RV350) {
+		u32 sdram_mode_reg = rinfo->save_regs[35];
+		static u32 default_mrtable[] =
+			{ 0x21320032,
+			  0x21321000, 0xa1321000, 0x21321000, 0xffffffff,
+			  0x21320032, 0xa1320032, 0x21320032, 0xffffffff,
+			  0x21321002, 0xa1321002, 0x21321002, 0xffffffff,
+			  0x21320132, 0xa1320132, 0x21320132, 0xffffffff,
+			  0x21320032, 0xa1320032, 0x21320032, 0xffffffff,
+			  0x31320032 };
+
+		u32 *mrtable = default_mrtable;
+		int i, mrtable_size = ARRAY_SIZE(default_mrtable);
+						 
+		mdelay(30);
+
+		/* Disable refresh */
+		memRefreshCntl 	= INREG( MEM_REFRESH_CNTL)
+			& ~MEM_REFRESH_CNTL__MEM_REFRESH_DIS;
+		OUTREG( MEM_REFRESH_CNTL, memRefreshCntl 
+			| MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+ 
+		/* Configure and enable M & SPLLs */
+       		radeon_pm_enable_dll_m10(rinfo);
+		radeon_pm_yclk_mclk_sync_m10(rinfo);
+
+#ifdef CONFIG_PPC_OF
+		if (rinfo->of_node != NULL) {
+			int size;
+
+			mrtable = (u32 *)get_property(rinfo->of_node, "ATY,MRT", &size);
+			if (mrtable)
+				mrtable_size = size >> 2;
+			else
+				mrtable = default_mrtable;
+		}
+#endif /* CONFIG_PPC_OF */
+
+		/* Program the SDRAM */
+		sdram_mode_reg = mrtable[0];
+		OUTREG(MEM_SDRAM_MODE_REG, sdram_mode_reg);
+		for (i = 0; i < mrtable_size; i++) {
+			if (mrtable[i] == 0xffffffffu)
+				radeon_pm_m10_program_mode_wait(rinfo);
+			else {
+				sdram_mode_reg &= ~(MEM_SDRAM_MODE_REG__MEM_MODE_REG_MASK
+						    | MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE
+						    | MEM_SDRAM_MODE_REG__MEM_SDRAM_RESET);
+				sdram_mode_reg |= mrtable[i];
+
+				OUTREG(MEM_SDRAM_MODE_REG, sdram_mode_reg);
+				mdelay(1);
+			}
+		}
+
+		/* Restore memory refresh */
+		OUTREG(MEM_REFRESH_CNTL, memRefreshCntl);
+		mdelay(30);
+
+	}
+	/* Here come the desktop RV200 "QW" card */
+	else if (!rinfo->is_mobility && rinfo->family == CHIP_FAMILY_RV200) {
+		/* Disable refresh */
+		memRefreshCntl 	= INREG( MEM_REFRESH_CNTL)
+			& ~MEM_REFRESH_CNTL__MEM_REFRESH_DIS;
+		OUTREG(MEM_REFRESH_CNTL, memRefreshCntl
+		       | MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+		mdelay(30);
+ 
+		/* Reset memory */
+		OUTREG(MEM_SDRAM_MODE_REG,
+		       INREG( MEM_SDRAM_MODE_REG) & ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+
+		radeon_pm_program_mode_reg(rinfo, 0x2002, 2);
+		radeon_pm_program_mode_reg(rinfo, 0x0132, 2);   
+		radeon_pm_program_mode_reg(rinfo, 0x0032, 2); 
+
+		OUTREG(MEM_SDRAM_MODE_REG,
+		       INREG(MEM_SDRAM_MODE_REG) | MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+
+		OUTREG( MEM_REFRESH_CNTL, 	memRefreshCntl);
+
+	}
+	/* The M6 */
+	else if (rinfo->is_mobility && rinfo->family == CHIP_FAMILY_RV100) {
+		/* Disable refresh */
+		memRefreshCntl = INREG(EXT_MEM_CNTL) & ~(1 << 20);
+		OUTREG( EXT_MEM_CNTL, memRefreshCntl | (1 << 20));
  
-	/* Reset memory */
-	OUTREG( MEM_SDRAM_MODE_REG,
-		INREG( MEM_SDRAM_MODE_REG) & ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE); // Init  Not Complete
+		/* Reset memory */
+		OUTREG( MEM_SDRAM_MODE_REG,
+			INREG( MEM_SDRAM_MODE_REG)
+			& ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
 
-	/* DLL */
-	radeon_pm_enable_dll(rinfo);
+		/* DLL */
+		radeon_pm_enable_dll(rinfo);
 
-	// MLCK /YCLK sync 
-	radeon_pm_yclk_mclk_sync(rinfo);
+		/* MLCK / YCLK sync */
+		radeon_pm_yclk_mclk_sync(rinfo);
 
-       	/* M6, M7 and M9 so far ... */
-	if (rinfo->is_mobility && rinfo->family <= CHIP_FAMILY_RV250) {
+		/* Program Mode Register */
 		radeon_pm_program_mode_reg(rinfo, 0x2000, 1);   
 		radeon_pm_program_mode_reg(rinfo, 0x2001, 1);   
 		radeon_pm_program_mode_reg(rinfo, 0x2002, 1);   
 		radeon_pm_program_mode_reg(rinfo, 0x0132, 1);   
 		radeon_pm_program_mode_reg(rinfo, 0x0032, 1); 
-	}	
 
-	OUTREG( MEM_SDRAM_MODE_REG,
-		INREG( MEM_SDRAM_MODE_REG) |  MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE); // Init Complete
+		/* Complete & re-enable refresh */
+		OUTREG( MEM_SDRAM_MODE_REG,
+			INREG( MEM_SDRAM_MODE_REG) | MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+
+		OUTREG(EXT_MEM_CNTL, memRefreshCntl);
+	}
+	/* And finally, the M7..M9 models, including M9+ (RV280) */
+	else if (rinfo->is_mobility) {
 
-	OUTREG( MEM_REFRESH_CNTL, 	memRefreshCntl);
+		/* Disable refresh */
+		memRefreshCntl 	= INREG( MEM_REFRESH_CNTL)
+			& ~MEM_REFRESH_CNTL__MEM_REFRESH_DIS;
+		OUTREG( MEM_REFRESH_CNTL, memRefreshCntl
+			| MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+ 
+		/* Reset memory */
+		OUTREG( MEM_SDRAM_MODE_REG,
+			INREG( MEM_SDRAM_MODE_REG)
+			& ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+
+		/* DLL */
+		radeon_pm_enable_dll(rinfo);
+
+		/* MLCK / YCLK sync */
+		radeon_pm_yclk_mclk_sync(rinfo);
+
+		/* M6, M7 and M9 so far ... */
+		if (rinfo->family <= CHIP_FAMILY_RV250) {
+			radeon_pm_program_mode_reg(rinfo, 0x2000, 1);   
+			radeon_pm_program_mode_reg(rinfo, 0x2001, 1);   
+			radeon_pm_program_mode_reg(rinfo, 0x2002, 1);   
+			radeon_pm_program_mode_reg(rinfo, 0x0132, 1);   
+			radeon_pm_program_mode_reg(rinfo, 0x0032, 1); 
+		}
+		/* M9+ (iBook G4) */
+		else if (rinfo->family == CHIP_FAMILY_RV280) {
+			radeon_pm_program_mode_reg(rinfo, 0x2000, 1);   
+			radeon_pm_program_mode_reg(rinfo, 0x0132, 1);   
+			radeon_pm_program_mode_reg(rinfo, 0x0032, 1); 
+		}
+
+		/* Complete & re-enable refresh */
+		OUTREG( MEM_SDRAM_MODE_REG,
+			INREG( MEM_SDRAM_MODE_REG) | MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+
+		OUTREG( MEM_REFRESH_CNTL, 	memRefreshCntl);
+	}
 
 	OUTREG( CRTC_GEN_CNTL, 		crtcGenCntl);
 	OUTREG( CRTC2_GEN_CNTL, 	crtcGenCntl2);
@@ -777,10 +1321,1076 @@
 	mdelay( 15);
 }
 
+#ifdef CONFIG_PPC_OF
+
+static void radeon_pm_reset_pad_ctlr_strength(struct radeonfb_info *rinfo)
+{
+	u32 tmp, tmp2;
+	int i,j;
+
+	/* Reset the PAD_CTLR_STRENGTH & wait for it to be stable */
+	INREG(PAD_CTLR_STRENGTH);
+	OUTREG(PAD_CTLR_STRENGTH, INREG(PAD_CTLR_STRENGTH) & ~PAD_MANUAL_OVERRIDE);
+	tmp = INREG(PAD_CTLR_STRENGTH);
+	for (i = j = 0; i < 65; ++i) {
+		mdelay(1);
+		tmp2 = INREG(PAD_CTLR_STRENGTH);
+		if (tmp != tmp2) {
+			tmp = tmp2;
+			i = 0;
+			j++;
+			if (j > 10) {
+				printk(KERN_WARNING "radeon: PAD_CTLR_STRENGTH doesn't "
+				       "stabilize !\n");
+				break;
+			}
+		}
+	}
+}
+
+static void radeon_pm_all_ppls_off(struct radeonfb_info *rinfo)
+{
+	u32 tmp;
+
+	tmp = INPLL(pllPPLL_CNTL);
+	OUTPLL(pllPPLL_CNTL, tmp | 0x3);
+	tmp = INPLL(pllP2PLL_CNTL);
+	OUTPLL(pllP2PLL_CNTL, tmp | 0x3);
+	tmp = INPLL(pllSPLL_CNTL);
+	OUTPLL(pllSPLL_CNTL, tmp | 0x3);
+	tmp = INPLL(pllMPLL_CNTL);
+	OUTPLL(pllMPLL_CNTL, tmp | 0x3);
+}
+
+static void radeon_pm_start_mclk_sclk(struct radeonfb_info *rinfo)
+{
+	u32 tmp;
+
+	/* Switch SPLL to PCI source */
+	tmp = INPLL(pllSCLK_CNTL);
+	OUTPLL(pllSCLK_CNTL, tmp & ~SCLK_CNTL__SCLK_SRC_SEL_MASK);
+
+	/* Reconfigure SPLL charge pump, VCO gain, duty cycle */
+	tmp = INPLL(pllSPLL_CNTL);
+	OUTREG8(CLOCK_CNTL_INDEX, pllSPLL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+
+	/* Set SPLL feedback divider */
+	tmp = INPLL(pllM_SPLL_REF_FB_DIV);
+	tmp = (tmp & 0xff00fffful) | (rinfo->save_regs[77] & 0x00ff0000ul);
+	OUTPLL(pllM_SPLL_REF_FB_DIV, tmp);
+
+	/* Power up SPLL */
+	tmp = INPLL(pllSPLL_CNTL);
+	OUTPLL(pllSPLL_CNTL, tmp & ~1);
+	(void)INPLL(pllSPLL_CNTL);
+
+	mdelay(10);
+
+	/* Release SPLL reset */
+	tmp = INPLL(pllSPLL_CNTL);
+	OUTPLL(pllSPLL_CNTL, tmp & ~0x2);
+	(void)INPLL(pllSPLL_CNTL);
+
+	mdelay(10);
+
+	/* Select SCLK source  */
+	tmp = INPLL(pllSCLK_CNTL);
+	tmp &= ~SCLK_CNTL__SCLK_SRC_SEL_MASK;
+	tmp |= rinfo->save_regs[3] & SCLK_CNTL__SCLK_SRC_SEL_MASK;
+	OUTPLL(pllSCLK_CNTL, tmp);
+	(void)INPLL(pllSCLK_CNTL);
+
+	mdelay(10);
+
+	/* Reconfigure MPLL charge pump, VCO gain, duty cycle */
+	tmp = INPLL(pllMPLL_CNTL);
+	OUTREG8(CLOCK_CNTL_INDEX, pllMPLL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+
+	/* Set MPLL feedback divider */
+	tmp = INPLL(pllM_SPLL_REF_FB_DIV);
+	tmp = (tmp & 0xffff00fful) | (rinfo->save_regs[77] & 0x0000ff00ul);
+
+	OUTPLL(pllM_SPLL_REF_FB_DIV, tmp);
+	/* Power up MPLL */
+	tmp = INPLL(pllMPLL_CNTL);
+	OUTPLL(pllMPLL_CNTL, tmp & ~0x2);
+	(void)INPLL(pllMPLL_CNTL);
+
+	mdelay(10);
+     
+	/* Un-reset MPLL */
+	tmp = INPLL(pllMPLL_CNTL);
+	OUTPLL(pllMPLL_CNTL, tmp & ~0x1);
+	(void)INPLL(pllMPLL_CNTL);
+
+	mdelay(10);
+
+	/* Select source for MCLK */
+	tmp = INPLL(pllMCLK_CNTL);
+	tmp |= rinfo->save_regs[2] & 0xffff;
+	OUTPLL(pllMCLK_CNTL, tmp);
+	(void)INPLL(pllMCLK_CNTL);
+
+	mdelay(10);
+}
+
+static void radeon_pm_m10_disable_spread_spectrum(struct radeonfb_info *rinfo)
+{
+	u32 r2ec;
+
+	/* GACK ! I though we didn't have a DDA on Radeon's anymore 
+	 * here we rewrite with the same value, ... I suppose we clear
+	 * some bits that are already clear ? Or maybe this 0x2ec
+	 * register is something new ?
+	 */
+	mdelay(20);
+	r2ec = INREG(VGA_DDA_ON_OFF);
+	OUTREG(VGA_DDA_ON_OFF, r2ec);
+	mdelay(1);
+
+	/* Spread spectrum PLLL off */
+	OUTPLL(pllSSPLL_CNTL, 0xbf03);
+
+	/* Spread spectrum disabled */
+	OUTPLL(pllSS_INT_CNTL, rinfo->save_regs[90] & ~3);
+
+	/* The trace shows read & rewrite of LVDS_PLL_CNTL here with same
+	 * value, not sure what for...
+	 */
+
+	r2ec |= 0x3f0;
+	OUTREG(VGA_DDA_ON_OFF, r2ec);
+	mdelay(1);
+}
+
+static void radeon_pm_m10_enable_lvds_spread_spectrum(struct radeonfb_info *rinfo)
+{
+	u32 r2ec, tmp;
+
+	/* GACK (bis) ! I though we didn't have a DDA on Radeon's anymore 
+	 * here we rewrite with the same value, ... I suppose we clear/set
+	 * some bits that are already clear/set ?
+	 */
+	r2ec = INREG(VGA_DDA_ON_OFF);
+	OUTREG(VGA_DDA_ON_OFF, r2ec);
+	mdelay(1);
+
+	/* Enable spread spectrum */
+	OUTPLL(pllSSPLL_CNTL, rinfo->save_regs[43] | 3);
+	mdelay(3);
+
+	OUTPLL(pllSSPLL_REF_DIV, rinfo->save_regs[44]);
+	OUTPLL(pllSSPLL_DIV_0, rinfo->save_regs[45]);
+	tmp = INPLL(pllSSPLL_CNTL);
+	OUTPLL(pllSSPLL_CNTL, tmp & ~0x2);
+	mdelay(6);
+	tmp = INPLL(pllSSPLL_CNTL);
+	OUTPLL(pllSSPLL_CNTL, tmp & ~0x1);
+	mdelay(5);
+
+       	OUTPLL(pllSS_INT_CNTL, rinfo->save_regs[90]);
+
+	r2ec |= 8;
+	OUTREG(VGA_DDA_ON_OFF, r2ec);
+	mdelay(20);
+
+	/* Enable LVDS interface */
+	tmp = INREG(LVDS_GEN_CNTL);
+	OUTREG(LVDS_GEN_CNTL, tmp | LVDS_EN);
+
+	/* Enable LVDS_PLL */
+	tmp = INREG(LVDS_PLL_CNTL);
+	tmp &= ~0x30000;
+	tmp |= 0x10000;
+	OUTREG(LVDS_PLL_CNTL, tmp);
+
+	OUTPLL(pllSCLK_MORE_CNTL, rinfo->save_regs[34]);
+	OUTPLL(pllSS_TST_CNTL, rinfo->save_regs[91]);
+
+	/* The trace reads that one here, waiting for something to settle down ? */
+	INREG(RBBM_STATUS); 
+
+	/* Ugh ? SS_TST_DEC is supposed to be a read register in the
+	 * R300 register spec at least...
+	 */
+	tmp = INPLL(pllSS_TST_CNTL);
+	tmp |= 0x00400000;
+	OUTPLL(pllSS_TST_CNTL, tmp);
+}
+
+static void radeon_pm_restore_pixel_pll(struct radeonfb_info *rinfo)
+{
+	u32 tmp;
+
+	OUTREG8(CLOCK_CNTL_INDEX, pllHTOTAL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA, 0);
+
+	tmp = INPLL(pllVCLK_ECP_CNTL);
+	OUTPLL(pllVCLK_ECP_CNTL, tmp | 0x80);
+	mdelay(5);
+
+	tmp = INPLL(pllPPLL_REF_DIV);
+	tmp = (tmp & ~PPLL_REF_DIV_MASK) | rinfo->pll.ref_div;
+	OUTPLL(pllPPLL_REF_DIV, tmp);
+	INPLL(pllPPLL_REF_DIV);
+
+	/* Reconfigure SPLL charge pump, VCO gain, duty cycle,
+	 * probably useless since we already did it ...
+	 */
+	tmp = INPLL(pllPPLL_CNTL);
+	OUTREG8(CLOCK_CNTL_INDEX, pllSPLL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+
+	/* Not sure what was intended here ... */
+	tmp = INREG(CLOCK_CNTL_INDEX);
+	OUTREG(CLOCK_CNTL_INDEX, tmp);
+
+	/* Restore our "reference" PPLL divider set by firmware
+	 * according to proper spread spectrum calculations
+	 */
+	OUTPLL(pllPPLL_DIV_0, rinfo->save_regs[92]);
+
+	tmp = INPLL(pllPPLL_CNTL);
+	OUTPLL(pllPPLL_CNTL, tmp & ~0x2);
+	mdelay(5);
+
+	tmp = INPLL(pllPPLL_CNTL);
+	OUTPLL(pllPPLL_CNTL, tmp & ~0x1);
+	mdelay(5);
+
+	tmp = INPLL(pllVCLK_ECP_CNTL);
+	OUTPLL(pllVCLK_ECP_CNTL, tmp | 3);
+	mdelay(5);
+
+	tmp = INPLL(pllVCLK_ECP_CNTL);
+	OUTPLL(pllVCLK_ECP_CNTL, tmp | 3);
+	mdelay(5);
+
+	/* Switch pixel clock to firmware default div 0 */
+	OUTREG8(CLOCK_CNTL_INDEX+1, 0);
+}
+
+static void radeon_pm_m10_reconfigure_mc(struct radeonfb_info *rinfo)
+{
+	OUTREG(MC_CNTL, rinfo->save_regs[46]);
+	OUTREG(MC_INIT_GFX_LAT_TIMER, rinfo->save_regs[47]);
+	OUTREG(MC_INIT_MISC_LAT_TIMER, rinfo->save_regs[48]);
+	OUTREG(MEM_SDRAM_MODE_REG,
+	       rinfo->save_regs[35] & ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+	OUTREG(MC_TIMING_CNTL, rinfo->save_regs[49]);
+	OUTREG(MEM_REFRESH_CNTL, rinfo->save_regs[42]);
+	OUTREG(MC_READ_CNTL_AB, rinfo->save_regs[50]);
+	OUTREG(MC_CHIP_IO_OE_CNTL_AB, rinfo->save_regs[52]);
+	OUTREG(MC_IOPAD_CNTL, rinfo->save_regs[51]);
+	OUTREG(MC_DEBUG, rinfo->save_regs[53]);
+
+	OUTMC(rinfo, ixR300_MC_MC_INIT_WR_LAT_TIMER, rinfo->save_regs[58]);
+	OUTMC(rinfo, ixR300_MC_IMP_CNTL, rinfo->save_regs[59]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_C0, rinfo->save_regs[60]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_C1, rinfo->save_regs[61]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_D0, rinfo->save_regs[62]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_D1, rinfo->save_regs[63]);
+	OUTMC(rinfo, ixR300_MC_BIST_CNTL_3, rinfo->save_regs[64]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_A0, rinfo->save_regs[65]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_A1, rinfo->save_regs[66]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_B0, rinfo->save_regs[67]);
+	OUTMC(rinfo, ixR300_MC_CHP_IO_CNTL_B1, rinfo->save_regs[68]);
+	OUTMC(rinfo, ixR300_MC_DEBUG_CNTL, rinfo->save_regs[69]);
+	OUTMC(rinfo, ixR300_MC_DLL_CNTL, rinfo->save_regs[70]);
+	OUTMC(rinfo, ixR300_MC_IMP_CNTL_0, rinfo->save_regs[71]);
+	OUTMC(rinfo, ixR300_MC_ELPIDA_CNTL, rinfo->save_regs[72]);
+	OUTMC(rinfo, ixR300_MC_READ_CNTL_CD, rinfo->save_regs[96]);
+	OUTREG(MC_IND_INDEX, 0);
+}
+
+static void radeon_reinitialize_M10(struct radeonfb_info *rinfo)
+{
+	u32 tmp, i;
+
+	/* Restore a bunch of registers first */
+	OUTREG(MC_AGP_LOCATION, rinfo->save_regs[32]);
+	OUTREG(DISPLAY_BASE_ADDR, rinfo->save_regs[31]);
+	OUTREG(CRTC2_DISPLAY_BASE_ADDR, rinfo->save_regs[33]);
+	OUTREG(MC_FB_LOCATION, rinfo->save_regs[30]);
+	OUTREG(OV0_BASE_ADDR, rinfo->save_regs[80]);
+	OUTREG(CONFIG_MEMSIZE, rinfo->video_ram);
+	OUTREG(BUS_CNTL, rinfo->save_regs[36]);	
+	OUTREG(BUS_CNTL1, rinfo->save_regs[14]);
+	OUTREG(MPP_TB_CONFIG, rinfo->save_regs[37]);
+	OUTREG(FCP_CNTL, rinfo->save_regs[38]);
+	OUTREG(RBBM_CNTL, rinfo->save_regs[39]);
+	OUTREG(DAC_CNTL, rinfo->save_regs[40]);
+	OUTREG(DAC_MACRO_CNTL, (INREG(DAC_MACRO_CNTL) & ~0x6) | 8);
+	OUTREG(DAC_MACRO_CNTL, (INREG(DAC_MACRO_CNTL) & ~0x6) | 8);
+
+	/* Hrm... */
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) | DAC2_EXPAND_MODE);
+
+	/* Reset the PAD CTLR */
+	radeon_pm_reset_pad_ctlr_strength(rinfo);
+       
+	/* Some PLLs are Read & written identically in the trace here...
+	 * I suppose it's actually to switch them all off & reset,
+	 * let's assume off is what we want. I'm just doing that for all major PLLs now.
+	 */
+	radeon_pm_all_ppls_off(rinfo);
+
+	/* Clear tiling, reset swappers */
+	INREG(SURFACE_CNTL);
+	OUTREG(SURFACE_CNTL, 0);
+
+	/* Some black magic with TV_DAC_CNTL, we should restore those from backups
+	 * rather than hard coding...
+	 */
+	tmp = INREG(TV_DAC_CNTL) & ~TV_DAC_CNTL_BGADJ_MASK;
+	tmp |= 8 << TV_DAC_CNTL_BGADJ__SHIFT;
+	OUTREG(TV_DAC_CNTL, tmp);
+
+	tmp = INREG(TV_DAC_CNTL) & ~TV_DAC_CNTL_DACADJ_MASK;
+	tmp |= 7 << TV_DAC_CNTL_DACADJ__SHIFT;
+	OUTREG(TV_DAC_CNTL, tmp);
+
+	/* More registers restored */
+	OUTREG(AGP_CNTL, rinfo->save_regs[16]);
+	OUTREG(HOST_PATH_CNTL, rinfo->save_regs[41]);
+	OUTREG(DISP_MISC_CNTL, rinfo->save_regs[9]);
+
+	/* Hrmmm ... What is that ? */
+	tmp = rinfo->save_regs[1]
+		& ~(CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT_MASK |
+		    CLK_PWRMGT_CNTL__MC_BUSY);
+	OUTPLL(pllCLK_PWRMGT_CNTL, tmp);
+
+	OUTREG(PAD_CTLR_MISC, rinfo->save_regs[56]);
+	OUTREG(FW_CNTL, rinfo->save_regs[57]);
+	OUTREG(HDP_DEBUG, rinfo->save_regs[96]);
+	OUTREG(PAMAC0_DLY_CNTL, rinfo->save_regs[54]);
+	OUTREG(PAMAC1_DLY_CNTL, rinfo->save_regs[55]);
+	OUTREG(PAMAC2_DLY_CNTL, rinfo->save_regs[79]);
+
+	/* Restore Memory Controller configuration */
+	radeon_pm_m10_reconfigure_mc(rinfo);
+
+	/* Make sure CRTC's dont touch memory */
+	OUTREG(CRTC_GEN_CNTL, INREG(CRTC_GEN_CNTL) 
+	       | CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B);
+	OUTREG(CRTC2_GEN_CNTL, INREG(CRTC2_GEN_CNTL)
+	       | CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B);
+	mdelay(30);
+      
+	/* Disable SDRAM refresh */
+	OUTREG(MEM_REFRESH_CNTL, INREG(MEM_REFRESH_CNTL)
+	       | MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+
+	/* Restore XTALIN routing (CLK_PIN_CNTL) */
+	OUTPLL(pllCLK_PIN_CNTL, rinfo->save_regs[4]);
+
+	/* Switch MCLK, YCLK and SCLK PLLs to PCI source & force them ON */
+	tmp = rinfo->save_regs[2] & 0xff000000;
+	tmp |=	MCLK_CNTL__FORCE_MCLKA |
+		MCLK_CNTL__FORCE_MCLKB |
+		MCLK_CNTL__FORCE_YCLKA |
+		MCLK_CNTL__FORCE_YCLKB |
+		MCLK_CNTL__FORCE_MC;
+	OUTPLL(pllMCLK_CNTL, tmp);
+
+	/* Force all clocks on in SCLK */
+	tmp = INPLL(pllSCLK_CNTL);
+	tmp |=	SCLK_CNTL__FORCE_DISP2|
+		SCLK_CNTL__FORCE_CP|
+		SCLK_CNTL__FORCE_HDP|
+		SCLK_CNTL__FORCE_DISP1|
+		SCLK_CNTL__FORCE_TOP|
+		SCLK_CNTL__FORCE_E2|
+		SCLK_CNTL__FORCE_SE|
+		SCLK_CNTL__FORCE_IDCT|
+		SCLK_CNTL__FORCE_VIP|
+		SCLK_CNTL__FORCE_PB|
+		SCLK_CNTL__FORCE_TAM|
+		SCLK_CNTL__FORCE_TDM|
+		SCLK_CNTL__FORCE_RB|
+		SCLK_CNTL__FORCE_TV_SCLK|
+		SCLK_CNTL__FORCE_SUBPIC|
+		SCLK_CNTL__FORCE_OV0;
+	tmp |=	SCLK_CNTL__CP_MAX_DYN_STOP_LAT  |
+		SCLK_CNTL__HDP_MAX_DYN_STOP_LAT |
+		SCLK_CNTL__TV_MAX_DYN_STOP_LAT  |
+		SCLK_CNTL__E2_MAX_DYN_STOP_LAT  |
+		SCLK_CNTL__SE_MAX_DYN_STOP_LAT  |
+		SCLK_CNTL__IDCT_MAX_DYN_STOP_LAT|
+		SCLK_CNTL__VIP_MAX_DYN_STOP_LAT |
+		SCLK_CNTL__RE_MAX_DYN_STOP_LAT  |
+		SCLK_CNTL__PB_MAX_DYN_STOP_LAT  |
+		SCLK_CNTL__TAM_MAX_DYN_STOP_LAT |
+		SCLK_CNTL__TDM_MAX_DYN_STOP_LAT |
+		SCLK_CNTL__RB_MAX_DYN_STOP_LAT;
+	OUTPLL(pllSCLK_CNTL, tmp);
+
+	OUTPLL(pllVCLK_ECP_CNTL, 0);
+	OUTPLL(pllPIXCLKS_CNTL, 0);
+	OUTPLL(pllMCLK_MISC,
+	       MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT |
+	       MCLK_MISC__IO_MCLK_MAX_DYN_STOP_LAT);
+
+	mdelay(5);
+
+	/* Restore the M_SPLL_REF_FB_DIV, MPLL_AUX_CNTL and SPLL_AUX_CNTL values */
+	OUTPLL(pllM_SPLL_REF_FB_DIV, rinfo->save_regs[77]);
+	OUTPLL(pllMPLL_AUX_CNTL, rinfo->save_regs[75]);
+	OUTPLL(pllSPLL_AUX_CNTL, rinfo->save_regs[76]);
+	
+	/* Now restore the major PLLs settings, keeping them off & reset though */
+	OUTPLL(pllPPLL_CNTL, rinfo->save_regs[93] | 0x3);
+	OUTPLL(pllP2PLL_CNTL, rinfo->save_regs[8] | 0x3);
+	OUTPLL(pllMPLL_CNTL, rinfo->save_regs[73] | 0x03);
+	OUTPLL(pllSPLL_CNTL, rinfo->save_regs[74] | 0x03);
+
+	/* Restore MC DLL state and switch it off/reset too  */ 
+	OUTMC(rinfo, ixR300_MC_DLL_CNTL, rinfo->save_regs[70]);
+
+	/* Switch MDLL off & reset */
+	OUTPLL(pllMDLL_RDCKA, rinfo->save_regs[98] | 0xff);
+	mdelay(5);
+
+	/* Setup some black magic bits in PLL_PWRMGT_CNTL. Hrm... we saved
+	 * 0xa1100007... and MacOS writes 0xa1000007 ..
+	 */
+	OUTPLL(pllPLL_PWRMGT_CNTL, rinfo->save_regs[0]);
+
+	/* Restore more stuffs */
+	OUTPLL(pllHTOTAL_CNTL, 0);
+	OUTPLL(pllHTOTAL2_CNTL, 0);
+
+	/* More PLL initial configuration */
+	tmp = INPLL(pllSCLK_CNTL2); /* What for ? */
+	OUTPLL(pllSCLK_CNTL2, tmp);
+
+	tmp = INPLL(pllSCLK_MORE_CNTL);
+	tmp |= 	SCLK_MORE_CNTL__FORCE_DISPREGS |	/* a guess */
+		SCLK_MORE_CNTL__FORCE_MC_GUI |
+		SCLK_MORE_CNTL__FORCE_MC_HOST;
+	OUTPLL(pllSCLK_MORE_CNTL, tmp);
+
+	/* Now we actually start MCLK and SCLK */
+	radeon_pm_start_mclk_sclk(rinfo);
+
+	/* Full reset sdrams, this also re-inits the MDLL */
+	radeon_pm_full_reset_sdram(rinfo);
+
+	/* Fill palettes */
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) | 0x20);	
+	for (i=0; i<256; i++)
+		OUTREG(PALETTE_30_DATA, 0x15555555);
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) & ~20);
+	udelay(20);
+	for (i=0; i<256; i++)
+		OUTREG(PALETTE_30_DATA, 0x15555555);
+
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) & ~0x20);
+	mdelay(3);
+
+	/* Restore TMDS */
+	OUTREG(FP_GEN_CNTL, rinfo->save_regs[82]);
+	OUTREG(FP2_GEN_CNTL, rinfo->save_regs[83]);
+
+	/* Set LVDS registers but keep interface & pll down */
+	OUTREG(LVDS_GEN_CNTL, rinfo->save_regs[11] &
+	       ~(LVDS_EN | LVDS_ON | LVDS_DIGON | LVDS_BLON | LVDS_BL_MOD_EN));
+	OUTREG(LVDS_PLL_CNTL, (rinfo->save_regs[12] & ~0xf0000) | 0x20000);
+
+	OUTREG(DISP_OUTPUT_CNTL, rinfo->save_regs[86]);
+
+	/* Restore GPIOPAD state */
+	OUTREG(GPIOPAD_A, rinfo->save_regs[19]);
+	OUTREG(GPIOPAD_EN, rinfo->save_regs[20]);
+	OUTREG(GPIOPAD_MASK, rinfo->save_regs[21]);
+
+	/* write some stuff to the framebuffer... */
+	for (i = 0; i < 0x8000; ++i)
+		writeb(0, rinfo->fb_base + i);
+	
+	mdelay(40);
+	OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) | LVDS_DIGON | LVDS_ON);
+	mdelay(40);
+
+	/* Restore a few more things */
+	OUTREG(GRPH_BUFFER_CNTL, rinfo->save_regs[94]);
+	OUTREG(GRPH2_BUFFER_CNTL, rinfo->save_regs[95]);
+
+	/* Take care of spread spectrum & PPLLs now */
+	radeon_pm_m10_disable_spread_spectrum(rinfo);
+	radeon_pm_restore_pixel_pll(rinfo);
+
+	/* GRRRR... I can't figure out the proper LVDS power sequence, and the
+	 * code I have for blank/unblank doesn't quite work on some laptop models
+	 * it seems ... Hrm. What I have here works most of the time ...
+	 */
+	radeon_pm_m10_enable_lvds_spread_spectrum(rinfo);
+}
+
+static void radeon_pm_m9p_reconfigure_mc(struct radeonfb_info *rinfo)
+{
+	OUTREG(MC_CNTL, rinfo->save_regs[46]);
+	OUTREG(MC_INIT_GFX_LAT_TIMER, rinfo->save_regs[47]);
+	OUTREG(MC_INIT_MISC_LAT_TIMER, rinfo->save_regs[48]);
+	OUTREG(MEM_SDRAM_MODE_REG,
+	       rinfo->save_regs[35] & ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE);
+	OUTREG(MC_TIMING_CNTL, rinfo->save_regs[49]);
+	OUTREG(MC_READ_CNTL_AB, rinfo->save_regs[50]);
+	OUTREG(MEM_REFRESH_CNTL, rinfo->save_regs[42]);
+	OUTREG(MC_IOPAD_CNTL, rinfo->save_regs[51]);
+	OUTREG(MC_DEBUG, rinfo->save_regs[53]);
+	OUTREG(MC_CHIP_IO_OE_CNTL_AB, rinfo->save_regs[52]);
+
+	OUTMC(rinfo, ixMC_IMP_CNTL, rinfo->save_regs[59] /*0x00f460d6*/);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_A0, rinfo->save_regs[65] /*0xfecfa666*/);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_A1, rinfo->save_regs[66] /*0x141555ff*/);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_B0, rinfo->save_regs[67] /*0xfecfa666*/);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_B1, rinfo->save_regs[68] /*0x141555ff*/);
+	OUTMC(rinfo, ixMC_IMP_CNTL_0, rinfo->save_regs[71] /*0x00009249*/);
+	OUTREG(MC_IND_INDEX, 0);
+	OUTREG(CONFIG_MEMSIZE, rinfo->video_ram);
+
+	mdelay(20);
+}
+
+static void radeon_reinitialize_M9P(struct radeonfb_info *rinfo)
+{
+	u32 tmp, i;
+	
+	/* Restore a bunch of registers first */
+	OUTREG(SURFACE_CNTL, rinfo->save_regs[29]);
+	OUTREG(MC_AGP_LOCATION, rinfo->save_regs[32]);
+	OUTREG(DISPLAY_BASE_ADDR, rinfo->save_regs[31]);
+	OUTREG(CRTC2_DISPLAY_BASE_ADDR, rinfo->save_regs[33]);
+	OUTREG(MC_FB_LOCATION, rinfo->save_regs[30]);
+	OUTREG(OV0_BASE_ADDR, rinfo->save_regs[80]);
+	OUTREG(BUS_CNTL, rinfo->save_regs[36]);
+	OUTREG(BUS_CNTL1, rinfo->save_regs[14]);
+	OUTREG(MPP_TB_CONFIG, rinfo->save_regs[37]);
+	OUTREG(FCP_CNTL, rinfo->save_regs[38]);
+	OUTREG(RBBM_CNTL, rinfo->save_regs[39]);
+
+	OUTREG(DAC_CNTL, rinfo->save_regs[40]);
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) | DAC2_EXPAND_MODE);
+
+	/* Reset the PAD CTLR */
+	radeon_pm_reset_pad_ctlr_strength(rinfo);
+
+	/* Some PLLs are Read & written identically in the trace here...
+	 * I suppose it's actually to switch them all off & reset,
+	 * let's assume off is what we want. I'm just doing that for all major PLLs now.
+	 */
+	radeon_pm_all_ppls_off(rinfo);
+
+	/* Clear tiling, reset swappers */
+	INREG(SURFACE_CNTL);
+	OUTREG(SURFACE_CNTL, 0);
+
+	/* Some black magic with TV_DAC_CNTL, we should restore those from backups
+	 * rather than hard coding...
+	 */
+	tmp = INREG(TV_DAC_CNTL) & ~TV_DAC_CNTL_BGADJ_MASK;
+	tmp |= 6 << TV_DAC_CNTL_BGADJ__SHIFT;
+	OUTREG(TV_DAC_CNTL, tmp);
+
+	tmp = INREG(TV_DAC_CNTL) & ~TV_DAC_CNTL_DACADJ_MASK;
+	tmp |= 6 << TV_DAC_CNTL_DACADJ__SHIFT;
+	OUTREG(TV_DAC_CNTL, tmp);
+	
+	OUTPLL(pllAGP_PLL_CNTL, rinfo->save_regs[78]);
+
+	OUTREG(PAMAC0_DLY_CNTL, rinfo->save_regs[54]);
+	OUTREG(PAMAC1_DLY_CNTL, rinfo->save_regs[55]);
+	OUTREG(PAMAC2_DLY_CNTL, rinfo->save_regs[79]);
+
+	OUTREG(AGP_CNTL, rinfo->save_regs[16]);
+	OUTREG(HOST_PATH_CNTL, rinfo->save_regs[41]); /* MacOS sets that to 0 !!! */
+	OUTREG(DISP_MISC_CNTL, rinfo->save_regs[9]);
+
+	tmp  = rinfo->save_regs[1]
+		& ~(CLK_PWRMGT_CNTL__ACTIVE_HILO_LAT_MASK |
+		    CLK_PWRMGT_CNTL__MC_BUSY);
+	OUTPLL(pllCLK_PWRMGT_CNTL, tmp);
+
+	OUTREG(FW_CNTL, rinfo->save_regs[57]);
+
+	/* Disable SDRAM refresh */
+	OUTREG(MEM_REFRESH_CNTL, INREG(MEM_REFRESH_CNTL)
+	       | MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+
+	/* Restore XTALIN routing (CLK_PIN_CNTL) */
+       	OUTPLL(pllCLK_PIN_CNTL, rinfo->save_regs[4]);
+
+	/* Force MCLK to be PCI sourced and forced ON */
+	tmp = rinfo->save_regs[2] & 0xff000000;
+	tmp |=	MCLK_CNTL__FORCE_MCLKA |
+		MCLK_CNTL__FORCE_MCLKB |
+		MCLK_CNTL__FORCE_YCLKA |
+		MCLK_CNTL__FORCE_YCLKB |
+		MCLK_CNTL__FORCE_MC    |
+		MCLK_CNTL__FORCE_AIC;
+	OUTPLL(pllMCLK_CNTL, tmp);
+
+	/* Force SCLK to be PCI sourced with a bunch forced */
+	tmp =	0 |
+		SCLK_CNTL__FORCE_DISP2|
+		SCLK_CNTL__FORCE_CP|
+		SCLK_CNTL__FORCE_HDP|
+		SCLK_CNTL__FORCE_DISP1|
+		SCLK_CNTL__FORCE_TOP|
+		SCLK_CNTL__FORCE_E2|
+		SCLK_CNTL__FORCE_SE|
+		SCLK_CNTL__FORCE_IDCT|
+		SCLK_CNTL__FORCE_VIP|
+		SCLK_CNTL__FORCE_RE|
+		SCLK_CNTL__FORCE_PB|
+		SCLK_CNTL__FORCE_TAM|
+		SCLK_CNTL__FORCE_TDM|
+		SCLK_CNTL__FORCE_RB;
+	OUTPLL(pllSCLK_CNTL, tmp);
+
+	/* Clear VCLK_ECP_CNTL & PIXCLKS_CNTL  */
+	OUTPLL(pllVCLK_ECP_CNTL, 0);
+	OUTPLL(pllPIXCLKS_CNTL, 0);
+
+	/* Setup MCLK_MISC, non dynamic mode */
+	OUTPLL(pllMCLK_MISC,
+	       MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT |
+	       MCLK_MISC__IO_MCLK_MAX_DYN_STOP_LAT);
+
+	mdelay(5);
+
+	/* Set back the default clock dividers */
+	OUTPLL(pllM_SPLL_REF_FB_DIV, rinfo->save_regs[77]);
+	OUTPLL(pllMPLL_AUX_CNTL, rinfo->save_regs[75]);
+	OUTPLL(pllSPLL_AUX_CNTL, rinfo->save_regs[76]);
+
+	/* PPLL and P2PLL default values & off */
+	OUTPLL(pllPPLL_CNTL, rinfo->save_regs[93] | 0x3);
+	OUTPLL(pllP2PLL_CNTL, rinfo->save_regs[8] | 0x3);
+
+	/* S and M PLLs are reset & off, configure them */
+	OUTPLL(pllMPLL_CNTL, rinfo->save_regs[73] | 0x03);
+	OUTPLL(pllSPLL_CNTL, rinfo->save_regs[74] | 0x03);
+
+	/* Default values for MDLL ... fixme */
+	OUTPLL(pllMDLL_CKO, 0x9c009c);
+	OUTPLL(pllMDLL_RDCKA, 0x08830883);
+	OUTPLL(pllMDLL_RDCKB, 0x08830883);
+	mdelay(5);
+
+	/* Restore PLL_PWRMGT_CNTL */ // XXXX
+	tmp = rinfo->save_regs[0];
+	tmp &= ~PLL_PWRMGT_CNTL_SU_SCLK_USE_BCLK;
+	tmp |= PLL_PWRMGT_CNTL_SU_MCLK_USE_BCLK;
+	OUTPLL(PLL_PWRMGT_CNTL,  tmp);
+	
+	/* Clear HTOTAL_CNTL & HTOTAL2_CNTL */
+	OUTPLL(pllHTOTAL_CNTL, 0);
+	OUTPLL(pllHTOTAL2_CNTL, 0);
+
+	/* All outputs off */
+	OUTREG(CRTC_GEN_CNTL, 0x04000000);
+	OUTREG(CRTC2_GEN_CNTL, 0x04000000);
+	OUTREG(FP_GEN_CNTL, 0x00004008);
+	OUTREG(FP2_GEN_CNTL, 0x00000008);
+	OUTREG(LVDS_GEN_CNTL, 0x08000008);
+
+	/* Restore Memory Controller configuration */
+	radeon_pm_m9p_reconfigure_mc(rinfo);
+
+	/* Now we actually start MCLK and SCLK */
+	radeon_pm_start_mclk_sclk(rinfo);
+
+	/* Full reset sdrams, this also re-inits the MDLL */
+	radeon_pm_full_reset_sdram(rinfo);
+
+	/* Fill palettes */
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) | 0x20);	
+	for (i=0; i<256; i++)
+		OUTREG(PALETTE_30_DATA, 0x15555555);
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) & ~20);
+	udelay(20);
+	for (i=0; i<256; i++)
+		OUTREG(PALETTE_30_DATA, 0x15555555);
+
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) & ~0x20);
+	mdelay(3);
+
+	/* Restore TV stuff, make sure TV DAC is down */
+	OUTREG(TV_MASTER_CNTL, rinfo->save_regs[88]);
+	OUTREG(TV_DAC_CNTL, rinfo->save_regs[13] | 0x07000000);
+
+	/* Restore GPIOS. MacOS does some magic here with one of the GPIO bits,
+	 * possibly related to the weird PLL related workarounds and to the
+	 * fact that CLK_PIN_CNTL is tweaked in ways I don't fully understand,
+	 * but we keep things the simple way here
+	 */
+	OUTREG(GPIOPAD_A, rinfo->save_regs[19]);
+	OUTREG(GPIOPAD_EN, rinfo->save_regs[20]);
+	OUTREG(GPIOPAD_MASK, rinfo->save_regs[21]);
+
+	/* Now do things with SCLK_MORE_CNTL. Force bits are already set, copy
+	 * high bits from backup
+	 */
+	tmp = INPLL(pllSCLK_MORE_CNTL) & 0x0000ffff;
+	tmp |= rinfo->save_regs[34] & 0xffff0000;
+	tmp |= SCLK_MORE_CNTL__FORCE_DISPREGS;
+	OUTPLL(pllSCLK_MORE_CNTL, tmp);
+
+	tmp = INPLL(pllSCLK_MORE_CNTL) & 0x0000ffff;
+	tmp |= rinfo->save_regs[34] & 0xffff0000;
+	tmp |= SCLK_MORE_CNTL__FORCE_DISPREGS;
+	OUTPLL(pllSCLK_MORE_CNTL, tmp);
+	
+	OUTREG(LVDS_GEN_CNTL, rinfo->save_regs[11] &
+	       ~(LVDS_EN | LVDS_ON | LVDS_DIGON | LVDS_BLON | LVDS_BL_MOD_EN));
+	OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) | LVDS_BLON);
+	OUTREG(LVDS_PLL_CNTL, (rinfo->save_regs[12] & ~0xf0000) | 0x20000);
+	mdelay(20);
+
+	/* write some stuff to the framebuffer... */
+	for (i = 0; i < 0x8000; ++i)
+		writeb(0, rinfo->fb_base + i);
+		
+	OUTREG(0x2ec, 0x6332a020);
+	OUTPLL(pllSSPLL_REF_DIV, rinfo->save_regs[44] /*0x3f */);
+	OUTPLL(pllSSPLL_DIV_0, rinfo->save_regs[45] /*0x000081bb */);
+	tmp = INPLL(pllSSPLL_CNTL);
+	tmp &= ~2;
+	OUTPLL(pllSSPLL_CNTL, tmp);
+	mdelay(6);
+	tmp &= ~1;
+	OUTPLL(pllSSPLL_CNTL, tmp);
+	mdelay(5);
+	tmp |= 3;
+	OUTPLL(pllSSPLL_CNTL, tmp);
+	mdelay(5);
+	
+	OUTPLL(pllSS_INT_CNTL, rinfo->save_regs[90] & ~3);/*0x0020300c*/
+	OUTREG(0x2ec, 0x6332a3f0);
+	mdelay(17);
+
+	OUTPLL(pllPPLL_REF_DIV, rinfo->pll.ref_div);;
+	OUTPLL(pllPPLL_DIV_0, rinfo->save_regs[92]);
+	
+	mdelay(40);
+	OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) | LVDS_DIGON | LVDS_ON);
+	mdelay(40);
+
+	/* Restore a few more things */
+	OUTREG(GRPH_BUFFER_CNTL, rinfo->save_regs[94]);
+	OUTREG(GRPH2_BUFFER_CNTL, rinfo->save_regs[95]);
+
+	/* Restore PPLL, spread spectrum & LVDS */
+	radeon_pm_m10_disable_spread_spectrum(rinfo);
+	radeon_pm_restore_pixel_pll(rinfo);
+	radeon_pm_m10_enable_lvds_spread_spectrum(rinfo);
+}
+
+#if 0 /* Not ready yet */
+static void radeon_reinitialize_QW(struct radeonfb_info *rinfo)
+{
+	int i;
+	u32 tmp, tmp2;
+	u32 cko, cka, ckb;
+	u32 cgc, cec, c2gc;
+
+	OUTREG(MC_AGP_LOCATION, rinfo->save_regs[32]);
+	OUTREG(DISPLAY_BASE_ADDR, rinfo->save_regs[31]);
+	OUTREG(CRTC2_DISPLAY_BASE_ADDR, rinfo->save_regs[33]);
+	OUTREG(MC_FB_LOCATION, rinfo->save_regs[30]);
+	OUTREG(BUS_CNTL, rinfo->save_regs[36]);
+	OUTREG(RBBM_CNTL, rinfo->save_regs[39]);
+
+	INREG(PAD_CTLR_STRENGTH);
+	OUTREG(PAD_CTLR_STRENGTH, INREG(PAD_CTLR_STRENGTH) & ~0x10000);
+	for (i = 0; i < 65; ++i) {
+		mdelay(1);
+		INREG(PAD_CTLR_STRENGTH);
+	}
+
+	OUTREG(DISP_TEST_DEBUG_CNTL, INREG(DISP_TEST_DEBUG_CNTL) | 0x10000000);
+	OUTREG(OV0_FLAG_CNTRL, INREG(OV0_FLAG_CNTRL) | 0x100);
+	OUTREG(CRTC_GEN_CNTL, INREG(CRTC_GEN_CNTL));
+	OUTREG(DAC_CNTL, 0xff00410a);
+	OUTREG(CRTC2_GEN_CNTL, INREG(CRTC2_GEN_CNTL));
+	OUTREG(DAC_CNTL2, INREG(DAC_CNTL2) | 0x4000);
+
+	OUTREG(SURFACE_CNTL, rinfo->save_regs[29]);
+	OUTREG(AGP_CNTL, rinfo->save_regs[16]);
+	OUTREG(HOST_PATH_CNTL, rinfo->save_regs[41]);
+	OUTREG(DISP_MISC_CNTL, rinfo->save_regs[9]);
+
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_A0, 0xf7bb4433);
+	OUTREG(MC_IND_INDEX, 0);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_B0, 0xf7bb4433);
+	OUTREG(MC_IND_INDEX, 0);
+
+	OUTREG(CRTC_MORE_CNTL, INREG(CRTC_MORE_CNTL));
+
+	tmp = INPLL(pllVCLK_ECP_CNTL);
+	OUTPLL(pllVCLK_ECP_CNTL, tmp);
+	tmp = INPLL(pllPIXCLKS_CNTL);
+	OUTPLL(pllPIXCLKS_CNTL, tmp);
+
+	OUTPLL(MCLK_CNTL, 0xaa3f0000);
+	OUTPLL(SCLK_CNTL, 0xffff0000);
+	OUTPLL(pllMPLL_AUX_CNTL, 6);
+	OUTPLL(pllSPLL_AUX_CNTL, 1);
+	OUTPLL(MDLL_CKO, 0x9f009f);
+	OUTPLL(MDLL_RDCKA, 0x830083);
+	OUTPLL(pllMDLL_RDCKB, 0x830083);
+	OUTPLL(PPLL_CNTL, 0xa433);
+	OUTPLL(P2PLL_CNTL, 0xa433);
+	OUTPLL(MPLL_CNTL, 0x0400a403);
+	OUTPLL(SPLL_CNTL, 0x0400a433);
+
+	tmp = INPLL(M_SPLL_REF_FB_DIV);
+	OUTPLL(M_SPLL_REF_FB_DIV, tmp);
+	tmp = INPLL(M_SPLL_REF_FB_DIV);
+	OUTPLL(M_SPLL_REF_FB_DIV, tmp | 0xc);
+	INPLL(M_SPLL_REF_FB_DIV);
+
+	tmp = INPLL(MPLL_CNTL);
+	OUTREG8(CLOCK_CNTL_INDEX, MPLL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+
+	tmp = INPLL(M_SPLL_REF_FB_DIV);
+	OUTPLL(M_SPLL_REF_FB_DIV, tmp | 0x5900);
+
+	tmp = INPLL(MPLL_CNTL);
+	OUTPLL(MPLL_CNTL, tmp & ~0x2);
+	mdelay(1);
+	tmp = INPLL(MPLL_CNTL);
+	OUTPLL(MPLL_CNTL, tmp & ~0x1);
+	mdelay(10);
+
+	OUTPLL(MCLK_CNTL, 0xaa3f1212);
+	mdelay(1);
+
+	INPLL(M_SPLL_REF_FB_DIV);
+	INPLL(MCLK_CNTL);
+	INPLL(M_SPLL_REF_FB_DIV);
+
+	tmp = INPLL(SPLL_CNTL);
+	OUTREG8(CLOCK_CNTL_INDEX, SPLL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+
+	tmp = INPLL(M_SPLL_REF_FB_DIV);
+	OUTPLL(M_SPLL_REF_FB_DIV, tmp | 0x780000);
+
+	tmp = INPLL(SPLL_CNTL);
+	OUTPLL(SPLL_CNTL, tmp & ~0x1);
+	mdelay(1);
+	tmp = INPLL(SPLL_CNTL);
+	OUTPLL(SPLL_CNTL, tmp & ~0x2);
+	mdelay(10);
+
+	tmp = INPLL(SCLK_CNTL);
+	OUTPLL(SCLK_CNTL, tmp | 2);
+	mdelay(1);
+
+	cko = INPLL(pllMDLL_CKO);
+	cka = INPLL(pllMDLL_RDCKA);
+	ckb = INPLL(pllMDLL_RDCKB);
+
+	cko &= ~(MDLL_CKO__MCKOA_SLEEP | MDLL_CKO__MCKOB_SLEEP);
+	OUTPLL(pllMDLL_CKO, cko);
+	mdelay(1);
+	cko &= ~(MDLL_CKO__MCKOA_RESET | MDLL_CKO__MCKOB_RESET);
+	OUTPLL(pllMDLL_CKO, cko);
+	mdelay(5);
+
+	cka &= ~(MDLL_RDCKA__MRDCKA0_SLEEP | MDLL_RDCKA__MRDCKA1_SLEEP);
+	OUTPLL(pllMDLL_RDCKA, cka);
+	mdelay(1);
+	cka &= ~(MDLL_RDCKA__MRDCKA0_RESET | MDLL_RDCKA__MRDCKA1_RESET);
+	OUTPLL(pllMDLL_RDCKA, cka);
+	mdelay(5);
+
+	ckb &= ~(MDLL_RDCKB__MRDCKB0_SLEEP | MDLL_RDCKB__MRDCKB1_SLEEP);
+	OUTPLL(pllMDLL_RDCKB, ckb);
+	mdelay(1);
+	ckb &= ~(MDLL_RDCKB__MRDCKB0_RESET | MDLL_RDCKB__MRDCKB1_RESET);
+	OUTPLL(pllMDLL_RDCKB, ckb);
+	mdelay(5);
+
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_A1, 0x151550ff);
+	OUTREG(MC_IND_INDEX, 0);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_B1, 0x151550ff);
+	OUTREG(MC_IND_INDEX, 0);
+	mdelay(1);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_A1, 0x141550ff);
+	OUTREG(MC_IND_INDEX, 0);
+	OUTMC(rinfo, ixMC_CHP_IO_CNTL_B1, 0x141550ff);
+	OUTREG(MC_IND_INDEX, 0);
+	mdelay(1);
+
+	OUTPLL(pllHTOTAL_CNTL, 0);
+	OUTPLL(pllHTOTAL2_CNTL, 0);
+
+	OUTREG(MEM_CNTL, 0x29002901);
+	OUTREG(MEM_SDRAM_MODE_REG, 0x45320032);	/* XXX use save_regs[35]? */
+	OUTREG(EXT_MEM_CNTL, 0x1a394333);
+	OUTREG(MEM_IO_CNTL_A1, 0x0aac0aac);
+	OUTREG(MEM_INIT_LATENCY_TIMER, 0x34444444);
+	OUTREG(MEM_REFRESH_CNTL, 0x1f1f7218);	/* XXX or save_regs[42]? */
+	OUTREG(MC_DEBUG, 0);
+	OUTREG(MEM_IO_OE_CNTL, 0x04300430);
+
+	OUTMC(rinfo, ixMC_IMP_CNTL, 0x00f460d6);
+	OUTREG(MC_IND_INDEX, 0);
+	OUTMC(rinfo, ixMC_IMP_CNTL_0, 0x00009249);
+	OUTREG(MC_IND_INDEX, 0);
+
+	OUTREG(CONFIG_MEMSIZE, rinfo->video_ram);
+
+	radeon_pm_full_reset_sdram(rinfo);
+
+	INREG(FP_GEN_CNTL);
+	OUTREG(TMDS_CNTL, 0x01000000);	/* XXX ? */
+	tmp = INREG(FP_GEN_CNTL);
+	tmp |= FP_CRTC_DONT_SHADOW_HEND | FP_CRTC_DONT_SHADOW_VPAR | 0x200;
+	OUTREG(FP_GEN_CNTL, tmp);
+
+	tmp = INREG(DISP_OUTPUT_CNTL);
+	tmp &= ~0x400;
+	OUTREG(DISP_OUTPUT_CNTL, tmp);
+
+	OUTPLL(CLK_PIN_CNTL, rinfo->save_regs[4]);
+	OUTPLL(CLK_PWRMGT_CNTL, rinfo->save_regs[1]);
+	OUTPLL(PLL_PWRMGT_CNTL, rinfo->save_regs[0]);
+
+	tmp = INPLL(MCLK_MISC);
+	tmp |= MCLK_MISC__MC_MCLK_DYN_ENABLE | MCLK_MISC__IO_MCLK_DYN_ENABLE;
+	OUTPLL(MCLK_MISC, tmp);
+
+	tmp = INPLL(SCLK_CNTL);
+	OUTPLL(SCLK_CNTL, tmp);
+
+	OUTREG(CRTC_MORE_CNTL, 0);
+	OUTREG8(CRTC_GEN_CNTL+1, 6);
+	OUTREG8(CRTC_GEN_CNTL+3, 1);
+	OUTREG(CRTC_PITCH, 32);
+
+	tmp = INPLL(VCLK_ECP_CNTL);
+	OUTPLL(VCLK_ECP_CNTL, tmp);
+
+	tmp = INPLL(PPLL_CNTL);
+	OUTPLL(PPLL_CNTL, tmp);
+
+	/* palette stuff and BIOS_1_SCRATCH... */
+
+	tmp = INREG(FP_GEN_CNTL);
+	tmp2 = INREG(TMDS_TRANSMITTER_CNTL);
+	tmp |= 2;
+	OUTREG(FP_GEN_CNTL, tmp);
+	mdelay(5);
+	OUTREG(FP_GEN_CNTL, tmp);
+	mdelay(5);
+	OUTREG(TMDS_TRANSMITTER_CNTL, tmp2);
+	OUTREG(CRTC_MORE_CNTL, 0);
+	mdelay(20);
+
+	tmp = INREG(CRTC_MORE_CNTL);
+	OUTREG(CRTC_MORE_CNTL, tmp);
+
+	cgc = INREG(CRTC_GEN_CNTL);
+	cec = INREG(CRTC_EXT_CNTL);
+	c2gc = INREG(CRTC2_GEN_CNTL);
+
+	OUTREG(CRTC_H_SYNC_STRT_WID, 0x008e0580);
+	OUTREG(CRTC_H_TOTAL_DISP, 0x009f00d2);
+	OUTREG8(CLOCK_CNTL_INDEX, HTOTAL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA, 0);
+	OUTREG(CRTC_V_SYNC_STRT_WID, 0x00830403);
+	OUTREG(CRTC_V_TOTAL_DISP, 0x03ff0429);
+	OUTREG(FP_CRTC_H_TOTAL_DISP, 0x009f0033);
+	OUTREG(FP_H_SYNC_STRT_WID, 0x008e0080);
+	OUTREG(CRT_CRTC_H_SYNC_STRT_WID, 0x008e0080);
+	OUTREG(FP_CRTC_V_TOTAL_DISP, 0x03ff002a);
+	OUTREG(FP_V_SYNC_STRT_WID, 0x00830004);
+	OUTREG(CRT_CRTC_V_SYNC_STRT_WID, 0x00830004);
+	OUTREG(FP_HORZ_VERT_ACTIVE, 0x009f03ff);
+	OUTREG(FP_HORZ_STRETCH, 0);
+	OUTREG(FP_VERT_STRETCH, 0);
+	OUTREG(OVR_CLR, 0);
+	OUTREG(OVR_WID_LEFT_RIGHT, 0);
+	OUTREG(OVR_WID_TOP_BOTTOM, 0);
+
+	tmp = INPLL(PPLL_REF_DIV);
+	tmp = (tmp & ~PPLL_REF_DIV_MASK) | rinfo->pll.ref_div;
+	OUTPLL(PPLL_REF_DIV, tmp);
+	INPLL(PPLL_REF_DIV);
+
+	OUTREG8(CLOCK_CNTL_INDEX, PPLL_CNTL + PLL_WR_EN);
+	OUTREG8(CLOCK_CNTL_DATA + 1, 0xbc);
+
+	tmp = INREG(CLOCK_CNTL_INDEX);
+	OUTREG(CLOCK_CNTL_INDEX, tmp & 0xff);
+
+	OUTPLL(PPLL_DIV_0, 0x48090);
+
+	tmp = INPLL(PPLL_CNTL);
+	OUTPLL(PPLL_CNTL, tmp & ~0x2);
+	mdelay(1);
+	tmp = INPLL(PPLL_CNTL);
+	OUTPLL(PPLL_CNTL, tmp & ~0x1);
+	mdelay(10);
+
+	tmp = INPLL(VCLK_ECP_CNTL);
+	OUTPLL(VCLK_ECP_CNTL, tmp | 3);
+	mdelay(1);
+
+	tmp = INPLL(VCLK_ECP_CNTL);
+	OUTPLL(VCLK_ECP_CNTL, tmp);
+
+	c2gc |= CRTC2_DISP_REQ_EN_B;
+	OUTREG(CRTC2_GEN_CNTL, c2gc);
+	cgc |= CRTC_EN;
+	OUTREG(CRTC_GEN_CNTL, cgc);
+	OUTREG(CRTC_EXT_CNTL, cec);
+	OUTREG(CRTC_PITCH, 0xa0);
+	OUTREG(CRTC_OFFSET, 0);
+	OUTREG(CRTC_OFFSET_CNTL, 0);
+
+	OUTREG(GRPH_BUFFER_CNTL, 0x20117c7c);
+	OUTREG(GRPH2_BUFFER_CNTL, 0x00205c5c);
+
+	tmp2 = INREG(FP_GEN_CNTL);
+	tmp = INREG(TMDS_TRANSMITTER_CNTL);
+	OUTREG(0x2a8, 0x0000061b);
+	tmp |= TMDS_PLL_EN;
+	OUTREG(TMDS_TRANSMITTER_CNTL, tmp);
+	mdelay(1);
+	tmp &= ~TMDS_PLLRST;
+	OUTREG(TMDS_TRANSMITTER_CNTL, tmp);
+	tmp2 &= ~2;
+	tmp2 |= FP_TMDS_EN;
+	OUTREG(FP_GEN_CNTL, tmp2);
+	mdelay(5);
+	tmp2 |= FP_FPON;
+	OUTREG(FP_GEN_CNTL, tmp2);
+
+	OUTREG(CUR_HORZ_VERT_OFF, CUR_LOCK | 1);
+	cgc = INREG(CRTC_GEN_CNTL);
+	OUTREG(CUR_HORZ_VERT_POSN, 0xbfff0fff);
+	cgc |= 0x10000;
+	OUTREG(CUR_OFFSET, 0);
+}
+#endif /* 0 */
+
+#endif /* CONFIG_PPC_OF */
+
 static void radeon_set_suspend(struct radeonfb_info *rinfo, int suspend)
 {
 	u16 pwr_cmd;
 	u32 tmp;
+	int i;
 
 	if (!rinfo->pm_reg)
 		return;
@@ -796,13 +2406,13 @@
 		 * duration of the suspend/resume process
 		 */
 		radeon_pm_disable_dynamic_mode(rinfo);
+
 		/* Save some registers */
-		radeon_pm_save_regs(rinfo);
+		radeon_pm_save_regs(rinfo, 0);
 
-		/* Prepare mobility chips for suspend. Only do that on <= RV250 chips that
-		 * have been tested
+		/* Prepare mobility chips for suspend.
 		 */
-		if (rinfo->is_mobility && rinfo->family <= CHIP_FAMILY_RV250) {
+		if (rinfo->is_mobility) {
 			/* Program V2CLK */
 			radeon_pm_program_v2clk(rinfo);
 		
@@ -815,13 +2425,22 @@
 			/* Prepare chip for power management */
 			radeon_pm_setup_for_suspend(rinfo);
 
-			/* Reset the MDLL */
-			/* because both INPLL and OUTPLL take the same lock, that's why. */
-			tmp = INPLL( pllMDLL_CKO) | MDLL_CKO__MCKOA_RESET | MDLL_CKO__MCKOB_RESET;
-			OUTPLL( pllMDLL_CKO, tmp );
+			if (rinfo->family <= CHIP_FAMILY_RV280) {
+				/* Reset the MDLL */
+				/* because both INPLL and OUTPLL take the same
+				 * lock, that's why. */
+				tmp = INPLL( pllMDLL_CKO) | MDLL_CKO__MCKOA_RESET
+					| MDLL_CKO__MCKOB_RESET;
+				OUTPLL( pllMDLL_CKO, tmp );
+			}
 		}
 
+		for (i = 0; i < 64; ++i)
+			pci_read_config_dword(rinfo->pdev, i * 4,
+					      &rinfo->cfg_save[i]);
+
 		/* Switch PCI power managment to D2. */
+		pci_disable_device(rinfo->pdev);
 		for (;;) {
 			pci_read_config_word(
 				rinfo->pdev, rinfo->pm_reg+PCI_PM_CTRL,
@@ -841,37 +2460,74 @@
 		pci_write_config_word(rinfo->pdev, rinfo->pm_reg+PCI_PM_CTRL, 0);
 		mdelay(500);
 
-		/* Reset the SDRAM controller  */
-       		radeon_pm_full_reset_sdram(rinfo);
-		
-		/* Restore some registers */
-		radeon_pm_restore_regs(rinfo);
-		radeon_pm_enable_dynamic_mode(rinfo);
+		if (rinfo->family <= CHIP_FAMILY_RV250) {
+			/* Reset the SDRAM controller  */
+			radeon_pm_full_reset_sdram(rinfo);
+
+			/* Restore some registers */
+			radeon_pm_restore_regs(rinfo);
+		} else {
+			/* Restore registers first */
+			radeon_pm_restore_regs(rinfo);
+			/* init sdram controller */
+			radeon_pm_full_reset_sdram(rinfo);
+		}
 	}
 }
 
+static int radeon_restore_pci_cfg(struct radeonfb_info *rinfo)
+{
+	int i;
+	static u32 radeon_cfg_after_resume[64];
+
+	for (i = 0; i < 64; ++i)
+		pci_read_config_dword(rinfo->pdev, i * 4,
+				      &radeon_cfg_after_resume[i]);
+
+	if (radeon_cfg_after_resume[PCI_BASE_ADDRESS_0/4]
+	    == rinfo->cfg_save[PCI_BASE_ADDRESS_0/4])
+		return 0;	/* assume everything is ok */
+
+	for (i = PCI_BASE_ADDRESS_0/4; i < 64; ++i) {
+		if (radeon_cfg_after_resume[i] != rinfo->cfg_save[i])
+			pci_write_config_dword(rinfo->pdev, i * 4,
+					       rinfo->cfg_save[i]);
+	}
+	pci_write_config_word(rinfo->pdev, PCI_CACHE_LINE_SIZE,
+			      rinfo->cfg_save[PCI_CACHE_LINE_SIZE/4]);
+	pci_write_config_word(rinfo->pdev, PCI_COMMAND,
+			      rinfo->cfg_save[PCI_COMMAND/4]);
+	return 1;
+}
+
+
+static/*extern*/ int susdisking = 0;
+
 int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
+	int i;
 
-	/* We don't do anything but D2, for now we return 0, but
-	 * we may want to change that. How do we know if the BIOS
-	 * can properly take care of D3 ? Also, with swsusp, we
-	 * know we'll be rebooted, ...
-	 */
+	if (state == pdev->dev.power.power_state)
+		return 0;
 
-	printk(KERN_DEBUG "radeonfb: suspending to state: %d...\n", state);
-	
-	acquire_console_sem();
+	printk(KERN_DEBUG "radeonfb (%s): suspending to state: %d...\n",
+	       pci_name(pdev), state);
 
-	/* Userland should do this but doesn't... bridge gets suspended
-	 * too late. Unfortunately, that works only when AGP is built-in,
-	 * not for a module.
+	/* For suspend-to-disk, we cheat here. We don't suspend anything and
+	 * let fbcon continue drawing until we are all set. That shouldn't
+	 * really cause any problem at this point, provided that the wakeup
+	 * code knows that any state in memory may not match the HW
 	 */
-#ifdef CONFIG_AGP
-	agp_enable(0);
-#endif
+	if (state != PM_SUSPEND_MEM)
+		goto done;
+	if (susdisking) {
+		printk("suspending to disk but state = %d\n", state);
+		goto done;
+	}
+
+	acquire_console_sem();
 
 	fb_set_suspend(info, 1);
 
@@ -883,21 +2539,52 @@
 	}
 
 	/* Blank display and LCD */
-	radeonfb_blank(VESA_POWERDOWN, info);
+	radeon_screen_blank(rinfo, FB_BLANK_POWERDOWN, 1);
 
 	/* Sleep */
 	rinfo->asleep = 1;
 	rinfo->lock_blank = 1;
+	del_timer_sync(&rinfo->lvds_timer);
 
-	/* Suspend the chip to D2 state when supported
+	/* If we support wakeup from poweroff, we save all regs we can including cfg
+	 * space
 	 */
-#ifdef CONFIG_RADEON_HAS_D2
-	if (radeon_suspend_to_d2(rinfo, state))
+	if (rinfo->pm_mode & radeon_pm_off) {
+		/* Always disable dynamic clocks or weird things are happening when
+		 * the chip goes off (basically the panel doesn't shut down properly
+		 * and we crash on wakeup),
+		 * also, we want the saved regs context to have no dynamic clocks in
+		 * it, we'll restore the dynamic clocks state on wakeup
+		 */
+		radeon_pm_disable_dynamic_mode(rinfo);
+		mdelay(50);
+		radeon_pm_save_regs(rinfo, 1);
+
+		if (rinfo->is_mobility && !(rinfo->pm_mode & radeon_pm_d2)) {
+			/* Switch off LVDS interface */
+			mdelay(1);
+			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_BL_MOD_EN));
+			mdelay(1);
+			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_EN | LVDS_ON));
+			OUTREG(LVDS_PLL_CNTL, (INREG(LVDS_PLL_CNTL) & ~30000) | 0x20000);
+			mdelay(20);
+			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_DIGON));
+
+			// FIXME: Use PCI layer
+			for (i = 0; i < 64; ++i)
+				pci_read_config_dword(rinfo->pdev, i * 4,
+						      &rinfo->cfg_save[i]);
+		}
+	}
+	/* If we support D2, we go to it (should be fixed later with a flag forcing
+	 * D3 only for some laptops)
+	 */
+	if (rinfo->pm_mode & radeon_pm_d2)
 		radeon_set_suspend(rinfo, 1);
-#endif /* CONFIG_RADEON_HAS_D2 */
 
 	release_console_sem();
 
+ done:
 	pdev->dev.power.power_state = state;
 
 	return 0;
@@ -907,22 +2594,59 @@
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
+	int rc = 0;
 
 	if (pdev->dev.power.power_state == 0)
 		return 0;
 
-	acquire_console_sem();
+	if (rinfo->no_schedule) {
+		if (try_acquire_console_sem())
+			return 0;
+	} else
+		acquire_console_sem();
+
+	printk(KERN_DEBUG "radeonfb (%s): resuming from state: %d...\n",
+	       pci_name(pdev), pdev->dev.power.power_state);
+
 
-	/* Wakeup chip */
-#ifdef CONFIG_RADEON_HAS_D2
-	if (radeon_suspend_to_d2(rinfo, 0))
-		radeon_set_suspend(rinfo, 0);
-#endif /* CONFIG_RADEON_HAS_D2 */
+	if (pci_enable_device(pdev)) {
+		rc = -ENODEV;
+		printk(KERN_ERR "radeonfb (%s): can't enable PCI device !\n",
+		       pci_name(pdev));
+		goto bail;
+	}
+	pci_set_master(pdev);
+
+	if (pdev->dev.power.power_state == PM_SUSPEND_MEM) {
+		/* Wakeup chip. Check from config space if we were powered off
+		 * (todo: additionally, check CLK_PIN_CNTL too)
+		 */
+		if ((rinfo->pm_mode & radeon_pm_off) && radeon_restore_pci_cfg(rinfo)) {
+			if (rinfo->reinit_func != NULL)
+				rinfo->reinit_func(rinfo);
+			else {
+				printk(KERN_ERR "radeonfb (%s): can't resume radeon from"
+				       " D3 cold, need softboot !", pci_name(pdev));
+				rc = -EIO;
+				goto bail;
+			}
+		}
+		/* If we support D2, try to resume... we should check what was our
+		 * state though... (were we really in D2 state ?). Right now, this code
+		 * is only enable on Macs so it's fine.
+		 */
+		else if (rinfo->pm_mode & radeon_pm_d2)
+			radeon_set_suspend(rinfo, 0);
 
-	rinfo->asleep = 0;
+		rinfo->asleep = 0;
+	} else
+		radeon_engine_idle();
 
 	/* Restore display & engine */
-	radeonfb_set_par(info);
+	radeon_write_mode (rinfo, &rinfo->state, 1);
+	if (!(info->flags & FBINFO_HWACCEL_DISABLED))
+		radeonfb_engine_init (rinfo);
+
 	fb_pan_display(info, &info->var);
 	fb_set_cmap(&info->cmap, info);
 
@@ -931,15 +2655,105 @@
 
 	/* Unblank */
 	rinfo->lock_blank = 0;
-	radeonfb_blank(0, info);
+	radeon_screen_blank(rinfo, FB_BLANK_UNBLANK, 1);
 
-	release_console_sem();
+	/* Check status of dynclk */
+	if (rinfo->dynclk == 1)
+		radeon_pm_enable_dynamic_mode(rinfo);
+	else if (rinfo->dynclk == 0)
+		radeon_pm_disable_dynamic_mode(rinfo);
 
 	pdev->dev.power.power_state = 0;
 
-	printk(KERN_DEBUG "radeonfb: resumed !\n");
+ bail:
+	release_console_sem();
 
-	return 0;
+	return rc;
+}
+
+#ifdef CONFIG_PPC_OF
+static void radeonfb_early_resume(void *data)
+{
+        struct radeonfb_info *rinfo = data;
+
+	rinfo->no_schedule = 1;
+	radeonfb_pci_resume(rinfo->pdev);
+	rinfo->no_schedule = 0;
 }
+#endif /* CONFIG_PPC_OF */
 
 #endif /* CONFIG_PM */
+
+void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk)
+{
+	/* Find PM registers in config space if any*/
+	rinfo->pm_reg = pci_find_capability(rinfo->pdev, PCI_CAP_ID_PM);
+
+	/* Enable/Disable dynamic clocks: TODO add sysfs access */
+	rinfo->dynclk = dynclk;
+	if (dynclk == 1) {
+		radeon_pm_enable_dynamic_mode(rinfo);
+		printk("radeonfb: Dynamic Clock Power Management enabled\n");
+	} else if (dynclk == 0) {
+		radeon_pm_disable_dynamic_mode(rinfo);
+		printk("radeonfb: Dynamic Clock Power Management disabled\n");
+	}
+
+	/* Check if we can power manage on suspend/resume. We can do
+	 * D2 on M6, M7 and M9, and we can resume from D3 cold a few other
+	 * "Mac" cards, but that's all. We need more infos about what the
+	 * BIOS does tho. Right now, all this PM stuff is pmac-only for that
+	 * reason. --BenH
+	 */
+#if defined(CONFIG_PM) && defined(CONFIG_PPC_OF)
+	if (_machine == _MACH_Pmac && rinfo->of_node) {
+		if (rinfo->is_mobility && rinfo->pm_reg &&
+		    rinfo->family <= CHIP_FAMILY_RV250)
+			rinfo->pm_mode |= radeon_pm_d2;
+
+		/* We can restart Jasper (M10 chip in albooks), BlueStone (7500 chip
+		 * in some desktop G4s), and Via (M9+ chip on iBook G4)
+		 */
+		if (!strcmp(rinfo->of_node->name, "ATY,JasperParent")) {
+			rinfo->reinit_func = radeon_reinitialize_M10;
+			rinfo->pm_mode |= radeon_pm_off;
+		}
+#if 0 /* Not ready yet */
+		if (!strcmp(rinfo->of_node->name, "ATY,BlueStoneParent")) {
+			rinfo->reinit_func = radeon_reinitialize_QW;
+			rinfo->pm_mode |= radeon_pm_off;
+		}
+#endif
+		if (!strcmp(rinfo->of_node->name, "ATY,ViaParent")) {
+			rinfo->reinit_func = radeon_reinitialize_M9P;
+			rinfo->pm_mode |= radeon_pm_off;
+			/* Workaround not used for now */
+			rinfo->m9p_workaround = 1;
+		}
+
+		/* If any of the above is set, we assume the machine can sleep/resume.
+		 * It's a bit of a "shortcut" but will work fine. Ideally, we need infos
+		 * from the platform about what happens to the chip...
+		 * Now we tell the platform about our capability
+		 */
+		if (rinfo->pm_mode != radeon_pm_none) {
+			pmac_call_feature(PMAC_FTR_DEVICE_CAN_WAKE, rinfo->of_node, 0, 1);
+			pmac_set_early_video_resume(radeonfb_early_resume, rinfo);
+		}
+
+		/* Power down TV DAC, taht saves a significant amount of power,
+		 * we'll have something better once we actually have some TVOut
+		 * support
+		 */
+		OUTREG(TV_DAC_CNTL, INREG(TV_DAC_CNTL) | 0x07000000);
+	}
+#endif /* defined(CONFIG_PM) && defined(CONFIG_PPC_OF) */
+}
+
+void radeonfb_pm_exit(struct radeonfb_info *rinfo)
+{
+#if defined(CONFIG_PM) && defined(CONFIG_PPC_OF)
+	if (rinfo->pm_mode != radeon_pm_none)
+		pmac_set_early_video_resume(NULL, NULL);
+#endif
+}
Index: linux-work/drivers/video/aty/radeonfb.h
===================================================================
--- linux-work.orig/drivers/video/aty/radeonfb.h	2004-11-22 11:50:27.000000000 +1100
+++ linux-work/drivers/video/aty/radeonfb.h	2005-01-17 13:49:30.073580288 +1100
@@ -16,8 +16,17 @@
 
 #include <asm/io.h>
 
+#ifdef CONFIG_PPC_OF
+#include <asm/prom.h>
+#endif
+
 #include <video/radeon.h>
 
+/* Some weird black magic use by Apple driver that we don't use for
+ * now --BenH
+ */
+#undef HAS_PLL_M9_GPIO_MAGIC
+
 /***************************************************************
  * Most of the definitions here are adapted right from XFree86 *
  ***************************************************************/
@@ -33,7 +42,8 @@
 	CHIP_FAMILY_RV100,
 	CHIP_FAMILY_RS100,    /* U1 (IGP320M) or A3 (IGP320)*/
 	CHIP_FAMILY_RV200,
-	CHIP_FAMILY_RS200,    /* U2 (IGP330M/340M/350M) or A4 (IGP330/340/345/350), RS250 (IGP 7000) */
+	CHIP_FAMILY_RS200,    /* U2 (IGP330M/340M/350M) or A4 (IGP330/340/345/350),
+				 RS250 (IGP 7000) */
 	CHIP_FAMILY_R200,
 	CHIP_FAMILY_RV250,
 	CHIP_FAMILY_RS300,    /* Radeon 9000 IGP */
@@ -41,9 +51,26 @@
 	CHIP_FAMILY_R300,
 	CHIP_FAMILY_R350,
 	CHIP_FAMILY_RV350,
+	CHIP_FAMILY_RV380,    /* RV370/RV380/M22/M24 */
+	CHIP_FAMILY_R420,     /* R420/R423/M18 */
 	CHIP_FAMILY_LAST,
 };
 
+#define IS_RV100_VARIANT(rinfo) (((rinfo)->family == CHIP_FAMILY_RV100)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RV200)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RS100)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RS200)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RV250)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RV280)  || \
+				 ((rinfo)->family == CHIP_FAMILY_RS300))
+
+
+#define IS_R300_VARIANT(rinfo) (((rinfo)->family == CHIP_FAMILY_R300)  || \
+				((rinfo)->family == CHIP_FAMILY_RV350) || \
+				((rinfo)->family == CHIP_FAMILY_R350)  || \
+				((rinfo)->family == CHIP_FAMILY_RV380) || \
+				((rinfo)->family == CHIP_FAMILY_R420))
+
 /*
  * Chip flags
  */
@@ -102,21 +129,6 @@
 	int ref_clk;
 };
 
-/*
- * VRAM infos
- */
-struct ram_info {
-	int ml;
-	int mb;
-	int trcd;
-	int trp;
-	int twr;
-	int cl;
-	int tr2w;
-	int loop_latency;
-	int rloop;
-};
-
 
 /*
  * This structure contains the various registers manipulated by this
@@ -210,6 +222,7 @@
 	u32		ppll_div_3;
 	u32		ppll_ref_div;
 	u32		vclk_ecp_cntl;
+	u32		clk_cntl_index;
 
 	/* Computed values for PLL2 */
 	u32		dot_clock_freq_2;
@@ -250,6 +263,12 @@
 };
 #endif
 
+enum radeon_pm_mode {
+	radeon_pm_none	= 0,		/* Nothing supported */
+	radeon_pm_d2	= 0x00000001,	/* Can do D2 state */
+	radeon_pm_off	= 0x00000002,	/* Can resume from D3 cold */
+};
+
 struct radeonfb_info {
 	struct fb_info		*info;
 
@@ -257,7 +276,6 @@
 	struct radeon_regs	init_state;
 
 	char			name[DEVICE_NAME_SIZE];
-	char			ram_type[12];
 
 	unsigned long		mmio_base_phys;
 	unsigned long		fb_base_phys;
@@ -268,6 +286,9 @@
 	unsigned long		fb_local_base;
 
 	struct pci_dev		*pdev;
+#ifdef CONFIG_PPC_OF
+	struct device_node	*of_node;
+#endif
 
 	void __iomem		*bios_seg;
 	int			fp_bios_start;
@@ -281,6 +302,8 @@
 	u8			rev;
 	unsigned long		video_ram;
 	unsigned long		mapped_vram;
+	int			vram_width;
+	int			vram_ddr;
 
 	int			pitch, bpp, depth;
 
@@ -288,6 +311,7 @@
 	int			is_mobility;
 	int			is_IGP;
 	int			R300_cg_workaround;
+	int			m9p_workaround;
 	int			reversed_DAC;
 	int			reversed_TMDS;
 	struct panel_info	panel_info;
@@ -302,14 +326,16 @@
 
 	struct pll_info		pll;
 
-	struct ram_info		ram;
-
 	int			mtrr_hdl;
 
 	int			pm_reg;
-	u32			save_regs[64];
+	u32			save_regs[100];
 	int			asleep;
 	int			lock_blank;
+	int			dynclk;
+	int			no_schedule;
+	enum radeon_pm_mode	pm_mode;
+	void			(*reinit_func)(struct radeonfb_info *rinfo);
 
 	/* Lock on register access */
 	spinlock_t		reg_lock;
@@ -317,11 +343,12 @@
 	/* Timer used for delayed LVDS operations */
 	struct timer_list	lvds_timer;
 	u32			pending_lvds_gen_cntl;
-	u32			pending_pixclks_cntl;
 
 #ifdef CONFIG_FB_RADEON_I2C
 	struct radeon_i2c_chan 	i2c[4];
 #endif
+
+	u32			cfg_save[64];
 };
 
 
@@ -353,6 +380,22 @@
 #define INREG(addr)		readl((rinfo->mmio_base)+addr)
 #define OUTREG(addr,val)	writel(val, (rinfo->mmio_base)+addr)
 
+static inline void _OUTREGP(struct radeonfb_info *rinfo, u32 addr,
+		       u32 val, u32 mask)
+{
+	unsigned long flags;
+	unsigned int tmp;
+	
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
+	tmp = INREG(addr);
+	tmp &= (mask);
+	tmp |= (val);
+	OUTREG(addr, tmp);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+}
+
+#define OUTREGP(addr,val,mask)	_OUTREGP(rinfo, addr, val,mask)
+
 static inline void R300_cg_workardound(struct radeonfb_info *rinfo)
 {
 	u32 save, tmp;
@@ -363,18 +406,35 @@
 	OUTREG(CLOCK_CNTL_INDEX, save);
 }
 
-#define __OUTPLL(addr,val)	\
-	do {	\
-		OUTREG8(CLOCK_CNTL_INDEX, (addr & 0x0000003f) | 0x00000080); \
-		OUTREG(CLOCK_CNTL_DATA, val); \
-} while(0)
-
 
 static inline u32 __INPLL(struct radeonfb_info *rinfo, u32 addr)
 {
 	u32 data;
+#ifdef HAS_PLL_M9_GPIO_MAGIC
+	u32 sv[3];
+
+	if (rinfo->m9p_workaround) {
+		sv[0] = INREG(0x19c);
+		sv[1] = INREG(0x1a0);
+		sv[2] = INREG(0x198);
+		OUTREG(0x198, 0);
+		OUTREG(0x1a0, 0);
+		OUTREG(0x19c, 0);
+	}
+#endif /* HAS_PLL_M9_GPIO_MAGIC */
+
 	OUTREG8(CLOCK_CNTL_INDEX, addr & 0x0000003f);
 	data = (INREG(CLOCK_CNTL_DATA));
+
+#ifdef HAS_PLL_M9_GPIO_MAGIC
+	if (rinfo->m9p_workaround) {
+		(void)INREG(CRTC_GEN_CNTL);
+		data = INREG(CLOCK_CNTL_DATA);
+		OUTREG(0x19c, sv[0]);
+		OUTREG(0x1a0, sv[1]);
+		OUTREG(0x198, sv[2]);
+	}
+#endif /* HAS_PLL_M9_GPIO_MAGIC */
 	if (rinfo->R300_cg_workaround)
 		R300_cg_workardound(rinfo);
 	return data;
@@ -393,37 +453,61 @@
 
 #define INPLL(addr)		_INPLL(rinfo, addr)
 
-#define OUTPLL(addr,val)	\
-	do {	\
-		unsigned long flags;\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); \
-		__OUTPLL(addr, val); \
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); \
-	} while(0)
-
-#define OUTPLLP(addr,val,mask)  					\
-	do {								\
-		unsigned long flags;                                    \
-		unsigned int _tmp;					\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); 		\
-		_tmp  = __INPLL(rinfo,addr);				\
-		_tmp &= (mask);						\
-		_tmp |= (val);						\
-		__OUTPLL(addr, _tmp);					\
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); 	\
-	} while (0)
-
-#define OUTREGP(addr,val,mask)  					\
-	do {								\
-		unsigned long flags;                                    \
-		unsigned int _tmp;					\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); 		\
-		_tmp = INREG(addr);				       	\
-		_tmp &= (mask);						\
-		_tmp |= (val);						\
-		OUTREG(addr, _tmp);					\
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); 	\
-	} while (0)
+
+static inline void __OUTPLL(struct radeonfb_info *rinfo, unsigned int index, u32 val)
+{
+#ifdef HAS_PLL_M9_GPIO_MAGIC
+	u32 sv[3];
+
+	if (rinfo->m9p_workaround) {
+		sv[0] = INREG(0x19c);
+		sv[1] = INREG(0x1a0);
+		sv[2] = INREG(0x198);
+		OUTREG(0x198, 0);
+		OUTREG(0x1a0, 0);
+		OUTREG(0x19c, 0);
+		mdelay(1);
+	}
+#endif /* HAS_PLL_M9_GPIO_MAGIC */
+
+	OUTREG8(CLOCK_CNTL_INDEX, (index & 0x0000003f) | 0x00000080);
+	OUTREG(CLOCK_CNTL_DATA, val);
+
+#ifdef HAS_PLL_M9_GPIO_MAGIC
+	if (rinfo->m9p_workaround) {
+		OUTREG(0x19c, sv[0]);
+		OUTREG(0x1a0, sv[1]);
+		OUTREG(0x198, sv[2]);
+	}
+#endif /* HAS_PLL_M9_GPIO_MAGIC */
+}
+	
+static inline void _OUTPLL(struct radeonfb_info *rinfo, unsigned int index, u32 val)
+{
+       	unsigned long flags;
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
+	__OUTPLL(rinfo, index, val);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+}
+
+static inline void _OUTPLLP(struct radeonfb_info *rinfo, unsigned int index,
+			    u32 val, u32 mask)
+{
+	unsigned long flags;
+	unsigned int tmp;
+
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
+	tmp  = __INPLL(rinfo, index);
+	tmp &= (mask);
+	tmp |= (val);
+	__OUTPLL(rinfo, index, tmp);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+}
+
+
+#define OUTPLL(index, val)		_OUTPLL(rinfo, index, val)
+#define OUTPLLP(index, val, mask)	_OUTPLLP(rinfo, index, val, mask)
+
 
 #define BIOS_IN8(v)  	(readb(rinfo->bios_seg + (v)))
 #define BIOS_IN16(v) 	(readb(rinfo->bios_seg + (v)) | \
@@ -484,7 +568,7 @@
 }
 
 
-static inline void _radeon_fifo_wait (struct radeonfb_info *rinfo, int entries)
+static inline void _radeon_fifo_wait(struct radeonfb_info *rinfo, int entries)
 {
 	int i;
 
@@ -497,7 +581,7 @@
 }
 
 
-static inline void _radeon_engine_idle (struct radeonfb_info *rinfo)
+static inline void _radeon_engine_idle(struct radeonfb_info *rinfo)
 {
 	int i;
 
@@ -514,8 +598,24 @@
 	printk(KERN_ERR "radeonfb: Idle Timeout !\n");
 }
 
+/* Note about this function: we have some rare cases where we must not schedule,
+ * this typically happen with our special "wake up early" hook which allows us to
+ * wake up the graphic chip (and thus get the console back) before everything else
+ * on some machines that support that mecanism. At this point, interrupts are off
+ * and scheduling is not permitted
+ */
+static inline void _radeon_msleep(struct radeonfb_info *rinfo, unsigned long ms)
+{
+	if (rinfo->no_schedule)
+		mdelay(ms);
+	else
+		msleep(ms);
+}
+
+
 #define radeon_engine_idle()		_radeon_engine_idle(rinfo)
 #define radeon_fifo_wait(entries)	_radeon_fifo_wait(rinfo,entries)
+#define radeon_msleep(ms)		_radeon_msleep(rinfo,ms)
 
 
 /* I2C Functions */
@@ -524,10 +624,10 @@
 extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid);
 
 /* PM Functions */
-extern void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo);
-extern void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo);
 extern int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state);
 extern int radeonfb_pci_resume(struct pci_dev *pdev);
+extern void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk);
+extern void radeonfb_pm_exit(struct radeonfb_info *rinfo);
 
 /* Monitor probe functions */
 extern void radeon_probe_screens(struct radeonfb_info *rinfo,
@@ -546,7 +646,9 @@
 extern void radeonfb_engine_reset(struct radeonfb_info *rinfo);
 
 /* Other functions */
-extern int radeonfb_blank(int blank, struct fb_info *info);
-extern int radeonfb_set_par(struct fb_info *info);
+extern int radeon_screen_blank(struct radeonfb_info *rinfo, int blank, int mode_switch);
+extern void radeon_save_state (struct radeonfb_info *rinfo, struct radeon_regs *save);
+extern void radeon_write_mode (struct radeonfb_info *rinfo, struct radeon_regs *mode,
+			       int reg_only);
 
 #endif /* __RADEONFB_H__ */
Index: linux-work/drivers/video/aty/ati_ids.h
===================================================================
--- linux-work.orig/drivers/video/aty/ati_ids.h	2004-11-22 11:50:26.000000000 +1100
+++ linux-work/drivers/video/aty/ati_ids.h	2005-01-17 13:49:30.075579984 +1100
@@ -4,6 +4,18 @@
  * radeonfb
  */
 
+#define PCI_CHIP_RV380_3150             0x3150
+#define PCI_CHIP_RV380_3151             0x3151
+#define PCI_CHIP_RV380_3152             0x3152
+#define PCI_CHIP_RV380_3153             0x3153
+#define PCI_CHIP_RV380_3154             0x3154
+#define PCI_CHIP_RV380_3156             0x3156
+#define PCI_CHIP_RV380_3E50             0x3E50
+#define PCI_CHIP_RV380_3E51             0x3E51
+#define PCI_CHIP_RV380_3E52             0x3E52
+#define PCI_CHIP_RV380_3E53             0x3E53
+#define PCI_CHIP_RV380_3E54             0x3E54
+#define PCI_CHIP_RV380_3E56             0x3E56
 #define PCI_CHIP_RS100_4136		0x4136
 #define PCI_CHIP_RS200_4137		0x4137
 #define PCI_CHIP_R300_AD		0x4144
@@ -52,6 +64,14 @@
 #define PCI_CHIP_RV250_Ie		0x4965
 #define PCI_CHIP_RV250_If		0x4966
 #define PCI_CHIP_RV250_Ig		0x4967
+#define PCI_CHIP_R420_JH                0x4A48
+#define PCI_CHIP_R420_JI                0x4A49
+#define PCI_CHIP_R420_JJ                0x4A4A
+#define PCI_CHIP_R420_JK                0x4A4B
+#define PCI_CHIP_R420_JL                0x4A4C
+#define PCI_CHIP_R420_JM                0x4A4D
+#define PCI_CHIP_R420_JN                0x4A4E
+#define PCI_CHIP_R420_JP                0x4A50
 #define PCI_CHIP_MACH64LB		0x4C42
 #define PCI_CHIP_MACH64LD		0x4C44
 #define PCI_CHIP_RAGE128LE		0x4C45
@@ -73,6 +93,7 @@
 #define PCI_CHIP_RV250_Le		0x4C65
 #define PCI_CHIP_RV250_Lf		0x4C66
 #define PCI_CHIP_RV250_Lg		0x4C67
+#define PCI_CHIP_RV250_Ln		0x4C6E
 #define PCI_CHIP_RAGE128MF		0x4D46
 #define PCI_CHIP_RAGE128ML		0x4D4C
 #define PCI_CHIP_R300_ND		0x4E44
@@ -148,6 +169,21 @@
 #define PCI_CHIP_RAGE128TS		0x5453
 #define PCI_CHIP_RAGE128TT		0x5454
 #define PCI_CHIP_RAGE128TU		0x5455
+#define PCI_CHIP_RV370_5460             0x5460
+#define PCI_CHIP_RV370_5461             0x5461
+#define PCI_CHIP_RV370_5462             0x5462
+#define PCI_CHIP_RV370_5463             0x5463
+#define PCI_CHIP_RV370_5464             0x5464
+#define PCI_CHIP_RV370_5465             0x5465
+#define PCI_CHIP_RV370_5466             0x5466
+#define PCI_CHIP_RV370_5467             0x5467
+#define PCI_CHIP_R423_UH                0x5548
+#define PCI_CHIP_R423_UI                0x5549
+#define PCI_CHIP_R423_UJ                0x554A
+#define PCI_CHIP_R423_UK                0x554B
+#define PCI_CHIP_R423_UQ                0x5551
+#define PCI_CHIP_R423_UR                0x5552
+#define PCI_CHIP_R423_UT                0x5554
 #define PCI_CHIP_MACH64VT		0x5654
 #define PCI_CHIP_MACH64VU		0x5655
 #define PCI_CHIP_MACH64VV		0x5656
@@ -155,14 +191,21 @@
 #define PCI_CHIP_RS300_5835		0x5835
 #define PCI_CHIP_RS300_5836		0x5836
 #define PCI_CHIP_RS300_5837		0x5837
+#define PCI_CHIP_RV370_5B60             0x5B60
+#define PCI_CHIP_RV370_5B61             0x5B61
+#define PCI_CHIP_RV370_5B62             0x5B62
+#define PCI_CHIP_RV370_5B63             0x5B63
+#define PCI_CHIP_RV370_5B64             0x5B64
+#define PCI_CHIP_RV370_5B65             0x5B65
+#define PCI_CHIP_RV370_5B66             0x5B66
+#define PCI_CHIP_RV370_5B67             0x5B67
 #define PCI_CHIP_RV280_5960		0x5960
 #define PCI_CHIP_RV280_5961		0x5961
 #define PCI_CHIP_RV280_5962		0x5962
-#define PCI_CHIP_RV280_5963		0x5963
 #define PCI_CHIP_RV280_5964		0x5964
-#define PCI_CHIP_RV280_5968		0x5968
-#define PCI_CHIP_RV280_5969		0x5969
-#define PCI_CHIP_RV280_596A		0x596A
-#define PCI_CHIP_RV280_596B		0x596B
 #define PCI_CHIP_RV280_5C61		0x5C61
 #define PCI_CHIP_RV280_5C63		0x5C63
+#define PCI_CHIP_R423_5D57              0x5D57
+#define PCI_CHIP_RS350_7834             0x7834
+#define PCI_CHIP_RS350_7835             0x7835
+
