Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwFD50rs4zDqBG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 08:35:48 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v3 11/16] char/genrtc: remove m68k support
Date: Thu, 28 Apr 2016 00:34:25 +0200
Message-Id: <1461796470-1291527-12-git-send-email-arnd@arndb.de>
In-Reply-To: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The asm/rtc.h header is only used for the old gen_rtc driver
that has been replaced by rtc-generic. According to Geert
Uytterhoeven, nobody has used the old driver on m68k for
a long time, so we can now just remove the header file
and disallow the driver in Kconfig.

All files that used to include asm/rtc.h are now changed so
they include the headers that were used implicitly through
asm/rtc.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/amiga/config.c    |  1 -
 arch/m68k/apollo/config.c   |  1 -
 arch/m68k/bvme6000/config.c |  1 -
 arch/m68k/hp300/config.c    |  2 +-
 arch/m68k/include/asm/rtc.h | 79 ---------------------------------------------
 arch/m68k/mac/config.c      |  3 +-
 arch/m68k/mac/misc.c        |  1 -
 arch/m68k/mvme147/config.c  |  1 -
 arch/m68k/mvme16x/config.c  |  1 -
 arch/m68k/q40/config.c      |  2 +-
 arch/m68k/sun3/config.c     |  1 -
 arch/m68k/sun3/intersil.c   |  2 +-
 arch/m68k/sun3x/time.c      |  2 +-
 drivers/char/Kconfig        |  2 +-
 14 files changed, 7 insertions(+), 92 deletions(-)
 delete mode 100644 arch/m68k/include/asm/rtc.h

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 01693df7f2f6..ec9cc1fdd237 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -35,7 +35,6 @@
 #include <asm/amigahw.h>
 #include <asm/amigaints.h>
 #include <asm/irq.h>
-#include <asm/rtc.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
 
diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index 6e62d66c396e..432bc8bacfc2 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -15,7 +15,6 @@
 #include <asm/pgtable.h>
 #include <asm/apollohw.h>
 #include <asm/irq.h>
-#include <asm/rtc.h>
 #include <asm/machdep.h>
 
 u_long sio01_physaddr;
diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index 478623dbb209..611d4d9ea2bd 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -34,7 +34,6 @@
 #include <asm/setup.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
-#include <asm/rtc.h>
 #include <asm/machdep.h>
 #include <asm/bvme6000hw.h>
 
diff --git a/arch/m68k/hp300/config.c b/arch/m68k/hp300/config.c
index a9befe65adc4..7cfab158fb61 100644
--- a/arch/m68k/hp300/config.c
+++ b/arch/m68k/hp300/config.c
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/console.h>
+#include <linux/rtc.h>
 
 #include <asm/bootinfo.h>
 #include <asm/bootinfo-hp300.h>
@@ -20,7 +21,6 @@
 #include <asm/blinken.h>
 #include <asm/io.h>                               /* readb() and writeb() */
 #include <asm/hp300hw.h>
-#include <asm/rtc.h>
 
 #include "time.h"
 
