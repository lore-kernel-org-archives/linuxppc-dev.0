Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 075AADE048
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 06:15:03 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc7448: add alias list to DTS, clean out old chosen node
Date: Thu, 10 Jul 2008 16:21:35 -0400
Message-Id: <1215721295-17555-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mpc7448hpc2 board doesn't have an alias block like
most of the other modern eval boards have.  We need this
block in order to have u-boot be able to make use of the
CONFIG_OF_STDOUT_VIA_ALIAS (vs. having a hard coded node)
in the future.

Also remove the old, redundant chosen node.  Of all the modern
Freescale eval boards (incl. 83xx, 85xx, 86xx) this is the only
one which still has it.  Its presence also breaks with some older
versions of u-boot, like 1.3.1 -- which try and insert a
second chosen node.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc7448hpc2.dts |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index 705c23c..2544f3e 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -18,6 +18,16 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+
+		serial0 = &serial0;
+		serial1 = &serial1;
+
+		pci0 = &pci0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells =<0>;
@@ -78,7 +88,7 @@
 
 		};
 
-		ethernet@6200 {
+		enet0: ethernet@6200 {
 			linux,network-index = <0>;
 			#size-cells = <0>;
 			device_type = "network";
@@ -91,7 +101,7 @@
 			phy-handle = <&phy8>;
 		};
 
-		ethernet@6600 {
+		enet1: ethernet@6600 {
 			linux,network-index = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -105,7 +115,7 @@
 			phy-handle = <&phy9>;
 		};
 
-		serial@7808 {
+		serial0: serial@7808 {
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <0x7808 0x200>;
@@ -114,7 +124,7 @@
 			interrupt-parent = <&mpic>;
 		};
 
-		serial@7c08 {
+		serial1: serial@7c08 {
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <0x7c08 0x200>;
@@ -131,7 +141,7 @@
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
 		};
-		pci@1000 {
+		pci0: pci@1000 {
 			compatible = "tsi108-pci";
 			device_type = "pci";
 			#interrupt-cells = <1>;
@@ -184,8 +194,4 @@
 			};
 		};
 	};
-	chosen {
-		linux,stdout-path = "/tsi108@c0000000/serial@7808";
-	};
-
 };
-- 
1.5.6.2
