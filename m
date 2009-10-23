Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D79FFB7BAB
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Oct 2009 18:14:11 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/44x: Enable 64bit (>= 4GB) memory size in Katmai dts
Date: Fri, 23 Oct 2009 09:14:03 +0200
Message-Id: <1256282043-8848-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Additionally to increasing #size-cells to in the root node, we also
need to explicitly define the ranges property in the plb node, because
of the different #size-cells between child and parent.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/katmai.dts |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index 077819b..b8cd97c 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -16,7 +16,7 @@
 
 / {
 	#address-cells = <2>;
-	#size-cells = <1>;
+	#size-cells = <2>;
 	model = "amcc,katmai";
 	compatible = "amcc,katmai";
 	dcr-parent = <&{/cpus/cpu@0}>;
@@ -49,7 +49,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by zImage */
+		reg = <0x0 0x00000000 0x0 0x00000000>; /* Filled in by U-Boot */
 	};
 
 	UIC0: interrupt-controller0 {
@@ -112,7 +112,15 @@
 		compatible = "ibm,plb-440spe", "ibm,plb-440gp", "ibm,plb4";
 		#address-cells = <2>;
 		#size-cells = <1>;
-		ranges;
+		/*        addr-child     addr-parent    size */
+		ranges = <0x4 0xe0000000 0x4 0xe0000000 0x20000000
+			  0xc 0x00000000 0xc 0x00000000 0x20000000
+			  0xd 0x00000000 0xd 0x00000000 0x80000000
+			  0xd 0x80000000 0xd 0x80000000 0x80000000
+			  0xe 0x00000000 0xe 0x00000000 0x80000000
+			  0xe 0x80000000 0xe 0x80000000 0x80000000
+			  0xf 0x00000000 0xf 0x00000000 0x80000000
+			  0xf 0x80000000 0xf 0x80000000 0x80000000>;
 		clock-frequency = <0>; /* Filled in by zImage */
 
 		SDRAM0: sdram {
-- 
1.6.5.1
