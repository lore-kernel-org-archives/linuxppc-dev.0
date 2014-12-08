Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C19BB1A0BD1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 21:40:35 +1100 (AEDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0123.outbound.protection.outlook.com [65.55.169.123])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0DA721400E9
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2014 21:40:33 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH v5 5/6] powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support to
 device tree(s)
Date: Mon, 8 Dec 2014 04:29:20 -0600
Message-ID: <1418034561-12034-6-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1418034561-12034-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1418034561-12034-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Poonam Aggrwal <poonam.aggrwal@Freescale.com>,
 Geoff Thorpe <Geoff.Thorpe@Freescale.com>,
 Emil Medve <Emilian.Medve@Freescale.com>,
 Chunhe Lan <Chunhe.Lan@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>

Change-Id: If643fa5ba0a903aef8f5056a2c90ebecc995b760
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
[Emil Medve: Sync with the upstream binding]
Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/boot/dts/b4qds.dtsi            |  17 +-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  60 ++++++-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  89 +++++++++-
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi |  37 +++-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |  11 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |  11 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |  11 +-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |  11 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi |  11 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi |  65 ++++++-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 105 ++++++++++-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 265 +++++++++++++++++++++++++++-
 arch/powerpc/boot/dts/kmcoge4.dts           |  15 ++
 arch/powerpc/boot/dts/oca4080.dts           |  15 ++
 arch/powerpc/boot/dts/p1023rdb.dts          |  18 +-
 arch/powerpc/boot/dts/p2041rdb.dts          |  17 +-
 arch/powerpc/boot/dts/p3041ds.dts           |  17 +-
 arch/powerpc/boot/dts/p4080ds.dts           |  17 +-
 arch/powerpc/boot/dts/p5020ds.dts           |  17 +-
 arch/powerpc/boot/dts/p5040ds.dts           |  17 +-
 arch/powerpc/boot/dts/t104xqds.dtsi         |  17 +-
 arch/powerpc/boot/dts/t104xrdb.dtsi         |  14 ++
 arch/powerpc/boot/dts/t208xqds.dtsi         |  17 +-
 arch/powerpc/boot/dts/t208xrdb.dtsi         |  15 ++
 arch/powerpc/boot/dts/t4240qds.dts          |  17 +-
 arch/powerpc/boot/dts/t4240rdb.dts          |  15 ++
 26 files changed, 899 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
index 6188583..89fa85f 100644
--- a/arch/powerpc/boot/dts/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/b4qds.dtsi
@@ -1,7 +1,7 @@
 /*
  * B4420DS Device Tree Source
  *
- * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 - 2014 Freescale Semiconductor, Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -104,10 +104,25 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01052000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index f356ed2..2dd61fa 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * B4860 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2012 Freescale Semiconductor Inc.
+ * Copyright 2012 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -109,6 +109,64 @@
 	};
 };
 
+&bportals {
+	bman-portal@38000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x38000 0x4000>, <0x100e000 0x1000>;
+		interrupts = <133 2 0 0>;
+	};
+	bman-portal@3c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x3c000 0x4000>, <0x100f000 0x1000>;
+		interrupts = <135 2 0 0>;
+	};
+	bman-portal@40000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x40000 0x4000>, <0x1010000 0x1000>;
+		interrupts = <137 2 0 0>;
+	};
+	bman-portal@44000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x44000 0x4000>, <0x1011000 0x1000>;
+		interrupts = <139 2 0 0>;
+	};
+	bman-portal@48000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x48000 0x4000>, <0x1012000 0x1000>;
+		interrupts = <141 2 0 0>;
+	};
+	bman-portal@4c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x4c000 0x4000>, <0x1013000 0x1000>;
+		interrupts = <143 2 0 0>;
+	};
+	bman-portal@50000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x50000 0x4000>, <0x1014000 0x1000>;
+		interrupts = <145 2 0 0>;
+	};
+	bman-portal@54000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x54000 0x4000>, <0x1015000 0x1000>;
+		interrupts = <147 2 0 0>;
+	};
+	bman-portal@58000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x58000 0x4000>, <0x1016000 0x1000>;
+		interrupts = <149 2 0 0>;
+	};
+	bman-portal@5c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x5c000 0x4000>, <0x1017000 0x1000>;
+		interrupts = <151 2 0 0>;
+	};
+	bman-portal@60000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x60000 0x4000>, <0x1018000 0x1000>;
+		interrupts = <153 2 0 0>;
+	};
+};
+
 &soc {
 	ddr2: memory-controller@9000 {
 		compatible = "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-controller";
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 4cd4a31..0d09bfb 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * B4420 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 - 2014 Freescale Semiconductor, Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -32,6 +32,11 @@
  * this software, even if advised of the possibility of such damage.
  */
 
