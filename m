Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 088EFDDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 07:18:55 +1100 (EST)
Date: Tue, 30 Dec 2008 23:18:53 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v3 3/4] powerpc/fsl_pci: Add MPC83xx PCI-E controller RC
	mode support
Message-ID: <20081230201853.GA28159@oksana.dev.rtsoft.ru>
References: <20081229164038.GC8215@oksana.dev.rtsoft.ru>
	<DE5232AE-281E-4A6E-9844-A69DF7C90034@kernel.crashing.org>
	<20081229210559.GA10801@oksana.dev.rtsoft.ru>
	<1EEA4587-74B7-499C-B367-02ABACB379A0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1EEA4587-74B7-499C-B367-02ABACB379A0@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
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

On Tue, Dec 30, 2008 at 12:07:08PM -0600, Kumar Gala wrote:
[...]
>> --- a/arch/powerpc/include/asm/pci-bridge.h
>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>> @@ -132,6 +132,7 @@ struct pci_controller {
>> #define PPC_INDIRECT_TYPE_NO_PCIE_LINK		0x00000008
>> #define PPC_INDIRECT_TYPE_BIG_ENDIAN		0x00000010
>> #define PPC_INDIRECT_TYPE_BROKEN_MRM		0x00000020
>> +#define PPC_INDIRECT_TYPE_MPC83XX_PCIE		0x00000040
>
> we are bastardizing indirect_type w/this.
>
> 1. we just possibly rename this flags and have it generally available.
> 2. we should rename PPC_INDIRECT_TYPE_MPC83XX_PCIE to _BROKEN_....
> 3. add a comment about what the new type is for.

Ugh, the PPC_INDIRECT_TYPE_MPC83XX_PCIE is a relic from the
original patch, when HW bug workaround was in the board file(s).
Now we don't need it as raw read/write pci ops are per phb,
thus we already know that this is mpc83xx pcie controller.

Even if we'll need this information at some point in the board
files, we can just use of_device_is_compatible().

Thanks for catching this.

[...]
>> -#if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
>> /* atmu setup for fsl pci/pcie controller */
>> static void __init setup_pci_atmu(struct pci_controller *hose,
>> 				  struct resource *rsrc)
>> @@ -228,6 +231,14 @@ int __init fsl_add_bridge(struct device_node  
>> *dev, int is_primary)
>> 	return 0;
>> }
>
> I might just be missing the ctx in the patch, but is there a reason to  
> expose setup_pci_atmu() on 83xx?

No, we only need the fixups and fsl_pcie_check_link(). Though, I'll
need to rearange the code to avoid new #ifdefs.

[...]
>> #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
>> +struct mpc83xx_pcie {
>
> should probably be something like struct pcie_window {

Well, I'd like to avoid _window, this struct might not neccesary
describe only cfg window. It's just a private struct for mpc83xx
pcie nodes, alike to driver_data for full fledged devices.

But I agree that "mpc83xx_pcie" name might be confusing (i.e. it
might look like the struct describes mpc83xx pcie registers).
Let's call it struct mpc83xx_pcie_priv?

Thanks for review, new version is down below.

 arch/powerpc/sysdev/fsl_pci.c |  234 ++++++++++++++++++++++++++++++++++++----
 include/linux/pci_ids.h       |    8 ++
 2 files changed, 218 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index f611d03..812dde3 100644
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
 /* atmu setup for fsl pci/pcie controller */
 static void __init setup_pci_atmu(struct pci_controller *hose,
@@ -118,28 +145,6 @@ static void __init setup_pci_pcsrbar(struct pci_controller *hose)
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
@@ -253,6 +258,171 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8610, quirk_fsl_pcie_header);
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
+	void __iomem *cfg_map;
+	u32 dev_base;
+};
+
+/*
+ * With the convention of u-boot, the PCIE outbound window 0 serves
+ * as configuration transactions outbound.
+ */
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
+	u32 dev_base = bus_no << 20 | devfn << 12;
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
+		return hose->cfg_data + offset;
+
+	if (pcie->dev_base == dev_base)
+		goto mapped;
+
+	out_le32(hose->cfg_data + PEX_OUTWIN0_TAL, dev_base);
+
+	pcie->dev_base = dev_base;
+mapped:
+	return pcie->cfg_map + offset;
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
+				     struct resource *reg,
+				     struct resource *cfg)
+{
+	struct mpc83xx_pcie_priv *pcie;
+
+	pcie = zalloc_maybe_bootmem(sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->cfg_map = ioremap(cfg->start, 0x1000);
+	if (!pcie->cfg_map)
+		goto err_cfg_map;
+
+	hose->cfg_data = ioremap(reg->start, resource_size(reg));
+	if (!hose->cfg_data)
+		goto err_cfg_data;
+
+	WARN_ON(hose->dn->data);
+	hose->dn->data = pcie;
+	hose->ops = &mpc83xx_pcie_ops;
+
+	out_le32(hose->cfg_data + PEX_OUTWIN0_TAH, 0);
+	out_le32(hose->cfg_data + PEX_OUTWIN0_TAL, 0);
+
+	if (fsl_pcie_check_link(hose))
+		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+
+	return 0;
+err_cfg_data:
+	iounmap(pcie->cfg_map);
+err_cfg_map:
+	kfree(pcie);
+	return -ENOMEM;
+
+}
+
 int __init mpc83xx_add_bridge(struct device_node *dev)
 {
 	int len;
@@ -262,6 +432,10 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	const int *bus_range;
 	int primary;
 
+	if (!of_device_is_available(dev)) {
+		pr_warning("%s: disabled by the firmware.\n", dev->full_name);
+		return -ENODEV;
+	}
 	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
 
 	/* Fetch host bridge registers address */
@@ -309,7 +483,16 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
-	setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 4, 0);
+	if (of_device_is_compatible(dev, "fsl,mpc8314-pcie")) {
+		int ret;
+
+		ret = mpc83xx_pcie_setup(hose, &rsrc_reg, &rsrc_cfg);
+		if (ret)
+			goto err;
+	} else {
+		setup_indirect_pci(hose, rsrc_cfg.start,
+				   rsrc_cfg.start + 4, 0);
+	}
 
 	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
@@ -324,5 +507,8 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	pci_process_bridge_OF_ranges(hose, dev, primary);
 
 	return 0;
+err:
+	pcibios_free_controller(hose);
+	return -ENOMEM;
 }
 #endif /* CONFIG_PPC_83xx */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1800f1d..b30e28f 100644
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
