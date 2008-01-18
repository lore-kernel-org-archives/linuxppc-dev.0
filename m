Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail102-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EE7B5DDFA7
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:09 +1100 (EST)
Message-ID: <47910C70.5040802@am.sony.com>
Date: Fri, 18 Jan 2008 12:30:40 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 04/16] PS3: Use the HVs storage device notification mechanism
	properly
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

The PS3 hypervisor has a storage device notification mechanism to wait until a
storage device is ready. Unfortunately the storage device probing code used
this mechanism in an incorrect way, needing a polling loop and handling of
devices that are not yet ready.

This change corrects this by:
  - First waiting for the reception of an asynchronous notification that a new
    storage device became ready,
  - Then looking up the storage device in the device repository.

On shutdown, the storage probe thread is stopped and the storage notification
device is closed using a reboot notifier.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/device-init.c |  422 ++++++++++++++++---------------
 arch/powerpc/platforms/ps3/platform.h    |    2 
 arch/powerpc/platforms/ps3/repository.c  |   29 --
 3 files changed, 221 insertions(+), 232 deletions(-)

--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/init.h>
+#include <linux/reboot.h>
 
 #include <asm/firmware.h>
 #include <asm/lv1call.h>
@@ -238,166 +239,6 @@ static int __init ps3_setup_vuart_device
 	return result;
 }
 
