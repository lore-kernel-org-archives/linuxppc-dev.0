Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A633ADDEF3
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 06:04:54 +1100 (EST)
Date: Thu, 5 Feb 2009 22:04:51 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/83xx: Convert existing sdhc nodes to new bindings
Message-ID: <20090205190451.GB3348@oksana.dev.rtsoft.ru>
References: <20090205190403.GA27976@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090205190403.GA27976@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

- sdhc node renamed to sdhci ("sdhc" name is confusing since SDHC is
  used to name Secure Digital High Capacity cards, while SDHCI is an
  interface).

- Get rid of "fsl,esdhc" compatible entry, it's replaced by the
  "fsl,<chip>-esdhc" scheme;

- Get rid of `model' property.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8377_mds.dts |    7 ++++---
 arch/powerpc/boot/dts/mpc8378_mds.dts |    7 ++++---
 arch/powerpc/boot/dts/mpc8379_mds.dts |    7 ++++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index a519e85..3e3ec8f 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -313,12 +313,13 @@
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
-		sdhc@2e000 {
-			model = "eSDHC";
-			compatible = "fsl,esdhc";
+		sdhci@2e000 {
+			compatible = "fsl,mpc8377-esdhc", "fsl,mpc8379-esdhc";
 			reg = <0x2e000 0x1000>;
 			interrupts = <42 0x8>;
 			interrupt-parent = <&ipic>;
+			/* Filled in by U-Boot */
+			clock-frequency = <0>;
 		};
 
 		sata@18000 {
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 6bbee49..c3b212c 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -313,12 +313,13 @@
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
-		sdhc@2e000 {
-			model = "eSDHC";
-			compatible = "fsl,esdhc";
+		sdhci@2e000 {
+			compatible = "fsl,mpc8378-esdhc", "fsl,mpc8379-esdhc";
 			reg = <0x2e000 0x1000>;
 			interrupts = <42 0x8>;
 			interrupt-parent = <&ipic>;
+			/* Filled in by U-Boot */
+			clock-frequency = <0>;
 		};
 
 		/* IPIC
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index acf06c4..1b61cda 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -310,12 +310,13 @@
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
-		sdhc@2e000 {
-			model = "eSDHC";
-			compatible = "fsl,esdhc";
+		sdhci@2e000 {
+			compatible = "fsl,mpc8379-esdhc";
 			reg = <0x2e000 0x1000>;
 			interrupts = <42 0x8>;
 			interrupt-parent = <&ipic>;
+			/* Filled in by U-Boot */
+			clock-frequency = <0>;
 		};
 
 		sata@18000 {
-- 
1.5.6.5
