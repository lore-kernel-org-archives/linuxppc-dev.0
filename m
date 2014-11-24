Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CA261A04EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Nov 2014 22:17:46 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0108.outbound.protection.outlook.com [157.56.111.108])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E8013140100
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2014 22:17:44 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH v2 4/4] powerpc/mpc85xx: Add FSL QorIQ DPAA QMan support to
 device tree(s)
Date: Mon, 24 Nov 2014 05:07:23 -0600
Message-ID: <1416827243-16396-5-git-send-email-Emilian.Medve@Freescale.com>
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
 arch/powerpc/boot/dts/b4qds.dtsi            |  18 ++
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  69 +++++++
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  96 +++++++++
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi |  31 +++
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |   3 +
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |   3 +
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |   3 +
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |   3 +
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi |   3 +
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi |  68 ++++++
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 116 +++++++++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 308 ++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/kmcoge4.dts           |  18 ++
 arch/powerpc/boot/dts/oca4080.dts           |  18 ++
 arch/powerpc/boot/dts/p1023rdb.dts          |  18 ++
 arch/powerpc/boot/dts/p2041rdb.dts          |  18 ++
 arch/powerpc/boot/dts/p3041ds.dts           |  18 ++
 arch/powerpc/boot/dts/p4080ds.dts           |  18 ++
 arch/powerpc/boot/dts/p5020ds.dts           |  18 ++
 arch/powerpc/boot/dts/p5040ds.dts           |  18 ++
 arch/powerpc/boot/dts/t104xqds.dtsi         |  18 ++
 arch/powerpc/boot/dts/t104xrdb.dtsi         |  18 ++
 arch/powerpc/boot/dts/t208xqds.dtsi         |  18 ++
 arch/powerpc/boot/dts/t208xrdb.dtsi         |  18 ++
 arch/powerpc/boot/dts/t4240qds.dts          |  18 ++
 arch/powerpc/boot/dts/t4240rdb.dts          |  18 ++
 26 files changed, 973 insertions(+)

diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
index 3a73103..3063b8a 100644
--- a/arch/powerpc/boot/dts/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/b4qds.dtsi
@@ -116,6 +116,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
 	};
 
 	dcsr: dcsr@f00000000 {
@@ -126,6 +140,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x2000000>;
 	};
 
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index 2dd61fa..38e297b 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -167,6 +167,75 @@
 	};
 };
 
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
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index ff1d509..62b9667 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -205,6 +205,97 @@
 	};
 };
 
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
@@ -338,6 +429,11 @@
 /include/ "qoriq-duart-1.dtsi"
 /include/ "qoriq-sec5.3-0.dtsi"
 
+/include/ "qoriq-qman3.dtsi"
+	qman: qman@318000 {
+		interrupts = <16 2 1 28>;
+	};
+
 /include/ "qoriq-bman1.dtsi"
 	bman: bman@31a000 {
 		interrupts = <16 2 1 29>;
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
index 6b8e612..8cc40a6 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
@@ -97,6 +97,31 @@
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
 &bportals {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -243,6 +268,12 @@
 /include/ "pq3-mpic.dtsi"
 /include/ "pq3-mpic-timer-B.dtsi"
 
+	qman: qman@88000 {
+		compatible = "fsl,qman";
+		reg = <0x88000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
 	bman: bman@8a000 {
 		compatible = "fsl,bman";
 		reg = <0x8a000 0x1000>;
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 661d014..e21194b 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -218,6 +218,8 @@
 
 /include/ "qoriq-bman1-portals.dtsi"
 
+/include/ "qoriq-qman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -410,6 +412,7 @@ crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-qman1.dtsi"
 /include/ "qoriq-bman1.dtsi"
 
 /include/ "qoriq-fman-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index 76a893e..c736456 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -245,6 +245,8 @@
 
 /include/ "qoriq-bman1-portals.dtsi"
 
+/include/ "qoriq-qman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -437,6 +439,7 @@ crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-qman1.dtsi"
 /include/ "qoriq-bman1.dtsi"
 
 /include/ "qoriq-fman-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index a57bf1a..f30ef14 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -245,6 +245,8 @@
 
 /include/ "qoriq-bman1-portals.dtsi"
 
+/include/ "qoriq-qman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -493,6 +495,7 @@ crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-qman1.dtsi"
 /include/ "qoriq-bman1.dtsi"
 
 /include/ "qoriq-fman-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index 4e91792..3285015 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -242,6 +242,8 @@
 
 /include/ "qoriq-bman1-portals.dtsi"
 
+/include/ "qoriq-qman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -423,6 +425,7 @@
 		fsl,iommu-parent = <&pamu1>;
 	};
 
+/include/ "qoriq-qman1.dtsi"
 /include/ "qoriq-bman1.dtsi"
 
 /include/ "qoriq-raid1.0-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index a8c804f..9a8141a 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -197,6 +197,8 @@
 
 /include/ "qoriq-bman1-portals.dtsi"
 
+/include/ "qoriq-qman1-portals.dtsi"
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -402,6 +404,7 @@
 		fsl,iommu-parent = <&pamu4>;
 	};
 
+/include/ "qoriq-qman1.dtsi"
 /include/ "qoriq-bman1.dtsi"
 
 /include/ "qoriq-fman-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 9f639c2..ca1d42f 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -275,6 +275,73 @@
 	};
 };
 
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
@@ -458,5 +525,6 @@
 		fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
 	};
 /include/ "qoriq-sec5.0-0.dtsi"
