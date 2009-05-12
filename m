Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B37D6DDF86
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 08:07:37 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n4CM7WM5018058
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 17:07:33 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/8xxx: Update PCI outbound window addresses for 36-bit
	configs
Date: Tue, 12 May 2009 17:07:32 -0500
Message-Id: <1242166052-1809-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In these configuration we expect to have large amounts of memory (> 4G)
and thus will bounce via swiotlb some region of PCI address space.

The outbound windows were wasting 512M of address space by leaving a
gap between the top of the outbound window and the 4G boundary.  By
moving the top of the outbound window up to the 4G boundary we can
reclaim the vast majority of the 512M (minus space needed for PEXCSRBAR)
and thus reduces the amount of memory we have to bounce.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8572ds_36b.dts    |   22 +++++++++++-----------
 arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts |   16 ++++++++--------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds_36b.dts b/arch/powerpc/boot/dts/mpc8572ds_36b.dts
index 1197965..f6365db 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_36b.dts
@@ -533,7 +533,7 @@
 		#address-cells = <3>;
 		reg = <0xf 0xffe08000 0 0x1000>;
 		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc 0x00000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
@@ -660,8 +660,8 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
 				  0x0 0x20000000
 
 				  0x1000000 0x0 0x0
@@ -671,8 +671,8 @@
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				#size-cells = <2>;
 				#address-cells = <3>;
-				ranges = <0x2000000 0x0 0xc0000000
-					  0x2000000 0x0 0xc0000000
+				ranges = <0x2000000 0x0 0xe0000000
+					  0x2000000 0x0 0xe0000000
 					  0x0 0x20000000
 
 					  0x1000000 0x0 0x0
@@ -742,7 +742,7 @@
 		#address-cells = <3>;
 		reg = <0xf 0xffe09000 0 0x1000>;
 		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
@@ -760,8 +760,8 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
 				  0x0 0x20000000
 
 				  0x1000000 0x0 0x0
@@ -778,7 +778,7 @@
 		#address-cells = <3>;
 		reg = <0xf 0xffe0a000 0 0x1000>;
 		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc 0x40000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x40000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc20000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
@@ -796,8 +796,8 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
 				  0x0 0x20000000
 
 				  0x1000000 0x0 0x0
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
index 65893b9..8be8e70 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
@@ -370,7 +370,7 @@
 		#address-cells = <3>;
 		reg = <0x0f 0xffe08000 0x0 0x1000>;
 		bus-range = <0x0 0xff>;
-		ranges = <0x02000000 0x0 0xc0000000 0x0c 0x00000000 0x0 0x20000000
+		ranges = <0x02000000 0x0 0xe0000000 0x0c 0x00000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0x0f 0xffc00000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
@@ -496,8 +496,8 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			ranges = <0x02000000 0x0 0xc0000000
-				  0x02000000 0x0 0xc0000000
+			ranges = <0x02000000 0x0 0xe0000000
+				  0x02000000 0x0 0xe0000000
 				  0x0 0x20000000
 
 				  0x01000000 0x0 0x00000000
@@ -507,8 +507,8 @@
 				reg = <0 0 0 0 0>;
 				#size-cells = <2>;
 				#address-cells = <3>;
-				ranges = <0x02000000 0x0 0xc0000000
-					  0x02000000 0x0 0xc0000000
+				ranges = <0x02000000 0x0 0xe0000000
+					  0x02000000 0x0 0xe0000000
 					  0x0 0x20000000
 					  0x01000000 0x0 0x00000000
 					  0x01000000 0x0 0x00000000
@@ -579,7 +579,7 @@
 		#address-cells = <3>;
 		reg = <0x0f 0xffe09000 0x0 0x1000>;
 		bus-range = <0x0 0xff>;
-		ranges = <0x02000000 0x0 0xc0000000 0x0c 0x20000000 0x0 0x20000000
+		ranges = <0x02000000 0x0 0xe0000000 0x0c 0x20000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0x0f 0xffc10000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
@@ -597,8 +597,8 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			ranges = <0x02000000 0x0 0xc0000000
-				  0x02000000 0x0 0xc0000000
+			ranges = <0x02000000 0x0 0xe0000000
+				  0x02000000 0x0 0xe0000000
 				  0x0 0x20000000
 
 				  0x01000000 0x0 0x00000000
-- 
1.6.0.6
