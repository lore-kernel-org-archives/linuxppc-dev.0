Return-Path: <geert@sonycom.com>
Message-Id: <20071012145130.961757000@pademelon.sonytel.be>
References: <20071012145052.640177000@pademelon.sonytel.be>
Date: Fri, 12 Oct 2007 16:51:05 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 13/13] ps3fb: Default to 480p on DVI-D/HDMI if video=safe
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

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: Default to the 480p video mode on DVI-D and HDMI displays if
`video=safe' is passed on the kernel command line.

This is intended to be used by `kboot'-style boot loaders (i.e. first-stage
kernels) for the PS3, to provide a failsafe video mode.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/notifier.h>
 #include <linux/ioctl.h>
+#include <linux/fb.h>
 
 #include <asm/firmware.h>
 #include <asm/ps3av.h>
@@ -33,6 +34,8 @@
 #define BUFSIZE          4096	/* vuart buf size */
 #define PS3AV_BUF_SIZE   512	/* max packet size */
 
+static int safe_mode;
+
 static int timeout = 5000;	/* in msec ( 5 sec ) */
 module_param(timeout, int, 0644);
 
@@ -639,6 +642,9 @@ static int ps3av_hdmi_get_id(struct ps3a
 {
 	int id;
 
+	if (safe_mode)
+		return PS3AV_DEFAULT_HDMI_MODE_ID_REG_60;
+
 	/* check native resolution */
 	id = ps3av_resbit2id(info->res_50.native, info->res_60.native,
 			     info->res_vesa.native);
@@ -1021,7 +1027,14 @@ static int ps3av_probe(struct ps3_system
 		       res);
 
 	ps3av_get_hw_conf(ps3av);
+
+#ifdef CONFIG_FB
+	if (fb_mode_option && !strcmp(fb_mode_option, "safe"))
+		safe_mode = 1;
+#endif /* CONFIG_FB */
 	id = ps3av_auto_videomode(&ps3av->av_hw_conf);
+	safe_mode = 0;
+
 	mutex_lock(&ps3av->mutex);
 	ps3av->ps3av_mode = id;
 	mutex_unlock(&ps3av->mutex);

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