+/include/ "qoriq-qman3.dtsi"
 /include/ "qoriq-bman1.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index 60366f6..0ce61c0 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -321,6 +321,121 @@
 	};
 };
 
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
@@ -497,6 +612,7 @@
 		phy_type = "utmi";
 	};
 /include/ "qoriq-sec5.2-0.dtsi"
+/include/ "qoriq-qman3.dtsi"
 /include/ "qoriq-bman1.dtsi"
 
 	L2_1: l2-cache-controller@c20000 {
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index f8d3d52..e5c2618 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -551,6 +551,313 @@
 	};
 };
 
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
@@ -743,6 +1050,7 @@
 /include/ "qoriq-sata2-0.dtsi"
 /include/ "qoriq-sata2-1.dtsi"
 /include/ "qoriq-sec5.0-0.dtsi"
+/include/ "qoriq-qman3.dtsi"
 /include/ "qoriq-bman1.dtsi"
 /include/ "qoriq-fman3-0.dtsi"
 /include/ "qoriq-fman3-0-1g-0.dtsi"
diff --git a/arch/powerpc/boot/dts/kmcoge4.dts b/arch/powerpc/boot/dts/kmcoge4.dts
index a65d946..c41f2e1 100644
--- a/arch/powerpc/boot/dts/kmcoge4.dts
+++ b/arch/powerpc/boot/dts/kmcoge4.dts
@@ -37,6 +37,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+                qman_fqd: qman-fqd {
+                        compatible = "fsl,qman-fqd";
+                        alloc-ranges = <0 0 0xffff 0xffffffff>;
+                        size = <0 0x400000>;
+                        alignment = <0 0x400000>;
+                        no-map;
+                };
+                qman_pfdr: qman-pfdr {
+                        compatible = "fsl,qman-pfdr";
+                        alloc-ranges = <0 0 0xffff 0xffffffff>;
+                        size = <0 0x2000000>;
+                        alignment = <0 0x2000000>;
+                        no-map;
+                };
 	};
 
 	dcsr: dcsr@f00000000 {
@@ -47,6 +61,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x200000>;
 	};
 
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/oca4080.dts b/arch/powerpc/boot/dts/oca4080.dts
index d51b860..092d6ea 100644
--- a/arch/powerpc/boot/dts/oca4080.dts
+++ b/arch/powerpc/boot/dts/oca4080.dts
@@ -61,6 +61,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+                qman_fqd: qman-fqd {
+                        compatible = "fsl,qman-fqd";
+                        alloc-ranges = <0 0 0xffff 0xffffffff>;
+                        size = <0 0x400000>;
+                        alignment = <0 0x400000>;
+                        no-map;
+                };
+                qman_pfdr: qman-pfdr {
+                        compatible = "fsl,qman-pfdr";
+                        alloc-ranges = <0 0 0xffff 0xffffffff>;
+                        size = <0 0x2000000>;
+                        alignment = <0 0x2000000>;
+                        no-map;
+                };
 	};
 
 	dcsr: dcsr@f00000000 {
@@ -71,6 +85,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x200000>;
 	};
 
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p1023rdb.dts b/arch/powerpc/boot/dts/p1023rdb.dts
index e769f22..a8760a6 100644
--- a/arch/powerpc/boot/dts/p1023rdb.dts
+++ b/arch/powerpc/boot/dts/p1023rdb.dts
@@ -59,6 +59,24 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
+	};
+
+	qportals: qman-portals@ff000000 {
+		ranges = <0x0 0xf 0xff000000 0x200000>;
 	};
 
 	bportals: bman-portals@ff200000 {
diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/p2041rdb.dts
index 41797ca..7ca29d4 100644
--- a/arch/powerpc/boot/dts/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/p2041rdb.dts
@@ -70,6 +70,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
 	};
 
 	dcsr: dcsr@f00000000 {
@@ -80,6 +94,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x200000>;
 	};
 
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index a984854..651829f 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -71,6 +71,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
 	};
 
 	dcsr: dcsr@f00000000 {
@@ -81,6 +95,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x200000>;
 	};
 
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 4c2c3d2..46a29ec 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -71,6 +71,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
 	};
 
 	dcsr: dcsr@f00000000 {
@@ -81,6 +95,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x200000>;
 	};
 
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index 6d59261..7289dca 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/p5020ds.dts
@@ -71,6 +71,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
 	};
 
 	dcsr: dcsr@f00000000 {
@@ -81,6 +95,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x200000>;
 	};
 
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/p5040ds.dts
index a9e9389..a066ebb 100644
--- a/arch/powerpc/boot/dts/p5040ds.dts
+++ b/arch/powerpc/boot/dts/p5040ds.dts
@@ -85,6 +85,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
 	};
 
 	dcsr: dcsr@f00000000 {
@@ -95,6 +109,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x200000>;
 	};
 
