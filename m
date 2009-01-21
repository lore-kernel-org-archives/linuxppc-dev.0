Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.178])
	by ozlabs.org (Postfix) with ESMTP id 3140C474F9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 07:55:27 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id s27so300762ele.3
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 12:55:27 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 4/8] powerpc/5200: Add support for the Media5200 board from
	Freescale
To: linuxppc-dev@ozlabs.org
Date: Wed, 21 Jan 2009 13:55:24 -0700
Message-ID: <20090121205523.31232.83548.stgit@localhost.localdomain>
In-Reply-To: <20090121205506.31232.27908.stgit@localhost.localdomain>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch adds board support for the Media5200 platform.  Changes are:
- add the media5200 device tree
- add the media5200 platform support code and cascaded interrupt controller
- add media5200 to the build targets.

Note: this patch also includes a minor tweak to the lite5200(b) target
images list to add the .dtb files to the image list.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/Makefile              |    4 
 arch/powerpc/boot/dts/media5200.dts     |  318 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/Kconfig     |    5 
 arch/powerpc/platforms/52xx/Makefile    |    1 
 arch/powerpc/platforms/52xx/media5200.c |  273 +++++++++++++++++++++++++++
 5 files changed, 600 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/media5200.dts
 create mode 100644 arch/powerpc/platforms/52xx/media5200.c


diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e84df33..8244813 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -235,7 +235,9 @@ image-$(CONFIG_PPC_ADDER875)		+= cuImage.adder875-uboot \
 					   dtbImage.adder875-redboot
 
 # Board ports in arch/powerpc/platform/52xx/Kconfig
-image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200 cuImage.lite5200b
+image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200 lite5200.dtb
+image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200b lite5200b.dtb
+image-$(CONFIG_PPC_MEDIA5200)		+= cuImage.media5200 media5200.dtb
 
 # Board ports in arch/powerpc/platform/82xx/Kconfig
 image-$(CONFIG_MPC8272_ADS)		+= cuImage.mpc8272ads
