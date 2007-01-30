Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 3769CDDFB1
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 04:03:10 +1100 (EST)
Date: Tue, 30 Jan 2007 18:03:08 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 9/10] ps3: cleanup ps3fb before clearing HPTE
In-Reply-To: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0701301802500.29487@pademelon.sonytel.be>
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

PS3: Cleanup the frame buffer device before clearing the HPTE mapping

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/platforms/ps3/htab.c |    6 +++++-
 include/asm-powerpc/ps3fb.h       |    2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

--- ps3-linux-2.6.20-rc6.orig/arch/powerpc/platforms/ps3/htab.c
+++ ps3-linux-2.6.20-rc6/arch/powerpc/platforms/ps3/htab.c
@@ -2,7 +2,7 @@
  *  PS3 pagetable management routines.
  *
  *  Copyright (C) 2006 Sony Computer Entertainment Inc.
- *  Copyright 2006 Sony Corp.
+ *  Copyright 2006, 2007 Sony Corporation
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -24,6 +24,7 @@
 #include <asm/lmb.h>
 #include <asm/udbg.h>
 #include <asm/lv1call.h>
+#include <asm/ps3fb.h>
 
 #include "platform.h"
 
@@ -233,6 +234,9 @@ static void ps3_hpte_invalidate(unsigned
 
 static void ps3_hpte_clear(void)
 {
+	/* Make sure to clean up the frame buffer device first */
+	ps3fb_cleanup();
+
 	lv1_unmap_htab(htab_addr);
 }
 
--- ps3-linux-2.6.20-rc6.orig/include/asm-powerpc/ps3fb.h
+++ ps3-linux-2.6.20-rc6/include/asm-powerpc/ps3fb.h
@@ -45,8 +45,10 @@ struct ps3fb_ioctl_res {
 
 #ifdef CONFIG_FB_PS3
 extern void ps3fb_flip_ctl(int);
+extern void ps3fb_cleanup(void);
 #else
 static inline void ps3fb_flip_ctl(int) {}
+static inline void ps3fb_cleanup(void) {}
 #endif
 
 #endif /* __KERNEL__ */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
