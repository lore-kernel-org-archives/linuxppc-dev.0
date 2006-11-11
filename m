Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 11 Nov 2006 17:24:45 +1100
Subject: [PATCH 3/32] Driver core: add notification of bus events
In-Reply-To: <1163226282.72526.823314634857.qpush@butch>
Message-Id: <20061111062516.315D8680FD@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I finally did as you suggested and added the notifier to the struct
bus_type itself. There are still problems to be expected is something
attaches to a bus type where the code can hook in different struct
device sub-classes (which is imho a big bogosity but I won't even try to
argue that case now) but it will solve nicely a number of issues I've
had so far.

That also means that clients interested in registering for such
notifications have to do it before devices are added and after bus types
are registered. Fortunately, most bus types that matter for the various
usage scenarios I have in mind are registerd at postcore_initcall time,
which means I have a really nice spot at arch_initcall time to add my
notifiers.

There are 4 notifications provided. Device being added (before hooked to
the bus) and removed (failure of previous case or after being unhooked
from the bus), along with driver being bound to a device and about to be
unbound.

The usage I have for these are:

 - The 2 first ones are used to maintain the DMA operations for various
bus types via the new dev_archdata addition to struct device (added by
a separate patch).

 - The other two ones have a completely different usage scenario. I have
cases where multiple devices and their drivers depend on each other. For
example, the IBM EMAC network driver needs to attach to a MAL DMA engine
which is a separate device, and a PHY interface which is also a separate
device. They are all of_platform_device's (well, about to be with my
upcoming patches) but there is no say in what precise order the core
will "probe" them and instanciate the various modules. The solution I
found for that is to have the drivers for emac to use multithread_probe,
and wait for a driver to be bound to the target MAL and PHY control
devices (the device-tree contains reference to the MAL and PHY interface
nodes, which I can then match to of_platform_devices). Right now, I've
been polling, but with that notifier, I can more cleanly wait (with a
timeout of course).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This patch is already in Greg KH tree under the name

driver-core-add-notification-of-bus-events.patch

 drivers/base/bus.c     |   15 +++++++++++++++
 drivers/base/core.c    |   12 ++++++++++++
 drivers/base/dd.c      |   10 ++++++++++
 include/linux/device.h |   25 ++++++++++++++++++++++++-
 4 files changed, 61 insertions(+), 1 deletion(-)

Index: linux-cell/drivers/base/core.c
===================================================================
--- linux-cell.orig/drivers/base/core.c	2006-11-02 13:20:21.000000000 +1100
+++ linux-cell/drivers/base/core.c	2006-11-02 13:20:24.000000000 +1100
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/kdev_t.h>
+#include <linux/notifier.h>
 
 #include <asm/semaphore.h>
 
@@ -428,6 +429,11 @@ int device_add(struct device *dev)
 	if (platform_notify)
 		platform_notify(dev);
 
+	/* notify clients of device entry (new way) */
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->bus_notifier,
+					     BUS_NOTIFY_ADD_DEVICE, dev);
+
 	dev->uevent_attr.attr.name = "uevent";
 	dev->uevent_attr.attr.mode = S_IWUSR;
 	if (dev->driver)
@@ -504,6 +510,9 @@ int device_add(struct device *dev)
  BusError:
 	device_pm_remove(dev);
  PMError:
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->bus_notifier,
+					     BUS_NOTIFY_DEL_DEVICE, dev);
 	device_remove_groups(dev);
  GroupError:
  	device_remove_attrs(dev);
