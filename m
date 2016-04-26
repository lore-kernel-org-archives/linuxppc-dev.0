Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvcKk27jtzDqrn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 07:53:29 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v2 5/6] rtc: sh: provide rtc_class_ops directly
Date: Tue, 26 Apr 2016 23:52:30 +0200
Message-Id: <1461707551-1337971-6-git-send-email-arnd@arndb.de>
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
and on sh, that goes through another indirection using
the rtc_sh_get_time/rtc_sh_set_time functions.

This changes the sh rtc-generic device to provide its
rtc_class_ops directly, skipping one of the abstraction
levels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/kernel/time.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index d6d0a986c6e9..92cd676970d9 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -50,27 +50,30 @@ int update_persistent_clock(struct timespec now)
 }
 #endif
 
-unsigned int get_rtc_time(struct rtc_time *tm)
+static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
 {
-	if (rtc_sh_get_time != null_rtc_get_time) {
-		struct timespec tv;
+	struct timespec tv;
 
-		rtc_sh_get_time(&tv);
-		rtc_time_to_tm(tv.tv_sec, tm);
-	}
-
-	return RTC_24H;
+	rtc_sh_get_time(&tv);
+	rtc_time_to_tm(tv.tv_sec, tm);
+	return 0;
 }
-EXPORT_SYMBOL(get_rtc_time);
 
-int set_rtc_time(struct rtc_time *tm)
+static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long secs;
 
 	rtc_tm_to_time(tm, &secs);
-	return rtc_sh_set_time(secs);
+	if (!rtc_sh_set_time || rtc_sh_set_time(secs) < 0)
+		return -EOPNOTSUPP;
+
+	return 0;
 }
-EXPORT_SYMBOL(set_rtc_time);
+
+static const struct rtc_class_ops rtc_generic_ops = {
+	.read_time = rtc_generic_get_time,
+	.set_time = rtc_generic_set_time,
+};
 
 static int __init rtc_generic_init(void)
 {
@@ -79,7 +82,10 @@ static int __init rtc_generic_init(void)
 	if (rtc_sh_get_time == null_rtc_get_time)
 		return -ENODEV;
 
-	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
+	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
+					     &rtc_generic_ops,
+					     sizeof(rtc_generic_ops));
+
 
 	return PTR_ERR_OR_ZERO(pdev);
 }
-- 
2.7.0
