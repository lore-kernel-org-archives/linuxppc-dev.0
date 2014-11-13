Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D3F11A0885
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 20:31:35 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0105.outbound.protection.outlook.com [157.56.111.105])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 862081400B6
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 20:31:32 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/mpc85xx: Add DPAA Q/BMan support to device tree(s)
Date: Thu, 13 Nov 2014 03:21:53 -0600
Message-ID: <1415870513-10632-1-git-send-email-Emilian.Medve@Freescale.com>
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

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
Change-Id: If643fa5ba0a903aef8f5056a2c90ebecc995b760
---

Based on:
	http://patchwork.ozlabs.org/patch/407034
	http://patchwork.ozlabs.org/patch/407037
	http://patchwork.ozlabs.org/patch/407035
	http://patchwork.ozlabs.org/patch/407036

 arch/powerpc/boot/dts/b4qds.dtsi            |  42 +-
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |   2 +-
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   2 +-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi | 129 ++++++-
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   3 +-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 180 ++++++++-
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi |  61 ++-
 arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi  |   2 +-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |   9 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |   9 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |   9 +-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |   9 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi |   9 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 128 ++++++-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 216 ++++++++++-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 568 +++++++++++++++++++++++++++-
 arch/powerpc/boot/dts/kmcoge4.dts           |  40 ++
 arch/powerpc/boot/dts/oca4080.dts           |  40 ++
 arch/powerpc/boot/dts/p1023rdb.dts          |  43 ++-
 arch/powerpc/boot/dts/p2041rdb.dts          |  42 +-
 arch/powerpc/boot/dts/p3041ds.dts           |  42 +-
 arch/powerpc/boot/dts/p4080ds.dts           |  42 +-
 arch/powerpc/boot/dts/p5020ds.dts           |  42 +-
 arch/powerpc/boot/dts/p5040ds.dts           |  42 +-
 arch/powerpc/boot/dts/t104xqds.dtsi         |  42 +-
 arch/powerpc/boot/dts/t104xrdb.dtsi         |  40 ++
 arch/powerpc/boot/dts/t208xqds.dtsi         |  42 +-
 arch/powerpc/boot/dts/t208xrdb.dtsi         |  40 ++
 arch/powerpc/boot/dts/t4240qds.dts          |  42 +-
 arch/powerpc/boot/dts/t4240rdb.dts          |  40 ++
 30 files changed, 1930 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
