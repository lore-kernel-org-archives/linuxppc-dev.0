Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJQrN0mj9zDqVt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 04:58:43 +1000 (AEST)
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
Subject: [PATCH v4 08/16] char/genrtc: remove parisc support
Date: Mon, 30 May 2016 20:57:56 +0200
Message-Id: <1464634684-1248135-9-git-send-email-arnd@arndb.de>
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

This architecture selects RTC_CLASS unconditionally, so the GEN_RTC
has not worked here for a long time.

Now we can remove both the asm/rtc.h header and the Kconfig dependency
for CONFIG_GEN_RTC.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/include/asm/rtc.h | 131 ------------------------------------------
 drivers/char/Kconfig          |   2 +-
 2 files changed, 1 insertion(+), 132 deletions(-)
 delete mode 100644 arch/parisc/include/asm/rtc.h

diff --git a/arch/parisc/include/asm/rtc.h b/arch/parisc/include/asm/rtc.h
deleted file mode 100644
index 099d641a42c2..000000000000
--- a/arch/parisc/include/asm/rtc.h
+++ /dev/null
@@ -1,131 +0,0 @@
-/* 
- * include/asm-parisc/rtc.h
- *
- * Copyright 2002 Randolph CHung <tausq@debian.org>
- *
- * Based on: include/asm-ppc/rtc.h and the genrtc driver in the
- * 2.4 parisc linux tree
- */
-
-#ifndef __ASM_RTC_H__
-#define __ASM_RTC_H__
-
-#ifdef __KERNEL__
-
-#include <linux/rtc.h>
-
-#include <asm/pdc.h>
-
-#define SECS_PER_HOUR   (60 * 60)
-#define SECS_PER_DAY    (SECS_PER_HOUR * 24)
-
-
-#define RTC_PIE 0x40		/* periodic interrupt enable */
-#define RTC_AIE 0x20		/* alarm interrupt enable */
-#define RTC_UIE 0x10		/* update-finished interrupt enable */
-
-#define RTC_BATT_BAD 0x100	/* battery bad */
-
-/* some dummy definitions */
-#define RTC_SQWE 0x08		/* enable square-wave output */
-#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
-#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
-#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
-
-# define __isleap(year) \
-  ((year) % 4 == 0 && ((year) % 100 != 0 || (year) % 400 == 0))
-
-/* How many days come before each month (0-12).  */
-static const unsigned short int __mon_yday[2][13] =
-{
-	/* Normal years.  */
-	{ 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365 },
-	/* Leap years.  */
-	{ 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366 }
-};
-
-static inline unsigned int get_rtc_time(struct rtc_time *wtime)
-{
-	struct pdc_tod tod_data;
-	long int days, rem, y;
-	const unsigned short int *ip;
-
-	memset(wtime, 0, sizeof(*wtime));
-	if (pdc_tod_read(&tod_data) < 0)
-		return RTC_24H | RTC_BATT_BAD;
-
-	// most of the remainder of this function is:
-//	Copyright (C) 1991, 1993, 1997, 1998 Free Software Foundation, Inc.
-//	This was originally a part of the GNU C Library.
-//      It is distributed under the GPL, and was swiped from offtime.c
-
-
-	days = tod_data.tod_sec / SECS_PER_DAY;
-	rem = tod_data.tod_sec % SECS_PER_DAY;
-
-	wtime->tm_hour = rem / SECS_PER_HOUR;
-	rem %= SECS_PER_HOUR;
-	wtime->tm_min = rem / 60;
-	wtime->tm_sec = rem % 60;
-
-	y = 1970;
-
-#define DIV(a, b) ((a) / (b) - ((a) % (b) < 0))
-#define LEAPS_THRU_END_OF(y) (DIV (y, 4) - DIV (y, 100) + DIV (y, 400))
-
-	while (days < 0 || days >= (__isleap (y) ? 366 : 365))
-	{
-		/* Guess a corrected year, assuming 365 days per year.  */
-		long int yg = y + days / 365 - (days % 365 < 0);
-
-		/* Adjust DAYS and Y to match the guessed year.  */
-		days -= ((yg - y) * 365
-			 + LEAPS_THRU_END_OF (yg - 1)
-			 - LEAPS_THRU_END_OF (y - 1));
-		y = yg;
-	}
-	wtime->tm_year = y - 1900;
-
-	ip = __mon_yday[__isleap(y)];
-	for (y = 11; days < (long int) ip[y]; --y)
-		continue;
-	days -= ip[y];
-	wtime->tm_mon = y;
-	wtime->tm_mday = days + 1;
-
-	return RTC_24H;
-}
-
-static int set_rtc_time(struct rtc_time *wtime)
-{
-	u_int32_t secs;
-
-	secs = mktime(wtime->tm_year + 1900, wtime->tm_mon + 1, wtime->tm_mday, 
-		      wtime->tm_hour, wtime->tm_min, wtime->tm_sec);
-
-	if(pdc_tod_set(secs, 0) < 0)
-		return -1;
-	else
-		return 0;
-
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
-#endif /* __ASM_RTC_H__ */
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 1d9e3063373b..074bc394e31b 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -328,7 +328,7 @@ config JS_RTC
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y
-	depends on M68K || PARISC || PPC
+	depends on M68K || PPC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- 
2.7.0
