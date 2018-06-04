Return-Path: <yangbo.lu@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zmTB0LfWzF0lJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 17:16:45 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 04/10] powerpc/mpc85xx: move ptp timer out of fman in dts
Date: Mon,  4 Jun 2018 15:08:31 +0800
Message-Id: <20180604070837.19265-5-yangbo.lu@nxp.com>
In-Reply-To: <20180604070837.19265-1-yangbo.lu@nxp.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is to move ptp timer node out of fman.
Because ptp timer will be probed by ptp_qoriq driver,
it should be an independent device in case of conflict
memory mapping.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi   |   14 ++++++++------
 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi   |   14 ++++++++------
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi  |   14 ++++++++------
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi  |   14 ++++++++------
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi |   14 ++++++++------
 5 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
index abd01d4..6b124f7 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
@@ -37,12 +37,13 @@ fman0: fman@400000 {
 	#size-cells = <1>;
 	cell-index = <0>;
 	compatible = "fsl,fman";
-	ranges = <0 0x400000 0x100000>;
-	reg = <0x400000 0x100000>;
+	ranges = <0 0x400000 0xfe000>;
+	reg = <0x400000 0xfe000>;
 	interrupts = <96 2 0 0>, <16 2 1 1>;
 	clocks = <&clockgen 3 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x40 0xc>;
+	ptimer-handle = <&ptp_timer0>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -93,9 +94,10 @@ fman0: fman@400000 {
 		reg = <0x87000 0x1000>;
 		status = "disabled";
 	};
+};
 
-	ptp_timer0: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer0: ptp-timer@4fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x4fe000 0x1000>;
+	interrupts = <96 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
index debea75..b80aaf5 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
@@ -37,12 +37,13 @@ fman1: fman@500000 {
 	#size-cells = <1>;
 	cell-index = <1>;
 	compatible = "fsl,fman";
-	ranges = <0 0x500000 0x100000>;
-	reg = <0x500000 0x100000>;
+	ranges = <0 0x500000 0xfe000>;
+	reg = <0x500000 0xfe000>;
 	interrupts = <97 2 0 0>, <16 2 1 0>;
 	clocks = <&clockgen 3 1>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x60 0xc>;
+	ptimer-handle = <&ptp_timer1>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -93,9 +94,10 @@ fman1: fman@500000 {
 		reg = <0x87000 0x1000>;
 		status = "disabled";
 	};
+};
 
-	ptp_timer1: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer1: ptp-timer@5fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x5fe000 0x1000>;
+	interrupts = <97 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
index 3a20e0d..d3720fd 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
@@ -37,12 +37,13 @@ fman0: fman@400000 {
 	#size-cells = <1>;
 	cell-index = <0>;
 	compatible = "fsl,fman";
-	ranges = <0 0x400000 0x100000>;
-	reg = <0x400000 0x100000>;
+	ranges = <0 0x400000 0xfe000>;
+	reg = <0x400000 0xfe000>;
 	interrupts = <96 2 0 0>, <16 2 1 1>;
 	clocks = <&clockgen 3 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x800 0x10>;
+	ptimer-handle = <&ptp_timer0>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -98,9 +99,10 @@ fman0: fman@400000 {
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
 	};
+};
 
-	ptp_timer0: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer0: ptp-timer@4fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x4fe000 0x1000>;
+	interrupts = <96 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
index 82750ac..ae34c20 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
@@ -37,12 +37,13 @@ fman1: fman@500000 {
 	#size-cells = <1>;
 	cell-index = <1>;
 	compatible = "fsl,fman";
-	ranges = <0 0x500000 0x100000>;
-	reg = <0x500000 0x100000>;
+	ranges = <0 0x500000 0xfe000>;
+	reg = <0x500000 0xfe000>;
 	interrupts = <97 2 0 0>, <16 2 1 0>;
 	clocks = <&clockgen 3 1>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x820 0x10>;
+	ptimer-handle = <&ptp_timer1>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -98,9 +99,10 @@ fman1: fman@500000 {
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
 	};
+};
 
-	ptp_timer1: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer1: ptp-timer@5fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x5fe000 0x1000>;
+	interrupts = <97 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
index 7f60b60..02f2755 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
@@ -37,12 +37,13 @@ fman0: fman@400000 {
 	#size-cells = <1>;
 	cell-index = <0>;
 	compatible = "fsl,fman";
-	ranges = <0 0x400000 0x100000>;
-	reg = <0x400000 0x100000>;
+	ranges = <0 0x400000 0xfe000>;
+	reg = <0x400000 0xfe000>;
 	interrupts = <96 2 0 0>, <16 2 1 1>;
 	clocks = <&clockgen 3 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x800 0x10>;
+	ptimer-handle = <&ptp_timer0>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -86,9 +87,10 @@ fman0: fman@400000 {
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
 	};
+};
 
-	ptp_timer0: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer0: ptp-timer@4fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x4fe000 0x1000>;
+	interrupts = <96 2 0 0>;
 };
-- 
1.7.1
