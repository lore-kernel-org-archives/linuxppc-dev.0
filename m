Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A48441A0BF9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:56:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 13 Feb 2015 14:56:02 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F1CC7357804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:55:59 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1D4tpTI25297030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:55:59 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1D4tPpj027607
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:55:26 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 2/4] PCI: Introduce list for device reset methods
Date: Fri, 13 Feb 2015 15:54:57 +1100
Message-Id: <1423803299-22356-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
 cascardo@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces list to hold the PCI device specific reset
methods. With help of the list, we can register PCI device specific
reset method dynamically as we do in next one patch.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/pci.h    |  1 +
 drivers/pci/quirks.c | 75 +++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e67b22f..82e648a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -310,6 +310,7 @@ struct pci_dev_reset_method {
 	u16 vendor;
 	u16 device;
 	int (*reset)(struct pci_dev *dev, int probe);
+	struct list_head node;
 };
 
 #ifdef CONFIG_PCI_QUIRKS
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 512bbbb..37f4c5d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3508,20 +3508,44 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 #define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
 #define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
 
-static const struct pci_dev_reset_method pci_dev_reset_methods[] = {
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
-		 reset_intel_82599_sfp_virtfn },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M_VGA,
-		reset_ivb_igd },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
-		reset_ivb_igd },
-	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
-		reset_intel_generic_dev },
-	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
-		reset_chelsio_generic_dev },
-	{ 0 }
+static LIST_HEAD(pci_dev_reset_list);
+static DEFINE_MUTEX(pci_dev_reset_mutex);
+static bool pci_dev_reset_populated = false;
+static struct pci_dev_reset_method pci_dev_reset_methods[] = {
+	{ .vendor = PCI_VENDOR_ID_INTEL,
+	  .device = PCI_DEVICE_ID_INTEL_82599_SFP_VF,
+	  .reset  = reset_intel_82599_sfp_virtfn
+	},
+	{ .vendor = PCI_VENDOR_ID_INTEL,
+	  .device = PCI_DEVICE_ID_INTEL_IVB_M_VGA,
+	  .reset  = reset_ivb_igd
+	},
+	{ .vendor = PCI_VENDOR_ID_INTEL,
+	  .device = PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
+	  .reset  =reset_ivb_igd
+	},
+	{ .vendor = PCI_VENDOR_ID_INTEL,
+	  .device = PCI_ANY_ID,
+	  .reset  = reset_intel_generic_dev
+	},
+	{ .vendor = PCI_VENDOR_ID_CHELSIO,
+	  .device = PCI_ANY_ID,
+	  .reset  = reset_chelsio_generic_dev
+	}
 };
 
+static void pci_dev_populate_reset(void)
+{
+	struct pci_dev_reset_method *m;
+	int i;
+
+	for (i = ARRAY_SIZE(pci_dev_reset_methods) - 1; i >= 0; i--) {
+		m = &pci_dev_reset_methods[i];
+		INIT_LIST_HEAD(&m->node);
+		list_add(&m->node, &pci_dev_reset_list);
+	}
+}
+
 /*
  * These device-specific reset methods are here rather than in a driver
  * because when a host assigns a device to a guest VM, the host may need
@@ -3529,16 +3553,29 @@ static const struct pci_dev_reset_method pci_dev_reset_methods[] = {
  */
 int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 {
-	const struct pci_dev_reset_method *i;
+	struct pci_dev_reset_method *m;
+	int ret;
 
-	for (i = pci_dev_reset_methods; i->reset; i++) {
-		if ((i->vendor == dev->vendor ||
-		     i->vendor == (u16)PCI_ANY_ID) &&
-		    (i->device == dev->device ||
-		     i->device == (u16)PCI_ANY_ID))
-			return i->reset(dev, probe);
+	mutex_lock(&pci_dev_reset_mutex);
+
+	if (!pci_dev_reset_populated) {
+		pci_dev_populate_reset();
+		pci_dev_reset_populated = true;
 	}
 
+	list_for_each_entry(m, &pci_dev_reset_list, node) {
+		if ((m->vendor == dev->vendor ||
+		     m->vendor == (u16)PCI_ANY_ID) &&
+		    (m->device == dev->device ||
+		     m->device == (u16)PCI_ANY_ID)) {
+			ret = m->reset(dev, probe);
+			mutex_unlock(&pci_dev_reset_mutex);
+			return ret;
+		}
+	}
+
+	mutex_unlock(&pci_dev_reset_mutex);
+
 	return -ENOTTY;
 }
 
-- 
1.8.3.2