+&bman_fbpr {
+	compatible = "fsl,bman-fbpr";
+	alloc-ranges = <0 0 0x10000 0>;
+};
+
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
@@ -128,6 +133,83 @@
 	};
 };
 
+&bportals {
+	#address-cells = <0x1>;
+	#size-cells = <0x1>;
+	compatible = "simple-bus";
+
+	bman-portal@0 {
+		compatible = "fsl,bman-portal";
+		reg = <0x0 0x4000>, <0x1000000 0x1000>;
+		interrupts = <105 2 0 0>;
+	};
+	bman-portal@4000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x4000 0x4000>, <0x1001000 0x1000>;
+		interrupts = <107 2 0 0>;
+	};
+	bman-portal@8000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x8000 0x4000>, <0x1002000 0x1000>;
+		interrupts = <109 2 0 0>;
+	};
+	bman-portal@c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xc000 0x4000>, <0x1003000 0x1000>;
+		interrupts = <111 2 0 0>;
+	};
+	bman-portal@10000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x10000 0x4000>, <0x1004000 0x1000>;
+		interrupts = <113 2 0 0>;
+	};
+	bman-portal@14000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x14000 0x4000>, <0x1005000 0x1000>;
+		interrupts = <115 2 0 0>;
+	};
+	bman-portal@18000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x18000 0x4000>, <0x1006000 0x1000>;
+		interrupts = <117 2 0 0>;
+	};
+	bman-portal@1c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x1c000 0x4000>, <0x1007000 0x1000>;
+		interrupts = <119 2 0 0>;
+	};
+	bman-portal@20000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x20000 0x4000>, <0x1008000 0x1000>;
+		interrupts = <121 2 0 0>;
+	};
+	bman-portal@24000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x24000 0x4000>, <0x1009000 0x1000>;
+		interrupts = <123 2 0 0>;
+	};
+	bman-portal@28000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x28000 0x4000>, <0x100a000 0x1000>;
+		interrupts = <125 2 0 0>;
+	};
+	bman-portal@2c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x2c000 0x4000>, <0x100b000 0x1000>;
+		interrupts = <127 2 0 0>;
+	};
+	bman-portal@30000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x30000 0x4000>, <0x100c000 0x1000>;
+		interrupts = <129 2 0 0>;
+	};
+	bman-portal@34000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x34000 0x4000>, <0x100d000 0x1000>;
+		interrupts = <131 2 0 0>;
+	};
+};
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -261,6 +343,11 @@
 /include/ "qoriq-duart-1.dtsi"
 /include/ "qoriq-sec5.3-0.dtsi"
 
+/include/ "qoriq-bman1.dtsi"
+	bman: bman@31a000 {
+		interrupts = <16 2 1 29>;
+	};
+
 /include/ "qoriq-fman3-0.dtsi"
 /include/ "qoriq-fman3-0-1g-0.dtsi"
 /include/ "qoriq-fman3-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
index 01fd153..a236af1 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P1023/P1017 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -32,6 +32,11 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+&bman_fbpr {
+	compatible = "fsl,bman-fbpr";
+	alloc-ranges = <0 0 0x10 0>;
+};
+
 &lbc {
 	#address-cells = <2>;
 	#size-cells = <1>;
@@ -97,6 +102,28 @@
 	};
 };
 
