Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id E204EDE025
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 04:06:06 +1100 (EST)
Date: Tue, 30 Jan 2007 18:06:05 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/10] fbdev modedb: allow refresh rates for named video modes
In-Reply-To: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0701301805480.29487@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
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

fbdev modedb: Take into account the specified refresh rates for video modes
specified by name, so e.g. all of `720p', `720p@60', and `720p@50' work.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/modedb.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- ps3-linux-2.6.20-rc6.orig/drivers/video/modedb.c
+++ ps3-linux-2.6.20-rc6/drivers/video/modedb.c
@@ -610,10 +610,8 @@ done:
 	diff = refresh;
 	best = -1;
 	for (i = 0; i < dbsize; i++) {
-		if ((name_matches(db[i], name, namelen) &&
-			!fb_try_mode(var, info, &db[i], bpp)))
-			return 1;
-		if (res_specified && res_matches(db[i], xres, yres)) {
+		if (name_matches(db[i], name, namelen) ||
+		    (res_specified && res_matches(db[i], xres, yres))) {
 			if(!fb_try_mode(var, info, &db[i], bpp)) {
 				if(!refresh_specified || db[i].refresh == refresh)
 					return 1;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
