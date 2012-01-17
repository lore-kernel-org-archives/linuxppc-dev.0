Return-Path: <r63061@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2DFB7B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2012 20:57:42 +1100 (EST)
From: Xie Xiaobo <X.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/dts: Add some DTS nodes and attributes for
 mpc8536ds
Date: Tue, 17 Jan 2012 17:59:50 +0800
Message-ID: <1326794391-6105-1-git-send-email-X.Xie@freescale.com>
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

1. Add partitions for NOR and NAND Flash.
2. Additional attributes for sdhc.

Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
---
 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |    5 ++
 arch/powerpc/boot/dts/mpc8536ds.dts           |    6 ++-
 arch/powerpc/boot/dts/mpc8536ds.dtsi          |   93 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8536ds_36b.dts       |    8 ++-
 4 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
index 89af626..3ebfda3 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
@@ -236,6 +236,11 @@
 	};
 
 /include/ "pq3-esdhc-0.dtsi"
+
+	sdhc@2e000 {
+		compatible = "fsl,mpc8536-esdhc", "fsl,esdhc";
+	};
+
 /include/ "pq3-sec3.0-0.dtsi"
 /include/ "pq3-mpic.dtsi"
 /include/ "pq3-mpic-timer-B.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index c158815..1973622 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -1,7 +1,7 @@
 /*
  * MPC8536 DS Device Tree Source
  *
- * Copyright 2008 Freescale Semiconductor, Inc.
+ * Copyright 2008, 2011 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -34,6 +34,10 @@
 
 	lbc: localbus@ffe05000 {
 		reg = <0 0xffe05000 0 0x1000>;
+
+		ranges = <0x0 0x0 0x0 0xe8000000 0x08000000
+			  0x2 0x0 0x0 0xffa00000 0x00040000
+			  0x3 0x0 0x0 0xffdf0000 0x00008000>;
 	};
 
 	board_soc: soc: soc@ffe00000 {
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dtsi b/arch/powerpc/boot/dts/mpc8536ds.dtsi
index 1462e4c..cc46dbd 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dtsi
+++ b/arch/powerpc/boot/dts/mpc8536ds.dtsi
@@ -32,6 +32,99 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+&lbc {
+	nor@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x8000000>;
+		bank-width = <2>;
+		device-width = <1>;
+
+		partition@0 {
+			reg = <0x0 0x03000000>;
+			label = "ramdisk-nor";
+		};
+
+		partition@3000000 {
+			reg = <0x03000000 0x00e00000>;
+			label = "diagnostic-nor";
+			read-only;
+		};
+
+		partition@3e00000 {
+			reg = <0x03e00000 0x00200000>;
+			label = "dink-nor";
+			read-only;
+		};
+
+		partition@4000000 {
+			reg = <0x04000000 0x00400000>;
+			label = "kernel-nor";
+		};
+
+		partition@4400000 {
+			reg = <0x04400000 0x03b00000>;
+			label = "fs-nor";
+		};
+
+		partition@7f00000 {
+			reg = <0x07f00000 0x00080000>;
+			label = "dtb-nor";
+		};
+
+		partition@7f80000 {
+			reg = <0x07f80000 0x00080000>;
+			label = "u-boot-nor";
+			read-only;
+		};
+	};
+
+	nand@2,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8536-fcm-nand",
+			     "fsl,elbc-fcm-nand";
+		reg = <0x2 0x0 0x40000>;
+
+		partition@0 {
+			reg = <0x0 0x02000000>;
+			label = "u-boot-nand";
+			read-only;
+		};
+
+		partition@2000000 {
+			reg = <0x02000000 0x10000000>;
+			label = "fs-nand";
+		};
+
+		partition@12000000 {
+			reg = <0x12000000 0x08000000>;
+			label = "ramdisk-nand";
+		};
+
+		partition@1a000000 {
+			reg = <0x1a000000 0x04000000>;
+			label = "kernel-nand";
+		};
+
+		partition@1e000000 {
+			reg = <0x1e000000 0x01000000>;
+			label = "dtb-nand";
+		};
+
+		partition@1f000000 {
+			reg = <0x1f000000 0x21000000>;
+			label = "empty-nand";
+		};
+	};
+
+	board-control@3,0 {
+		compatible = "fsl,mpc8536ds-fpga-pixis";
+		reg = <0x3 0x0 0x8000>;
+	};
+};
+
 &board_soc {
 	i2c@3100 {
 		rtc@68 {
diff --git a/arch/powerpc/boot/dts/mpc8536ds_36b.dts b/arch/powerpc/boot/dts/mpc8536ds_36b.dts
index 8f4b929..f8a3b34 100644
--- a/arch/powerpc/boot/dts/mpc8536ds_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds_36b.dts
@@ -1,7 +1,7 @@
 /*
  * MPC8536DS Device Tree Source (36-bit address map)
  *
- * Copyright 2008-2009 Freescale Semiconductor, Inc.
+ * Copyright 2008-2009, 2011 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -33,7 +33,11 @@
 	};
 
 	lbc: localbus@ffe05000 {
-		reg = <0 0xffe05000 0 0x1000>;
+		reg = <0xf 0xffe05000 0 0x1000>;
+
+		ranges = <0x0 0x0 0xf 0xe8000000 0x08000000
+			  0x2 0x0 0xf 0xffa00000 0x00040000
+			  0x3 0x0 0xf 0xffdf0000 0x00008000>;
 	};
 
 	board_soc: soc: soc@fffe00000 {
-- 
1.7.5.1
