Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0BEA0474C3
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 08:55:41 +1100 (EST)
Date: Fri, 9 Jan 2009 00:55:39 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v6 1/2] powerpc/fsl_pci: Add MPC83xx PCI-E controller RC
	mode support
Message-ID: <20090108215539.GA6183@oksana.dev.rtsoft.ru>
References: <20090108013006.GA31653@oksana.dev.rtsoft.ru>
	<20090108013110.GA11165@oksana.dev.rtsoft.ru>
	<C65915E8-6544-4229-9ED2-D2BB936D537C@kernel.crashing.org>
	<20090108191021.GA10008@oksana.dev.rtsoft.ru>
	<44A459AC-796C-4928-A39E-88F6F6DF159E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <44A459AC-796C-4928-A39E-88F6F6DF159E@kernel.crashing.org>
Cc: Huang Changming <Chang-Ming.Huang@freescale.com>,
	Liu Dave <DaveLiu@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for PCI-Express controllers as found on the
newer MPC83xx chips.

The work is loosely based on the Tony Li's patch[1], but unlike the
original patch, this patch implements sliding window for the Type 1
transactions using outbound window translations, so we don't have to
ioremap the whole PCI-E configuration space.

[1] http://ozlabs.org/pipermail/linuxppc-dev/2008-January/049028.html

Signed-off-by: Tony Li <tony.li@freescale.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Thu, Jan 08, 2009 at 01:24:27PM -0600, Kumar Gala wrote:
[...]
> I'm ok if you get rid of cfg_data usage.. than we aren't overloading the 
> indirect variables for 83xx pci cfg cycles

Here it is.

Thanks,

 arch/powerpc/sysdev/fsl_pci.c |  244 +++++++++++++++++++++++++++++++++++++----
 include/linux/pci_ids.h       |    8 ++
 2 files changed, 228 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 9817f63..78021d8 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1,12 +1,16 @@
 /*
  * MPC83xx/85xx/86xx PCI/PCIE support routing.
  *
- * Copyright 2007,2008 Freescale Semiconductor, Inc
+ * Copyright 2007-2009 Freescale Semiconductor, Inc.
+ * Copyright 2008-2009 MontaVista Software, Inc.
  *
  * Initial author: Xianghua Xiao <x.xiao@freescale.com>
  * Recode: ZHANG WEI <wei.zhang@freescale.com>
  * Rewrite the routing for Frescale PCI and PCI Express
  * 	Roy Zang <tie-fei.zang@freescale.com>
+ * MPC83xx PCI-Express support:
+ * 	Tony Li <tony.li@freescale.com>
+ * 	Anton Vorontsov <avorontsov@ru.mvista.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -27,6 +31,29 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+static int fsl_pcie_bus_fixup;
+
+static void __init quirk_fsl_pcie_header(struct pci_dev *dev)
+{
+	/* if we aren't a PCIe don't bother */
+	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
+		return;
+
+	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+	fsl_pcie_bus_fixup = 1;
+	return;
+}
+
+static int __init fsl_pcie_check_link(struct pci_controller *hose)
+{
+	u32 val;
+
+	early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
+	if (val < PCIE_LTSSM_L0)
+		return 1;
+	return 0;
+}
+
 #if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
 static int __init setup_one_atmu(struct ccsr_pci __iomem *pci,
 	unsigned int index, const struct resource *res,
@@ -159,28 +186,6 @@ static void __init setup_pci_pcsrbar(struct pci_controller *hose)
 #endif
 }
 
-static int fsl_pcie_bus_fixup;
-
-static void __init quirk_fsl_pcie_header(struct pci_dev *dev)
-{
-	/* if we aren't a PCIe don't bother */
-	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
-		return ;
-
-	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
-	fsl_pcie_bus_fixup = 1;
-	return ;
-}
-
-static int __init fsl_pcie_check_link(struct pci_controller *hose)
-{
-	u32 val;
-	early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
-	if (val < PCIE_LTSSM_L0)
-		return 1;
-	return 0;
-}
-
 void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
@@ -294,8 +299,184 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8610, quirk_fsl_pcie_header);
 #endif /* CONFIG_PPC_85xx || CONFIG_PPC_86xx */
 
 #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8314E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8314, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8315E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8315, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8377E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8377, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8378E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8378, quirk_fsl_pcie_header);