index 6188583..48c3fb4 100644
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
@@ -38,6 +38,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
 
 	aliases {
 		phy_sgmii_10 = &phy_sgmii_10;
@@ -104,10 +105,49 @@
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
+			reusable;
+		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+			reusable;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+			reusable;
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
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
index 86161ae..0f56263 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * B4420 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 - 2014 Freescale Semiconductor, Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index 338af7e..f392949 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * B4420 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 - 2014 Freescale Semiconductor, Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index f356ed2..38e297b 100644
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
@@ -109,6 +109,133 @@
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
+&qportals {
+	qportal14: qman-portal@38000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x38000 0x4000>, <0x100e000 0x1000>;
+		interrupts = <132 0x2 0 0>;
+		fsl,qman-channel-id = <0xe>;
+	};
+	qportal15: qman-portal@3c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x3c000 0x4000>, <0x100f000 0x1000>;
+		interrupts = <134 0x2 0 0>;
+		fsl,qman-channel-id = <0xf>;
+	};
+	qportal16: qman-portal@40000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x40000 0x4000>, <0x1010000 0x1000>;
+		interrupts = <136 0x2 0 0>;
+		fsl,qman-channel-id = <0x10>;
+	};
+	qportal17: qman-portal@44000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x44000 0x4000>, <0x1011000 0x1000>;
+		interrupts = <138 0x2 0 0>;
+		fsl,qman-channel-id = <0x11>;
+	};
+	qportal18: qman-portal@48000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x48000 0x4000>, <0x1012000 0x1000>;
+		interrupts = <140 0x2 0 0>;
+		fsl,qman-channel-id = <0x12>;
+	};
+	qportal19: qman-portal@4c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x4c000 0x4000>, <0x1013000 0x1000>;
+		interrupts = <142 0x2 0 0>;
+		fsl,qman-channel-id = <0x13>;
+	};
+	qportal20: qman-portal@50000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x50000 0x4000>, <0x1014000 0x1000>;
+		interrupts = <144 0x2 0 0>;
+		fsl,qman-channel-id = <0x14>;
+	};
+	qportal21: qman-portal@54000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x54000 0x4000>, <0x1015000 0x1000>;
+		interrupts = <146 0x2 0 0>;
+		fsl,qman-channel-id = <0x15>;
+	};
+	qportal22: qman-portal@58000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x58000 0x4000>, <0x1016000 0x1000>;
+		interrupts = <148 0x2 0 0>;
+		fsl,qman-channel-id = <0x16>;
+	};
+	qportal23: qman-portal@5c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x5c000 0x4000>, <0x1017000 0x1000>;
+		interrupts = <150 0x2 0 0>;
+		fsl,qman-channel-id = <0x17>;
+	};
+	qportal24: qman-portal@60000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x60000 0x4000>, <0x1018000 0x1000>;
+		interrupts = <152 0x2 0 0>;
+		fsl,qman-channel-id = <0x18>;
+	};
+};
+
 &soc {
 	ddr2: memory-controller@9000 {
 		compatible = "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-controller";
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
index a85e435..c10d3f3 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * B4860 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2012 Freescale Semiconductor Inc.
+ * Copyright 2012 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -58,7 +58,6 @@
 		fman0 = &fman0;
 	};
 
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 4cd4a31..62b9667 100644
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
@@ -128,6 +128,174 @@
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
+&qportals {
+	#address-cells = <0x1>;
+	#size-cells = <0x1>;
+	compatible = "simple-bus";
+
+	qportal0: qman-portal@0 {
+		compatible = "fsl,qman-portal";
+		reg = <0x0 0x4000>, <0x1000000 0x1000>;
+		interrupts = <104 0x2 0 0>;
+		fsl,qman-channel-id = <0x0>;
+	};
+	qportal1: qman-portal@4000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x4000 0x4000>, <0x1001000 0x1000>;
+		interrupts = <106 0x2 0 0>;
+		fsl,qman-channel-id = <0x1>;
+	};
+	qportal2: qman-portal@8000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x8000 0x4000>, <0x1002000 0x1000>;
+		interrupts = <108 0x2 0 0>;
+		fsl,qman-channel-id = <0x2>;
+	};
+	qportal3: qman-portal@c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xc000 0x4000>, <0x1003000 0x1000>;
+		interrupts = <110 0x2 0 0>;
+		fsl,qman-channel-id = <0x3>;
+	};
+	qportal4: qman-portal@10000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x10000 0x4000>, <0x1004000 0x1000>;
+		interrupts = <112 0x2 0 0>;
+		fsl,qman-channel-id = <0x4>;
+	};
+	qportal5: qman-portal@14000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x14000 0x4000>, <0x1005000 0x1000>;
+		interrupts = <114 0x2 0 0>;
+		fsl,qman-channel-id = <0x5>;
+	};
+	qportal6: qman-portal@18000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x18000 0x4000>, <0x1006000 0x1000>;
+		interrupts = <116 0x2 0 0>;
+		fsl,qman-channel-id = <0x6>;
+	};
+	qportal7: qman-portal@1c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x1c000 0x4000>, <0x1007000 0x1000>;
+		interrupts = <118 0x2 0 0>;
+		fsl,qman-channel-id = <0x7>;
+	};
+	qportal8: qman-portal@20000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x20000 0x4000>, <0x1008000 0x1000>;
+		interrupts = <120 0x2 0 0>;
+		fsl,qman-channel-id = <0x8>;
+	};
+	qportal9: qman-portal@24000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x24000 0x4000>, <0x1009000 0x1000>;
+		interrupts = <122 0x2 0 0>;
+		fsl,qman-channel-id = <0x9>;
+	};
+	qportal10: qman-portal@28000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x28000 0x4000>, <0x100a000 0x1000>;
+		interrupts = <124 0x2 0 0>;
+		fsl,qman-channel-id = <0xa>;
+	};
+	qportal11: qman-portal@2c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x2c000 0x4000>, <0x100b000 0x1000>;
+		interrupts = <126 0x2 0 0>;
+		fsl,qman-channel-id = <0xb>;
+	};
+	qportal12: qman-portal@30000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x30000 0x4000>, <0x100c000 0x1000>;
+		interrupts = <128 0x2 0 0>;
+		fsl,qman-channel-id = <0xc>;
+	};
+	qportal13: qman-portal@34000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x34000 0x4000>, <0x100d000 0x1000>;
+		interrupts = <130 0x2 0 0>;
+		fsl,qman-channel-id = <0xd>;
+	};
+};
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -261,6 +429,16 @@
 /include/ "qoriq-duart-1.dtsi"
 /include/ "qoriq-sec5.3-0.dtsi"
 
+/include/ "qoriq-qman3.dtsi"
+	qman: qman@318000 {
+		interrupts = <16 2 1 28>;
+	};
+
+/include/ "qoriq-bman1.dtsi"
+	bman: bman@31a000 {
+		interrupts = <16 2 1 29>;
+	};
+
 /include/ "qoriq-fman3-0.dtsi"
 /include/ "qoriq-fman3-0-1g-0.dtsi"
 /include/ "qoriq-fman3-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
index 01fd153..8cc40a6 100644
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
@@ -97,6 +97,53 @@
 	};
 };
 
