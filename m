Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id AF7A9DDEEE
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 02:59:34 +1000 (EST)
Date: Thu, 10 May 2007 10:03:05 -0700
From: Dave Jiang <djiang@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: add dts entries to 85xx for EDAC
Message-ID: <20070510170305.GA16203@blade.az.mvista.com>
References: <20070426000852.GA2193@localhost.localdomain>
	<20070426003748.GA30730@blade.az.mvista.com>
	<9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
	<20070501183220.GA6426@blade.az.mvista.com>
	<20070507232634.GA11166@blade.az.mvista.com>
	<3EF891D2-F973-43D6-B43B-B8BBC4269C60@kernel.crashing.org>
	<4640AE88.9040806@mvista.com>
	<6fb05a0954f19c5744369c18670d81ff@kernel.crashing.org>
	<20070509165333.GA3118@blade.az.mvista.com>
	<3E2DA6EA-8952-47B3-A395-C416D7AC9D62@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3E2DA6EA-8952-47B3-A395-C416D7AC9D62@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adding memory-controller and l2-cache-controller entries to be used by EDAC 
as of_devices.

Signed-off-by: Dave Jiang <djiang@mvista.com>

---

Fixed up additional changes per Kumar.

 arch/powerpc/boot/dts/mpc8540ads.dts |   16 ++++++++++++++++
 arch/powerpc/boot/dts/mpc8548cds.dts |   16 ++++++++++++++++
 arch/powerpc/boot/dts/mpc8560ads.dts |   18 +++++++++++++++++-
 3 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index f261d64..d91e81c 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -48,6 +48,22 @@
 		reg = <e0000000 00100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
+		memory-controller@2000 {
+			compatible = "fsl,8540-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8540-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		i2c@3000 {
 			device_type = "i2c";
 			compatible = "fsl-i2c";
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index b2b2200..ad96381 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -48,6 +48,22 @@
 		reg = <e0000000 00100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
+		memory-controller@2000 {
+			compatible = "fsl,8548-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8548-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <80000>;	// L2, 512K
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		i2c@3000 {
 			device_type = "i2c";
 			compatible = "fsl-i2c";
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 1f2afe9..8068215 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -48,6 +48,22 @@
 		reg = <e0000000 00000200>;
 		bus-frequency = <13ab6680>;
 
+		memory-controller@2000 {
+			compatible = "fsl,8540-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8540-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		mdio@24520 {
 			device_type = "mdio";
 			compatible = "gianfar";
@@ -110,7 +126,7 @@
 			#address-cells = <3>;
 			compatible = "85xx";
 			device_type = "pci";
-			reg = <8000 400>;
+			reg = <8000 1000>;
 			clock-frequency = <3f940aa>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
