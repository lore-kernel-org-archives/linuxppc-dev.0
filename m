Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4460CDDFC9
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 07:39:46 +1100 (EST)
Date: Fri, 21 Dec 2007 23:41:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] [POWERPC] MPC8360E-RDK: add support for NAND on UPM
Message-ID: <20071221204143.GC4829@localhost.localdomain>
References: <20071221203552.GA4738@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071221203552.GA4738@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc836x_rdk.dts |   19 +++++++++++++++++--
 arch/powerpc/platforms/83xx/Kconfig   |    1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index 3f8d2b0..43420b1 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -126,7 +126,8 @@
 			reg = <0x700 0x100>;
 		};
 
-		par_io@1400 {
+		qe_pio: par_io@1400 {
+			#gpio-cells = <2>;
 			compatible = "fsl,qe-pario";
 			reg = <0x1400 0x100>;
 			num-ports = <7>;
@@ -292,7 +293,8 @@
 		compatible = "fsl,mpc8360-localbus",
 			     "fsl,pq2pro-localbus";
 		reg = <0xe0005000 0xd8>;
-		ranges = <0 0 0xff800000 0x800000>;
+		ranges = <0 0 0xff800000 0x800000
+			  1 0 0x60000000 0x001000>;
 
 		nor-flash@0,0 {
 			compatible = "intel,PC28F640P30T85", "cfi-flash";
@@ -300,6 +302,19 @@
 			bank-width = <2>;
 			device-width = <1>;
 		};
+
+		nand-flash@1,0 {
+			compatible = "stmicro,NAND512W3A2BN6E", "fsl,upm-nand";
+			reg = <1 0 1>;
+			width = <1>;
+			upm = "A";
+			upm-addr-offset = <16>;
+			upm-cmd-offset = <8>;
+			gpios = <4 18>;
+			gpio-parent = <&qe_pio>;
+			wait-pattern;
+			wait-write;
+		};
 	};
 
 	pci0: pci@e0008500 {
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 0d5a87c..723a8fe 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -88,6 +88,7 @@ config PPC_MPC836x
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
+	select FSL_UPM
 	default y if MPC836x_MDS || MPC836x_RDK
 
 config PPC_MPC837x
-- 
1.5.2.2