+&qportals {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "simple-bus";
+
+	qportal0: qman-portal@0 {
+		compatible = "fsl,qman-portal";
+		reg = <0x0 0x4000>, <0x100000 0x1000>;
+		interrupts = <29 2 0 0>;
+		fsl,qman-channel-id = <0>;
+	};
+	qportal1: qman-portal@4000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x4000 0x4000>, <0x101000 0x1000>;
+		interrupts = <31 2 0 0>;
+		fsl,qman-channel-id = <1>;
+	};
+	qportal2: qman-portal@8000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x8000 0x4000>, <0x102000 0x1000>;
+		interrupts = <33 2 0 0>;
+		fsl,qman-channel-id = <2>;
+	};
+};
+
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
@@ -221,6 +268,18 @@
 /include/ "pq3-mpic.dtsi"
 /include/ "pq3-mpic-timer-B.dtsi"
 
+	qman: qman@88000 {
+		compatible = "fsl,qman";
+		reg = <0x88000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
+	bman: bman@8a000 {
+		compatible = "fsl,bman";
+		reg = <0x8a000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
 	global-utilities@e0000 {
 		compatible = "fsl,p1023-guts";
 		reg = <0xe0000 0x1000>;
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
index 132a152..01d8b3f 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * P1023/P1017 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 37d35da..e21194b 100644
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
@@ -216,6 +216,10 @@
 	};
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
+/include/ "qoriq-qman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -408,6 +412,9 @@ crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-qman1.dtsi"
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-fman-0.dtsi"
 /include/ "qoriq-fman-0-1g-0.dtsi"
 /include/ "qoriq-fman-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index 0e9a07d..c736456 100644
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
@@ -243,6 +243,10 @@
 	};
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
+/include/ "qoriq-qman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -435,6 +439,9 @@ crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-qman1.dtsi"
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-fman-0.dtsi"
 /include/ "qoriq-fman-0-1g-0.dtsi"
 /include/ "qoriq-fman-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 090c586..f30ef14 100644
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
@@ -243,6 +243,10 @@
 
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
+/include/ "qoriq-qman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -491,6 +495,9 @@ crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-qman1.dtsi"
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-fman-0.dtsi"
 /include/ "qoriq-fman-0-1g-0.dtsi"
 /include/ "qoriq-fman-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index db82352..3285015 100644
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
@@ -240,6 +240,10 @@
 	};
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
+/include/ "qoriq-qman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -421,6 +425,9 @@
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-qman1.dtsi"
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-raid1.0-0.dtsi"
 	raideng@320000 {
 		fsl,iommu-parent = <&pamu1>;
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index cd44659..9a8141a 100644
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
@@ -195,6 +195,10 @@
 	};
 };
 
+/include/ "qoriq-bman1-portals.dtsi"
+
+/include/ "qoriq-qman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -400,6 +404,9 @@
 		fsl,iommu-parent = <&pamu4>;
 	};
 
+/include/ "qoriq-qman1.dtsi"
+/include/ "qoriq-bman1.dtsi"
+
 /include/ "qoriq-fman-0.dtsi"
 /include/ "qoriq-fman-0-1g-0.dtsi"
 /include/ "qoriq-fman-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 15ae462..ca1d42f 100644
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
@@ -218,6 +218,130 @@
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
+&qportals {
+	#address-cells = <0x1>;
+	#size-cells = <0x1>;
+	compatible = "simple-bus";
+
+	qportal0: qman-portal@0 {
+		compatible = "fsl,qman-portal";
+		reg = <0x0 0x4000>, <0x1000000 0x1000>;
+		interrupts = <104 0x2 0 0>;
+		fsl,qman-channel-id = <0x0>;
+	};
+	qportal1: qman-portal@4000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x4000 0x4000>, <0x1001000 0x1000>;
+		interrupts = <106 0x2 0 0>;
+		fsl,qman-channel-id = <0x1>;
+	};
+	qportal2: qman-portal@8000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x8000 0x4000>, <0x1002000 0x1000>;
+		interrupts = <108 0x2 0 0>;
+		fsl,qman-channel-id = <0x2>;
+	};
+	qportal3: qman-portal@c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xc000 0x4000>, <0x1003000 0x1000>;
+		interrupts = <110 0x2 0 0>;
+		fsl,qman-channel-id = <0x3>;
+	};
+	qportal4: qman-portal@10000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x10000 0x4000>, <0x1004000 0x1000>;
+		interrupts = <112 0x2 0 0>;
+		fsl,qman-channel-id = <0x4>;
+	};
+	qportal5: qman-portal@14000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x14000 0x4000>, <0x1005000 0x1000>;
+		interrupts = <114 0x2 0 0>;
+		fsl,qman-channel-id = <0x5>;
+	};
+	qportal6: qman-portal@18000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x18000 0x4000>, <0x1006000 0x1000>;
+		interrupts = <116 0x2 0 0>;
+		fsl,qman-channel-id = <0x6>;
+	};
+	qportal7: qman-portal@1c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x1c000 0x4000>, <0x1007000 0x1000>;
+		interrupts = <118 0x2 0 0>;
+		fsl,qman-channel-id = <0x7>;
+	};
+	qportal8: qman-portal@20000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x20000 0x4000>, <0x1008000 0x1000>;
+		interrupts = <120 0x2 0 0>;
+		fsl,qman-channel-id = <0x8>;
+	};
+	qportal9: qman-portal@24000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x24000 0x4000>, <0x1009000 0x1000>;
+		interrupts = <122 0x2 0 0>;
+		fsl,qman-channel-id = <0x9>;
+	};
+};
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -401,4 +525,6 @@
 		fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
 	};
 /include/ "qoriq-sec5.0-0.dtsi"
