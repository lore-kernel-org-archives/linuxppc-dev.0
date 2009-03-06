Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id 3A25ADDE98
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 03:10:24 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so833885rvb.1
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 08:10:22 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC] drivers/base: Add bus_register_notifier_alldev() variant
Date: Fri, 06 Mar 2009 09:10:19 -0700
Message-ID: <20090306160818.404.92700.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

bus_register_notifier_alldev() is a variation on bus_register_notifier()
which also triggers the notifier callback for devices already on the bus
and already bound to drivers.

This function is useful for the case where a driver needs to get a
reference to a struct device other than the one it is bound to and
it is not known if the device will be bound before or after this
function is called.  For example, an Ethernet device connected to
a PHY that is probed separately.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: linux-kernel@vger.kernel.org
CC: linuxppc-dev@ozlabs.org
CC: Greg Kroah-Hartman <gregkh@suse.de>
---

I'm using this as part of some changes to phylib to make it easier for
Ethernet drivers to find their PHY device.  Before I'm completely committed
to this approach I'd like some feedback on this change to drivers core.

Thanks,
g.


 drivers/base/bus.c     |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |    2 ++
 2 files changed, 49 insertions(+), 0 deletions(-)


diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 83f32b8..6edde85 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -962,6 +962,53 @@ int bus_register_notifier(struct bus_type *bus, struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(bus_register_notifier);
 
+/**
+ * bus_register_notifier_alldev_helper - internal support function
+ * Used by bus_register_notifier_alldev() to create ADD and BOUND events
+ * for devices.
+ */
+static int bus_register_notifier_alldev_helper(struct device *dev, void *data)
+{
+	struct notifier_block *nb = data;
+	nb->notifier_call(nb, BUS_NOTIFY_ADD_DEVICE, dev);
+	if (dev->driver)
+		nb->notifier_call(nb, BUS_NOTIFY_BOUND_DRIVER, dev);
+	return 0;
+}
+
+/**
+ * bus_register_notifier_alldev - Register for bus events; include existing devs
+ * @bus: pointer to bus_type
+ * @nb: pointer to notifier block to register with the bus
+ *
+ * Similar to bus_register_notifier() except it also generates events for
+ * devices already on the bus when the notifier is registered.  When this
+ * function is called the notifier is called once for each device with
+ * the BUS_NOTIFY_ADD_DEVICE event, and once for each device registered to
+ * a driver * with the BUS_NOTIFY_BOUND_DRIVER event.
+ *
+ * There is a small chance that the notifier could be called more than once
+ * for a device.  This would happen if a new device was registered on the bus
+ * or bound to a driver between the call to bus_register_notifier() and the
+ * call to bus_for_each_dev().  The only way I can see to protect against
+ * this would be to take the klist_devices spinlock while calling the
+ * notifier; but that would be a Very Bad Thing (tm).  Caller needs to be
+ * aware that a notifier called before this function returns might get
+ * called a second time on the same device.
+ */
+int bus_register_notifier_alldev(struct bus_type *b, struct notifier_block *nb)
+{
+	int ret;
+
+	ret = bus_register_notifier(b, nb);
+	if (ret == 0) {
+		bus_for_each_dev(b, NULL, nb,
+				 bus_register_notifier_alldev_helper);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bus_register_notifier_alldev);
+
 int bus_unregister_notifier(struct bus_type *bus, struct notifier_block *nb)
 {
 	return blocking_notifier_chain_unregister(&bus->p->bus_notifier, nb);
diff --git a/include/linux/device.h b/include/linux/device.h
index 45e5b19..05c7d5b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -103,6 +103,8 @@ struct notifier_block;
 
 extern int bus_register_notifier(struct bus_type *bus,
 				 struct notifier_block *nb);
+extern int bus_register_notifier_alldev(struct bus_type *b,
+					struct notifier_block *nb);
 extern int bus_unregister_notifier(struct bus_type *bus,
 				   struct notifier_block *nb);
 
