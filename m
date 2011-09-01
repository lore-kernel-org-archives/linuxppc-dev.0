Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A84F1007FC
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2011 05:26:45 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] powerpc/85xx: Adding DCSR node to dtsi device trees
Date: Thu,  1 Sep 2011 14:26:38 -0500
Message-Id: <1314905198-4440-1-git-send-email-galak@kernel.crashing.org>
Cc: devicetree-discuss@lists.ozlabs.org,
	Stephen George <stephen.george@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen George <stephen.george@freescale.com>

Adding new device tree binding file for the DCSR node.  Modifying device
tree dtsi files to add DCSR node for P2041, P3041, P3060, P4080, & P5020.

Signed-off-by: Stephen George <stephen.george@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p2041rdb.dts |    4 ++
 arch/powerpc/boot/dts/p2041si.dtsi |   70 +++++++++++++++++++++++++-
 arch/powerpc/boot/dts/p3041ds.dts  |    4 ++
 arch/powerpc/boot/dts/p3041si.dtsi |   70 +++++++++++++++++++++++++-
 arch/powerpc/boot/dts/p3060qds.dts |    4 ++
 arch/powerpc/boot/dts/p3060si.dtsi |   80 +++++++++++++++++++++++++++++-
 arch/powerpc/boot/dts/p4080ds.dts  |    4 ++
 arch/powerpc/boot/dts/p4080si.dtsi |   97 +++++++++++++++++++++++++++++++++++-
 arch/powerpc/boot/dts/p5020ds.dts  |    4 ++
 arch/powerpc/boot/dts/p5020si.dtsi |   67 ++++++++++++++++++++++++-
 10 files changed, 397 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/p2041rdb.dts
index 47bb461..79b6895 100644
--- a/arch/powerpc/boot/dts/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/p2041rdb.dts
@@ -45,6 +45,10 @@
 		device_type = "memory";
 	};
 
+	dcsr: dcsr@f00000000 {
+		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
+	};
+
 	soc: soc@ffe000000 {
 		spi@110000 {
 			flash@0 {
diff --git a/arch/powerpc/boot/dts/p2041si.dtsi b/arch/powerpc/boot/dts/p2041si.dtsi
index 420cdb0..628ba82 100644
--- a/arch/powerpc/boot/dts/p2041si.dtsi
+++ b/arch/powerpc/boot/dts/p2041si.dtsi
@@ -109,6 +109,74 @@
 		};
 	};
 
+	dcsr: dcsr@f00000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,dcsr", "simple-bus";
+
+		dcsr-epu@0 {
+			compatible = "fsl,dcsr-epu";
+			interrupts = <36 2 0 0
+				      68 2 0 0
+				      69 2 0 0>;
+			interrupt-parent = <&mpic>;
+			reg = <0x0 0x1000>;
+		};
+		dcsr-npc {
+			compatible = "fsl,dcsr-npc";
+			reg = <0x1000 0x1000 0x1000000 0x8000>;
+		};
+		dcsr-nxc@2000 {
+			compatible = "fsl,dcsr-nxc";
+			reg = <0x2000 0x1000>;
+		};
+		dcsr-corenet {
+			compatible = "fsl,dcsr-corenet";
+			reg = <0x8000 0x1000 0xB0000 0x1000>;
+		};
+		dcsr-dpaa@9000 {
+			compatible = "fsl,p2041-dcsr-dpaa", "fsl,dcsr-dpaa";
+			reg = <0x9000 0x1000>;
+		};
+		dcsr-ocn@11000 {
+			compatible = "fsl,p2041-dcsr-ocn", "fsl,dcsr-ocn";
+			reg = <0x11000 0x1000>;
+		};
+		dcsr-ddr@12000 {
+			compatible = "fsl,dcsr-ddr";
+			dev-handle = <&ddr>;
+			reg = <0x12000 0x1000>;
+		};
+		dcsr-nal@18000 {
+			compatible = "fsl,p2041-dcsr-nal", "fsl,dcsr-nal";
+			reg = <0x18000 0x1000>;
+		};
+		dcsr-rcpm@22000 {
+			compatible = "fsl,p2041-dcsr-rcpm", "fsl,dcsr-rcpm";
+			reg = <0x22000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@40000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu0>;
+			reg = <0x40000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@41000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu1>;
+			reg = <0x41000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@42000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu2>;
+			reg = <0x42000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@43000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu3>;
+			reg = <0x43000 0x1000>;
+		};
+	};
+
 	soc: soc@ffe000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -128,7 +196,7 @@
 			fsl,num-laws = <32>;
 		};
 
