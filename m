Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6E0D7DE564
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 07:46:34 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id AE8CC8818
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 01:46:32 +0400 (SAMT)
Date: Mon, 10 Dec 2007 23:49:51 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC 7/7] [POWERPC] MPC8360E-RDK: add support for NAND on UPM
Message-ID: <20071210204951.GG32278@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071210204705.GA31263@localhost.localdomain>
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
 arch/powerpc/boot/dts/mpc836x_rdk.dts     |   24 +++++++++++++++++++++++-
 arch/powerpc/platforms/83xx/Kconfig       |    2 ++
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |    1 +
 3 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index a1b2da6..f57ba53 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -115,7 +115,7 @@
 			device_type = "ipic";
 		};
 
-		par_io@1400 {
+		qe_pio: par_io@1400 {
 			reg = <0x1400 0x100>;
 			num-ports = <7>;
 		};
@@ -229,4 +229,26 @@
 			interrupt-parent = <&ipic>;
 		};
 	};
+
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8360erdk-localbus",
+			     "fsl,mpc8360e-localbus",
+			     "fsl,pq2pro-localbus";
+		reg = <0xe0005000 0xd8>;
+		ranges = <1 0 0x60000000 1>;
+
+		nand-flash@1,0 {
+			compatible = "STMicro,NAND512W3A2BN6E", "fsl,upm-nand";
+			reg = <1 0 1>;
+			upm = "A";
+			upm-addr-offset = <16>;
+			upm-cmd-offset = <8>;
+			gpios = <4 18>;
+			gpio-parent = <&qe_pio>;
+			wait-pattern;
+			wait-write;
+		};
+	};
 };
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 98f6358..2fc60c1 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -54,6 +54,7 @@ config MPC836x_RDK
 	bool "Freescale/Logic MPC836x RDK"
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
+	select FSL_UPM_LOCKLESS
 	help
 	  This option enables support for the MPC836x RDK Processor Board,
 	  also known as ZOOM PowerQUICC Kit.
@@ -82,4 +83,5 @@ config PPC_MPC836x
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
+	select FSL_UPM
 	default y if MPC836x_MDS || MPC836x_RDK
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index be9e2fd..4288e16 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -27,6 +27,7 @@ static struct of_device_id mpc836x_rdk_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .compatible = "fsl,pq2pro-localbus", },
 	{},
 };
 
-- 
1.5.2.2