+	qportals: qman-portals@ff4200000 {
+		ranges = <0x0 0xf 0xf4200000 0x200000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t104xqds.dtsi b/arch/powerpc/boot/dts/t104xqds.dtsi
index c43e5b3..75a02cf 100644
--- a/arch/powerpc/boot/dts/t104xqds.dtsi
+++ b/arch/powerpc/boot/dts/t104xqds.dtsi
@@ -50,6 +50,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
 	};
 
 	ifc: localbus@ffe124000 {
@@ -95,6 +109,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x2000000>;
 	};
 
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t104xrdb.dtsi b/arch/powerpc/boot/dts/t104xrdb.dtsi
index 2b62eb9..2a3b811 100644
--- a/arch/powerpc/boot/dts/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/t104xrdb.dtsi
@@ -46,6 +46,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
 	};
 
 	ifc: localbus@ffe124000 {
@@ -87,6 +101,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x2000000>;
 	};
 
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t208xqds.dtsi b/arch/powerpc/boot/dts/t208xqds.dtsi
index 77f7f28..937dc7b 100644
--- a/arch/powerpc/boot/dts/t208xqds.dtsi
+++ b/arch/powerpc/boot/dts/t208xqds.dtsi
@@ -51,6 +51,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
 	};
 
 	ifc: localbus@ffe124000 {
@@ -96,6 +110,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x2000000>;
 	};
 
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t208xrdb.dtsi b/arch/powerpc/boot/dts/t208xrdb.dtsi
index 2fc352f..663cc5c 100644
--- a/arch/powerpc/boot/dts/t208xrdb.dtsi
+++ b/arch/powerpc/boot/dts/t208xrdb.dtsi
@@ -51,6 +51,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
 	};
 
 	ifc: localbus@ffe124000 {
@@ -97,6 +111,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x2000000>;
 	};
 
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/t4240qds.dts
index c2c3cfc..395da61 100644
--- a/arch/powerpc/boot/dts/t4240qds.dts
+++ b/arch/powerpc/boot/dts/t4240qds.dts
@@ -300,6 +300,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+		qman_fqd: qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+			no-map;
+		};
+		qman_pfdr: qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xffff 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+			no-map;
+		};
 	};
 
 	dcsr: dcsr@f00000000 {
@@ -310,6 +324,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x2000000>;
 	};
 
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
diff --git a/arch/powerpc/boot/dts/t4240rdb.dts b/arch/powerpc/boot/dts/t4240rdb.dts
index 3231815..b8138ff 100644
--- a/arch/powerpc/boot/dts/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/t4240rdb.dts
@@ -81,6 +81,20 @@
 			alignment = <0 0x1000000>;
 			no-map;
 		};
+                qman_fqd: qman-fqd {
+                        compatible = "fsl,qman-fqd";
+                        alloc-ranges = <0 0 0xffff 0xffffffff>;
+                        size = <0 0x400000>;
+                        alignment = <0 0x400000>;
+                        no-map;
+                };
+                qman_pfdr: qman-pfdr {
+                        compatible = "fsl,qman-pfdr";
+                        alloc-ranges = <0 0 0xffff 0xffffffff>;
+                        size = <0 0x2000000>;
+                        alignment = <0 0x2000000>;
+                        no-map;
+                };
 	};
 
 	dcsr: dcsr@f00000000 {
@@ -91,6 +105,10 @@
 		ranges = <0x0 0xf 0xf4000000 0x2000000>;
 	};
 
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
-- 
2.1.3