diff --git a/arch/powerpc/boot/dts/media5200.dts b/arch/powerpc/boot/dts/media5200.dts
new file mode 100644
index 0000000..5bd74ad
--- /dev/null
+++ b/arch/powerpc/boot/dts/media5200.dts
@@ -0,0 +1,318 @@
+/*
+ * Freescale Media5200 board Device Tree Source
+ *
+ * Copyright 2009 Secret Lab Technologies Ltd.
+ * Grant Likely <grant.likely@secretlab.ca>
+ * Steven Cavanagh <scavanagh@secretlab.ca>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "fsl,media5200";
+	compatible = "fsl,media5200";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&mpc5200_pic>;
+
+	aliases {
+		console = &console;
+		ethernet0 = &eth0;
+	};
+
+	chosen {
+		linux,stdout-path = &console;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,5200@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x4000>;		// L1, 16K
+			i-cache-size = <0x4000>;		// L1, 16K
+			timebase-frequency = <33000000>;	// 33 MHz, these were configured by U-Boot
+			bus-frequency = <132000000>;		// 132 MHz
+			clock-frequency = <396000000>;		// 396 MHz
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x08000000>;	// 128MB RAM
+	};
+
+	soc@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc5200b-immr";
+		ranges = <0 0xf0000000 0x0000c000>;
+		reg = <0xf0000000 0x00000100>;
+		bus-frequency = <132000000>;// 132 MHz 
+		system-frequency = <0>;		// from bootloader
+
+		cdm@200 {
+			compatible = "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
+			reg = <0x200 0x38>;
+		};
+
+		mpc5200_pic: interrupt-controller@500 {
+			// 5200 interrupts are encoded into two levels;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
+			reg = <0x500 0x80>;
+		};
+
+		timer@600 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <0x600 0x10>;
+			interrupts = <1 9 0>;
+			fsl,has-wdt;
+		};
+
+		timer@610 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <0x610 0x10>;
+			interrupts = <1 10 0>;
+		};
+
+		timer@620 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <0x620 0x10>;
+			interrupts = <1 11 0>;
+		};
+
+		timer@630 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <0x630 0x10>;
+			interrupts = <1 12 0>;
+		};
+
+		timer@640 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <0x640 0x10>;
+			interrupts = <1 13 0>;
+		};
+
+		timer@650 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <0x650 0x10>;
+			interrupts = <1 14 0>;
+		};
+
+		timer@660 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <0x660 0x10>;
+			interrupts = <1 15 0>;
+		};
+
+		timer@670 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <0x670 0x10>;
+			interrupts = <1 16 0>;
+		};
+
+		rtc@800 {	// Real time clock
+			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
+			reg = <0x800 0x100>;
+			interrupts = <1 5 0 1 6 0>;
+		};
+
+		can@900 {
+			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
+			interrupts = <2 17 0>;
+			reg = <0x900 0x80>;
+		};
+
+		can@980 {
+			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
+			interrupts = <2 18 0>;
+			reg = <0x980 0x80>;
+		};
+
+		gpio_simple: gpio@b00 {
+			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
+			reg = <0xb00 0x40>;
+			interrupts = <1 7 0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpio_wkup: gpio@c00 {
+			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
+			reg = <0xc00 0x40>;
+			interrupts = <1 8 0 0 3 0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		spi@f00 {
+			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
+			reg = <0xf00 0x20>;
+			interrupts = <2 13 0 2 14 0>;
+		};
+
+		usb@1000 {
+			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
+			reg = <0x1000 0x100>;
+			interrupts = <2 6 0>;
+		};
+
+		dma-controller@1200 {
+			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
+			reg = <0x1200 0x80>;
+			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
+			              3 4 0  3 5 0  3 6 0  3 7 0
+			              3 8 0  3 9 0  3 10 0  3 11 0
+			              3 12 0  3 13 0  3 14 0  3 15 0>;
+		};
+
+		xlb@1f00 {
+			compatible = "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
+			reg = <0x1f00 0x100>;
+		};
+
+		// PSC6 in uart mode
+		console: serial@2c00 {		// PSC6
+			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			cell-index = <5>;
+			port-number = <0>;  // Logical port assignment
+			reg = <0x2c00 0x100>;
+			interrupts = <2 4 0>;
+		};
+
+		eth0: ethernet@3000 {
+			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
+			reg = <0x3000 0x400>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <2 5 0>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
+			reg = <0x3000 0x400>;	// fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
+
+			phy0: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		ata@3a00 {
+			compatible = "fsl,mpc5200b-ata","fsl,mpc5200-ata";
+			reg = <0x3a00 0x100>;
+			interrupts = <2 7 0>;
+		};
+
+		i2c@3d00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
+			reg = <0x3d00 0x40>;
+			interrupts = <2 15 0>;
+			fsl5200-clocking;
+		};
+
+		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
+			reg = <0x3d40 0x40>;
+			interrupts = <2 16 0>;
+			fsl5200-clocking;
+		};
+
+		sram@8000 {
+			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram";
+			reg = <0x8000 0x4000>;
+		};
+	};
+
+	pci@f0000d00 {
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		compatible = "fsl,mpc5200b-pci","fsl,mpc5200-pci";
+		reg = <0xf0000d00 0x100>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0xc000 0 0 1 &media5200_fpga 0 2 // 1st slot
+				 0xc000 0 0 2 &media5200_fpga 0 3
+				 0xc000 0 0 3 &media5200_fpga 0 4
+				 0xc000 0 0 4 &media5200_fpga 0 5
+
+				 0xc800 0 0 1 &media5200_fpga 0 3 // 2nd slot
+				 0xc800 0 0 2 &media5200_fpga 0 4
+				 0xc800 0 0 3 &media5200_fpga 0 5
+				 0xc800 0 0 4 &media5200_fpga 0 2
+
+				 0xd000 0 0 1 &media5200_fpga 0 4 // miniPCI
+				 0xd000 0 0 2 &media5200_fpga 0 5
+
+				 0xe000 0 0 1 &media5200_fpga 0 5 // CoralIP
+				>;
+		clock-frequency = <0>; // From boot loader
+		interrupts = <2 8 0 2 9 0 2 10 0>;
+		interrupt-parent = <&mpc5200_pic>;
+		bus-range = <0 0>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
+			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
+	};
+
+	localbus {
+		compatible = "fsl,mpc5200b-lpb","simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		ranges = < 0 0 0xfc000000 0x02000000
+			   1 0 0xfe000000 0x02000000
+			   2 0 0xf0010000 0x00010000
+			   3 0 0xf0020000 0x00010000 >;
+
+		flash@0,0 {
+			compatible = "amd,am29lv28ml", "cfi-flash";
+			reg = <0 0x0 0x2000000>;		// 32 MB
+			bank-width = <4>;			// Width in bytes of the flash bank
+			device-width = <2>;			// Two devices on each bank
+		};
+
+		flash@1,0 {
+			compatible = "amd,am29lv28ml", "cfi-flash";
+			reg = <1 0 0x2000000>;			// 32 MB
+			bank-width = <4>;			// Width in bytes of the flash bank
+			device-width = <2>;			// Two devices on each bank
+		};
+
+		media5200_fpga: fpga@2,0 {
+			compatible = "fsl,media5200-fpga";
+			interrupt-controller;
+			#interrupt-cells = <2>;	// 0:bank 1:id; no type field
+			reg = <2 0 0x10000>;
+
+			interrupt-parent = <&mpc5200_pic>;
+			interrupts = <0 0 3	// IRQ bank 0
+			              1 1 3>;	// IRQ bank 1
+		};
+
+		uart@3,0 {
+			compatible = "ti,tl16c752bpt";
+			reg = <3 0 0x10000>;
+			interrupt-parent = <&media5200_fpga>;
+			interrupts = <0 0  0 1>; // 2 irqs
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 696a5ee..c01db13 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -35,6 +35,11 @@ config PPC_LITE5200
 	depends on PPC_MPC52xx
 	select DEFAULT_UIMAGE
 
+config PPC_MEDIA5200
+	bool "Freescale Media5200 Eval Board"
+	depends on PPC_MPC52xx
+	select DEFAULT_UIMAGE
+
 config PPC_MPC5200_BUGFIX
 	bool "MPC5200 (L25R) bugfix support"
 	depends on PPC_MPC52xx
diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
index b8a5206..9dfbde2 100644
--- a/arch/powerpc/platforms/52xx/Makefile
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PCI)		+= mpc52xx_pci.o
 obj-$(CONFIG_PPC_MPC5200_SIMPLE) += mpc5200_simple.o
 obj-$(CONFIG_PPC_EFIKA)		+= efika.o
 obj-$(CONFIG_PPC_LITE5200)	+= lite5200.o
+obj-$(CONFIG_PPC_MEDIA5200)	+= media5200.o
 
 obj-$(CONFIG_PM)		+= mpc52xx_sleep.o mpc52xx_pm.o
 ifeq ($(CONFIG_PPC_LITE5200),y)
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
new file mode 100644
index 0000000..68e4f16
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -0,0 +1,273 @@
+/*
+ * Support for 'media5200-platform' compatible boards.
+ *
+ * Copyright (C) 2008 Secret Lab Technologies Ltd.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Description:
+ * This code implements support for the Freescape Media5200 platform
+ * (built around the MPC5200 SoC).
+ *
+ * Notable characteristic of the Media5200 is the presence of an FPGA
+ * that has all external IRQ lines routed through it.  This file implements
+ * a cascaded interrupt controller driver which attaches itself to the
+ * Virtual IRQ subsystem after the primary mpc5200 interrupt controller
+ * is initialized.
+ *
+ */
+
+#undef DEBUG
+
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <asm/time.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/mpc52xx.h>
+
+static struct of_device_id mpc5200_gpio_ids[] __initdata = {
+	{ .compatible = "fsl,mpc5200-gpio", },
+	{ .compatible = "mpc5200-gpio", },
+	{}
+};
+
+/* FPGA register set */
+#define MEDIA5200_IRQ_ENABLE (0x40c)
+#define MEDIA5200_IRQ_STATUS (0x410)
+#define MEDIA5200_NUM_IRQS   (6)
+#define MEDIA5200_IRQ_SHIFT  (32 - MEDIA5200_NUM_IRQS)
+
+struct media5200_irq {
+	void __iomem *regs;
+	spinlock_t lock;
+	struct irq_host *irqhost;
+};
+struct media5200_irq media5200_irq;
+
+static void media5200_irq_unmask(unsigned int virq)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&media5200_irq.lock, flags);
+	val = in_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE);
+	val |= 1 << (MEDIA5200_IRQ_SHIFT + irq_map[virq].hwirq);
+	out_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE, val);
+	spin_unlock_irqrestore(&media5200_irq.lock, flags);
+}
+
+static void media5200_irq_mask(unsigned int virq)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&media5200_irq.lock, flags);
+	val = in_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE);
+	val &= ~(1 << (MEDIA5200_IRQ_SHIFT + irq_map[virq].hwirq));
+	out_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE, val);
+	spin_unlock_irqrestore(&media5200_irq.lock, flags);
+}
+
+static struct irq_chip media5200_irq_chip = {
+	.typename = "Media5200 FPGA",
+	.unmask = media5200_irq_unmask,
+	.mask = media5200_irq_mask,
+	.mask_ack = media5200_irq_mask,
+};
+
+void media5200_irq_cascade(unsigned int virq, struct irq_desc *desc)
+{
+	int sub_virq, val;
+	u32 status, enable;
+
+	/* Mask off the cascaded IRQ */
+	spin_lock(&desc->lock);
+	desc->chip->mask(virq);
+	spin_unlock(&desc->lock);
+
+	/* Ask the FPGA for IRQ status.  If 'val' is 0, then no irqs
+	 * are pending.  'ffs()' is 1 based */
+	status = in_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE);
+	enable = in_be32(media5200_irq.regs + MEDIA5200_IRQ_STATUS);
+	val = ffs((status & enable) >> MEDIA5200_IRQ_SHIFT);
+	if (val) {
+		sub_virq = irq_linear_revmap(media5200_irq.irqhost, val - 1);
+		/* pr_debug("%s: virq=%i s=%.8x e=%.8x hwirq=%i subvirq=%i\n",
+		 *          __func__, virq, status, enable, val - 1, sub_virq);
+		 */
+		generic_handle_irq(sub_virq);
+	}
+
+	/* Processing done; can reenable the cascade now */
+	spin_lock(&desc->lock);
+	desc->chip->ack(virq);
+	if (!(desc->status & IRQ_DISABLED))
+		desc->chip->unmask(virq);
+	spin_unlock(&desc->lock);
+}
+
+static int media5200_irq_map(struct irq_host *h, unsigned int virq,
+			     irq_hw_number_t hw)
+{
+	struct irq_desc *desc = get_irq_desc(virq);
+
+	pr_debug("%s: h=%p, virq=%i, hwirq=%i\n", __func__, h, virq, (int)hw);
+	set_irq_chip_data(virq, &media5200_irq);
+	set_irq_chip_and_handler(virq, &media5200_irq_chip, handle_level_irq);
+	set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
+	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
+	desc->status |= IRQ_TYPE_LEVEL_LOW | IRQ_LEVEL;
+
+	return 0;
+}
+
+static int media5200_irq_xlate(struct irq_host *h, struct device_node *ct,
+				 u32 *intspec, unsigned int intsize,
+				 irq_hw_number_t *out_hwirq,
+				 unsigned int *out_flags)
+{
+	if (intsize != 2)
+		return -1;
+
+	pr_debug("%s: bank=%i, number=%i\n", __func__, intspec[0], intspec[1]);
+	*out_hwirq = intspec[1];
+	*out_flags = IRQ_TYPE_NONE;
+	return 0;
+}
+
+static struct irq_host_ops media5200_irq_ops = {
+	.map = media5200_irq_map,
+	.xlate = media5200_irq_xlate,
+};
+
+/*
+ * Setup Media5200 IRQ mapping
+ */
+static void __init media5200_init_irq(void)
+{
+	struct device_node *fpga_np;
+	int cascade_virq;
+
+	/* First setup the regular MPC5200 interrupt controller */
+	mpc52xx_init_irq();
+
+	/* Now find the FPGA IRQ */
+	fpga_np = of_find_compatible_node(NULL, NULL, "fsl,media5200-fpga");
+	if (!fpga_np)
+		goto out;
+	pr_debug("%s: found fpga node: %s\n", __func__, fpga_np->full_name);
+
+	media5200_irq.regs = of_iomap(fpga_np, 0);
+	if (!media5200_irq.regs)
+		goto out;
+	pr_debug("%s: mapped to %p\n", __func__, media5200_irq.regs);
+
+	cascade_virq = irq_of_parse_and_map(fpga_np, 0);
+	if (!cascade_virq)
+		goto out;
+	pr_debug("%s: cascaded on virq=%i\n", __func__, cascade_virq);
+
+	/* Disable all FPGA IRQs */
+	out_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE, 0);
+
+	spin_lock_init(&media5200_irq.lock);
+
+	media5200_irq.irqhost = irq_alloc_host(fpga_np, IRQ_HOST_MAP_LINEAR,
+					       MEDIA5200_NUM_IRQS,
+					       &media5200_irq_ops, -1);
+	if (!media5200_irq.irqhost)
+		goto out;
+	pr_debug("%s: allocated irqhost\n", __func__);
+
+	media5200_irq.irqhost->host_data = &media5200_irq;
+
+	set_irq_data(cascade_virq, &media5200_irq);
+	set_irq_chained_handler(cascade_virq, media5200_irq_cascade);
+
+	return;
+
+ out:
+	pr_err("Could not find Media5200 FPGA; PCI interrupts will not work\n");
+}
+
+/*
+ * Setup the architecture
+ */
+static void __init media5200_setup_arch(void)
+{
+
+	struct device_node *np;
+	struct mpc52xx_gpio __iomem *gpio;
+	u32 port_config;
+
+	if (ppc_md.progress)
+		ppc_md.progress("media5200_setup_arch()", 0);
+
+	/* Map important registers from the internal memory map */
+	mpc52xx_map_common_devices();
+
+	/* Some mpc5200 & mpc5200b related configuration */
+	mpc5200_setup_xlb_arbiter();
+
+	mpc52xx_setup_pci();
+
+	np = of_find_matching_node(NULL, mpc5200_gpio_ids);
+	gpio = of_iomap(np, 0);
+	of_node_put(np);
+	if (!gpio) {
+		printk(KERN_ERR "%s() failed. expect abnormal behavior\n",
+		       __func__);
+		return;
+	}
+
+	/* Set port config */
+	port_config = in_be32(&gpio->port_config);
+
+	port_config &= ~0x03000000;	/* ATA CS is on csb_4/5		*/
+	port_config |=  0x01000000;
+
+	out_be32(&gpio->port_config, port_config);
+
+	/* Unmap zone */
+	iounmap(gpio);
+
+}
+
+/* list of the supported boards */
+static char *board[] __initdata = {
+	"fsl,media5200",
+	NULL
+};
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init media5200_probe(void)
+{
+	unsigned long node = of_get_flat_dt_root();
+	int i = 0;
+
+	while (board[i]) {
+		if (of_flat_dt_is_compatible(node, board[i]))
+			break;
+		i++;
+	}
+
+	return (board[i] != NULL);
+}
+
+define_machine(media5200_platform) {
+	.name		= "media5200-platform",
+	.probe		= media5200_probe,
+	.setup_arch	= media5200_setup_arch,
+	.init		= mpc52xx_declare_of_platform_devices,
+	.init_IRQ	= media5200_init_irq,
+	.get_irq	= mpc52xx_get_irq,
+	.restart	= mpc52xx_restart,
+	.calibrate_decr	= generic_calibrate_decr,
+};
