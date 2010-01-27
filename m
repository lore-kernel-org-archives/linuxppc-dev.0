Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40739B7E71
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jan 2010 14:10:25 +1100 (EST)
Subject: [PATCH 1/3] powerpc/pci: Add calls to set_pcie_port_type() and
	set_pcie_hotplug_bridge()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 27 Jan 2010 14:10:03 +1100
Message-ID: <1264561803.3601.163.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Breno Leitao <leitao@linux.vnet.ibm.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are missing these when building the pci_dev from scratch off
the Open Firmware device-tree

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_of_scan.c |    2 ++
 drivers/pci/probe.c               |    4 ++--
 include/linux/pci.h               |    4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

Jesse, can I have an ack for the generic bits ? Note that I couldn't test
on a pSeries machine with PCI-E as all such machines in ozlabs currently
have all their partitions with PCI-E devices in them in FAIL state in ABAT
and our admin is out.

Breno, can you test ? Also if you could give a quick spin to the other ones
too make sure they don't break anything else, it would be great ! 

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 7311fdf..693eb9a 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -140,6 +140,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 	dev->devfn = devfn;
 	dev->multifunction = 0;		/* maybe a lie? */
 	dev->needs_freset = 0;		/* pcie fundamental reset required */
+	set_pcie_port_type(dev);
 
 	dev->vendor = get_int_prop(node, "vendor-id", 0xffff);
 	dev->device = get_int_prop(node, "device-id", 0xffff);
@@ -164,6 +165,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 		/* a PCI-PCI bridge */
 		dev->hdr_type = PCI_HEADER_TYPE_BRIDGE;
 		dev->rom_base_reg = PCI_ROM_ADDRESS1;
+		set_pcie_hotplug_bridge(dev);
 	} else if (!strcmp(type, "cardbus")) {
 		dev->hdr_type = PCI_HEADER_TYPE_CARDBUS;
 	} else {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 98ffb2d..446e4a9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -681,7 +681,7 @@ static void pci_read_irq(struct pci_dev *dev)
 	dev->irq = irq;
 }
 
-static void set_pcie_port_type(struct pci_dev *pdev)
+void set_pcie_port_type(struct pci_dev *pdev)
 {
 	int pos;
 	u16 reg16;
@@ -695,7 +695,7 @@ static void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_type = (reg16 & PCI_EXP_FLAGS_TYPE) >> 4;
 }
 
-static void set_pcie_hotplug_bridge(struct pci_dev *pdev)
+void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 {
 	int pos;
 	u16 reg16;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 174e539..c1968f4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -756,6 +756,10 @@ pci_power_t pci_target_state(struct pci_dev *dev);
 int pci_prepare_to_sleep(struct pci_dev *dev);
 int pci_back_from_sleep(struct pci_dev *dev);
 
+/* For use by arch with custom probe code */
+void set_pcie_port_type(struct pci_dev *pdev);
+void set_pcie_hotplug_bridge(struct pci_dev *pdev);
+
 /* Functions for PCI Hotplug drivers to use */
 int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
 #ifdef CONFIG_HOTPLUG
