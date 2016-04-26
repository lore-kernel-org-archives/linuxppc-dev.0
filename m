Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvcKm3f4zzDqf8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 07:53:32 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v2 2/6] rtc: m68k: provide ioctl for q40
Date: Tue, 26 Apr 2016 23:52:27 +0200
Message-Id: <1461707551-1337971-3-git-send-email-arnd@arndb.de>
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

The q40 platform is the only machine in the kernel that provides
RTC_PLL_GET/RTC_PLL_SET ioctl commands in its rtc through the
mach_get_rtc_pll/mach_set_rtc_pll callbacks.

However, this currenctly works only in the old-style genrtc
driver, not the (somewhat) modern rtc-generic driver replacing
it. This adds an ioctl implementation to the m68k generic_rtc_ops
in order to let both drivers provide the same API.

After this, we should be able to remove support for genrtc
from the m68k architecture.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/kernel/time.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index fe35890feede..5f0a5826a05e 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -100,7 +100,32 @@ static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static int rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct rtc_pll_info pll;
+	struct rtc_pll_info __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case RTC_PLL_GET:
+		if (!mach_get_rtc_pll || mach_get_rtc_pll(&pll))
+			return -EINVAL;
+		return copy_to_user(argp, &pll, sizeof pll) ? -EFAULT : 0;
+
+	case RTC_PLL_SET:
+		if (!mach_set_rtc_pll)
+			return -EINVAL;
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+		if (copy_from_user(&pll, argp, sizeof(pll)))
+			return -EFAULT;
+		return mach_set_rtc_pll(&pll);
+	}
+
+	return -ENOIOCTLCMD;
+}
+
 static const struct rtc_class_ops generic_rtc_ops = {
+	.ioctl = rtc_ioctl,
 	.read_time = rtc_generic_get_time,
 	.set_time = rtc_generic_set_time,
 };
-- 
2.7.0
