Return-Path: <geert@sonycom.com>
Message-Id: <20070926164031.299276000@pademelon.sonytel.be>
References: <20070926163308.772580000@pademelon.sonytel.be>
Date: Wed, 26 Sep 2007 18:33:14 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 6/8] ps3av: add quirk database for broken monitors
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

ps3av: add a quirk database for broken monitors where the `best' advertised
video mode doesn't work

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+)

--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -721,6 +721,45 @@ static void ps3av_monitor_info_dump(cons
 	}
 }
 
+static const struct ps3av_monitor_quirk {
+	const char *monitor_name;
+	u32 clear_60, clear_50, clear_vesa;
+} ps3av_monitor_quirks[] = {
+	{
+		.monitor_name	= "DELL 2007WFP",
+		.clear_60	= PS3AV_RESBIT_1920x1080I
+	}, {
+		.monitor_name	= "L226WTQ",
+		.clear_60	= PS3AV_RESBIT_1920x1080I |
+				  PS3AV_RESBIT_1920x1080P
+	}, {
+		.monitor_name	= "SyncMaster",
+		.clear_60	= PS3AV_RESBIT_1920x1080I
+	}
+};
+
+static void ps3av_fixup_monitor_info(struct ps3av_info_monitor *info)
+{
+	unsigned int i;
+	const struct ps3av_monitor_quirk *quirk;
+
+	for (i = 0; i < ARRAY_SIZE(ps3av_monitor_quirks); i++) {
+		quirk = &ps3av_monitor_quirks[i];
+		if (!strncmp(info->monitor_name, quirk->monitor_name,
+			     sizeof(info->monitor_name))) {
+			pr_info("%s: Applying quirk for %s\n", __func__,
+				quirk->monitor_name);
+			info->res_60.res_bits &= ~quirk->clear_60;
+			info->res_60.native &= ~quirk->clear_60;
+			info->res_50.res_bits &= ~quirk->clear_50;
+			info->res_50.native &= ~quirk->clear_50;
+			info->res_vesa.res_bits &= ~quirk->clear_vesa;
+			info->res_vesa.native &= ~quirk->clear_vesa;
+			break;
+		}
+	}
+}
+
 static int ps3av_auto_videomode(struct ps3av_pkt_av_get_hw_conf *av_hw_conf,
 				int boot)
 {
@@ -739,6 +778,8 @@ static int ps3av_auto_videomode(struct p
 		ps3av_monitor_info_dump(&monitor_info);
 
 		info = &monitor_info.info;
+		ps3av_fixup_monitor_info(info);
+
 		switch (info->monitor_type) {
 		case PS3AV_MONITOR_TYPE_DVI:
 			dvi = PS3AV_MODE_DVI;

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
