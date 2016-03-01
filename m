Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5EAA1A0BC0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 04:01:22 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arm-kernel@lists.infradead.org, Kyle McMartin <kyle@mcmartin.ca>,
 rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] m68k: rtc: provide rtc_class_ops directly
Date: Tue,  1 Mar 2016 17:59:58 +0100
Message-Id: <1456851608-3374907-3-git-send-email-arnd@arndb.de>
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

The rtc-generic driver provides an architecture specific
wrapper on top of the generic rtc_class_ops abstraction,
and m68k has another abstraction on top, which is a bit
silly.

This changes the m68k rtc-generic device to provide its
rtc_class_ops directly, to reduce the number of layers
by one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/kernel/time.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 3857737e3958..773b2187210d 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -87,6 +87,23 @@ void read_persistent_clock(struct timespec *ts)
 }
 
 #ifdef CONFIG_ARCH_USES_GETTIMEOFFSET
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
