Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwFKr4HFBzDqhB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 08:40:48 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v3 14/16] rtc: generic: remove get_rtc_time/set_rtc_time
 wrappers
Date: Thu, 28 Apr 2016 00:34:28 +0200
Message-Id: <1461796470-1291527-15-git-send-email-arnd@arndb.de>
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

All architectures using this driver are now converted to
provide their own operations, so this one can be turned
into a trivial stub driver relying on its platform data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-generic.c | 35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/rtc/rtc-generic.c b/drivers/rtc/rtc-generic.c
index efcb9833cac8..1bf5d2347928 100644
--- a/drivers/rtc/rtc-generic.c
+++ b/drivers/rtc/rtc-generic.c
@@ -9,43 +9,10 @@
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 
-#if 0
-#include <asm/rtc.h>
-
-static int generic_get_time(struct device *dev, struct rtc_time *tm)
-{
-	unsigned int ret = get_rtc_time(tm);
-
-	if (ret & RTC_BATT_BAD)
-		return -EOPNOTSUPP;
-
-	return rtc_valid_tm(tm);
-}
-
-static int generic_set_time(struct device *dev, struct rtc_time *tm)
-{
-	if (set_rtc_time(tm) < 0)
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
-static const struct rtc_class_ops generic_rtc_ops = {
-	.read_time = generic_get_time,
-	.set_time = generic_set_time,
-};
-#else
-#define generic_rtc_ops *(struct rtc_class_ops*)NULL
-#endif
-
 static int __init generic_rtc_probe(struct platform_device *dev)
 {
 	struct rtc_device *rtc;
-	const struct rtc_class_ops *ops;
-
-	ops = dev_get_platdata(&dev->dev);
-	if (!ops)
-		ops = &generic_rtc_ops;
+	const struct rtc_class_ops *ops = dev_get_platdata(&dev->dev);
 
 	rtc = devm_rtc_device_register(&dev->dev, "rtc-generic",
 					ops, THIS_MODULE);
-- 
2.7.0
