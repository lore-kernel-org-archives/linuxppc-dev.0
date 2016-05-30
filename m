Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJQrR6HgKzDqXj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 04:58:47 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org,
 gregkh@linuxfoundation.org, deller@gmx.de, benh@kernel.crashing.org,
 mpe@ellerman.id.au, dalias@libc.org, dhowells@redhat.com,
 linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v4 13/16] char/genrtc: remove powerpc support
Date: Mon, 30 May 2016 20:58:01 +0200
Message-Id: <1464634684-1248135-14-git-send-email-arnd@arndb.de>
In-Reply-To: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerPC is the last architecture using the GEN_RTC driver on some
machines, but we can migrate them all to using the RTC_DRV_GENERIC
driver instead now.

This moves over the CONFIG_GEN_RTC option from drivers/char into
arch/powerpc/platforms/Kconfig and makes it just select the
replacement driver instead, for the only reason of not breaking
existing defconfig and .config files that users may have.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/rtc.h    | 78 ---------------------------------------
 arch/powerpc/platforms/Kconfig    | 11 ++++++
 arch/powerpc/platforms/ps3/time.c |  2 +-
 drivers/char/Kconfig              |  4 +-
 drivers/char/Makefile             |  2 +-
 5 files changed, 15 insertions(+), 82 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/rtc.h

diff --git a/arch/powerpc/include/asm/rtc.h b/arch/powerpc/include/asm/rtc.h
deleted file mode 100644
index f5802926b6c0..000000000000
--- a/arch/powerpc/include/asm/rtc.h
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * Real-time clock definitions and interfaces
- *
- * Author: Tom Rini <trini@mvista.com>
- *
- * 2002 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Based on:
- * include/asm-m68k/rtc.h
- *
- * Copyright Richard Zidlicky
- * implementation details for genrtc/q40rtc driver
- *
- * And the old drivers/macintosh/rtc.c which was heavily based on:
- * Linux/SPARC Real Time Clock Driver
- * Copyright (C) 1996 Thomas K. Dyas (tdyas@eden.rutgers.edu)
- *
- * With additional work by Paul Mackerras and Franz Sirl.
- */
-
-#ifndef __ASM_POWERPC_RTC_H__
-#define __ASM_POWERPC_RTC_H__
-
-#ifdef __KERNEL__
-
-#include <linux/rtc.h>
-
-#include <asm/machdep.h>
-#include <asm/time.h>
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
-	if (ppc_md.get_rtc_time)
-		ppc_md.get_rtc_time(time);
-	return RTC_24H;
-}
-
-/* Set the current date and time in the real time clock. */
-static inline int set_rtc_time(struct rtc_time *time)
-{
-	if (ppc_md.set_rtc_time)
-		return ppc_md.set_rtc_time(time);
-	return -EINVAL;
-}
-
-static inline unsigned int get_rtc_ss(void)
-{
-	struct rtc_time h;
-
-	get_rtc_time(&h);
-	return h.tm_sec;
-}
-
-static inline int get_rtc_pll(struct rtc_pll_info *pll)
-{
-	return -EINVAL;
-}
-static inline int set_rtc_pll(struct rtc_pll_info *pll)
-{
-	return -EINVAL;
-}
-
-#endif /* __KERNEL__ */
-#endif /* __ASM_POWERPC_RTC_H__ */
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 46a3533d3acb..863aa4341390 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -321,6 +321,17 @@ config OF_RTC
 	  Uses information from the OF or flattened device tree to instantiate
 	  platform devices for direct mapped RTC chips like the DS1742 or DS1743.
 
+config GEN_RTC
+	bool "Use the platform RTC operations from user space"
+	select RTC_CLASS
+	select RTC_DRV_GENERIC
+	help
+	  This option provides backwards compatibility with the old gen_rtc.ko
+	  module that was traditionally used for old PowerPC machines.
+	  Platforms should migrate to enabling the RTC_DRV_GENERIC by hand
+	  replacing their get_rtc_time/set_rtc_time callbacks with
+	  a proper RTC device driver.
+
 config SIMPLE_GPIO
 	bool "Support for simple, memory-mapped GPIO controllers"
 	depends on PPC
diff --git a/arch/powerpc/platforms/ps3/time.c b/arch/powerpc/platforms/ps3/time.c
index 791c6142c4a7..11b45b58c81b 100644
--- a/arch/powerpc/platforms/ps3/time.c
+++ b/arch/powerpc/platforms/ps3/time.c
@@ -20,9 +20,9 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/rtc.h>
 
 #include <asm/firmware.h>
-#include <asm/rtc.h>
 #include <asm/lv1call.h>
 #include <asm/ps3.h>
 
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index fccac76257c9..153e90f8a445 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -325,10 +325,10 @@ config JS_RTC
 	  To compile this driver as a module, choose M here: the
 	  module will be called js-rtc.
 
-config GEN_RTC
+config OLD_GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y
-	depends on PPC
+	depends on BROKEN
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index d8a7579300d2..fc0905aa7373 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_APPLICOM)		+= applicom.o
 obj-$(CONFIG_SONYPI)		+= sonypi.o
 obj-$(CONFIG_RTC)		+= rtc.o
 obj-$(CONFIG_HPET)		+= hpet.o
-obj-$(CONFIG_GEN_RTC)		+= genrtc.o
+obj-$(CONFIG_OLD_GEN_RTC)	+= genrtc.o
 obj-$(CONFIG_EFI_RTC)		+= efirtc.o
 obj-$(CONFIG_DS1302)		+= ds1302.o
 obj-$(CONFIG_XILINX_HWICAP)	+= xilinx_hwicap/
-- 
2.7.0
