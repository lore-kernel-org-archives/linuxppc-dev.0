Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 08E81100857
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:07:21 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAG7IgS027729
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:07:19 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/11] powerpc/85xx: Rework P1020RDB device tree
Date: Thu, 10 Nov 2011 10:07:08 -0600
Message-Id: <1320941229-29557-10-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941229-29557-9-git-send-email-galak@kernel.crashing.org>
References: <1320941229-29557-1-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-2-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-3-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-4-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-5-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-6-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-7-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-8-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-9-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We split out the common bits of the P1020RDB device tree such that we
can reuse those bits between a 32-bit or 36-bit address map device tree.

We also update the P1020RDB device tree to utilize the new p1020 SoC dts
includes (fsl/p1020si-pre.dtsi & fsl/p1020si-post.dtsi).

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1020rdb.dts  |  232 ++---------------------------------
 arch/powerpc/boot/dts/p1020rdb.dtsi |  208 +++++++++++++++++++++++++++++++
 2 files changed, 216 insertions(+), 224 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1020rdb.dtsi

diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/p1020rdb.dts
index b31e7ec..518bf99 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dts
+++ b/arch/powerpc/boot/dts/p1020rdb.dts
@@ -9,245 +9,26 @@
  * option) any later version.
  */
 
-/include/ "p1020si.dtsi"
-
+/include/ "fsl/p1020si-pre.dtsi"
 / {
 	model = "fsl,P1020RDB";
 	compatible = "fsl,P1020RDB";
 
-	aliases {
-		serial0 = &serial0;
-		serial1 = &serial1;
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		pci0 = &pci0;
-		pci1 = &pci1;
-	};
-
 	memory {
 		device_type = "memory";
 	};
 
-	localbus@ffe05000 {
+	board_lbc: lbc: localbus@ffe05000 {
+		reg = <0 0xffe05000 0 0x1000>;
 
 		/* NOR, NAND Flashes and Vitesse 5 port L2 switch */
 		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
 			  0x1 0x0 0x0 0xffa00000 0x00040000
 			  0x2 0x0 0x0 0xffb00000 0x00020000>;
-
-		nor@0,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "cfi-flash";
-			reg = <0x0 0x0 0x1000000>;
-			bank-width = <2>;
-			device-width = <1>;
-
-			partition@0 {
-				/* This location must not be altered  */
-				/* 256KB for Vitesse 7385 Switch firmware */
-				reg = <0x0 0x00040000>;
-				label = "NOR (RO) Vitesse-7385 Firmware";
-				read-only;
-			};
-
-			partition@40000 {
-				/* 256KB for DTB Image */
-				reg = <0x00040000 0x00040000>;
-				label = "NOR (RO) DTB Image";
-				read-only;
-			};
-
-			partition@80000 {
-				/* 3.5 MB for Linux Kernel Image */
-				reg = <0x00080000 0x00380000>;
-				label = "NOR (RO) Linux Kernel Image";
-				read-only;
-			};
-
-			partition@400000 {
-				/* 11MB for JFFS2 based Root file System */
-				reg = <0x00400000 0x00b00000>;
-				label = "NOR (RW) JFFS2 Root File System";
-			};
-
-			partition@f00000 {
-				/* This location must not be altered  */
-				/* 512KB for u-boot Bootloader Image */
-				/* 512KB for u-boot Environment Variables */
-				reg = <0x00f00000 0x00100000>;
-				label = "NOR (RO) U-Boot Image";
-				read-only;
-			};
-		};
-
-		nand@1,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,p1020-fcm-nand",
-				     "fsl,elbc-fcm-nand";
-			reg = <0x1 0x0 0x40000>;
-
-			partition@0 {
-				/* This location must not be altered  */
-				/* 1MB for u-boot Bootloader Image */
-				reg = <0x0 0x00100000>;
-				label = "NAND (RO) U-Boot Image";
-				read-only;
-			};
-
-			partition@100000 {
-				/* 1MB for DTB Image */
-				reg = <0x00100000 0x00100000>;
-				label = "NAND (RO) DTB Image";
-				read-only;
-			};
-
-			partition@200000 {
-				/* 4MB for Linux Kernel Image */
-				reg = <0x00200000 0x00400000>;
-				label = "NAND (RO) Linux Kernel Image";
-				read-only;
-			};
-
-			partition@600000 {
-				/* 4MB for Compressed Root file System Image */
-				reg = <0x00600000 0x00400000>;
-				label = "NAND (RO) Compressed RFS Image";
-				read-only;
-			};
-
-			partition@a00000 {
-				/* 7MB for JFFS2 based Root file System */
-				reg = <0x00a00000 0x00700000>;
-				label = "NAND (RW) JFFS2 Root File System";
-			};
-
-			partition@1100000 {
-				/* 15MB for JFFS2 based Root file System */
-				reg = <0x01100000 0x00f00000>;
-				label = "NAND (RW) Writable User area";
-			};
-		};
-
-		L2switch@2,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "vitesse-7385";
-			reg = <0x2 0x0 0x20000>;
-		};
-
 	};
 
