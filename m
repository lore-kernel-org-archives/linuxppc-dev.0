Return-Path: <lars@metafoo.de>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLcCz2GkpzDsy6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Nov 2016 01:08:44 +1100 (AEDT)
From: Lars-Peter Clausen <lars@metafoo.de>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ibmebus: Remove legacy suspend/resume support
Date: Sat, 19 Nov 2016 14:42:14 +0100
Message-Id: <1479562934-1541-1-git-send-email-lars@metafoo.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are no ibmebus driver that make use of legacy suspend/resume. This
patch removes the support for it from ibmebus framework, new ibmebus driver
(as unlikely as they are) wanting to use suspend/resume should use
dev_pm_ops.

Since there aren't any special bus specific things to do during
suspend/resume and since the PM core will automatically fallback directly
to using the device's PM ops if no bus PM ops are specified there is no
need to have any special ibmebus PM ops at all.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/powerpc/kernel/ibmebus.c | 298 ------------------------------------------
 1 file changed, 298 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 35f5244..614c285 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -423,303 +423,6 @@ static struct device_attribute ibmebus_bus_device_attrs[] = {
 	__ATTR_NULL
 };
 
-#ifdef CONFIG_PM_SLEEP
-static int ibmebus_bus_legacy_suspend(struct device *dev, pm_message_t mesg)
-{
-	struct platform_device *of_dev = to_platform_device(dev);
-	struct platform_driver *drv = to_platform_driver(dev->driver);
-	int ret = 0;
-
-	if (dev->driver && drv->suspend)
-		ret = drv->suspend(of_dev, mesg);
-	return ret;
-}
-
-static int ibmebus_bus_legacy_resume(struct device *dev)
-{
-	struct platform_device *of_dev = to_platform_device(dev);
-	struct platform_driver *drv = to_platform_driver(dev->driver);
-	int ret = 0;
-
-	if (dev->driver && drv->resume)
-		ret = drv->resume(of_dev);
-	return ret;
-}
-
-static int ibmebus_bus_pm_prepare(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (drv && drv->pm && drv->pm->prepare)
-		ret = drv->pm->prepare(dev);
-
-	return ret;
-}
-
-static void ibmebus_bus_pm_complete(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-
-	if (drv && drv->pm && drv->pm->complete)
-		drv->pm->complete(dev);
-}
-
-#ifdef CONFIG_SUSPEND
-
-static int ibmebus_bus_pm_suspend(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->suspend)
-			ret = drv->pm->suspend(dev);
-	} else {
-		ret = ibmebus_bus_legacy_suspend(dev, PMSG_SUSPEND);
-	}
-
-	return ret;
-}
-
-static int ibmebus_bus_pm_suspend_noirq(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->suspend_noirq)
-			ret = drv->pm->suspend_noirq(dev);
-	}
-
-	return ret;
-}
-
-static int ibmebus_bus_pm_resume(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->resume)
-			ret = drv->pm->resume(dev);
-	} else {
-		ret = ibmebus_bus_legacy_resume(dev);
-	}
-
-	return ret;
-}
-
-static int ibmebus_bus_pm_resume_noirq(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->resume_noirq)
-			ret = drv->pm->resume_noirq(dev);
-	}
-
-	return ret;
-}
-
-#else /* !CONFIG_SUSPEND */
-
-#define ibmebus_bus_pm_suspend		NULL
-#define ibmebus_bus_pm_resume		NULL
-#define ibmebus_bus_pm_suspend_noirq	NULL
-#define ibmebus_bus_pm_resume_noirq	NULL
-
-#endif /* !CONFIG_SUSPEND */
-
-#ifdef CONFIG_HIBERNATE_CALLBACKS
-
-static int ibmebus_bus_pm_freeze(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->freeze)
-			ret = drv->pm->freeze(dev);
-	} else {
-		ret = ibmebus_bus_legacy_suspend(dev, PMSG_FREEZE);
-	}
-
-	return ret;
-}
-
-static int ibmebus_bus_pm_freeze_noirq(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->freeze_noirq)
-			ret = drv->pm->freeze_noirq(dev);
-	}
-
-	return ret;
-}
-
-static int ibmebus_bus_pm_thaw(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->thaw)
-			ret = drv->pm->thaw(dev);
-	} else {
-		ret = ibmebus_bus_legacy_resume(dev);
-	}
-
-	return ret;
-}
-
-static int ibmebus_bus_pm_thaw_noirq(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->thaw_noirq)
-			ret = drv->pm->thaw_noirq(dev);
-	}
-
-	return ret;
-}
-
-static int ibmebus_bus_pm_poweroff(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->poweroff)
-			ret = drv->pm->poweroff(dev);
-	} else {
-		ret = ibmebus_bus_legacy_suspend(dev, PMSG_HIBERNATE);
-	}
-
-	return ret;
-}
-
-static int ibmebus_bus_pm_poweroff_noirq(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->poweroff_noirq)
-			ret = drv->pm->poweroff_noirq(dev);
-	}
-
-	return ret;
-}
-
-static int ibmebus_bus_pm_restore(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->restore)
-			ret = drv->pm->restore(dev);
-	} else {
-		ret = ibmebus_bus_legacy_resume(dev);
-	}
-
-	return ret;
-}
-
-static int ibmebus_bus_pm_restore_noirq(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->restore_noirq)
-			ret = drv->pm->restore_noirq(dev);
-	}
-
-	return ret;
-}
-
-#else /* !CONFIG_HIBERNATE_CALLBACKS */
-
-#define ibmebus_bus_pm_freeze		NULL
-#define ibmebus_bus_pm_thaw		NULL
-#define ibmebus_bus_pm_poweroff		NULL
-#define ibmebus_bus_pm_restore		NULL
-#define ibmebus_bus_pm_freeze_noirq	NULL
-#define ibmebus_bus_pm_thaw_noirq		NULL
-#define ibmebus_bus_pm_poweroff_noirq	NULL
-#define ibmebus_bus_pm_restore_noirq	NULL
-
-#endif /* !CONFIG_HIBERNATE_CALLBACKS */
-
-static struct dev_pm_ops ibmebus_bus_dev_pm_ops = {
-	.prepare = ibmebus_bus_pm_prepare,
-	.complete = ibmebus_bus_pm_complete,
-	.suspend = ibmebus_bus_pm_suspend,
-	.resume = ibmebus_bus_pm_resume,
-	.freeze = ibmebus_bus_pm_freeze,
-	.thaw = ibmebus_bus_pm_thaw,
-	.poweroff = ibmebus_bus_pm_poweroff,
-	.restore = ibmebus_bus_pm_restore,
-	.suspend_noirq = ibmebus_bus_pm_suspend_noirq,
-	.resume_noirq = ibmebus_bus_pm_resume_noirq,
-	.freeze_noirq = ibmebus_bus_pm_freeze_noirq,
-	.thaw_noirq = ibmebus_bus_pm_thaw_noirq,
-	.poweroff_noirq = ibmebus_bus_pm_poweroff_noirq,
-	.restore_noirq = ibmebus_bus_pm_restore_noirq,
-};
-
-#define IBMEBUS_BUS_PM_OPS_PTR	(&ibmebus_bus_dev_pm_ops)
-
-#else /* !CONFIG_PM_SLEEP */
-
-#define IBMEBUS_BUS_PM_OPS_PTR	NULL
-
-#endif /* !CONFIG_PM_SLEEP */
-
 struct bus_type ibmebus_bus_type = {
 	.name      = "ibmebus",
 	.uevent    = of_device_uevent_modalias,
@@ -729,7 +432,6 @@ struct bus_type ibmebus_bus_type = {
 	.remove    = ibmebus_bus_device_remove,
 	.shutdown  = ibmebus_bus_device_shutdown,
 	.dev_attrs = ibmebus_bus_device_attrs,
-	.pm        = IBMEBUS_BUS_PM_OPS_PTR,
 };
 EXPORT_SYMBOL(ibmebus_bus_type);
 
-- 
2.1.4