+&bportals {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "simple-bus";
+
+	bman-portal@0 {
+		compatible = "fsl,bman-portal";
+		reg = <0x0 0x4000>, <0x100000 0x1000>;
+		interrupts = <30 2 0 0>;
+	};
+	bman-portal@4000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x4000 0x4000>, <0x101000 0x1000>;
+		interrupts = <32 2 0 0>;
+	};
+	bman-portal@8000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x8000 0x4000>, <0x102000 0x1000>;
+		interrupts = <34 2 0 0>;
+	};
+};
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -221,6 +248,14 @@
 /include/ "pq3-mpic.dtsi"
 /include/ "pq3-mpic-timer-B.dtsi"
 
+	bman: bman@8a000 {
+		compatible = "fsl,bman";
+		reg = <0x8a000 0x1000>;
+		interrupts = <16 2 0 0>;
+		fsl,bman-portals = <&bportals>;
+		memory-region = <&bman_fbpr>;
+	};
+
 	global-utilities@e0000 {
 		compatible = "fsl,p1023-guts";
 		reg = <0xe0000 0x1000>;
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 37d35da..31d55e6 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P2041/P2040 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -32,6 +32,11 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+&bman_fbpr {
+	compatible = "fsl,bman-fbpr";
+	alloc-ranges = <0 0 0x10 0>;
+};
+
 &lbc {
 	compatible = "fsl,p2041-elbc", "fsl,elbc", "simple-bus";
 	interrupts = <25 2 0 0>;
@@ -216,6 +221,8 @@
 	};
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -408,6 +415,8 @@ crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-fman-0.dtsi"
 /include/ "qoriq-fman-0-1g-0.dtsi"
 /include/ "qoriq-fman-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index 0e9a07d..c544445 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P3041 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -32,6 +32,11 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+&bman_fbpr {
+	compatible = "fsl,bman-fbpr";
+	alloc-ranges = <0 0 0x10 0>;
+};
+
 &lbc {
 	compatible = "fsl,p3041-elbc", "fsl,elbc", "simple-bus";
 	interrupts = <25 2 0 0>;
@@ -243,6 +248,8 @@
 	};
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -435,6 +442,8 @@ crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-fman-0.dtsi"
 /include/ "qoriq-fman-0-1g-0.dtsi"
 /include/ "qoriq-fman-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 090c586..ec86606 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P4080/P4040 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -32,6 +32,11 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+&bman_fbpr {
+	compatible = "fsl,bman-fbpr";
+	alloc-ranges = <0 0 0x10 0>;
+};
+
 &lbc {
 	compatible = "fsl,p4080-elbc", "fsl,elbc", "simple-bus";
 	interrupts = <25 2 0 0>;
@@ -243,6 +248,8 @@
 
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -491,6 +498,8 @@ crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-fman-0.dtsi"
 /include/ "qoriq-fman-0-1g-0.dtsi"
 /include/ "qoriq-fman-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index db82352..eb28ef7 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P5020/5010 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -32,6 +32,11 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+&bman_fbpr {
+	compatible = "fsl,bman-fbpr";
+	alloc-ranges = <0 0 0x10000 0>;
+};
+
 &lbc {
 	compatible = "fsl,p5020-elbc", "fsl,elbc", "simple-bus";
 	interrupts = <25 2 0 0>;
@@ -240,6 +245,8 @@
 	};
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -421,6 +428,8 @@
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-raid1.0-0.dtsi"
 	raideng@320000 {
 		fsl,iommu-parent = <&pamu1>;
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index cd44659..c8225a8 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P5040 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2012 Freescale Semiconductor Inc.
+ * Copyright 2012 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -32,6 +32,11 @@
  * software, even if advised of the possibility of such damage.
  */
 
+&bman_fbpr {
+	compatible = "fsl,bman-fbpr";
+	alloc-ranges = <0 0 0x10000 0>;
+};
+
 &lbc {
 	compatible = "fsl,p5040-elbc", "fsl,elbc", "simple-bus";
 	interrupts = <25 2 0 0>;
@@ -195,6 +200,8 @@
 	};
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -400,6 +407,8 @@
 		fsl,iommu-parent = <&pamu4>;
 	};
 
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-fman-0.dtsi"
 /include/ "qoriq-fman-0-1g-0.dtsi"
 /include/ "qoriq-fman-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 15ae462..5cc01be 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * T1040 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2013 Freescale Semiconductor Inc.