-	soc@ffe00000 {
-		i2c@3000 {
-			rtc@68 {
-				compatible = "dallas,ds1339";
-				reg = <0x68>;
-			};
-		};
-
-		spi@7000 {
-			flash@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
-				reg = <0>;
-				spi-max-frequency = <40000000>; /* input clock */
-
-				partition@u-boot {
-					/* 512KB for u-boot Bootloader Image */
-					reg = <0x0 0x00080000>;
-					label = "u-boot";
-					read-only;
-				};
-
-				partition@dtb {
-					/* 512KB for DTB Image */
-					reg = <0x00080000 0x00080000>;
-					label = "dtb";
-					read-only;
-				};
-
-				partition@kernel {
-					/* 4MB for Linux Kernel Image */
-					reg = <0x00100000 0x00400000>;
-					label = "kernel";
-					read-only;
-				};
-
-				partition@fs {
-					/* 4MB for Compressed RFS Image */
-					reg = <0x00500000 0x00400000>;
-					label = "file system";
-					read-only;
-				};
-
-				partition@jffs-fs {
-					/* 7MB for JFFS2 based RFS */
-					reg = <0x00900000 0x00700000>;
-					label = "file system jffs2";
-				};
-			};
-		};
-
-		mdio@24000 {
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <3 1>;
-				reg = <0x0>;
-			};
-
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <2 1>;
-				reg = <0x1>;
-			};
-		};
-
-		mdio@25000 {
-
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		enet0: ethernet@b0000 {
-			fixed-link = <1 1 1000 0 0>;
-			phy-connection-type = "rgmii-id";
-
-		};
-
-		enet1: ethernet@b1000 {
-			phy-handle = <&phy0>;
-			tbi-handle = <&tbi0>;
-			phy-connection-type = "sgmii";
-
-		};
-
-		enet2: ethernet@b2000 {
-			phy-handle = <&phy1>;
-			phy-connection-type = "rgmii-id";
-
-		};
-
-		usb@22000 {
-			phy_type = "ulpi";
-		};
-
-		/* USB2 is shared with localbus, so it must be disabled
-		   by default. We can't put 'status = "disabled";' here
-		   since U-Boot doesn't clear the status property when
-		   it enables USB2. OTOH, U-Boot does create a new node
-		   when there isn't any. So, just comment it out.
-		usb@23000 {
-			phy_type = "ulpi";
-		};
-		*/
-
+	board_soc: soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
 	};
 
 	pci0: pcie@ffe09000 {
@@ -280,3 +61,6 @@
 		};
 	};
 };
