Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 703821A0BCB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 04:01:17 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, Kyle McMartin <kyle@mcmartin.ca>,
 rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] rtc: generic: allow building on all architectures
Date: Tue,  1 Mar 2016 17:59:57 +0100
Message-Id: <1456851608-3374907-2-git-send-email-arnd@arndb.de>
In-Reply-To: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are four architectures using this driver, but since we can
build it with COMPILE_TEST, we should try dealing with the absence
of the asm/rtc.h header file, to avoid getting a build error:

drivers/rtc/rtc-generic.c:12:21: fatal error: asm/rtc.h: No such file or directory

This creates an alternative use of the driver, allowing architectures
to pass a set of rtc_class_ops in platform data. We can convert the
four architectures to use this and then remove the original
code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-generic.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-generic.c b/drivers/rtc/rtc-generic.c
index e782ebd719b2..d726c6aa96a8 100644
--- a/drivers/rtc/rtc-generic.c
+++ b/drivers/rtc/rtc-generic.c
@@ -9,6 +9,8 @@
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 
+#if defined(CONFIG_M68K) || defined(CONFIG_PARISC) || \
+    defined(CONFIG_PPC) || defined(CONFIG_SUPERH32)
 #include <asm/rtc.h>
 
 static int generic_get_time(struct device *dev, struct rtc_time *tm)
@@ -33,13 +35,21 @@ static const struct rtc_class_ops generic_rtc_ops = {
 	.read_time = generic_get_time,
 	.set_time = generic_set_time,
 };
+#else
+#define generic_rtc_ops *(struct rtc_class_ops*)NULL
+#endif
 
 static int __init generic_rtc_probe(struct platform_device *dev)
 {
 	struct rtc_device *rtc;
+	const struct rtc_class_ops *ops;
+
+	ops = dev_get_platdata(&dev->dev);
+	if (!ops)
+		ops = &generic_rtc_ops;
 
 	rtc = devm_rtc_device_register(&dev->dev, "rtc-generic",
-					&generic_rtc_ops, THIS_MODULE);
+					ops, THIS_MODULE);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
-- 
2.7.0