+/include/ "qoriq-qman3.dtsi"
+/include/ "qoriq-bman1.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index 1ce91e3..0ce61c0 100644
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
@@ -224,6 +224,218 @@
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
+&qportals {
+	#address-cells = <0x1>;
+	#size-cells = <0x1>;
+	compatible = "simple-bus";
+
+	qportal0: qman-portal@0 {
+		compatible = "fsl,qman-portal";
+		reg = <0x0 0x4000>, <0x1000000 0x1000>;
+		interrupts = <104 0x2 0 0>;
+		fsl,qman-channel-id = <0x0>;
+	};
+	qportal1: qman-portal@4000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x4000 0x4000>, <0x1001000 0x1000>;
+		interrupts = <106 0x2 0 0>;
+		fsl,qman-channel-id = <0x1>;
+	};
+	qportal2: qman-portal@8000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x8000 0x4000>, <0x1002000 0x1000>;
+		interrupts = <108 0x2 0 0>;
+		fsl,qman-channel-id = <0x2>;
+	};
+	qportal3: qman-portal@c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xc000 0x4000>, <0x1003000 0x1000>;
+		interrupts = <110 0x2 0 0>;
+		fsl,qman-channel-id = <0x3>;
+	};
+	qportal4: qman-portal@10000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x10000 0x4000>, <0x1004000 0x1000>;
+		interrupts = <112 0x2 0 0>;
+		fsl,qman-channel-id = <0x4>;
+	};
+	qportal5: qman-portal@14000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x14000 0x4000>, <0x1005000 0x1000>;
+		interrupts = <114 0x2 0 0>;
+		fsl,qman-channel-id = <0x5>;
+	};
+	qportal6: qman-portal@18000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x18000 0x4000>, <0x1006000 0x1000>;
+		interrupts = <116 0x2 0 0>;
+		fsl,qman-channel-id = <0x6>;
+	};
+	qportal7: qman-portal@1c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x1c000 0x4000>, <0x1007000 0x1000>;
+		interrupts = <118 0x2 0 0>;
+		fsl,qman-channel-id = <0x7>;
+	};
+	qportal8: qman-portal@20000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x20000 0x4000>, <0x1008000 0x1000>;
+		interrupts = <120 0x2 0 0>;
+		fsl,qman-channel-id = <0x8>;
+	};
+	qportal9: qman-portal@24000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x24000 0x4000>, <0x1009000 0x1000>;
+		interrupts = <122 0x2 0 0>;
+		fsl,qman-channel-id = <0x9>;
+	};
+	qportal10: qman-portal@28000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x28000 0x4000>, <0x100a000 0x1000>;
+		interrupts = <124 0x2 0 0>;
+		fsl,qman-channel-id = <0xa>;
+	};
+	qportal11: qman-portal@2c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x2c000 0x4000>, <0x100b000 0x1000>;
+		interrupts = <126 0x2 0 0>;
+		fsl,qman-channel-id = <0xb>;
+	};
+	qportal12: qman-portal@30000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x30000 0x4000>, <0x100c000 0x1000>;
+		interrupts = <128 0x2 0 0>;
+		fsl,qman-channel-id = <0xc>;
+	};
+	qportal13: qman-portal@34000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x34000 0x4000>, <0x100d000 0x1000>;
+		interrupts = <130 0x2 0 0>;
+		fsl,qman-channel-id = <0xd>;
+	};
+	qportal14: qman-portal@38000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x38000 0x4000>, <0x100e000 0x1000>;
+		interrupts = <132 0x2 0 0>;
+		fsl,qman-channel-id = <0xe>;
+	};
+	qportal15: qman-portal@3c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x3c000 0x4000>, <0x100f000 0x1000>;
+		interrupts = <134 0x2 0 0>;
+		fsl,qman-channel-id = <0xf>;
+	};
+	qportal16: qman-portal@40000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x40000 0x4000>, <0x1010000 0x1000>;
+		interrupts = <136 0x2 0 0>;
+		fsl,qman-channel-id = <0x10>;
+	};
+	qportal17: qman-portal@44000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x44000 0x4000>, <0x1011000 0x1000>;
+		interrupts = <138 0x2 0 0>;
+		fsl,qman-channel-id = <0x11>;
+	};
+};
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -400,6 +612,8 @@
 		phy_type = "utmi";
 	};
 /include/ "qoriq-sec5.2-0.dtsi"
