Return-Path: <yangbo.lu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0116.outbound.protection.outlook.com [157.56.111.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B2E861A0276
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 19:44:41 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <scottwood@freescale.com>
Subject: [PATCH] powerpc/dts: Add 1588 timer node for eTSEC
Date: Wed, 6 May 2015 17:40:56 +0800
Message-ID: <1430905256-4930-1-git-send-email-yangbo.lu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Yangbo Lu <yangbo.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add 1588 timer node in files:
arch/powerpc/boot/dts/bsc9131rdb.dtsi
arch/powerpc/boot/dts/bsc9132qds.dtsi
arch/powerpc/boot/dts/p1010rdb.dtsi
arch/powerpc/boot/dts/p1020rdb-pd.dts
arch/powerpc/boot/dts/p1021rdb-pc.dtsi
arch/powerpc/boot/dts/p1022ds.dtsi
arch/powerpc/boot/dts/p1025twr.dtsi
arch/powerpc/boot/dts/p2020rdb-pc.dtsi

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 arch/powerpc/boot/dts/bsc9131rdb.dtsi  | 12 ++++++++++++
 arch/powerpc/boot/dts/bsc9132qds.dtsi  | 12 ++++++++++++
 arch/powerpc/boot/dts/p1010rdb.dtsi    | 12 ++++++++++++
 arch/powerpc/boot/dts/p1020rdb-pd.dts  | 12 ++++++++++++
 arch/powerpc/boot/dts/p1021rdb-pc.dtsi | 12 ++++++++++++
 arch/powerpc/boot/dts/p1022ds.dtsi     | 12 ++++++++++++
 arch/powerpc/boot/dts/p1025twr.dtsi    | 12 ++++++++++++
 arch/powerpc/boot/dts/p2020rdb-pc.dtsi | 15 +++++++++------
 8 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/bsc9131rdb.dtsi b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
index 45efcba..629cc03 100644
--- a/arch/powerpc/boot/dts/bsc9131rdb.dtsi
+++ b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
@@ -80,6 +80,18 @@
 		status = "disabled";
 	};
 
+	ptp_clock@b0e00 {
+		compatible = "fsl,etsec-ptp";
+		reg = <0xb0e00 0xb0>;
+		interrupts = <68 2 0 0 69 2 0 0>;
+		fsl,tclk-period	= <5>;
+		fsl,tmr-prsc	= <2>;
+		fsl,tmr-add	= <0xcccccccd>;
+		fsl,tmr-fiper1	= <0x3b9ac9fb>;
+		fsl,tmr-fiper2	= <0x00018696>;
+		fsl,max-adj	= <249999999>;
+	};
+
 	enet0: ethernet@b0000 {
 		phy-handle = <&phy0>;
 		phy-connection-type = "rgmii-id";
diff --git a/arch/powerpc/boot/dts/bsc9132qds.dtsi b/arch/powerpc/boot/dts/bsc9132qds.dtsi
index af8e888..9d8d466 100644
--- a/arch/powerpc/boot/dts/bsc9132qds.dtsi
+++ b/arch/powerpc/boot/dts/bsc9132qds.dtsi
@@ -87,6 +87,18 @@
 		};
 	};
 
+	ptp_clock@b0e00 {
+		compatible = "fsl,etsec-ptp";
+		reg = <0xb0e00 0xb0>;
+		interrupts = <68 2 0 0 69 2 0 0>;
+		fsl,tclk-period	= <5>;
+		fsl,tmr-prsc	= <2>;
+		fsl,tmr-add	= <0xcccccccd>;
+		fsl,tmr-fiper1	= <0x3b9ac9fb>;
+		fsl,tmr-fiper2	= <0x00018696>;
+		fsl,max-adj	= <249999999>;
+	};
+
 	enet0: ethernet@b0000 {
 		phy-handle = <&phy0>;
 		tbi-handle = <&tbi0>;
diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index ea534ef..a454cfe 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -186,6 +186,18 @@
 		};
 	};
 
+	ptp_clock@b0e00 {
+		compatible = "fsl,etsec-ptp";
+		reg = <0xb0e00 0xb0>;
+		interrupts = <68 2 0 0 69 2 0 0>;
+		fsl,tclk-period	= <10>;
+		fsl,tmr-prsc	= <2>;
+		fsl,tmr-add	= <0x80000016>;
+		fsl,tmr-fiper1	= <0x3b9ac9f6>;
+		fsl,tmr-fiper2	= <0x00018696>;
+		fsl,max-adj	= <199999999>;
+	};
+
 	enet0: ethernet@b0000 {
 		phy-handle = <&phy0>;
 		phy-connection-type = "rgmii-id";
diff --git a/arch/powerpc/boot/dts/p1020rdb-pd.dts b/arch/powerpc/boot/dts/p1020rdb-pd.dts
index 987017e..2d45195 100644
--- a/arch/powerpc/boot/dts/p1020rdb-pd.dts
+++ b/arch/powerpc/boot/dts/p1020rdb-pd.dts
@@ -225,6 +225,18 @@
 			};
 		};
 
