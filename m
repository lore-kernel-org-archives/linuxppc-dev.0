Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D0E3D2C0087
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2012 00:34:41 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 17 Sep 2012 10:34:35 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8HEYVFj138326
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2012 10:34:31 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8HEYU5r006580
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2012 11:34:31 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] ppc/eeh: lock module while handling EEH event
Date: Mon, 17 Sep 2012 22:34:27 +0800
Message-Id: <1347892468-25818-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The EEH core is talking with the PCI device driver to determine the
action (purely reset, or PCI device removal). During the period, the
driver might be unloaded and in turn causes kernel crash as follows:

EEH: Detected PCI bus error on PHB#4-PE#10000
EEH: This PCI device has failed 3 times in the last hour
lpfc 0004:01:00.0: 0:2710 PCI channel disable preparing for reset
Unable to handle kernel paging request for data at address 0x00000490
Faulting instruction address: 0xd00000000e682c90
cpu 0x1: Vector: 300 (Data Access) at [c000000fc75ffa20]
    pc: d00000000e682c90: .lpfc_io_error_detected+0x30/0x240 [lpfc]
    lr: d00000000e682c8c: .lpfc_io_error_detected+0x2c/0x240 [lpfc]
    sp: c000000fc75ffca0
   msr: 8000000000009032
   dar: 490
 dsisr: 40000000
  current = 0xc000000fc79b88b0
  paca    = 0xc00000000edb0380	 softe: 0	 irq_happened: 0x00
    pid   = 3386, comm = eehd
enter ? for help
[c000000fc75ffca0] c000000fc75ffd30 (unreliable)
[c000000fc75ffd30] c00000000004fd3c .eeh_report_error+0x7c/0xf0
[c000000fc75ffdc0] c00000000004ee00 .eeh_pe_dev_traverse+0xa0/0x180
[c000000fc75ffe70] c00000000004ffd8 .eeh_handle_event+0x68/0x300
[c000000fc75fff00] c0000000000503a0 .eeh_event_handler+0x130/0x1a0
[c000000fc75fff90] c000000000020138 .kernel_thread+0x54/0x70
1:mon>

The patch increases the reference of the corresponding driver modules
while EEH core does the negotiation with PCI device driver so that the
corresponding driver modules can't be unloaded during the period and
we're safe to refer the callbacks. 

Cc: stable@vger.kernel.org
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_driver.c |   91 ++++++++++++++++++++------
 1 files changed, 70 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 37c2cf7..a3fefb6 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 #include <asm/eeh.h>
 #include <asm/eeh_event.h>
@@ -47,6 +48,41 @@ static inline const char *eeh_pcid_name(struct pci_dev *pdev)
 	return "";
 }
 
+/**
+ * eeh_pcid_get - Get the PCI device driver
+ * @pdev: PCI device
+ *
+ * The function is used to retrieve the PCI device driver for
+ * the indicated PCI device. Besides, we will increase the reference
+ * of the PCI device driver to prevent that being unloaded on
+ * the fly. Otherwise, kernel crash would be seen.
+ */
+static inline struct pci_driver *eeh_pcid_get(struct pci_dev *pdev)
+{
+	if (!pdev || !pdev->driver)
+		return NULL;
+
+	if (!try_module_get(pdev->driver->driver.owner))
+		return NULL;
+
+	return pdev->driver;
+}
+
+/**
+ * eeh_pcid_put - Dereference on the PCI device driver
+ * @pdev: PCI device
+ *
+ * The function is called to do dereference on the PCI device
+ * driver of the indicated PCI device.
+ */
+static inline void eeh_pcid_put(struct pci_dev *pdev)
+{
+	if (!pdev || !pdev->driver)
+		return;
+
+	module_put(pdev->driver->driver.owner);
+}
+
 #if 0
 static void print_device_node_tree(struct pci_dn *pdn, int dent)
 {
@@ -128,23 +164,24 @@ static void *eeh_report_error(void *data, void *userdata)
 	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	enum pci_ers_result rc, *res = userdata;
-	struct pci_driver *driver = dev->driver;
+	struct pci_driver *driver;
 
 	/* We might not have the associated PCI device,
 	 * then we should continue for next one.
 	 */
 	if (!dev) return NULL;
-
 	dev->error_state = pci_channel_io_frozen;
 
-	if (!driver)
-		return NULL;
+	driver = eeh_pcid_get(dev);
+	if (!driver) return NULL;
 
 	eeh_disable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected)
