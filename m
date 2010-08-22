Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B7291B70A2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 02:23:20 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH/v2] via-pmu: add compat_pmu_ioctl
References: <m2lj7zzm6w.fsf@igel.home> <201008221333.50575.arnd@arndb.de>
Date: Sun, 22 Aug 2010 18:23:17 +0200
In-Reply-To: <201008221333.50575.arnd@arndb.de> (Arnd Bergmann's message of
	"Sun, 22 Aug 2010 13:33:50 +0200")
Message-ID: <m2hbimmxai.fsf_-_@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ioctls are actually compatible, but due to historical mistake the
numbers differ between 32bit and 64bit.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 drivers/macintosh/via-pmu.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 35bc273..2d17e76 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -45,6 +45,7 @@
 #include <linux/syscalls.h>
 #include <linux/suspend.h>
 #include <linux/cpu.h>
+#include <linux/compat.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -2349,11 +2350,52 @@ static long pmu_unlocked_ioctl(struct file *filp,
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+#define PMU_IOC_GET_BACKLIGHT32	_IOR('B', 1, compat_size_t)
+#define PMU_IOC_SET_BACKLIGHT32	_IOW('B', 2, compat_size_t)
+#define PMU_IOC_GET_MODEL32	_IOR('B', 3, compat_size_t)
+#define PMU_IOC_HAS_ADB32	_IOR('B', 4, compat_size_t)
+#define PMU_IOC_CAN_SLEEP32	_IOR('B', 5, compat_size_t)
+#define PMU_IOC_GRAB_BACKLIGHT32 _IOR('B', 6, compat_size_t)
+
+static long compat_pmu_ioctl (struct file *filp, u_int cmd, u_long arg)
+{
+	switch (cmd) {
+	case PMU_IOC_SLEEP:
+		break;
+	case PMU_IOC_GET_BACKLIGHT32:
+		cmd = PMU_IOC_GET_BACKLIGHT;
+		break;
+	case PMU_IOC_SET_BACKLIGHT32:
+		cmd = PMU_IOC_SET_BACKLIGHT;
+		break;
+	case PMU_IOC_GET_MODEL32:
+		cmd = PMU_IOC_GET_MODEL;
+		break;
+	case PMU_IOC_HAS_ADB32:
+		cmd = PMU_IOC_HAS_ADB;
+		break;
+	case PMU_IOC_CAN_SLEEP32:
+		cmd = PMU_IOC_CAN_SLEEP;
+		break;
+	case PMU_IOC_GRAB_BACKLIGHT32:
+		cmd = PMU_IOC_GRAB_BACKLIGHT;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+	return pmu_unlocked_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static const struct file_operations pmu_device_fops = {
 	.read		= pmu_read,
 	.write		= pmu_write,
 	.poll		= pmu_fpoll,
 	.unlocked_ioctl	= pmu_unlocked_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= compat_pmu_ioctl,
+#endif
 	.open		= pmu_open,
 	.release	= pmu_release,
 };
-- 
1.7.2.2


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