+/include/ "qoriq-qman3.dtsi"
+/include/ "qoriq-bman1.dtsi"
 
 	L2_1: l2-cache-controller@c20000 {
 		/* Cluster 0 L2 cache */
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index b73ee47..e5c2618 100644
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
@@ -294,6 +294,570 @@
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
+&qportals {
+	#address-cells = <0x1>;
+	#size-cells = <0x1>;
+	compatible = "simple-bus";
+
+	qportal0: qman-portal@0 {
+		compatible = "fsl,qman-portal";
+		reg = <0x0 0x4000>, <0x1000000 0x1000>;
+		interrupts = <104 0x2 0 0>;
+		fsl,qman-channel-id = <0x0>;
+	};
+	qportal1: qman-portal@4000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x4000 0x4000>, <0x1001000 0x1000>;
+		interrupts = <106 0x2 0 0>;
+		fsl,qman-channel-id = <0x1>;
+	};
+	qportal2: qman-portal@8000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x8000 0x4000>, <0x1002000 0x1000>;
+		interrupts = <108 0x2 0 0>;
+		fsl,qman-channel-id = <0x2>;
+	};
+	qportal3: qman-portal@c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xc000 0x4000>, <0x1003000 0x1000>;
+		interrupts = <110 0x2 0 0>;
+		fsl,qman-channel-id = <0x3>;
+	};
+	qportal4: qman-portal@10000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x10000 0x4000>, <0x1004000 0x1000>;
+		interrupts = <112 0x2 0 0>;
+		fsl,qman-channel-id = <0x4>;
+	};
+	qportal5: qman-portal@14000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x14000 0x4000>, <0x1005000 0x1000>;
+		interrupts = <114 0x2 0 0>;
+		fsl,qman-channel-id = <0x5>;
+	};
+	qportal6: qman-portal@18000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x18000 0x4000>, <0x1006000 0x1000>;
+		interrupts = <116 0x2 0 0>;
+		fsl,qman-channel-id = <0x6>;
+	};
+	qportal7: qman-portal@1c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x1c000 0x4000>, <0x1007000 0x1000>;
+		interrupts = <118 0x2 0 0>;
+		fsl,qman-channel-id = <0x7>;
+	};
+	qportal8: qman-portal@20000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x20000 0x4000>, <0x1008000 0x1000>;
+		interrupts = <120 0x2 0 0>;
+		fsl,qman-channel-id = <0x8>;
+	};
+	qportal9: qman-portal@24000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x24000 0x4000>, <0x1009000 0x1000>;
+		interrupts = <122 0x2 0 0>;
+		fsl,qman-channel-id = <0x9>;
+	};
+	qportal10: qman-portal@28000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x28000 0x4000>, <0x100a000 0x1000>;
+		interrupts = <124 0x2 0 0>;
+		fsl,qman-channel-id = <0xa>;
+	};
+	qportal11: qman-portal@2c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x2c000 0x4000>, <0x100b000 0x1000>;
+		interrupts = <126 0x2 0 0>;
+		fsl,qman-channel-id = <0xb>;
+	};
+	qportal12: qman-portal@30000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x30000 0x4000>, <0x100c000 0x1000>;
+		interrupts = <128 0x2 0 0>;
+		fsl,qman-channel-id = <0xc>;
+	};
+	qportal13: qman-portal@34000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x34000 0x4000>, <0x100d000 0x1000>;
+		interrupts = <130 0x2 0 0>;
+		fsl,qman-channel-id = <0xd>;
+	};
+	qportal14: qman-portal@38000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x38000 0x4000>, <0x100e000 0x1000>;
+		interrupts = <132 0x2 0 0>;
+		fsl,qman-channel-id = <0xe>;
+	};
+	qportal15: qman-portal@3c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x3c000 0x4000>, <0x100f000 0x1000>;
+		interrupts = <134 0x2 0 0>;
+		fsl,qman-channel-id = <0xf>;
+	};
+	qportal16: qman-portal@40000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x40000 0x4000>, <0x1010000 0x1000>;
+		interrupts = <136 0x2 0 0>;
+		fsl,qman-channel-id = <0x10>;
+	};
+	qportal17: qman-portal@44000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x44000 0x4000>, <0x1011000 0x1000>;
+		interrupts = <138 0x2 0 0>;
+		fsl,qman-channel-id = <0x11>;
+	};
+	qportal18: qman-portal@48000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x48000 0x4000>, <0x1012000 0x1000>;
+		interrupts = <140 0x2 0 0>;
+		fsl,qman-channel-id = <0x12>;
+	};
+	qportal19: qman-portal@4c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x4c000 0x4000>, <0x1013000 0x1000>;
+		interrupts = <142 0x2 0 0>;
+		fsl,qman-channel-id = <0x13>;
+	};
+	qportal20: qman-portal@50000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x50000 0x4000>, <0x1014000 0x1000>;
+		interrupts = <144 0x2 0 0>;
+		fsl,qman-channel-id = <0x14>;
+	};
+	qportal21: qman-portal@54000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x54000 0x4000>, <0x1015000 0x1000>;
+		interrupts = <146 0x2 0 0>;
+		fsl,qman-channel-id = <0x15>;
+	};
+	qportal22: qman-portal@58000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x58000 0x4000>, <0x1016000 0x1000>;
+		interrupts = <148 0x2 0 0>;
+		fsl,qman-channel-id = <0x16>;
+	};
+	qportal23: qman-portal@5c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x5c000 0x4000>, <0x1017000 0x1000>;
+		interrupts = <150 0x2 0 0>;
+		fsl,qman-channel-id = <0x17>;
+	};
+	qportal24: qman-portal@60000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x60000 0x4000>, <0x1018000 0x1000>;
+		interrupts = <152 0x2 0 0>;
+		fsl,qman-channel-id = <0x18>;
+	};
+	qportal25: qman-portal@64000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x64000 0x4000>, <0x1019000 0x1000>;
+		interrupts = <154 0x2 0 0>;
+		fsl,qman-channel-id = <0x19>;
+	};
+	qportal26: qman-portal@68000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x68000 0x4000>, <0x101a000 0x1000>;
+		interrupts = <156 0x2 0 0>;
+		fsl,qman-channel-id = <0x1a>;
+	};
+	qportal27: qman-portal@6c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x6c000 0x4000>, <0x101b000 0x1000>;
+		interrupts = <158 0x2 0 0>;
+		fsl,qman-channel-id = <0x1b>;
+	};
+	qportal28: qman-portal@70000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x70000 0x4000>, <0x101c000 0x1000>;
+		interrupts = <160 0x2 0 0>;
+		fsl,qman-channel-id = <0x1c>;
+	};
+	qportal29: qman-portal@74000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x74000 0x4000>, <0x101d000 0x1000>;
+		interrupts = <162 0x2 0 0>;
+		fsl,qman-channel-id = <0x1d>;
+	};
+	qportal30: qman-portal@78000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x78000 0x4000>, <0x101e000 0x1000>;
+		interrupts = <164 0x2 0 0>;
+		fsl,qman-channel-id = <0x1e>;
+	};
+	qportal31: qman-portal@7c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x7c000 0x4000>, <0x101f000 0x1000>;
+		interrupts = <166 0x2 0 0>;
+		fsl,qman-channel-id = <0x1f>;
+	};
+	qportal32: qman-portal@80000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x80000 0x4000>, <0x1020000 0x1000>;
+		interrupts = <168 0x2 0 0>;
+		fsl,qman-channel-id = <0x20>;
+	};
+	qportal33: qman-portal@84000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x84000 0x4000>, <0x1021000 0x1000>;
+		interrupts = <170 0x2 0 0>;
+		fsl,qman-channel-id = <0x21>;
+	};
+	qportal34: qman-portal@88000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x88000 0x4000>, <0x1022000 0x1000>;
+		interrupts = <172 0x2 0 0>;
+		fsl,qman-channel-id = <0x22>;
+	};
+	qportal35: qman-portal@8c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x8c000 0x4000>, <0x1023000 0x1000>;
+		interrupts = <174 0x2 0 0>;
+		fsl,qman-channel-id = <0x23>;
+	};
+	qportal36: qman-portal@90000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x90000 0x4000>, <0x1024000 0x1000>;
+		interrupts = <384 0x2 0 0>;
+		fsl,qman-channel-id = <0x24>;
+	};
+	qportal37: qman-portal@94000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x94000 0x4000>, <0x1025000 0x1000>;
+		interrupts = <386 0x2 0 0>;
+		fsl,qman-channel-id = <0x25>;
+	};
+	qportal38: qman-portal@98000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x98000 0x4000>, <0x1026000 0x1000>;
+		interrupts = <388 0x2 0 0>;
+		fsl,qman-channel-id = <0x26>;
+	};
+	qportal39: qman-portal@9c000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x9c000 0x4000>, <0x1027000 0x1000>;
+		interrupts = <390 0x2 0 0>;
+		fsl,qman-channel-id = <0x27>;
+	};
+	qportal40: qman-portal@a0000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xa0000 0x4000>, <0x1028000 0x1000>;
+		interrupts = <392 0x2 0 0>;
+		fsl,qman-channel-id = <0x28>;
+	};
+	qportal41: qman-portal@a4000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xa4000 0x4000>, <0x1029000 0x1000>;
+		interrupts = <394 0x2 0 0>;
+		fsl,qman-channel-id = <0x29>;
+	};
+	qportal42: qman-portal@a8000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xa8000 0x4000>, <0x102a000 0x1000>;
+		interrupts = <396 0x2 0 0>;
+		fsl,qman-channel-id = <0x2a>;
+	};
+	qportal43: qman-portal@ac000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xac000 0x4000>, <0x102b000 0x1000>;
+		interrupts = <398 0x2 0 0>;
+		fsl,qman-channel-id = <0x2b>;
+	};
+	qportal44: qman-portal@b0000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xb0000 0x4000>, <0x102c000 0x1000>;
+		interrupts = <400 0x2 0 0>;
+		fsl,qman-channel-id = <0x2c>;
+	};
+	qportal45: qman-portal@b4000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xb4000 0x4000>, <0x102d000 0x1000>;
+		interrupts = <402 0x2 0 0>;
+		fsl,qman-channel-id = <0x2d>;
+	};
+	qportal46: qman-portal@b8000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xb8000 0x4000>, <0x102e000 0x1000>;
+		interrupts = <404 0x2 0 0>;
+		fsl,qman-channel-id = <0x2e>;
+	};
+	qportal47: qman-portal@bc000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xbc000 0x4000>, <0x102f000 0x1000>;
+		interrupts = <406 0x2 0 0>;
+		fsl,qman-channel-id = <0x2f>;
+	};
+	qportal48: qman-portal@c0000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xc0000 0x4000>, <0x1030000 0x1000>;
+		interrupts = <408 0x2 0 0>;
+		fsl,qman-channel-id = <0x30>;
+	};
+	qportal49: qman-portal@c4000 {
+		compatible = "fsl,qman-portal";
+		reg = <0xc4000 0x4000>, <0x1031000 0x1000>;
+		interrupts = <410 0x2 0 0>;
+		fsl,qman-channel-id = <0x31>;
+	};
+};
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -486,6 +1050,8 @@
 /include/ "qoriq-sata2-0.dtsi"
 /include/ "qoriq-sata2-1.dtsi"
 /include/ "qoriq-sec5.0-0.dtsi"
