Return-Path: <fkan@amcc.com>
Received: from svdc-dhcp-10-66-6-202.amcc.com (unknown [76.195.33.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2457DDED9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 15:34:30 +1000 (EST)
From: fkan@amcc.com
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Add AMCC 4XX PCIe MSI support
Date: Thu, 21 Aug 2008 21:42:24 -0700
Message-Id: <1219380144-17175-1-git-send-email-fkan@amcc.com>
Cc: Preetesh Parekh <pparekh@amcc.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Preetesh  Parekh <pparekh@amcc.com>

Signed-off-by: Preetesh Parekh <pparekh@amcc.com>
---
 arch/powerpc/platforms/40x/kilauea.c     |   13 ++++
 arch/powerpc/platforms/44x/canyonlands.c |   14 ++++
 arch/powerpc/sysdev/ppc4xx_pci.c         |  115 ++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.h         |   45 ++++++++++++
 include/asm-powerpc/dcr-native.h         |   12 +++
 5 files changed, 199 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/40x/kilauea.c b/arch/powerpc/platforms/40x/kilauea.c
index 1dd24ff..3610be2 100644
--- a/arch/powerpc/platforms/40x/kilauea.c
+++ b/arch/powerpc/platforms/40x/kilauea.c
@@ -22,6 +22,11 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc4xx.h>
 
+#ifdef CONFIG_PCI_MSI
+extern int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+extern void ppc4xx_teardown_msi_irqs(struct pci_dev *dev);
+#endif
+
 static __initdata struct of_device_id kilauea_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,opb", },
@@ -46,6 +51,14 @@ static int __init kilauea_probe(void)
 
 	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
 
+#ifdef CONFIG_PCI_MSI
+	/*
+	 * Setting callback functions for MSI support
+	 */
+	ppc_md.setup_msi_irqs = ppc4xx_setup_msi_irqs;
+	ppc_md.teardown_msi_irqs = ppc4xx_teardown_msi_irqs;
+#endif
+
 	return 1;
 }
 
diff --git a/arch/powerpc/platforms/44x/canyonlands.c b/arch/powerpc/platforms/44x/canyonlands.c
index 3949289..ee38fb7 100644
--- a/arch/powerpc/platforms/44x/canyonlands.c
+++ b/arch/powerpc/platforms/44x/canyonlands.c
@@ -25,6 +25,12 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc4xx.h>
 
+
+#ifdef CONFIG_PCI_MSI
+extern int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+extern void ppc4xx_teardown_msi_irqs(struct pci_dev *dev);
+#endif
+
 static __initdata struct of_device_id canyonlands_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,opb", },
@@ -49,6 +55,14 @@ static int __init canyonlands_probe(void)
 
 	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
 
+#ifdef CONFIG_PCI_MSI
+	/*
+	 * Setting callback functions for MSI support
+	 */
+	ppc_md.setup_msi_irqs = ppc4xx_setup_msi_irqs;
+	ppc_md.teardown_msi_irqs = ppc4xx_teardown_msi_irqs;
+#endif
+
 	return 1;
 }
 
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index fb368df..bdb3663 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -35,6 +35,11 @@
 
 static int dma_offset_set;
 
+#ifdef CONFIG_PCI_MSI
+#include <linux/msi.h>
+#include "../../../drivers/pci/msi.h"
+#endif
+
 /* Move that to a useable header */
 extern unsigned long total_memory;
 
@@ -1587,12 +1592,26 @@ static void __init ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port *port)
 	out_le16(mbase + 0x202, val);
 
 	if (!port->endpoint) {
+#ifdef CONFIG_PCI_MSI
+		/* Set MSI enable, multiple msg cap = 4 */
+		/* 4 messages allocated, 64 bit capability */
+		out_le32(mbase + 0x048, in_le32(mbase + 0x048) | 0x00a50000);
+
+		/* Enable interrupts in BCR */
+		out_le32(mbase + 0x03C, in_le32(mbase + 0x03C) | 0xFF000000);
+#endif
+
 		/* Set Class Code to PCI-PCI bridge and Revision Id to 1 */
 		out_le32(mbase + 0x208, 0x06040001);
 
 		printk(KERN_INFO "PCIE%d: successfully set as root-complex\n",
 		       port->index);
 	} else {
+#ifdef CONFIG_PCI_MSI
+		/* Enable MSI for End-Point */
+		out_le32(mbase + 0x048, (in_le32(mbase + 0x048) | 0x00a50000));
+#endif
+
 		/* Set Class Code to Processor/PPC */
 		out_le32(mbase + 0x208, 0x0b200001);
 
@@ -1704,6 +1723,97 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
 	ppc4xx_pciex_port_setup_hose(port);
 }
 
