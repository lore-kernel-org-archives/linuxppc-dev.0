Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE4602C0190
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2013 13:01:56 +1000 (EST)
Received: from mail206-ch1 (localhost [127.0.0.1])	by
 mail206-ch1-R.bigfish.com (Postfix) with ESMTP id 0E3821E0123	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2013 03:01:52 +0000 (UTC)
Received: from CH1EHSMHS030.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.237])	by mail206-ch1.bigfish.com (Postfix) with ESMTP id
 AA7DA3400A7	for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2013 03:01:49
 +0000 (UTC)
From: Wang Dongsheng <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v3 4/4] powerpc/fsl: add MPIC timer wakeup support
Date: Tue, 9 Apr 2013 10:22:32 +0800
Message-ID: <1365474152-21524-4-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1365474152-21524-1-git-send-email-dongsheng.wang@freescale.com>
References: <1365474152-21524-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>,
 Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The driver provides a way to wake up the system by the MPIC timer.

For example,
echo 5 > /sys/devices/system/mpic/timer_wakeup
echo standby > /sys/power/state

After 5 seconds the MPIC timer will generate an interrupt to wake up
the system.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
v2:
* Remove: Create mpic subsystem.

 arch/powerpc/platforms/Kconfig              |   9 ++
 arch/powerpc/sysdev/Makefile                |   1 +
 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c | 161 ++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index c447b3c..3d934ba 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -99,6 +99,15 @@ config MPIC_TIMER
 	  chip, but it can potentially support other global timers
 	  complying with the OpenPIC standard.
 
+config FSL_MPIC_TIMER_WAKEUP
+	tristate "Freescale MPIC global timer wakeup driver"
+	depends on FSL_SOC &&  MPIC_TIMER && PM
+	default n
+	help
+	  The driver provides a way to wake up the system by MPIC
+	  timer.
+	  e.g. "echo 5 > /sys/devices/system/mpic/timer_wakeup"
+
 config PPC_EPAPR_HV_PIC
 	bool
 	default n
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index ff6184a..e1b8a80 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -5,6 +5,7 @@ ccflags-$(CONFIG_PPC64)		:= -mno-minimal-toc
 mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o mpic_pasemi_msi.o
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
 obj-$(CONFIG_MPIC_TIMER)        += mpic_timer.o
+obj-$(CONFIG_FSL_MPIC_TIMER_WAKEUP)	+= fsl_mpic_timer_wakeup.o
 mpic-msgr-obj-$(CONFIG_MPIC_MSGR)	+= mpic_msgr.o
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y) $(mpic-msgr-obj-y)
 obj-$(CONFIG_PPC_EPAPR_HV_PIC)	+= ehv_pic.o
diff --git a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
new file mode 100644
index 0000000..1707bf0
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
@@ -0,0 +1,161 @@
+/*
+ * MPIC timer wakeup driver
+ *
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+
+#include <asm/mpic_timer.h>
+#include <asm/mpic.h>
+
+struct fsl_mpic_timer_wakeup {
+	struct mpic_timer *timer;
+	struct work_struct free_work;
+};
+
+static struct fsl_mpic_timer_wakeup *fsl_wakeup;
+static DEFINE_MUTEX(sysfs_lock);
+
+static void fsl_free_resource(struct work_struct *ws)
+{
+	struct fsl_mpic_timer_wakeup *wakeup =
+		container_of(ws, struct fsl_mpic_timer_wakeup, free_work);
+
+	mutex_lock(&sysfs_lock);
+
+	if (wakeup->timer) {
+		disable_irq_wake(wakeup->timer->irq);
+		mpic_free_timer(wakeup->timer);
+	}
+
+	wakeup->timer = NULL;
+	mutex_unlock(&sysfs_lock);
+}
+
+static irqreturn_t fsl_mpic_timer_irq(int irq, void *dev_id)
+{
+	struct fsl_mpic_timer_wakeup *wakeup = dev_id;
+
+	schedule_work(&wakeup->free_work);
+
+	return wakeup->timer ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static ssize_t fsl_timer_wakeup_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct timeval interval;
+	int val = 0;
+
+	mutex_lock(&sysfs_lock);
+	if (fsl_wakeup->timer) {
+		mpic_get_remain_time(fsl_wakeup->timer, &interval);
+		val = interval.tv_sec + 1;
+	}
+	mutex_unlock(&sysfs_lock);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t fsl_timer_wakeup_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t count)
+{
+	struct timeval interval;
+	int ret;
+
+	interval.tv_usec = 0;
+	if (kstrtol(buf, 0, &interval.tv_sec))
+		return -EINVAL;
+
+	mutex_lock(&sysfs_lock);
+
+	if (fsl_wakeup->timer) {
+		disable_irq_wake(fsl_wakeup->timer->irq);
+		mpic_free_timer(fsl_wakeup->timer);
+		fsl_wakeup->timer = NULL;
+	}
+
+	if (!interval.tv_sec) {
+		mutex_unlock(&sysfs_lock);
+		return count;
+	}
+
+	fsl_wakeup->timer = mpic_request_timer(fsl_mpic_timer_irq,
+						fsl_wakeup, &interval);
+	if (!fsl_wakeup->timer) {
+		mutex_unlock(&sysfs_lock);
+		return -EINVAL;
+	}
+
+	ret = enable_irq_wake(fsl_wakeup->timer->irq);
+	if (ret) {
+		mpic_free_timer(fsl_wakeup->timer);
+		fsl_wakeup->timer = NULL;
+		mutex_unlock(&sysfs_lock);
+
+		return ret;
+	}
+
+	mpic_start_timer(fsl_wakeup->timer);
+
+	mutex_unlock(&sysfs_lock);
+
+	return count;
+}
+
+static struct device_attribute mpic_attributes = __ATTR(timer_wakeup, 0644,
+			fsl_timer_wakeup_show, fsl_timer_wakeup_store);
+
+static int __init fsl_wakeup_sys_init(void)
+{
+	int ret;
+
+	fsl_wakeup = kzalloc(sizeof(struct fsl_mpic_timer_wakeup), GFP_KERNEL);
+	if (!fsl_wakeup)
+		return -ENOMEM;
+
+	INIT_WORK(&fsl_wakeup->free_work, fsl_free_resource);
+
+	ret = device_create_file(mpic_subsys.dev_root, &mpic_attributes);
+	if (ret)
+		kfree(fsl_wakeup);
+
+	return ret;
+}
+
+static void __exit fsl_wakeup_sys_exit(void)
+{
+	device_remove_file(mpic_subsys.dev_root, &mpic_attributes);
+
+	mutex_lock(&sysfs_lock);
+
+	if (fsl_wakeup->timer) {
+		disable_irq_wake(fsl_wakeup->timer->irq);
+		mpic_free_timer(fsl_wakeup->timer);
+	}
+
+	kfree(fsl_wakeup);
+
+	mutex_unlock(&sysfs_lock);
+}
+
+module_init(fsl_wakeup_sys_init);
+module_exit(fsl_wakeup_sys_exit);
+
+MODULE_DESCRIPTION("Freescale MPIC global timer wakeup driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Wang Dongsheng <dongsheng.wang@freescale.com>");
-- 
1.8.0
