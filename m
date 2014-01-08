Return-Path: <Minghuan.Lian@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A9B6D2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 16:02:01 +1100 (EST)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 06/12][v4] pci: fsl: port PCI controller setup code
Date: Wed, 8 Jan 2014 13:01:57 +0800
Message-ID: <1389157323-3088-6-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linux-pci@vger.kernel.org,
 Zang Roy-R61911 <r61911@freescale.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PCI controller setup code will initialize structure fsl_pci
according to PCI dts node and initialize PCI command register
and ATMU. The patch uses general API of_pci_parse_bus_range
to parse PCI bus range, uses general of_address's API to parse
PCI IO/MEM ranges.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v4:
no change
v1-v3:
Derived from http://patchwork.ozlabs.org/patch/278965/

Based on upstream master.
Based on the discussion of RFC version here
http://patchwork.ozlabs.org/patch/274487/

 drivers/pci/host/pci-fsl-common.c | 179 +++++++++++++++++++++-----------------
 1 file changed, 97 insertions(+), 82 deletions(-)

diff --git a/drivers/pci/host/pci-fsl-common.c b/drivers/pci/host/pci-fsl-common.c
index 26ee4c3..7184ac7 100644
--- a/drivers/pci/host/pci-fsl-common.c
+++ b/drivers/pci/host/pci-fsl-common.c
@@ -24,6 +24,8 @@
 #include <linux/log2.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -498,131 +500,144 @@ static void setup_pci_atmu(struct fsl_pci *pci)
 	}
 }
 
-static void __init setup_pci_cmd(struct pci_controller *hose)
+static void __init setup_pci_cmd(struct fsl_pci *pci)
 {
 	u16 cmd;
 	int cap_x;
 
-	early_read_config_word(hose, 0, 0, PCI_COMMAND, &cmd);
+	early_fsl_read_config_word(pci, 0, 0, PCI_COMMAND, &cmd);
 	cmd |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
 		| PCI_COMMAND_IO;
-	early_write_config_word(hose, 0, 0, PCI_COMMAND, cmd);
+	early_fsl_write_config_word(pci, 0, 0, PCI_COMMAND, cmd);
 
-	cap_x = early_find_capability(hose, 0, 0, PCI_CAP_ID_PCIX);
+	cap_x = early_fsl_find_capability(pci, 0, 0, PCI_CAP_ID_PCIX);
 	if (cap_x) {
 		int pci_x_cmd = cap_x + PCI_X_CMD;
 		cmd = PCI_X_CMD_MAX_SPLIT | PCI_X_CMD_MAX_READ
 			| PCI_X_CMD_ERO | PCI_X_CMD_DPERR_E;
-		early_write_config_word(hose, 0, 0, pci_x_cmd, cmd);
-	} else {
-		early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
-	}
+		early_fsl_write_config_word(pci, 0, 0, pci_x_cmd, cmd);
+	} else
+		early_fsl_write_config_byte(pci, 0, 0, PCI_LATENCY_TIMER,
+					    0x80);
 }
 
-int __init fsl_add_bridge(struct platform_device *pdev, int is_primary)
+static int __init
+fsl_pci_setup(struct platform_device *pdev, struct fsl_pci *pci)
 {
-	int len;
-	struct pci_controller *hose;
-	struct resource rsrc;
-	const int *bus_range;
+	struct resource *rsrc;
 	u8 hdr_type, progif;
-	struct device_node *dev;
-	struct ccsr_pci __iomem *pci;
-
-	dev = pdev->dev.of_node;
+	struct device_node *dn;
+	struct of_pci_range range;
+	struct of_pci_range_parser parser;
+	int mem = 0;
 
-	if (!of_device_is_available(dev)) {
-		pr_warning("%s: disabled\n", dev->full_name);
-		return -ENODEV;
-	}
+	dn = pdev->dev.of_node;
+	pci->dn = dn;
+	pci->dev = &pdev->dev;
 
-	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
+	dev_info(&pdev->dev, "Find controller %s\n", dn->full_name);
 
 	/* Fetch host bridge registers address */
-	if (of_address_to_resource(dev, 0, &rsrc)) {
-		printk(KERN_WARNING "Can't get pci register base!");
-		return -ENOMEM;
+	rsrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!rsrc) {
+		dev_err(&pdev->dev, "Can't get pci register base!");
+		return -EINVAL;
 	}
+	dev_info(&pdev->dev, "REG 0x%016llx..0x%016llx\n",
+		 (u64)rsrc->start, (u64)rsrc->end);
 
-	/* Get bus range if any */
-	bus_range = of_get_property(dev, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int))
-		printk(KERN_WARNING "Can't get bus-range for %s, assume"
-			" bus 0\n", dev->full_name);
-
-	pci_add_flags(PCI_REASSIGN_ALL_BUS);
-	hose = pcibios_alloc_controller(dev);
-	if (!hose)
-		return -ENOMEM;
+	/* Parse pci range resources from device tree */
+	if (of_pci_range_parser_init(&parser, dn)) {
+		dev_err(&pdev->dev, "missing ranges property\n");
+		return -EINVAL;
+	}
 