+/include/ "qoriq-qman3.dtsi"
+/include/ "qoriq-bman1.dtsi"
 /include/ "qoriq-fman3-0.dtsi"
 /include/ "qoriq-fman3-0-1g-0.dtsi"
 /include/ "qoriq-fman3-0-1g-1.dtsi"
diff --git a/arch/powerpc/boot/dts/kmcoge4.dts b/arch/powerpc/boot/dts/kmcoge4.dts
index 89b4119..77ed595 100644
--- a/arch/powerpc/boot/dts/kmcoge4.dts
+++ b/arch/powerpc/boot/dts/kmcoge4.dts
@@ -20,15 +20,55 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
 
 	memory {
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
+			reusable;
+		};
+                qman_fqd: qman-fqd {
+                        compatible = "fsl,qman-fqd";
+                        alloc-ranges = <0 0 0xffff 0xffffffff>;
+                        size = <0 0x400000>;
+                        alignment = <0 0x400000>;
+                        no-map;
+                        reusable;
+                };
+                qman_pfdr: qman-pfdr {
+                        compatible = "fsl,qman-pfdr";
+                        alloc-ranges = <0 0 0xffff 0xffffffff>;
+                        size = <0 0x2000000>;
+                        alignment = <0 0x2000000>;
+                        no-map;
+                        reusable;
+                };
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x200000>;
+	};
+
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/oca4080.dts b/arch/powerpc/boot/dts/oca4080.dts
index 3d4c751..60c9b0a 100644
--- a/arch/powerpc/boot/dts/oca4080.dts
+++ b/arch/powerpc/boot/dts/oca4080.dts
@@ -44,15 +44,55 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
 
 	memory {
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
+			reusable;
+		};
+                qman_fqd: qman-fqd {
+                        compatible = "fsl,qman-fqd";
+                        alloc-ranges = <0 0 0xffff 0xffffffff>;
+                        size = <0 0x400000>;
+                        alignment = <0 0x400000>;
+                        no-map;
+                        reusable;
+                };
+                qman_pfdr: qman-pfdr {
+                        compatible = "fsl,qman-pfdr";
+                        alloc-ranges = <0 0 0xffff 0xffffffff>;
+                        size = <0 0x2000000>;
+                        alignment = <0 0x2000000>;
+                        no-map;
+                        reusable;
+                };
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x200000>;
+	};
+
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p1023rdb.dts b/arch/powerpc/boot/dts/p1023rdb.dts
index d121bda..9335896 100644
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
@@ -42,11 +42,51 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
 
 	memory {
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
+			reusable;
+		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+			reusable;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+			reusable;
+		};
+	};
+
+	qportals: qman-portals@ff000000 {
+		ranges = <0x0 0xf 0xff000000 0x200000>;
+	};
+
+	bportals: bman-portals@ff200000 {
+		ranges = <0x0 0xf 0xff200000 0x200000>;
+	};
+
 	soc: soc@ff600000 {
 		ranges = <0x0 0x0 0xff600000 0x200000>;
 
@@ -247,7 +287,6 @@
 				  0x0 0x100000>;
 		};
 	};
