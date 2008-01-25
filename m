Return-Path: <geert@sonycom.com>
Message-Id: <20080125153107.116974131@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
Date: Fri, 25 Jan 2008 16:06:26 +0100
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 03/11] ps3fb: Kill PS3FB_FULL_MODE_BIT
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

ps3fb: Kill PS3FB_FULL_MODE_BIT, use PS3AV_MODE_FULL instead

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -57,8 +57,6 @@
 #define GPU_ALIGN_UP(x)				_ALIGN_UP((x), 64)
 #define GPU_MAX_LINE_LENGTH			(65536 - 64)
 
-#define PS3FB_FULL_MODE_BIT			0x80
-
 #define GPU_INTR_STATUS_VSYNC_0			0	/* vsync on head A */
 #define GPU_INTR_STATUS_VSYNC_1			1	/* vsync on head B */
 #define GPU_INTR_STATUS_FLIP_0			3	/* flip head A */
@@ -310,7 +308,7 @@ static int ps3fb_get_res_table(u32 xres,
 	unsigned int i;
 	u32 x, y, f;
 
-	full_mode = (mode & PS3FB_FULL_MODE_BIT) ? PS3FB_RES_FULL : 0;
+	full_mode = (mode & PS3AV_MODE_FULL) ? PS3FB_RES_FULL : 0;
 	for (i = 0;; i++) {
 		x = ps3fb_res[i].xres;
 		y = ps3fb_res[i].yres;
@@ -373,7 +371,7 @@ found:
 	/* Full broadcast modes have the full mode bit set */
 	mode = i+1;
 	if (mode > PS3AV_MODE_WUXGA)
-		mode = (mode - PS3AV_MODE_WUXGA) | PS3FB_FULL_MODE_BIT;
+		mode = (mode - PS3AV_MODE_WUXGA) | PS3AV_MODE_FULL;
 
 	pr_debug("ps3fb_find_mode: mode %u\n", mode);
 
@@ -390,7 +388,7 @@ static const struct fb_videomode *ps3fb_
 
 	flags = id & ~PS3AV_MODE_MASK;
 
-	if (mode <= PS3AV_MODE_1080P50 && flags & PS3FB_FULL_MODE_BIT) {
+	if (mode <= PS3AV_MODE_1080P50 && flags & PS3AV_MODE_FULL) {
 		/* Full broadcast mode */
 		return &ps3fb_modedb[mode + PS3AV_MODE_WUXGA - 1];
 	}

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
