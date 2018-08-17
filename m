Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41s3pZ3dWvzDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 10:23:50 +1000 (AEST)
Message-ID: <16fa7682a17785cd2580a12fed60e237f6f98826.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/powernv/pci: Work around  races in PCI bridge enabling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <michaele@au1.ibm.com>
Date: Fri, 17 Aug 2018 10:23:42 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic code is race when multiple children of a PCI bridge try to
enable it simultaneously.

This leads to drivers trying to access a device through a not-yet-enabled
bridge, and this EEH errors under various circumstances when using parallel
driver probing.

There is work going on to fix that properly in the PCI core but it will
take some time.

x86 gets away with it because (outside of hotplug), the BIOS enables all
the bridges at boot time.

This patch does the same thing on powernv by enabling all bridges that
have child devices at boot time, thus avoiding subsequent races. It's suitable
for backporting to stable and distros, while the proper PCI fix will probably
be significantly more invasive.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: stable@vger.kernel.org
---

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 70b2e1e0f23c..0975b0aaf210 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3368,12 +3368,52 @@ static void pnv_pci_ioda_create_dbgfs(void)
 #endif /* CONFIG_DEBUG_FS */
 }
 
+static void pnv_pci_enable_bridge(struct pci_bus *bus)
+{
+	struct pci_dev *dev = bus->self;
+	struct pci_bus *child;
+
+	/* Empty bus ? bail */
+	if (list_empty(&bus->devices))
+		return;
+
+	/*
+	 * If there's a bridge associated with that bus enable it. This works
+	 * around races in the generic code if the enabling is done during
+	 * parallel probing. This can be removed once those races have been
+	 * fixed.
+	 */
+	if (dev) {
+		int rc = pci_enable_device(dev);
+		if (rc)
+			pci_err(dev, "Error enabling bridge (%d)\n", rc);
+		pci_set_master(dev);
+	}
+
+	/* Perform the same to child busses */
+	list_for_each_entry(child, &bus->children, node)
+		pnv_pci_enable_bridge(child);
+}
+
+static void pnv_pci_enable_bridges(void)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct pci_bus *bus;
+	struct pci_dev *pdev;
+
+	list_for_each_entry(hose, &hose_list, list_node)
+		pnv_pci_enable_bridge(hose->bus);
+}
+
 static void pnv_pci_ioda_fixup(void)
 {
 	pnv_pci_ioda_setup_PEs();
 	pnv_pci_ioda_setup_iommu_api();
 	pnv_pci_ioda_create_dbgfs();
 
+	pnv_pci_enable_bridges();
+
 #ifdef CONFIG_EEH
 	pnv_eeh_post_init();
 #endif
