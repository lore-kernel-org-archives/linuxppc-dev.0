Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id 859E72C0375
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Nov 2013 13:08:54 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: benh@kernel.crashing.org
Subject: =?UTF-8?q?=5BPATCH=208/8=5D=20powerpc=3A=20Added=20PCI=20MSI=20support=20using=20the=20HSTA=20module?=
Date: Fri, 22 Nov 2013 13:08:36 +1100
Message-Id: <1385086116-10972-8-git-send-email-alistair@popple.id.au>
In-Reply-To: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PPC476GTR SoC supports message signalled interrupts (MSI) by writing
to special addresses within the High Speed Transfer Assist (HSTA) module.

This patch adds support for PCI MSI with a new system device. The DMA
window is also updated to allow access to the entire 42-bit address range
to allow PCI devices write access to the HSTA module.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/boot/dts/akebono.dts     |   46 +++++-
 arch/powerpc/platforms/44x/Kconfig    |    2 +
 arch/powerpc/sysdev/Kconfig           |    6 +
 arch/powerpc/sysdev/Makefile          |    1 +
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c |  266 +++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.c      |    8 +-
 6 files changed, 319 insertions(+), 10 deletions(-)
 create mode 100644 arch/powerpc/sysdev/ppc4xx_hsta_msi.c

diff --git a/arch/powerpc/boot/dts/akebono.dts b/arch/powerpc/boot/dts/akebono.dts
index 6dd47e9..4cb917f 100644
--- a/arch/powerpc/boot/dts/akebono.dts
+++ b/arch/powerpc/boot/dts/akebono.dts
@@ -82,6 +82,28 @@
 		ranges;
 		clock-frequency = <200000000>; // 200Mhz
 
+		HSTA0: hsta@310000e0000 {
+			compatible = "ibm,476gtr-hsta-msi", "ibm,hsta-msi";
+			reg = <0x310 0x000e0000 0x0 0xf0>;
+			interrupt-parent = <&MPIC>;
+			interrupts = <108 0
+				      109 0
+				      110 0
+				      111 0
+				      112 0
+				      113 0
+				      114 0
+				      115 0
+				      116 0
+				      117 0
+				      118 0
+				      119 0
+				      120 0
+				      121 0
+				      122 0
+				      123 0>;
+		};
+
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-476gtr", "ibm,mcmal2";
 			dcr-reg = <0xc0000000 0x062>;
@@ -242,8 +264,10 @@
 			ranges = <0x02000000 0x00000000 0x80000000 0x00000110 0x80000000 0x0 0x80000000
 			          0x01000000 0x0        0x0        0x00000140 0x0        0x0 0x00010000>;
 
-			/* Inbound starting at 0 to memsize filled in by zImage */
-			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x0>;
+			/* Inbound starting at 0x0 to 0x40000000000. In order to use MSI
+			 * PCI devices must be able to write to the HSTA module.
+			 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x400 0x0>;
 
 			/* This drives busses 0 to 0xf */
 			bus-range = <0x0 0xf>;
@@ -280,8 +304,10 @@
 			ranges = <0x02000000 0x00000000 0x80000000 0x00000210 0x80000000 0x0 0x80000000
 			          0x01000000 0x0        0x0        0x00000240 0x0        0x0 0x00010000>;
 
-			/* Inbound starting at 0 to memsize filled in by zImage */
-			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x0>;
+			/* Inbound starting at 0x0 to 0x40000000000. In order to use MSI
+			 * PCI devices must be able to write to the HSTA module.
+			 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x400 0x0>;
 
 			/* This drives busses 0 to 0xf */
 			bus-range = <0x0 0xf>;
@@ -318,8 +344,10 @@
 			ranges = <0x02000000 0x00000000 0x80000000 0x00000190 0x80000000 0x0 0x80000000
 			          0x01000000 0x0        0x0        0x000001c0 0x0        0x0 0x00010000>;
 
