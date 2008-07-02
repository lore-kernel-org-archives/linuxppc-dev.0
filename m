Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8036DDE070
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 17:19:38 +1000 (EST)
Date: Wed, 2 Jul 2008 02:19:25 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] powerpc/85xx: Add support for MPC8536DS
In-Reply-To: <20080702170814.de282293.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0807020218560.25690@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0807020201030.24791@blarg.am.freescale.net>
	<20080702170814.de282293.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support for the MPC8536 process and MPC8536DS reference board.  The
MPC8536 is an e500v2 based SoC which eTSEC, USB, SATA, PCI, and PCIe.

The USB and SATA IP blocks are similiar to those on the PQ2 Pro SoCs and
thus use the same drivers.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Fixed issues pointed out by sfr:
* removed unncessary initialization
* fixed OF reference count issue w/mpic
* maked of_device_ids as __initdata.

- k

 arch/powerpc/boot/dts/mpc8536ds.dts       |  420 ++++++++
 arch/powerpc/configs/mpc8536_ds_defconfig | 1637 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig       |    6 +
 arch/powerpc/platforms/85xx/Makefile      |    1 +
 arch/powerpc/platforms/85xx/mpc8536_ds.c  |  125 +++
 arch/powerpc/sysdev/fsl_pci.c             |    2 +
 include/linux/pci_ids.h                   |    2 +
 7 files changed, 2193 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8536ds.dts
 create mode 100644 arch/powerpc/configs/mpc8536_ds_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/mpc8536_ds.c

diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
new file mode 100644
index 0000000..98ad27a
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -0,0 +1,420 @@
+/*
+ * MPC8536 DS Device Tree Source
+ *
+ * Copyright 2008 Freescale Semiconductor, Inc.
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
+	model = "fsl,mpc8536ds";
+	compatible = "fsl,mpc8536ds";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+		pci3 = &pci3;
+	};
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8536@0 {
+			device_type = "cpu";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 00000000>;	// Filled by U-Boot
+	};
+
+	soc@ffe00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x0 0xffe00000 0x100000>;
+		reg = <0xffe00000 0x1000>;
+		bus-frequency = <0>;		// Filled out by uboot.
+
+		memory-controller@2000 {
+			compatible = "fsl,mpc8536-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 0x2>;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,mpc8536-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <16 0x2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+			rtc@68 {
+				compatible = "dallas,ds3232";
+				reg = <0x68>;
+			};
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8536-dma", "fsl,eloplus-dma";
+			reg = <0x21300 4>;
+			ranges = <0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8536-dma-channel",
+					     "fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <14 0x2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8536-dma-channel",
+					     "fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <15 0x2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8536-dma-channel",
+					     "fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <16 0x2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8536-dma-channel",
+					     "fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <17 0x2>;
+			};
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <10 0x1>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <10 0x1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		usb@22000 {
+			compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
+			reg = <0x22000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&mpic>;
+			interrupts = <28 0x2>;
+			phy_type = "ulpi";
+		};
+
+		usb@23000 {
+			compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
+			reg = <0x23000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&mpic>;
+			interrupts = <46 0x2>;
+			phy_type = "ulpi";
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		enet1: ethernet@26000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <31 2 32 2 33 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		usb@2b000 {
+			compatible = "fsl,mpc8536-usb2-dr", "fsl-usb2-dr";
+			reg = <0x2b000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&mpic>;
+			interrupts = <60 0x2>;
+			dr_mode = "peripheral";
+			phy_type = "ulpi";
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		sata@18000 {
+			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
+			reg = <0x18000 0x1000>;
+			cell-index = <1>;
+			interrupts = <74 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		sata@19000 {
+			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
+			reg = <0x19000 0x1000>;
+			cell-index = <2>;
+			interrupts = <41 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	//global utilities block
+			compatible = "fsl,mpc8548-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+		};
+
+		msi@41600 {
+			compatible = "fsl,mpc8536-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+	};
+
+	pci0: pci@ffe08000 {
+		cell-index = <0>;
+		compatible = "fsl,mpc8540-pci";
+		device_type = "pci";
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+
+			/* IDSEL 0x11 J17 Slot 1 */
+			0x8800 0 0 1 &mpic 1 1
+			0x8800 0 0 2 &mpic 2 1
+			0x8800 0 0 3 &mpic 3 1
+			0x8800 0 0 4 &mpic 4 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <24 0x2>;
+		bus-range = <0 0xff>;
+		ranges = <0x02000000 0 0x80000000 0x80000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xffc00000 0 0x00010000>;
+		clock-frequency = <66666666>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xffe08000 0x1000>;
+	};
+
+	pci1: pcie@ffe09000 {
+		cell-index = <1>;
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xffe09000 0x1000>;
+		bus-range = <0 0xff>;
+		ranges = <0x02000000 0 0x98000000 0x98000000 0 0x08000000
+			  0x01000000 0 0x00000000 0xffc20000 0 0x00010000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <25 0x2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 4 1
+			0000 0 0 2 &mpic 5 1
+			0000 0 0 3 &mpic 6 1
+			0000 0 0 4 &mpic 7 1
+			>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0 0x98000000
+				  0x02000000 0 0x98000000
+				  0 0x08000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+
+	pci2: pcie@ffe0a000 {
+		cell-index = <2>;
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xffe0a000 0x1000>;
+		bus-range = <0 0xff>;
+		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x08000000
+			  0x01000000 0 0x00000000 0xffc10000 0 0x00010000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <26 0x2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 0 1
+			0000 0 0 2 &mpic 1 1
+			0000 0 0 3 &mpic 2 1
+			0000 0 0 4 &mpic 3 1
+			>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0 0x90000000
+				  0x02000000 0 0x90000000
+				  0 0x08000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+
+	pci3: pcie@ffe0b000 {
+		cell-index = <3>;
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xffe0b000 0x1000>;
+		bus-range = <0 0xff>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xffc30000 0 0x00010000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <27 0x2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 8 1
+			0000 0 0 2 &mpic 9 1
+			0000 0 0 3 &mpic 10 1
+			0000 0 0 4 &mpic 11 1
+			>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0 0xa0000000
+				  0x02000000 0 0xa0000000
+				  0 0x20000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00100000>;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 9cb8e29..cebea5c 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -38,6 +38,12 @@ config MPC85xx_MDS
 	help
 	  This option enables support for the MPC85xx MDS board

+config MPC8536_DS
+	bool "Freescale MPC8536 DS"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the MPC8536 DS board
+
 config MPC85xx_DS
 	bool "Freescale MPC85xx DS"
 	select PPC_I8259
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 6cea185..cb3054e 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -4,6 +4,7 @@
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
+obj-$(CONFIG_MPC8536_DS)  += mpc8536_ds.o
 obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
new file mode 100644
index 0000000..71d7c03
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -0,0 +1,125 @@
+/*
+ * MPC8536 DS Board Setup
+ *
+ * Copyright 2008 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+void __init mpc8536_ds_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np;
+
+	np = of_find_node_by_type(np, "open-pic");
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+			  MPIC_PRIMARY | MPIC_WANTS_RESET |
+			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
+			0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	mpic_init(mpic);
+}
+
+/*
+ * Setup the architecture
+ */
+static void __init mpc8536_ds_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc8536_ds_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
+		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
+			struct resource rsrc;
+			of_address_to_resource(np, 0, &rsrc);
+			if ((rsrc.start & 0xfffff) == 0x8000)
+				fsl_add_bridge(np, 1);
+			else
+				fsl_add_bridge(np, 0);
+		}
+	}
+
+#endif
+
+	printk("MPC8536 DS board from Freescale Semiconductor\n");
+}
+
+static struct of_device_id __initdata mpc8536_ds_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{},
+};
+
+static int __init mpc8536_ds_publish_devices(void)
+{
+	return of_platform_bus_probe(NULL, mpc8536_ds_ids, NULL);
+}
+machine_device_initcall(mpc8536_ds, mpc8536_ds_publish_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mpc8536_ds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,mpc8536ds");
+}
+
+define_machine(mpc8536_ds) {
+	.name			= "MPC8536 DS",
+	.probe			= mpc8536_ds_probe,
+	.setup_arch		= mpc8536_ds_setup_arch,
+	.init_IRQ		= mpc8536_ds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 489ca5a..87b0aa1 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -243,6 +243,8 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8544E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8544, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8572E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8572, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8536E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8536, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8610, quirk_fsl_pcie_header);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index eafc9d6..8b605bd 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2170,6 +2170,8 @@
 #define PCI_DEVICE_ID_MPC8544		0x0033
 #define PCI_DEVICE_ID_MPC8572E		0x0040
 #define PCI_DEVICE_ID_MPC8572		0x0041
+#define PCI_DEVICE_ID_MPC8536E		0x0050
+#define PCI_DEVICE_ID_MPC8536		0x0051
 #define PCI_DEVICE_ID_MPC8641		0x7010
 #define PCI_DEVICE_ID_MPC8641D		0x7011
 #define PCI_DEVICE_ID_MPC8610		0x7018
-- 
1.5.5.1
