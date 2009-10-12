Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 1F0EAB7088
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 02:50:45 +1100 (EST)
Date: Mon, 12 Oct 2009 19:50:41 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] of/platform: Implement support for dev_pm_ops
Message-ID: <20091012155041.GA1071@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linux power management subsystem supports vast amount of new PM
callbacks that are crucial for proper suspend and hibernation support
in drivers.

This patch implements support for dev_pm_ops, preserving support
for legacy callbacks.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/of/platform.c |  305 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 290 insertions(+), 15 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 298de0f..d58ade1 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -65,47 +65,322 @@ static int of_platform_device_remove(struct device *dev)
 	return 0;
 }
 
-static int of_platform_device_suspend(struct device *dev, pm_message_t state)
+static void of_platform_device_shutdown(struct device *dev)
 {
 	struct of_device *of_dev = to_of_device(dev);
 	struct of_platform_driver *drv = to_of_platform_driver(dev->driver);
-	int error = 0;
 
-	if (dev->driver && drv->suspend)
-		error = drv->suspend(of_dev, state);
-	return error;
+	if (dev->driver && drv->shutdown)
+		drv->shutdown(of_dev);
 }
 
-static int of_platform_device_resume(struct device * dev)
+#ifdef CONFIG_PM_SLEEP
+
+static int of_platform_legacy_suspend(struct device *dev, pm_message_t mesg)
 {
 	struct of_device *of_dev = to_of_device(dev);
 	struct of_platform_driver *drv = to_of_platform_driver(dev->driver);
-	int error = 0;
+	int ret = 0;
 
-	if (dev->driver && drv->resume)
-		error = drv->resume(of_dev);
-	return error;
+	if (dev->driver && drv->suspend)
+		ret = drv->suspend(of_dev, mesg);
+	return ret;
 }
 
-static void of_platform_device_shutdown(struct device *dev)
+static int of_platform_legacy_resume(struct device *dev)
 {
 	struct of_device *of_dev = to_of_device(dev);
 	struct of_platform_driver *drv = to_of_platform_driver(dev->driver);
+	int ret = 0;
 
-	if (dev->driver && drv->shutdown)
-		drv->shutdown(of_dev);
+	if (dev->driver && drv->resume)
+		ret = drv->resume(of_dev);
+	return ret;
+}
+
+static int of_platform_pm_prepare(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (drv && drv->pm && drv->pm->prepare)
+		ret = drv->pm->prepare(dev);
+
+	return ret;
+}
+
+static void of_platform_pm_complete(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+
+	if (drv && drv->pm && drv->pm->complete)
+		drv->pm->complete(dev);
+}
+
+#ifdef CONFIG_SUSPEND
+
+static int of_platform_pm_suspend(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->suspend)
+			ret = drv->pm->suspend(dev);
+	} else {
+		ret = of_platform_legacy_suspend(dev, PMSG_SUSPEND);
+	}
+
+	return ret;
 }
 