-			/* Inbound starting at 0 to memsize filled in by zImage */
-			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x0>;
+			/* Inbound starting at 0x0 to 0x40000000000. In order to use MSI
+			 * PCI devices must be able to write to the HSTA module.
+			 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x400 0x0>;
 
 			/* This drives busses 0 to 0xf */
 			bus-range = <0x0 0xf>;
@@ -356,8 +384,10 @@
 			ranges = <0x02000000 0x00000000 0x80000000 0x00000290 0x80000000 0x0 0x80000000
 			          0x01000000 0x0        0x0        0x000002c0 0x0        0x0 0x00010000>;
 
-			/* Inbound starting at 0 to memsize filled in by zImage */
-			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x0>;
+			/* Inbound starting at 0x0 to 0x40000000000. In order to use MSI
+			 * PCI devices must be able to write to the HSTA module.
+			 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x400 0x0>;
 
 			/* This drives busses 0 to 0xf */
 			bus-range = <0x0 0xf>;
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 9d20800..7bc993e 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -206,6 +206,8 @@ config AKEBONO
 	select SWIOTLB
 	select 476
 	select PPC4xx_PCI_EXPRESS
+	select PCI_MSI
+	select PPC4xx_HSTA_MSI
 	select I2C
 	select I2C_IBM_IIC
 	select NETDEVICES
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index ab4cb54..d3d91ca 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -7,6 +7,12 @@ config PPC4xx_PCI_EXPRESS
 	depends on PCI && 4xx
 	default n
 
+config PPC4xx_HSTA_MSI
+	bool
+	depends on PCI_MSI
+	depends on PCI && 4xx
+	default n
+
 config PPC4xx_MSI
 	bool
 	depends on PCI_MSI
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index f67ac90..7657fb7 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
 endif
+obj-$(CONFIG_PPC4xx_HSTA_MSI)	+= ppc4xx_hsta_msi.o
 obj-$(CONFIG_PPC4xx_MSI)	+= ppc4xx_msi.o
 obj-$(CONFIG_PPC4xx_CPM)	+= ppc4xx_cpm.o
 obj-$(CONFIG_PPC4xx_GPIO)	+= ppc4xx_gpio.o
