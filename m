Date: Wed, 23 Oct 2002 16:49:07 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Compile fixes for linuxppc-2.5
Message-ID: <Pine.LNX.4.32.0210231642560.19486-100000@gra-vd1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi all,

I just tried my first bleeding edge compile from the linuxppc-2.5
bk repository. It did not compile without the appened patch. The
first part looks obviously correct since it was the only usage
of lcd_on which was not hidden by a CONFIG_PMAC_PBOOK. I'm less
sure about the second part, it may be due to the fact that I have
I have an unconventional configuration (no modules), but nevertheless.

	Gabriel.

===== drivers/video/aty128fb.c 1.16 vs edited =====
--- 1.16/drivers/video/aty128fb.c	Mon Aug 19 14:45:44 2002
+++ edited/drivers/video/aty128fb.c	Wed Oct 23 14:54:39 2002
@@ -2099,8 +2099,10 @@
 	struct aty128fb_par *par = data;
 	unsigned int reg = aty_ld_le32(LVDS_GEN_CNTL);

+#ifdef CONFIG_PMAC_PBOOK
 	if (!par->lcd_on)
 		on = 0;
+#endif
 	reg |= LVDS_BL_MOD_EN | LVDS_BLON;
 	if (on && level > BACKLIGHT_OFF) {
 		reg |= LVDS_DIGION;
===== include/sound/initval.h 1.2 vs edited =====
--- 1.2/include/sound/initval.h	Tue Jun 11 18:30:46 2002
+++ edited/include/sound/initval.h	Wed Oct 23 16:30:48 2002
@@ -145,6 +145,7 @@
 #if defined(SNDRV_GET_ID) && !defined(MODULE)
 #include <linux/ctype.h>
 #include <linux/init.h>
+#include <linux/slab.h>
 static int __init get_id(char **str, char **dst)
 {
 	char *s, *d;


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