+
+struct mpc83xx_pcie_priv {
+	void __iomem *cfg_type0;
+	void __iomem *cfg_type1;
+	u32 dev_base;
+};
+
+/*
+ * With the convention of u-boot, the PCIE outbound window 0 serves
+ * as configuration transactions outbound.
+ */
+#define PEX_OUTWIN0_BAR		0xCA4
+#define PEX_OUTWIN0_TAL		0xCA8
+#define PEX_OUTWIN0_TAH		0xCAC
+
+static int mpc83xx_pcie_exclude_device(struct pci_bus *bus, unsigned int devfn)
+{
+	struct pci_controller *hose = bus->sysdata;
+
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	/*
+	 * Workaround for the HW bug: for Type 0 configure transactions the
+	 * PCI-E controller does not check the device number bits and just
+	 * assumes that the device number bits are 0.
+	 */
+	if (bus->number == hose->first_busno ||
+			bus->primary == hose->first_busno) {
+		if (devfn & 0xf8)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	if (ppc_md.pci_exclude_device) {
+		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static void __iomem *mpc83xx_pcie_remap_cfg(struct pci_bus *bus,
+					    unsigned int devfn, int offset)
+{
+	struct pci_controller *hose = bus->sysdata;
+	struct mpc83xx_pcie_priv *pcie = hose->dn->data;
+	u8 bus_no = bus->number - hose->first_busno;
+	u32 dev_base = bus_no << 24 | devfn << 16;
+	int ret;
+
+	ret = mpc83xx_pcie_exclude_device(bus, devfn);
+	if (ret)
+		return NULL;
+
+	offset &= 0xfff;
+
+	/* Type 0 */
+	if (bus->number == hose->first_busno)
+		return pcie->cfg_type0 + offset;
+
+	if (pcie->dev_base == dev_base)
+		goto mapped;
+
+	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAL, dev_base);
+
+	pcie->dev_base = dev_base;
+mapped:
+	return pcie->cfg_type1 + offset;
+}
+
+static int mpc83xx_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
+				    int offset, int len, u32 *val)
+{
+	void __iomem *cfg_addr;
+
+	cfg_addr = mpc83xx_pcie_remap_cfg(bus, devfn, offset);
+	if (!cfg_addr)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	switch (len) {
+	case 1:
+		*val = in_8(cfg_addr);
+		break;
+	case 2:
+		*val = in_le16(cfg_addr);
+		break;
+	default:
+		*val = in_le32(cfg_addr);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int mpc83xx_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
+				     int offset, int len, u32 val)
+{
+	void __iomem *cfg_addr;
+
+	cfg_addr = mpc83xx_pcie_remap_cfg(bus, devfn, offset);
+	if (!cfg_addr)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	switch (len) {
+	case 1:
+		out_8(cfg_addr, val);
+		break;
+	case 2:
+		out_le16(cfg_addr, val);
+		break;
+	default:
+		out_le32(cfg_addr, val);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops mpc83xx_pcie_ops = {
+	.read = mpc83xx_pcie_read_config,
+	.write = mpc83xx_pcie_write_config,
+};
+
+static int __init mpc83xx_pcie_setup(struct pci_controller *hose,
+				     struct resource *reg)
+{
+	struct mpc83xx_pcie_priv *pcie;
+	u32 cfg_bar;
+	int ret = -ENOMEM;
+
+	pcie = zalloc_maybe_bootmem(sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return ret;
+
+	pcie->cfg_type0 = ioremap(reg->start, resource_size(reg));
+	if (!pcie->cfg_type0)
+		goto err0;
+
+	cfg_bar = in_le32(pcie->cfg_type0 + PEX_OUTWIN0_BAR);
+	if (!cfg_bar) {
+		/* PCI-E isn't configured. */
+		ret = -ENODEV;
+		goto err1;
+	}
+
+	pcie->cfg_type1 = ioremap(cfg_bar, 0x1000);
+	if (!pcie->cfg_type1)
+		goto err1;
+
+	WARN_ON(hose->dn->data);
+	hose->dn->data = pcie;
+	hose->ops = &mpc83xx_pcie_ops;
+
+	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAH, 0);
+	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAL, 0);
+
+	if (fsl_pcie_check_link(hose))
+		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+
+	return 0;
+err1:
+	iounmap(pcie->cfg_type0);
+err0:
+	kfree(pcie);
+	return ret;
+
+}
+
 int __init mpc83xx_add_bridge(struct device_node *dev)
 {
+	int ret;
 	int len;
 	struct pci_controller *hose;
 	struct resource rsrc_reg;
@@ -303,6 +484,11 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	const int *bus_range;
 	int primary;
 
+	if (!of_device_is_available(dev)) {
+		pr_warning("%s: disabled by the firmware.\n",
+			   dev->full_name);
+		return -ENODEV;
+	}
 	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
 
 	/* Fetch host bridge registers address */
@@ -350,7 +536,14 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
-	setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 4, 0);
+	if (of_device_is_compatible(dev, "fsl,mpc8314-pcie")) {
+		ret = mpc83xx_pcie_setup(hose, &rsrc_reg);
+		if (ret)
+			goto err0;
+	} else {
+		setup_indirect_pci(hose, rsrc_cfg.start,
+				   rsrc_cfg.start + 4, 0);
+	}
 
 	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
@@ -365,5 +558,8 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	pci_process_bridge_OF_ranges(hose, dev, primary);
 
 	return 0;
+err0:
+	pcibios_free_controller(hose);
+	return ret;
 }
 #endif /* CONFIG_PPC_83xx */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b6e6944..008c90d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2209,6 +2209,14 @@
 #define PCI_DEVICE_ID_TDI_EHCI          0x0101
 
 #define PCI_VENDOR_ID_FREESCALE		0x1957
+#define PCI_DEVICE_ID_MPC8315E		0x00b4
+#define PCI_DEVICE_ID_MPC8315		0x00b5
+#define PCI_DEVICE_ID_MPC8314E		0x00b6
+#define PCI_DEVICE_ID_MPC8314		0x00b7
+#define PCI_DEVICE_ID_MPC8378E		0x00c4
+#define PCI_DEVICE_ID_MPC8378		0x00c5
+#define PCI_DEVICE_ID_MPC8377E		0x00c6
+#define PCI_DEVICE_ID_MPC8377		0x00c7
 #define PCI_DEVICE_ID_MPC8548E		0x0012
 #define PCI_DEVICE_ID_MPC8548		0x0013
 #define PCI_DEVICE_ID_MPC8543E		0x0014
-- 
1.5.6.5
