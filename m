Return-Path: <geert@sonycom.com>
Message-Id: <20080125153107.054556036@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
Date: Fri, 25 Jan 2008 16:06:25 +0100
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 02/11] ps3: Use symbolic names for video modes
Sender: geert <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3: Use symbolic names for video modes

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c         |   39 ++++++++++++++++++++-------------------
 drivers/video/ps3fb.c       |   17 ++++++++++-------
 include/asm-powerpc/ps3av.h |   41 ++++++++++++++++++++++++++++++-----------
 3 files changed, 60 insertions(+), 37 deletions(-)

--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -542,7 +542,7 @@ static void ps3av_set_videomode_packet(u
 
 static void ps3av_set_videomode_cont(u32 id, u32 old_id)
 {
-	static int vesa = 0;
+	static int vesa;
 	int res;
 
 	/* video signal off */
@@ -552,9 +552,9 @@ static void ps3av_set_videomode_cont(u32
 	 * AV backend needs non-VESA mode setting at least one time
 	 * when VESA mode is used.
 	 */
-	if (vesa == 0 && (id & PS3AV_MODE_MASK) >= 11) {
+	if (vesa == 0 && (id & PS3AV_MODE_MASK) >= PS3AV_MODE_WXGA) {
 		/* vesa mode */
-		ps3av_set_videomode_packet(2);	/* 480P */
+		ps3av_set_videomode_packet(PS3AV_MODE_480P);
 	}
 	vesa = 1;
 
@@ -594,20 +594,21 @@ static const struct {
 	unsigned mask : 19;
 	unsigned id :  4;
 } ps3av_preferred_modes[] = {
-	{ .mask = PS3AV_RESBIT_WUXGA		<< SHIFT_VESA,	.id = 13 },
-	{ .mask = PS3AV_RESBIT_1920x1080P	<< SHIFT_60,	.id = 5 },
-	{ .mask = PS3AV_RESBIT_1920x1080P	<< SHIFT_50,	.id = 10 },
-	{ .mask = PS3AV_RESBIT_1920x1080I	<< SHIFT_60,	.id = 4 },
-	{ .mask = PS3AV_RESBIT_1920x1080I	<< SHIFT_50,	.id = 9 },
-	{ .mask = PS3AV_RESBIT_SXGA		<< SHIFT_VESA,	.id = 12 },
-	{ .mask = PS3AV_RESBIT_WXGA		<< SHIFT_VESA,	.id = 11 },
-	{ .mask = PS3AV_RESBIT_1280x720P	<< SHIFT_60,	.id = 3 },
-	{ .mask = PS3AV_RESBIT_1280x720P	<< SHIFT_50,	.id = 8 },
-	{ .mask = PS3AV_RESBIT_720x480P		<< SHIFT_60,	.id = 2 },
-	{ .mask = PS3AV_RESBIT_720x576P		<< SHIFT_50,	.id = 7 },
+	{ PS3AV_RESBIT_WUXGA      << SHIFT_VESA, PS3AV_MODE_WUXGA   },
+	{ PS3AV_RESBIT_1920x1080P << SHIFT_60,   PS3AV_MODE_1080P60 },
+	{ PS3AV_RESBIT_1920x1080P << SHIFT_50,   PS3AV_MODE_1080P50 },
+	{ PS3AV_RESBIT_1920x1080I << SHIFT_60,   PS3AV_MODE_1080I60 },
+	{ PS3AV_RESBIT_1920x1080I << SHIFT_50,   PS3AV_MODE_1080I50 },
+	{ PS3AV_RESBIT_SXGA       << SHIFT_VESA, PS3AV_MODE_SXGA    },
+	{ PS3AV_RESBIT_WXGA       << SHIFT_VESA, PS3AV_MODE_WXGA    },
+	{ PS3AV_RESBIT_1280x720P  << SHIFT_60,   PS3AV_MODE_720P60  },
+	{ PS3AV_RESBIT_1280x720P  << SHIFT_50,   PS3AV_MODE_720P50  },
+	{ PS3AV_RESBIT_720x480P   << SHIFT_60,   PS3AV_MODE_480P    },
+	{ PS3AV_RESBIT_720x576P   << SHIFT_50,   PS3AV_MODE_576P    },
 };
 
-static int ps3av_resbit2id(u32 res_50, u32 res_60, u32 res_vesa)
+static enum ps3av_mode_num ps3av_resbit2id(u32 res_50, u32 res_60,
+					   u32 res_vesa)
 {
 	unsigned int i;
 	u32 res_all;
@@ -636,9 +637,9 @@ static int ps3av_resbit2id(u32 res_50, u
 	return 0;
 }
 
-static int ps3av_hdmi_get_id(struct ps3av_info_monitor *info)
+static enum ps3av_mode_num ps3av_hdmi_get_id(struct ps3av_info_monitor *info)
 {
-	int id;
+	enum ps3av_mode_num id;
 
 	if (safe_mode)
 		return PS3AV_DEFAULT_HDMI_MODE_ID_REG_60;
@@ -852,7 +853,7 @@ int ps3av_set_video_mode(u32 id)
 
 	/* auto mode */
 	option = id & ~PS3AV_MODE_MASK;
-	if ((id & PS3AV_MODE_MASK) == 0) {
+	if ((id & PS3AV_MODE_MASK) == PS3AV_MODE_AUTO) {
 		id = ps3av_auto_videomode(&ps3av->av_hw_conf);
 		if (id < 1) {
 			printk(KERN_ERR "%s: invalid id :%d\n", __func__, id);
@@ -958,7 +959,7 @@ static int ps3av_probe(struct ps3_system
 		return -ENOMEM;
 
 	mutex_init(&ps3av->mutex);
-	ps3av->ps3av_mode = 0;
+	ps3av->ps3av_mode = PS3AV_MODE_AUTO;
 	ps3av->dev = dev;
 
 	INIT_WORK(&ps3av->work, ps3avd);
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -338,7 +338,7 @@ static int ps3fb_get_res_table(u32 xres,
 static unsigned int ps3fb_find_mode(const struct fb_var_screeninfo *var,
 				    u32 *ddr_line_length, u32 *xdr_line_length)
 {
-	unsigned int i, mode;
+	unsigned int i, fi, mode;
 
 	for (i = 0; i < ARRAY_SIZE(ps3fb_modedb); i++)
 		if (var->xres == ps3fb_modedb[i].xres &&
@@ -359,7 +359,8 @@ static unsigned int ps3fb_find_mode(cons
 
 found:
 	/* Cropped broadcast modes use the full line length */
-	*ddr_line_length = ps3fb_modedb[i < 10 ? i + 13 : i].xres * BPP;
+	fi = i < PS3AV_MODE_1080P50 ? i + PS3AV_MODE_WUXGA : i;
+	*ddr_line_length = ps3fb_modedb[fi].xres * BPP;
 
 	if (ps3_compare_firmware_version(1, 9, 0) >= 0) {
 		*xdr_line_length = GPU_ALIGN_UP(max(var->xres,
@@ -370,7 +371,9 @@ found:
 		*xdr_line_length = *ddr_line_length;
 
 	/* Full broadcast modes have the full mode bit set */
-	mode = i > 12 ? (i - 12) | PS3FB_FULL_MODE_BIT : i + 1;
+	mode = i+1;
+	if (mode > PS3AV_MODE_WUXGA)
+		mode = (mode - PS3AV_MODE_WUXGA) | PS3FB_FULL_MODE_BIT;
 
 	pr_debug("ps3fb_find_mode: mode %u\n", mode);
 
@@ -382,14 +385,14 @@ static const struct fb_videomode *ps3fb_
 	u32 mode = id & PS3AV_MODE_MASK;
 	u32 flags;
 
-	if (mode < 1 || mode > 13)
+	if (mode < PS3AV_MODE_480I || mode > PS3AV_MODE_WUXGA)
 		return NULL;
 
 	flags = id & ~PS3AV_MODE_MASK;
 
-	if (mode <= 10 && flags & PS3FB_FULL_MODE_BIT) {
+	if (mode <= PS3AV_MODE_1080P50 && flags & PS3FB_FULL_MODE_BIT) {
 		/* Full broadcast mode */
-		return &ps3fb_modedb[mode + 12];
+		return &ps3fb_modedb[mode + PS3AV_MODE_WUXGA - 1];
 	}
 
 	return &ps3fb_modedb[mode - 1];
@@ -1080,7 +1083,7 @@ static int __devinit ps3fb_probe(struct 
 
 	if (!ps3fb_mode)
 		ps3fb_mode = ps3av_get_mode();
-	dev_dbg(&dev->core, "ps3av_mode:%d\n", ps3fb_mode);
+	dev_dbg(&dev->core, "ps3fb_mode: %d\n", ps3fb_mode);
 
 	if (ps3fb_mode > 0 &&
 	    !ps3av_video_mode2res(ps3fb_mode, &xres, &yres)) {
--- a/include/asm-powerpc/ps3av.h
+++ b/include/asm-powerpc/ps3av.h
@@ -310,19 +310,25 @@
 #define PS3AV_MONITOR_TYPE_HDMI			1	/* HDMI */
 #define PS3AV_MONITOR_TYPE_DVI			2	/* DVI */
 
-#define PS3AV_DEFAULT_HDMI_MODE_ID_REG_60	2	/* 480p */
-#define PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_60	1	/* 480i */
-#define PS3AV_DEFAULT_HDMI_MODE_ID_REG_50	7	/* 576p */
-#define PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_50	6	/* 576i */
-
-#define PS3AV_REGION_60				0x01
-#define PS3AV_REGION_50				0x02
-#define PS3AV_REGION_RGB			0x10
-
-#define get_status(buf)				(((__u32 *)buf)[2])
-#define PS3AV_HDR_SIZE				4	/* version + size */
 
 /* for video mode */
+enum ps3av_mode_num {
+	PS3AV_MODE_AUTO				= 0,
+	PS3AV_MODE_480I				= 1,
+	PS3AV_MODE_480P				= 2,
+	PS3AV_MODE_720P60			= 3,
+	PS3AV_MODE_1080I60			= 4,
+	PS3AV_MODE_1080P60			= 5,
+	PS3AV_MODE_576I				= 6,
+	PS3AV_MODE_576P				= 7,
+	PS3AV_MODE_720P50			= 8,
+	PS3AV_MODE_1080I50			= 9,
+	PS3AV_MODE_1080P50			= 10,
+	PS3AV_MODE_WXGA				= 11,
+	PS3AV_MODE_SXGA				= 12,
+	PS3AV_MODE_WUXGA			= 13,
+};
+
 #define PS3AV_MODE_MASK				0x000F
 #define PS3AV_MODE_HDCP_OFF			0x1000	/* Retail PS3 product doesn't support this */
 #define PS3AV_MODE_DITHER			0x0800
@@ -333,6 +339,19 @@
 #define PS3AV_MODE_RGB				0x0020
 
 
+#define PS3AV_DEFAULT_HDMI_MODE_ID_REG_60	PS3AV_MODE_480P
+#define PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_60	PS3AV_MODE_480I
+#define PS3AV_DEFAULT_HDMI_MODE_ID_REG_50	PS3AV_MODE_576P
+#define PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_50	PS3AV_MODE_576I
+
+#define PS3AV_REGION_60				0x01
+#define PS3AV_REGION_50				0x02
+#define PS3AV_REGION_RGB			0x10
+
+#define get_status(buf)				(((__u32 *)buf)[2])
+#define PS3AV_HDR_SIZE				4	/* version + size */
+
+
 /** command packet structure **/
 struct ps3av_send_hdr {
 	u16 version;

-- 
With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
