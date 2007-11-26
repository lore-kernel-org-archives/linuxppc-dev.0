Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id D580BDE179
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 04:27:50 +1100 (EST)
Message-Id: <20071126172712.338327000@pademelon.sonytel.be>
References: <20071126172455.308741000@pademelon.sonytel.be>
Date: Mon, 26 Nov 2007 18:24:59 +0100
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: [patch 4/9] ps3fb: Inline macros that are used only once
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: inline the X_OFF(), Y_OFF(), WIDTH(), HEIGHT(), and VP_OFF() macros,
as they're used in one place only

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -286,15 +286,8 @@ static const struct fb_videomode ps3fb_m
 #define HEAD_A
 #define HEAD_B
 
-#define X_OFF(i)	(ps3fb_res[i].xoff)	/* left/right margin (pixel) */
-#define Y_OFF(i)	(ps3fb_res[i].yoff)	/* top/bottom margin (pixel) */
-#define WIDTH(i)	(ps3fb_res[i].xres)	/* width of FB */
-#define HEIGHT(i)	(ps3fb_res[i].yres)	/* height of FB */
 #define BPP		4			/* number of bytes per pixel */
 
-/* Start of the virtual frame buffer (relative to fullscreen ) */
-#define VP_OFF(i)	((WIDTH(i) * Y_OFF(i) + X_OFF(i)) * BPP)
-
 
 static int ps3fb_mode;
 module_param(ps3fb_mode, int, 0);
@@ -609,7 +602,10 @@ static int ps3fb_set_par(struct fb_info 
 
 	par->width = info->var.xres;
 	par->height = info->var.yres;
-	offset = VP_OFF(i);
+
+	/* Start of the virtual frame buffer (relative to fullscreen) */
+	offset = ps3fb_res[i].yoff * ddr_line_length + ps3fb_res[i].xoff * BPP;
+
 	par->fb_offset = GPU_ALIGN_UP(offset);
 	par->full_offset = par->fb_offset - offset;
 	par->pan_offset = info->var.yoffset * xdr_line_length +

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
