Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC4641A0C2A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 16:54:56 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 11:24:54 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9DEF2125804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 11:25:10 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB45t4lR56164472
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 11:25:04 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB45spk3004666
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 11:24:51 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 1/5] powerpc/pci: Move pcibios_find_pci_bus() around
Date: Thu,  4 Dec 2014 16:54:44 +1100
Message-Id: <1417672488-27341-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1417672488-27341-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1417672488-27341-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch moves pcibios_find_pci_bus() to PPC kerenl directory so
that it can be reused by hotplug code for pSeries and PowerNV
platform at the same time.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/pci-hotplug.c          | 36 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pci_dlpar.c | 32 --------------------------
 2 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 5b78917..6e2b4e3 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -21,6 +21,42 @@
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
+/**
+ * pcibios_find_pci_bus - find PCI bus according to the given device node
+ * @dn: Device node
+ *
+ * Find the corresponding PCI bus according to the given device node.
+ */
+struct pci_bus *pcibios_find_pci_bus(struct device_node *dn)
+{
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	if (!pdn  || !pdn->phb || !pdn->phb->bus)
+		return NULL;
+
+	return find_pci_bus(pdn->phb->bus, dn);
+}
+EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
+
 /**
  * pcibios_release_device - release PCI device
  * @dev: PCI device
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 89e2381..98c50bc 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -32,38 +32,6 @@
 #include <asm/firmware.h>
 #include <asm/eeh.h>
 
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
-- 
1.8.3.2
