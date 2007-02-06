Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 33409DDE48
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 09:23:55 +1100 (EST)
Message-ID: <45C8FFF3.8040508@am.sony.com>
Date: Tue, 06 Feb 2007 14:23:47 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/3] PS3: Vuart add async read
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add asynchronous read support to the PS3 vuart driver.  This is needed to
support the PS3 system manager driver.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 drivers/ps3/vuart.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ps3/vuart.h |   29 ++++++++++++++++++++++++----
 2 files changed, 78 insertions(+), 4 deletions(-)

--- ps3-linux-dev.orig/drivers/ps3/vuart.c
+++ ps3-linux-dev/drivers/ps3/vuart.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 #include <asm/ps3.h>
 
 #include <asm/lv1call.h>
@@ -565,6 +566,44 @@ int ps3_vuart_read(struct ps3_vuart_port
 	return 0;
 }
 
+int ps3_vuart_read_async(struct ps3_vuart_port_device *dev, work_func_t func,
+	unsigned int bytes)
+{
+	unsigned long flags;
+
+	if(dev->priv->work.trigger) {
+		dev_dbg(&dev->core, "%s:%d: warning, multiple calls\n",
+			__func__, __LINE__);
+		return -EAGAIN;
+	}
+
+	BUG_ON(!bytes);
+
+	PREPARE_WORK(&dev->priv->work.work, func);
+
+	spin_lock_irqsave(&dev->priv->work.lock, flags);
+	if(dev->priv->rx_list.bytes_held >= bytes) {
+		dev_dbg(&dev->core, "%s:%d: schedule_work %xh bytes\n",
+			__func__, __LINE__, bytes);
+		schedule_work(&dev->priv->work.work);
+		spin_unlock_irqrestore(&dev->priv->work.lock, flags);
+		return 0;
+	}
+
+	dev->priv->work.trigger = bytes;
+	spin_unlock_irqrestore(&dev->priv->work.lock, flags);
+
+	dev_dbg(&dev->core, "%s:%d: waiting for %u(%xh) bytes\n", __func__,
+		__LINE__, bytes, bytes);
+
+	return 0;
+}
+
+void ps3_vuart_cancel_async(struct ps3_vuart_port_device *dev)
+{
+	dev->priv->work.trigger = 0;
+}
+
 /**
  * ps3_vuart_handle_interrupt_tx - third stage transmit interrupt handler
  *
@@ -672,6 +711,15 @@ static int ps3_vuart_handle_interrupt_rx
 	dev_dbg(&dev->core, "%s:%d: buf_%lu: queued %lxh bytes\n",
 		__func__, __LINE__, lb->dbg_number, bytes);
 
+	spin_lock_irqsave(&dev->priv->work.lock, flags);
+	if(dev->priv->work.trigger
+		&& dev->priv->rx_list.bytes_held >= dev->priv->work.trigger) {
+		dev_dbg(&dev->core, "%s:%d: schedule_work %lxh bytes\n",
+			__func__, __LINE__, dev->priv->work.trigger);
+		dev->priv->work.trigger = 0;
+		schedule_work(&dev->priv->work.work);
+	}
+	spin_unlock_irqrestore(&dev->priv->work.lock, flags);
 	return 0;
 }
 
@@ -837,6 +885,11 @@ static int ps3_vuart_probe(struct device
 	INIT_LIST_HEAD(&dev->priv->rx_list.head);
 	spin_lock_init(&dev->priv->rx_list.lock);
 
+	INIT_WORK(&dev->priv->work.work, NULL);
+	spin_lock_init(&dev->priv->work.lock);
+	dev->priv->work.trigger = 0;
+	dev->priv->work.dev = dev;
+
 	if (++vuart_bus_priv.use_count == 1) {
 
 		result = ps3_alloc_vuart_irq(PS3_BINDING_CPU_ANY,
--- ps3-linux-dev.orig/drivers/ps3/vuart.h
+++ ps3-linux-dev/drivers/ps3/vuart.h
@@ -31,6 +31,13 @@ struct ps3_vuart_stats {
 	unsigned long disconnect_interrupts;
 };
 
+struct ps3_vuart_work {
+	struct work_struct work;
+	unsigned long trigger;
+	spinlock_t lock;
+	struct ps3_vuart_port_device* dev; /* to convert work to device */
+};
+
 /**
  * struct ps3_vuart_port_priv - private vuart device data.
  */
@@ -49,6 +56,7 @@ struct ps3_vuart_port_priv {
 		struct list_head head;
 	} rx_list;
 	struct ps3_vuart_stats stats;
+	struct ps3_vuart_work work;
 };
 
 /**
@@ -71,10 +79,6 @@ struct ps3_vuart_port_driver {
 int ps3_vuart_port_driver_register(struct ps3_vuart_port_driver *drv);
 void ps3_vuart_port_driver_unregister(struct ps3_vuart_port_driver *drv);
 
-int ps3_vuart_write(struct ps3_vuart_port_device *dev,
-	const void* buf, unsigned int bytes);
-int ps3_vuart_read(struct ps3_vuart_port_device *dev, void* buf,
-	unsigned int bytes);
 static inline struct ps3_vuart_port_driver *to_ps3_vuart_port_driver(
 	struct device_driver *_drv)
 {
@@ -85,5 +89,22 @@ static inline struct ps3_vuart_port_devi
 {
 	return container_of(_dev, struct ps3_vuart_port_device, core);
 }
+static inline struct ps3_vuart_port_device *ps3_vuart_work_to_port_device(
+	struct work_struct *_work)
+{
+	struct ps3_vuart_work *vw = container_of(_work, struct ps3_vuart_work,
+		work);
+	return vw->dev;
+}
+
+int ps3_vuart_write(struct ps3_vuart_port_device *dev, const void* buf,
+	unsigned int bytes);
+int ps3_vuart_read(struct ps3_vuart_port_device *dev, void* buf,
+	unsigned int bytes);
+int ps3_vuart_read_async(struct ps3_vuart_port_device *dev, work_func_t func,
+	unsigned int bytes);
+void ps3_vuart_cancel_async(struct ps3_vuart_port_device *dev);
+void ps3_vuart_clear_rx_bytes(struct ps3_vuart_port_device *dev,
+	unsigned int bytes);
 
 #endif
