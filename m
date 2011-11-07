Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 506F51007D3
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2011 15:58:14 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
 by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id pA74uRmf006293
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 15:56:27 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA74wD5F2584696
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 15:58:13 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA74wDcW020768
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 15:58:13 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] powerpc/pci: Add a platform hook after probe and before
 resource survey
Date: Mon,  7 Nov 2011 15:55:57 +1100
Message-Id: <1320641761-4028-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some platforms need to perform resource allocation using a custom algorithm
due to HW constraints, or may want to tweak things globally below a host
bridge. For example OPAL support for IODA will need to perform a
resource allocation pass that applies IODA specific segmentation
constraints to MMIO which cannot be done simply using the kernel generic
resource management code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/machdep.h |    3 +++
 arch/powerpc/kernel/pci-common.c   |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 58fc216..505bc21 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -212,6 +212,9 @@ struct machdep_calls {
 	 * allow assignment/enabling of the device. */
 	int  (*pcibios_enable_device_hook)(struct pci_dev *);
 
+	/* Called after scan and before resource survey */
+	void (*pcibios_fixup_phb)(struct pci_controller *hose);
+
 	/* Called to shutdown machine specific hardware not already controlled
 	 * by other drivers.
 	 */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 677eccc..855969f 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1731,6 +1731,12 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	if (mode == PCI_PROBE_NORMAL)
 		hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
 
+	/* Platform gets a chance to do some global fixups before
+	 * we proceed to resource allocation
+	 */
+	if (ppc_md.pcibios_fixup_phb)
+		ppc_md.pcibios_fixup_phb(hose);
+
 	/* Configure PCI Express settings */
 	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
 		struct pci_bus *child;
-- 
1.7.7.1
