Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406stP1lBGzDqm3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 16:44:29 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, ruscur@russell.cc,
 sam.bobroff@au1.ibm.com, Michael Neuling <mikey@neuling.org>
Subject: [PATCH] powerpc/eeh: Fix race with driver un/bind
Date: Fri, 23 Mar 2018 16:44:17 +1100
Message-Id: <20180323054417.3268-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current EEH callbacks can race with a driver unbind. This
can result in a backtraces like this:

[    7.573055] EEH: Frozen PHB#0-PE#1fc detected
[    7.573063] EEH: PE location: S000009, PHB location: N/A
[    7.573069] CPU: 2 PID: 2312 Comm: kworker/u258:3 Not tainted 4.15.6-openpower1 #2
[    7.573078] Workqueue: nvme-wq nvme_reset_work [nvme]
[    7.573080] Call Trace:
[    7.573088] [c000000ff12a3a30] [c0000000005f5000] dump_stack+0x9c/0xd0
[    7.573093]  (unreliable)
[    7.573106] [c000000ff12a3a70] [c00000000002385c] eeh_dev_check_failure+0x420/0x470
[    7.573111] [c000000ff12a3b10] [c00000000002394c] eeh_check_failure+0xa0/0xa4
[    7.573115] [c000000ff12a3b50] [c0080000088c2ff0] nvme_reset_work+0x138/0x1414 [nvme]
[    7.573122] [c000000ff12a3cb0] [c000000000089c78] process_one_work+0x1ec/0x328
[    7.573132] [c000000ff12a3d40] [c00000000008a3b4] worker_thread+0x2e4/0x3a8
[    7.573140] [c000000ff12a3dc0] [c00000000008fed0] kthread+0x14c/0x154
[    7.573150] [c000000ff12a3e30] [c00000000000b594] ret_from_kernel_thread+0x5c/0xc8
[    7.573183] nvme nvme1: Removing after probe failure status: -19
<snip>
cpu 0x23: Vector: 300 (Data Access) at [c000000ff50f3800]
    pc: c0080000089a0eb0: nvme_error_detected+0x4c/0x90 [nvme]
    lr: c000000000026564: eeh_report_error+0xe0/0x110
    sp: c000000ff50f3a80
   msr: 9000000000009033
   dar: 400
 dsisr: 40000000
  current = 0xc000000ff507c000
  paca    = 0xc00000000fdc9d80   softe: 0        irq_happened: 0x01
    pid   = 782, comm = eehd
Linux version 4.15.6-openpower1 (smc@smc-desktop) (gcc version 6.4.0 (Buildroot 2017.11.2-00008-g4b6188e)) #2 SM                                             P Tue Feb 27 12:33:27 PST 2018
enter ? for help
[c000000ff50f3af0] c000000000026564 eeh_report_error+0xe0/0x110
[c000000ff50f3b30] c000000000025520 eeh_pe_dev_traverse+0xc0/0xdc
[c000000ff50f3bc0] c000000000026bd0 eeh_handle_normal_event+0x184/0x4c4
[c000000ff50f3c70] c000000000026ff4 eeh_handle_event+0x30/0x288
[c000000ff50f3d10] c00000000002758c eeh_event_handler+0x124/0x170
[c000000ff50f3dc0] c00000000008fed0 kthread+0x14c/0x154
[c000000ff50f3e30] c00000000000b594 ret_from_kernel_thread+0x5c/0xc8

The first part is an EEH (on boot), the second half is the resulting
crash. nvme probe starts the nvme_reset_work() worker thread. This
worker thread starts touching the device which see a device error
(EEH) and hence queues up an event in the powerpc EEH worker
thread. nvme_reset_work() then continues and runs
nvme_remove_dead_ctrl_work() which results in unbinding the driver
from the device and hence releases all resources. At the same time,
the EEH worker thread starts doing the EEH .error_detected() driver
callback, which no longer works since the resources have been freed.

This fixes the problem in the same way the generic PCIe AER code (in
drivers/pci/pcie/aer/aerdrv_core.c) does. It makes the EEH code hold
the device_lock() before performing the driver EEH callbacks. This
ensures either the callbacks are no longer register, or if they are
registered the driver will not be removed from underneath us.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/eeh_driver.c | 67 ++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 0c0b66fc5b..7cf946ae9a 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -207,18 +207,18 @@ static void *eeh_report_error(void *data, void *userdata)
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_frozen;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out2;
 
 	eeh_disable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    !driver->err_handler->error_detected)
+		goto out1;
 
 	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
 
@@ -227,8 +227,11 @@ static void *eeh_report_error(void *data, void *userdata)
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
 	edev->in_error = true;
-	eeh_pcid_put(dev);
 	pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
+out1:
+	eeh_pcid_put(dev);
+out2:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -251,15 +254,14 @@ static void *eeh_report_mmio_enabled(void *data, void *userdata)
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
 
+	device_lock(&dev->dev);
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out2;
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->mmio_enabled ||
-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    (edev->mode & EEH_DEV_NO_HANDLER))
+		goto out1;
 
 	rc = driver->err_handler->mmio_enabled(dev);
 
@@ -267,7 +269,10 @@ static void *eeh_report_mmio_enabled(void *data, void *userdata)
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
+out1:
 	eeh_pcid_put(dev);
+out2:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -290,20 +295,20 @@ static void *eeh_report_reset(void *data, void *userdata)
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_normal;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out2;
 
 	eeh_enable_irq(dev);
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->slot_reset ||
 	    (edev->mode & EEH_DEV_NO_HANDLER) ||
-	    (!edev->in_error)) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    (!edev->in_error))
+		goto out1;
 
 	rc = driver->err_handler->slot_reset(dev);
 	if ((*res == PCI_ERS_RESULT_NONE) ||
@@ -311,7 +316,10 @@ static void *eeh_report_reset(void *data, void *userdata)
 	if (*res == PCI_ERS_RESULT_DISCONNECT &&
 	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 
+out1:
 	eeh_pcid_put(dev);
+out2:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -362,10 +370,12 @@ static void *eeh_report_resume(void *data, void *userdata)
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_normal;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out2;
 
 	was_in_error = edev->in_error;
 	edev->in_error = false;
@@ -375,18 +385,20 @@ static void *eeh_report_resume(void *data, void *userdata)
 	    !driver->err_handler->resume ||
 	    (edev->mode & EEH_DEV_NO_HANDLER) || !was_in_error) {
 		edev->mode &= ~EEH_DEV_NO_HANDLER;
-		eeh_pcid_put(dev);
-		return NULL;
+		goto out1;
 	}
 
 	driver->err_handler->resume(dev);
 
-	eeh_pcid_put(dev);
 	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
+out1:
+	eeh_pcid_put(dev);
 #ifdef CONFIG_PCI_IOV
 	if (eeh_ops->notify_resume && eeh_dev_to_pdn(edev))
 		eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
 #endif
+out2:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -406,23 +418,26 @@ static void *eeh_report_failure(void *data, void *userdata)
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_perm_failure;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out2;
 
 	eeh_disable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    !driver->err_handler->error_detected)
+		goto out1;
 
 	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
 
-	eeh_pcid_put(dev);
 	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
+out1:
+	eeh_pcid_put(dev);
+out2:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
-- 
2.14.1
