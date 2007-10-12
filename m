Return-Path: <geert@sonycom.com>
Message-Id: <20071012145129.480506000@pademelon.sonytel.be>
References: <20071012145052.640177000@pademelon.sonytel.be>
Date: Fri, 12 Oct 2007 16:50:53 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 01/13] ps3av: Fix black and white stripes
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Masashi Kimoto <Masashi_Kimoto@hq.scei.sony.co.jp>

Fix the black and white stripes issue with WUXGA monitor via HDMI.

It seems that when we use a VESA resolution from boot up, the AV settings
driver could not be initialized correctly.
In that case we need a dummy packet before VESA setting.

[Geert] Refactored to reduce code duplication.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3av.c |   58 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 38 insertions(+), 20 deletions(-)

--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -491,10 +491,10 @@ static int ps3av_set_videomode(void)
 	return 0;
 }
 
-static void ps3av_set_videomode_cont(u32 id, u32 old_id)
+static void ps3av_set_videomode_packet(u32 id)
 {
 	struct ps3av_pkt_avb_param avb_param;
-	int i;
+	unsigned int i;
 	u32 len = 0, av_video_cs;
 	const struct avset_video_mode *video_mode;
 	int res;
@@ -507,24 +507,6 @@ static void ps3av_set_videomode_cont(u32
 					ps3av->av_hw_conf.num_of_avmulti;
 	avb_param.num_of_av_audio_pkt = 0;
 
-	/* video signal off */
-	ps3av_set_video_disable_sig();
-
-	/* Retail PS3 product doesn't support this */
-	if (id & PS3AV_MODE_HDCP_OFF) {
-		res = ps3av_cmd_av_hdmi_mode(PS3AV_CMD_AV_HDMI_HDCP_OFF);
-		if (res == PS3AV_STATUS_UNSUPPORTED_HDMI_MODE)
-			dev_dbg(&ps3av->dev->core, "Not supported\n");
-		else if (res)
-			dev_dbg(&ps3av->dev->core,
-				"ps3av_cmd_av_hdmi_mode failed\n");
-	} else if (old_id & PS3AV_MODE_HDCP_OFF) {
-		res = ps3av_cmd_av_hdmi_mode(PS3AV_CMD_AV_HDMI_MODE_NORMAL);
-		if (res < 0 && res != PS3AV_STATUS_UNSUPPORTED_HDMI_MODE)
-			dev_dbg(&ps3av->dev->core,
-				"ps3av_cmd_av_hdmi_mode failed\n");
-	}
-
 	/* video_pkt */
 	for (i = 0; i < avb_param.num_of_video_pkt; i++)
 		len += ps3av_cmd_set_video_mode(&avb_param.buf[len],
@@ -555,6 +537,42 @@ static void ps3av_set_videomode_cont(u32
 		       __func__);
 	else if (res)
 		dev_dbg(&ps3av->dev->core, "ps3av_cmd_avb_param failed\n");
+}
+
+static void ps3av_set_videomode_cont(u32 id, u32 old_id)
+{
+	static int vesa;
+	int res;
+
+	/* video signal off */
+	ps3av_set_video_disable_sig();
+
+	/*
+	 * AV backend needs non-VESA mode setting at least one time
+	 * when VESA mode is used.
+	 */
+	if (vesa == 0 && (id & PS3AV_MODE_MASK) >= 11) {
+		/* vesa mode */
+		ps3av_set_videomode_packet(2);	/* 480P */
+	}
+	vesa = 1;
+
+	/* Retail PS3 product doesn't support this */
+	if (id & PS3AV_MODE_HDCP_OFF) {
+		res = ps3av_cmd_av_hdmi_mode(PS3AV_CMD_AV_HDMI_HDCP_OFF);
+		if (res == PS3AV_STATUS_UNSUPPORTED_HDMI_MODE)
+			dev_dbg(&ps3av->dev->core, "Not supported\n");
+		else if (res)
+			dev_dbg(&ps3av->dev->core,
+				"ps3av_cmd_av_hdmi_mode failed\n");
+	} else if (old_id & PS3AV_MODE_HDCP_OFF) {
+		res = ps3av_cmd_av_hdmi_mode(PS3AV_CMD_AV_HDMI_MODE_NORMAL);
+		if (res < 0 && res != PS3AV_STATUS_UNSUPPORTED_HDMI_MODE)
+			dev_dbg(&ps3av->dev->core,
+				"ps3av_cmd_av_hdmi_mode failed\n");
+	}
+
+	ps3av_set_videomode_packet(id);
 
 	msleep(1500);
 	/* av video mute */

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
