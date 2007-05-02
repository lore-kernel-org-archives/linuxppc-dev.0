Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 6479CDDEF2
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 22:49:43 +1000 (EST)
Message-Id: <20070502124840.253744000@pademelon.sonytel.be>
References: <20070502124830.911142000@pademelon.sonytel.be>
Date: Wed, 02 May 2007 14:48:32 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 2/8] ps3fb: atomic fixes
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: James Simmons <jsimmons@infradead.org>, Antonino Daplas <adaplas@gmail.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linux-fbdev-devel@lists.sourceforge.net
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

--- ps3-linux-2.6.21.orig/drivers/video/ps3fb.c
+++ ps3-linux-2.6.21/drivers/video/ps3fb.c
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
 

--
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
