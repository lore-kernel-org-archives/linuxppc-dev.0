Return-Path: <kernelfans@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KZY21k6vzF1NW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 16:51:50 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id l65-v6so503242pgl.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 23:51:50 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv3 4/4] Revert "driver core: correct device's shutdown order"
Date: Tue,  3 Jul 2018 14:50:42 +0800
Message-Id: <1530600642-25090-5-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit 52cdbdd49853dfa856082edb0f4c4c0249d9df07.
Since the device_shutdown() does not rely on the order in devices_kset any
more, reverting that commit safely.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/base.h |  1 -
 drivers/base/core.c | 49 -------------------------------------------------
 drivers/base/dd.c   |  8 --------
 3 files changed, 58 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index a75c302..5bc9064 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -135,7 +135,6 @@ extern void device_unblock_probing(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
-extern void devices_kset_move_last(struct device *dev);
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
 extern void module_add_driver(struct module *mod, struct device_driver *drv);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index db3deb8..570aeee 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1259,52 +1259,6 @@ static DEVICE_ATTR_RO(dev);
 struct kset *devices_kset;
 
 /**
- * devices_kset_move_before - Move device in the devices_kset's list.
- * @deva: Device to move.
- * @devb: Device @deva should come before.
- */
-static void devices_kset_move_before(struct device *deva, struct device *devb)
-{
-	if (!devices_kset)
-		return;
-	pr_debug("devices_kset: Moving %s before %s\n",
-		 dev_name(deva), dev_name(devb));
-	spin_lock(&devices_kset->list_lock);
-	list_move_tail(&deva->kobj.entry, &devb->kobj.entry);
-	spin_unlock(&devices_kset->list_lock);
-}
-
-/**
- * devices_kset_move_after - Move device in the devices_kset's list.
- * @deva: Device to move
- * @devb: Device @deva should come after.
- */
-static void devices_kset_move_after(struct device *deva, struct device *devb)
-{
-	if (!devices_kset)
-		return;
-	pr_debug("devices_kset: Moving %s after %s\n",
-		 dev_name(deva), dev_name(devb));
-	spin_lock(&devices_kset->list_lock);
-	list_move(&deva->kobj.entry, &devb->kobj.entry);
-	spin_unlock(&devices_kset->list_lock);
-}
-
-/**
- * devices_kset_move_last - move the device to the end of devices_kset's list.
- * @dev: device to move
- */
-void devices_kset_move_last(struct device *dev)
-{
-	if (!devices_kset)
-		return;
-	pr_debug("devices_kset: Moving %s to end of list\n", dev_name(dev));
-	spin_lock(&devices_kset->list_lock);
-	list_move_tail(&dev->kobj.entry, &devices_kset->list);
-	spin_unlock(&devices_kset->list_lock);
-}
-
-/**
  * device_create_file - create sysfs attribute file for device.
  * @dev: device.
  * @attr: device attribute descriptor.
@@ -2776,15 +2730,12 @@ int device_move(struct device *dev, struct device *new_parent,
 		break;
 	case DPM_ORDER_DEV_AFTER_PARENT:
 		device_pm_move_after(dev, new_parent);
-		devices_kset_move_after(dev, new_parent);
 		break;
 	case DPM_ORDER_PARENT_BEFORE_DEV:
 		device_pm_move_before(new_parent, dev);
-		devices_kset_move_before(new_parent, dev);
 		break;
 	case DPM_ORDER_DEV_LAST:
 		device_pm_move_last(dev);
-		devices_kset_move_last(dev);
 		break;
 	}
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d72..6ebcd65 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -434,14 +434,6 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			goto probe_failed;
 	}
 
-	/*
-	 * Ensure devices are listed in devices_kset in correct order
-	 * It's important to move Dev to the end of devices_kset before
-	 * calling .probe, because it could be recursive and parent Dev
-	 * should always go first
-	 */
-	devices_kset_move_last(dev);
-
 	if (dev->bus->probe) {
 		ret = dev->bus->probe(dev);
 		if (ret)
-- 
2.7.4