+#ifdef CONFIG_PCI_MSI
+int ppc4xx_setup_peih(void)
+{
+	void __iomem *peih_base;
+
+	printk(KERN_INFO " %s \n",__FUNCTION__);	
+	/* Set base address for PEIH and enable PEIH */
+	SDR_WRITE(PESDR0_4XX_IHS1, PPC4XX_PEIH_REGBASE_HADDR);	
+	SDR_WRITE(PESDR0_4XX_IHS2, PPC4XX_PEIH_REGBASE_LADDR);	
+
+	/* Map in PCI-E Interrupt Handler Registers */
+	peih_base = ioremap(PPC4XX_PEIH_REGBASE, PPC4XX_PEIH_REGSIZE);
+	if(!peih_base) {
+		printk(KERN_ERR "%s: ioremap64 failed for addr 0x%08x\n",
+			__FUNCTION__, PPC4XX_PEIH_REGBASE);
+		return -ENODEV;
+	}
+
+	/* Progam the Interrupt handler Termination addr registers */
+	out_be32(peih_base + PEIH_TERMADH, PPC4XX_PCIE_MSI_HADDR);
+	out_be32(peih_base + PEIH_TERMADL, PPC4XX_PCIE_MSI_LADDR);
+
+	/* Program MSI Expected data and Mask bits */
+	out_be32(peih_base + PEIH_MSIED, PPC4XX_MSI_DATA_PTRN);
+	out_be32(peih_base + PEIH_MSIMK, PPC4XX_MSI_DATA_VALD);
+
+	iounmap(peih_base);
+
+	return 0;	/* success */
+}
+
+
+int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
+{
+	/* Setup MSI Capabilities structure for dev func */
+	int pos;
+	u16 control, ctrl;
+
+	printk(KERN_INFO " %s \n",__FUNCTION__);	
+	pos = desc->msi_attrib.pos;
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
+
+	/* Multiple msg enable */
+	ctrl = multi_msi_enable(control, 4);
+	pci_write_config_dword(dev, msi_control_reg(pos), ctrl);
+
+	/* setup MSI address registers */
+	if(is_64bit_address(control))
+		pci_write_config_dword(dev, msi_upper_address_reg(pos), PPC4XX_PCIE_MSI_HADDR);
+
+	pci_write_config_dword(dev, msi_lower_address_reg(pos),
+					PPC4XX_PCIE_MSI_LADDR);
+
+	if(is_64bit_address(control)) {
+		/* setup MSI data register */
+		pci_write_config_dword(dev, msi_data_reg(pos, 1),
+						PPC4XX_MSI_DATA_PTRN_EP);
+		/* setup MSI mask bits reg */
+		pci_write_config_dword(dev, msi_mask_bits_reg(pos, 1), 0x00000000);
+	}
+	else {
+		pci_write_config_dword(dev, msi_data_reg(pos, 0),
+							PPC4XX_MSI_DATA_PTRN_EP);
+		pci_write_config_dword(dev, msi_mask_bits_reg(pos, 0), 0x00000000);
+	}
+		
+	return 0;
+}
+
+int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	struct msi_desc *entry;
+	int ret;
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		ret = arch_setup_msi_irq(dev, entry);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
+{
+	return;
+}
+
+
+#endif	/* CONFIG_PCI_MSI  */
+
 #endif /* CONFIG_PPC4xx_PCI_EXPRESS */
 
 static int __init ppc4xx_pci_find_bridges(void)
