Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6CA92DDEF5
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 07:10:35 +1000 (EST)
Date: Fri, 27 Jun 2008 16:10:17 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc: Add dma nodes to 83xx, 85xx and 86xx boards
In-Reply-To: <E57F448A-7217-4893-A77B-6367B0C3118A@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0806271609540.10625@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0806271449540.9071@blarg.am.freescale.net>
	<48654D6D.1090309@freescale.com>
	<E57F448A-7217-4893-A77B-6367B0C3118A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added DMA nodes for the elo/elo-plus DMA engines.

Renamed the interrupt controller alias in mpc832x_rdb.dts to ipic so that
its the same as all the other boards.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Some copy/paste bugs are now fixed (thanks Scott for actually looking at the patch).

- k

 arch/powerpc/boot/dts/asp834x-redboot.dts  |   35 ++++++++++++
 arch/powerpc/boot/dts/ksi8560.dts          |   41 ++++++++++++++
 arch/powerpc/boot/dts/mpc8313erdb.dts      |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc8315erdb.dts      |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc832x_mds.dts      |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc832x_rdb.dts      |   71 ++++++++++++++++++------
 arch/powerpc/boot/dts/mpc8349emitx.dts     |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc8349emitxgp.dts   |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc834x_mds.dts      |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc836x_mds.dts      |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc836x_rdk.dts      |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc8377_mds.dts      |   70 ++++++++++++------------
 arch/powerpc/boot/dts/mpc8377_rdb.dts      |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc8378_mds.dts      |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc8378_rdb.dts      |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc8379_mds.dts      |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc8379_rdb.dts      |   35 ++++++++++++
 arch/powerpc/boot/dts/mpc8540ads.dts       |   41 ++++++++++++++
 arch/powerpc/boot/dts/mpc8541cds.dts       |   41 ++++++++++++++
 arch/powerpc/boot/dts/mpc8548cds.dts       |   41 ++++++++++++++
 arch/powerpc/boot/dts/mpc8555cds.dts       |   41 ++++++++++++++
 arch/powerpc/boot/dts/mpc8560ads.dts       |   41 ++++++++++++++
 arch/powerpc/boot/dts/mpc8568mds.dts       |   41 ++++++++++++++
 arch/powerpc/boot/dts/mpc8572ds.dts        |   82 ++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |   41 ++++++++++++++
 arch/powerpc/boot/dts/sbc8349.dts          |   35 ++++++++++++
 arch/powerpc/boot/dts/sbc8548.dts          |   41 ++++++++++++++
 arch/powerpc/boot/dts/sbc8560.dts          |   41 ++++++++++++++
 arch/powerpc/boot/dts/sbc8641d.dts         |   41 ++++++++++++++
 arch/powerpc/boot/dts/stx_gp3_8560.dts     |   41 ++++++++++++++
 arch/powerpc/boot/dts/tqm8540.dts          |   41 ++++++++++++++
 arch/powerpc/boot/dts/tqm8541.dts          |   41 ++++++++++++++
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |   41 ++++++++++++++
 arch/powerpc/boot/dts/tqm8548.dts          |   41 ++++++++++++++
 arch/powerpc/boot/dts/tqm8555.dts          |   41 ++++++++++++++
 arch/powerpc/boot/dts/tqm8560.dts          |   41 ++++++++++++++
 36 files changed, 1433 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/boot/dts/asp834x-redboot.dts b/arch/powerpc/boot/dts/asp834x-redboot.dts
index 972cf78..8b1bb0e 100644
--- a/arch/powerpc/boot/dts/asp834x-redboot.dts
+++ b/arch/powerpc/boot/dts/asp834x-redboot.dts
@@ -118,6 +118,41 @@
 			mode = "cpu";
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8347-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8347-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8347-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8347-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8347-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		/* phy type (ULPI or SERIAL) are only types supported for MPH */
 		/* port = 0 or 1 */
 		usb@22000 {
diff --git a/arch/powerpc/boot/dts/ksi8560.dts b/arch/powerpc/boot/dts/ksi8560.dts
index 6eb7c77..fd58043 100644
--- a/arch/powerpc/boot/dts/ksi8560.dts
+++ b/arch/powerpc/boot/dts/ksi8560.dts
@@ -83,6 +83,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8560-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {					/* For TSECs */
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index e1f0dca..b206843 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -144,6 +144,41 @@
 			mode = "cpu";
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8313-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8313-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8313-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8313-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8313-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index d7a1ece..a40e806 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -132,6 +132,41 @@
 			mode = "cpu";
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8315-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 539e02f..b5968b6 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -114,6 +114,41 @@
 			interrupt-parent = <&ipic>;
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8323-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		crypto@30000 {
 			device_type = "crypto";
 			model = "SEC2";
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 179c81c..a798d86 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -68,7 +68,7 @@
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
 			interrupts = <14 0x8>;
-			interrupt-parent = <&pic>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};

@@ -79,7 +79,7 @@
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
-			interrupt-parent = <&pic>;
+			interrupt-parent = <&ipic>;
 		};

 		serial1: serial@4600 {
@@ -89,7 +89,42 @@
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
-			interrupt-parent = <&pic>;
+			interrupt-parent = <&ipic>;
+		};
+
+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8323-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
 		};

 		crypto@30000 {
@@ -98,7 +133,7 @@
 			compatible = "talitos";
 			reg = <0x30000 0x7000>;
 			interrupts = <11 0x8>;
-			interrupt-parent = <&pic>;
+			interrupt-parent = <&ipic>;
 			/* Rev. 2.2 */
 			num-channels = <1>;
 			channel-fifo-len = <24>;
@@ -106,7 +141,7 @@
 			descriptor-types-mask = <0x0122003f>;
 		};

