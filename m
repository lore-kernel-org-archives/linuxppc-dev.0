Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 931C82C029A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:17:39 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 09:17:36 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 10BCE6E8021
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 09:17:26 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EHR7G28442802
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:27 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EHRNP007180
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 11:17:27 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/22] powerpc/eeh: Function to tranverse PCI devices
Date: Fri,  1 Mar 2013 22:17:00 +0800
Message-Id: <1362147440-14096-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For EEH on PowerNV platform, the PCI devices will be probed to
check if they support EEH functionality. Different from the case
of EEH for pSeries platform, we will probe real PCI device instead
of device tree node for EEH capability on PowerNV platform.

The patch introduces function eeh_pci_dev_traverse() to traverse
PCI devices for the indicated PCI bus from top to bottom.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h           |    3 ++
 arch/powerpc/platforms/pseries/eeh_dev.c |   35 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index e32c3c5..eeaeab6 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -183,6 +183,7 @@ static inline void eeh_unlock(void)
 #define EEH_MAX_ALLOWED_FREEZES 5
 
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
+typedef void *(*eeh_pci_traverse_func)(struct pci_dev *dev, void *flag);
 int eeh_phb_pe_create(struct pci_controller *phb);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe);
@@ -191,6 +192,8 @@ void *eeh_pe_dev_traverse(struct eeh_pe *root,
 void eeh_pe_restore_bars(struct eeh_pe *pe);
 struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
+void eeh_pci_dev_traverse(struct pci_bus *bus,
+		eeh_pci_traverse_func fn, void *flag);
 void *eeh_dev_init(struct device_node *dn, void *data);
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
 int __init eeh_ops_register(struct eeh_ops *ops);
diff --git a/arch/powerpc/platforms/pseries/eeh_dev.c b/arch/powerpc/platforms/pseries/eeh_dev.c
index 1efa28f..12c445d 100644
--- a/arch/powerpc/platforms/pseries/eeh_dev.c
+++ b/arch/powerpc/platforms/pseries/eeh_dev.c
@@ -41,6 +41,41 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
 
+
+/**
+ * eeh_pci_dev_traverse - Traverse PCI devices for the indicated bus
+ * @bus: PCI bus
+ * @fn: callback function
+ * @flag: extra flag
+ *
+ * The function traverses the PCI devices for the indicated PCI bus
+ * from top to bottom fashion until the supplied callback function
+ * returns non-zero value on the specific PCI device.
+ */
+void eeh_pci_dev_traverse(struct pci_bus *bus,
+		eeh_pci_traverse_func fn, void *flag)
+{
+	struct pci_dev *dev;
+	void *ret;
+
+	if (!bus)
+		return;
+
+	/*
+	 * We should make sure the parent devices are scanned
+	 * prior to the child devices so that the parent PE
+	 * could be created before the child PEs.
+	 */
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		ret = fn(dev, flag);
+		if (ret)
+			return;
+
+		if (dev->subordinate)
+			eeh_pci_dev_traverse(dev->subordinate, fn, flag);
+	}
+}
+
 /**
  * eeh_dev_init - Create EEH device according to OF node
  * @dn: device node
-- 
1.7.5.4
