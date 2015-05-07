Return-Path: <yangbo.lu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0102.outbound.protection.outlook.com [157.56.110.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DF701A09CE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 13:47:12 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <scottwood@freescale.com>
Subject: [PATCH v2] powerpc/dts: Add and fix 1588 timer node for eTSEC
Date: Thu, 7 May 2015 11:29:07 +0800
Message-ID: <1430969347-13869-1-git-send-email-yangbo.lu@freescale.com>
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
Fix 1588 timer node in file:
arch/powerpc/boot/dts/p2020rdb-pc.dtsi

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v2:
	- Changed hex value to decimal value in dts
	- Modified commit message
	- Modified 1588 node in p2020rdb-pc.dtsi
---
 arch/powerpc/boot/dts/bsc9131rdb.dtsi  | 12 ++++++++++++
 arch/powerpc/boot/dts/bsc9132qds.dtsi  | 12 ++++++++++++
 arch/powerpc/boot/dts/p1010rdb.dtsi    | 12 ++++++++++++
 arch/powerpc/boot/dts/p1020rdb-pd.dts  | 12 ++++++++++++
 arch/powerpc/boot/dts/p1021rdb-pc.dtsi | 12 ++++++++++++
 arch/powerpc/boot/dts/p1022ds.dtsi     | 12 ++++++++++++
 arch/powerpc/boot/dts/p1025twr.dtsi    | 12 ++++++++++++
 arch/powerpc/boot/dts/p2020rdb-pc.dtsi | 12 ++++++------
 8 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/bsc9131rdb.dtsi b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
index 45efcba..a6d533e 100644
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
+		fsl,tmr-add	= <3435973837>;
+		fsl,tmr-fiper1	= <999999995>;
+		fsl,tmr-fiper2	= <99990>;
+		fsl,max-adj	= <249999999>;
+	};
+
 	enet0: ethernet@b0000 {
 		phy-handle = <&phy0>;
 		phy-connection-type = "rgmii-id";
diff --git a/arch/powerpc/boot/dts/bsc9132qds.dtsi b/arch/powerpc/boot/dts/bsc9132qds.dtsi
index af8e888..ef75804 100644
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
+		fsl,tmr-add	= <3435973837>;
+		fsl,tmr-fiper1	= <999999995>;
+		fsl,tmr-fiper2	= <99990>;
+		fsl,max-adj	= <249999999>;
+	};
+
 	enet0: ethernet@b0000 {
 		phy-handle = <&phy0>;
 		tbi-handle = <&tbi0>;
diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index ea534ef..1613678 100644
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
+		fsl,tmr-add	= <2147483670>;
+		fsl,tmr-fiper1	= <999999990>;
+		fsl,tmr-fiper2	= <99990>;
+		fsl,max-adj	= <199999999>;
+	};
+
 	enet0: ethernet@b0000 {
 		phy-handle = <&phy0>;
 		phy-connection-type = "rgmii-id";
diff --git a/arch/powerpc/boot/dts/p1020rdb-pd.dts b/arch/powerpc/boot/dts/p1020rdb-pd.dts
index 987017e..52e8fe8 100644
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
+			fsl,tmr-add	= <2147483670>;
+			fsl,tmr-fiper1	= <999999990>;
+			fsl,tmr-fiper2	= <99990>;
+			fsl,max-adj	= <199999999>;
+		};
+
 		enet0: ethernet@b0000 {
 			fixed-link = <1 1 1000 0 0>;
 			phy-connection-type = "rgmii-id";
diff --git a/arch/powerpc/boot/dts/p1021rdb-pc.dtsi b/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
index d6274c5..a29c84a 100644
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
+		fsl,tmr-add	= <2147483670>;
+		fsl,tmr-fiper1	= <999999990>;
+		fsl,tmr-fiper2	= <99990>;
+		fsl,max-adj	= <199999999>;
+	};
+
 	enet0: ethernet@b0000 {
 		fixed-link = <1 1 1000 0 0>;
 		phy-connection-type = "rgmii-id";
diff --git a/arch/powerpc/boot/dts/p1022ds.dtsi b/arch/powerpc/boot/dts/p1022ds.dtsi
index 957e0dc..50f915f 100644
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
+		fsl,tmr-add	= <3223239997>;
+		fsl,tmr-fiper1	= <999999995>;
+		fsl,tmr-fiper2	= <99990>;
+		fsl,max-adj	= <266499999>;
+	};
+
 	ethernet@b0000 {
 		phy-handle = <&phy0>;
 		phy-connection-type = "rgmii-id";
diff --git a/arch/powerpc/boot/dts/p1025twr.dtsi b/arch/powerpc/boot/dts/p1025twr.dtsi
index 8453501..52a6c7e 100644
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
+		fsl,tmr-add	= <3221225505>;
+		fsl,tmr-fiper1	= <999999990>;
+		fsl,tmr-fiper2	= <99990>;
+		fsl,max-adj	= <133333332>;
+	};
+
 	enet0: ethernet@b0000 {
 		phy-handle = <&phy0>;
 		phy-connection-type = "rgmii-id";
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
index c21d1c7..363172d 100644
--- a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
@@ -215,12 +215,12 @@
 	};
 
 	ptp_clock@24e00 {
-		fsl,tclk-period = <5>;
-		fsl,tmr-prsc = <200>;
-		fsl,tmr-add = <0xCCCCCCCD>;
-		fsl,tmr-fiper1 = <0x3B9AC9FB>;
-		fsl,tmr-fiper2 = <0x0001869B>;
-		fsl,max-adj = <249999999>;
+		fsl,tclk-period	= <5>;
+		fsl,tmr-prsc	= <2>;
+		fsl,tmr-add	= <2863311531>;
+		fsl,tmr-fiper1	= <999999995>;
+		fsl,tmr-fiper2	= <99990>;
+		fsl,max-adj	= <299999999>;
 	};
 
 	enet0: ethernet@24000 {
-- 
2.1.0.27.g96db324