-		pic:pic@700 {
+		ipic:pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
@@ -240,13 +275,13 @@
 			compatible = "fsl,ucc-mdio";

 			phy00:ethernet-phy@00 {
-				interrupt-parent = <&pic>;
+				interrupt-parent = <&ipic>;
 				interrupts = <0>;
 				reg = <0x0>;
 				device_type = "ethernet-phy";
 			};
 			phy04:ethernet-phy@04 {
-				interrupt-parent = <&pic>;
+				interrupt-parent = <&ipic>;
 				interrupts = <0>;
 				reg = <0x4>;
 				device_type = "ethernet-phy";
@@ -261,7 +296,7 @@
 			reg = <0x80 0x80>;
 			big-endian;
 			interrupts = <32 0x8 33 0x8>; //high:32 low:33
-			interrupt-parent = <&pic>;
+			interrupt-parent = <&ipic>;
 		};
 	};

@@ -270,21 +305,21 @@
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 				/* IDSEL 0x10 AD16 (USB) */
-				 0x8000 0x0 0x0 0x1 &pic 17 0x8
+				 0x8000 0x0 0x0 0x1 &ipic 17 0x8

 				/* IDSEL 0x11 AD17 (Mini1)*/
-				 0x8800 0x0 0x0 0x1 &pic 18 0x8
-				 0x8800 0x0 0x0 0x2 &pic 19 0x8
-				 0x8800 0x0 0x0 0x3 &pic 20 0x8
-				 0x8800 0x0 0x0 0x4 &pic 48 0x8
+				 0x8800 0x0 0x0 0x1 &ipic 18 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 19 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 20 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 48 0x8

 				/* IDSEL 0x12 AD18 (PCI/Mini2) */
-				 0x9000 0x0 0x0 0x1 &pic 19 0x8
-				 0x9000 0x0 0x0 0x2 &pic 20 0x8
-				 0x9000 0x0 0x0 0x3 &pic 48 0x8
-				 0x9000 0x0 0x0 0x4 &pic 17 0x8>;
+				 0x9000 0x0 0x0 0x1 &ipic 19 0x8
+				 0x9000 0x0 0x0 0x2 &ipic 20 0x8
+				 0x9000 0x0 0x0 0x3 &ipic 48 0x8
+				 0x9000 0x0 0x0 0x4 &ipic 17 0x8>;

