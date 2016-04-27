Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwFDB0GY7zDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 08:35:53 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v3 03/16] char/genrtc: x86: remove remnants of asm/rtc.h
Date: Thu, 28 Apr 2016 00:34:17 +0200
Message-Id: <1461796470-1291527-4-git-send-email-arnd@arndb.de>
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

Commit 3195ef59cb42 ("x86: Do full rtc synchronization with ntp") had
the side-effect of unconditionally enabling the RTC_LIB symbol on x86,
which in turn disables the selection of the CONFIG_RTC and
CONFIG_GEN_RTC drivers that contain a two older implementations of
the CONFIG_RTC_DRV_CMOS driver.

This removes x86 from the list for genrtc, and changes all references
to the asm/rtc.h header to instead point to the interfaces
from linux/mc146818rtc.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/rtc.h   | 1 -
 arch/x86/kernel/hpet.c       | 3 +--
 arch/x86/kernel/rtc.c        | 3 +--
 arch/x86/platform/efi/efi.c  | 1 -
 drivers/acpi/acpi_cmos_rtc.c | 2 +-
 drivers/base/power/trace.c   | 6 +++---
 drivers/char/Kconfig         | 2 +-
 drivers/rtc/rtc-mrst.c       | 2 +-
 8 files changed, 8 insertions(+), 12 deletions(-)
 delete mode 100644 arch/x86/include/asm/rtc.h

diff --git a/arch/x86/include/asm/rtc.h b/arch/x86/include/asm/rtc.h
deleted file mode 100644
index f71c3b0ed360..000000000000
--- a/arch/x86/include/asm/rtc.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/rtc.h>
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index f112af7aa62e..357900aad62c 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1020,7 +1020,6 @@ void hpet_disable(void)
  */
 #include <linux/mc146818rtc.h>
 #include <linux/rtc.h>
-#include <asm/rtc.h>
 
 #define DEFAULT_RTC_INT_FREQ	64
 #define DEFAULT_RTC_SHIFT	6
@@ -1244,7 +1243,7 @@ irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id)
 	memset(&curr_time, 0, sizeof(struct rtc_time));
 
 	if (hpet_rtc_flags & (RTC_UIE | RTC_AIE))
-		get_rtc_time(&curr_time);
+		mc146818_set_time(&curr_time);
 
 	if (hpet_rtc_flags & RTC_UIE &&
 	    curr_time.tm_sec != hpet_prev_update_sec) {
diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index eceaa082ec3f..79c6311cd912 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -13,7 +13,6 @@
 #include <asm/x86_init.h>
 #include <asm/time.h>
 #include <asm/intel-mid.h>
-#include <asm/rtc.h>
 #include <asm/setup.h>
 
 #ifdef CONFIG_X86_32
@@ -47,7 +46,7 @@ int mach_set_rtc_mmss(const struct timespec *now)
 
 	rtc_time_to_tm(nowtime, &tm);
 	if (!rtc_valid_tm(&tm)) {
-		retval = set_rtc_time(&tm);
+		retval = mc146818_set_time(&tm);
 		if (retval)
 			printk(KERN_ERR "%s: RTC write failed with error %d\n",
 			       __func__, retval);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 994a7df84a7b..13b216f71191 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -51,7 +51,6 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/x86_init.h>
-#include <asm/rtc.h>
 #include <asm/uv/uv.h>
 
 #define EFI_DEBUG
diff --git a/drivers/acpi/acpi_cmos_rtc.c b/drivers/acpi/acpi_cmos_rtc.c
index 81dc75033f15..0980a133916f 100644
--- a/drivers/acpi/acpi_cmos_rtc.c
+++ b/drivers/acpi/acpi_cmos_rtc.c
@@ -14,7 +14,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <asm-generic/rtc.h>
+#include <linux/mc146818rtc.h>
 
 #include "internal.h"
 
diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index a6975795e7f3..efec10b49d59 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -11,7 +11,7 @@
 #include <linux/export.h>
 #include <linux/rtc.h>
 
-#include <asm/rtc.h>
+#include <linux/mc146818rtc.h>
 
 #include "power.h"
 
@@ -103,7 +103,7 @@ static int set_magic_time(unsigned int user, unsigned int file, unsigned int dev
 	n /= 24;
 	time.tm_min = (n % 20) * 3;
 	n /= 20;
-	set_rtc_time(&time);
+	mc146818_set_time(&time);
 	return n ? -1 : 0;
 }
 
@@ -112,7 +112,7 @@ static unsigned int read_magic_time(void)
 	struct rtc_time time;
 	unsigned int val;
 
-	get_rtc_time(&time);
+	mc146818_get_time(&time);
 	pr_info("RTC time: %2d:%02d:%02d, date: %02d/%02d/%02d\n",
 		time.tm_hour, time.tm_min, time.tm_sec,
 		time.tm_mon + 1, time.tm_mday, time.tm_year % 100);
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index ca397384dc15..9bdb629fbaae 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -328,7 +328,7 @@ config JS_RTC
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y
-	depends on ALPHA || M68K || MN10300 || PARISC || PPC || X86
+	depends on ALPHA || M68K || MN10300 || PARISC || PPC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index 548ea6f6f384..bb8ac7c5e217 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -32,11 +32,11 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
+#include <linux/mc146818rtc.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sfi.h>
 
-#include <asm-generic/rtc.h>
 #include <asm/intel_scu_ipc.h>
 #include <asm/intel-mid.h>
 #include <asm/intel_mid_vrtc.h>
-- 
2.7.0
