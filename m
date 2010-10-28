Return-Path: <tmarri@amcc.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9DB5B70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 09:55:24 +1100 (EST)
From: tmarri@apm.com
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATHC v1] PPC4xx: Adding PCI(E) MSI support
Date: Thu, 28 Oct 2010 15:55:14 -0700
Message-Id: <1288306514-9769-1-git-send-email-tmarri@apm.com>
Cc: tmarri@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tirumala Marri <tmarri@apm.com>

This patch adds MSI support for 440SPe, 460Ex, 460Sx and 405Ex.

Signed-off-by: Tirumala R Marri <tmarri@apm.com>
---
v1:
  * Get rid of bitmap functions.
  * Remove irq mapping as each MSI is tied to UIC.
  * Cleaning up of prints.
---
 arch/powerpc/boot/dts/canyonlands.dts |   18 +++
 arch/powerpc/boot/dts/katmai.dts      |   18 +++
 arch/powerpc/boot/dts/kilauea.dts     |   28 ++++
 arch/powerpc/boot/dts/redwood.dts     |   20 +++
 arch/powerpc/platforms/40x/Kconfig    |    2 +
 arch/powerpc/platforms/44x/Kconfig    |    6 +
 arch/powerpc/sysdev/Kconfig           |    6 +
 arch/powerpc/sysdev/Makefile          |    1 +
 arch/powerpc/sysdev/ppc4xx_msi.c      |  251 +++++++++++++++++++++++++++++++++
 9 files changed, 350 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/ppc4xx_msi.c

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index a303703..5a8e04e 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -519,5 +519,23 @@
 				0x0 0x0 0x0 0x3 &UIC3 0x12 0x4 /* swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC3 0x13 0x4 /* swizzled int D */>;
 		};
+
+		MSI: ppc4xx-msi@C10000000 {
+			compatible = "amcc,ppc4xx-msi", "ppc4xx-msi";
+			reg = < 0xC 0x10000000 0x100>;
+			sdr-base = <0x36C>;
+			msi-data = <0x00000000>;
+			msi-mask = <0x44440000>;
+			interrupt-count = <3>;
+			interrupts = <0 1 2 3>;
+			interrupt-parent = <&UIC3>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = <0 &UIC3 0x18 1
+					1 &UIC3 0x19 1
+					2 &UIC3 0x1A 1
+					3 &UIC3 0x1B 1>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index 7c3be5e..f913dbe 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -442,6 +442,24 @@
 				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled int D */>;
 		};
 
+		MSI: ppc4xx-msi@400300000 {
+				compatible = "amcc,ppc4xx-msi", "ppc4xx-msi";
+				reg = < 0x4 0x00300000 0x100>;
+				sdr-base = <0x3B0>;
+				msi-data = <0x00000000>;
+				msi-mask = <0x44440000>;
+				interrupt-count = <3>;
+				interrupts =<0 1 2 3>;
+				interrupt-parent = <&UIC0>;
+				#interrupt-cells = <1>;
+				#address-cells = <0>;
+				#size-cells = <0>;
+				interrupt-map = <0 &UIC0 0xC 1
+					1 &UIC0 0x0D 1
+					2 &UIC0 0x0E 1
+					3 &UIC0 0x0F 1>;
+		};
+
 		I2O: i2o@400100000 {
 			compatible = "ibm,i2o-440spe";
 			reg = <0x00000004 0x00100000 0x100>;
diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index 083e68e..21e88f5 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -394,5 +394,33 @@
 				0x0 0x0 0x0 0x3 &UIC2 0xd 0x4 /* swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC2 0xe 0x4 /* swizzled int D */>;
 		};
