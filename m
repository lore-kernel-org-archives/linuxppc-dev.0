Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7602BDE0FA
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 18:54:15 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lBC7sArq031043
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 01:54:11 -0600
Date: Wed, 12 Dec 2007 01:52:33 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] FSL: Added aliases node to device trees
Message-ID: <Pine.LNX.4.64.0712120152080.25255@blarg.am.freescale.net>
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

Added aliases nodes for kurobox, 83xx, 85xx, and 86xx platforms.
This included added labels and cell-index properties for serial and
pci nodes.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/kuroboxHD.dts      |   14 +++++++++++---
 arch/powerpc/boot/dts/kuroboxHG.dts      |   14 +++++++++++---
 arch/powerpc/boot/dts/mpc8313erdb.dts    |   17 ++++++++++++++---
 arch/powerpc/boot/dts/mpc832x_mds.dts    |   17 ++++++++++++++---
 arch/powerpc/boot/dts/mpc832x_rdb.dts    |   17 ++++++++++++++---
 arch/powerpc/boot/dts/mpc8349emitx.dts   |   21 +++++++++++++++++----
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |   16 +++++++++++++---
 arch/powerpc/boot/dts/mpc834x_mds.dts    |   21 +++++++++++++++++----
 arch/powerpc/boot/dts/mpc836x_mds.dts    |   17 ++++++++++++++---
 arch/powerpc/boot/dts/mpc8540ads.dts     |   18 +++++++++++++++---
 arch/powerpc/boot/dts/mpc8541cds.dts     |   23 ++++++++++++++++++-----
 arch/powerpc/boot/dts/mpc8544ds.dts      |   30 +++++++++++++++++++++++-------
 arch/powerpc/boot/dts/mpc8548cds.dts     |   29 ++++++++++++++++++++++++-----
 arch/powerpc/boot/dts/mpc8555cds.dts     |   23 ++++++++++++++++++-----
 arch/powerpc/boot/dts/mpc8560ads.dts     |   17 ++++++++++++++---
 arch/powerpc/boot/dts/mpc8568mds.dts     |   23 +++++++++++++++++++----
 arch/powerpc/boot/dts/mpc8572ds.dts      |   27 ++++++++++++++++++++++-----
 arch/powerpc/boot/dts/mpc8610_hpcd.dts   |   20 +++++++++++++++-----
 arch/powerpc/boot/dts/mpc8641_hpcn.dts   |    4 ++++
 19 files changed, 297 insertions(+), 71 deletions(-)

diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index 1c14dcd..4469588 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -23,6 +23,12 @@ XXXX add flash parts, rtc, ??
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -73,7 +79,8 @@ XXXX add flash parts, rtc, ??
 			};
 		};

-		serial@80004500 {
+		serial0: serial@80004500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <80004500 8>;
@@ -83,7 +90,8 @@ XXXX add flash parts, rtc, ??
 			interrupt-parent = <&mpic>;
 		};

-		serial@80004600 {
+		serial1: serial@80004600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <80004600 8>;
@@ -102,7 +110,7 @@ XXXX add flash parts, rtc, ??
 			reg = <80040000 40000>;
 		};

-		pci@fec00000 {
+		pci0: pci@fec00000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index 1b973fa..8443c85 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -23,6 +23,12 @@ XXXX add flash parts, rtc, ??
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -73,7 +79,8 @@ XXXX add flash parts, rtc, ??
 			};
 		};

-		serial@80004500 {
+		serial0: serial@80004500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <80004500 8>;
@@ -83,7 +90,8 @@ XXXX add flash parts, rtc, ??
 			interrupt-parent = <&mpic>;
 		};

-		serial@80004600 {
+		serial1: serial@80004600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <80004600 8>;
@@ -102,7 +110,7 @@ XXXX add flash parts, rtc, ??
 			reg = <80040000 40000>;
 		};

-		pci@fec00000 {
+		pci0: pci@fec00000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 2f83050..c5b6665 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -15,6 +15,14 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -137,7 +145,8 @@
 			phy-handle = < &phy4 >;
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -146,7 +155,8 @@
 			interrupt-parent = < &ipic >;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -184,7 +194,8 @@
 		};
 	};

-	pci@e0008500 {
+	pci0: pci@e0008500 {
+		cell-index = <1>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index b0d89d6..5a88187 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -15,6 +15,14 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -72,7 +80,8 @@
 			};
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -81,7 +90,8 @@
 			interrupt-parent = < &ipic >;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -273,7 +283,8 @@
 		};
 	};

-	pci@e0008500 {
+	pci0: pci@e0008500 {
+		cell-index = <1>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <
 				/* IDSEL 0x11 AD17 */
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 0c64381..d314986 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -15,6 +15,14 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -62,7 +70,8 @@
 			dfsrr;
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -71,7 +80,8 @@
 			interrupt-parent = <&pic>;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -254,7 +264,8 @@
 		};
 	};

