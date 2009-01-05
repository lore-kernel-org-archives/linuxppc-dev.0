Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6E295DE171
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 04:41:57 +1100 (EST)
Date: Mon, 5 Jan 2009 20:41:55 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/83xx: Add PCI-E support for all MPC83xx boards
	with PCI-E
Message-ID: <20090105174155.GB8718@oksana.dev.rtsoft.ru>
References: <20090105174050.GA30219@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20090105174050.GA30219@oksana.dev.rtsoft.ru>
Cc: Huang Changming <Chang-Ming.Huang@freescale.com>,
	Liu Dave <DaveLiu@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds pcie nodes to the appropriate dts files, plus adds
some probing code for the boards.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8315erdb.dts     |   64 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8377_mds.dts     |   64 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8377_rdb.dts     |   64 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8378_mds.dts     |   64 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8378_rdb.dts     |   64 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |    2 +
 arch/powerpc/platforms/83xx/mpc837x_mds.c |    2 +
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |    2 +
 8 files changed, 326 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 072c9b0..9a4fa2a 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -22,6 +22,8 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
 	};
 
 	cpus {
@@ -349,4 +351,66 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xa0000000
+				  0x02000000 0 0xa0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xc0000000
+				  0x02000000 0 0xc0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 1d14d70..b12b9b4 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -23,6 +23,8 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
 	};
 
 	cpus {
@@ -409,4 +411,66 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xa0000000
+				  0x02000000 0 0xa0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xc0000000
+				  0x02000000 0 0xc0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 9413af3..1aed6d0 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -22,6 +22,8 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
 	};
 
 	cpus {
@@ -350,4 +352,66 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xa0000000
+				  0x02000000 0 0xa0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xc0000000
+				  0x02000000 0 0xc0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index b85fc02..771bbf4 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -23,6 +23,8 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
 	};
 
 	cpus {
@@ -395,4 +397,66 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8378-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xa0000000
+				  0x02000000 0 0xa0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8378-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xc0000000
+				  0x02000000 0 0xc0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 23c10ce..68ee09e 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -22,6 +22,8 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
 	};
 
 	cpus {
@@ -334,4 +336,66 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8378-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xa0000000
+				  0x02000000 0 0xa0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8378-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xc0000000
+				  0x02000000 0 0xc0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
 };
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index 5177bdd..b690fd7 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -38,6 +38,8 @@ static void __init mpc831x_rdb_setup_arch(void)
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8314-pcie")
+		mpc83xx_add_bridge(np);
 #endif
 	mpc831x_usb_cfg();
 }
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 530ef99..33420eb 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -92,6 +92,8 @@ static void __init mpc837x_mds_setup_arch(void)
 		}
 		mpc83xx_add_bridge(np);
 	}
+	for_each_compatible_node(np, "pci", "fsl,mpc8314-pcie")
+		mpc83xx_add_bridge(np);
 #endif
 	mpc837xmds_usb_cfg();
 }
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 1d09654..3d7b953 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -38,6 +38,8 @@ static void __init mpc837x_rdb_setup_arch(void)
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8314-pcie")
+		mpc83xx_add_bridge(np);
 #endif
 	mpc837x_usb_cfg();
 }
-- 
1.5.6.5