-	/* set platform device as the parent */
-	hose->parent = &pdev->dev;
-	hose->first_busno = bus_range ? bus_range[0] : 0x0;
-	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+	/* Get the I/O and memory ranges from device tree */
+	for_each_of_pci_range(&parser, &range) {
+		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
+		if (restype == IORESOURCE_IO) {
+			of_pci_range_to_resource(&range, dn,
+						 &pci->io_resource);
+			pci->io_resource.name = "I/O";
+			pci->io_resource.start = range.pci_addr;
+			pci->io_resource.end = range.pci_addr + range.size - 1;
+			pci->pci_io_size = range.size;
+			pci->io_base_phys = range.cpu_addr - range.pci_addr;
+			dev_info(&pdev->dev,
+				 " IO 0x%016llx..0x%016llx -> 0x%016llx\n",
+				 range.cpu_addr,
+				 range.cpu_addr + range.size - 1,
+				 range.pci_addr);
+		}
+		if (restype == IORESOURCE_MEM) {
+			if (mem >= 3)
+				continue;
+			of_pci_range_to_resource(&range, dn,
+						 &pci->mem_resources[mem]);
+			pci->mem_resources[mem].name = "MEM";
+			pci->mem_offset[mem] = range.cpu_addr - range.pci_addr;
+			dev_info(&pdev->dev,
+				 "MEM 0x%016llx..0x%016llx -> 0x%016llx\n",
+				 (u64)pci->mem_resources[mem].start,
+				 (u64)pci->mem_resources[mem].end,
+				 range.pci_addr);
+		}
+	}
 
-	pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
-		 (u64)rsrc.start, (u64)resource_size(&rsrc));
+	/* Get bus range */
+	if (of_pci_parse_bus_range(dn, &pci->busn)) {
+		dev_err(&pdev->dev, "failed to parse bus-range property\n");
+		pci->first_busno = 0x0;
+		pci->last_busno = 0xff;
+	} else {
+		pci->first_busno = pci->busn.start;
+		pci->last_busno = pci->busn.end;
+	}
+	dev_info(&pdev->dev, "Firmware bus number %d->%d\n",
+		 pci->first_busno, pci->last_busno);
 
-	pci = hose->private_data = ioremap(rsrc.start, resource_size(&rsrc));
-	if (!hose->private_data)
-		goto no_bridge;
+	pci->regs = devm_ioremap_resource(&pdev->dev, rsrc);
+	if (IS_ERR(pci->regs))
+		return PTR_ERR(pci->regs);
 
-	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
-			   PPC_INDIRECT_TYPE_BIG_ENDIAN);
+	pci->ops = &fsl_indirect_pci_ops;
+	pci->indirect_type = INDIRECT_TYPE_BIG_ENDIAN;
 
-	if (in_be32(&pci->block_rev1) < PCIE_IP_REV_3_0)
-		hose->indirect_type |= PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK;
+	if (in_be32(&pci->regs->block_rev1) < PCIE_IP_REV_3_0)
+		pci->indirect_type |= INDIRECT_TYPE_FSL_CFG_REG_LINK;
 
-	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
-		/* use fsl_indirect_read_config for PCIe */
-		hose->ops = &fsl_indirect_pcie_ops;
-		/* For PCIE read HEADER_TYPE to identify controler mode */
-		early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &hdr_type);
-		if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
+	pci->is_pcie = !!early_fsl_find_capability(pci, 0, 0, PCI_CAP_ID_EXP);
+	if (pci->is_pcie) {
+		/* For PCIE read HEADER_TYPE to identify controller mode */
+		early_fsl_read_config_byte(pci, 0, 0, PCI_HEADER_TYPE,
+					   &hdr_type);
+		if ((hdr_type & 0x7f) == PCI_HEADER_TYPE_NORMAL)
 			goto no_bridge;
-
 	} else {
 		/* For PCI read PROG to identify controller mode */
-		early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
+		early_fsl_read_config_byte(pci, 0, 0, PCI_CLASS_PROG, &progif);
 		if ((progif & 1) == 1)
 			goto no_bridge;
 	}
 
-	setup_pci_cmd(hose);
+	setup_pci_cmd(pci);
 
 	/* check PCI express link status */
-	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
-		hose->indirect_type |= PPC_INDIRECT_TYPE_EXT_REG |
-			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
-		if (fsl_pcie_check_link(hose))
-			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+	if (pci->is_pcie) {
+		pci->indirect_type |= INDIRECT_TYPE_EXT_REG |
+				       INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
+		if (!fsl_pci_check_link(pci))
+			pci->indirect_type |= INDIRECT_TYPE_NO_PCIE_LINK;
 	}
 
-	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
-		"Firmware bus number: %d->%d\n",
-		(unsigned long long)rsrc.start, hose->first_busno,
-		hose->last_busno);
-
-	pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
-		hose, hose->cfg_addr, hose->cfg_data);
-
-	/* Interpret the "ranges" property */
-	/* This also maps the I/O region and sets isa_io/mem_base */
-	pci_process_bridge_OF_ranges(hose, dev, is_primary);
-
 	/* Setup PEX window registers */
-	setup_pci_atmu(hose);
+	setup_pci_atmu(pci);
+
+	platform_set_drvdata(pdev, pci);
 
 	return 0;
 
 no_bridge:
-	iounmap(hose->private_data);
-	/* unmap cfg_data & cfg_addr separately if not on same page */
-	if (((unsigned long)hose->cfg_data & PAGE_MASK) !=
-	    ((unsigned long)hose->cfg_addr & PAGE_MASK))
-		iounmap(hose->cfg_data);
-	iounmap(hose->cfg_addr);
-	pcibios_free_controller(hose);
 	return -ENODEV;
 }
 
-- 
1.8.1.2
