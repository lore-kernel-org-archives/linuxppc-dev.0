Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3445FDDEB6
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 02:09:11 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l8BG96Vh027353
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 11:09:07 -0500
Date: Tue, 11 Sep 2007 11:09:00 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Message-ID: <Pine.LNX.4.64.0709111107390.12590@blarg.am.freescale.net>
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

Added basic board port for MPC8572 DS reference platform that is
similiar to the MPC8544/33 DS reference platform in uniprocessor mode.

---

Take two, with my clean ups to the device tree as commented by Scott and
fixing my copy/paste foobar with pci_ids.h.

 arch/powerpc/boot/dts/mpc8572ds.dts       |  375 ++++++++
 arch/powerpc/configs/mpc8572_ds_defconfig | 1496 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |   31 +
 arch/powerpc/sysdev/fsl_pci.c             |    2 +
 include/linux/pci_ids.h                   |    2 +
 5 files changed, 1906 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8572ds.dts
 create mode 100644 arch/powerpc/configs/mpc8572_ds_defconfig

diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
new file mode 100644
index 0000000..c76e8d8
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -0,0 +1,375 @@
+/*
+ * MPC8572 DS Device Tree Source
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/ {
+	model = "fsl,MPC8572DS";
+	compatible = "fsl,MPC8572DS", "fsl,MPC85xxDS";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8572@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 00000000>;	// Filled by U-Boot
+	};
+
+	soc8572@ffe00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <00000000 ffe00000 00100000
+			  80000000 80000000 20000000
+			  a0000000 a0000000 20000000
+			  c0000000 c0000000 20000000
+			  ffc00000 ffc00000 00010000
+			  ffc10000 ffc10000 00010000
+			  ffc20000 ffc20000 00010000>;
+
+		reg = <ffe00000 00001000>;	// CCSRBAR & soc regs
+		bus-frequency = <0>;		// Filled out by uboot.
+
+		memory-controller@2000 {
+			compatible = "fsl,8572-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <12 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8572-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <80000>;	// L2, 512K
+			interrupt-parent = <&mpic>;
+			interrupts = <10 2>;
+		};
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <2b 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <a 1>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <a 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&mpic>;
+				interrupts = <a 1>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = <&mpic>;
+				interrupts = <a 1>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <1d 2 1e 2 22 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <23 2 24 2 28 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <26000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <1f 2 20 2 21 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy2>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <27000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <25 2 26 2 27 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy3>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>;
+			clock-frequency = <0>;
+			interrupts = <2a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;
+			clock-frequency = <0>;
+			interrupts = <2a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		pcie@8000 {
+			compatible = "fsl,mpc8548-pcie";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 ffc00000 0 00010000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+			interrupt-map-mask = <fb00 0 0 0>;
+			interrupt-map = <
+				/* IDSEL 0x11 - PCI slot 1 */
+				8800 0 0 1 &mpic 2 1
+				8800 0 0 2 &mpic 3 1
+				8800 0 0 3 &mpic 4 1
+				8800 0 0 4 &mpic 1 1
+
+				/* IDSEL 0x12 - PCI slot 2 */
+				9000 0 0 1 &mpic 3 1
+				9000 0 0 2 &mpic 4 1
+				9000 0 0 3 &mpic 1 1
+				9000 0 0 4 &mpic 2 1
+
+				// IDSEL 0x1c  USB
+				e000 0 0 0 &i8259 c 2
+				e100 0 0 0 &i8259 9 2
+				e200 0 0 0 &i8259 a 2
+				e300 0 0 0 &i8259 b 2
+
+				// IDSEL 0x1d  Audio
+				e800 0 0 0 &i8259 6 2
+
+				// IDSEL 0x1e Legacy
+				f000 0 0 0 &i8259 7 2
+				f100 0 0 0 &i8259 7 2
+
+				// IDSEL 0x1f IDE/SATA
+				f800 0 0 0 &i8259 e 2
+				f900 0 0 0 &i8259 5 2
+
+				>;
+			uli1575@0 {
+				reg = <0 0 0 0 0>;
+				#size-cells = <2>;
+				#address-cells = <3>;
+				ranges = <02000000 0 80000000
+					  02000000 0 80000000
+					  0 20000000
+					  01000000 0 00000000
+					  01000000 0 00000000
+					  0 00100000>;
+
+				pci_bridge@0 {
+					reg = <0 0 0 0 0>;
+					#size-cells = <2>;
+					#address-cells = <3>;
+					ranges = <02000000 0 80000000
+						  02000000 0 80000000
+						  0 20000000
+						  01000000 0 00000000
+						  01000000 0 00000000
+						  0 00100000>;
+
+					isa@1e {
+						device_type = "isa";
+						#interrupt-cells = <2>;
+						#size-cells = <1>;
+						#address-cells = <2>;
+						reg = <f000 0 0 0 0>;
+						ranges = <1 0 01000000 0 0
+							  00001000>;
+						interrupt-parent = <&i8259>;
+
+						i8259: interrupt-controller@20 {
+							reg = <1 20 2
+							       1 a0 2
+							       1 4d0 2>;
+							clock-frequency = <0>;
+							interrupt-controller;
+							device_type = "interrupt-controller";
+							#address-cells = <0>;
+							#interrupt-cells = <2>;
+							built-in;
+							compatible = "chrp,iic";
+							interrupts = <9 2>;
+							interrupt-parent =
+								<&mpic>;
+						};
+
+						i8042@60 {
+							#size-cells = <0>;
+							#address-cells = <1>;
+							reg = <1 60 1 1 64 1>;
+							interrupts = <1 3 c 3>;
+							interrupt-parent =
+								<&i8259>;
+
+							keyboard@0 {
+								reg = <0>;
+								compatible = "pnpPNP,303";
+							};
+
+							mouse@1 {
+								reg = <1>;
+								compatible = "pnpPNP,f03";
+							};
+						};
+
+						rtc@70 {
+							compatible = "pnpPNP,b00";
+							reg = <1 70 2>;
+						};
+
+						gpio@400 {
+							reg = <1 400 80>;
+						};
+					};
+				};
+			};
+
+		};
+
+		pcie@9000 {
+			compatible = "fsl,mpc8548-pcie";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <9000 1000>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 a0000000 a0000000 0 20000000
+				  01000000 0 00000000 ffc10000 0 00010000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <1a 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 4 1
+				0000 0 0 2 &mpic 5 1
+				0000 0 0 3 &mpic 6 1
+				0000 0 0 4 &mpic 7 1
+				>;
+		};
+
+		pcie@a000 {
+			compatible = "fsl,mpc8548-pcie";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <a000 1000>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 c0000000 c0000000 0 20000000
+				  01000000 0 00000000 ffc20000 0 00010000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <1b 2>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 0 1
+				0000 0 0 2 &mpic 1 1
+				0000 0 0 3 &mpic 2 1
+				0000 0 0 4 &mpic 3 1
+				>;
+		};
+
+		global-utilities@e0000 {	//global utilities block
+			compatible = "fsl,mpc8548-guts";
+			reg = <e0000 1000>;
+			fsl,has-rstcr;
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 3a5c3c4..4d44902 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -181,6 +181,23 @@ static int __init mpc8544_ds_probe(void)
 	}
 }