-
 };
 
 /include/ "fsl/p1023si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/p2041rdb.dts
index 1060716..15821f8 100644
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
@@ -40,6 +40,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
 
 	aliases {
 		phy_rgmii_0 = &phy_rgmii_0;
@@ -58,10 +59,49 @@
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
+			reusable;
+		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+			reusable;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+			reusable;
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
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index 253d01b..813213f 100644
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
@@ -40,6 +40,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
 
 	aliases{
 		phy_rgmii_0 = &phy_rgmii_0;
@@ -59,10 +60,49 @@
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
+			reusable;
+		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+			reusable;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+			reusable;
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
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index f6b4923..7a93b9e 100644
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
@@ -40,6 +40,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
 
 	aliases {
 		phy_rgmii = &phyrgmii;
@@ -59,10 +60,49 @@
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
+			reusable;
+		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+			reusable;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+			reusable;
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
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index 981f5df..b2ec893 100644
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
@@ -40,6 +40,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
 
 	aliases {
 		phy_rgmii_0 = &phy_rgmii_0;
@@ -59,10 +60,49 @@
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
+			reusable;
+		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+			reusable;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+			reusable;
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
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/p5040ds.dts
index a5be79d..1e4d88a 100644
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
@@ -40,6 +40,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
 
 	memory {
 		device_type = "memory";
@@ -73,10 +74,49 @@
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
+			reusable;
+		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+			reusable;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+			reusable;
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
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t104xqds.dtsi b/arch/powerpc/boot/dts/t104xqds.dtsi
index 234f4b5..57ed431 100644
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
@@ -37,6 +37,38 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
+
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
+			reusable;
+		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+			reusable;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+			reusable;
+		};
+	};
 
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
@@ -77,6 +109,14 @@
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t104xrdb.dtsi b/arch/powerpc/boot/dts/t104xrdb.dtsi
index 1cf0f3c..9f6b58b 100644
--- a/arch/powerpc/boot/dts/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/t104xrdb.dtsi
@@ -33,6 +33,38 @@
  */
 
 / {
+	reserved-ranges;
+
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
+			reusable;
+		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+			reusable;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+			reusable;
+		};
+	};
 
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
@@ -69,6 +101,14 @@
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t208xqds.dtsi b/arch/powerpc/boot/dts/t208xqds.dtsi
index 555dc6e..598a781 100644
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
@@ -38,6 +38,38 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
+
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
+			reusable;
+		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+			reusable;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+			reusable;
+		};
+	};
 
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
@@ -78,6 +110,14 @@
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t208xrdb.dtsi b/arch/powerpc/boot/dts/t208xrdb.dtsi
index 1481e19..ebe1c61 100644
--- a/arch/powerpc/boot/dts/t208xrdb.dtsi
+++ b/arch/powerpc/boot/dts/t208xrdb.dtsi
@@ -38,6 +38,38 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
+
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
+			reusable;
+		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+			reusable;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+			reusable;
+		};
+	};
 
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
@@ -79,6 +111,14 @@
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/t4240qds.dts
index e9f528c..4c57324 100644
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
@@ -40,6 +40,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
 
 	aliases{
 		phy_rgmii1 = &phyrgmii1;
@@ -288,10 +289,49 @@
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
+			reusable;
+		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+			reusable;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+			reusable;
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
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t4240rdb.dts b/arch/powerpc/boot/dts/t4240rdb.dts
index 53761d4..69f5e91 100644
--- a/arch/powerpc/boot/dts/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/t4240rdb.dts
@@ -40,6 +40,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+	reserved-ranges;
 
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
@@ -69,10 +70,49 @@
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
+			reusable;
+		};
+                qman_fqd: qman-fqd {
+                        compatible = "fsl,qman-fqd";
+                        alloc-ranges = <0 0 0xffff 0xffffffff>;
+                        size = <0 0x400000>;
+                        alignment = <0 0x400000>;
+                        no-map;
+                        reusable;
+                };
+                qman_pfdr: qman-pfdr {
+                        compatible = "fsl,qman-pfdr";
+                        alloc-ranges = <0 0 0xffff 0xffffffff>;
+                        size = <0 0x2000000>;
+                        alignment = <0 0x2000000>;
+                        no-map;
+                        reusable;
+                };
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
-- 
2.1.3