+
+		MSI: ppc4xx-msi@C10000000 {
+			compatible = "amcc,ppc4xx-msi", "ppc4xx-msi";
+			reg = < 0x0 0xEF620000 0x100>;
+			sdr-base = <0x4B0>;
+			msi-data = <0x00000000>;
+			msi-mask = <0x44440000>;
+			interrupt-count = <12>;
+			interrupts = <0 1 2 3 4 5 6 7 8 9 0xA 0xB 0xC 0xD>;
+			interrupt-parent = <&UIC2>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = <0 &UIC2 0x10 1
+					1 &UIC2 0x11 1
+					2 &UIC2 0x12 1
+					2 &UIC2 0x13 1
+					2 &UIC2 0x14 1
+					2 &UIC2 0x15 1
+					2 &UIC2 0x16 1
+					2 &UIC2 0x17 1
+					2 &UIC2 0x18 1
+					2 &UIC2 0x19 1
+					2 &UIC2 0x1A 1
+					2 &UIC2 0x1B 1
+					2 &UIC2 0x1C 1
+					3 &UIC2 0x1D 1>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/redwood.dts b/arch/powerpc/boot/dts/redwood.dts
index 81636c0..d86a3a4 100644
--- a/arch/powerpc/boot/dts/redwood.dts
+++ b/arch/powerpc/boot/dts/redwood.dts
@@ -358,8 +358,28 @@
 				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled int D */>;
 		};
 
+		MSI: ppc4xx-msi@400300000 {
+				compatible = "amcc,ppc4xx-msi", "ppc4xx-msi";
+				reg = < 0x4 0x00300000 0x100
+					0x4 0x00300000 0x100>;
+				sdr-base = <0x3B0>;
+				msi-data = <0x00000000>;
+				msi-mask = <0x44440000>;
+				interrupt-count = <3>;
+				interrupts =<0 1 2 3>;
+				interrupt-parent = <&UIC0>;
+				#interrupt-cells = <1>;
+				#address-cells = <0>;
+				#size-cells = <0>;
+				interrupt-map = <0 &UIC0 0xC 1
+					1 &UIC0 0x0D 1
+					2 &UIC0 0x0E 1
+					3 &UIC0 0x0F 1>;
+		};
+
 	};
 
+
 	chosen {
 		linux,stdout-path = "/plb/opb/serial@ef600200";
 	};
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index b721764..92aeee6 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -57,6 +57,8 @@ config KILAUEA
 	select 405EX
 	select PPC40x_SIMPLE
 	select PPC4xx_PCI_EXPRESS
+	select PCI_MSI
+	select 4xx_MSI
 	help
 	  This option enables support for the AMCC PPC405EX evaluation board.
 
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 0f979c5..3836353 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -74,6 +74,8 @@ config KATMAI
 	select 440SPe
 	select PCI
 	select PPC4xx_PCI_EXPRESS
+	select PCI_MSI
+	select 4xx_MSI
 	help
 	  This option enables support for the AMCC PPC440SPe evaluation board.
 
@@ -119,6 +121,8 @@ config CANYONLANDS
 	select 460EX
 	select PCI
 	select PPC4xx_PCI_EXPRESS
+	select PCI_MSI
+	select 4xx_MSI
 	select IBM_NEW_EMAC_RGMII
 	select IBM_NEW_EMAC_ZMII
 	help
@@ -145,6 +149,8 @@ config REDWOOD
 	select 460SX
 	select PCI
 	select PPC4xx_PCI_EXPRESS
+	select PCI_MSI
+	select 4xx_MSI
 	help
 	  This option enables support for the AMCC PPC460SX Redwood board.
 
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 3965828..ec86000 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -7,6 +7,12 @@ config PPC4xx_PCI_EXPRESS
 	depends on PCI && 4xx
 	default n
 
+config 4xx_MSI
+	bool
+	depends on PCI_MSI
+	depends on PCI && 4xx
+	default n
+
 config PPC_MSI_BITMAP
 	bool
 	depends on PCI_MSI
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 0bef9da..30f4da4 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_XILINX_PCI)	+= xilinx_pci.o
 obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
+obj-$(CONFIG_4xx_MSI)		+= ppc4xx_msi.o
 endif
 obj-$(CONFIG_PPC4xx_GPIO)	+= ppc4xx_gpio.o
 
diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
new file mode 100644
index 0000000..9d5e0c9
--- /dev/null
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -0,0 +1,251 @@
+/*
+ * Adding PCI-E MSI support for PPC4XX SoCs.
+ *
+ * Copyright (c) 2010, Applied Micro Circuits Corporation
+ * Authors: 	Tirumala R Marri <tmarri@apm.com>
+ * 		Feng Kan <fkan@apm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+#include <linux/irq.h>
+#include <linux/bootmem.h>
+#include <linux/pci.h>
+#include <linux/msi.h>
+#include <linux/of_platform.h>
+#include <linux/interrupt.h>
+#include <asm/prom.h>
+#include <asm/hw_irq.h>
+#include <asm/ppc-pci.h>
+#include <boot/dcr.h>
+#include <asm/dcr-regs.h>
+#include <asm/msi_bitmap.h>
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
+#define  UPPER_4BITS_OF36BIT 32
+#define  LOWER_32BITS_OF36BIT 0xFFFFFFFF
+
+struct ppc4xx_msi {
+	u32 msi_addr_lo;
+	u32 msi_addr_hi;
+	void __iomem *msi_regs;
+	u32 feature;
+};
+
+static struct ppc4xx_msi *ppc4xx_msi;
+struct ppc4xx_msi_feature {
+	u32 ppc4xx_pic_ip;
+	u32 msiir_offset;
+};
+
+static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	struct msi_desc *entry;
+	unsigned int virq = 0;
+	struct msi_msg msg;
+	struct ppc4xx_msi *msi_data = ppc4xx_msi;
+	static int int_no = 0;	/* To remember last used interrupt */
+	struct device_node *msi_dev = NULL;
+	const u32 *count;
+
+	msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
+	if (msi_dev)
+		return -ENODEV;
+
+	count = of_get_property(msi_dev, "interrupt-count", NULL);
+	if (!count) {
+		dev_err(&dev->dev, "no interrupts property found \n");
+		return -ENODEV;
+	}
+
+	if (int_no > *count)
+		return -EINVAL;
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		virq = irq_of_parse_and_map(msi_dev, int_no);
+		printk("virq = 0x%x\n", virq);
+		if (virq == NO_IRQ) {
+			dev_err(&dev->dev, "%s: fail mapping irq\n", __func__);
+			return -EINVAL;
+		} else
+			set_irq_data(virq, (void *)int_no);
+
+		dev_dbg(&dev->dev, "%s: virq = %d \n", __func__, virq);
+
+		/* Setup msi address space */
+		msg.address_hi = msi_data->msi_addr_hi;
+		msg.address_lo = msi_data->msi_addr_lo;
+
+		set_irq_msi(virq, entry);
+		msg.data = int_no;
+		int_no++;
+		write_msi_msg(virq, &msg);
+	}
+
+	return 0;
+}
+
+void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
+{
+	struct msi_desc *entry;
+
+	dev_dbg(&dev->dev, "PCIE-MSI: tearing down msi irqs\n");
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		if (entry->irq == NO_IRQ)
+			continue;
+		set_irq_msi(entry->irq, NULL);
+		irq_dispose_mapping(entry->irq);
+	}
+
+	return;
+}
+
+static int ppc4xx_msi_check_device(struct pci_dev *pdev, int nvec, int type)
+{
+	dev_dbg(&pdev->dev, "PCIE-MSI:%s called. vec %x type %d\n",
+		__func__, nvec, type);
+	return 0;
+}
+
+static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
+				 struct resource res, struct ppc4xx_msi *msi)
+{
+	const u32 *msi_data;
+	const u32 *msi_mask;
+	const u32 *sdr_addr;
+	int rc = 0;
+	dma_addr_t msi_phys;
+	void *msi_virt;
+
+	sdr_addr = of_get_property(dev->dev.of_node, "sdr-base", NULL);
+	if (!sdr_addr)
+		return -1;
+
+	SDR0_WRITE(sdr_addr, (u64)res.start >> UPPER_4BITS_OF36BIT);	/*HIGH addr */
+	SDR0_WRITE(sdr_addr + 1, res.start & LOWER_32BITS_OF36BIT);	/* Low addr */
+
+	msi->msi_regs = ioremap((u64) res.start, res.end - res.start + 1);
+	if (!msi->msi_regs) {
+		dev_err(&dev->dev, "ioremap problem failed\n");
+		return ENOMEM;
+	}
+	dev_dbg(&dev->dev, "PCIE-MSI: msi register mapped 0x%x 0x%x\n",
+		(u32) (msi->msi_regs + PEIH_TERMADH), (u32) (msi->msi_regs));
+
+	msi_virt = dma_alloc_coherent(&dev->dev, 64, &msi_phys, GFP_KERNEL);
+	msi->msi_addr_hi = 0x0;
+	msi->msi_addr_lo = (u32) msi_phys;
+	dev_dbg(&dev->dev, "PCIE-MSI: msi address 0x%x \n", msi->msi_addr_lo);
+
+	/* Progam the Interrupt handler Termination addr registers */
+	out_be32(msi->msi_regs + PEIH_TERMADH, msi->msi_addr_hi);
+	out_be32(msi->msi_regs + PEIH_TERMADL, msi->msi_addr_lo);
+
+	msi_data = of_get_property(dev->dev.of_node, "msi-data", NULL);
+	if (!msi_data) {
+		rc = -1;
+		goto error_out;
+	}
+
+	msi_mask = of_get_property(dev->dev.of_node, "msi-mask", NULL);
+	if (!msi_mask) {
+		rc = -1;
+		goto error_out;
+	}
+
+	/* Program MSI Expected data and Mask bits */
+	out_be32(msi->msi_regs + PEIH_MSIED, 0);
+	out_be32(msi->msi_regs + PEIH_MSIMK, *msi_mask);
+
+	return 0;
+      error_out:
+	iounmap(msi->msi_regs);
+	return rc;
+}
+static int __devinit ppc4xx_msi_probe(struct platform_device *dev,
+				      const struct of_device_id *match)
+{
+	struct ppc4xx_msi *msi;
+	struct resource res;
+	int err = 0;
+
+	dev_dbg(&dev->dev, "PCIE-MSI: Setting up MSI support...\n");
+
+	msi = kzalloc(sizeof(struct ppc4xx_msi), GFP_KERNEL);
+	if (!msi) {
+		dev_err(&dev->dev, "No memory for MSI structure\n");
+		err = -ENOMEM;
+		goto error_out;
+	}
+	/* Get MSI ranges */
+	err = of_address_to_resource(dev->dev.of_node, 0, &res);
+	if (err) {
+		dev_err(&dev->dev, "%s resource error!\n",
+			dev->dev.of_node->full_name);
+		goto error_out;
+	}
+
+	if (ppc4xx_setup_pcieh_hw(dev, res, msi))
+		goto error_out;
+
+	ppc4xx_msi = msi;
+
+	WARN_ON(ppc_md.setup_msi_irqs);
+	ppc_md.setup_msi_irqs = ppc4xx_setup_msi_irqs;
+	ppc_md.teardown_msi_irqs = ppc4xx_teardown_msi_irqs;
+	ppc_md.msi_check_device = ppc4xx_msi_check_device;
+	return 0;
+
+      error_out:
+	kfree(msi);
+	return err;
+}
+static const struct ppc4xx_msi_feature ppc4xx_msi_feature = {
+	.ppc4xx_pic_ip = 0,
+	.msiir_offset = 0x140,
+};
+
+static const struct of_device_id ppc4xx_msi_ids[] = {
+	{
+	 .compatible = "amcc,ppc4xx-msi",
+	 .data = (void *)&ppc4xx_msi_feature,
+	 },
+	{}
+};
+
+static struct of_platform_driver ppc4xx_msi_driver = {
+	.driver = {
+		   .name = "ppc4xx-msi",
+		   .owner = THIS_MODULE,
+		   .of_match_table = ppc4xx_msi_ids,
+		   },
+	.probe = ppc4xx_msi_probe,
+};
+
+static __init int ppc4xx_msi_init(void)
+{
+	return of_register_platform_driver(&ppc4xx_msi_driver);
+}
+
+subsys_initcall(ppc4xx_msi_init);
-- 
1.6.1.rc3
