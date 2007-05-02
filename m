Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 1B3B6DDEEF
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 22:49:45 +1000 (EST)
Message-Id: <20070502124840.650035000@pademelon.sonytel.be>
References: <20070502124830.911142000@pademelon.sonytel.be>
Date: Wed, 02 May 2007 14:48:36 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 6/8] ps3: Make `ps3videomode -v 0 (auto mode) work again
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

From: Masashi Kimoto <Masashi_Kimoto@hq.scei.sony.co.jp>

ps3: Make `ps3videomode -v 0' (auto mode) work again

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c         |    7 +++++++
 drivers/video/ps3fb.c       |    5 +++++
 include/asm-powerpc/ps3av.h |    1 +
 3 files changed, 13 insertions(+)

--- ps3-linux-2.6.21.orig/drivers/ps3/ps3av.c
+++ ps3-linux-2.6.21/drivers/ps3/ps3av.c
@@ -744,6 +744,13 @@ int ps3av_set_video_mode(u32 id, int boo
 
 EXPORT_SYMBOL_GPL(ps3av_set_video_mode);
 
+int ps3av_get_auto_mode(int boot)
+{
+	return ps3av_auto_videomode(&ps3av.av_hw_conf, boot);
+}
+
+EXPORT_SYMBOL_GPL(ps3av_get_auto_mode);
+
 int ps3av_set_mode(u32 id, int boot)
 {
 	int res;
--- ps3-linux-2.6.21.orig/drivers/video/ps3fb.c
+++ ps3-linux-2.6.21/drivers/video/ps3fb.c
@@ -732,6 +732,11 @@ static int ps3fb_ioctl(struct fb_info *i
 			if (copy_from_user(&val, argp, sizeof(val)))
 				break;
 
+			if (!(val & PS3AV_MODE_MASK)) {
+				u32 id = ps3av_get_auto_mode(0);
+				if (id > 0)
+					val = (val & ~PS3AV_MODE_MASK) | id;
+			}
 			DPRINTK("PS3FB_IOCTL_SETMODE:%x\n", val);
 			retval = -EINVAL;
 			old_mode = ps3fb_mode;
--- ps3-linux-2.6.21.orig/include/asm-powerpc/ps3av.h
+++ ps3-linux-2.6.21/include/asm-powerpc/ps3av.h
@@ -706,6 +706,7 @@ extern int ps3av_vuart_read(struct ps3_v
 
 extern int ps3av_set_video_mode(u32, int);
 extern int ps3av_set_audio_mode(u32, u32, u32, u32, u32);
+extern int ps3av_get_auto_mode(int);
 extern int ps3av_set_mode(u32, int);
 extern int ps3av_get_mode(void);
 extern int ps3av_get_scanmode(int);

--
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