+ * Copyright 2013 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -32,6 +32,11 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+&bman_fbpr {
+	compatible = "fsl,bman-fbpr";
+	alloc-ranges = <0 0 0x10000 0>;
+};
+
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
@@ -218,6 +223,63 @@
 	};
 };
 
+&bportals {
+	#address-cells = <0x1>;
+	#size-cells = <0x1>;
+	compatible = "simple-bus";
+
+	bman-portal@0 {
+		compatible = "fsl,bman-portal";
+		reg = <0x0 0x4000>, <0x1000000 0x1000>;
+		interrupts = <105 2 0 0>;
+	};
+	bman-portal@4000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x4000 0x4000>, <0x1001000 0x1000>;
+		interrupts = <107 2 0 0>;
+	};
+	bman-portal@8000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x8000 0x4000>, <0x1002000 0x1000>;
+		interrupts = <109 2 0 0>;
+	};
+	bman-portal@c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xc000 0x4000>, <0x1003000 0x1000>;
+		interrupts = <111 2 0 0>;
+	};
+	bman-portal@10000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x10000 0x4000>, <0x1004000 0x1000>;
+		interrupts = <113 2 0 0>;
+	};
+	bman-portal@14000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x14000 0x4000>, <0x1005000 0x1000>;
+		interrupts = <115 2 0 0>;
+	};
+	bman-portal@18000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x18000 0x4000>, <0x1006000 0x1000>;
+		interrupts = <117 2 0 0>;
+	};
+	bman-portal@1c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x1c000 0x4000>, <0x1007000 0x1000>;
+		interrupts = <119 2 0 0>;
+	};
+	bman-portal@20000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x20000 0x4000>, <0x1008000 0x1000>;
+		interrupts = <121 2 0 0>;
+	};
+	bman-portal@24000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x24000 0x4000>, <0x1009000 0x1000>;
+		interrupts = <123 2 0 0>;
+	};
+};
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -401,4 +463,5 @@
 		fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
 	};
 /include/ "qoriq-sec5.0-0.dtsi"
+/include/ "qoriq-bman1.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index 1ce91e3..86bdaf6 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * T2081 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2013 Freescale Semiconductor Inc.
+ * Copyright 2013 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -32,6 +32,11 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+&bman_fbpr {
+	compatible = "fsl,bman-fbpr";
+	alloc-ranges = <0 0 0x10000 0>;
+};
+
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
@@ -224,6 +229,103 @@
 	};
 };
 
