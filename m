Return-Path: <adaplas@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 865F6DDDE7
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 12:16:00 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id p76so86185pyb
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 18:15:59 -0700 (PDT)
Subject: Re: [PATCH 13/13] fix ps3fb glue allowing a modular build
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0703141040030.28462@pademelon.sonytel.be>
References: <E1HRPbU-0003Ha-Oq@ZenIV.linux.org.uk>
	<Pine.LNX.4.62.0703141040030.28462@pademelon.sonytel.be>
Content-Type: multipart/mixed; boundary="=-Oe5lRfO+wWHXodcYjLbp"
Date: Thu, 15 Mar 2007 09:17:07 +0800
Message-Id: <1173921427.12329.3.camel@daplas>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Oe5lRfO+wWHXodcYjLbp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2007-03-14 at 10:50 +0100, Geert Uytterhoeven wrote:
> On Wed, 14 Mar 2007, Al Viro wrote:
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 

> And finally, make sure CONFIG_LOGO=n, as there's a bug in the logo code: logos
> are __initdata but the logo code still tries to draw them for a modular fbdev.
> Originally (eons ago) this case was handled by the flag initmem_freed, which no
> longer exists.
> 

True, I tried to prevent the logo from being drawn if the driver is
loaded first prior to fbcon, but the code will still draw the logo if
the load order is reversed.  Can you try this patch?  It will only
permit the drawing of the logo if both the driver and fbcon are compiled
statically.

Tony

--=-Oe5lRfO+wWHXodcYjLbp
Content-Disposition: attachment; filename=logo_fix.diff
Content-Type: text/x-patch; name=logo_fix.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index bd131d4..12e8a3b 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -107,7 +107,9 @@ static struct display fb_display[MAX_NR_
 
 static signed char con2fb_map[MAX_NR_CONSOLES];
 static signed char con2fb_map_boot[MAX_NR_CONSOLES];
+#ifndef MODULE
 static int logo_height;
+#endif
 static int logo_lines;
 /* logo_shown is an index to vc_cons when >= 0; otherwise follows FBCON_LOGO
    enums.  */
@@ -576,6 +578,13 @@ static int fbcon_takeover(int show_logo)
 	return err;
 }
 
+#ifdef MODULE
+static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
+			       int cols, int rows, int new_cols, int new_rows)
+{
+	logo_shown = FBCON_LOGO_DONTSHOW;
+}
+#else
 static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 			       int cols, int rows, int new_cols, int new_rows)
 {
@@ -584,6 +593,11 @@ static void fbcon_prepare_logo(struct vc
 	int cnt, erase = vc->vc_video_erase_char, step;
 	unsigned short *save = NULL, *r, *q;
 
+	if (info->flags & FBINFO_MODULE) {
+		logo_shown = FBCON_LOGO_DONTSHOW;
+		goto done;
+	}
+
 	/*
 	 * remove underline attribute from erase character
 	 * if black and white framebuffer.
@@ -654,7 +668,10 @@ static void fbcon_prepare_logo(struct vc
 		logo_shown = FBCON_LOGO_DRAW;
 		vc->vc_top = logo_lines;
 	}
+
+done:
 }
+#endif /* MODULE */
 
 #ifdef CONFIG_FB_TILEBLITTING
 static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 45f3839..08c292d 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -418,7 +418,8 @@ int fb_prepare_logo(struct fb_info *info
 
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
-	if (info->flags & FBINFO_MISC_TILEBLITTING)
+	if (info->flags & FBINFO_MISC_TILEBLITTING ||
+	    info->flags & FBINFO_MODULE)
 		return 0;
 
 	if (info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
@@ -483,7 +484,8 @@ int fb_show_logo(struct fb_info *info, i
 	struct fb_image image;
 
 	/* Return if the frame buffer is not mapped or suspended */
-	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
+	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING ||
+	    info->flags & FBINFO_MODULE)
 		return 0;
 
 	image.depth = 8;

--=-Oe5lRfO+wWHXodcYjLbp--