-static int ps3stor_wait_for_completion(u64 dev_id, u64 tag,
-				       unsigned int timeout)
-{
-	int result = -1;
-	unsigned int retries = 0;
-	u64 status;
-
-	for (retries = 0; retries < timeout; retries++) {
-		result = lv1_storage_check_async_status(dev_id, tag, &status);
-		if (!result)
-			break;
-
-		msleep(1);
-	}
-
-	if (result)
-		pr_debug("%s:%u: check_async_status: %s, status %lx\n",
-			 __func__, __LINE__, ps3_result(result), status);
-
-	return result;
-}
-
-/**
- * ps3_storage_wait_for_device - Wait for a storage device to become ready.
- * @repo: The repository device to wait for.
- *
- * Uses the hypervisor's storage device notification mechanism to wait until
- * a storage device is ready.  The device notification mechanism uses a
- * psuedo device (id = -1) to asynchronously notify the guest when storage
- * devices become ready.  The notification device has a block size of 512
- * bytes.
- */
-
-static int ps3_storage_wait_for_device(const struct ps3_repository_device *repo)
-{
-	int error = -ENODEV;
-	int result;
-	const u64 notification_dev_id = (u64)-1LL;
-	const unsigned int timeout = HZ;
-	u64 lpar;
-	u64 tag;
-	void *buf;
-	enum ps3_notify_type {
-		notify_device_ready = 0,
-		notify_region_probe = 1,
-		notify_region_update = 2,
-	};
-	struct {
-		u64 operation_code;	/* must be zero */
-		u64 event_mask;		/* OR of 1UL << enum ps3_notify_type */
-	} *notify_cmd;
-	struct {
-		u64 event_type;		/* enum ps3_notify_type */
-		u64 bus_id;
-		u64 dev_id;
-		u64 dev_type;
-		u64 dev_port;
-	} *notify_event;
-
-	pr_debug(" -> %s:%u: (%lu:%lu:%u)\n", __func__, __LINE__, repo->bus_id,
-		 repo->dev_id, repo->dev_type);
-
-	buf = kzalloc(512, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	lpar = ps3_mm_phys_to_lpar(__pa(buf));
-	notify_cmd = buf;
-	notify_event = buf;
-
-	result = lv1_open_device(repo->bus_id, notification_dev_id, 0);
-	if (result) {
-		printk(KERN_ERR "%s:%u: lv1_open_device %s\n", __func__,
-		       __LINE__, ps3_result(result));
-		goto fail_free;
-	}
-
-	/* Setup and write the request for device notification. */
-
-	notify_cmd->operation_code = 0; /* must be zero */
-	notify_cmd->event_mask = 1UL << notify_region_probe;
-
-	result = lv1_storage_write(notification_dev_id, 0, 0, 1, 0, lpar,
-				   &tag);
-	if (result) {
-		printk(KERN_ERR "%s:%u: write failed %s\n", __func__, __LINE__,
-		       ps3_result(result));
-		goto fail_close;
-	}
-
-	/* Wait for the write completion */
-
-	result = ps3stor_wait_for_completion(notification_dev_id, tag,
-					     timeout);
-	if (result) {
-		printk(KERN_ERR "%s:%u: write not completed %s\n", __func__,
-		       __LINE__, ps3_result(result));
-		goto fail_close;
-	}
-
-	/* Loop here processing the requested notification events. */
-
-	while (1) {
-		memset(notify_event, 0, sizeof(*notify_event));
-
-		result = lv1_storage_read(notification_dev_id, 0, 0, 1, 0,
-					  lpar, &tag);
-		if (result) {
-			printk(KERN_ERR "%s:%u: write failed %s\n", __func__,
-			       __LINE__, ps3_result(result));
-			break;
-		}
-
-		result = ps3stor_wait_for_completion(notification_dev_id, tag,
-						     timeout);
-		if (result) {
-			printk(KERN_ERR "%s:%u: read not completed %s\n",
-			       __func__, __LINE__, ps3_result(result));
-			break;
-		}
-
-		pr_debug("%s:%d: notify event (%u:%u:%u): event_type 0x%lx, "
-			 "port %lu\n", __func__, __LINE__, repo->bus_index,
-			 repo->dev_index, repo->dev_type,
-			 notify_event->event_type, notify_event->dev_port);
-
-		if (notify_event->event_type != notify_region_probe ||
-		    notify_event->bus_id != repo->bus_id) {
-			pr_debug("%s:%u: bad notify_event: event %lu, "
-				 "dev_id %lu, dev_type %lu\n",
-				 __func__, __LINE__, notify_event->event_type,
-				 notify_event->dev_id, notify_event->dev_type);
-			break;
-		}
-
-		if (notify_event->dev_id == repo->dev_id &&
-		    notify_event->dev_type == repo->dev_type) {
-			pr_debug("%s:%u: device ready (%u:%u:%u)\n", __func__,
-				 __LINE__, repo->bus_index, repo->dev_index,
-				 repo->dev_type);
-			error = 0;
-			break;
-		}
-
-		if (notify_event->dev_id == repo->dev_id &&
-		    notify_event->dev_type == PS3_DEV_TYPE_NOACCESS) {
-			pr_debug("%s:%u: no access: dev_id %lu\n", __func__,
-				 __LINE__, repo->dev_id);
-			break;
-		}
-	}
-
-fail_close:
-	lv1_close_device(repo->bus_id, notification_dev_id);
-fail_free:
-	kfree(buf);
-	pr_debug(" <- %s:%u\n", __func__, __LINE__);
-	return error;
-}
-
 static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
 				 enum ps3_match_id match_id)
 {
@@ -449,16 +290,6 @@ static int ps3_setup_storage_dev(const s
 		goto fail_find_interrupt;
 	}
 
-	/* FIXME: Arrange to only do this on a 'cold' boot */
-
-	result = ps3_storage_wait_for_device(repo);
-	if (result) {
-		printk(KERN_ERR "%s:%u: storage_notification failed %d\n",
-		       __func__, __LINE__, result);
-		result = -ENODEV;
-		goto fail_probe_notification;
-	}
-
 	for (i = 0; i < num_regions; i++) {
 		unsigned int id;
 		u64 start, size;
@@ -494,7 +325,6 @@ static int ps3_setup_storage_dev(const s
 
 fail_device_register:
 fail_read_region:
-fail_probe_notification:
 fail_find_interrupt:
 	kfree(p);
 fail_malloc:
@@ -659,62 +489,248 @@ static int ps3_register_repository_devic
 	return result;
 }
 
+
+#define PS3_NOTIFICATION_DEV_ID		ULONG_MAX
+#define PS3_NOTIFICATION_INTERRUPT_ID	0
+
+struct ps3_notification_device {
+	struct ps3_system_bus_device sbd;
+	spinlock_t lock;
+	u64 tag;
+	u64 lv1_status;
+	struct completion done;
+};
+
+enum ps3_notify_type {
+	notify_device_ready = 0,
+	notify_region_probe = 1,
+	notify_region_update = 2,
+};
+
+struct ps3_notify_cmd {
+	u64 operation_code;		/* must be zero */
+	u64 event_mask;			/* OR of 1UL << enum ps3_notify_type */
+};
+
+struct ps3_notify_event {
+	u64 event_type;			/* enum ps3_notify_type */
+	u64 bus_id;
+	u64 dev_id;
+	u64 dev_type;
+	u64 dev_port;
+};
+
+static irqreturn_t ps3_notification_interrupt(int irq, void *data)
+{
+	struct ps3_notification_device *dev = data;
+	int res;
+	u64 tag, status;
+
+	spin_lock(&dev->lock);
+	res = lv1_storage_get_async_status(PS3_NOTIFICATION_DEV_ID, &tag,
+					   &status);
+	if (tag != dev->tag)
+		pr_err("%s:%u: tag mismatch, got %lx, expected %lx\n",
+		       __func__, __LINE__, tag, dev->tag);
+
+	if (res) {
+		pr_err("%s:%u: res %d status 0x%lx\n", __func__, __LINE__, res,
+		       status);
+	} else {
+		pr_debug("%s:%u: completed, status 0x%lx\n", __func__,
+			 __LINE__, status);
+		dev->lv1_status = status;
+		complete(&dev->done);
+	}
+	spin_unlock(&dev->lock);
+	return IRQ_HANDLED;
+}
+
+static int ps3_notification_read_write(struct ps3_notification_device *dev,
+				       u64 lpar, int write)
+{
+	const char *op = write ? "write" : "read";
+	unsigned long flags;
+	int res;
+
+	init_completion(&dev->done);
+	spin_lock_irqsave(&dev->lock, flags);
+	res = write ? lv1_storage_write(dev->sbd.dev_id, 0, 0, 1, 0, lpar,
+					&dev->tag)
+		    : lv1_storage_read(dev->sbd.dev_id, 0, 0, 1, 0, lpar,
+				       &dev->tag);
+	spin_unlock_irqrestore(&dev->lock, flags);
+	if (res) {
+		pr_err("%s:%u: %s failed %d\n", __func__, __LINE__, op, res);
+		return -EPERM;
+	}
+	pr_debug("%s:%u: notification %s issued\n", __func__, __LINE__, op);
+
+	res = wait_event_interruptible(dev->done.wait,
+				       dev->done.done || kthread_should_stop());
+	if (kthread_should_stop())
+		res = -EINTR;
+	if (res) {
+		pr_debug("%s:%u: interrupted %s\n", __func__, __LINE__, op);
+		return res;
+	}
+
+	if (dev->lv1_status) {
+		pr_err("%s:%u: %s not completed, status 0x%lx\n", __func__,
+		       __LINE__, op, dev->lv1_status);
+		return -EIO;
+	}
+	pr_debug("%s:%u: notification %s completed\n", __func__, __LINE__, op);
+
+	return 0;
+}
+
+static struct task_struct *probe_task;
+
 /**
  * ps3_probe_thread - Background repository probing at system startup.
  *
  * This implementation only supports background probing on a single bus.
+ * It uses the hypervisor's storage device notification mechanism to wait until
+ * a storage device is ready.  The device notification mechanism uses a
+ * pseudo device to asynchronously notify the guest when storage devices become
+ * ready.  The notification device has a block size of 512 bytes.
  */
 
 static int ps3_probe_thread(void *data)
 {
-	struct ps3_repository_device *repo = data;
-	int result;
-	unsigned int ms = 250;
+	struct ps3_notification_device dev;
+	struct ps3_repository_device repo;
+	int res;
+	unsigned int irq;
+	u64 lpar;
+	void *buf;
+	struct ps3_notify_cmd *notify_cmd;
+	struct ps3_notify_event *notify_event;
 
 	pr_debug(" -> %s:%u: kthread started\n", __func__, __LINE__);
 
-	do {
-		try_to_freeze();
+	buf = kzalloc(512, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
-		pr_debug("%s:%u: probing...\n", __func__, __LINE__);
+	lpar = ps3_mm_phys_to_lpar(__pa(buf));
+	notify_cmd = buf;
+	notify_event = buf;
 
-		do {
-			result = ps3_repository_find_device(repo);
+	/* dummy system bus device */
+	dev.sbd.bus_id = (u64)data;
+	dev.sbd.dev_id = PS3_NOTIFICATION_DEV_ID;
+	dev.sbd.interrupt_id = PS3_NOTIFICATION_INTERRUPT_ID;
+
+	res = lv1_open_device(dev.sbd.bus_id, dev.sbd.dev_id, 0);
+	if (res) {
+		pr_err("%s:%u: lv1_open_device failed %s\n", __func__,
+		       __LINE__, ps3_result(res));
+		goto fail_free;
+	}
 
-			if (result == -ENODEV)
-				pr_debug("%s:%u: nothing new\n", __func__,
-					__LINE__);
-			else if (result)
-				pr_debug("%s:%u: find device error.\n",
-					__func__, __LINE__);
-			else {
-				pr_debug("%s:%u: found device (%u:%u:%u)\n",
-					 __func__, __LINE__, repo->bus_index,
-					 repo->dev_index, repo->dev_type);
-				ps3_register_repository_device(repo);
-				ps3_repository_bump_device(repo);
-				ms = 250;
-			}
-		} while (!result);
+	res = ps3_sb_event_receive_port_setup(&dev.sbd, PS3_BINDING_CPU_ANY,
+					      &irq);
+	if (res) {
+		pr_err("%s:%u: ps3_sb_event_receive_port_setup failed %d\n",
+		       __func__, __LINE__, res);
+	       goto fail_close_device;
+	}
+
+	spin_lock_init(&dev.lock);
+
+	res = request_irq(irq, ps3_notification_interrupt, IRQF_DISABLED,
+			  "ps3_notification", &dev);
+	if (res) {
+		pr_err("%s:%u: request_irq failed %d\n", __func__, __LINE__,
+		       res);
+		goto fail_sb_event_receive_port_destroy;
+	}
 
-		pr_debug("%s:%u: ms %u\n", __func__, __LINE__, ms);
+	/* Setup and write the request for device notification. */
+	notify_cmd->operation_code = 0; /* must be zero */
+	notify_cmd->event_mask = 1UL << notify_region_probe;
 
-		if ( ms > 60000)
+	res = ps3_notification_read_write(&dev, lpar, 1);
+	if (res)
+		goto fail_free_irq;
+
+	/* Loop here processing the requested notification events. */
+	do {
+		try_to_freeze();
+
+		memset(notify_event, 0, sizeof(*notify_event));
+
+		res = ps3_notification_read_write(&dev, lpar, 0);
+		if (res)
 			break;
 
-		msleep_interruptible(ms);
+		pr_debug("%s:%u: notify event type 0x%lx bus id %lu dev id %lu"
+			 " type %lu port %lu\n", __func__, __LINE__,
+			 notify_event->event_type, notify_event->bus_id,
+			 notify_event->dev_id, notify_event->dev_type,
+			 notify_event->dev_port);
 
-		/* An exponential backoff. */
-		ms <<= 1;
+		if (notify_event->event_type != notify_region_probe ||
+		    notify_event->bus_id != dev.sbd.bus_id) {
+			pr_warning("%s:%u: bad notify_event: event %lu, "
+				   "dev_id %lu, dev_type %lu\n",
+				   __func__, __LINE__, notify_event->event_type,
+				   notify_event->dev_id,
+				   notify_event->dev_type);
+			continue;
+		}
+
+		res = ps3_repository_find_device_by_id(&repo, dev.sbd.bus_id,
+						       notify_event->dev_id);
+		if (res) {
+			pr_warning("%s:%u: device %lu:%lu not found\n",
+				   __func__, __LINE__, dev.sbd.bus_id,
+				   notify_event->dev_id);
+			continue;
+		}
+
+		pr_debug("%s:%u: device %lu:%lu found\n", __func__, __LINE__,
+			 dev.sbd.bus_id, notify_event->dev_id);
+		ps3_register_repository_device(&repo);
 
 	} while (!kthread_should_stop());
 
+fail_free_irq:
+	free_irq(irq, &dev);
+fail_sb_event_receive_port_destroy:
+	ps3_sb_event_receive_port_destroy(&dev.sbd, irq);
+fail_close_device:
+	lv1_close_device(dev.sbd.bus_id, dev.sbd.dev_id);
+fail_free:
+	kfree(buf);
+
+	probe_task = NULL;
+
 	pr_debug(" <- %s:%u: kthread finished\n", __func__, __LINE__);
 
 	return 0;
 }
 
 /**
+ * ps3_stop_probe_thread - Stops the background probe thread.
+ *
+ */
+
+static int ps3_stop_probe_thread(struct notifier_block *nb, unsigned long code,
+				 void *data)
+{
+	if (probe_task)
+		kthread_stop(probe_task);
+	return 0;
+}
+
+static struct notifier_block nb = {
+	.notifier_call = ps3_stop_probe_thread
+};
+
+/**
  * ps3_start_probe_thread - Starts the background probe thread.
  *
  */
@@ -723,7 +739,7 @@ static int __init ps3_start_probe_thread
 {
 	int result;
 	struct task_struct *task;
-	static struct ps3_repository_device repo; /* must be static */
+	struct ps3_repository_device repo;
 
 	pr_debug(" -> %s:%d\n", __func__, __LINE__);
 
@@ -746,7 +762,8 @@ static int __init ps3_start_probe_thread
 		return -ENODEV;
 	}
 
-	task = kthread_run(ps3_probe_thread, &repo, "ps3-probe-%u", bus_type);
+	task = kthread_run(ps3_probe_thread, (void *)repo.bus_id,
+			   "ps3-probe-%u", bus_type);
 
 	if (IS_ERR(task)) {
 		result = PTR_ERR(task);
@@ -755,6 +772,9 @@ static int __init ps3_start_probe_thread
 		return result;
 	}
 
+	probe_task = task;
+	register_reboot_notifier(&nb);
+
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 	return 0;
 }
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -89,8 +89,6 @@ enum ps3_dev_type {
 	PS3_DEV_TYPE_STOR_ROM = TYPE_ROM,	/* 5 */
 	PS3_DEV_TYPE_SB_GPIO = 6,
 	PS3_DEV_TYPE_STOR_FLASH = TYPE_RBC,	/* 14 */
-	PS3_DEV_TYPE_STOR_DUMMY = 32,
-	PS3_DEV_TYPE_NOACCESS = 255,
 };
 
 int ps3_repository_read_bus_str(unsigned int bus_index, const char *bus_str,
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -344,35 +344,6 @@ int ps3_repository_find_device(struct ps
 		return result;
 	}
 
-	if (tmp.bus_type == PS3_BUS_TYPE_STORAGE) {
-		/*
-		 * A storage device may show up in the repository before the
-		 * hypervisor has finished probing its type and regions
-		 */
-		unsigned int num_regions;
-
-		if (tmp.dev_type == PS3_DEV_TYPE_STOR_DUMMY) {
-			pr_debug("%s:%u storage device not ready\n", __func__,
-				 __LINE__);
-			return -ENODEV;
-		}
-
-		result = ps3_repository_read_stor_dev_num_regions(tmp.bus_index,
-								  tmp.dev_index,
-								  &num_regions);
-		if (result) {
-			pr_debug("%s:%d read_stor_dev_num_regions failed\n",
-				 __func__, __LINE__);
-			return result;
-		}
-
-		if (!num_regions) {
-			pr_debug("%s:%u storage device has no regions yet\n",
-				 __func__, __LINE__);
-			return -ENODEV;
-		}
-	}
-
 	result = ps3_repository_read_dev_id(tmp.bus_index, tmp.dev_index,
 		&tmp.dev_id);
 

-- 
