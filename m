Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvcS610rwzDqfG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 07:59:01 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v2 1/6] rtc: m68k: provide rtc_class_ops directly
Date: Tue, 26 Apr 2016 23:52:26 +0200
Message-Id: <1461707551-1337971-2-git-send-email-arnd@arndb.de>
In-Reply-To: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
References: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The rtc-generic driver provides an architecture specific
wrapper on top of the generic rtc_class_ops abstraction,
and m68k has another abstraction on top, which is a bit
silly.

This changes the m68k rtc-generic device to provide its
rtc_class_ops directly, to reduce the number of layers
by one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/kernel/time.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 3857737e3958..fe35890feede 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -86,7 +86,24 @@ void read_persistent_clock(struct timespec *ts)
 	}
 }
 
-#ifdef CONFIG_ARCH_USES_GETTIMEOFFSET
+#if defined(CONFIG_ARCH_USES_GETTIMEOFFSET) && defined(CONFIG_RTC_DRV_GENERIC)
+static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
+{
+	mach_hwclk(0, tm);
+	return rtc_valid_tm(tm);
+}
+
+static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
+{
+	if (mach_hwclk(1, tm) < 0)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static const struct rtc_class_ops generic_rtc_ops = {
+	.read_time = rtc_generic_get_time,
+	.set_time = rtc_generic_set_time,
+};
 
 static int __init rtc_init(void)
 {
@@ -95,7 +112,10 @@ static int __init rtc_init(void)
 	if (!mach_hwclk)
 		return -ENODEV;
 
-	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
+	/* or just call devm_rtc_device_register instead? */
+	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
+					     &generic_rtc_ops,
+					     sizeof(generic_rtc_ops));
 	return PTR_ERR_OR_ZERO(pdev);
 }
 
-- 
2.7.0
