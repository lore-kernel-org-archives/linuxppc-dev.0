Return-Path: <mathieu@macbookpro.malat.net>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yyKRD1m9BzDrWq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 03:54:32 +1100 (AEDT)
From: Mathieu Malaterre <malat@debian.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: dts: Remove leading 0x and 0s from bindings notation
Date: Thu, 14 Dec 2017 17:54:00 +0100
Message-Id: <20171214165413.28163-1-malat@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Improve the DTS files by removing all the leading "0x" and zeros to fix the
following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

and

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -E -i -e "s/@0x([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" -e "s/@0+([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" {} +

For simplicity, two sed expressions were used to solve each warnings separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before the
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/boot/dts/a3m071.dts           | 10 +++++-----
 arch/powerpc/boot/dts/akebono.dts          |  4 ++--
 arch/powerpc/boot/dts/c2k.dts              |  6 +++---
 arch/powerpc/boot/dts/currituck.dts        |  2 +-
 arch/powerpc/boot/dts/fsl/mpc8568mds.dts   | 12 +++++------
 arch/powerpc/boot/dts/fsl/mpc8569mds.dts   | 20 +++++++++----------
 arch/powerpc/boot/dts/fsl/p1021mds.dts     |  6 +++---
 arch/powerpc/boot/dts/fsl/p1025rdb.dtsi    |  8 ++++----
 arch/powerpc/boot/dts/fsl/p1025rdb_32b.dts |  2 +-
 arch/powerpc/boot/dts/fsl/p1025twr.dtsi    |  8 ++++----
 arch/powerpc/boot/dts/fsl/t1040rdb.dts     |  2 +-
 arch/powerpc/boot/dts/fsl/t1042d4rdb.dts   | 10 +++++-----
 arch/powerpc/boot/dts/fsl/t1042rdb.dts     |  2 +-
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi    |  6 +++---
 arch/powerpc/boot/dts/fsp2.dts             |  6 +++---
 arch/powerpc/boot/dts/gamecube.dts         | 14 ++++++-------
 arch/powerpc/boot/dts/haleakala.dts        |  2 +-
 arch/powerpc/boot/dts/kilauea.dts          |  4 ++--
 arch/powerpc/boot/dts/kmeter1.dts          | 10 +++++-----
 arch/powerpc/boot/dts/makalu.dts           |  4 ++--
 arch/powerpc/boot/dts/mpc832x_mds.dts      | 10 +++++-----
 arch/powerpc/boot/dts/mpc832x_rdb.dts      |  8 ++++----
 arch/powerpc/boot/dts/mpc836x_mds.dts      |  8 ++++----
 arch/powerpc/boot/dts/sbc8548-altflash.dts |  8 ++++----
 arch/powerpc/boot/dts/sbc8548.dts          |  8 ++++----
 arch/powerpc/boot/dts/wii.dts              | 32 +++++++++++++++---------------
 26 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/arch/powerpc/boot/dts/a3m071.dts b/arch/powerpc/boot/dts/a3m071.dts
index bf81b8f9704c..187ce458d03a 100644
--- a/arch/powerpc/boot/dts/a3m071.dts
+++ b/arch/powerpc/boot/dts/a3m071.dts
@@ -105,24 +105,24 @@
 			reg = <0 0x0 0x02000000>;
 			compatible = "cfi-flash";
 			bank-width = <2>;
