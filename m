Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4B691DE06C
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:18:57 +1000 (EST)
Message-ID: <4673024E.9060908@am.sony.com>
Date: Fri, 15 Jun 2007 14:19:10 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 07/33] PS3: Add support for HDMI RGB Full Range mode
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, Masashi Kimoto <Masashi_Kimoto@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Masashi Kimoto <Masashi_Kimoto@hq.scei.sony.co.jp>

Add support for HDMI RGB Full Range mode, which is available on system
software 1.80 or newer.

CC: Masashi Kimoto <Masashi_Kimoto@hq.scei.sony.co.jp>
Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3av_cmd.c     |   16 ++++++++++++++++
 include/asm-powerpc/ps3av.h |   12 +++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

--- a/drivers/ps3/ps3av_cmd.c
+++ b/drivers/ps3/ps3av_cmd.c
@@ -143,6 +143,14 @@ static u32 ps3av_vid_video2av(int vid)
 	return PS3AV_CMD_AV_VID_480P;
 }
 
+static int ps3av_hdmi_range(void)
+{
+	if (ps3_compare_firmware_version(1, 8, 0) < 0)
+		return 0;
+	else
+		return 1; /* supported */
+}
+
 int ps3av_cmd_init(void)
 {
 	int res;
@@ -350,6 +358,10 @@ u32 ps3av_cmd_set_av_video_cs(void *p, u
 	/* should be same as video_mode.video_cs_out */
 	av_video_cs->av_cs_in = ps3av_cs_video2av(PS3AV_CMD_VIDEO_CS_RGB_8);
 	av_video_cs->bitlen_out = ps3av_cs_video2av_bitlen(cs_out);
+	if ((id & PS3AV_MODE_WHITE) && ps3av_hdmi_range())
+		av_video_cs->super_white = PS3AV_CMD_AV_SUPER_WHITE_ON;
+	else /* default off */
+		av_video_cs->super_white = PS3AV_CMD_AV_SUPER_WHITE_OFF;
 	av_video_cs->aspect = aspect;
 	if (id & PS3AV_MODE_DITHER) {
 		av_video_cs->dither = PS3AV_CMD_AV_DITHER_ON
@@ -392,6 +404,10 @@ u32 ps3av_cmd_set_video_mode(void *p, u3
 	video_mode->pitch = video_mode->width * 4;	/* line_length */
 	video_mode->video_out_format = PS3AV_CMD_VIDEO_OUT_FORMAT_RGB_12BIT;
 	video_mode->video_format = ps3av_video_fmt_table[video_fmt].format;
+	if ((id & PS3AV_MODE_COLOR) && ps3av_hdmi_range())
+		video_mode->video_cl_cnv = PS3AV_CMD_VIDEO_CL_CNV_DISABLE_LUT;
+	else /* default enable */
+		video_mode->video_cl_cnv = PS3AV_CMD_VIDEO_CL_CNV_ENABLE_LUT;
 	video_mode->video_order = ps3av_video_fmt_table[video_fmt].order;
 
 	pr_debug("%s: video_mode:vid:%x width:%d height:%d pitch:%d out_format:%d format:%x order:%x\n",
--- a/include/asm-powerpc/ps3av.h
+++ b/include/asm-powerpc/ps3av.h
@@ -159,6 +159,9 @@
 #define PS3AV_CMD_VIDEO_FMT_X8R8G8B8			0x0000
 /* video_out_format */
 #define PS3AV_CMD_VIDEO_OUT_FORMAT_RGB_12BIT		0x0000
+/* video_cl_cnv */
+#define PS3AV_CMD_VIDEO_CL_CNV_ENABLE_LUT		0x0000
+#define PS3AV_CMD_VIDEO_CL_CNV_DISABLE_LUT		0x0010
 /* video_sync */
 #define PS3AV_CMD_VIDEO_SYNC_VSYNC			0x0001
 #define PS3AV_CMD_VIDEO_SYNC_CSYNC			0x0004
@@ -311,6 +314,8 @@
 #define PS3AV_MODE_MASK				0x000F
 #define PS3AV_MODE_HDCP_OFF			0x1000	/* Retail PS3 product doesn't support this */
 #define PS3AV_MODE_DITHER			0x0800
+#define PS3AV_MODE_COLOR			0x0400
+#define PS3AV_MODE_WHITE			0x0200
 #define PS3AV_MODE_FULL				0x0080
 #define PS3AV_MODE_DVI				0x0040
 #define PS3AV_MODE_RGB				0x0020
@@ -529,9 +534,9 @@ struct ps3av_pkt_video_mode {
 	u32 video_out_format;	/* in: out format */
 	u32 video_format;	/* in: input frame buffer format */
 	u8 reserved3;
-	u8 reserved4;
+	u8 video_cl_cnv;	/* in: color conversion */
 	u16 video_order;	/* in: input RGB order */
-	u32 reserved5;
+	u32 reserved4;
 };
 
 /* video: format */
@@ -539,7 +544,8 @@ struct ps3av_pkt_video_format {
 	struct ps3av_send_hdr send_hdr;
 	u32 video_head;		/* in: head */
 	u32 video_format;	/* in: frame buffer format */
-	u16 reserved;
+	u8 reserved;
+	u8 video_cl_cnv;	/* in: color conversion */
 	u16 video_order;	/* in: input RGB order */
 };
 

-- 
