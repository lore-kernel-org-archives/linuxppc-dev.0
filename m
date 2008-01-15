Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87173DDF88
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 13:48:20 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0F2mG9v021910
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 20:48:16 -0600
Date: Mon, 14 Jan 2008 20:46:03 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] FSL: Rework PCI/PCIe support for 85xx/86xx
Message-ID: <Pine.LNX.4.64.0801142045290.32246@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current PCI code for Freescale 85xx/86xx was treating the virtual
P2P PCIe bridge as a transparent bridge.  Rather than doing that fixup
the virtual P2P bridge by copying the resources from the PHB.

Also, fixup a bit of the code for dealing with resource_size_t being
64-bits and how we set ATMU registers for >4G.

---

in my git tree.

 arch/powerpc/sysdev/fsl_pci.c |  141 +++++++++++++++++------------------------
 1 files changed, 57 insertions(+), 84 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4b1d512..39177eb 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -33,8 +33,8 @@ void __init setup_pci_atmu(struct pci_controller *hose, struct resource *rsrc)
 	struct ccsr_pci __iomem *pci;
 	int i;

-	pr_debug("PCI memory map start 0x%x, size 0x%x\n", rsrc->start,
-			rsrc->end - rsrc->start + 1);
+	pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
+		    (u64)rsrc->start, (u64)rsrc->end - (u64)rsrc->start + 1);
 	pci = ioremap(rsrc->start, rsrc->end - rsrc->start + 1);

 	/* Disable all windows (except powar0 since its ignored) */
