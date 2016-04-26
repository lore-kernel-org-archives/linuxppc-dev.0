Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvcHp1nrGzDqmK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 07:51:49 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, tony.luck@intel.com, geert@linux-m68k.org,
 jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
 mpe@ellerman.id.au, dalias@libc.org, dhowells@redhat.com,
 yasutake.koichi@jp.panasonic.com, rth@twiddle.net,
 ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, x86@kernel.org,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH 1/8] char/rtc: replace blacklist with whitelist
Date: Tue, 26 Apr 2016 23:44:05 +0200
Message-Id: <1461707052-1337718-2-git-send-email-arnd@arndb.de>
In-Reply-To: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Every new architecture has to add itself to the growing list of those
that do not support the legacy PC RTC driver.

This replaces the long list of architectures that don't support it
with a shorter list of those that do.

The list is taken from those architectures that have a non-empty
asm/mc146818rtc.h header file and were not explicitly blacklisted.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 3ec0766ed5e9..66b5d48f409a 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -279,8 +279,7 @@ if RTC_LIB=n
 
 config RTC
 	tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
-	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV \
-			&& !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN && !UML
+	depends on ALPHA || (MIPS && MACH_LOONGSON64) || MN10300 || X86
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- 
2.7.0