diff --git a/arch/m68k/include/asm/rtc.h b/arch/m68k/include/asm/rtc.h
deleted file mode 100644
index a4d08ea122ee..000000000000
--- a/arch/m68k/include/asm/rtc.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* include/asm-m68k/rtc.h
- *
- * Copyright Richard Zidlicky
- * implementation details for genrtc/q40rtc driver
- */
-/* permission is hereby granted to copy, modify and redistribute this code
- * in terms of the GNU Library General Public License, Version 2 or later,
- * at your option.
- */
-
-#ifndef _ASM_RTC_H
-#define _ASM_RTC_H
-
-#ifdef __KERNEL__
-
-#include <linux/rtc.h>
-#include <asm/errno.h>
-#include <asm/machdep.h>
-
-#define RTC_PIE 0x40		/* periodic interrupt enable */
-#define RTC_AIE 0x20		/* alarm interrupt enable */
-#define RTC_UIE 0x10		/* update-finished interrupt enable */
-
-/* some dummy definitions */
-#define RTC_BATT_BAD 0x100	/* battery bad */
-#define RTC_SQWE 0x08		/* enable square-wave output */
-#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
-#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
-#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
-
-static inline unsigned int get_rtc_time(struct rtc_time *time)
-{
-	/*
-	 * Only the values that we read from the RTC are set. We leave
-	 * tm_wday, tm_yday and tm_isdst untouched. Even though the
-	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
-	 * by the RTC when initially set to a non-zero value.
-	 */
-	if (mach_hwclk)
-		mach_hwclk(0, time);
-	return RTC_24H;
-}
-
-static inline int set_rtc_time(struct rtc_time *time)
-{
-	if (mach_hwclk)
-		return mach_hwclk(1, time);
-	return -EINVAL;
-}
-
-static inline unsigned int get_rtc_ss(void)
-{
-	if (mach_get_ss)
-		return mach_get_ss();
-	else{
-		struct rtc_time h;
-
-		get_rtc_time(&h);
-		return h.tm_sec;
-	}
-}
-
-static inline int get_rtc_pll(struct rtc_pll_info *pll)
-{
-	if (mach_get_rtc_pll)
-		return mach_get_rtc_pll(pll);
-	else
-		return -EINVAL;
-}
-static inline int set_rtc_pll(struct rtc_pll_info *pll)
-{
-	if (mach_set_rtc_pll)
-		return mach_set_rtc_pll(pll);
-	else
-		return -EINVAL;
-}
-#endif /* __KERNEL__ */
-
-#endif /* _ASM__RTC_H */
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 689b47d292ac..2f33a33001e5 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -10,6 +10,7 @@
  * Miscellaneous linux stuff
  */
 
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/mm.h>
@@ -25,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
+#include <linux/rtc.h>
 
 #include <asm/setup.h>
 #include <asm/bootinfo.h>
@@ -34,7 +36,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/pgtable.h>
-#include <asm/rtc.h>
 #include <asm/machdep.h>
 
 #include <asm/macintosh.h>
diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 707b61aea203..0fb54a90eac2 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -18,7 +18,6 @@
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
-#include <asm/rtc.h>
 #include <asm/segment.h>
 #include <asm/setup.h>
 #include <asm/macintosh.h>
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index e6a3b56c6481..c11d38dfad08 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -32,7 +32,6 @@
 #include <asm/setup.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
-#include <asm/rtc.h>
 #include <asm/machdep.h>
 #include <asm/mvme147hw.h>
 
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index a53803cc66cd..58e240939d26 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -35,7 +35,6 @@
 #include <asm/setup.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
-#include <asm/rtc.h>
 #include <asm/machdep.h>
 #include <asm/mvme16xhw.h>
 
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index e90fe903613e..fcb7f05b60b6 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -12,6 +12,7 @@
  * for more details.
  */
 
+#include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -27,7 +28,6 @@
 #include <linux/platform_device.h>
 
 #include <asm/io.h>
-#include <asm/rtc.h>
 #include <asm/bootinfo.h>
 #include <asm/pgtable.h>
 #include <asm/setup.h>
diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index 71884bf01d72..3af34fa3a344 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -26,7 +26,6 @@
 #include <asm/pgalloc.h>
 #include <asm/sun3-head.h>
 #include <asm/sun3mmu.h>
-#include <asm/rtc.h>
 #include <asm/machdep.h>
 #include <asm/machines.h>
 #include <asm/idprom.h>
diff --git a/arch/m68k/sun3/intersil.c b/arch/m68k/sun3/intersil.c
index 889829e11f1d..2cd0bcbe6f30 100644
--- a/arch/m68k/sun3/intersil.c
+++ b/arch/m68k/sun3/intersil.c
@@ -14,8 +14,8 @@
 #include <linux/rtc.h>
 
 #include <asm/errno.h>
-#include <asm/rtc.h>
 #include <asm/intersil.h>
+#include <asm/machdep.h>
 
 
 /* bits to set for start/run of the intersil */
diff --git a/arch/m68k/sun3x/time.c b/arch/m68k/sun3x/time.c
index c8eb08add6b0..431d3c4306dd 100644
--- a/arch/m68k/sun3x/time.c
+++ b/arch/m68k/sun3x/time.c
@@ -15,10 +15,10 @@
 
 #include <asm/irq.h>
 #include <asm/io.h>
+#include <asm/machdep.h>
 #include <asm/traps.h>
 #include <asm/sun3x.h>
 #include <asm/sun3ints.h>
-#include <asm/rtc.h>
 
 #include "time.h"
 
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index abab6e565c60..26089feae9b0 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -328,7 +328,7 @@ config JS_RTC
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y
-	depends on M68K || PPC
+	depends on PPC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- 
2.7.0