@@ -1713,6 +1823,11 @@ static int __init ppc4xx_pci_find_bridges(void)
 #ifdef CONFIG_PPC4xx_PCI_EXPRESS
 	for_each_compatible_node(np, NULL, "ibm,plb-pciex")
 		ppc4xx_probe_pciex_bridge(np);
+
+#ifdef CONFIG_PCI_MSI
+	ppc4xx_setup_peih();
+#endif
+
 #endif
 	for_each_compatible_node(np, NULL, "ibm,plb-pcix")
 		ppc4xx_probe_pcix_bridge(np);
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.h b/arch/powerpc/sysdev/ppc4xx_pci.h
index d04e40b..d5fcaa9 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.h
+++ b/arch/powerpc/sysdev/ppc4xx_pci.h
@@ -158,6 +158,51 @@
 #define GPL_DMER_MASK_DISA	0x02000000
 
 /*
+ * 4xx PCIe IRQ Handler register definitions
+ */
+#ifdef CONFIG_PCI_MSI
+
+#if defined(CONFIG_405EX)
+#define PESDR0_4XX_IHS1				0x04B0
+#define PESDR0_4XX_IHS2				0x04B1
+#define PPC4XX_PEIH_REGBASE			0x0EF620000
+#define PPC4XX_PEIH_REGBASE_HADDR   	0x0
+#define PPC4XX_PEIH_REGBASE_LADDR   	0xEF620000
+#define PPC4XX_PCIE_MSI_ADDR  			0x080000000
+#define PPC4XX_PCIE_MSI_HADDR  		0x0
+#define PPC4XX_PCIE_MSI_LADDR  		0x80000000
+
+#elif defined(CONFIG_460EX)
+#define PESDR0_4XX_IHS1				0x036C
+#define PESDR0_4XX_IHS2				0x036D
+#define PPC4XX_PEIH_REGBASE			0xC10000000
+#define PPC4XX_PEIH_REGBASE_HADDR   	0xC
+#define PPC4XX_PEIH_REGBASE_LADDR   	0x10000000
+#define PPC4XX_PCIE_MSI_ADDR  			0xe80000000
+#define PPC4XX_PCIE_MSI_HADDR  		0xe
+#define PPC4XX_PCIE_MSI_LADDR  		0x80000000
+#endif
+
+#define PPC4XX_PEIH_REGSIZE       0x100
+#define PPC4XX_MSI_DATA_PTRN      0x44440000
+#define PPC4XX_MSI_DATA_VALD      0xFFFF0000
+#define PPC4XX_MSI_DATA_PTRN_EP   0x00004444
+
+#define PEIH_TERMADH    0x00
+#define PEIH_TERMADL    0x08
+#define PEIH_MSIED      0x10
+#define PEIH_MSIMK      0x18
+#define PEIH_MSIASS     0x20
+#define PEIH_FLUSH0     0x30
+#define PEIH_FLUSH1     0x38
+#define PEIH_CNTRST     0x48
+
+
+#endif 	/* CONFIG_PCI_MSI  */
+
+
+
+/*
  * System DCRs (SDRs)
  */
 #define PESDR0_PLLLCT1			0x03a0
diff --git a/include/asm-powerpc/dcr-native.h b/include/asm-powerpc/dcr-native.h
index 72d2b72..357ba36 100644
--- a/include/asm-powerpc/dcr-native.h
+++ b/include/asm-powerpc/dcr-native.h
@@ -111,6 +111,18 @@ static inline void __dcri_clrset(int base_addr, int base_data, int reg,
 							      DCRN_ ## base ## _CONFIG_DATA,	\
 							      reg, clr, set)
 
+/* SDR read/write helper macros */
+
+#define DCRN_SDR_CONFIG_ADDR    0x00E
+#define DCRN_SDR_CONFIG_DATA    0x00F
+
+#define SDR_READ(offset) ({			\
+	mtdcr(DCRN_SDR_CONFIG_ADDR, offset);	\
+	mfdcr(DCRN_SDR_CONFIG_DATA);})
+#define SDR_WRITE(offset, data) ({		\
+	mtdcr(DCRN_SDR_CONFIG_ADDR, offset);	\
+	mtdcr(DCRN_SDR_CONFIG_DATA, data);})
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DCR_NATIVE_H */
-- 
1.5.5
