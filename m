Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7439CB7534
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 16:09:45 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p4K69fjD001144
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 01:09:41 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/14] powerpc/pci: Move FSL fixup from 32-bit to common
Date: Fri, 20 May 2011 01:09:29 -0500
Message-Id: <1305871771-16334-12-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1305871771-16334-11-git-send-email-galak@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-3-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-6-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-7-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-8-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-9-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-10-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-11-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need the FSL specific header fixup code on both 32-bit and 64-bit
platforms so just move the code into pci-common.c.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/pci-common.c |   18 ++++++++++++++++++
 arch/powerpc/kernel/pci_32.c     |   19 -------------------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 893af2a..4f134132c 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1728,3 +1728,21 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	if (mode == PCI_PROBE_NORMAL)
 		hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
 }
+
+static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
+{
+	int i, class = dev->class >> 8;
+
+	if ((class == PCI_CLASS_PROCESSOR_POWERPC ||
+	     class == PCI_CLASS_BRIDGE_OTHER) &&
+		(dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
+		(dev->bus->parent == NULL)) {
+		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+			dev->resource[i].start = 0;
+			dev->resource[i].end = 0;
+			dev->resource[i].flags = 0;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl);
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index bedb370..d521644 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -51,25 +51,6 @@ struct pci_dev *isa_bridge_pcidev;
 EXPORT_SYMBOL_GPL(isa_bridge_pcidev);
 
 static void
-fixup_hide_host_resource_fsl(struct pci_dev *dev)
-{
-	int i, class = dev->class >> 8;
-
-	if ((class == PCI_CLASS_PROCESSOR_POWERPC ||
-	     class == PCI_CLASS_BRIDGE_OTHER) &&
-		(dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
-		(dev->bus->parent == NULL)) {
-		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-			dev->resource[i].start = 0;
-			dev->resource[i].end = 0;
-			dev->resource[i].flags = 0;
-		}
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl); 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl); 
-
-static void
 fixup_cpc710_pci64(struct pci_dev* dev)
 {
 	/* Hide the PCI64 BARs from the kernel as their content doesn't
-- 
1.7.3.4
