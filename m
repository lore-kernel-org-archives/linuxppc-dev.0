Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 034D41A0745
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Nov 2014 22:17:48 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0140.outbound.protection.outlook.com [157.56.111.140])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8002B140100
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2014 22:17:46 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH v2 3/4] powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support to
 device tree(s)
Date: Mon, 24 Nov 2014 05:07:22 -0600
Message-ID: <1416827243-16396-4-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1416827243-16396-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1416827243-16396-1-git-send-email-Emilian.Medve@Freescale.com>
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
 arch/powerpc/boot/dts/b4qds.dtsi            |  20 ++-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  60 ++++++-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  84 ++++++++-
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi |  30 +++-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |   6 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |   6 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |   6 +-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |   6 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi |   6 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi |  60 ++++++-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 100 ++++++++++-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 260 +++++++++++++++++++++++++++-
 arch/powerpc/boot/dts/kmcoge4.dts           |  18 ++
 arch/powerpc/boot/dts/oca4080.dts           |  18 ++
 arch/powerpc/boot/dts/p1023rdb.dts          |  21 ++-
 arch/powerpc/boot/dts/p2041rdb.dts          |  20 ++-
 arch/powerpc/boot/dts/p3041ds.dts           |  20 ++-
 arch/powerpc/boot/dts/p4080ds.dts           |  20 ++-
 arch/powerpc/boot/dts/p5020ds.dts           |  20 ++-
 arch/powerpc/boot/dts/p5040ds.dts           |  20 ++-
 arch/powerpc/boot/dts/t104xqds.dtsi         |  20 ++-
 arch/powerpc/boot/dts/t104xrdb.dtsi         |  18 ++
 arch/powerpc/boot/dts/t208xqds.dtsi         |  20 ++-
 arch/powerpc/boot/dts/t208xrdb.dtsi         |  18 ++
 arch/powerpc/boot/dts/t4240qds.dts          |  20 ++-
 arch/powerpc/boot/dts/t4240rdb.dts          |  18 ++
 26 files changed, 893 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
index 6188583..3a73103 100644
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
@@ -104,10 +104,28 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
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
index 4cd4a31..ff1d509 100644
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
@@ -128,6 +128,83 @@
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
@@ -261,6 +338,11 @@
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
index 01fd153..6b8e612 100644
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
@@ -97,6 +97,28 @@
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
@@ -221,6 +243,12 @@
 /include/ "pq3-mpic.dtsi"
 /include/ "pq3-mpic-timer-B.dtsi"
 
+	bman: bman@8a000 {
+		compatible = "fsl,bman";
+		reg = <0x8a000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
 	global-utilities@e0000 {
 		compatible = "fsl,p1023-guts";
 		reg = <0xe0000 0x1000>;
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 37d35da..661d014 100644
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
@@ -216,6 +216,8 @@
 	};
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -408,6 +410,8 @@ crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-fman-0.dtsi"
 /include/ "qoriq-fman-0-1g-0.dtsi"
 /include/ "qoriq-fman-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index 0e9a07d..76a893e 100644
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
@@ -243,6 +243,8 @@
 	};
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -435,6 +437,8 @@ crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-fman-0.dtsi"
 /include/ "qoriq-fman-0-1g-0.dtsi"
 /include/ "qoriq-fman-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 090c586..a57bf1a 100644
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
@@ -243,6 +243,8 @@
 
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -491,6 +493,8 @@ crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-fman-0.dtsi"
 /include/ "qoriq-fman-0-1g-0.dtsi"
 /include/ "qoriq-fman-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index db82352..4e91792 100644
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
@@ -240,6 +240,8 @@
 	};
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -421,6 +423,8 @@
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-raid1.0-0.dtsi"
 	raideng@320000 {
 		fsl,iommu-parent = <&pamu1>;
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index cd44659..a8c804f 100644
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
@@ -195,6 +195,8 @@
 	};
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -400,6 +402,8 @@
 		fsl,iommu-parent = <&pamu4>;
 	};
 
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-fman-0.dtsi"
 /include/ "qoriq-fman-0-1g-0.dtsi"
 /include/ "qoriq-fman-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 15ae462..9f639c2 100644
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
@@ -218,6 +218,63 @@
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
@@ -401,4 +458,5 @@
 		fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
 	};
 /include/ "qoriq-sec5.0-0.dtsi"