-		memory-controller@8000 {
+		ddr: memory-controller@8000 {
 			compatible = "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-controller";
 			reg = <0x8000 0x1000>;
 			interrupts = <16 2 1 23>;
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index 69cae67..ce15726 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -45,6 +45,10 @@
 		device_type = "memory";
 	};
 
+	dcsr: dcsr@f00000000 {
+		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
+	};
+
 	soc: soc@ffe000000 {
 		spi@110000 {
 			flash@0 {
diff --git a/arch/powerpc/boot/dts/p3041si.dtsi b/arch/powerpc/boot/dts/p3041si.dtsi
index 8b69580..0468899 100644
--- a/arch/powerpc/boot/dts/p3041si.dtsi
+++ b/arch/powerpc/boot/dts/p3041si.dtsi
@@ -133,7 +133,7 @@
 			fsl,num-laws = <32>;
 		};
 
-		memory-controller@8000 {
+		ddr: memory-controller@8000 {
 			compatible = "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-controller";
 			reg = <0x8000 0x1000>;
 			interrupts = <16 2 1 23>;
@@ -542,6 +542,74 @@
 	rapidio0: rapidio@ffe0c0000
 */
 
+	dcsr: dcsr@f00000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,dcsr", "simple-bus";
+
+		dcsr-epu@0 {
+			compatible = "fsl,dcsr-epu";
+			interrupts = <36 2 0 0
+				      68 2 0 0
+				      69 2 0 0>;
+			interrupt-parent = <&mpic>;
+			reg = <0x0 0x1000>;
+		};
+		dcsr-npc {
+			compatible = "fsl,dcsr-npc";
+			reg = <0x1000 0x1000 0x1000000 0x8000>;
+		};
+		dcsr-nxc@2000 {
+			compatible = "fsl,dcsr-nxc";
+			reg = <0x2000 0x1000>;
+		};
+		dcsr-corenet {
+			compatible = "fsl,dcsr-corenet";
+			reg = <0x8000 0x1000 0xB0000 0x1000>;
+		};
+		dcsr-dpaa@9000 {
+			compatible = "fsl,p43041-dcsr-dpaa", "fsl,dcsr-dpaa";
+			reg = <0x9000 0x1000>;
+		};
+		dcsr-ocn@11000 {
+			compatible = "fsl,p43041-dcsr-ocn", "fsl,dcsr-ocn";
+			reg = <0x11000 0x1000>;
+		};
+		dcsr-ddr@12000 {
+			compatible = "fsl,dcsr-ddr";
+			dev-handle = <&ddr>;
+			reg = <0x12000 0x1000>;
+		};
+		dcsr-nal@18000 {
+			compatible = "fsl,p43041-dcsr-nal", "fsl,dcsr-nal";
+			reg = <0x18000 0x1000>;
+		};
+		dcsr-rcpm@22000 {
+			compatible = "fsl,p43041-dcsr-rcpm", "fsl,dcsr-rcpm";
+			reg = <0x22000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@40000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu0>;
+			reg = <0x40000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@41000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu1>;
+			reg = <0x41000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@42000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu2>;
+			reg = <0x42000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@43000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu3>;
+			reg = <0x43000 0x1000>;
+		};
+	};
+
 	localbus@ffe124000 {
 		compatible = "fsl,p3041-elbc", "fsl,elbc", "simple-bus";
 		interrupts = <25 2 0 0>;
diff --git a/arch/powerpc/boot/dts/p3060qds.dts b/arch/powerpc/boot/dts/p3060qds.dts
index bf3844b..89beeab 100644
--- a/arch/powerpc/boot/dts/p3060qds.dts
+++ b/arch/powerpc/boot/dts/p3060qds.dts
@@ -45,6 +45,10 @@
 		device_type = "memory";
 	};
 
+	dcsr: dcsr@f00000000 {
+		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
+	};
+
 	soc: soc@ffe000000 {
 		spi@110000 {
 			flash@0 {
diff --git a/arch/powerpc/boot/dts/p3060si.dtsi b/arch/powerpc/boot/dts/p3060si.dtsi
index 0e2cd10..65fe383 100644
--- a/arch/powerpc/boot/dts/p3060si.dtsi
+++ b/arch/powerpc/boot/dts/p3060si.dtsi
@@ -125,6 +125,84 @@
 		};
 	};
 
+	dcsr: dcsr@f00000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,dcsr", "simple-bus";
+
+		dcsr-epu@0 {
+			compatible = "fsl,dcsr-epu";
+			interrupts = <36 2 0 0
+				      68 2 0 0
+				      69 2 0 0>;
+			interrupt-parent = <&mpic>;
+			reg = <0x0 0x1000>;
+		};
+		dcsr-npc {
+			compatible = "fsl,dcsr-npc";
+			reg = <0x1000 0x1000 0x1000000 0x8000>;
+		};
+		dcsr-nxc@2000 {
+			compatible = "fsl,dcsr-nxc";
+			reg = <0x2000 0x1000>;
+		};
+		dcsr-corenet {
+			compatible = "fsl,dcsr-corenet";
+			reg = <0x8000 0x1000 0xB0000 0x1000>;
+		};
+		dcsr-dpaa@9000 {
+			compatible = "fsl,p3060-dcsr-dpaa", "fsl,dcsr-dpaa";
+			reg = <0x9000 0x1000>;
+		};
+		dcsr-ocn@11000 {
+			compatible = "fsl,p3060-dcsr-ocn", "fsl,dcsr-ocn";
+			reg = <0x11000 0x1000>;
+		};
+		dcsr-ddr@12000 {
+			compatible = "fsl,dcsr-ddr";
+			dev-handle = <&ddr>;
+			reg = <0x12000 0x1000>;
+		};
+		dcsr-nal@18000 {
+			compatible = "fsl,p3060-dcsr-nal", "fsl,dcsr-nal";
+			reg = <0x18000 0x1000>;
+		};
+		dcsr-rcpm@22000 {
+			compatible = "fsl,p3060-dcsr-rcpm", "fsl,dcsr-rcpm";
+			reg = <0x22000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@40000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu0>;
+			reg = <0x40000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@41000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu1>;
+			reg = <0x41000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@44000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu4>;
+			reg = <0x44000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@45000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu5>;
+			reg = <0x45000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@46000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu6>;
+			reg = <0x46000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@47000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu7>;
+			reg = <0x47000 0x1000>;
+		};
+	};
+
 	soc: soc@ffe000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -144,7 +222,7 @@
 			fsl,num-laws = <32>;
 		};
 
-		memory-controller@8000 {
+		ddr: memory-controller@8000 {
 			compatible = "fsl,qoriq-memory-controller-v4.4", "fsl,qoriq-memory-controller";
 			reg = <0x8000 0x1000>;
 			interrupts = <16 2 1 23>;
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index eb11098..c1ab435 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -45,6 +45,10 @@
 		device_type = "memory";
 	};
 
+	dcsr: dcsr@f00000000 {
+		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
+	};
+
 	soc: soc@ffe000000 {
 		spi@110000 {
 			flash@0 {
diff --git a/arch/powerpc/boot/dts/p4080si.dtsi b/arch/powerpc/boot/dts/p4080si.dtsi
index 4984edb..57dec98 100644
--- a/arch/powerpc/boot/dts/p4080si.dtsi
+++ b/arch/powerpc/boot/dts/p4080si.dtsi
@@ -162,13 +162,13 @@
 			fsl,num-laws = <32>;
 		};
 
-		memory-controller@8000 {
+		ddr1: memory-controller@8000 {
 			compatible = "fsl,qoriq-memory-controller-v4.4", "fsl,qoriq-memory-controller";
 			reg = <0x8000 0x1000>;
 			interrupts = <16 2 1 23>;
 		};
 
-		memory-controller@9000 {
+		ddr2: memory-controller@9000 {
 			compatible = "fsl,qoriq-memory-controller-v4.4","fsl,qoriq-memory-controller";
 			reg = <0x9000 0x1000>;
 			interrupts = <16 2 1 22>;
@@ -557,6 +557,99 @@
 		};
 	};
 
+	dcsr: dcsr@f00000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,dcsr", "simple-bus";
+
+		dcsr-epu@0 {
+			compatible = "fsl,dcsr-epu";
+			interrupts = <36 2 0 0
+				      68 2 0 0
+				      69 2 0 0>;
+			interrupt-parent = <&mpic>;
+			reg = <0x0 0x1000>;
+		};
+		dcsr-npc {
+			compatible = "fsl,dcsr-npc";
+			reg = <0x1000 0x1000 0x1000000 0x8000>;
+		};
+		dcsr-nxc@2000 {
+			compatible = "fsl,dcsr-nxc";
+			reg = <0x2000 0x1000>;
+		};
+		dcsr-corenet {
+			compatible = "fsl,dcsr-corenet";
+			reg = <0x8000 0x1000 0xB0000 0x1000>;
+		};
+		dcsr-dpaa@9000 {
+			compatible = "fsl,p4080-dcsr-dpaa", "fsl,dcsr-dpaa";
+			reg = <0x9000 0x1000>;
+		};
+		dcsr-ocn@11000 {
+			compatible = "fsl,p4080-dcsr-ocn", "fsl,dcsr-ocn";
+			reg = <0x11000 0x1000>;
+		};
+		dcsr-ddr@12000 {
+			compatible = "fsl,dcsr-ddr";
+			dev-handle = <&ddr1>;
+			reg = <0x12000 0x1000>;
+		};
+		dcsr-ddr@13000 {
+			compatible = "fsl,dcsr-ddr";
+			dev-handle = <&ddr2>;
+			reg = <0x13000 0x1000>;
+		};
+		dcsr-nal@18000 {
+			compatible = "fsl,p4080-dcsr-nal", "fsl,dcsr-nal";
+			reg = <0x18000 0x1000>;
+		};
+		dcsr-rcpm@22000 {
+			compatible = "fsl,p4080-dcsr-rcpm", "fsl,dcsr-rcpm";
+			reg = <0x22000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@40000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu0>;
+			reg = <0x40000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@41000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu1>;
+			reg = <0x41000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@42000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu2>;
+			reg = <0x42000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@43000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu3>;
+			reg = <0x43000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@44000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu4>;
+			reg = <0x44000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@45000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu5>;
+			reg = <0x45000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@46000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu6>;
+			reg = <0x46000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@47000 {
+			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu7>;
+			reg = <0x47000 0x1000>;
+		};
+	};
+
 	rapidio0: rapidio@ffe0c0000 {
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index 8366e2f..38fbf5c 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/p5020ds.dts
@@ -45,6 +45,10 @@
 		device_type = "memory";
 	};
 
+	dcsr: dcsr@f00000000 {
+		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
+	};
+
 	soc: soc@ffe000000 {
 		spi@110000 {
 			flash@0 {
diff --git a/arch/powerpc/boot/dts/p5020si.dtsi b/arch/powerpc/boot/dts/p5020si.dtsi
index 5e6048e..a248853 100644
--- a/arch/powerpc/boot/dts/p5020si.dtsi
+++ b/arch/powerpc/boot/dts/p5020si.dtsi
@@ -117,13 +117,13 @@
 			fsl,num-laws = <32>;
 		};
 
-		memory-controller@8000 {
+		ddr1: memory-controller@8000 {
 			compatible = "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-controller";
 			reg = <0x8000 0x1000>;
 			interrupts = <16 2 1 23>;
 		};
 
-		memory-controller@9000 {
+		ddr2: memory-controller@9000 {
 			compatible = "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-controller";
 			reg = <0x9000 0x1000>;
 			interrupts = <16 2 1 22>;
@@ -534,6 +534,69 @@
 	rapidio0: rapidio@ffe0c0000
 */
 
+	dcsr: dcsr@f00000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,dcsr", "simple-bus";
+
+		dcsr-epu@0 {
+			compatible = "fsl,dcsr-epu";
+			interrupts = <36 2 0 0
+				      68 2 0 0
+				      69 2 0 0>;
+			interrupt-parent = <&mpic>;
+			reg = <0x0 0x1000>;
+		};
+		dcsr-npc {
+			compatible = "fsl,dcsr-npc";
+			reg = <0x1000 0x1000 0x1000000 0x8000>;
+		};
+		dcsr-nxc@2000 {
+			compatible = "fsl,dcsr-nxc";
+			reg = <0x2000 0x1000>;
+		};
+		dcsr-corenet {
+			compatible = "fsl,dcsr-corenet";
+			reg = <0x8000 0x1000 0xB0000 0x1000>;
+		};
+		dcsr-dpaa@9000 {
+			compatible = "fsl,p5020-dcsr-dpaa", "fsl,dcsr-dpaa";
+			reg = <0x9000 0x1000>;
+		};
+		dcsr-ocn@11000 {
+			compatible = "fsl,p5020-dcsr-ocn", "fsl,dcsr-ocn";
+			reg = <0x11000 0x1000>;
+		};
+		dcsr-ddr@12000 {
+			compatible = "fsl,dcsr-ddr";
+			dev-handle = <&ddr1>;
+			reg = <0x12000 0x1000>;
+		};
+		dcsr-ddr@13000 {
+			compatible = "fsl,dcsr-ddr";
+			dev-handle = <&ddr2>;
+			reg = <0x13000 0x1000>;
+		};
+		dcsr-nal@18000 {
+			compatible = "fsl,p5020-dcsr-nal", "fsl,dcsr-nal";
+			reg = <0x18000 0x1000>;
+		};
+		dcsr-rcpm@22000 {
+			compatible = "fsl,p5020-dcsr-rcpm", "fsl,dcsr-rcpm";
+			reg = <0x22000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@40000 {
+			compatible = "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu0>;
+			reg = <0x40000 0x1000>;
+		};
+		dcsr-cpu-sb-proxy@41000 {
+			compatible = "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+			cpu-handle = <&cpu1>;
+			reg = <0x41000 0x1000>;
+		};
+	};
+
 	localbus@ffe124000 {
 		compatible = "fsl,p5020-elbc", "fsl,elbc", "simple-bus";
 		interrupts = <25 2 0 0>;
-- 
1.7.3.4
