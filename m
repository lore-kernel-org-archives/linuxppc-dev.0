Return-Path: <SRS0+0172f75cf8e7244956cd+1562+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A09B9DDDEB
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 04:04:58 +1100 (EST)
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1IzEj0-00069Y-1U
	for linuxppc-dev@ozlabs.org; Mon, 03 Dec 2007 17:04:54 +0000
Subject: [PATCH] Generic RTC class support for ppc_md.[gs]et_rtc_time
From: David Woodhouse <dwmw2@infradead.org>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Dec 2007 17:04:53 +0000
Message-Id: <1196701493.13978.163.camel@pmac.infradead.org>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It would be good to migrate the platform code to register RTC devices
directly, but for now this will make them functional enough for most
purposes...

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 1e6715e..3e788b7 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -461,4 +461,12 @@ config RTC_DRV_RS5C313
 	help
 	  If you say yes here you get support for the Ricoh RS5C313 RTC chips.
 
+config RTC_DRV_PPC
+       tristate "PowerPC machine dependent RTC support"
+       depends on PPC_MERGE
+       help
+         The PowerPC kernel has machine-specific functions for accessing
+	 the RTC. This exposes that functionality through the generic RTC
+	 class.
+
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 465db4d..e822e56 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -49,3 +49,4 @@ obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020.o
 obj-$(CONFIG_RTC_DRV_VR41XX)	+= rtc-vr41xx.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
+obj-$(CONFIG_RTC_DRV_PPC)	+= rtc-ppc.o
--- /dev/null	2007-12-03 03:08:41.854157978 +0000
+++ b/drivers/rtc/rtc-ppc.c	2007-12-03 16:56:15.000000000 +0000
@@ -0,0 +1,69 @@
+/*
+ * RTC driver for ppc_md RTC functions
+ *
+ * © 2007 Red Hat, Inc.
+ *
+ * Author: David Woodhouse <dwmw2@infradead.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+#include <asm/machdep.h>
+
+static int ppc_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	ppc_md.get_rtc_time(tm);
+	return 0;
+}
+
+static int ppc_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	return ppc_md.set_rtc_time(tm);
+}
+
+static const struct rtc_class_ops ppc_rtc_ops = {
+	.set_time = ppc_rtc_set_time,
+	.read_time = ppc_rtc_read_time,
+};
+
+static struct rtc_device *rtc;
+static struct platform_device *ppc_rtc_pdev;
+
+static int __init ppc_rtc_init(void)
+{
+	if (!ppc_md.get_rtc_time || !ppc_md.set_rtc_time)
+		return -ENODEV;
+
+	ppc_rtc_pdev = platform_device_register_simple("ppc-rtc", 0, NULL, 0);
+	if (IS_ERR(ppc_rtc_pdev))
+		return PTR_ERR(ppc_rtc_pdev);
+
+	rtc = rtc_device_register("ppc_md", &ppc_rtc_pdev->dev,
+				  &ppc_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc)) {
+		platform_device_unregister(ppc_rtc_pdev);
+		return PTR_ERR(rtc);
+	}
+
+	return 0;
+}
+
+static void __exit ppc_rtc_exit(void)
+{
+	rtc_device_unregister(rtc);
+	platform_device_unregister(ppc_rtc_pdev);
+}
+
+module_init(ppc_rtc_init);
+module_exit(ppc_rtc_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org>");
+MODULE_DESCRIPTION("Generic RTC class driver for PowerPC");

-- 
dwmw2
