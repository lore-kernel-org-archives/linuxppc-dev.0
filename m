Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BD641A1CB5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:16 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DAF912BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764D6Zf41222208
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:14 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764Cb2A001287
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:12:42 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 30/42] powerpc/pci: Move pcibios_find_pci_bus() around
Date: Thu,  6 Aug 2015 14:11:35 +1000
Message-Id: <1438834307-26960-31-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves pcibios_find_pci_bus() to PowerPC kernel directory
so that it can be reused by hotplug code for pSeries and PowerNV
platform at the same time. Also, the function is renamed to
of_node_to_pci_bus().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/pci-bridge.h      |  2 +-
 arch/powerpc/kernel/pci-hotplug.c          | 30 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pci_dlpar.c | 32 ------------------------------
 drivers/pci/hotplug/rpadlpar_core.c        |  6 +++---
 drivers/pci/hotplug/rpaphp_pci.c           |  2 +-
 5 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 65357a9..84dee1e 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -259,7 +259,7 @@ static inline struct eeh_dev *pdn_to_eeh_dev(struct pci_dn *pdn)
 #endif
 
 /** Find the bus corresponding to the indicated device node */
-extern struct pci_bus *pcibios_find_pci_bus(struct device_node *dn);
+extern struct pci_bus *of_node_to_pci_bus(struct device_node *dn);
 
 /** Remove all of the PCI devices under this bus */
 extern void pcibios_remove_pci_devices(struct pci_bus *bus);
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index c307d9a..692beca 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -21,6 +21,36 @@
 #include <asm/firmware.h>
 #include <asm/eeh.h>
 
+static struct pci_bus *find_pci_bus(struct pci_bus *bus,
+				    struct device_node *dn)
+{
+	struct pci_bus *tmp, *child = NULL;
+	struct device_node *busdn;
+
+	busdn = pci_bus_to_OF_node(bus);
+	if (busdn == dn)
+		return bus;
+
+	list_for_each_entry(tmp, &bus->children, node) {
+		child = find_pci_bus(tmp, dn);
+		if (child)
+			break;
+	}
+
+	return child;
+}
+
+struct pci_bus *of_node_to_pci_bus(struct device_node *dn)
+{
+	struct pci_dn *pdn = dn->data;
+
+	if (!pdn  || !pdn->phb || !pdn->phb->bus)
+		return NULL;
+
+	return find_pci_bus(pdn->phb->bus, dn);
+}
+EXPORT_SYMBOL_GPL(of_node_to_pci_bus);
+
 /**
  * pcibios_release_device - release PCI device
  * @dev: PCI device
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 5d4a3df..906dbaa 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -34,38 +34,6 @@
 
 #include "pseries.h"
 
-static struct pci_bus *
-find_bus_among_children(struct pci_bus *bus,
-                        struct device_node *dn)
-{
-	struct pci_bus *child = NULL;
-	struct pci_bus *tmp;
-	struct device_node *busdn;
-
-	busdn = pci_bus_to_OF_node(bus);
-	if (busdn == dn)
-		return bus;
-
-	list_for_each_entry(tmp, &bus->children, node) {
-		child = find_bus_among_children(tmp, dn);
-		if (child)
-			break;
-	};
-	return child;
-}
-
-struct pci_bus *
-pcibios_find_pci_bus(struct device_node *dn)
-{
-	struct pci_dn *pdn = dn->data;
-
-	if (!pdn  || !pdn->phb || !pdn->phb->bus)
-		return NULL;
-
-	return find_bus_among_children(pdn->phb->bus, dn);
-}
-EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
-
 struct pci_controller *init_phb_dynamic(struct device_node *dn)
 {
 	struct pci_controller *phb;
diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index e12bafd..f57a293 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -176,7 +176,7 @@ static int dlpar_add_pci_slot(char *drc_name, struct device_node *dn)
 	struct pci_dev *dev;
 	struct pci_controller *phb;
 
-	if (pcibios_find_pci_bus(dn))
+	if (of_node_to_pci_bus(dn))
 		return -EINVAL;
 
 	/* Add pci bus */
@@ -213,7 +213,7 @@ static int dlpar_remove_phb(char *drc_name, struct device_node *dn)
 	struct pci_dn *pdn;
 	int rc = 0;
 
-	if (!pcibios_find_pci_bus(dn))
+	if (!of_node_to_pci_bus(dn))
 		return -EINVAL;
 
 	/* If pci slot is hotpluggable, use hotplug to remove it */
@@ -357,7 +357,7 @@ int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
 
 	pci_lock_rescan_remove();
 
-	bus = pcibios_find_pci_bus(dn);
+	bus = of_node_to_pci_bus(dn);
 	if (!bus) {
 		ret = -EINVAL;
 		goto out;
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index 9243f3e7..293bd86 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -93,7 +93,7 @@ int rpaphp_enable_slot(struct slot *slot)
 	if (rc)
 		return rc;
 
-	bus = pcibios_find_pci_bus(slot->dn);
+	bus = of_node_to_pci_bus(slot->dn);
 	if (!bus) {
 		err("%s: no pci_bus for dn %s\n", __func__, slot->dn->full_name);
 		return -EINVAL;
-- 
2.1.0
