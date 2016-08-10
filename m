Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8C8N4r5kzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 10:44:20 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7A0hOwC052015
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 20:44:18 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9ruyfj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 20:44:18 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 21:44:16 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 3FA06352006C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 20:43:53 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7A0iD5D16253350
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 21:44:13 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7A0iCND006387
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 21:44:13 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] powerpc: update pci_controller.refcount for PCI
 devices and buses
Date: Tue,  9 Aug 2016 21:44:04 -0300
In-Reply-To: <1470789844-16401-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1470789844-16401-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1470789844-16401-3-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch employs the refcount in struct pci_controller to track
the references from PCI devices and buses (struct pci_dev/pci_bus).

In order to do that without modifying any PCI scan/probe approach
(e.g., PCI_PROBE_DEVTREE and PCI_PROBE_NORMAL), it leverages some
of the PCI arch-specific callback: pci_(add|release)_device() and
pci_(add|remove)_bus().

(a small change is required for PCI_PROBE_DEVTREE, which makes it
consistent with PCI_PROBE_NORMAL - the pci_dev should inherit the
parent pci_bus's phb pointer - see pci_setup_device() in probe.c)

This also has the advantage that locking for kref_(get|put)() is
satisfied by the 'pci_rescan_remove_lock' mutex, which is normal
practice for usage of the PCI subsystem - thus already in place.
More details added in comment on pcibios_release_device().

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h |  4 ++--
 arch/powerpc/kernel/pci-common.c      | 25 +++++++++++++++++++++++++
 arch/powerpc/kernel/pci-hotplug.c     | 29 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_of_scan.c     |  1 +
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 6fde0a9..d10eee3 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -131,8 +131,8 @@ struct pci_controller {
 
 	/*
 	 * Reference counting for the structures:
-	 * - TODO pci_dev
-	 * - TODO pci_bus
+	 * - pci_dev
+	 * - pci_bus
 	 * - TODO pci_dn
 	 * - TODO eeh_pe
 	 * - TODO eeh_dev
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 29b37d3..c55e9c0 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1047,6 +1047,17 @@ static void pcibios_setup_device(struct pci_dev *dev)
 
 int pcibios_add_device(struct pci_dev *dev)
 {
+	struct pci_controller *phb = pci_bus_to_host(dev->bus);
+
+	pr_debug("PCI %s, pci_dev %p, phb %p\n", dev_name(&dev->dev), dev, phb);
+
+	if (!phb)
+		pr_warn("%s: PCI device %s has null PHB; refcount bug!",
+			__func__, dev_name(&dev->dev)); /* WARN_ON ahead */
+
+	/* locking: see comment on pcibios_release_device(). */
+	controller_get(phb);
+
 	/*
 	 * We can only call pcibios_setup_device() after bus setup is complete,
 	 * since some of the platform specific DMA setup code depends on it.
@@ -1062,6 +1073,20 @@ int pcibios_add_device(struct pci_dev *dev)
 	return 0;
 }
 
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	struct pci_controller *phb = pci_bus_to_host(bus);
+
+	pr_debug("PCI %s, pci_bus %p, phb %p\n", dev_name(&bus->dev), bus, phb);
+
+	if (!phb)
+		pr_warn("%s: PCI bus %s has null PHB; refcount bug!",
+			__func__, dev_name(&bus->dev)); /* WARN_ON ahead */
+
+	/* locking: see comment on pcibios_release_device(). */
+	controller_get(phb);
+}
+
 void pcibios_setup_bus_devices(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 2d71269..24d1a2a 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -55,15 +55,44 @@ EXPORT_SYMBOL_GPL(pci_find_bus_by_node);
  * @dev: PCI device
  *
  * The function is called before releasing the indicated PCI device.
+ *
+ * The locking for kref_get() and kref_put() of the PHB/pci_controller
+ * in pcibios_(add|release)_device() and pcibios_(add|remove)_bus() is
+ * satisfied by the pci_rescan_remove_lock mutex (required for rescan/
+ * remove paths of PCI devices/buses; the scan path doesn't require it,
+ * as there is only addition of devices/buses - no removal at all.)
  */
 void pcibios_release_device(struct pci_dev *dev)
 {
 	struct pci_controller *phb = pci_bus_to_host(dev->bus);
 
+	pr_debug("PCI %s, pci_dev %p, phb %p\n", dev_name(&dev->dev), dev, phb);
+
 	eeh_remove_device(dev);
 
 	if (phb->controller_ops.release_device)
 		phb->controller_ops.release_device(dev);
+
+	if (unlikely(!phb))
+		pr_warn("%s: PCI device %s has null PHB; refcount bug!",
+			__func__, dev_name(&dev->dev)); /* WARN_ON ahead */
+
+	/* locking: see comment on pcibios_release_device(). */
+	controller_put(phb);
+}
+
+void pcibios_remove_bus(struct pci_bus *bus)
+{
+	struct pci_controller *phb = pci_bus_to_host(bus);
+
+	pr_debug("PCI %s, pci_bus %p, phb %p\n", dev_name(&bus->dev), bus, phb);
+
+	if (unlikely(!phb))
+		pr_warn("%s: PCI bus %s has null PHB; refcount bug!",
+			__func__, dev_name(&bus->dev)); /* WARN_ON ahead */
+
+	/* locking: see comment on pcibios_release_device(). */
+	controller_put(phb);
 }
 
 /**
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 526ac67..e6f0deb 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -142,6 +142,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 	dev->devfn = devfn;
 	dev->multifunction = 0;		/* maybe a lie? */
 	dev->needs_freset = 0;		/* pcie fundamental reset required */
+	dev->sysdata = bus->sysdata;	/* inherit bus's phb for phb->refcount */
 	set_pcie_port_type(dev);
 
 	pci_dev_assign_slot(dev);
-- 
1.8.3.1
