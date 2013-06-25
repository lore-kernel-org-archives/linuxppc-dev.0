Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62FAD2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 15:55:32 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 01:55:29 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A627138C8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:55:25 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P5tQbP297386
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:55:26 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P5tPW3021298
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 23:55:25 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/10] powerpc/powernv: Block PCI-CFG access if necessary
Date: Tue, 25 Jun 2013 13:55:14 +0800
Message-Id: <1372139717-14885-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the PCI-CFG access on the specific PHB, to return 0xFF's for
reading and drop writing. The patch implements that for PowerNV
platform. The patch also removes the check on "hose == NULL"
for PCI-CFG accessors since the kernel should stop while fetching
platform-dependent PHB (struct pnv_phb).

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c |   10 ++---
 arch/powerpc/platforms/powernv/pci.c         |   59 ++++++++++++++++++++------
 arch/powerpc/platforms/powernv/pci.h         |    4 ++
 3 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 20a7865..249798e 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -328,9 +328,9 @@ static int powernv_eeh_read_config(struct device_node *dn, int where,
 {
 	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	struct pci_controller *hose = edev->phb;
 
-	return hose->ops->read(dev->bus, dev->devfn, where, size, val);
+	return pnv_pci_cfg_read(dev->bus, dev->devfn,
+				where, size, val, false);
 }
 
 /**
@@ -347,11 +347,9 @@ static int powernv_eeh_write_config(struct device_node *dn, int where,
 {
 	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	struct pci_controller *hose = edev->phb;
 
-	hose = pci_bus_to_host(dev->bus);
-
-	return hose->ops->write(dev->bus, dev->devfn, where, size, val);
+	return pnv_pci_cfg_write(dev->bus, dev->devfn,
+				 where, size, val, false);
 }
 
 /**
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 1f31826..47fa921 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -255,21 +255,30 @@ static void pnv_pci_config_check_eeh(struct pnv_phb *phb, struct pci_bus *bus,
 		pnv_pci_handle_eeh_config(phb, pe_no);
 }
 
-static int pnv_pci_read_config(struct pci_bus *bus,
-			       unsigned int devfn,
-			       int where, int size, u32 *val)
+int pnv_pci_cfg_read(struct pci_bus *bus,
+		     unsigned int devfn,
+		     int where, int size,
+		     u32 *val, bool check)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
+	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
+	s64 rc;
 #ifdef CONFIG_EEH
 	struct device_node *busdn, *dn;
 	struct eeh_pe *phb_pe = NULL;
-#endif
-	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
-	s64 rc;
 
-	if (hose == NULL)
+	/*
+	 * If PCI-CFG access has been blocked, we simply
+	 * return 0xFF's here.
+	 */
+	if (check &&
+	    (phb->eeh_state & PNV_EEH_STATE_ENABLED) &&
+	    (phb->eeh_state & PNV_EEH_STATE_CFG_BLOCKED)) {
+		*val = 0xFFFFFFFF;
 		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+#endif
 
 	switch (size) {
 	case 1: {
@@ -329,19 +338,26 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int pnv_pci_write_config(struct pci_bus *bus,
-				unsigned int devfn,
-				int where, int size, u32 val)
+int pnv_pci_cfg_write(struct pci_bus *bus,
+		      unsigned int devfn,
+		      int where, int size,
+		      u32 val, bool check)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
 	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
 
-	if (hose == NULL)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
 	cfg_dbg("pnv_pci_write_config bus: %x devfn: %x +%x/%x -> %08x\n",
 		bus->number, devfn, where, size, val);
+
+#ifdef CONFIG_EEH
+	/* If PCI-CFG access has been blocked, drop it */
+	if (check &&
+	    (phb->eeh_state & PNV_EEH_STATE_ENABLED) &&
+	    (phb->eeh_state & PNV_EEH_STATE_CFG_BLOCKED))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+#endif
+
 	switch (size) {
 	case 1:
 		opal_pci_config_write_byte(phb->opal_id, bdfn, where, val);
@@ -367,6 +383,23 @@ static int pnv_pci_write_config(struct pci_bus *bus,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static int pnv_pci_read_config(struct pci_bus *bus,
+			       unsigned int devfn,
+			       int where, int size, u32 *val)
+{
+	return pnv_pci_cfg_read(bus, devfn, where,
+				size, val, true);
+}
+
+static int pnv_pci_write_config(struct pci_bus *bus,
+				unsigned int devfn,
+				int where, int size,
+				u32 val)
+{
+	return pnv_pci_cfg_write(bus, devfn, where,
+				 size, val, true);
+}
+
 struct pci_ops pnv_pci_ops = {
 	.read = pnv_pci_read_config,
 	.write = pnv_pci_write_config,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index a281a1c..8624f8f 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -187,6 +187,10 @@ extern struct pci_ops pnv_pci_ops;
 extern struct pnv_eeh_ops ioda_eeh_ops;
 #endif
 
+extern int pnv_pci_cfg_read(struct pci_bus *bus, unsigned int devfn,
+			    int where, int size, u32 *val, bool check);
+extern int pnv_pci_cfg_write(struct pci_bus *bus, unsigned int devfn,
+			     int where, int size, u32 val, bool check);
 extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 				      void *tce_mem, u64 tce_size,
 				      u64 dma_offset);
-- 
1.7.5.4