@@ -46,17 +46,17 @@ void __init setup_pci_atmu(struct pci_controller *hose, struct resource *rsrc)
 	/* Setup outbound MEM window */
 	for(i = 0; i < 3; i++)
 		if (hose->mem_resources[i].flags & IORESOURCE_MEM){
-			pr_debug("PCI MEM resource start 0x%08x, size 0x%08x.\n",
-				hose->mem_resources[i].start,
-				hose->mem_resources[i].end
-				  - hose->mem_resources[i].start + 1);
-			out_be32(&pci->pow[i+1].potar,
-				(hose->mem_resources[i].start >> 12)
-				& 0x000fffff);
+			resource_size_t pci_addr_start =
+				 hose->mem_resources[i].start -
+				 hose->pci_mem_offset;
+			pr_debug("PCI MEM resource start 0x%016llx, size 0x%016llx.\n",
+				(u64)hose->mem_resources[i].start,
+				(u64)hose->mem_resources[i].end
+				  - (u64)hose->mem_resources[i].start + 1);
+			out_be32(&pci->pow[i+1].potar, (pci_addr_start >> 12));
 			out_be32(&pci->pow[i+1].potear, 0);
 			out_be32(&pci->pow[i+1].powbar,
-				(hose->mem_resources[i].start >> 12)
-				& 0x000fffff);
+				(hose->mem_resources[i].start >> 12));
 			/* Enable, Mem R/W */
 			out_be32(&pci->pow[i+1].powar, 0x80044000
 				| (__ilog2(hose->mem_resources[i].end
@@ -65,15 +65,14 @@ void __init setup_pci_atmu(struct pci_controller *hose, struct resource *rsrc)

 	/* Setup outbound IO window */
 	if (hose->io_resource.flags & IORESOURCE_IO){
-		pr_debug("PCI IO resource start 0x%08x, size 0x%08x, phy base 0x%08x.\n",
-			hose->io_resource.start,
-			hose->io_resource.end - hose->io_resource.start + 1,
-			hose->io_base_phys);
-		out_be32(&pci->pow[i+1].potar, (hose->io_resource.start >> 12)
-				& 0x000fffff);
+		pr_debug("PCI IO resource start 0x%016llx, size 0x%016llx, "
+			 "phy base 0x%016llx.\n",
+			(u64)hose->io_resource.start,
+			(u64)hose->io_resource.end - (u64)hose->io_resource.start + 1,
+			(u64)hose->io_base_phys);
+		out_be32(&pci->pow[i+1].potar, (hose->io_resource.start >> 12));
 		out_be32(&pci->pow[i+1].potear, 0);
-		out_be32(&pci->pow[i+1].powbar, (hose->io_base_phys >> 12)
-				& 0x000fffff);
+		out_be32(&pci->pow[i+1].powbar, (hose->io_base_phys >> 12));
 		/* Enable, IO R/W */
 		out_be32(&pci->pow[i+1].powar, 0x80088000
 			| (__ilog2(hose->io_resource.end
@@ -107,55 +106,17 @@ void __init setup_pci_cmd(struct pci_controller *hose)
 	}
 }

-static void __init quirk_fsl_pcie_transparent(struct pci_dev *dev)
-{
-	struct resource *res;
-	int i, res_idx = PCI_BRIDGE_RESOURCES;
-	struct pci_controller *hose;
+static int fsl_pcie_bus_fixup;

+static void __init quirk_fsl_pcie_header(struct pci_dev *dev)
+{
 	/* if we aren't a PCIe don't bother */
 	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
 		return ;
-
-	/*
-	 * Make the bridge be transparent.
-	 */
-	dev->transparent = 1;
-
-	hose = pci_bus_to_host(dev->bus);
-	if (!hose) {
-		printk(KERN_ERR "Can't find hose for bus %d\n",
-		       dev->bus->number);
-		return;
-	}
-
-	/* Clear out any of the virtual P2P bridge registers */
-	pci_write_config_word(dev, PCI_IO_BASE_UPPER16, 0);
-	pci_write_config_word(dev, PCI_IO_LIMIT_UPPER16, 0);
-	pci_write_config_byte(dev, PCI_IO_BASE, 0x10);
-	pci_write_config_byte(dev, PCI_IO_LIMIT, 0);
-	pci_write_config_word(dev, PCI_MEMORY_BASE, 0x10);
-	pci_write_config_word(dev, PCI_MEMORY_LIMIT, 0);
-	pci_write_config_word(dev, PCI_PREF_BASE_UPPER32, 0x0);
-	pci_write_config_word(dev, PCI_PREF_LIMIT_UPPER32, 0x0);
-	pci_write_config_word(dev, PCI_PREF_MEMORY_BASE, 0x10);
-	pci_write_config_word(dev, PCI_PREF_MEMORY_LIMIT, 0);
-
-	if (hose->io_resource.flags) {
-		res = &dev->resource[res_idx++];
-		res->start = hose->io_resource.start;
-		res->end = hose->io_resource.end;
-		res->flags = hose->io_resource.flags;
-		update_bridge_resource(dev, res);
-	}
-
-	for (i = 0; i < 3; i++) {
-		res = &dev->resource[res_idx + i];
-		res->start = hose->mem_resources[i].start;
-		res->end = hose->mem_resources[i].end;
-		res->flags = hose->mem_resources[i].flags;
-		update_bridge_resource(dev, res);
-	}
+
+	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+	fsl_pcie_bus_fixup = 1;
+	return ;
 }

 int __init fsl_pcie_check_link(struct pci_controller *hose)
@@ -179,6 +140,18 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 				bus->resource[i] = bus->parent->resource[i];
 		}
 	}
+
+	if (fsl_pcie_bus_fixup &&
+	    (bus->parent == hose->bus) &&
+	     early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
+		for (i = 0; i < 4; ++i) {
+			if (bus->resource[i] && bus->parent->resource[i]) {
+				bus->resource[i]->start = bus->parent->resource[i]->start;
+				bus->resource[i]->end = bus->parent->resource[i]->end;
+				bus->resource[i]->flags = bus->parent->resource[i]->flags;
+			}
+		}
+	}
 }

 int __init fsl_add_bridge(struct device_node *dev, int is_primary)
@@ -240,23 +213,23 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	return 0;
 }

-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8548E, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8548, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8543E, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8543, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8547E, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8545E, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8545, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8568E, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8568, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8567E, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8567, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8533E, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8533, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8544E, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8544, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8572E, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8572, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8641, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8610, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8548E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8548, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8543E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8543, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8547E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8545E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8545, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8568E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8568, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8567E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8567, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8533E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8533, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8544E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8544, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8572E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8572, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8610, quirk_fsl_pcie_header);
-- 
1.5.3.7