+	    !driver->err_handler->error_detected) {
+		eeh_pcid_put(dev);
 		return NULL;
+	}
 
 	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
 
@@ -152,6 +189,7 @@ static void *eeh_report_error(void *data, void *userdata)
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
+	eeh_pcid_put(dev);
 	return NULL;
 }
 
@@ -171,12 +209,14 @@ static void *eeh_report_mmio_enabled(void *data, void *userdata)
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
 
-	if (!dev) return NULL;
+	driver = eeh_pcid_get(dev);
+	if (!driver) return NULL;
 
-	if (!(driver = dev->driver) ||
-	    !driver->err_handler ||
-	    !driver->err_handler->mmio_enabled)
+	if (!driver->err_handler ||
+	    !driver->err_handler->mmio_enabled) {
+		eeh_pcid_put(dev);
 		return NULL;
+	}
 
 	rc = driver->err_handler->mmio_enabled(dev);
 
@@ -184,6 +224,7 @@ static void *eeh_report_mmio_enabled(void *data, void *userdata)
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
+	eeh_pcid_put(dev);
 	return NULL;
 }
 
@@ -204,16 +245,19 @@ static void *eeh_report_reset(void *data, void *userdata)
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
 
-	if (!dev || !(driver = dev->driver))
-		return NULL;
-
+	if (!dev) return NULL;
 	dev->error_state = pci_channel_io_normal;
 
+	driver = eeh_pcid_get(dev);
+	if (!driver) return NULL;
+
 	eeh_enable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->slot_reset)
+	    !driver->err_handler->slot_reset) {
+		eeh_pcid_put(dev);
 		return NULL;
+	}
 
 	rc = driver->err_handler->slot_reset(dev);
 	if ((*res == PCI_ERS_RESULT_NONE) ||
@@ -221,6 +265,7 @@ static void *eeh_report_reset(void *data, void *userdata)
 	if (*res == PCI_ERS_RESULT_DISCONNECT &&
 	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 
+	eeh_pcid_put(dev);
 	return NULL;
 }
 
@@ -240,20 +285,22 @@ static void *eeh_report_resume(void *data, void *userdata)
 	struct pci_driver *driver;
 
 	if (!dev) return NULL;
-
 	dev->error_state = pci_channel_io_normal;
 
-	if (!(driver = dev->driver))
-		return NULL;
+	driver = eeh_pcid_get(dev);
+	if (!driver) return NULL;
 
 	eeh_enable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->resume)
+	    !driver->err_handler->resume) {
+		eeh_pcid_put(dev);
 		return NULL;
+	}
 
 	driver->err_handler->resume(dev);
 
+	eeh_pcid_put(dev);
 	return NULL;
 }
 
@@ -272,20 +319,22 @@ static void *eeh_report_failure(void *data, void *userdata)
 	struct pci_driver *driver;
 
 	if (!dev) return NULL;
-
 	dev->error_state = pci_channel_io_perm_failure;
 
-	if (!(driver = dev->driver))
-		return NULL;
+	driver = eeh_pcid_get(dev);
+	if (!driver) return NULL;
 
 	eeh_disable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected)
+	    !driver->err_handler->error_detected) {
+		eeh_pcid_put(dev);
 		return NULL;
+	}
 
 	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
 
+	eeh_pcid_put(dev);
 	return NULL;
 }
 
-- 
1.7.5.4
