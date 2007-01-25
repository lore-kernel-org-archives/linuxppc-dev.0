Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 1B429DDEBA
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 04:49:54 +1100 (EST)
Date: Thu, 25 Jan 2007 18:49:52 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/9] fb_videomode_to_var: reset virtual screen parameters
In-Reply-To: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0701251849270.24610@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

fb_videomode_to_var(): reset the virtual screen parameters when converting from
an fb_videomode to an fb_var_screeninfo.

Without this the old virtual screen parameters are kept. Hence you cannot
switch to a video mode with a lower resolution on frame buffer devices that
don't support virtual screens and panning, as values are not supposed to be
rounded down when they don't fit.

I also reordered the assignments to match the order of the individual members.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/modedb.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

--- ps3-linux.orig/drivers/video/modedb.c
+++ ps3-linux/drivers/video/modedb.c
@@ -716,13 +716,17 @@ void fb_videomode_to_var(struct fb_var_s
 {
 	var->xres = mode->xres;
 	var->yres = mode->yres;
+	var->xres_virtual = mode->xres;
+	var->yres_virtual = mode->yres;
+	var->xoffset = 0;
+	var->yoffset = 0;
 	var->pixclock = mode->pixclock;
 	var->left_margin = mode->left_margin;
-	var->hsync_len = mode->hsync_len;
-	var->vsync_len = mode->vsync_len;
 	var->right_margin = mode->right_margin;
 	var->upper_margin = mode->upper_margin;
 	var->lower_margin = mode->lower_margin;
+	var->hsync_len = mode->hsync_len;
+	var->vsync_len = mode->vsync_len;
 	var->sync = mode->sync;
 	var->vmode = mode->vmode & FB_VMODE_MASK;
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