+&bportals {
+	#address-cells = <0x1>;
+	#size-cells = <0x1>;
+	compatible = "simple-bus";
+
+	bman-portal@0 {
+		compatible = "fsl,bman-portal";
+		reg = <0x0 0x4000>, <0x1000000 0x1000>;
+		interrupts = <105 2 0 0>;
+	};
+	bman-portal@4000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x4000 0x4000>, <0x1001000 0x1000>;
+		interrupts = <107 2 0 0>;
+	};
+	bman-portal@8000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x8000 0x4000>, <0x1002000 0x1000>;
+		interrupts = <109 2 0 0>;
+	};
+	bman-portal@c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xc000 0x4000>, <0x1003000 0x1000>;
+		interrupts = <111 2 0 0>;
+	};
+	bman-portal@10000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x10000 0x4000>, <0x1004000 0x1000>;
+		interrupts = <113 2 0 0>;
+	};
+	bman-portal@14000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x14000 0x4000>, <0x1005000 0x1000>;
+		interrupts = <115 2 0 0>;
+	};
+	bman-portal@18000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x18000 0x4000>, <0x1006000 0x1000>;
+		interrupts = <117 2 0 0>;
+	};
+	bman-portal@1c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x1c000 0x4000>, <0x1007000 0x1000>;
+		interrupts = <119 2 0 0>;
+	};
+	bman-portal@20000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x20000 0x4000>, <0x1008000 0x1000>;
+		interrupts = <121 2 0 0>;
+	};
+	bman-portal@24000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x24000 0x4000>, <0x1009000 0x1000>;
+		interrupts = <123 2 0 0>;
+	};
+	bman-portal@28000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x28000 0x4000>, <0x100a000 0x1000>;
+		interrupts = <125 2 0 0>;
+	};
+	bman-portal@2c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x2c000 0x4000>, <0x100b000 0x1000>;
+		interrupts = <127 2 0 0>;
+	};
+	bman-portal@30000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x30000 0x4000>, <0x100c000 0x1000>;
+		interrupts = <129 2 0 0>;
+	};
+	bman-portal@34000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x34000 0x4000>, <0x100d000 0x1000>;
+		interrupts = <131 2 0 0>;
+	};
+	bman-portal@38000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x38000 0x4000>, <0x100e000 0x1000>;
+		interrupts = <133 2 0 0>;
+	};
+	bman-portal@3c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x3c000 0x4000>, <0x100f000 0x1000>;
+		interrupts = <135 2 0 0>;
+	};
+	bman-portal@40000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x40000 0x4000>, <0x1010000 0x1000>;
+		interrupts = <137 2 0 0>;
+	};
+	bman-portal@44000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x44000 0x4000>, <0x1011000 0x1000>;
+		interrupts = <139 2 0 0>;
+	};
+};
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -400,6 +502,7 @@
 		phy_type = "utmi";
 	};
 /include/ "qoriq-sec5.2-0.dtsi"
+/include/ "qoriq-bman1.dtsi"
 
 	L2_1: l2-cache-controller@c20000 {
 		/* Cluster 0 L2 cache */
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index b73ee47..6493ed1 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * T4240 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2012 Freescale Semiconductor Inc.
+ * Copyright 2012 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -32,6 +32,11 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+&bman_fbpr {
+	compatible = "fsl,bman-fbpr";
+	alloc-ranges = <0 0 0x10000 0>;
+};
+
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
@@ -294,6 +299,263 @@
 	};
 };
 
