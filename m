Return-Path: <geert@sonycom.com>
Message-Id: <20080125153106.990140657@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
Date: Fri, 25 Jan 2008 16:06:24 +0100
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 01/11] ps3av: ps3av_get_scanmode() and
	ps3av_get_refresh_rate() are unused
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

ps3av: ps3av_get_scanmode() and ps3av_get_refresh_rate() are unused, so remove
them

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c         |   58 +++++++++-----------------------------------
 include/asm-powerpc/ps3av.h |    2 -
 2 files changed, 13 insertions(+), 47 deletions(-)

--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -78,23 +78,21 @@ static const struct avset_video_mode {
 	u32 aspect;
 	u32 x;
 	u32 y;
-	u32 interlace;
-	u32 freq;
 } video_mode_table[] = {
 	{     0, }, /* auto */
-	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_480I,       A_N,  720,  480, 1, 60},
-	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_480P,       A_N,  720,  480, 0, 60},
-	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_720P_60HZ,  A_N, 1280,  720, 0, 60},
-	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080I_60HZ, A_W, 1920, 1080, 1, 60},
-	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080P_60HZ, A_W, 1920, 1080, 0, 60},
-	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_576I,       A_N,  720,  576, 1, 50},
-	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_576P,       A_N,  720,  576, 0, 50},
-	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_720P_50HZ,  A_N, 1280,  720, 0, 50},
-	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080I_50HZ, A_W, 1920, 1080, 1, 50},
-	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080P_50HZ, A_W, 1920, 1080, 0, 50},
-	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_WXGA,       A_W, 1280,  768, 0, 60},
-	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_SXGA,       A_N, 1280, 1024, 0, 60},
-	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_WUXGA,      A_W, 1920, 1200, 0, 60},
+	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_480I,       A_N,  720,  480},
+	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_480P,       A_N,  720,  480},
+	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_720P_60HZ,  A_N, 1280,  720},
+	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080I_60HZ, A_W, 1920, 1080},
+	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080P_60HZ, A_W, 1920, 1080},
+	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_576I,       A_N,  720,  576},
+	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_576P,       A_N,  720,  576},
+	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_720P_50HZ,  A_N, 1280,  720},
+	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080I_50HZ, A_W, 1920, 1080},
+	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080P_50HZ, A_W, 1920, 1080},
+	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_WXGA,       A_W, 1280,  768},
+	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_SXGA,       A_N, 1280, 1024},
+	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_WUXGA,      A_W, 1920, 1200},
 };
 
 /* supported CIDs */
@@ -889,36 +887,6 @@ int ps3av_get_mode(void)
 
 EXPORT_SYMBOL_GPL(ps3av_get_mode);
 
-int ps3av_get_scanmode(int id)
-{
-	int size;
-
-	id = id & PS3AV_MODE_MASK;
-	size = ARRAY_SIZE(video_mode_table);
-	if (id > size - 1 || id < 0) {
-		printk(KERN_ERR "%s: invalid mode %d\n", __func__, id);
-		return -EINVAL;
-	}
-	return video_mode_table[id].interlace;
-}
-
-EXPORT_SYMBOL_GPL(ps3av_get_scanmode);
-
-int ps3av_get_refresh_rate(int id)
-{
-	int size;
-
-	id = id & PS3AV_MODE_MASK;
-	size = ARRAY_SIZE(video_mode_table);
-	if (id > size - 1 || id < 0) {
-		printk(KERN_ERR "%s: invalid mode %d\n", __func__, id);
-		return -EINVAL;
-	}
-	return video_mode_table[id].freq;
-}
-
-EXPORT_SYMBOL_GPL(ps3av_get_refresh_rate);
-
 /* get resolution by video_mode */
 int ps3av_video_mode2res(u32 id, u32 *xres, u32 *yres)
 {
--- a/include/asm-powerpc/ps3av.h
+++ b/include/asm-powerpc/ps3av.h
@@ -713,8 +713,6 @@ extern int ps3av_set_video_mode(u32);
 extern int ps3av_set_audio_mode(u32, u32, u32, u32, u32);
 extern int ps3av_get_auto_mode(void);
 extern int ps3av_get_mode(void);
-extern int ps3av_get_scanmode(int);
-extern int ps3av_get_refresh_rate(int);
 extern int ps3av_video_mode2res(u32, u32 *, u32 *);
 extern int ps3av_video_mute(int);
 extern int ps3av_audio_mute(int);

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