+/include/ "qoriq-bman1.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index 1ce91e3..60366f6 100644
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
@@ -224,6 +224,103 @@
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
@@ -400,6 +497,7 @@
 		phy_type = "utmi";
 	};
 /include/ "qoriq-sec5.2-0.dtsi"
+/include/ "qoriq-bman1.dtsi"
 
 	L2_1: l2-cache-controller@c20000 {
 		/* Cluster 0 L2 cache */
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index b73ee47..f8d3d52 100644
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
@@ -294,6 +294,263 @@
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
@@ -486,6 +743,7 @@
 /include/ "qoriq-sata2-0.dtsi"
 /include/ "qoriq-sata2-1.dtsi"
 /include/ "qoriq-sec5.0-0.dtsi"
+/include/ "qoriq-bman1.dtsi"
 /include/ "qoriq-fman3-0.dtsi"
 /include/ "qoriq-fman3-0-1g-0.dtsi"
 /include/ "qoriq-fman3-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/kmcoge4.dts b/arch/powerpc/boot/dts/kmcoge4.dts
index 89b4119..a65d946 100644
--- a/arch/powerpc/boot/dts/kmcoge4.dts
+++ b/arch/powerpc/boot/dts/kmcoge4.dts
@@ -25,10 +25,28 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
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
index 3d4c751..d51b860 100644
--- a/arch/powerpc/boot/dts/oca4080.dts
+++ b/arch/powerpc/boot/dts/oca4080.dts
@@ -49,10 +49,28 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
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
index d121bda..e769f22 100644
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
@@ -47,6 +47,24 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
+		};
+	};
+
+	bportals: bman-portals@ff200000 {
+		ranges = <0x0 0xf 0xff200000 0x200000>;
+	};
+
 	soc: soc@ff600000 {
 		ranges = <0x0 0x0 0xff600000 0x200000>;
 
@@ -247,7 +265,6 @@
 				  0x0 0x100000>;
 		};
 	};
-
 };
 
 /include/ "fsl/p1023si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/p2041rdb.dts
index 1060716..41797ca 100644
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
@@ -58,10 +58,28 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
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
index 253d01b..a984854 100644
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
@@ -59,10 +59,28 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
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
index f6b4923..4c2c3d2 100644
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
@@ -59,10 +59,28 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
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
index 981f5df..6d59261 100644
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
@@ -59,10 +59,28 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
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
index a5be79d..a9e9389 100644
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
@@ -73,10 +73,28 @@
 		hydra_xg_slot2 = &hydra_xg_slot2;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
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
index 234f4b5..c43e5b3 100644
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
@@ -38,6 +38,20 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
+		};
+	};
+
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
@@ -77,6 +91,10 @@
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
index 1cf0f3c..2b62eb9 100644
--- a/arch/powerpc/boot/dts/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/t104xrdb.dtsi
@@ -34,6 +34,20 @@
 
 / {
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
+		};
+	};
+
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
@@ -69,6 +83,10 @@
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
index 555dc6e..77f7f28 100644
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
@@ -39,6 +39,20 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
+		};
+	};
+
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
@@ -78,6 +92,10 @@
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
index 1481e19..2fc352f 100644
--- a/arch/powerpc/boot/dts/t208xrdb.dtsi
+++ b/arch/powerpc/boot/dts/t208xrdb.dtsi
@@ -39,6 +39,20 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
+		};
+	};
+
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
@@ -79,6 +93,10 @@
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
index e9f528c..c2c3cfc 100644
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
@@ -288,10 +288,28 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
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
index 53761d4..3231815 100644
--- a/arch/powerpc/boot/dts/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/t4240rdb.dts
@@ -69,10 +69,28 @@
 		device_type = "memory";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+			no-map;
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
2.1.3