-		interrupt-parent = <&pic>;
+		interrupt-parent = <&ipic>;
 		interrupts = <66 0x8>;
 		bus-range = <0x0 0x0>;
 		ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 9426676..fc0f4c9 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -93,6 +93,41 @@
 			mode = "cpu";
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		usb@22000 {
 			compatible = "fsl-usb2-mph";
 			reg = <0x22000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index f81d735..e6afb1d 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -91,6 +91,41 @@
 			mode = "cpu";
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 0199c5c..9c75c7c 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -103,6 +103,41 @@
 			mode = "cpu";
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		/* phy type (ULPI or SERIAL) are only types supported for MPH */
 		/* port = 0 or 1 */
 		usb@22000 {
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 8160ff2..8e33b15 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -118,6 +118,41 @@
 			interrupt-parent = <&ipic>;
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8360-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		crypto@30000 {
 			device_type = "crypto";
 			model = "SEC2";
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index 3402d26..8acd1d6 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -113,6 +113,41 @@
 			clock-frequency = <0>;
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8360-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		crypto@30000 {
 			compatible = "fsl,sec2-crypto";
 			reg = <0x30000 0x10000>;
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index fea5925..49a38cb 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -233,41 +233,6 @@
 			interrupt-parent = <&ipic>;
 		};

-		crypto@30000 {
-			model = "SEC3";
-			compatible = "talitos";
-			reg = <0x30000 0x10000>;
-			interrupts = <11 0x8>;
-			interrupt-parent = <&ipic>;
-			/* Rev. 3.0 geometry */
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x000001fe>;
-			descriptor-types-mask = <0x03ab0ebf>;
-		};
-
-		sdhc@2e000 {
-			model = "eSDHC";
-			compatible = "fsl,esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <42 0x8>;
-			interrupt-parent = <&ipic>;
-		};
-
-		sata@18000 {
-			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
-			reg = <0x18000 0x1000>;
-			interrupts = <44 0x8>;
-			interrupt-parent = <&ipic>;
-		};
-
-		sata@19000 {
-			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
-			reg = <0x19000 0x1000>;
-			interrupts = <45 0x8>;
-			interrupt-parent = <&ipic>;
-		};
-
 		dma@82a8 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -303,6 +268,41 @@
 			};
 		};

+		crypto@30000 {
+			model = "SEC3";
+			compatible = "talitos";
+			reg = <0x30000 0x10000>;
+			interrupts = <11 0x8>;
+			interrupt-parent = <&ipic>;
+			/* Rev. 3.0 geometry */
+			num-channels = <4>;
+			channel-fifo-len = <24>;
+			exec-units-mask = <0x000001fe>;
+			descriptor-types-mask = <0x03ab0ebf>;
+		};
+
+		sdhc@2e000 {
+			model = "eSDHC";
+			compatible = "fsl,esdhc";
+			reg = <0x2e000 0x1000>;
+			interrupts = <42 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		sata@18000 {
+			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
+			reg = <0x18000 0x1000>;
+			interrupts = <44 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		sata@19000 {
+			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
+			reg = <0x19000 0x1000>;
+			interrupts = <45 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
 		/* IPIC
 		 * interrupts cell = <intr #, sense>
 		 * sense values match linux IORESOURCE_IRQ_* defines:
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 5bc09ad..e05743a 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -143,6 +143,41 @@
 			mode = "cpu";
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8377-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 1d6ea08..99ad49d 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -157,6 +157,41 @@
 			mode = "cpu";
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8378-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 711f9a3..a8bdbaa 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -143,6 +143,41 @@
 			mode = "cpu";
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8378-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index 6f78a9f..980be81 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -157,6 +157,41 @@
 			mode = "cpu";
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8379-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index c11ceb7..9d636e3 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -143,6 +143,41 @@
 			mode = "cpu";
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8379-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 79881a1..f2273a8 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -84,6 +84,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8540-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8540-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8540-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8540-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 66192aa..21ad71b 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -84,6 +84,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8541-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8541-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8541-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8541-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8541-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 205598d..621388d 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -100,6 +100,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8548-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 7c9d0b1..6fc8059 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -84,6 +84,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8555-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8555-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8555-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8555-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8555-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 5d9f3c4..ba8159d 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -73,6 +73,47 @@
 			interrupts = <16 2>;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8560-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index d7af8db..be9a289 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -107,6 +107,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8568-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8568-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8568-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8568-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8568-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index a444e6a..cb06325 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -117,6 +117,88 @@
 			dfsrr;
 		};

+		dma@c300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
+			reg = <0xc300 0x4>;
+			ranges = <0x0 0xc100 0x200>;
+			cell-index = <1>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <76 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <77 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <78 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <79 2>;
+			};
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 14f718d..ae08761 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -134,6 +134,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index 3839d4b..5b76bb2 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -95,6 +95,41 @@
 			mode = "cpu";
 		};

+		dma@82a8 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
+			reg = <0x82a8 4>;
+			ranges = <0 0x8100 0x1a8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <71 8>;
+			};
+		};
+
 		/* phy type (ULPI or SERIAL) are only types supported for MPH */
 		/* port = 0 or 1 */
 		usb@22000 {
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index d252e38..21cbacb 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -193,6 +193,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8548-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
index e556c5a..db3632e 100644
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -98,6 +98,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8560-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/sbc8641d.dts b/arch/powerpc/boot/dts/sbc8641d.dts
index 3eebeec..9652456 100644
--- a/arch/powerpc/boot/dts/sbc8641d.dts
+++ b/arch/powerpc/boot/dts/sbc8641d.dts
@@ -151,6 +151,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/stx_gp3_8560.dts b/arch/powerpc/boot/dts/stx_gp3_8560.dts
index 1e61283..fcd1db6 100644
--- a/arch/powerpc/boot/dts/stx_gp3_8560.dts
+++ b/arch/powerpc/boot/dts/stx_gp3_8560.dts
@@ -83,6 +83,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8560-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index 3504db3..e1d260b 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -90,6 +90,47 @@
 			};
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8540-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8540-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8540-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8540-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index 8241ae3..d083a64 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -89,6 +89,47 @@
 			};
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8541-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8541-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8541-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8541-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8541-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index d8a1b19..64d2d5b 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -96,6 +96,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8548-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index e80b450..13cd728 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -96,6 +96,47 @@
 			dfsrr;
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8548-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index 5a57cef..96b0b94 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -89,6 +89,47 @@
 			};
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8555-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8555-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8555-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8555-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8555-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index 6794882..3fe3520 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -91,6 +91,47 @@
 			};
 		};

+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8560-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8560-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.5.5.1