@@ -622,6 +631,9 @@ void device_del(struct device * dev)
 	 */
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->bus_notifier,
+					     BUS_NOTIFY_DEL_DEVICE, dev);
 	device_pm_remove(dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
Index: linux-cell/include/linux/device.h
===================================================================
--- linux-cell.orig/include/linux/device.h	2006-10-25 12:50:17.000000000 +1000
+++ linux-cell/include/linux/device.h	2006-11-02 13:20:24.000000000 +1100
@@ -42,6 +42,8 @@ struct bus_type {
 	struct klist		klist_devices;
 	struct klist		klist_drivers;
 
+	struct blocking_notifier_head bus_notifier;
+
 	struct bus_attribute	* bus_attrs;
 	struct device_attribute	* dev_attrs;
 	struct driver_attribute	* drv_attrs;
@@ -75,6 +77,28 @@ int __must_check bus_for_each_drv(struct
 		struct device_driver *start, void *data,
 		int (*fn)(struct device_driver *, void *));
 
+/* Bus notifiers: Get notified of addition/removal of devices
+ * and binding/unbinding of drivers to devices.
+ * In the long run, it should be a replacement for the platform
+ * notify hooks.
+ */
+struct notifier_block;
+
+extern int register_bus_notifier(struct bus_type *bus,
+				 struct notifier_block *nb);
+extern int unregister_bus_notifier(struct bus_type *bus,
+				   struct notifier_block *nb);
+
+/* All 4 notifers below get called with the target struct device *
+ * as an argument. Note that those functions are likely to be called
+ * with the device semaphore held in the core, so be careful.
+ */
+#define BUS_NOTIFY_ADD_DEVICE		0x00000001 /* device added */
+#define BUS_NOTIFY_DEL_DEVICE		0x00000002 /* device removed */
+#define BUS_NOTIFY_BOUND_DRIVER		0x00000003 /* driver bound to device */
+#define BUS_NOTIFY_UNBIND_DRIVER	0x00000004 /* driver about to be
+						      unbound */
+
 /* driverfs interface for exporting bus attributes */
 
 struct bus_attribute {
@@ -427,7 +451,6 @@ extern int (*platform_notify)(struct dev
 
 extern int (*platform_notify_remove)(struct device * dev);
 
-
 /**
  * get_device - atomically increment the reference count for the device.
  *
Index: linux-cell/drivers/base/bus.c
===================================================================
--- linux-cell.orig/drivers/base/bus.c	2006-10-23 14:41:37.000000000 +1000
+++ linux-cell/drivers/base/bus.c	2006-11-02 13:20:24.000000000 +1100
@@ -724,6 +724,8 @@ int bus_register(struct bus_type * bus)
 {
 	int retval;
 
+	BLOCKING_INIT_NOTIFIER_HEAD(&bus->bus_notifier);
+
 	retval = kobject_set_name(&bus->subsys.kset.kobj, "%s", bus->name);
 	if (retval)
 		goto out;
@@ -782,6 +784,16 @@ void bus_unregister(struct bus_type * bu
 	subsystem_unregister(&bus->subsys);
 }
 
+int register_bus_notifier(struct bus_type *bus, struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&bus->bus_notifier, nb);
+}
+
+int unregister_bus_notifier(struct bus_type *bus, struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&bus->bus_notifier, nb);
+}
+
 int __init buses_init(void)
 {
 	return subsystem_register(&bus_subsys);
@@ -798,3 +810,6 @@ EXPORT_SYMBOL_GPL(bus_rescan_devices);
 
 EXPORT_SYMBOL_GPL(bus_create_file);
 EXPORT_SYMBOL_GPL(bus_remove_file);
+
+EXPORT_SYMBOL_GPL(register_bus_notifier);
+EXPORT_SYMBOL_GPL(unregister_bus_notifier);
Index: linux-cell/drivers/base/dd.c
===================================================================
--- linux-cell.orig/drivers/base/dd.c	2006-10-30 08:00:39.000000000 +1100
+++ linux-cell/drivers/base/dd.c	2006-11-02 13:20:24.000000000 +1100
@@ -52,6 +52,11 @@ int device_bind_driver(struct device *de
 
 	pr_debug("bound device '%s' to driver '%s'\n",
 		 dev->bus_id, dev->driver->name);
+
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->bus_notifier,
+					     BUS_NOTIFY_BOUND_DRIVER, dev);
+
 	klist_add_tail(&dev->knode_driver, &dev->driver->klist_devices);
 	ret = sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
@@ -288,6 +293,11 @@ static void __device_release_driver(stru
 		sysfs_remove_link(&dev->kobj, "driver");
 		klist_remove(&dev->knode_driver);
 
+		if (dev->bus)
+			blocking_notifier_call_chain(&dev->bus->bus_notifier,
+						     BUS_NOTIFY_UNBIND_DRIVER,
+						     dev);
+
 		if (dev->bus && dev->bus->remove)
 			dev->bus->remove(dev);
 		else if (drv->remove)
