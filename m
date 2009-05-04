Return-Path: <krzysztof.h1@poczta.fm>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by ozlabs.org (Postfix) with ESMTP id B2960DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 03:28:28 +1000 (EST)
Date: Mon, 4 May 2009 19:07:24 +0200
From: Krzysztof Helt <krzysztof.h1@poczta.fm>
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] offb: use framebuffer_alloc() to allocate fb_info struct
Message-Id: <20090504190724.c2dfb53c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use the framebuffer_alloc() function to allocate the fb_info
structure so the structure is correctly initialized after allocation.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-orig/drivers/video/offb.c linux-2.6.30/drivers/video/offb.c
--- linux-orig/drivers/video/offb.c	2008-08-09 05:09:05.000000000 +0200
+++ linux-2.6.30/drivers/video/offb.c	2009-05-04 00:14:28.000000000 +0200
@@ -378,7 +378,6 @@ static void __init offb_init_fb(const ch
 	struct fb_fix_screeninfo *fix;
 	struct fb_var_screeninfo *var;
 	struct fb_info *info;
-	int size;
 
 	if (!request_mem_region(res_start, res_size, "offb"))
 		return;
@@ -393,15 +392,12 @@ static void __init offb_init_fb(const ch
 		return;
 	}
 
-	size = sizeof(struct fb_info) + sizeof(u32) * 16;
-
-	info = kmalloc(size, GFP_ATOMIC);
+	info = framebuffer_alloc(sizeof(u32) * 16, NULL);
 	
 	if (info == 0) {
 		release_mem_region(res_start, res_size);
 		return;
 	}
-	memset(info, 0, size);
 
 	fix = &info->fix;
 	var = &info->var;

----------------------------------------------------------------------
Wygraj 3000 zl, wycieczke lub lot balonem!
Sprawdz >> http://link.interia.pl/f2154
