Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B0232C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2012 06:13:34 +1100 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Fri, 28 Dec 2012 17:13:28 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A7B341DC005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 14:13:25 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBSJD4fQ26017986
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 17:13:04 -0200
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBSJDPwq005026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 17:13:25 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] ppc/EEH: fix crash when adding a device in a slot with DDW
Date: Fri, 28 Dec 2012 17:13:19 -0200
Message-Id: <1356721999-25159-2-git-send-email-cascardo@linux.vnet.ibm.com>
In-Reply-To: <20121228120616.GB21831@oc0268524204.ibm.com>
References: <20121228120616.GB21831@oc0268524204.ibm.com>
Cc: shangw@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, paulus@samba.org,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 bhelgaas@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The DDW code uses a eeh_dev struct from the pci_dev. However, this is
not set until eeh_add_device_late is called.

Since pci_bus_add_devices is called before eeh_add_device_late, the PCI
devices are added to the bus, making drivers' probe hooks to be called.
These will call set_dma_mask, which will call the DDW code, which will
require the eeh_dev struct from pci_dev. This would result in a crash,
due to a NULL dereference.

Calling eeh_add_device_late after pci_bus_add_devices would make the
system BUG, because device files shouldn't be added to devices there
were not added to the system. So, a new function is needed to add such
files only after pci_bus_add_devices have been called.

Cc: stable@vger.kernel.org
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h       |    3 +++
 arch/powerpc/kernel/of_platform.c    |    3 +++
 arch/powerpc/kernel/pci-common.c     |    7 +++++--
 arch/powerpc/platforms/pseries/eeh.c |   24 +++++++++++++++++++++++-
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index b0ef738..0f816da 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -201,6 +201,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev);
 void __init eeh_addr_cache_build(void);
 void eeh_add_device_tree_early(struct device_node *);
 void eeh_add_device_tree_late(struct pci_bus *);
+void eeh_add_sysfs_files(struct pci_bus *);
 void eeh_remove_bus_device(struct pci_dev *, int);
 
 /**
@@ -240,6 +241,8 @@ static inline void eeh_add_device_tree_early(struct device_node *dn) { }
 
 static inline void eeh_add_device_tree_late(struct pci_bus *bus) { }
 
+static inline void eeh_add_sysfs_files(struct pci_bus *bus) { }
+
 static inline void eeh_remove_bus_device(struct pci_dev *dev, int purge_pe) { }
 
 static inline void eeh_lock(void) { }
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index c5fc6b2..500dd32 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -91,6 +91,9 @@ static int __devinit of_pci_phb_probe(struct platform_device *dev)
 	/* Add probed PCI devices to the device model */
 	pci_bus_add_devices(phb->bus);
 
+	/* sysfs files should only be added after devices are added */
+	eeh_add_sysfs_files(phb->bus);
+
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7f94f76..4d3de7e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1480,11 +1480,14 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
 	pcibios_allocate_bus_resources(bus);
 	pcibios_claim_one_bus(bus);
 
+	/* Fixup EEH */
+	eeh_add_device_tree_late(bus);
+
 	/* Add new devices to global lists.  Register in proc, sysfs. */
 	pci_bus_add_devices(bus);
 
-	/* Fixup EEH */
-	eeh_add_device_tree_late(bus);
+	/* sysfs files should only be added after devices are added */
+	eeh_add_sysfs_files(bus);
 }
 EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
 
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 9a04322..6b73d6c 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -788,7 +788,6 @@ static void eeh_add_device_late(struct pci_dev *dev)
 	dev->dev.archdata.edev = edev;
 
 	eeh_addr_cache_insert_dev(dev);
-	eeh_sysfs_add_device(dev);
 }
 
 /**
@@ -815,6 +814,29 @@ void eeh_add_device_tree_late(struct pci_bus *bus)
 EXPORT_SYMBOL_GPL(eeh_add_device_tree_late);
 
 /**
+ * eeh_add_sysfs_files - Add EEH sysfs files for the indicated PCI bus
+ * @bus: PCI bus
+ *
+ * This routine must be used to add EEH sysfs files for PCI
+ * devices which are attached to the indicated PCI bus. The PCI bus
+ * is added after system boot through hotplug or dlpar.
+ */
+void eeh_add_sysfs_files(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		eeh_sysfs_add_device(dev);
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+			struct pci_bus *subbus = dev->subordinate;
+			if (subbus)
+				eeh_add_sysfs_files(subbus);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(eeh_add_sysfs_files);
+
+/**
  * eeh_remove_device - Undo EEH setup for the indicated pci device
  * @dev: pci device to be removed
  * @purge_pe: remove the PE or not
-- 
1.7.1
