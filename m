Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id E1871DDDA1
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 02:46:58 +1100 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Subject: [PATCH/RFC 3/5] m68k: Enable rtc-generic
Date: Fri, 20 Feb 2009 16:46:47 +0100
Message-Id: <1235144809-32468-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1235144809-32468-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1235144809-32468-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1235144809-32468-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Richard Zidlicky <rz@linux-m68k.org>, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle McMartin <kyle@mcmartin.ca>, linuxppc-dev@ozlabs.org,
	linux-m68k@lists.linux-m68k.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/m68k/Kconfig       |    4 ++++
 arch/m68k/kernel/time.c |   21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index fb87c08..9d2565e 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -27,6 +27,10 @@ config ARCH_HAS_ILOG2_U64
 	bool
 	default n
 
+config ARCH_HAS_GENERIC_RTC
+	bool
+	default y
+
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 7db4159..b26933f 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/rtc.h>
+#include <linux/platform_device.h>
 
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -159,3 +160,23 @@ int do_settimeofday(struct timespec *tv)
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+
+
+static struct platform_device rtc_generic_dev = {
+	.name = "rtc-generic",
+	.id = -1,
+};
+
+static int __init rtc_init(void)
+{
+	int ret;
+
+	ret = platform_device_register(&rtc_generic_dev);
+	if (ret < 0)
+		pr_err("Unable to register rtc device...\n");
+
+	/* not necessarily an error */
+	return 0;
+}
+
+module_init(rtc_init);
-- 
1.6.0.4
