Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66088B6F1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Dec 2009 12:31:54 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nBF1Vj6D007831
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2009 19:31:47 -0600
Subject: [PATCH] powerpc: Fix MSI support on U4 bridge PCIe slot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Dec 2009 12:31:13 +1100
Message-ID: <1260840673.12008.0.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On machines using the Apple U4 bridge (AKA IBM CPC945) PCIe interface such
as the latest generation G5 machines x16 slot or the x16 slot of the
PowerStation, MSIs are currently broken (and will oops when enabling).

This fixes the oops and implements proper support for those. Instead of
using the PCIe <-> HT bridge conversion, on such slots we need to use
a bunch of magic registers in the bridge as the MSI target, encoding
the interrupt number in the low bits of the address itself

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/mpic_msi.c   |   11 ++++++++-
 arch/powerpc/sysdev/mpic_u3msi.c |   46 ++++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic_msi.c b/arch/powerpc/sysdev/mpic_msi.c
index 1d44eee..0f67cd7 100644
--- a/arch/powerpc/sysdev/mpic_msi.c
+++ b/arch/powerpc/sysdev/mpic_msi.c
@@ -39,7 +39,12 @@ static int mpic_msi_reserve_u3_hwirqs(struct mpic *mpic)
 
 	pr_debug("mpic: found U3, guessing msi allocator setup\n");
 
-	/* Reserve source numbers we know are reserved in the HW */
+	/* Reserve source numbers we know are reserved in the HW.
+	 *
+	 * This is a bit of a mix of U3 and U4 reserves but that's going
+	 * to work fine, we have plenty enugh numbers left so let's just
+	 * mark anything we don't like reserved.
+	 */
 	for (i = 0;   i < 8;   i++)
 		msi_bitmap_reserve_hwirq(&mpic->msi_bitmap, i);
 
@@ -49,6 +54,10 @@ static int mpic_msi_reserve_u3_hwirqs(struct mpic *mpic)
 	for (i = 100; i < 105; i++)
 		msi_bitmap_reserve_hwirq(&mpic->msi_bitmap, i);
 
+	for (i = 124; i < mpic->irq_count; i++)
+		msi_bitmap_reserve_hwirq(&mpic->msi_bitmap, i);
+
+
 	np = NULL;
 	while ((np = of_find_all_nodes(np))) {
 		pr_debug("mpic: mapping hwirqs for %s\n", np->full_name);
diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index d3caf23..bcbfe79 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -64,12 +64,12 @@ static u64 read_ht_magic_addr(struct pci_dev *pdev, unsigned int pos)
 	return addr;
 }
 
-static u64 find_ht_magic_addr(struct pci_dev *pdev)
+static u64 find_ht_magic_addr(struct pci_dev *pdev, unsigned int hwirq)
 {
 	struct pci_bus *bus;
 	unsigned int pos;
 
-	for (bus = pdev->bus; bus; bus = bus->parent) {
+	for (bus = pdev->bus; bus && bus->self; bus = bus->parent) {
 		pos = pci_find_ht_capability(bus->self, HT_CAPTYPE_MSI_MAPPING);
 		if (pos)
 			return read_ht_magic_addr(bus->self, pos);
@@ -78,13 +78,41 @@ static u64 find_ht_magic_addr(struct pci_dev *pdev)
 	return 0;
 }
 
+static u64 find_u4_magic_addr(struct pci_dev *pdev, unsigned int hwirq)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+
+	/* U4 PCIe MSIs need to write to the special register in
+	 * the bridge that generates interrupts. There should be
+	 * theorically a register at 0xf8005000 where you just write
+	 * the MSI number and that triggers the right interrupt, but
+	 * unfortunately, this is busted in HW, the bridge endian swaps
+	 * the value and hits the wrong nibble in the register.
+	 *
+	 * So instead we use another register set which is used normally
+	 * for converting HT interrupts to MPIC interrupts, which decodes
+	 * the interrupt number as part of the low address bits
+	 *
+	 * This will not work if we ever use more than one legacy MSI in
+	 * a block but we never do. For one MSI or multiple MSI-X where
+	 * each interrupt address can be specified separately, it works
+	 * just fine.
+	 */
+	if (of_device_is_compatible(hose->dn, "u4-pcie") ||
+	    of_device_is_compatible(hose->dn, "U4-pcie"))
+		return 0xf8004000 | (hwirq << 4);
+
+	return 0;
+}
+
 static int u3msi_msi_check_device(struct pci_dev *pdev, int nvec, int type)
 {
 	if (type == PCI_CAP_ID_MSIX)
 		pr_debug("u3msi: MSI-X untested, trying anyway.\n");
 
 	/* If we can't find a magic address then MSI ain't gonna work */
-	if (find_ht_magic_addr(pdev) == 0) {
+	if (find_ht_magic_addr(pdev, 0) == 0 &&
+	    find_u4_magic_addr(pdev, 0) == 0) {
 		pr_debug("u3msi: no magic address found for %s\n",
 			 pci_name(pdev));
 		return -ENXIO;
@@ -118,10 +146,6 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	u64 addr;
 	int hwirq;
 
-	addr = find_ht_magic_addr(pdev);
-	msg.address_lo = addr & 0xFFFFFFFF;
-	msg.address_hi = addr >> 32;
-
 	list_for_each_entry(entry, &pdev->msi_list, list) {
 		hwirq = msi_bitmap_alloc_hwirqs(&msi_mpic->msi_bitmap, 1);
 		if (hwirq < 0) {
@@ -129,6 +153,12 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			return hwirq;
 		}
 
+		addr = find_ht_magic_addr(pdev, hwirq);
+		if (addr == 0)
+			addr = find_u4_magic_addr(pdev, hwirq);
+		msg.address_lo = addr & 0xFFFFFFFF;
+		msg.address_hi = addr >> 32;
+
 		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
 		if (virq == NO_IRQ) {
 			pr_debug("u3msi: failed mapping hwirq 0x%x\n", hwirq);
@@ -143,6 +173,8 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		pr_debug("u3msi: allocated virq 0x%x (hw 0x%x) addr 0x%lx\n",
 			  virq, hwirq, (unsigned long)addr);
 
+		printk("u3msi: allocated virq 0x%x (hw 0x%x) addr 0x%lx\n",
+			  virq, hwirq, (unsigned long)addr);
 		msg.data = hwirq;
 		write_msi_msg(virq, &msg);
 