+&bportals {
+	#address-cells = <0x1>;
+	#size-cells = <0x1>;
+	compatible = "simple-bus";
+
+	bman-portal@0 {
+		compatible = "fsl,bman-portal";
+		reg = <0x0 0x4000>, <0x1000000 0x1000>;
+		interrupts = <105 2 0 0>;
+	};
+	bman-portal@4000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x4000 0x4000>, <0x1001000 0x1000>;
+		interrupts = <107 2 0 0>;
+	};
+	bman-portal@8000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x8000 0x4000>, <0x1002000 0x1000>;
+		interrupts = <109 2 0 0>;
+	};
+	bman-portal@c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xc000 0x4000>, <0x1003000 0x1000>;
+		interrupts = <111 2 0 0>;
+	};
+	bman-portal@10000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x10000 0x4000>, <0x1004000 0x1000>;
+		interrupts = <113 2 0 0>;
+	};
+	bman-portal@14000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x14000 0x4000>, <0x1005000 0x1000>;
+		interrupts = <115 2 0 0>;
+	};
+	bman-portal@18000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x18000 0x4000>, <0x1006000 0x1000>;
+		interrupts = <117 2 0 0>;
+	};
+	bman-portal@1c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x1c000 0x4000>, <0x1007000 0x1000>;
+		interrupts = <119 2 0 0>;
+	};
+	bman-portal@20000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x20000 0x4000>, <0x1008000 0x1000>;
+		interrupts = <121 2 0 0>;
+	};
+	bman-portal@24000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x24000 0x4000>, <0x1009000 0x1000>;
+		interrupts = <123 2 0 0>;
+	};
+	bman-portal@28000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x28000 0x4000>, <0x100a000 0x1000>;
+		interrupts = <125 2 0 0>;
+	};
+	bman-portal@2c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x2c000 0x4000>, <0x100b000 0x1000>;
+		interrupts = <127 2 0 0>;
+	};
+	bman-portal@30000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x30000 0x4000>, <0x100c000 0x1000>;
+		interrupts = <129 2 0 0>;
+	};
+	bman-portal@34000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x34000 0x4000>, <0x100d000 0x1000>;
+		interrupts = <131 2 0 0>;
+	};
+	bman-portal@38000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x38000 0x4000>, <0x100e000 0x1000>;
+		interrupts = <133 2 0 0>;
+	};
+	bman-portal@3c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x3c000 0x4000>, <0x100f000 0x1000>;
+		interrupts = <135 2 0 0>;
+	};
+	bman-portal@40000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x40000 0x4000>, <0x1010000 0x1000>;
+		interrupts = <137 2 0 0>;
+	};
+	bman-portal@44000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x44000 0x4000>, <0x1011000 0x1000>;
+		interrupts = <139 2 0 0>;
+	};
+	bman-portal@48000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x48000 0x4000>, <0x1012000 0x1000>;
+		interrupts = <141 2 0 0>;
+	};
+	bman-portal@4c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x4c000 0x4000>, <0x1013000 0x1000>;
+		interrupts = <143 2 0 0>;
+	};
+	bman-portal@50000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x50000 0x4000>, <0x1014000 0x1000>;
+		interrupts = <145 2 0 0>;
+	};
+	bman-portal@54000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x54000 0x4000>, <0x1015000 0x1000>;
+		interrupts = <147 2 0 0>;
+	};
+	bman-portal@58000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x58000 0x4000>, <0x1016000 0x1000>;
+		interrupts = <149 2 0 0>;
+	};
+	bman-portal@5c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x5c000 0x4000>, <0x1017000 0x1000>;
+		interrupts = <151 2 0 0>;
+	};
+	bman-portal@60000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x60000 0x4000>, <0x1018000 0x1000>;
+		interrupts = <153 2 0 0>;
+	};
+	bman-portal@64000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x64000 0x4000>, <0x1019000 0x1000>;
+		interrupts = <155 2 0 0>;
+	};
+	bman-portal@68000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x68000 0x4000>, <0x101a000 0x1000>;
+		interrupts = <157 2 0 0>;
+	};
+	bman-portal@6c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x6c000 0x4000>, <0x101b000 0x1000>;
+		interrupts = <159 2 0 0>;
+	};
+	bman-portal@70000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x70000 0x4000>, <0x101c000 0x1000>;
+		interrupts = <161 2 0 0>;
+	};
+	bman-portal@74000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x74000 0x4000>, <0x101d000 0x1000>;
+		interrupts = <163 2 0 0>;
+	};
+	bman-portal@78000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x78000 0x4000>, <0x101e000 0x1000>;
+		interrupts = <165 2 0 0>;
+	};
+	bman-portal@7c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x7c000 0x4000>, <0x101f000 0x1000>;
+		interrupts = <167 2 0 0>;
+	};
+	bman-portal@80000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x80000 0x4000>, <0x1020000 0x1000>;
+		interrupts = <169 2 0 0>;
+	};
+	bman-portal@84000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x84000 0x4000>, <0x1021000 0x1000>;
+		interrupts = <171 2 0 0>;
+	};
+	bman-portal@88000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x88000 0x4000>, <0x1022000 0x1000>;
+		interrupts = <173 2 0 0>;
+	};
+	bman-portal@8c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x8c000 0x4000>, <0x1023000 0x1000>;
+		interrupts = <175 2 0 0>;
+	};
+	bman-portal@90000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x90000 0x4000>, <0x1024000 0x1000>;
+		interrupts = <385 2 0 0>;
+	};
+	bman-portal@94000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x94000 0x4000>, <0x1025000 0x1000>;
+		interrupts = <387 2 0 0>;
+	};
+	bman-portal@98000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x98000 0x4000>, <0x1026000 0x1000>;
+		interrupts = <389 2 0 0>;
+	};
+	bman-portal@9c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x9c000 0x4000>, <0x1027000 0x1000>;
+		interrupts = <391 2 0 0>;
+	};
+	bman-portal@a0000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xa0000 0x4000>, <0x1028000 0x1000>;
+		interrupts = <393 2 0 0>;
+	};
+	bman-portal@a4000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xa4000 0x4000>, <0x1029000 0x1000>;
+		interrupts = <395 2 0 0>;
+	};
+	bman-portal@a8000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xa8000 0x4000>, <0x102a000 0x1000>;
+		interrupts = <397 2 0 0>;
+	};
+	bman-portal@ac000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xac000 0x4000>, <0x102b000 0x1000>;
+		interrupts = <399 2 0 0>;
+	};
+	bman-portal@b0000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xb0000 0x4000>, <0x102c000 0x1000>;
+		interrupts = <401 2 0 0>;
+	};
+	bman-portal@b4000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xb4000 0x4000>, <0x102d000 0x1000>;
+		interrupts = <403 2 0 0>;
+	};
+	bman-portal@b8000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xb8000 0x4000>, <0x102e000 0x1000>;
+		interrupts = <405 2 0 0>;
+	};
+	bman-portal@bc000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xbc000 0x4000>, <0x102f000 0x1000>;
+		interrupts = <407 2 0 0>;
+	};
+	bman-portal@c0000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xc0000 0x4000>, <0x1030000 0x1000>;
+		interrupts = <409 2 0 0>;
+	};
+	bman-portal@c4000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xc4000 0x4000>, <0x1031000 0x1000>;
+		interrupts = <411 2 0 0>;
+	};
+};
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -486,6 +748,7 @@
 /include/ "qoriq-sata2-0.dtsi"
 /include/ "qoriq-sata2-1.dtsi"
 /include/ "qoriq-sec5.0-0.dtsi"
