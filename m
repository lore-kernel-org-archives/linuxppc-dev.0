Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D95DBDE9B1
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 06:43:24 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m4UKhJrA001894
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 15:43:20 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Cleanup mpic nodes in .dts
Date: Fri, 30 May 2008 15:43:18 -0500
Message-Id: <1212180199-968-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removed clock-frequency and big-endian props as they aren't specified
anywhere.

---

In my powerpc-next branch.

 Documentation/powerpc/booting-without-of.txt |    6 ------
 arch/powerpc/boot/dts/mpc7448hpc2.dts        |    2 --
 arch/powerpc/boot/dts/mpc8540ads.dts         |    2 --
 arch/powerpc/boot/dts/mpc8541cds.dts         |    2 --
 arch/powerpc/boot/dts/mpc8544ds.dts          |    2 --
 arch/powerpc/boot/dts/mpc8548cds.dts         |    2 --
 arch/powerpc/boot/dts/mpc8555cds.dts         |    2 --
 arch/powerpc/boot/dts/mpc8560ads.dts         |    1 +
 arch/powerpc/boot/dts/mpc8568mds.dts         |    2 --
 arch/powerpc/boot/dts/mpc8572ds.dts          |    2 --
 arch/powerpc/boot/dts/mpc8610_hpcd.dts       |    2 --
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |    2 --
 arch/powerpc/boot/dts/sbc8548.dts            |    2 --
 arch/powerpc/boot/dts/sbc8560.dts            |    2 +-
 arch/powerpc/boot/dts/storcenter.dts         |    1 +
 arch/powerpc/boot/dts/stx_gp3_8560.dts       |    1 +
 arch/powerpc/boot/dts/tqm8540.dts            |    1 +
 arch/powerpc/boot/dts/tqm8541.dts            |    1 +
 arch/powerpc/boot/dts/tqm8555.dts            |    1 +
 arch/powerpc/boot/dts/tqm8560.dts            |    1 +
 20 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index c67d2f5..948f641 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1363,14 +1363,11 @@ platforms are moved over to use the flattened-device-tree model.
 
 	pic@40000 {
 		linux,phandle = <40000>;
-		clock-frequency = <0>;
 		interrupt-controller;
 		#address-cells = <0>;
 		reg = <40000 40000>;
-		built-in;
 		compatible = "chrp,open-pic";
 		device_type = "open-pic";
-		big-endian;
 	};
 
 
@@ -3663,14 +3660,11 @@ not necessary as they are usually the same as the root node.
 
 		pic@40000 {
 			linux,phandle = <40000>;
-			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
 			reg = <40000 40000>;
-			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-                        big-endian;
 		};
 
 		i2c@3000 {
diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index 4936349..705c23c 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -124,14 +124,12 @@
 		};
 
 	  	mpic: pic@7400 {
-			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x7400 0x400>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-                       	big-endian;
 		};
 		pci@1000 {
 			compatible = "tsi108-pci";
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 18033ed..58e165e 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -165,14 +165,12 @@
 			interrupt-parent = <&mpic>;
 		};
 		mpic: pic@40000 {
-			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-			big-endian;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 663c7c5..21ebe7c 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -148,14 +148,12 @@
 		};
 
 		mpic: pic@40000 {
-			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-                        big-endian;
 		};
 
 		cpm@919c0 {
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 1cfd970..921f9f6 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -210,14 +210,12 @@
 		};
 
 		mpic: pic@40000 {
-			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-			big-endian;
 		};
 
 		msi@41600 {
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index fa298a8..213c88e 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -208,14 +208,12 @@
 		};
 
 		mpic: pic@40000 {
-			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-                        big-endian;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index b025c56..400f6db 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -148,14 +148,12 @@
 		};
 
 		mpic: pic@40000 {
-			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-                        big-endian;
 		};
 
 		cpm@919c0 {
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 0cc16ab..f0b1f98 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -134,6 +134,7 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
 			device_type = "open-pic";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index a025a8e..d9064ee 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -202,14 +202,12 @@
 		};
 
 		mpic: pic@40000 {
-			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-                        big-endian;
 		};
 
 		par_io@e0100 {
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 174d51a..3ca8cae 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -238,14 +238,12 @@
 		};
 
 		mpic: pic@40000 {
-			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-			big-endian;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index fa9c297..186f102 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -172,14 +172,12 @@
 		};
 
 		mpic: interrupt-controller@40000 {
-			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-			big-endian;
 		};
 
 		msi@41600 {
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 1e4bfe9..14f718d 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -239,14 +239,12 @@
 		};
 
 		mpic: pic@40000 {
-			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-			big-endian;
 		};
 
 		global-utilities@e0000 {
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index 22d9671..ce496fb 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -265,12 +265,10 @@
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
-			#size-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-                        big-endian;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
index 0476802..2663501 100644
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -155,8 +155,8 @@
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
-			#size-cells = <0>;
 			#interrupt-cells = <2>;
+			compatible = "chrp,open-pic";
 			reg = <0x40000 0x40000>;
 			device_type = "open-pic";
 		};
diff --git a/arch/powerpc/boot/dts/storcenter.dts b/arch/powerpc/boot/dts/storcenter.dts
index 5893816..eab680c 100644
--- a/arch/powerpc/boot/dts/storcenter.dts
+++ b/arch/powerpc/boot/dts/storcenter.dts
@@ -95,6 +95,7 @@
 
 		mpic: interrupt-controller@40000 {
 			#interrupt-cells = <2>;
+			#address-cells = <0>;
 			device_type = "open-pic";
 			compatible = "chrp,open-pic";
 			interrupt-controller;
diff --git a/arch/powerpc/boot/dts/stx_gp3_8560.dts b/arch/powerpc/boot/dts/stx_gp3_8560.dts
index f81fd7f..096277b 100644
--- a/arch/powerpc/boot/dts/stx_gp3_8560.dts
+++ b/arch/powerpc/boot/dts/stx_gp3_8560.dts
@@ -131,6 +131,7 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
 			device_type = "open-pic";
 		};
 
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index 1addb3a..8ee4664 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -177,6 +177,7 @@
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			device_type = "open-pic";
+			compatible = "chrp,open-pic";
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index 9e01093..cadbebf 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -164,6 +164,7 @@
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			device_type = "open-pic";
+			compatible = "chrp,open-pic";
 		};
 
 		cpm@919c0 {
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index a20eb06..9d6dc04 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -164,6 +164,7 @@
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			device_type = "open-pic";
+			compatible = "chrp,open-pic";
 		};
 
 		cpm@919c0 {
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index b9ac6c9..358cbd7 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -145,6 +145,7 @@
 			#interrupt-cells = <2>;
 			reg = <0x40000 0x40000>;
 			device_type = "open-pic";
+			compatible = "chrp,open-pic";
 		};
 
 		cpm@919c0 {
-- 
1.5.4.5
