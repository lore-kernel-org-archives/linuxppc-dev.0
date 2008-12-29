Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 45F10DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Dec 2008 03:40:42 +1100 (EST)
Date: Mon, 29 Dec 2008 19:40:40 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx boards
	with PCI-E
Message-ID: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Tony Li <tony.li@freescale.com>
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

Note that the nodes are disabled by default (via status property),
since old (community) U-Boots don't configure PCI-E controllers.

Also, remove of_device_is_avaliable() check from the mpc837x_mds.c
board file, as mpc83xx_add_bridge() has the same check now.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8315erdb.dts     |   42 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8377_mds.dts     |   42 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8377_rdb.dts     |   42 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8378_mds.dts     |   42 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8378_rdb.dts     |   42 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |    2 +
 arch/powerpc/platforms/83xx/mpc837x_mds.c |   10 ++-----
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |    2 +
 8 files changed, 217 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index d3d3097..5997325 100644
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
@@ -330,4 +332,44 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pcie";
+		compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pcie";
+		compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000 0xd0000000 0x01000000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 0484561..61c3303 100644
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
@@ -390,4 +392,44 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pcie";
+		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pcie";
+		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000 0xd0000000 0x01000000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 9fe8e4c..54baea7 100644
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
@@ -331,4 +333,44 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pcie";
+		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pcie";
+		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000 0xd0000000 0x01000000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 67a08d2..cc66008 100644
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
@@ -376,4 +378,44 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pcie";
+		compatible = "fsl,mpc8378-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pcie";
+		compatible = "fsl,mpc8378-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000 0xd0000000 0x01000000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 3a6d528..ab89f8f 100644
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
@@ -317,4 +319,44 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pcie";
+		compatible = "fsl,mpc8378-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pcie";
+		compatible = "fsl,mpc8378-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000 0xd0000000 0x01000000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+	};
 };
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index 5177bdd..821b11b 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -38,6 +38,8 @@ static void __init mpc831x_rdb_setup_arch(void)
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pcie", "fsl,mpc8314-pcie")
+		mpc83xx_add_bridge(np);
 #endif
 	mpc831x_usb_cfg();
 }
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 530ef99..a8593f2 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -84,14 +84,10 @@ static void __init mpc837x_mds_setup_arch(void)
 		ppc_md.progress("mpc837x_mds_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") {
-		if (!of_device_is_available(np)) {
-			pr_warning("%s: disabled by the firmware.\n",
-				   np->full_name);
-			continue;
-		}
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
+		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pcie", "fsl,mpc8314-pcie")
 		mpc83xx_add_bridge(np);
-	}
 #endif
 	mpc837xmds_usb_cfg();
 }
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 1d09654..011b4c4 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -38,6 +38,8 @@ static void __init mpc837x_rdb_setup_arch(void)
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pcie", "fsl,mpc8314-pcie")
+		mpc83xx_add_bridge(np);
 #endif
 	mpc837x_usb_cfg();
 }
-- 
1.5.6.5
