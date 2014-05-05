Return-Path: <Diana.Craciun@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5A09E140312
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 02:04:47 +1000 (EST)
From: Diana Craciun <diana.craciun@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/fsl: Updated device trees for platforms with
 corenet version 2
Date: Mon, 5 May 2014 19:04:27 +0300
Message-ID: <1399305867-6779-1-git-send-email-diana.craciun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Diana Craciun <Diana.Craciun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Diana Craciun <Diana.Craciun@freescale.com>

Updated the device trees according to the corenet-cf
binding definition.

Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
---
 arch/powerpc/boot/dts/b4860emu.dts          |  7 ++++++-
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |  4 ----
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |  2 ++
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  4 ----
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |  4 ++++
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  3 ++-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |  3 ++-
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi  | 12 ++++++++++++
 arch/powerpc/boot/dts/t4240emu.dts          | 15 ++++++++++++++-
 9 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/boot/dts/b4860emu.dts b/arch/powerpc/boot/dts/b4860emu.dts
index 7290021..85646b4 100644
--- a/arch/powerpc/boot/dts/b4860emu.dts
+++ b/arch/powerpc/boot/dts/b4860emu.dts
@@ -61,21 +61,25 @@
 			device_type = "cpu";
 			reg = <0 1>;
 			next-level-cache = <&L2>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
 			next-level-cache = <&L2>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu2: PowerPC,e6500@4 {
 			device_type = "cpu";
 			reg = <4 5>;
 			next-level-cache = <&L2>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu3: PowerPC,e6500@6 {
 			device_type = "cpu";
 			reg = <6 7>;
 			next-level-cache = <&L2>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 	};
 };
@@ -157,7 +161,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,b4-corenet-cf";
+		compatible = "fsl,corenet2-cf", "fsl,corenet-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 0>;
 		fsl,ccf-num-csdids = <32>;
@@ -167,6 +171,7 @@
 	iommu@20000 {
 		compatible = "fsl,pamu-v1.0", "fsl,pamu";
 		reg = <0x20000 0x4000>;
+		fsl,portid-mapping = <0x8000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		interrupts = <
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
index 60566f99..d678944 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -76,10 +76,6 @@
 		compatible = "fsl,b4420-l3-cache-controller", "cache";
 	};
 
-	corenet-cf@18000 {
-		compatible = "fsl,b4420-corenet-cf";
-	};
-
 	guts: global-utilities@e0000 {
 		compatible = "fsl,b4420-device-config", "fsl,qoriq-device-config-2.0";
 	};
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index 2419731..338af7e 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -66,12 +66,14 @@
 			reg = <0 1>;
 			clocks = <&mux0>;
 			next-level-cache = <&L2>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
 			clocks = <&mux0>;
 			next-level-cache = <&L2>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index cbc354b..582381d 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -120,10 +120,6 @@
 		compatible = "fsl,b4860-l3-cache-controller", "cache";
 	};
 