+
+/include/ "p1020rdb.dtsi"
+/include/ "fsl/p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1020rdb.dtsi b/arch/powerpc/boot/dts/p1020rdb.dtsi
new file mode 100644
index 0000000..1c50146
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020rdb.dtsi
@@ -0,0 +1,208 @@
+&board_lbc {
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x1000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			partition@0 {
+				/* This location must not be altered  */
+				/* 256KB for Vitesse 7385 Switch firmware */
+				reg = <0x0 0x00040000>;
+				label = "NOR (RO) Vitesse-7385 Firmware";
+				read-only;
+			};
+
+			partition@40000 {
+				/* 256KB for DTB Image */
+				reg = <0x00040000 0x00040000>;
+				label = "NOR (RO) DTB Image";
+				read-only;
+			};
+
+			partition@80000 {
+				/* 3.5 MB for Linux Kernel Image */
+				reg = <0x00080000 0x00380000>;
+				label = "NOR (RO) Linux Kernel Image";
+				read-only;
+			};
+
+			partition@400000 {
+				/* 11MB for JFFS2 based Root file System */
+				reg = <0x00400000 0x00b00000>;
+				label = "NOR (RW) JFFS2 Root File System";
+			};
+
+			partition@f00000 {
+				/* This location must not be altered  */
+				/* 512KB for u-boot Bootloader Image */
+				/* 512KB for u-boot Environment Variables */
+				reg = <0x00f00000 0x00100000>;
+				label = "NOR (RO) U-Boot Image";
+				read-only;
+			};
+		};
+
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p1020-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <0x1 0x0 0x40000>;
+
+			partition@0 {
+				/* This location must not be altered  */
+				/* 1MB for u-boot Bootloader Image */
+				reg = <0x0 0x00100000>;
+				label = "NAND (RO) U-Boot Image";
+				read-only;
+			};
+
+			partition@100000 {
+				/* 1MB for DTB Image */
+				reg = <0x00100000 0x00100000>;
+				label = "NAND (RO) DTB Image";
+				read-only;
+			};
+
+			partition@200000 {
+				/* 4MB for Linux Kernel Image */
+				reg = <0x00200000 0x00400000>;
+				label = "NAND (RO) Linux Kernel Image";
+				read-only;
+			};
+
+			partition@600000 {
+				/* 4MB for Compressed Root file System Image */
+				reg = <0x00600000 0x00400000>;
+				label = "NAND (RO) Compressed RFS Image";
+				read-only;
+			};
+
+			partition@a00000 {
+				/* 7MB for JFFS2 based Root file System */
+				reg = <0x00a00000 0x00700000>;
+				label = "NAND (RW) JFFS2 Root File System";
+			};
+
+			partition@1100000 {
+				/* 15MB for JFFS2 based Root file System */
+				reg = <0x01100000 0x00f00000>;
+				label = "NAND (RW) Writable User area";
+			};
+		};
+
+		L2switch@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "vitesse-7385";
+			reg = <0x2 0x0 0x20000>;
+		};
+};
+
+&board_soc {
+	i2c@3000 {
+		rtc@68 {
+			compatible = "dallas,ds1339";
+			reg = <0x68>;
+		};
+	};
+
+	spi@7000 {
+		flash@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "spansion,s25sl12801";
+			reg = <0>;
+			spi-max-frequency = <40000000>; /* input clock */
+
+			partition@u-boot {
+				/* 512KB for u-boot Bootloader Image */
+				reg = <0x0 0x00080000>;
+				label = "u-boot";
+				read-only;
+			};
+
+			partition@dtb {
+				/* 512KB for DTB Image */
+				reg = <0x00080000 0x00080000>;
+				label = "dtb";
+				read-only;
+			};
+
+			partition@kernel {
+				/* 4MB for Linux Kernel Image */
+				reg = <0x00100000 0x00400000>;
+				label = "kernel";
+				read-only;
+			};
+
+			partition@fs {
+				/* 4MB for Compressed RFS Image */
+				reg = <0x00500000 0x00400000>;
+				label = "file system";
+				read-only;
+			};
+
+			partition@jffs-fs {
+				/* 7MB for JFFS2 based RFS */
+				reg = <0x00900000 0x00700000>;
+				label = "file system jffs2";
+			};
+		};
+	};
+
+	mdio@24000 {
+		phy0: ethernet-phy@0 {
+			interrupt-parent = <&mpic>;
+			interrupts = <3 1>;
+			reg = <0x0>;
+		};
+
+		phy1: ethernet-phy@1 {
+			interrupt-parent = <&mpic>;
+			interrupts = <2 1>;
+			reg = <0x1>;
+		};
+	};
+
+	mdio@25000 {
+		tbi0: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	enet0: ethernet@b0000 {
+		fixed-link = <1 1 1000 0 0>;
+		phy-connection-type = "rgmii-id";
+
+	};
+
+	enet1: ethernet@b1000 {
+		phy-handle = <&phy0>;
+		tbi-handle = <&tbi0>;
+		phy-connection-type = "sgmii";
+	};
+
+	enet2: ethernet@b2000 {
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	usb@22000 {
+		phy_type = "ulpi";
+	};
+
+	/* USB2 is shared with localbus, so it must be disabled
+	   by default. We can't put 'status = "disabled";' here
+	   since U-Boot doesn't clear the status property when
+	   it enables USB2. OTOH, U-Boot does create a new node
+	   when there isn't any. So, just comment it out.
+	usb@23000 {
+		phy_type = "ulpi";
+	};
+	*/
+};
-- 
1.7.3.4