-			partition@0x0 {
+			partition@0 {
 				label = "u-boot";
 				reg = <0x00000000 0x00040000>;
 				read-only;
 			};
-			partition@0x00040000 {
+			partition@40000 {
 				label = "env";
 				reg = <0x00040000 0x00020000>;
 			};
-			partition@0x00060000 {
+			partition@60000 {
 				label = "dtb";
 				reg = <0x00060000 0x00020000>;
 			};
-			partition@0x00080000 {
+			partition@80000 {
 				label = "kernel";
 				reg = <0x00080000 0x00500000>;
 			};
-			partition@0x00580000 {
+			partition@580000 {
 				label = "root";
 				reg = <0x00580000 0x00A80000>;
 			};
diff --git a/arch/powerpc/boot/dts/akebono.dts b/arch/powerpc/boot/dts/akebono.dts
index e61d5dc598c1..746779202a12 100644
--- a/arch/powerpc/boot/dts/akebono.dts
+++ b/arch/powerpc/boot/dts/akebono.dts
@@ -216,7 +216,7 @@
 				interrupts = <39 2>;
 			};
 
-			IIC0: i2c@00000000 {
+			IIC0: i2c@0 {
 				compatible = "ibm,iic-476gtr", "ibm,iic";
 				reg = <0x0 0x00000020>;
 				interrupt-parent = <&MPIC>;
@@ -229,7 +229,7 @@
 				};
 			};
 
-			IIC1: i2c@00000100 {
+			IIC1: i2c@100 {
 				compatible = "ibm,iic-476gtr", "ibm,iic";
 				reg = <0x100 0x00000020>;
 				interrupt-parent = <&MPIC>;
diff --git a/arch/powerpc/boot/dts/c2k.dts b/arch/powerpc/boot/dts/c2k.dts
index 1e32903cb0a8..27f169e3ade9 100644
--- a/arch/powerpc/boot/dts/c2k.dts
+++ b/arch/powerpc/boot/dts/c2k.dts
@@ -276,14 +276,14 @@
 			>;
 		};
 
-		cpu-error@0070 {
+		cpu-error@70 {
 			compatible = "marvell,mv64360-cpu-error";
 			reg = <0x0070 0x10 0x0128 0x28>;
 			interrupts = <3>;
 			interrupt-parent = <&PIC>;
 		};
 
-		sram-ctrl@0380 {
+		sram-ctrl@380 {
 			compatible = "marvell,mv64360-sram-ctrl";
 			reg = <0x0380 0x80>;
 			interrupts = <13>;
@@ -311,7 +311,7 @@
 			interrupt-parent = <&PIC>;
 		};
 		/* Devices attached to the device controller */
-		devicebus@045c {
+		devicebus@45c {
 			#address-cells = <2>;
 			#size-cells = <1>;
 			compatible = "marvell,mv64306-devctrl";
diff --git a/arch/powerpc/boot/dts/currituck.dts b/arch/powerpc/boot/dts/currituck.dts
index 4191e1850ea1..f2ad5815f08d 100644
--- a/arch/powerpc/boot/dts/currituck.dts
+++ b/arch/powerpc/boot/dts/currituck.dts
@@ -108,7 +108,7 @@
 				reg = <0x50000000 0x4>;
 			};
 
-			IIC0: i2c@00000000 {
+			IIC0: i2c@0 {
 				compatible = "ibm,iic-currituck", "ibm,iic";
 				reg = <0x0 0x00000014>;
 				interrupt-parent = <&MPIC>;
diff --git a/arch/powerpc/boot/dts/fsl/mpc8568mds.dts b/arch/powerpc/boot/dts/fsl/mpc8568mds.dts
index 01706a339603..bc3e8039bdc7 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8568mds.dts
@@ -126,7 +126,7 @@
 		par_io@e0100 {
 			num-ports = <7>;
 
-			pio1: ucc_pin@01 {
+			pio1: ucc_pin@1 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0x4  0xa  0x1  0x0  0x2  0x0 	/* TxD0 */
@@ -154,7 +154,7 @@
 					0x1  0x1f  0x2  0x0  0x3  0x0>;	/* GTX125 */
 			};
 
-			pio2: ucc_pin@02 {
+			pio2: ucc_pin@2 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0x5  0xa 0x1  0x0  0x2  0x0   /* TxD0 */
@@ -228,22 +228,22 @@
 
 			/* These are the same PHYs as on
 			 * gianfar's MDIO bus */
-			qe_phy0: ethernet-phy@07 {
+			qe_phy0: ethernet-phy@7 {
 				interrupt-parent = <&mpic>;
 				interrupts = <1 1 0 0>;
 				reg = <0x7>;
 			};
-			qe_phy1: ethernet-phy@01 {
+			qe_phy1: ethernet-phy@1 {
 				interrupt-parent = <&mpic>;
 				interrupts = <2 1 0 0>;
 				reg = <0x1>;
 			};
-			qe_phy2: ethernet-phy@02 {
+			qe_phy2: ethernet-phy@2 {
 				interrupt-parent = <&mpic>;
 				interrupts = <1 1 0 0>;
 				reg = <0x2>;
 			};
-			qe_phy3: ethernet-phy@03 {
+			qe_phy3: ethernet-phy@3 {
 				interrupt-parent = <&mpic>;
 				interrupts = <2 1 0 0>;
 				reg = <0x3>;
diff --git a/arch/powerpc/boot/dts/fsl/mpc8569mds.dts b/arch/powerpc/boot/dts/fsl/mpc8569mds.dts
index 76b2bd6f7742..d8367ceddea6 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8569mds.dts
@@ -141,7 +141,7 @@
 				gpio-controller;
 			};
 
-			pio1: ucc_pin@01 {
+			pio1: ucc_pin@1 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0x2  0x1f 0x1  0x0  0x1  0x0	/* QE_MUX_MDC */
@@ -161,7 +161,7 @@
 					0x2  0x14 0x1  0x0  0x2  0x0>;	/* ENET1_GTXCLK	*/
 			};
 
-			pio2: ucc_pin@02 {
+			pio2: ucc_pin@2 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0x2  0x1f 0x1  0x0  0x1  0x0	/* QE_MUX_MDC */
@@ -181,7 +181,7 @@
 					0x2  0x2 0x1  0x0  0x2  0x0>;	/* ENET2_GTXCLK	*/
 			};
 
-			pio3: ucc_pin@03 {
+			pio3: ucc_pin@3 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0x2  0x1f 0x1  0x0  0x1  0x0	/* QE_MUX_MDC */
@@ -201,7 +201,7 @@
 					0x2  0x19 0x1  0x0  0x2  0x0>;	/* ENET3_GTXCLK	*/
 			};
 
-			pio4: ucc_pin@04 {
+			pio4: ucc_pin@4 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0x2  0x1f 0x1  0x0  0x1  0x0	/* QE_MUX_MDC */
@@ -272,30 +272,30 @@
 			reg = <0x2120 0x18>;
 			compatible = "fsl,ucc-mdio";
 
-			qe_phy0: ethernet-phy@07 {
+			qe_phy0: ethernet-phy@7 {
 				interrupt-parent = <&mpic>;
 				interrupts = <1 1 0 0>;
 				reg = <0x7>;
 			};
-			qe_phy1: ethernet-phy@01 {
+			qe_phy1: ethernet-phy@1 {
 				interrupt-parent = <&mpic>;
 				interrupts = <2 1 0 0>;
 				reg = <0x1>;
 			};
-			qe_phy2: ethernet-phy@02 {
+			qe_phy2: ethernet-phy@2 {
 				interrupt-parent = <&mpic>;
 				interrupts = <3 1 0 0>;
 				reg = <0x2>;
 			};
-			qe_phy3: ethernet-phy@03 {
+			qe_phy3: ethernet-phy@3 {
 				interrupt-parent = <&mpic>;
 				interrupts = <4 1 0 0>;
 				reg = <0x3>;
 			};
-			qe_phy5: ethernet-phy@04 {
+			qe_phy5: ethernet-phy@4 {
 				reg = <0x04>;
 			};
-			qe_phy7: ethernet-phy@06 {
+			qe_phy7: ethernet-phy@6 {
 				reg = <0x6>;
 			};
 			tbi1: tbi-phy@11 {
diff --git a/arch/powerpc/boot/dts/fsl/p1021mds.dts b/arch/powerpc/boot/dts/fsl/p1021mds.dts
index 291454c75dda..1047802f4d2a 100644
--- a/arch/powerpc/boot/dts/fsl/p1021mds.dts
+++ b/arch/powerpc/boot/dts/fsl/p1021mds.dts
@@ -202,7 +202,7 @@
 			ranges = <0x0 0xe0100 0x60>;
 			device_type = "par_io";
 			num-ports = <3>;
-			pio1: ucc_pin@01 {
+			pio1: ucc_pin@1 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0x1  0x13 0x1  0x0  0x1  0x0    /* QE_MUX_MDC */
@@ -225,7 +225,7 @@
 					0x0  0x10 0x2  0x0  0x2  0x0>;    /* ENET1_COL */
 			};
 
-			pio2: ucc_pin@02 {
+			pio2: ucc_pin@2 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0x1  0x13 0x1  0x0  0x1  0x0    /* QE_MUX_MDC */
@@ -296,7 +296,7 @@
 				interrupts = <4 1 0 0>;
 				reg = <0x0>;
 			};
-			qe_phy1: ethernet-phy@03 {
+			qe_phy1: ethernet-phy@3 {
 				interrupt-parent = <&mpic>;
 				interrupts = <5 1 0 0>;
 				reg = <0x3>;
diff --git a/arch/powerpc/boot/dts/fsl/p1025rdb.dtsi b/arch/powerpc/boot/dts/fsl/p1025rdb.dtsi
index d44bb12debb0..0a5434a631c3 100644
--- a/arch/powerpc/boot/dts/fsl/p1025rdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1025rdb.dtsi
@@ -245,7 +245,7 @@
 		ranges = <0x0 0xe0100 0x60>;
 		device_type = "par_io";
 		num-ports = <3>;
-		pio1: ucc_pin@01 {
+		pio1: ucc_pin@1 {
 			pio-map = <
 		/* port  pin  dir  open_drain  assignment  has_irq */
 				0x1  0x13 0x1  0x0  0x1  0x0    /* QE_MUX_MDC */
@@ -268,7 +268,7 @@
 				0x0  0x10 0x2  0x0  0x2  0x0>;    /* ENET1_COL */
 		};
 
-		pio2: ucc_pin@02 {
+		pio2: ucc_pin@2 {
 			pio-map = <
 		/* port  pin  dir  open_drain  assignment  has_irq */
 				0x1  0x13 0x1  0x0  0x1  0x0    /* QE_MUX_MDC */
@@ -283,7 +283,7 @@
 				0x1  0x8  0x2  0x0  0x2  0x0>;    /* ENET5_RX_ER_SER5_CD_B */
 		};
 
-		pio3: ucc_pin@03 {
+		pio3: ucc_pin@3 {
 			pio-map = <
 		/* port  pin  dir  open_drain  assignment  has_irq */
 				0x0  0x16 0x2  0x0  0x2  0x0    /* SER7_CD_B*/
@@ -293,7 +293,7 @@
 				0x0  0x15 0x1  0x0  0x2  0x0>;    /* SER7_TXD0*/
 		};
 
-		pio4: ucc_pin@04 {
+		pio4: ucc_pin@4 {
 			pio-map = <
 		/* port  pin  dir  open_drain  assignment  has_irq */
 				0x1  0x0  0x2  0x0  0x2  0x0    /* SER3_CD_B*/
diff --git a/arch/powerpc/boot/dts/fsl/p1025rdb_32b.dts b/arch/powerpc/boot/dts/fsl/p1025rdb_32b.dts
index b15acbaea34b..ea33b57f8774 100644
--- a/arch/powerpc/boot/dts/fsl/p1025rdb_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1025rdb_32b.dts
@@ -106,7 +106,7 @@
 				interrupts = <4 1 0 0>;
 				reg = <0x6>;
 			};
-			qe_phy1: ethernet-phy@03 {
+			qe_phy1: ethernet-phy@3 {
 				interrupt-parent = <&mpic>;
 				interrupts = <5 1 0 0>;
 				reg = <0x3>;
diff --git a/arch/powerpc/boot/dts/fsl/p1025twr.dtsi b/arch/powerpc/boot/dts/fsl/p1025twr.dtsi
index 08816fb474f5..ab75b8f29ae2 100644
--- a/arch/powerpc/boot/dts/fsl/p1025twr.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1025twr.dtsi
@@ -172,7 +172,7 @@
 		ranges = <0x0 0xe0100 0x60>;
 		device_type = "par_io";
 		num-ports = <3>;
-		pio1: ucc_pin@01 {
+		pio1: ucc_pin@1 {
 			pio-map = <
 		/* port  pin  dir  open_drain  assignment  has_irq */
 				0x1  0x13 0x1  0x0  0x1  0x0    /* QE_MUX_MDC */
@@ -195,7 +195,7 @@
 				0x0  0x10 0x2  0x0  0x2  0x0>;    /* ENET1_COL */
 		};
 
-		pio2: ucc_pin@02 {
+		pio2: ucc_pin@2 {
 			pio-map = <
 		/* port  pin  dir  open_drain  assignment  has_irq */
 				0x1  0x13 0x1  0x0  0x1  0x0    /* QE_MUX_MDC */
@@ -210,7 +210,7 @@
 				0x1  0x8  0x2  0x0  0x2  0x0>;    /* ENET5_RX_ER_SER5_CD_B */
 		};
 
-		pio3: ucc_pin@03 {
+		pio3: ucc_pin@3 {
 			pio-map = <
 		/* port  pin  dir  open_drain  assignment  has_irq */
 				0x0  0x16 0x2  0x0  0x2  0x0    /* SER7_CD_B*/
@@ -220,7 +220,7 @@
 				0x0  0x15 0x1  0x0  0x2  0x0>;    /* SER7_TXD0*/
 		};
 
-		pio4: ucc_pin@04 {
+		pio4: ucc_pin@4 {
 			pio-map = <
 		/* port  pin  dir  open_drain  assignment  has_irq */
 				0x1  0x0  0x2  0x0  0x2  0x0    /* SER3_CD_B*/
diff --git a/arch/powerpc/boot/dts/fsl/t1040rdb.dts b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
index 621f2c6ee6ad..65ff34c49025 100644
--- a/arch/powerpc/boot/dts/fsl/t1040rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
@@ -61,7 +61,7 @@
 			};
 
 			mdio@fc000 {
-				phy_sgmii_2: ethernet-phy@03 {
+				phy_sgmii_2: ethernet-phy@3 {
 					reg = <0x03>;
 				};
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts b/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
index fcd2aeb5b8ac..4fa15f48a4c3 100644
--- a/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
@@ -77,23 +77,23 @@
 			};
 
 			mdio0: mdio@fc000 {
-				phy_sgmii_0: ethernet-phy@02 {
+				phy_sgmii_0: ethernet-phy@2 {
 					reg = <0x02>;
 				};
 
-				phy_sgmii_1: ethernet-phy@03 {
+				phy_sgmii_1: ethernet-phy@3 {
 					reg = <0x03>;
 				};
 
-				phy_sgmii_2: ethernet-phy@01 {
+				phy_sgmii_2: ethernet-phy@1 {
 					reg = <0x01>;
 				};
 
-				phy_rgmii_0: ethernet-phy@04 {
+				phy_rgmii_0: ethernet-phy@4 {
 					reg = <0x04>;
 				};
 
-				phy_rgmii_1: ethernet-phy@05 {
+				phy_rgmii_1: ethernet-phy@5 {
 					reg = <0x05>;
 				};
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t1042rdb.dts b/arch/powerpc/boot/dts/fsl/t1042rdb.dts
index 2c138627b1b4..3ebb712224cb 100644
--- a/arch/powerpc/boot/dts/fsl/t1042rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042rdb.dts
@@ -59,7 +59,7 @@
 			};
 
 			mdio@fc000 {
-				phy_sgmii_2: ethernet-phy@03 {
+				phy_sgmii_2: ethernet-phy@3 {
 					reg = <0x03>;
 				};
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
index 5fdddbd2a62b..099a598c74c0 100644
--- a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
@@ -148,15 +148,15 @@
 			};
 
 			mdio0: mdio@fc000 {
-				phy_sgmii_2: ethernet-phy@03 {
+				phy_sgmii_2: ethernet-phy@3 {
 					reg = <0x03>;
 				};
 
-				phy_rgmii_0: ethernet-phy@01 {
+				phy_rgmii_0: ethernet-phy@1 {
 					reg = <0x01>;
 				};
 
-				phy_rgmii_1: ethernet-phy@02 {
+				phy_rgmii_1: ethernet-phy@2 {
 					reg = <0x02>;
 				};
 			};
diff --git a/arch/powerpc/boot/dts/fsp2.dts b/arch/powerpc/boot/dts/fsp2.dts
index f10a64aeb83b..6560283c5aec 100644
--- a/arch/powerpc/boot/dts/fsp2.dts
+++ b/arch/powerpc/boot/dts/fsp2.dts
@@ -583,21 +583,21 @@
 			};
 		};
 
-		OHCI1: ohci@02040000 {
+		OHCI1: ohci@2040000 {
 			compatible = "ohci-le";
 			reg = <0x02040000 0xa0>;
 			interrupt-parent = <&UIC1_3>;
 			interrupts = <28 0x8 29 0x8>;
 		};
 
-		OHCI2: ohci@02080000 {
+		OHCI2: ohci@2080000 {
 			compatible = "ohci-le";
 			reg = <0x02080000 0xa0>;
 			interrupt-parent = <&UIC1_3>;
 			interrupts = <30 0x8 31 0x8>;
 		};
 
-		EHCI: ehci@02000000 {
+		EHCI: ehci@2000000 {
 			compatible = "usb-ehci";
 			reg = <0x02000000 0xa4>;
 			interrupt-parent = <&UIC1_3>;
diff --git a/arch/powerpc/boot/dts/gamecube.dts b/arch/powerpc/boot/dts/gamecube.dts
index ef3be0e58b02..58d06c9ee08b 100644
--- a/arch/powerpc/boot/dts/gamecube.dts
+++ b/arch/powerpc/boot/dts/gamecube.dts
@@ -54,13 +54,13 @@
 		ranges = <0x0c000000 0x0c000000 0x00010000>;
 		interrupt-parent = <&PIC>;
 
-		video@0c002000 {
+		video@c002000 {
 			compatible = "nintendo,flipper-vi";
 			reg = <0x0c002000 0x100>;
 			interrupts = <8>;
 		};
 
-		processor-interface@0c003000 {
+		processor-interface@c003000 {
 			compatible = "nintendo,flipper-pi";
 			reg = <0x0c003000 0x100>;
 
@@ -71,7 +71,7 @@
 			};
 		};
 
-		dsp@0c005000 {
+		dsp@c005000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "nintendo,flipper-dsp";
@@ -84,26 +84,26 @@
 			};
 		};
 
-		disk@0c006000 {
+		disk@c006000 {
 			compatible = "nintendo,flipper-di";
 			reg = <0x0c006000 0x40>;
 			interrupts = <2>;
 		};
 
-		audio@0c006c00 {
+		audio@c006c00 {
 			compatible = "nintendo,flipper-ai";
 			reg = <0x0c006c00 0x20>;
 			interrupts = <6>;
 		};
 
-		gamepad-controller@0c006400 {
+		gamepad-controller@c006400 {
 			compatible = "nintendo,flipper-si";
 			reg = <0x0c006400 0x100>;
 			interrupts = <3>;
 		};
 
 		/* External Interface bus */
-		exi@0c006800 {
+		exi@c006800 {
 			compatible = "nintendo,flipper-exi";
 			reg = <0x0c006800 0x40>;
 			virtual-reg = <0x0c006800>;
diff --git a/arch/powerpc/boot/dts/haleakala.dts b/arch/powerpc/boot/dts/haleakala.dts
index 2b256694eca6..cb16dad43c92 100644
--- a/arch/powerpc/boot/dts/haleakala.dts
+++ b/arch/powerpc/boot/dts/haleakala.dts
@@ -237,7 +237,7 @@
 			};
 		};
 
-		PCIE0: pciex@0a0000000 {
+		PCIE0: pciex@a0000000 {
 			device_type = "pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index 5ba7f01e2a29..2a3413221cc1 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -322,7 +322,7 @@
 			};
 		};
 
-		PCIE0: pciex@0a0000000 {
+		PCIE0: pciex@a0000000 {
 			device_type = "pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
@@ -363,7 +363,7 @@
 				0x0 0x0 0x0 0x4 &UIC2 0x3 0x4 /* swizzled int D */>;
 		};
 
-		PCIE1: pciex@0c0000000 {
+		PCIE1: pciex@c0000000 {
 			device_type = "pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/kmeter1.dts b/arch/powerpc/boot/dts/kmeter1.dts
index 983aee185793..9fa33d9ba966 100644
--- a/arch/powerpc/boot/dts/kmeter1.dts
+++ b/arch/powerpc/boot/dts/kmeter1.dts
@@ -434,27 +434,27 @@
 				compatible = "fsl,ucc-mdio";
 
 				/* Piggy2 (UCC4, MDIO 0x00, RMII) */
-				phy_piggy2: ethernet-phy@00 {
+				phy_piggy2: ethernet-phy@0 {
 					reg = <0x0>;
 				};
 
 				/* Eth-1 (UCC5, MDIO 0x08, RMII) */
-				phy_eth1: ethernet-phy@08 {
+				phy_eth1: ethernet-phy@8 {
 					reg = <0x08>;
 				};
 
 				/* Eth-2 (UCC6, MDIO 0x09, RMII) */
-				phy_eth2: ethernet-phy@09 {
+				phy_eth2: ethernet-phy@9 {
 					reg = <0x09>;
 				};
 
 				/* Eth-3 (UCC7, MDIO 0x0a, RMII) */
-				phy_eth3: ethernet-phy@0a {
+				phy_eth3: ethernet-phy@a {
 					reg = <0x0a>;
 				};
 
 				/* Eth-4 (UCC8, MDIO 0x0b, RMII) */
-				phy_eth4: ethernet-phy@0b {
+				phy_eth4: ethernet-phy@b {
 					reg = <0x0b>;
 				};
 
diff --git a/arch/powerpc/boot/dts/makalu.dts b/arch/powerpc/boot/dts/makalu.dts
index 63d48b632c84..bf8fe1629392 100644
--- a/arch/powerpc/boot/dts/makalu.dts
+++ b/arch/powerpc/boot/dts/makalu.dts
@@ -268,7 +268,7 @@
 			};
 		};
 
-		PCIE0: pciex@0a0000000 {
+		PCIE0: pciex@a0000000 {
 			device_type = "pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
@@ -309,7 +309,7 @@
 				0x0 0x0 0x0 0x4 &UIC2 0x3 0x4 /* swizzled int D */>;
 		};
 
-		PCIE1: pciex@0c0000000 {
+		PCIE1: pciex@c0000000 {
 			device_type = "pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 0793cdf0d46e..49c7d657118a 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -186,7 +186,7 @@
 			device_type = "par_io";
 			num-ports = <7>;
 
-			pio3: ucc_pin@03 {
+			pio3: ucc_pin@3 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					3  4  3  0  2  0  /* MDIO */
@@ -208,7 +208,7 @@
 					1 12  1  0  1  0 	/* TX_EN */
 					1 13  2  0  1  0>;	/* CRS */
 			};
-			pio4: ucc_pin@04 {
+			pio4: ucc_pin@4 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					3 31  2  0  1  0 	/* RX_CLK (CLK7) */
@@ -228,7 +228,7 @@
 					1 30  1  0  1  0 	/* TX_EN */
 					1 31  2  0  1  0>;	/* CRS */
 			};
-			pio5: ucc_pin@05 {
+			pio5: ucc_pin@5 {
 				pio-map = <
 				/*
 				 *    		      open       has
@@ -352,12 +352,12 @@
 			reg = <0x2320 0x18>;
 			compatible = "fsl,ucc-mdio";
 
-			phy3: ethernet-phy@03 {
+			phy3: ethernet-phy@3 {
 				interrupt-parent = <&ipic>;
 				interrupts = <17 0x8>;
 				reg = <0x3>;
 			};
-			phy4: ethernet-phy@04 {
+			phy4: ethernet-phy@4 {
 				interrupt-parent = <&ipic>;
 				interrupts = <18 0x8>;
 				reg = <0x4>;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 91df1eb16667..647cae14c16d 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -175,7 +175,7 @@
 				gpio-controller;
 			};
 
-			ucc2pio:ucc_pin@02 {
+			ucc2pio:ucc_pin@2 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					3  4  3  0  2  0 	/* MDIO */
@@ -197,7 +197,7 @@
 					0 30  1  0  1  0 	/* TX_EN */
 					0 31  2  0  1  0>;      /* CRS */
 			};
-			ucc3pio:ucc_pin@03 {
+			ucc3pio:ucc_pin@3 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0 13  2  0  1  0 	/* RX_CLK (CLK9) */
@@ -310,12 +310,12 @@
 			reg = <0x3120 0x18>;
 			compatible = "fsl,ucc-mdio";
 
-			phy00:ethernet-phy@00 {
+			phy00:ethernet-phy@0 {
 				interrupt-parent = <&ipic>;
 				interrupts = <0>;
 				reg = <0x0>;
 			};
-			phy04:ethernet-phy@04 {
+			phy04:ethernet-phy@4 {
 				interrupt-parent = <&ipic>;
 				interrupts = <0>;
 				reg = <0x4>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index ecb6ccd3a6aa..539fd9f72eda 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -228,7 +228,7 @@
 				gpio-controller;
 			};
 
-			pio1: ucc_pin@01 {
+			pio1: ucc_pin@1 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0  3  1  0  1  0 	/* TxD0 */
@@ -255,7 +255,7 @@
 					2  9  1  0  3  0 	/* GTX_CLK - CLK10 */
 					2  8  2  0  1  0>;	/* GTX125 - CLK9 */
 			};
-			pio2: ucc_pin@02 {
+			pio2: ucc_pin@2 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0  17 1  0  1  0   /* TxD0 */
@@ -393,12 +393,12 @@
 			reg = <0x2120 0x18>;
 			compatible = "fsl,ucc-mdio";
 
-			phy0: ethernet-phy@00 {
+			phy0: ethernet-phy@0 {
 				interrupt-parent = <&ipic>;
 				interrupts = <17 0x8>;
 				reg = <0x0>;
 			};
-			phy1: ethernet-phy@01 {
+			phy1: ethernet-phy@1 {
 				interrupt-parent = <&ipic>;
 				interrupts = <18 0x8>;
 				reg = <0x1>;
diff --git a/arch/powerpc/boot/dts/sbc8548-altflash.dts b/arch/powerpc/boot/dts/sbc8548-altflash.dts
index 0b38a0defd2c..8967a56adad4 100644
--- a/arch/powerpc/boot/dts/sbc8548-altflash.dts
+++ b/arch/powerpc/boot/dts/sbc8548-altflash.dts
@@ -40,12 +40,12 @@
 			compatible = "intel,JS28F128", "cfi-flash";
 			bank-width = <4>;
 			device-width = <1>;
-			partition@0x0 {
+			partition@0 {
 				label = "space";
 				/* FC000000 -> FFEFFFFF */
 				reg = <0x00000000 0x03f00000>;
 			};
-			partition@0x03f00000 {
+			partition@3f00000 {
 				label = "bootloader";
 				/* FFF00000 -> FFFFFFFF */
 				reg = <0x03f00000 0x00100000>;
@@ -95,12 +95,12 @@
 			reg = <0x6 0x0 0x800000>;
 			bank-width = <1>;
 			device-width = <1>;
-			partition@0x0 {
+			partition@0 {
 				label = "space";
 				/* EF800000 -> EFF9FFFF */
 				reg = <0x00000000 0x007a0000>;
 			};
-			partition@0x7a0000 {
+			partition@7a0000 {
 				label = "bootloader";
 				/* EFFA0000 -> EFFFFFFF */
 				reg = <0x007a0000 0x00060000>;
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index 1df2a0955668..9bdb828a504e 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -38,12 +38,12 @@
 			reg = <0x0 0x0 0x800000>;
 			bank-width = <1>;
 			device-width = <1>;
-			partition@0x0 {
+			partition@0 {
 				label = "space";
 				/* FF800000 -> FFF9FFFF */
 				reg = <0x00000000 0x007a0000>;
 			};
-			partition@0x7a0000 {
+			partition@7a0000 {
 				label = "bootloader";
 				/* FFFA0000 -> FFFFFFFF */
 				reg = <0x007a0000 0x00060000>;
@@ -92,12 +92,12 @@
 			compatible = "intel,JS28F128", "cfi-flash";
 			bank-width = <4>;
 			device-width = <1>;
-			partition@0x0 {
+			partition@0 {
 				label = "space";
 				/* EC000000 -> EFEFFFFF */
 				reg = <0x00000000 0x03f00000>;
 			};
-			partition@0x03f00000 {
+			partition@3f00000 {
 				label = "bootloader";
 				/* EFF00000 -> EFFFFFFF */
 				reg = <0x03f00000 0x00100000>;
diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index 77528c9a8dbd..17a5babb098d 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -65,14 +65,14 @@
 			  0x0d800000 0x0d800000 0x00800000>;
 		interrupt-parent = <&PIC0>;
 
-		video@0c002000 {
+		video@c002000 {
 			compatible = "nintendo,hollywood-vi",
 					"nintendo,flipper-vi";
 			reg = <0x0c002000 0x100>;
 			interrupts = <8>;
 		};
 
-		processor-interface@0c003000 {
+		processor-interface@c003000 {
 			compatible = "nintendo,hollywood-pi",
 					"nintendo,flipper-pi";
 			reg = <0x0c003000 0x100>;
@@ -84,7 +84,7 @@
 			};
 		};
 
-		dsp@0c005000 {
+		dsp@c005000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "nintendo,hollywood-dsp",
@@ -93,14 +93,14 @@
 			interrupts = <6>;
 		};
 
-		gamepad-controller@0d006400 {
+		gamepad-controller@d006400 {
 			compatible = "nintendo,hollywood-si",
 					"nintendo,flipper-si";
 			reg = <0x0d006400 0x100>;
 			interrupts = <3>;
 		};
 
-		audio@0c006c00 {
+		audio@c006c00 {
 			compatible = "nintendo,hollywood-ai",
 					"nintendo,flipper-ai";
 			reg = <0x0d006c00 0x20>;
@@ -108,7 +108,7 @@
 		};
 
 		/* External Interface bus */
-		exi@0d006800 {
+		exi@d006800 {
 			compatible = "nintendo,hollywood-exi",
 					"nintendo,flipper-exi";
 			reg = <0x0d006800 0x40>;
@@ -116,7 +116,7 @@
 			interrupts = <4>;
 		};
 
-		usb@0d040000 {
+		usb@d040000 {
 			compatible = "nintendo,hollywood-usb-ehci",
 					"usb-ehci";
 			reg = <0x0d040000 0x100>;
@@ -124,7 +124,7 @@
 			interrupt-parent = <&PIC1>;
 		};
 
-		usb@0d050000 {
+		usb@d050000 {
 			compatible = "nintendo,hollywood-usb-ohci",
 					"usb-ohci";
 			reg = <0x0d050000 0x100>;
@@ -132,7 +132,7 @@
 			interrupt-parent = <&PIC1>;
 		};
 
-		usb@0d060000 {
+		usb@d060000 {
 			compatible = "nintendo,hollywood-usb-ohci",
 					"usb-ohci";
 			reg = <0x0d060000 0x100>;
@@ -140,7 +140,7 @@
 			interrupt-parent = <&PIC1>;
 		};
 
-		sd@0d070000 {
+		sd@d070000 {
 			compatible = "nintendo,hollywood-sdhci",
 					"sdhci";
 			reg = <0x0d070000 0x200>;
@@ -148,7 +148,7 @@
 			interrupt-parent = <&PIC1>;
 		};
 
-		sdio@0d080000 {
+		sdio@d080000 {
 			compatible = "nintendo,hollywood-sdhci",
 					"sdhci";
 			reg = <0x0d080000 0x200>;
@@ -156,14 +156,14 @@
 			interrupt-parent = <&PIC1>;
 		};
 
-		ipc@0d000000 {
+		ipc@d000000 {
 			compatible = "nintendo,hollywood-ipc";
 			reg = <0x0d000000 0x10>;
 			interrupts = <30>;
 			interrupt-parent = <&PIC1>;
 		};
 
-		PIC1: pic1@0d800030 {
+		PIC1: pic1@d800030 {
 			#interrupt-cells = <1>;
 			compatible = "nintendo,hollywood-pic";
 			reg = <0x0d800030 0x10>;
@@ -171,7 +171,7 @@
 			interrupts = <14>;
 		};
 
-		GPIO: gpio@0d8000c0 {
+		GPIO: gpio@d8000c0 {
 			#gpio-cells = <2>;
 			compatible = "nintendo,hollywood-gpio";
 			reg = <0x0d8000c0 0x40>;
@@ -203,12 +203,12 @@
 			*/
 		};
 
-		control@0d800100 {
+		control@d800100 {
 			compatible = "nintendo,hollywood-control";
 			reg = <0x0d800100 0x300>;
 		};
 
-		disk@0d806000 {
+		disk@d806000 {
 			compatible = "nintendo,hollywood-di";
 			reg = <0x0d806000 0x40>;
 			interrupts = <2>;
-- 
2.11.0
