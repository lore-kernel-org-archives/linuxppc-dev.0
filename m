Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id D6760DEB5E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:59:59 +1100 (EST)
Date: Thu, 8 Feb 2007 14:59:58 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 9/10] ps3: cleanup ps3fb before clearing HPTE
In-Reply-To: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0702081459470.19437@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PS3: Cleanup the frame buffer device before clearing the HPTE mapping

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/platforms/ps3/htab.c |    6 +++++-
 include/asm-powerpc/ps3fb.h       |    2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

--- ps3-linux-2.6.20.orig/arch/powerpc/platforms/ps3/htab.c
+++ ps3-linux-2.6.20/arch/powerpc/platforms/ps3/htab.c
@@ -2,7 +2,7 @@
  *  PS3 pagetable management routines.
  *
  *  Copyright (C) 2006 Sony Computer Entertainment Inc.
- *  Copyright 2006 Sony Corp.
+ *  Copyright 2006, 2007 Sony Corporation
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -25,6 +25,7 @@
 #include <asm/udbg.h>
 #include <asm/ps3.h>
 #include <asm/lv1call.h>
+#include <asm/ps3fb.h>
 
 #include "platform.h"
 
@@ -234,6 +235,9 @@ static void ps3_hpte_invalidate(unsigned
 
 static void ps3_hpte_clear(void)
 {
+	/* Make sure to clean up the frame buffer device first */
+	ps3fb_cleanup();
+
 	lv1_unmap_htab(htab_addr);
 }
 
--- ps3-linux-2.6.20.orig/include/asm-powerpc/ps3fb.h
+++ ps3-linux-2.6.20/include/asm-powerpc/ps3fb.h
@@ -45,8 +45,10 @@ struct ps3fb_ioctl_res {
 
 #ifdef CONFIG_FB_PS3
 extern void ps3fb_flip_ctl(int on);
+extern void ps3fb_cleanup(void);
 #else
 static inline void ps3fb_flip_ctl(int on) {}
+static inline void ps3fb_cleanup(void) {}
 #endif
 
 #endif /* __KERNEL__ */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