+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mpc8572_ds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "fsl,MPC8572DS")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
 define_machine(mpc8544_ds) {
 	.name			= "MPC8544 DS",
 	.probe			= mpc8544_ds_probe,
@@ -194,3 +211,17 @@ define_machine(mpc8544_ds) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
+
+define_machine(mpc8572_ds) {
+	.name			= "MPC8572 DS",
+	.probe			= mpc8572_ds_probe,
+	.setup_arch		= mpc85xx_ds_setup_arch,
+	.init_IRQ		= mpc85xx_ds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= mpc85xx_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 114c90f..34cad96 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -255,5 +255,7 @@ DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8533E, quirk_fsl_pcie_transpare
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8533, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8544E, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8544, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8572E, quirk_fsl_pcie_transparent)
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8572, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8641, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_transparent);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 06d23e1..daedb60 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2100,6 +2100,8 @@
 #define PCI_DEVICE_ID_MPC8533		0x0031
 #define PCI_DEVICE_ID_MPC8544E		0x0032
 #define PCI_DEVICE_ID_MPC8544		0x0033
+#define PCI_DEVICE_ID_MPC8572E		0x0040
+#define PCI_DEVICE_ID_MPC8572		0x0041
 #define PCI_DEVICE_ID_MPC8641		0x7010
 #define PCI_DEVICE_ID_MPC8641D		0x7011

-- 
1.5.2.4