+static int of_platform_pm_suspend_noirq(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->suspend_noirq)
+			ret = drv->pm->suspend_noirq(dev);
+	}
+
+	return ret;
+}
+
+static int of_platform_pm_resume(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->resume)
+			ret = drv->pm->resume(dev);
+	} else {
+		ret = of_platform_legacy_resume(dev);
+	}
+
+	return ret;
+}
+
+static int of_platform_pm_resume_noirq(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->resume_noirq)
+			ret = drv->pm->resume_noirq(dev);
+	}
+
+	return ret;
+}
+
+#else /* !CONFIG_SUSPEND */
+
+#define of_platform_pm_suspend		NULL
+#define of_platform_pm_resume		NULL
+#define of_platform_pm_suspend_noirq	NULL
+#define of_platform_pm_resume_noirq	NULL
+
+#endif /* !CONFIG_SUSPEND */
+
+#ifdef CONFIG_HIBERNATION
+
+static int of_platform_pm_freeze(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->freeze)
+			ret = drv->pm->freeze(dev);
+	} else {
+		ret = of_platform_legacy_suspend(dev, PMSG_FREEZE);
+	}
+
+	return ret;
+}
+
+static int of_platform_pm_freeze_noirq(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->freeze_noirq)
+			ret = drv->pm->freeze_noirq(dev);
+	}
+
+	return ret;
+}
+
+static int of_platform_pm_thaw(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->thaw)
+			ret = drv->pm->thaw(dev);
+	} else {
+		ret = of_platform_legacy_resume(dev);
+	}
+
+	return ret;
+}
+
+static int of_platform_pm_thaw_noirq(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->thaw_noirq)
+			ret = drv->pm->thaw_noirq(dev);
+	}
+
+	return ret;
+}
+
+static int of_platform_pm_poweroff(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->poweroff)
+			ret = drv->pm->poweroff(dev);
+	} else {
+		ret = of_platform_legacy_suspend(dev, PMSG_HIBERNATE);
+	}
+
+	return ret;
+}
+
+static int of_platform_pm_poweroff_noirq(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->poweroff_noirq)
+			ret = drv->pm->poweroff_noirq(dev);
+	}
+
+	return ret;
+}
+
+static int of_platform_pm_restore(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->restore)
+			ret = drv->pm->restore(dev);
+	} else {
+		ret = of_platform_legacy_resume(dev);
+	}
+
+	return ret;
+}
+
+static int of_platform_pm_restore_noirq(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->restore_noirq)
+			ret = drv->pm->restore_noirq(dev);
+	}
+
+	return ret;
+}
+
+#else /* !CONFIG_HIBERNATION */
+
+#define of_platform_pm_freeze		NULL
+#define of_platform_pm_thaw		NULL
+#define of_platform_pm_poweroff		NULL
+#define of_platform_pm_restore		NULL
+#define of_platform_pm_freeze_noirq	NULL
+#define of_platform_pm_thaw_noirq		NULL
+#define of_platform_pm_poweroff_noirq	NULL
+#define of_platform_pm_restore_noirq	NULL
+
+#endif /* !CONFIG_HIBERNATION */
+
+static struct dev_pm_ops of_platform_dev_pm_ops = {
+	.prepare = of_platform_pm_prepare,
+	.complete = of_platform_pm_complete,
+	.suspend = of_platform_pm_suspend,
+	.resume = of_platform_pm_resume,
+	.freeze = of_platform_pm_freeze,
+	.thaw = of_platform_pm_thaw,
+	.poweroff = of_platform_pm_poweroff,
+	.restore = of_platform_pm_restore,
+	.suspend_noirq = of_platform_pm_suspend_noirq,
+	.resume_noirq = of_platform_pm_resume_noirq,
+	.freeze_noirq = of_platform_pm_freeze_noirq,
+	.thaw_noirq = of_platform_pm_thaw_noirq,
+	.poweroff_noirq = of_platform_pm_poweroff_noirq,
+	.restore_noirq = of_platform_pm_restore_noirq,
+};
+
+#define OF_PLATFORM_PM_OPS_PTR	(&of_platform_dev_pm_ops)
+
+#else /* !CONFIG_PM_SLEEP */
+
+#define OF_PLATFORM_PM_OPS_PTR	NULL
+
+#endif /* !CONFIG_PM_SLEEP */
+
 int of_bus_type_init(struct bus_type *bus, const char *name)
 {
 	bus->name = name;
 	bus->match = of_platform_bus_match;
 	bus->probe = of_platform_device_probe;
 	bus->remove = of_platform_device_remove;
-	bus->suspend = of_platform_device_suspend;
-	bus->resume = of_platform_device_resume;
 	bus->shutdown = of_platform_device_shutdown;
 	bus->dev_attrs = of_platform_device_attrs;
+	bus->pm = OF_PLATFORM_PM_OPS_PTR;
 	return bus_register(bus);
 }
 
-- 
1.6.3.3
