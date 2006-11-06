Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 06 Nov 2006 18:05:39 +1100
Subject: [PATCH 2/27] Call platform_notify_remove later
In-Reply-To: <1162796738.274582.277491064706.qpush@grosgo>
Message-Id: <20061106070654.D25E067C5D@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move the call to platform_notify_remove() to after the call to
bus_remove_device(), where it belongs.  It's bogus to notify the platform
of removal while drivers are still attached to the device and possibly
still operating since the platform might use this callback to tear down
some resources used by the driver (ACPI bits, iommu table, ...)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

---
This patch is already in -mm under the name

call-platform_notify_remove-later.patch

 drivers/base/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-cell/drivers/base/core.c
===================================================================
--- linux-cell.orig/drivers/base/core.c	2006-10-25 13:04:40.000000000 +1000
+++ linux-cell/drivers/base/core.c	2006-10-25 13:04:56.000000000 +1000
@@ -615,12 +615,13 @@ void device_del(struct device * dev)
 	device_remove_groups(dev);
 	device_remove_attrs(dev);
 
+	bus_remove_device(dev);
+
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
 	 */
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
-	bus_remove_device(dev);
 	device_pm_remove(dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
