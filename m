Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9D59DB70D4
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Aug 2010 07:32:26 +1000 (EST)
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id B0B2C1C159FA
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Aug 2010 23:32:24 +0200 (CEST)
Received: from igel.home (ppp-93-104-151-37.dynamic.mnet-online.de
	[93.104.151.37])
	by mail.mnet-online.de (Postfix) with ESMTP id B536F1C00106
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Aug 2010 23:32:23 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] pmu: add compat_pmu_ioctl
Date: Sat, 21 Aug 2010 23:32:23 +0200
Message-ID: <m2lj7zzm6w.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
 drivers/macintosh/via-pmu.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 35bc273..610f247 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -2349,11 +2349,52 @@ static long pmu_unlocked_ioctl(struct file *filp,
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+#define PMU_IOC_GET_BACKLIGHT32	_IOR('B', 1, u32)
+#define PMU_IOC_SET_BACKLIGHT32	_IOW('B', 2, u32)
+#define PMU_IOC_GET_MODEL32	_IOR('B', 3, u32)
+#define PMU_IOC_HAS_ADB32	_IOR('B', 4, u32)
+#define PMU_IOC_CAN_SLEEP32	_IOR('B', 5, u32)
+#define PMU_IOC_GRAB_BACKLIGHT32 _IOR('B', 6, u32)
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
+	return pmu_unlocked_ioctl(filp, cmd, arg);
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
