Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwFKx668RzDqhl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 08:40:53 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v3 05/16] char/genrtc: remove alpha support
Date: Thu, 28 Apr 2016 00:34:19 +0200
Message-Id: <1461796470-1291527-6-git-send-email-arnd@arndb.de>
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

The genrtc driver serves no purpose on Alpha because it drives the
same hardware as the original rtc.c driver, and the newer rtc-generic.c
or rtc-cmos.c drivers on architectures that use the asm-generic/rtc.h
header.

The defconfig uses CONFIG_RTC=y, so this driver is not used by default.
At one point it was used to abstract a quirk for the "Marvel" platform,
but it does not do this any more after the code was moved into yet
another driver in arch/alpha/kernel/rtc.c.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/rtc.h    | 1 -
 arch/alpha/kernel/core_marvel.c | 1 -
 drivers/char/Kconfig            | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)
 delete mode 100644 arch/alpha/include/asm/rtc.h

diff --git a/arch/alpha/include/asm/rtc.h b/arch/alpha/include/asm/rtc.h
deleted file mode 100644
index f71c3b0ed360..000000000000
--- a/arch/alpha/include/asm/rtc.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/rtc.h>
diff --git a/arch/alpha/kernel/core_marvel.c b/arch/alpha/kernel/core_marvel.c
index 53dd2f1a53aa..d5f0580746a5 100644
--- a/arch/alpha/kernel/core_marvel.c
+++ b/arch/alpha/kernel/core_marvel.c
@@ -24,7 +24,6 @@
 #include <asm/gct.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <asm/rtc.h>
 #include <asm/vga.h>
 
 #include "proto.h"
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 9bdb629fbaae..697510325b1d 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -328,7 +328,7 @@ config JS_RTC
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y
-	depends on ALPHA || M68K || MN10300 || PARISC || PPC
+	depends on M68K || MN10300 || PARISC || PPC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- 
2.7.0
