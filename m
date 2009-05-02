Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id C35D4DE0D7
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 12:16:52 +1000 (EST)
Date: Sat, 2 May 2009 06:16:51 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/6] powerpc/85xx: Fix reg and interrupts for mpc8569emds'
	localbus, add NAND
Message-ID: <20090502021651.GC18281@oksana.dev.rtsoft.ru>
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

This patch fixes bogus reg = <> property in the localbus node,
and fixes interrupt property (should be "interrupts").

Also add node for NAND support.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8569mds.dts |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index bcf8042..ede515e 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -53,13 +53,14 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc8569-elbc", "fsl,elbc", "simple-bus";
-		reg = <0 0xe0005000 0 0x1000>;
-		interrupt = <19 2>;
+		reg = <0xe0005000 0x1000>;
+		interrupts = <19 2>;
 		interrupt-parent = <&mpic>;
 
 		ranges = <0x0 0x0 0xfe000000 0x02000000
 			  0x1 0x0 0xf8000000 0x00008000
 			  0x2 0x0 0xf0000000 0x04000000
+			  0x3 0x0 0xfc000000 0x00008000
 			  0x4 0x0 0xf8008000 0x00008000
 			  0x5 0x0 0xf8010000 0x00008000>;
 
@@ -77,6 +78,12 @@
 			reg = <1 0 0x8000>;
 		};
 
+		nand@3,0 {
+			compatible = "fsl,mpc8569-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <3 0 0x8000>;
+		};
+
 		pib@4,0 {
 			compatible = "fsl,mpc8569mds-pib";
 			reg = <4 0 0x8000>;
-- 
1.6.2.2
