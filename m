Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8293ADDE08
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 06:05:01 +1100 (EST)
Date: Thu, 5 Feb 2009 22:04:59 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/83xx: Add FSL eSDHC support for MPC837x-RDB boards
Message-ID: <20090205190459.GC3348@oksana.dev.rtsoft.ru>
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

Simply add appropriate sdhci nodes.

Note that U-Boot should configure pin multiplexing for eSDHC prior
to Linux could use it. U-Boot should also fill-in the clock-frequency
property (eSDHC clock depends on board-specific SCCR[ESDHCCM] bits).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8377_rdb.dts |    9 +++++++++
 arch/powerpc/boot/dts/mpc8378_rdb.dts |    9 +++++++++
 arch/powerpc/boot/dts/mpc8379_rdb.dts |    9 +++++++++
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index b4ab3d0..6f4d614 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -291,6 +291,15 @@
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
+		sdhci@2e000 {
+			compatible = "fsl,mpc8377-esdhc", "fsl,mpc8379-esdhc";
+			reg = <0x2e000 0x1000>;
+			interrupts = <42 0x8>;
+			interrupt-parent = <&ipic>;
+			/* Filled in by U-Boot */
+			clock-frequency = <0>;
+		};
+
 		sata@18000 {
 			compatible = "fsl,mpc8377-sata", "fsl,pq-sata";
 			reg = <0x18000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 1b05fb0..6457ef1 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -289,6 +289,15 @@
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
+		sdhci@2e000 {
+			compatible = "fsl,mpc8378-esdhc", "fsl,mpc8379-esdhc";
+			reg = <0x2e000 0x1000>;
+			interrupts = <42 0x8>;
+			interrupt-parent = <&ipic>;
+			/* Filled in by U-Boot */
+			clock-frequency = <0>;
+		};
+
 		/* IPIC
 		 * interrupts cell = <intr #, sense>
 		 * sense values match linux IORESOURCE_IRQ_* defines:
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 72cdc3c..203fff2 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -288,6 +288,15 @@
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
+		sdhci@2e000 {
+			compatible = "fsl,mpc8379-esdhc";
+			reg = <0x2e000 0x1000>;
+			interrupts = <42 0x8>;
+			interrupt-parent = <&ipic>;
+			/* Filled in by U-Boot */
+			clock-frequency = <0>;
+		};
+
 		sata@18000 {
 			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
 			reg = <0x18000 0x1000>;
-- 
1.5.6.5
