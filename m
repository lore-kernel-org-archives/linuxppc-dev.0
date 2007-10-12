Return-Path: <geert@sonycom.com>
Message-Id: <20071012145130.182399000@pademelon.sonytel.be>
References: <20071012145052.640177000@pademelon.sonytel.be>
Date: Fri, 12 Oct 2007 16:50:58 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 06/13] ps3fb: Make ps3fb_wait_for_vsync() and ps3fb_flip_ctl()
	static
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

ps3fb: Make ps3fb_wait_for_vsync() and ps3fb_flip_ctl() static, as they're no
(longer) used outside ps3fb.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -652,7 +652,7 @@ static int ps3fb_get_vblank(struct fb_vb
 	return 0;
 }
 
-int ps3fb_wait_for_vsync(u32 crtc)
+static int ps3fb_wait_for_vsync(u32 crtc)
 {
 	int ret;
 	u64 count;
@@ -667,9 +667,7 @@ int ps3fb_wait_for_vsync(u32 crtc)
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ps3fb_wait_for_vsync);
-
-void ps3fb_flip_ctl(int on, void *data)
+static void ps3fb_flip_ctl(int on, void *data)
 {
 	struct ps3fb_priv *priv = data;
 	if (on)

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
