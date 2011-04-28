Return-Path: <B32579@freescale.com>
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree-discuss@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx:Create dts of each core in CAMP mode for P1020RDB
Date: Thu, 28 Apr 2011 12:30:00 +0530
Message-ID: <1303974000-2943-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create the dts files for each core and splits the devices between the two cores
for P1020RDB.

Core0 has core0 to have memory, l2, i2c, spi, gpio, tdm, dma, usb, eth1, eth2,
sdhc, crypto, global-util, message, pci0, pci1, msi.
Core1 has l2, eth0, crypto.

MPIC is shared between two cores but each core will protect its interrupts from
other core by using "protected-sources" of mpic.

Fix compatible property for global-util node of P1020si.dtsi.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branch master)
 
 This patch depends on following patch
 	"powerpc/85xx: P1020 DTS : re-organize dts files"

 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts |  213 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1020rdb_camp_core1.dts |  148 +++++++++++++++++
 arch/powerpc/boot/dts/p1020si.dtsi            |    2 +-
 3 files changed, 362 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
 create mode 100644 arch/powerpc/boot/dts/p1020rdb_camp_core1.dts

diff --git a/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts b/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
new file mode 100644
index 0000000..f0bf7f4
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
@@ -0,0 +1,213 @@
+/*
+ * P1020 RDB  Core0 Device Tree Source in CAMP mode.
+ *
+ * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
+ * can be shared, all the other devices must be assigned to one core only.
+ * This dts file allows core0 to have memory, l2, i2c, spi, gpio, tdm, dma, usb,
+ * eth1, eth2, sdhc, crypto, global-util, message, pci0, pci1, msi.
+ *
+ * Please note to add "-b 0" for core0's dts compiling.
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "p1020si.dtsi"
+
+/ {
+	model = "fsl,P1020RDB";
+	compatible = "fsl,P1020RDB", "fsl,MPC85XXRDB-CAMP";
+
+	aliases {
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		serial0 = &serial0;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		PowerPC,P1020@1 {
+		status = "disabled";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	localbus@ffe05000 {
+		status = "disabled";
+	};
+
+	soc@ffe00000 {
+		i2c@3000 {
+			rtc@68 {
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+			};
+		};
+
+		serial1: serial@4600 {
+			status = "disabled";
+		};
+
+		spi@7000 {
+			fsl_m25p80@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,espi-flash";
+				reg = <0>;
+				linux,modalias = "fsl_m25p80";
+				spi-max-frequency = <40000000>;
+
+				partition@0 {
+					/* 512KB for u-boot Bootloader Image */
+					reg = <0x0 0x00080000>;
+					label = "SPI (RO) U-Boot Image";
+					read-only;
+				};
+
+				partition@80000 {
+					/* 512KB for DTB Image */
+					reg = <0x00080000 0x00080000>;
+					label = "SPI (RO) DTB Image";
+					read-only;
+				};
+
+				partition@100000 {
+					/* 4MB for Linux Kernel Image */
+					reg = <0x00100000 0x00400000>;
+					label = "SPI (RO) Linux Kernel Image";
+					read-only;
+				};
+
+				partition@500000 {
+					/* 4MB for Compressed RFS Image */
+					reg = <0x00500000 0x00400000>;
+					label = "SPI (RO) Compressed RFS Image";
+					read-only;
+				};
+
+				partition@900000 {
+					/* 7MB for JFFS2 based RFS */
+					reg = <0x00900000 0x00700000>;
+					label = "SPI (RW) JFFS2 RFS";
+				};
+			};
+		};
+
+		mdio@24000 {
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <3 1>;
+				reg = <0x0>;
+			};
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <2 1>;
+				reg = <0x1>;
+			};
+		};
+
+		mdio@25000 {
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		enet0: ethernet@b0000 {
+			status = "disabled";
+		};
+
+		enet1: ethernet@b1000 {
+			phy-handle = <&phy0>;
+			tbi-handle = <&tbi0>;
+			phy-connection-type = "sgmii";
+		};
+
+		enet2: ethernet@b2000 {
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		usb@22000 {
+			phy_type = "ulpi";
+		};
+
+		/* USB2 is shared with localbus, so it must be disabled
+		   by default. We can't put 'status = "disabled";' here
+		   since U-Boot doesn't clear the status property when
+		   it enables USB2. OTOH, U-Boot does create a new node
+		   when there isn't any. So, just comment it out.
+		usb@23000 {
+			phy_type = "ulpi";
+		};
+		*/
+
+		mpic: pic@40000 {
+			protected-sources = <
+			42 29 30 34	/* serial1, enet0-queue-group0 */
+			17 18 24 45	/* enet0-queue-group1, crypto */
+			>;
+		};
+
+	};
+
+	pci0: pcie@ffe09000 {
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x4 0x1
+			0000 0x0 0x0 0x2 &mpic 0x5 0x1
+			0000 0x0 0x0 0x3 &mpic 0x6 0x1
+			0000 0x0 0x0 0x4 &mpic 0x7 0x1
+			>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0xa0000000
+				  0x2000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@ffe0a000 {
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x0 0x1
+			0000 0x0 0x0 0x2 &mpic 0x1 0x1
+			0000 0x0 0x0 0x3 &mpic 0x2 0x1
+			0000 0x0 0x0 0x4 &mpic 0x3 0x1
+			>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1020rdb_camp_core1.dts b/arch/powerpc/boot/dts/p1020rdb_camp_core1.dts
new file mode 100644
index 0000000..8498988
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020rdb_camp_core1.dts
@@ -0,0 +1,148 @@
+/*
+ * P1020 RDB Core1 Device Tree Source in CAMP mode.
+ *
+ * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
+ * can be shared, all the other devices must be assigned to one core only.
+ * This dts allows core1 to have l2, eth0, crypto.
+ *
+ * Please note to add "-b 1" for core1's dts compiling.
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "p1020si.dtsi"
+
+/ {
+	model = "fsl,P1020RDB";
+	compatible = "fsl,P1020RDB", "fsl,MPC85XXRDB-CAMP";
+
+	aliases {
+		ethernet0 = &enet0;
+		serial0 = &serial1;
+		};
+
+	cpus {
+		PowerPC,P1020@0 {
+		status = "disabled";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	localbus@ffe05000 {
+		status = "disabled";
+	};
+
+	soc@ffe00000 {
+		ecm-law@0 {
+			status = "disabled";
+		};
+
+		ecm@1000 {
+			status = "disabled";
+		};
+
+		memory-controller@2000 {
+			status = "disabled";
+		};
+
+		i2c@3000 {
+			status = "disabled";
+		};
+
+		i2c@3100 {
+			status = "disabled";
+		};
+
+		serial0: serial@4500 {
+			status = "disabled";
+		};
+
+		spi@7000 {
+			status = "disabled";
+		};
+
+		gpio: gpio-controller@f000 {
+			status = "disabled";
+		};
+
+		dma@21300 {
+			status = "disabled";
+		};
+
+		mdio@24000 {
+			status = "disabled";
+		};
+
+		mdio@25000 {
+			status = "disabled";
+		};
+
+		enet0: ethernet@b0000 {
+			fixed-link = <1 1 1000 0 0>;
+			phy-connection-type = "rgmii-id";
+
+		};
+
+		enet1: ethernet@b1000 {
+			status = "disabled";
+		};
+
+		enet2: ethernet@b2000 {
+			status = "disabled";
+		};
+
+		usb@22000 {
+			status = "disabled";
+		};
+
+		sdhci@2e000 {
+			status = "disabled";
+		};
+
+		mpic: pic@40000 {
+			protected-sources = <
+			16 		/* ecm, mem, L2, pci0, pci1 */
+			43 42 59	/* i2c, serial0, spi */
+			47 63 62 	/* gpio, tdm */
+			20 21 22 23	/* dma */
+			03 02 		/* mdio */
+			35 36 40	/* enet1-queue-group0 */
+			51 52 67	/* enet1-queue-group1 */
+			31 32 33	/* enet2-queue-group0 */
+			25 26 27	/* enet2-queue-group1 */
+			28 72 58 	/* usb, sdhci, crypto */
+			0xb0 0xb1 0xb2	/* message */
+			0xb3 0xb4 0xb5
+			0xb6 0xb7
+			0xe0 0xe1 0xe2	/* msi */
+			0xe3 0xe4 0xe5
+			0xe6 0xe7		/* sdhci, crypto , pci */
+			>;
+		};
+
+		msi@41600 {
+			status = "disabled";
+		};
+
+		global-utilities@e0000 {	//global utilities block
+			status = "disabled";
+		};
+
+	};
+
+	pci0: pcie@ffe09000 {
+		status = "disabled";
+	};
+
+	pci1: pcie@ffe0a000 {
+		status = "disabled";
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1020si.dtsi b/arch/powerpc/boot/dts/p1020si.dtsi
index f6f1100..5c5acb6 100644
--- a/arch/powerpc/boot/dts/p1020si.dtsi
+++ b/arch/powerpc/boot/dts/p1020si.dtsi
@@ -343,7 +343,7 @@
 		};
 
 		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,p1020-guts";
+			compatible = "fsl,p1020-guts","fsl,p2020-guts";
 			reg = <0xe0000 0x1000>;
 			fsl,has-rstcr;
 		};
-- 
1.7.3