diff --git a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
new file mode 100644
index 0000000..dac3f3b
--- /dev/null
+++ b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
@@ -0,0 +1,266 @@
+/*
+ * MSI support for PPC4xx SoCs using High Speed Transfer Assist (HSTA) for
+ * generation of the interrupt.
+ *
+ * Copyright © 2013 Alistair Popple <alistair@popple.id.au> IBM Corporation
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/semaphore.h>
+#include <asm/msi_bitmap.h>
+
+/*
+ * If TEST_IRQ is defined the driver will test that all MSI interrupts
+ * can be generated by writing to the HSTA module from the CPU before
+ * allowing MSI to be used. This increases system boot time and is
+ * only needed to test correct operation of the HSTA so it isn't
+ * enabled by default.
+ */
+#undef TEST_IRQ
+
+struct ppc4xx_hsta_msi {
+	struct device *dev;
+
+	/* The ioremapped HSTA MSI IO space */
+	u32 __iomem *data;
+
+	/* Physical address of HSTA MSI IO space */
+	u64 address;
+	struct msi_bitmap bmp;
+
+	/* An array mapping offsets to hardware IRQs */
+	int *irq_map;
+
+#ifdef TEST_IRQ
+	struct semaphore sem;
+#endif
+};
+static struct ppc4xx_hsta_msi ppc4xx_hsta_msi;
+
+#ifdef TEST_IRQ
+static irqreturn_t hsta_test_msi_irq(int irq, void *data)
+{
+	pr_debug("HSTA MSI: Got test irq %d\n", irq);
+	up(&ppc4xx_hsta_msi.sem);
+	return IRQ_HANDLED;
+}
+#endif
+
+static int hsta_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	struct msi_msg msg;
+	struct msi_desc *entry;
+	int irq, hwirq;
+	u64 addr;
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		irq = msi_bitmap_alloc_hwirqs(&ppc4xx_hsta_msi.bmp, 1);
+		if (irq < 0) {
+			pr_debug("%s: Failed to allocate msi interrupt\n",
+				 __func__);
+			return irq;
+		}
+
+		hwirq = ppc4xx_hsta_msi.irq_map[irq];
+		if (hwirq == NO_IRQ) {
+			pr_err("%s: Failed mapping irq %d\n", __func__, irq);
+			return -EINVAL;
+		}
+
+		/*
+		 * HSTA generates interrupts on writes to 128-bit aligned
+		 * addresses.
+		 */
+		addr = ppc4xx_hsta_msi.address + irq*0x10;
+		msg.address_hi = upper_32_bits(addr);
+		msg.address_lo = lower_32_bits(addr);
+
+		/* Data is not used by the HSTA. */
+		msg.data = 0;
+
+		pr_debug("%s: Setup irq %d (0x%0llx)\n", __func__, hwirq,
+			 (((u64) msg.address_hi) << 32) | msg.address_lo);
+
+		if (irq_set_msi_desc(hwirq, entry)) {
+			pr_err(
+			"%s: Invalid hwirq %d specified in device tree\n",
+			__func__, hwirq);
+			msi_bitmap_free_hwirqs(&ppc4xx_hsta_msi.bmp, irq, 1);
+			return -EINVAL;
+		}
+		write_msi_msg(hwirq, &msg);
+	}
+
+	return 0;
+}
+
+static int hsta_find_hwirq_offset(int hwirq)
+{
+	int irq;
+
+	/* Find the offset given the hwirq */
+	for (irq = 0; ppc4xx_hsta_msi.irq_map[irq] != hwirq;
+	     irq++)
+		;
+
+	if (ppc4xx_hsta_msi.irq_map[irq] != hwirq)
+		irq = -EINVAL;
+
+	return irq;
+}
+
+static void hsta_teardown_msi_irqs(struct pci_dev *dev)
+{
+	struct msi_desc *entry;
+	int irq;
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		if (entry->irq == NO_IRQ)
+			continue;
+
+		irq = hsta_find_hwirq_offset(entry->irq);
+
+		/* entry->irq should always be in irq_map */
+		BUG_ON(irq < 0);
+		irq_set_msi_desc(entry->irq, NULL);
+		msi_bitmap_free_hwirqs(&ppc4xx_hsta_msi.bmp, irq, 1);
+		pr_debug("%s: Teardown IRQ %u (index %u)\n", __func__,
+			 entry->irq, irq);
+	}
+}
+
+static int hsta_msi_check_device(struct pci_dev *pdev, int nvec, int type)
+{
+	/* We don't support MSI-X */
+	if (type == PCI_CAP_ID_MSIX) {
+		pr_debug("%s: MSI-X not supported.\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hsta_msi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *mem;
+	int irq, ret, irq_count;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (IS_ERR(mem)) {
+		dev_err(dev, "Unable to get mmio space\n");
+		return -EINVAL;
+	}
+
+	irq_count = of_irq_count(dev->of_node);
+	if (!irq_count) {
+		dev_err(dev, "Unable to find IRQ range\n");
+		return -EINVAL;
+	}
+
+	ppc4xx_hsta_msi.dev = dev;
+	ppc4xx_hsta_msi.address = mem->start;
+	ppc4xx_hsta_msi.data = ioremap(mem->start, resource_size(mem));
+	if (IS_ERR(ppc4xx_hsta_msi.data)) {
+		dev_err(dev, "Unable to map memory\n");
+		return -ENOMEM;
+	}
+
+	ret = msi_bitmap_alloc(&ppc4xx_hsta_msi.bmp, irq_count, dev->of_node);
+	if (ret)
+		goto out;
+
+	ppc4xx_hsta_msi.irq_map = kmalloc(sizeof(int) * irq_count, GFP_KERNEL);
+	if (IS_ERR(ppc4xx_hsta_msi.irq_map)) {
+		ret = -ENOMEM;
+		goto out1;
+	}
+
+	/* Setup a mapping from irq offsets to hardware irq numbers */
+	for (irq = 0; irq < irq_count; irq++) {
+		ppc4xx_hsta_msi.irq_map[irq] =
+			irq_of_parse_and_map(dev->of_node, irq);
+		if (ppc4xx_hsta_msi.irq_map[irq] == NO_IRQ) {
+			dev_err(dev, "Unable to map IRQ\n");
+			ret = -EINVAL;
+			goto out2;
+		}
+	}
+
+#ifdef TEST_IRQ
+	/* Test generation of MSI interrupts */
+	semaphore_init(&ppc4xx_hsta_msi.sem, 0);
+	pr_info("HSTA MSI: Testing irq generation.\n");
+	for (irq = 0; irq < irq_count; irq++) {
+		int hwirq = ppc4xx_hsta_msi.irq_map[irq];
+		ret = request_irq(hwirq, hsta_test_msi_irq, 0,
+				"hsta-test-msi-irq", NULL);
+		if (ret) {
+			pr_err("HSTA MSI: Can't get interrupt %d.\n", hwirq);
+			goto out2;
+		}
+
+		/*
+		 * Interrupts are generated by writes to the HSTA memory space
+		 * at 128-bit aligned offsets.
+		 */
+		ppc4xx_hsta_msi.data[irq*4] = 0x0;
+		if (down_timeout(&ppc4xx_hsta_msi.sem, 0.5 * HZ)) {
+			pr_err("HSTA MSI: Timeout waiting for interrupt %d.\n",
+				hwirq);
+			ret = -ETIME;
+			free_irq(hwirq, NULL);
+			goto out2;
+		}
+		free_irq(hwirq, NULL);
+	}
+	pr_info("HSTA MSI: Irq test completed successfully.\n");
+#endif
+
+	ppc_md.setup_msi_irqs = hsta_setup_msi_irqs;
+	ppc_md.teardown_msi_irqs = hsta_teardown_msi_irqs;
+	ppc_md.msi_check_device = hsta_msi_check_device;
+	return 0;
+
+out2:
+	kfree(ppc4xx_hsta_msi.irq_map);
+
+out1:
+	msi_bitmap_free(&ppc4xx_hsta_msi.bmp);
+
+out:
+	iounmap(ppc4xx_hsta_msi.data);
+	return ret;
+}
+
+static const struct of_device_id hsta_msi_ids[] = {
+	{
+		.compatible = "ibm,hsta-msi",
+	},
+	{}
+};
+
+static struct platform_driver hsta_msi_driver = {
+	.probe = hsta_msi_probe,
+	.driver = {
+		.name = "hsta-msi",
+		.owner = THIS_MODULE,
+		.of_match_table = hsta_msi_ids,
+	},
+};
+
+static int hsta_msi_init(void)
+{
+	return platform_driver_register(&hsta_msi_driver);
+}
+subsys_initcall(hsta_msi_init);
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 771a0ba..fad9031 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -176,8 +176,12 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_controller *hose,
 		return -ENXIO;
 	}
 
-	/* Check that we are fully contained within 32 bits space */
-	if (res->end > 0xffffffff) {
+	/* Check that we are fully contained within 32 bits space if we are not
+	 * running on a 460sx or 476fpe which have 64 bit bus addresses.
+	 */
+	if (res->end > 0xffffffff &&
+	    !(of_device_is_compatible(hose->dn, "ibm,plb-pciex-460sx")
+	      || of_device_is_compatible(hose->dn, "ibm,plb-pciex-476fpe"))) {
 		printk(KERN_ERR "%s: dma-ranges outside of 32 bits space\n",
 		       hose->dn->full_name);
 		return -ENXIO;
-- 
1.7.10.4