-	corenet-cf@18000 {
-		compatible = "fsl,b4860-corenet-cf";
-	};
-
 	guts: global-utilities@e0000 {
 		compatible = "fsl,b4860-device-config", "fsl,qoriq-device-config-2.0";
 	};
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
index 142ac86..1948f73 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -66,24 +66,28 @@
 			reg = <0 1>;
 			clocks = <&mux0>;
 			next-level-cache = <&L2>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
 			clocks = <&mux0>;
 			next-level-cache = <&L2>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu2: PowerPC,e6500@4 {
 			device_type = "cpu";
 			reg = <4 5>;
 			clocks = <&mux0>;
 			next-level-cache = <&L2>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu3: PowerPC,e6500@6 {
 			device_type = "cpu";
 			reg = <6 7>;
 			clocks = <&mux0>;
 			next-level-cache = <&L2>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 4f6e482..1a54ba7 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -158,7 +158,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,b4-corenet-cf";
+		compatible = "fsl,corenet2-cf", "fsl,corenet-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 0>;
 		fsl,ccf-num-csdids = <32>;
@@ -168,6 +168,7 @@
 	iommu@20000 {
 		compatible =  "fsl,pamu-v1.0", "fsl,pamu";
 		reg = <0x20000 0x4000>;
+		fsl,portid-mapping = <0x8000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		interrupts = <
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index f99d74f..793669b 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -343,7 +343,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,corenet-cf";
+		compatible = "fsl,corenet2-cf", "fsl,corenet-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 31>;
 		fsl,ccf-num-csdids = <32>;
@@ -353,6 +353,7 @@
 	iommu@20000 {
 		compatible = "fsl,pamu-v1.0", "fsl,pamu";
 		reg = <0x20000 0x6000>;
+		fsl,portid-mapping = <0x8000>;
 		interrupts = <
 			24 2 0 0
 			16 2 1 30>;
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
index 0b8ccc5..d2f157e 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
@@ -69,72 +69,84 @@
 			reg = <0 1>;
 			clocks = <&mux0>;
 			next-level-cache = <&L2_1>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
 			clocks = <&mux0>;
 			next-level-cache = <&L2_1>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu2: PowerPC,e6500@4 {
 			device_type = "cpu";
 			reg = <4 5>;
 			clocks = <&mux0>;
 			next-level-cache = <&L2_1>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu3: PowerPC,e6500@6 {
 			device_type = "cpu";
 			reg = <6 7>;
 			clocks = <&mux0>;
 			next-level-cache = <&L2_1>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu4: PowerPC,e6500@8 {
 			device_type = "cpu";
 			reg = <8 9>;
 			clocks = <&mux1>;
 			next-level-cache = <&L2_2>;
+			fsl,portid-mapping = <0x40000000>;
 		};
 		cpu5: PowerPC,e6500@10 {
 			device_type = "cpu";
 			reg = <10 11>;
 			clocks = <&mux1>;
 			next-level-cache = <&L2_2>;
+			fsl,portid-mapping = <0x40000000>;
 		};
 		cpu6: PowerPC,e6500@12 {
 			device_type = "cpu";
 			reg = <12 13>;
 			clocks = <&mux1>;
 			next-level-cache = <&L2_2>;
+			fsl,portid-mapping = <0x40000000>;
 		};
 		cpu7: PowerPC,e6500@14 {
 			device_type = "cpu";
 			reg = <14 15>;
 			clocks = <&mux1>;
 			next-level-cache = <&L2_2>;
+			fsl,portid-mapping = <0x40000000>;
 		};
 		cpu8: PowerPC,e6500@16 {
 			device_type = "cpu";
 			reg = <16 17>;
 			clocks = <&mux2>;
 			next-level-cache = <&L2_3>;
+			fsl,portid-mapping = <0x20000000>;
 		};
 		cpu9: PowerPC,e6500@18 {
 			device_type = "cpu";
 			reg = <18 19>;
 			clocks = <&mux2>;
 			next-level-cache = <&L2_3>;
+			fsl,portid-mapping = <0x20000000>;
 		};
 		cpu10: PowerPC,e6500@20 {
 			device_type = "cpu";
 			reg = <20 21>;
 			clocks = <&mux2>;
 			next-level-cache = <&L2_3>;
+			fsl,portid-mapping = <0x20000000>;
 		};
 		cpu11: PowerPC,e6500@22 {
 			device_type = "cpu";
 			reg = <22 23>;
 			clocks = <&mux2>;
 			next-level-cache = <&L2_3>;
+			fsl,portid-mapping = <0x20000000>;
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/t4240emu.dts b/arch/powerpc/boot/dts/t4240emu.dts
index ee24ab3..bc12127a 100644
--- a/arch/powerpc/boot/dts/t4240emu.dts
+++ b/arch/powerpc/boot/dts/t4240emu.dts
@@ -60,63 +60,75 @@
 			device_type = "cpu";
 			reg = <0 1>;
 			next-level-cache = <&L2_1>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
 			next-level-cache = <&L2_1>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu2: PowerPC,e6500@4 {
 			device_type = "cpu";
 			reg = <4 5>;
 			next-level-cache = <&L2_1>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu3: PowerPC,e6500@6 {
 			device_type = "cpu";
 			reg = <6 7>;
 			next-level-cache = <&L2_1>;
+			fsl,portid-mapping = <0x80000000>;
 		};
 
 		cpu4: PowerPC,e6500@8 {
 			device_type = "cpu";
 			reg = <8 9>;
 			next-level-cache = <&L2_2>;
+			fsl,portid-mapping = <0x40000000>;
 		};
 		cpu5: PowerPC,e6500@10 {
 			device_type = "cpu";
 			reg = <10 11>;
 			next-level-cache = <&L2_2>;
+			fsl,portid-mapping = <0x40000000>;
 		};
 		cpu6: PowerPC,e6500@12 {
 			device_type = "cpu";
 			reg = <12 13>;
 			next-level-cache = <&L2_2>;
+			fsl,portid-mapping = <0x40000000>;
 		};
 		cpu7: PowerPC,e6500@14 {
 			device_type = "cpu";
 			reg = <14 15>;
 			next-level-cache = <&L2_2>;
+			fsl,portid-mapping = <0x40000000>;
 		};
 
 		cpu8: PowerPC,e6500@16 {
 			device_type = "cpu";
 			reg = <16 17>;
 			next-level-cache = <&L2_3>;
+			fsl,portid-mapping = <0x20000000>;
 		};
 		cpu9: PowerPC,e6500@18 {
 			device_type = "cpu";
 			reg = <18 19>;
 			next-level-cache = <&L2_3>;
+			fsl,portid-mapping = <0x20000000>;
 		};
 		cpu10: PowerPC,e6500@20 {
 			device_type = "cpu";
 			reg = <20 21>;
 			next-level-cache = <&L2_3>;
+			fsl,portid-mapping = <0x20000000>;
 		};
 		cpu11: PowerPC,e6500@22 {
 			device_type = "cpu";
 			reg = <22 23>;
 			next-level-cache = <&L2_3>;
+			fsl,portid-mapping = <0x20000000>;
 		};
 	};
 };
@@ -213,7 +225,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,corenet-cf";
+		compatible = "fsl,corenet2-cf", "fsl,corenet-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 31>;
 		fsl,ccf-num-csdids = <32>;
@@ -223,6 +235,7 @@
 	iommu@20000 {
 		compatible = "fsl,pamu-v1.0", "fsl,pamu";
 		reg = <0x20000 0x6000>;
+		fsl,portid-mapping = <0x8000>;
 		interrupts = <
 			24 2 0 0
 			16 2 1 30>;
-- 
1.7.11.7
