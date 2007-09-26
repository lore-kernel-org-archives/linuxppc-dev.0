Return-Path: <geert@sonycom.com>
Message-Id: <20070926164031.494263000@pademelon.sonytel.be>
References: <20070926163308.772580000@pademelon.sonytel.be>
Date: Wed, 26 Sep 2007 18:33:16 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 8/8] ps3av: dont distinguish between `boot and `non-boot
	autodetection
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

ps3av: don't distinguish between `boot' and `non-boot' autodetection now the
autodetection code has been improved

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c         |   35 ++++++-----------------------------
 drivers/video/ps3fb.c       |    6 ++----
 include/asm-powerpc/ps3av.h |    4 ++--
 3 files changed, 10 insertions(+), 35 deletions(-)

--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -760,8 +760,7 @@ static void ps3av_fixup_monitor_info(str
 	}
 }
 
-static int ps3av_auto_videomode(struct ps3av_pkt_av_get_hw_conf *av_hw_conf,
-				int boot)
+static int ps3av_auto_videomode(struct ps3av_pkt_av_get_hw_conf *av_hw_conf)
 {
 	int i, res, id = 0, dvi = 0, rgb = 0;
 	struct ps3av_pkt_av_get_monitor_info monitor_info;
@@ -799,28 +798,6 @@ static int ps3av_auto_videomode(struct p
 		if (ps3av->region & PS3AV_REGION_RGB)
 			rgb = PS3AV_MODE_RGB;
 		pr_debug("%s: Using avmulti mode %d\n", __func__, id);
-	} else if (boot) {
-		/* HDMI: using DEFAULT HDMI_MODE_ID while booting up */
-		info = &monitor_info.info;
-		if (ps3av->region & PS3AV_REGION_60) {
-			if (info->res_60.res_bits & PS3AV_RESBIT_720x480P)
-				id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_60;
-			else if (info->res_50.res_bits & PS3AV_RESBIT_720x576P)
-				id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_50;
-			else {
-				/* default */
-				id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_60;
-			}
-		} else {
-			if (info->res_50.res_bits & PS3AV_RESBIT_720x576P)
-				id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_50;
-			else if (info->res_60.res_bits & PS3AV_RESBIT_720x480P)
-				id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_60;
-			else {
-				/* default */
-				id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_50;
-			}
-		}
 	}
 
 	return id | dvi | rgb;
@@ -862,7 +839,7 @@ static int ps3av_get_hw_conf(struct ps3a
 }
 
 /* set mode using id */
-int ps3av_set_video_mode(u32 id, int boot)
+int ps3av_set_video_mode(u32 id)
 {
 	int size;
 	u32 option;
@@ -876,7 +853,7 @@ int ps3av_set_video_mode(u32 id, int boo
 	/* auto mode */
 	option = id & ~PS3AV_MODE_MASK;
 	if ((id & PS3AV_MODE_MASK) == 0) {
-		id = ps3av_auto_videomode(&ps3av->av_hw_conf, boot);
+		id = ps3av_auto_videomode(&ps3av->av_hw_conf);
 		if (id < 1) {
 			printk(KERN_ERR "%s: invalid id :%d\n", __func__, id);
 			return -EINVAL;
@@ -896,9 +873,9 @@ int ps3av_set_video_mode(u32 id, int boo
 
 EXPORT_SYMBOL_GPL(ps3av_set_video_mode);
 
-int ps3av_get_auto_mode(int boot)
+int ps3av_get_auto_mode(void)
 {
-	return ps3av_auto_videomode(&ps3av->av_hw_conf, boot);
+	return ps3av_auto_videomode(&ps3av->av_hw_conf);
 }
 
 EXPORT_SYMBOL_GPL(ps3av_get_auto_mode);
@@ -1044,7 +1021,7 @@ static int ps3av_probe(struct ps3_system
 		       res);
 
 	ps3av_get_hw_conf(ps3av);
-	id = ps3av_auto_videomode(&ps3av->av_hw_conf, 1);
+	id = ps3av_auto_videomode(&ps3av->av_hw_conf);
 	mutex_lock(&ps3av->mutex);
 	ps3av->ps3av_mode = id;
 	mutex_unlock(&ps3av->mutex);
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -548,7 +548,6 @@ static int ps3fb_set_par(struct fb_info 
 	unsigned int mode;
 	int i;
 	unsigned long offset;
-	static int first = 1;
 
 	DPRINTK("xres:%d xv:%d yres:%d yv:%d clock:%d\n",
 		info->var.xres, info->var.xres_virtual,
@@ -572,10 +571,9 @@ static int ps3fb_set_par(struct fb_info 
 	/* Keep the special bits we cannot set using fb_var_screeninfo */
 	ps3fb_mode = (ps3fb_mode & ~PS3AV_MODE_MASK) | mode;
 
-	if (ps3av_set_video_mode(ps3fb_mode, first))
+	if (ps3av_set_video_mode(ps3fb_mode))
 		return -EINVAL;
 
-	first = 0;
 	return 0;
 }
 
@@ -737,7 +735,7 @@ static int ps3fb_ioctl(struct fb_info *i
 				break;
 
 			if (!(val & PS3AV_MODE_MASK)) {
-				u32 id = ps3av_get_auto_mode(0);
+				u32 id = ps3av_get_auto_mode();
 				if (id > 0)
 					val = (val & ~PS3AV_MODE_MASK) | id;
 			}
--- a/include/asm-powerpc/ps3av.h
+++ b/include/asm-powerpc/ps3av.h
@@ -709,9 +709,9 @@ extern int ps3av_cmd_av_get_hw_conf(stru
 extern int ps3av_cmd_video_get_monitor_info(struct ps3av_pkt_av_get_monitor_info *,
 					    u32);
 
-extern int ps3av_set_video_mode(u32, int);
+extern int ps3av_set_video_mode(u32);
 extern int ps3av_set_audio_mode(u32, u32, u32, u32, u32);
-extern int ps3av_get_auto_mode(int);
+extern int ps3av_get_auto_mode(void);
 extern int ps3av_get_mode(void);
 extern int ps3av_get_scanmode(int);
 extern int ps3av_get_refresh_rate(int);

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
