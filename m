Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvc91067vzDqBR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 07:45:56 +1000 (AEST)
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
Subject: [PATCH 8/8] char/genrtc: disallow building on mn10300
Date: Tue, 26 Apr 2016 23:44:12 +0200
Message-Id: <1461707052-1337718-9-git-send-email-arnd@arndb.de>
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

The genrtc driver serves no purpose on mn10300 because it drives the
same hardware as the original rtc.c driver, and the newer rtc-generic.c
or rtc-cmos.c drivers on architectures that use the asm-generic/rtc.h
header.

I assume it was initially only added for completeness when the
mn10300 port was done, but the older rtc.c driver was always used
instead.

It would be nice to change the architecture to use the rtc-cmos driver
next, and remove support for the old rtc driver as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 697510325b1d..d17ed90ebc82 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -328,7 +328,7 @@ config JS_RTC
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y
-	depends on M68K || MN10300 || PARISC || PPC
+	depends on M68K || PARISC || PPC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- 
2.7.0