+/include/ "qoriq-bman1.dtsi"
 /include/ "qoriq-fman3-0.dtsi"
 /include/ "qoriq-fman3-0-1g-0.dtsi"
 /include/ "qoriq-fman3-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/kmcoge4.dts b/arch/powerpc/boot/dts/kmcoge4.dts
index 89b4119..97e6d11 100644
--- a/arch/powerpc/boot/dts/kmcoge4.dts
+++ b/arch/powerpc/boot/dts/kmcoge4.dts
@@ -25,10 +25,25 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/oca4080.dts b/arch/powerpc/boot/dts/oca4080.dts
index 3d4c751..eb76caa 100644
--- a/arch/powerpc/boot/dts/oca4080.dts
+++ b/arch/powerpc/boot/dts/oca4080.dts
@@ -49,10 +49,25 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p1023rdb.dts b/arch/powerpc/boot/dts/p1023rdb.dts
index d121bda..c1992ad 100644
--- a/arch/powerpc/boot/dts/p1023rdb.dts
+++ b/arch/powerpc/boot/dts/p1023rdb.dts
@@ -1,7 +1,7 @@
 /*
  * P1023 RDB Device Tree Source
  *
- *    Copyright 2013 Freescale Semiconductor Inc.
+ * Copyright 2013 - 2014 Freescale Semiconductor Inc.
  *
  * Author: Chunhe Lan <Chunhe.Lan@freescale.com>
  *
@@ -47,6 +47,21 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
+	bportals: bman-portals@ff200000 {
+		ranges = <0x0 0xf 0xff200000 0x200000>;
+	};
+
 	soc: soc@ff600000 {
 		ranges = <0x0 0x0 0xff600000 0x200000>;
 
@@ -247,7 +262,6 @@
 				  0x0 0x100000>;
 		};
 	};
-
 };
 
 /include/ "fsl/p1023si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/p2041rdb.dts
index 1060716..e7f75a2 100644
--- a/arch/powerpc/boot/dts/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/p2041rdb.dts
@@ -1,7 +1,7 @@
 /*
  * P2041RDB Device Tree Source
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -58,10 +58,25 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index 253d01b..d2b2086 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -1,7 +1,7 @@
 /*
  * P3041DS Device Tree Source
  *
- * Copyright 2010-2011 Freescale Semiconductor Inc.
+ * Copyright 2010 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -59,10 +59,25 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index f6b4923..8f9eda5 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -1,7 +1,7 @@
 /*
  * P4080DS Device Tree Source
  *
- * Copyright 2009-2011 Freescale Semiconductor Inc.
+ * Copyright 2009 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -59,10 +59,25 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index 981f5df..52b8c59 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/p5020ds.dts
@@ -1,7 +1,7 @@
 /*
  * P5020DS Device Tree Source
  *
- * Copyright 2010-2011 Freescale Semiconductor Inc.
+ * Copyright 2010 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -59,10 +59,25 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/p5040ds.dts
index a5be79d..a0d9447 100644
--- a/arch/powerpc/boot/dts/p5040ds.dts
+++ b/arch/powerpc/boot/dts/p5040ds.dts
@@ -1,7 +1,7 @@
 /*
  * P5040DS Device Tree Source
  *
- * Copyright 2012 Freescale Semiconductor Inc.
+ * Copyright 2012 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -73,10 +73,25 @@
 		hydra_xg_slot2 = &hydra_xg_slot2;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t104xqds.dtsi b/arch/powerpc/boot/dts/t104xqds.dtsi
index 234f4b5..f7e9bfb 100644
--- a/arch/powerpc/boot/dts/t104xqds.dtsi
+++ b/arch/powerpc/boot/dts/t104xqds.dtsi
@@ -1,7 +1,7 @@
 /*
  * T104xQDS Device Tree Source
  *
- * Copyright 2013 Freescale Semiconductor Inc.
+ * Copyright 2013 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -38,6 +38,17 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
@@ -77,6 +88,10 @@
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t104xrdb.dtsi b/arch/powerpc/boot/dts/t104xrdb.dtsi
index 1cf0f3c..56f8d43 100644
--- a/arch/powerpc/boot/dts/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/t104xrdb.dtsi
@@ -33,6 +33,16 @@
  */
 
 / {
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
 
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
@@ -69,6 +79,10 @@
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t208xqds.dtsi b/arch/powerpc/boot/dts/t208xqds.dtsi
index 555dc6e..1d6cf31 100644
--- a/arch/powerpc/boot/dts/t208xqds.dtsi
+++ b/arch/powerpc/boot/dts/t208xqds.dtsi
@@ -1,7 +1,7 @@
 /*
  * T2080/T2081 QDS Device Tree Source
  *
- * Copyright 2013 Freescale Semiconductor Inc.
+ * Copyright 2013 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -39,6 +39,17 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
@@ -78,6 +89,10 @@
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t208xrdb.dtsi b/arch/powerpc/boot/dts/t208xrdb.dtsi
index 1481e19..e1463b1 100644
--- a/arch/powerpc/boot/dts/t208xrdb.dtsi
+++ b/arch/powerpc/boot/dts/t208xrdb.dtsi
@@ -39,6 +39,17 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
@@ -79,6 +90,10 @@
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/t4240qds.dts
index e9f528c..6bb9a18 100644
--- a/arch/powerpc/boot/dts/t4240qds.dts
+++ b/arch/powerpc/boot/dts/t4240qds.dts
@@ -1,7 +1,7 @@
 /*
  * T4240QDS Device Tree Source
  *
- * Copyright 2012 Freescale Semiconductor Inc.
+ * Copyright 2012 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -288,10 +288,25 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t4240rdb.dts b/arch/powerpc/boot/dts/t4240rdb.dts
index 53761d4..46049cf 100644
--- a/arch/powerpc/boot/dts/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/t4240rdb.dts
@@ -69,10 +69,25 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
-- 
2.2.0
