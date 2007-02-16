Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id F1E13DDEF0
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:04:01 +1100 (EST)
Date: Fri, 16 Feb 2007 17:03:58 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH extra] ps3fb: atomic fixes
In-Reply-To: <20070215165916.de546f0d.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.62.0702161700040.8263@pademelon.sonytel.be>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
	<20070215175007.GA10817@lst.de>
	<1171575817.5644.44.camel@localhost.localdomain>
	<20070215165916.de546f0d.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-fbdev-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ps3fb: Use atomic_dec_if_positive() instead of bogus atomic_read()/atomic_dec()
combinations

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

--- ps3-linux-2.6.20.orig/drivers/video/ps3fb.c
+++ ps3-linux-2.6.20/drivers/video/ps3fb.c
@@ -680,13 +680,10 @@ EXPORT_SYMBOL_GPL(ps3fb_wait_for_vsync);
 
 void ps3fb_flip_ctl(int on)
 {
-	if (on) {
-		if (atomic_read(&ps3fb.ext_flip) > 0) {
-			atomic_dec(&ps3fb.ext_flip);
-		}
-	} else {
+	if (on)
+		atomic_dec_if_positive(&ps3fb.ext_flip);
+	else
 		atomic_inc(&ps3fb.ext_flip);
-	}
 }
 
 EXPORT_SYMBOL_GPL(ps3fb_flip_ctl);
@@ -786,8 +783,7 @@ static int ps3fb_ioctl(struct fb_info *i
 
 	case PS3FB_IOCTL_OFF:
 		DPRINTK("PS3FB_IOCTL_OFF:\n");
-		if (atomic_read(&ps3fb.ext_flip) > 0)
-			atomic_dec(&ps3fb.ext_flip);
+		atomic_dec_if_positive(&ps3fb.ext_flip);
 		retval = 0;
 		break;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
