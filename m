Return-Path: <geert@sonycom.com>
Message-Id: <20070926164031.098705000@pademelon.sonytel.be>
References: <20070926163308.772580000@pademelon.sonytel.be>
Date: Wed, 26 Sep 2007 18:33:12 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 4/8] ps3av: treat DVI-D like HDMI in autodetect
Sender: Geert Uytterhoeven <geert@sonycom.com>
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

ps3av: treat DVI-D monitors like HDMI monitors when autodetecting the best
video mode

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c         |   24 ++++++++----------------
 include/asm-powerpc/ps3av.h |    1 -
 2 files changed, 8 insertions(+), 17 deletions(-)

--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -620,9 +620,6 @@ static int ps3av_hdmi_get_id(struct ps3a
 	u32 res_50, res_60;
 	int id;
 
-	if (info->monitor_type != PS3AV_MONITOR_TYPE_HDMI)
-		return 0;
-
 	/* check native resolution */
 	res_50 = info->res_50.native & PS3AV_RES_MASK_50;
 	res_60 = info->res_60.native & PS3AV_RES_MASK_60;
@@ -712,7 +709,7 @@ static int ps3av_auto_videomode(struct p
 	struct ps3av_info_monitor *info;
 
 	/* get mode id for hdmi */
-	for (i = 0; i < av_hw_conf->num_of_hdmi; i++) {
+	for (i = 0; i < av_hw_conf->num_of_hdmi && !id; i++) {
 		res = ps3av_cmd_video_get_monitor_info(&monitor_info,
 						       PS3AV_CMD_AVPORT_HDMI_0 +
 						       i);
@@ -720,24 +717,19 @@ static int ps3av_auto_videomode(struct p
 			return -1;
 
 		ps3av_monitor_info_dump(&monitor_info);
+
 		info = &monitor_info.info;
-		/* check DVI */
-		if (info->monitor_type == PS3AV_MONITOR_TYPE_DVI) {
+		switch (info->monitor_type) {
+		case PS3AV_MONITOR_TYPE_DVI:
 			dvi = PS3AV_MODE_DVI;
-			break;
-		}
-		/* check HDMI */
-		id = ps3av_hdmi_get_id(info);
-		if (id) {
-			/* got valid mode id */
+			/* fall through */
+		case PS3AV_MONITOR_TYPE_HDMI:
+			id = ps3av_hdmi_get_id(info);
 			break;
 		}
 	}
 
-	if (dvi) {
-		/* DVI mode */
-		id = PS3AV_DEFAULT_DVI_MODE_ID;
-	} else if (!id) {
+	if (!id) {
 		/* no HDMI interface or HDMI is off */
 		if (ps3av->region & PS3AV_REGION_60)
 			id = PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_60;
--- a/include/asm-powerpc/ps3av.h
+++ b/include/asm-powerpc/ps3av.h
@@ -305,7 +305,6 @@
 #define PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_60	1	/* 480i */
 #define PS3AV_DEFAULT_HDMI_MODE_ID_REG_50	7	/* 576p */
 #define PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_50	6	/* 576i */
-#define PS3AV_DEFAULT_DVI_MODE_ID		2	/* 480p */
 
 #define PS3AV_REGION_60				0x01
 #define PS3AV_REGION_50				0x02

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