-	pci@e0008500 {
+	pci0: pci@e0008500 {
+		cell-index = <1>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <
 				/* IDSEL 0x10 AD16 (USB) */
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index d2184ad..e354f26 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -14,6 +14,15 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -154,7 +163,8 @@
 			linux,network-index = <1>;
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -163,7 +173,8 @@
 			interrupt-parent = < &ipic >;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -194,7 +205,8 @@
 		};
 	};

-	pci@e0008500 {
+	pci0: pci@e0008500 {
+		cell-index = <1>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <
 				/* IDSEL 0x10 - SATA */
@@ -215,7 +227,8 @@
 		device_type = "pci";
 	};

-	pci@e0008600 {
+	pci1: pci@e0008600 {
+		cell-index = <2>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <
 				/* IDSEL 0x0E - MiniPCI Slot */
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index 30c6816..ebdf0b7 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -14,6 +14,13 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -121,7 +128,8 @@
 			linux,network-index = <0>;
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -130,7 +138,8 @@
 			interrupt-parent = < &ipic >;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -161,7 +170,8 @@
 		};
 	};

-	pci@e0008600 {
+	pci0: pci@e0008600 {
+		cell-index = <2>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <
 				/* IDSEL 0x0F - PCI Slot */
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index c5239c9..0ba13eb 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -15,6 +15,15 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -164,7 +173,8 @@
 			linux,network-index = <1>;
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -173,7 +183,8 @@
 			interrupt-parent = < &ipic >;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -213,7 +224,8 @@
 		};
 	};

-	pci@e0008500 {
+	pci0: pci@e0008500 {
+		cell-index = <1>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <

@@ -273,7 +285,8 @@
 		device_type = "pci";
 	};

-	pci@e0008600 {
+	pci1: pci@e0008600 {
+		cell-index = <2>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <

diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 3b0873a..ea07a6f 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -20,6 +20,14 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -88,7 +96,8 @@
 			dfsrr;
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -97,7 +106,8 @@
 			interrupt-parent = < &ipic >;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -306,7 +316,8 @@
 		};
 	};

-	pci@e0008500 {
+	pci0: pci@e0008500 {
+		cell-index = <1>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <

diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 7961d91..9752484 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -16,6 +16,15 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -135,7 +144,8 @@
 			phy-handle = <&phy3>;
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>; 	// reg base, size
@@ -144,7 +154,8 @@
 			interrupt-parent = <&mpic>;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;	// reg base, size
@@ -164,7 +175,8 @@
 		};
 	};

-	pci@e0008000 {
+	pci0: pci@e0008000 {
+		cell-index = <0>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <

diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 8637fe0..fa8d9aa 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -16,6 +16,15 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -117,7 +126,8 @@
 			phy-handle = <&phy1>;
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>; 	// reg base, size
@@ -126,7 +136,8 @@
 			interrupt-parent = <&mpic>;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;	// reg base, size
@@ -183,7 +194,8 @@
 		};
 	};

-	pci1: pci@e0008000 {
+	pci0: pci@e0008000 {
+		cell-index = <0>;
 		interrupt-map-mask = <1f800 0 0 7>;
 		interrupt-map = <

@@ -250,11 +262,12 @@
 			#interrupt-cells = <2>;
 			compatible = "chrp,iic";
 			interrupts = <1>;
-			interrupt-parent = <&pci1>;
+			interrupt-parent = <&pci0>;
 		};
 	};

-	pci@e0009000 {
+	pci1: pci@e0009000 {
+		cell-index = <1>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index a98c46e..54b3bdf 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -15,6 +15,17 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

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
 	cpus {
 		#cpus = <1>;
 		#address-cells = <1>;
@@ -131,7 +142,8 @@
 			phy-connection-type = "rgmii-id";
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -140,7 +152,8 @@
 			interrupt-parent = <&mpic>;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -167,7 +180,8 @@
 		};
 	};

-	pci@e0008000 {
+	pci0: pci@e0008000 {
+		cell-index = <0>;
 		compatible = "fsl,mpc8540-pci";
 		device_type = "pci";
 		interrupt-map-mask = <f800 0 0 7>;
@@ -198,7 +212,8 @@
 		reg = <e0008000 1000>;
 	};

-	pcie@e0009000 {
+	pci1: pcie@e0009000 {
+		cell-index = <1>;
 		compatible = "fsl,mpc8548-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
@@ -234,7 +249,8 @@
 		};
 	};

-	pcie@e000a000 {
+	pci2: pcie@e000a000 {
+		cell-index = <2>;
 		compatible = "fsl,mpc8548-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
@@ -270,7 +286,8 @@
 		};
 	};

-	pcie@e000b000 {
+	pci3: pcie@e000b000 {
+		cell-index = <3>;
 		compatible = "fsl,mpc8548-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
@@ -380,6 +397,5 @@
 				};
 			};
 		};
-
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 64f83d0..1f470c6 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -16,6 +16,20 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+/*
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+*/
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -166,7 +180,8 @@
 		};
  */

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;	// reg base, size
@@ -175,7 +190,8 @@
 			interrupt-parent = <&mpic>;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;	// reg base, size
@@ -202,7 +218,8 @@
 		};
 	};

