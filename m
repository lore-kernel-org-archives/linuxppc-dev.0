Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id ABB67DE206
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 12:16:55 +1000 (EST)
Date: Sat, 2 May 2009 06:16:53 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/6] powerpc/85xx: Add eSDHC support for MPC8569E-MDS boards
Message-ID: <20090502021653.GD18281@oksana.dev.rtsoft.ru>
References: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Note that eSDHC and DUART0 are mutually exclusive on MPC8569E-MDS
boards. Default option is DUART0, so eSDHC is disabled by default.
U-Boot will fixup device tree if eSDHC should be used instead of
DUART0.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8569mds.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index ede515e..14120d7 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -221,6 +221,16 @@
 			};
 		};
 
+		sdhci@2e000 {
+			compatible = "fsl,mpc8569-esdhc", "fsl,mpc8536-esdhc";
+			reg = <0x2e000 0x1000>;
+			interrupts = <72 0x8>;
+			interrupt-parent = <&mpic>;
+			/* Filled in by U-Boot */
+			clock-frequency = <0>;
+			status = "disabled";
+		};
+
 		crypto@30000 {
 			compatible = "fsl,sec3.1", "fsl,sec3.0", "fsl,sec2.4",
 				"fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
-- 
1.6.2.2