+		ptp_clock@b0e00 {
+			compatible = "fsl,etsec-ptp";
+			reg = <0xb0e00 0xb0>;
+			interrupts = <68 2 0 0 69 2 0 0>;
+			fsl,tclk-period	= <10>;
+			fsl,tmr-prsc	= <2>;
+			fsl,tmr-add	= <0x80000016>;
+			fsl,tmr-fiper1	= <0x3b9ac9f6>;
+			fsl,tmr-fiper2	= <0x00018696>;
+			fsl,max-adj	= <199999999>;
+		};
+
 		enet0: ethernet@b0000 {
 			fixed-link = <1 1 1000 0 0>;
 			phy-connection-type = "rgmii-id";
diff --git a/arch/powerpc/boot/dts/p1021rdb-pc.dtsi b/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
index d6274c5..3a2c12c 100644
--- a/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
@@ -224,6 +224,18 @@
 		};
 	};
 
+	ptp_clock@b0e00 {
+		compatible = "fsl,etsec-ptp";
+		reg = <0xb0e00 0xb0>;
+		interrupts = <68 2 0 0 69 2 0 0>;
+		fsl,tclk-period	= <10>;
+		fsl,tmr-prsc	= <2>;
+		fsl,tmr-add	= <0x80000016>;
+		fsl,tmr-fiper1	= <0x3b9ac9f6>;
+		fsl,tmr-fiper2	= <0x00018696>;
+		fsl,max-adj	= <199999999>;
+	};
+
 	enet0: ethernet@b0000 {
 		fixed-link = <1 1 1000 0 0>;
 		phy-connection-type = "rgmii-id";
diff --git a/arch/powerpc/boot/dts/p1022ds.dtsi b/arch/powerpc/boot/dts/p1022ds.dtsi
index 957e0dc..75cdac2 100644
--- a/arch/powerpc/boot/dts/p1022ds.dtsi
+++ b/arch/powerpc/boot/dts/p1022ds.dtsi
@@ -215,6 +215,18 @@
 		};
 	};
 
+	ptp_clock@b0e00 {
+		compatible = "fsl,etsec-ptp";
+		reg = <0xb0e00 0xb0>;
+		interrupts = <68 2 0 0 69 2 0 0>;
+		fsl,tclk-period	= <5>;
+		fsl,tmr-prsc	= <2>;
+		fsl,tmr-add	= <0xc01ebd3d>;
+		fsl,tmr-fiper1	= <0x3b9ac9fb>;
+		fsl,tmr-fiper2	= <0x00018696>;
+		fsl,max-adj	= <266499999>;
+	};
+
 	ethernet@b0000 {
 		phy-handle = <&phy0>;
 		phy-connection-type = "rgmii-id";
diff --git a/arch/powerpc/boot/dts/p1025twr.dtsi b/arch/powerpc/boot/dts/p1025twr.dtsi
index 8453501..860b133 100644
--- a/arch/powerpc/boot/dts/p1025twr.dtsi
+++ b/arch/powerpc/boot/dts/p1025twr.dtsi
@@ -138,6 +138,18 @@
 		};
 	};
 
+	ptp_clock@b0e00 {
+		compatible = "fsl,etsec-ptp";
+		reg = <0xb0e00 0xb0>;
+		interrupts = <68 2 0 0 69 2 0 0>;
+		fsl,tclk-period	= <10>;
+		fsl,tmr-prsc	= <2>;
+		fsl,tmr-add	= <0xc0000021>;
+		fsl,tmr-fiper1	= <0x3b9ac9f6>;
+		fsl,tmr-fiper2	= <0x00018696>;
+		fsl,max-adj	= <133333332>;
+	};
+
 	enet0: ethernet@b0000 {
 		phy-handle = <&phy0>;
 		phy-connection-type = "rgmii-id";
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
index c21d1c7..434e21b 100644
--- a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
@@ -215,12 +215,15 @@
 	};
 
 	ptp_clock@24e00 {
-		fsl,tclk-period = <5>;
-		fsl,tmr-prsc = <200>;
-		fsl,tmr-add = <0xCCCCCCCD>;
-		fsl,tmr-fiper1 = <0x3B9AC9FB>;
-		fsl,tmr-fiper2 = <0x0001869B>;
-		fsl,max-adj = <249999999>;
+		compatible = "fsl,etsec-ptp";
+		reg = <0x24e00 0xb0>;
+		interrupts = <68 2 0 0 69 2 0 0>;
+		fsl,tclk-period	= <5>;
+		fsl,tmr-prsc	= <2>;
+		fsl,tmr-add	= <0xaaaaaaab>;
+		fsl,tmr-fiper1	= <0x3b9ac9fb>;
+		fsl,tmr-fiper2	= <0x00018696>;
+		fsl,max-adj	= <299999999>;
 	};
 
 	enet0: ethernet@24000 {
-- 
2.1.0.27.g96db324