-	pci@e0008000 {
+	pci0: pci@e0008000 {
+		cell-index = <0>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x4 (PCIX Slot 2) */
@@ -351,7 +368,8 @@
 		};
 	};

-	pci@e0009000 {
+	pci1: pci@e0009000 {
+		cell-index = <1>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <

@@ -375,7 +393,8 @@
 		device_type = "pci";
 	};

-	pcie@e000a000 {
+	pci2: pcie@e000a000 {
+		cell-index = <2>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <

diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 339e873..4538f3c 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -16,6 +16,15 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -117,7 +126,8 @@
 			phy-handle = <&phy1>;
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>; 	// reg base, size
@@ -126,7 +136,8 @@
 			interrupt-parent = <&mpic>;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;	// reg base, size
@@ -183,7 +194,8 @@
 		};
 	};

-	pci1: pci@e0008000 {
+	pci0: pci@e0008000 {
+		cell-index = <0>;
 		interrupt-map-mask = <1f800 0 0 7>;
 		interrupt-map = <

@@ -250,11 +262,12 @@
 			#interrupt-cells = <2>;
 			compatible = "chrp,iic";
 			interrupts = <1>;
-			interrupt-parent = <&pci1>;
+			interrupt-parent = <&pci0>;
 		};
 	};

-	pci@e0009000 {
+	pci1: pci@e0009000 {
+		cell-index = <1>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <

diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 936a4d5..639ce8a 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -16,6 +16,16 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -162,7 +172,7 @@
 				compatible = "fsl,mpc8560-cpm-pic", "fsl,cpm2-pic";
 			};

-			serial@91a00 {
+			serial0: serial@91a00 {
 				device_type = "serial";
 				compatible = "fsl,mpc8560-scc-uart",
 				             "fsl,cpm2-scc-uart";
@@ -174,7 +184,7 @@
 				interrupt-parent = <&cpmpic>;
 			};

-			serial@91a20 {
+			serial1: serial@91a20 {
 				device_type = "serial";
 				compatible = "fsl,mpc8560-scc-uart",
 				             "fsl,cpm2-scc-uart";
@@ -212,7 +222,8 @@
 		};
 	};

-	pci@e0008000 {
+	pci0: pci@e0008000 {
+		cell-index = <0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 60f0eab..90545b1 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -20,6 +20,17 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -154,7 +165,8 @@
 			phy-handle = <&phy3>;
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -169,7 +181,8 @@
 			fsl,has-rstcr;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -385,7 +398,8 @@

 	};

-	pci@e0008000 {
+	pci0: pci@e0008000 {
+		cell-index = <0>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x12 AD18 */
@@ -415,7 +429,8 @@
 	};

 	/* PCI Express */
-	pcie@e000a000 {
+	pci1: pcie@e000a000 {
+		cell-index = <2>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <

diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index c2a8ffa..233e0d5 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -15,6 +15,18 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -170,7 +182,8 @@
 			phy-connection-type = "rgmii-id";
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -179,7 +192,8 @@
 			interrupt-parent = <&mpic>;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -206,7 +220,8 @@
 		};
 	};

-	pcie@ffe08000 {
+	pci0: pcie@ffe08000 {
+		cell-index = <0>;
 		compatible = "fsl,mpc8548-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
@@ -415,7 +430,8 @@

 	};

-	pcie@ffe09000 {
+	pci1: pcie@ffe09000 {
+		cell-index = <1>;
 		compatible = "fsl,mpc8548-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
@@ -451,7 +467,8 @@
 		};
 	};

-	pcie@ffe0a000 {
+	pci2: pcie@ffe0a000 {
+		cell-index = <2>;
 		compatible = "fsl,mpc8548-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index e9c444e..01040a7 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -15,6 +15,13 @@
 	#address-cells = <1>;
 	#size-cells = <1>;

+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -68,7 +75,8 @@
 			dfsrr;
 		};

-		serial@4500 {
+		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -77,7 +85,8 @@
 			interrupt-parent = <&mpic>;
 		};

-		serial@4600 {
+		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -86,7 +95,6 @@
 			interrupt-parent = <&mpic>;
 		};

-
 		mpic: interrupt-controller@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
@@ -105,7 +113,8 @@
 		};
 	};

-	pci@e0008000 {
+	pci0: pci@e0008000 {
+		cell-index = <0>;
 		compatible = "fsl,mpc8610-pci";
 		device_type = "pci";
 		#interrupt-cells = <1>;
@@ -134,7 +143,8 @@
 			>;
 	};

-	pcie@e000a000 {
+	pci1: pcie@e000a000 {
+		cell-index = <1>;
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index ddd8fbb..86fc228 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -175,6 +175,7 @@
 		};

 		serial0: serial@4500 {
+			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -184,6 +185,7 @@
 		};

 		serial1: serial@4600 {
+			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -211,6 +213,7 @@
 	};

 	pci0: pcie@f8008000 {
+		cell-index = <0>;
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
@@ -419,6 +422,7 @@
 	};

 	pci1: pcie@f8009000 {
+		cell-index = <1>;
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
-- 
1.5.3.4
