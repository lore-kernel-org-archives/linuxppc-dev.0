Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 3042DDDEE9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 03:47:25 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS files
Date: Tue, 13 Feb 2007 10:47:19 -0600
Message-Id: <11713852392294-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 'linux,boot-cpu' property and the 'chosen' node do not belong in the
DTS file, because U-Boot creates these entries in the device tree when
it boots linux.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/kuroboxHG.dts    |    1 -
 arch/powerpc/boot/dts/mpc7448hpc2.dts  |    5 ++---
 arch/powerpc/boot/dts/mpc8272ads.dts   |    8 --------
 arch/powerpc/boot/dts/mpc8323emds.dts  |    7 +++----
 arch/powerpc/boot/dts/mpc8360emds.dts  |    1 -
 arch/powerpc/boot/dts/mpc8560ads.dts   |    1 -
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |    3 +--
 arch/powerpc/boot/dts/mpc866ads.dts    |    1 -
 arch/powerpc/boot/dts/mpc885ads.dts    |    1 -
 9 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index d06b0b0..7531027 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -35,7 +35,6 @@ build with: "dtc -f -I dts -O dtb -o kur
 
 		PowerPC,603e { /* Really 8241 */
 			linux,phandle = <2100>;
-			linux,boot-cpu;
 			device_type = "cpu";
 			reg = <0>;
 			clock-frequency = <fdad680>;	/* Fixed by bootwrapper */
diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index c4d9562..4164351 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -23,7 +23,7 @@
 		#address-cells = <1>;
 		#size-cells =<0>;
 		linux,phandle = <200>;
-				
+
 		PowerPC,7448@0 {
 			device_type = "cpu";
 			reg = <0>;
@@ -36,7 +36,6 @@
 			bus-frequency = <0>;		// From U-Boot
 			32-bit;
 			linux,phandle = <201>;
-			linux,boot-cpu;
 		};
 	};
 
@@ -152,7 +151,7 @@
 			#address-cells = <3>;
 			reg = <1000 1000>;
 			bus-range = <0 0>;
-			ranges = <02000000 0 e0000000 e0000000 0 1A000000	
+			ranges = <02000000 0 e0000000 e0000000 0 1A000000
 				  01000000 0 00000000 fa000000 0 00010000>;
 			clock-frequency = <7f28154>;
 			interrupt-parent = <7400>;
diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 26b44f7..c9ffc12 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -34,7 +34,6 @@
                        clock-frequency = <0>;
                        32-bit;
                        linux,phandle = <201>;
-                       linux,boot-cpu;
                };
        };
 
@@ -53,13 +52,6 @@
                reg = <00000000 4000000 f4500000 00000020>;
        };
 
-       chosen {
-               name = "chosen";
-               linux,platform = <0>;
-               interrupt-controller = <10c00>;
-               linux,phandle = <400>;
-       };
-
        soc8272@f0000000 {
                #address-cells = <1>;
                #size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8323emds.dts b/arch/powerpc/boot/dts/mpc8323emds.dts
index fa7ef24..eaf0f86 100644
--- a/arch/powerpc/boot/dts/mpc8323emds.dts
+++ b/arch/powerpc/boot/dts/mpc8323emds.dts
@@ -34,7 +34,6 @@
 			clock-frequency = <0>;
 			32-bit;
 			linux,phandle = <201>;
-			linux,boot-cpu;
 		};
 	};
 
@@ -174,7 +173,7 @@
 			built-in;
 			device_type = "ipic";
 		};
-		
+
 		par_io@1400 {
 			reg = <1400 100>;
 			device_type = "par_io";
@@ -237,11 +236,11 @@
 		reg = <e0100000 480>;
 		brg-frequency = <0>;
 		bus-frequency = <BCD3D80>;
-		
+
 		muram@10000 {
 			device_type = "muram";
 			ranges = <0 00010000 00004000>;
-	
+
 			data-only@0 {
 				reg = <0 4000>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8360emds.dts b/arch/powerpc/boot/dts/mpc8360emds.dts
index 9022192..303bd66 100644
--- a/arch/powerpc/boot/dts/mpc8360emds.dts
+++ b/arch/powerpc/boot/dts/mpc8360emds.dts
@@ -39,7 +39,6 @@
 			clock-frequency = <1F78A400>;
 			32-bit;
 			linux,phandle = <201>;
-			linux,boot-cpu;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 119bd5d..c74d6eb 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -35,7 +35,6 @@
 			clock-frequency = <312c8040>;
 			32-bit;
 			linux,phandle = <201>;
-			linux,boot-cpu;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index f0c7731..258fccb 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -32,7 +32,6 @@
 			bus-frequency = <0>;		// From uboot
 			clock-frequency = <0>;		// From uboot
 			32-bit;
-			linux,boot-cpu;
 		};
 		PowerPC,8641@1 {
 			device_type = "cpu";
@@ -142,7 +141,7 @@
 			interrupt-parent = <40000>;
 			phy-handle = <2452001>;
 		};
-		
+
 		ethernet@26000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index 5d40052..2b56b5d 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -37,7 +37,6 @@
 			interrupts = <f 2>;	// decrementer interrupt
 			interrupt-parent = <ff000000>;
 			linux,phandle = <201>;
-			linux,boot-cpu;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index cf1a19f..faecd08 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -37,7 +37,6 @@
 			interrupts = <f 2>;	// decrementer interrupt
 			interrupt-parent = <ff000000>;
 			linux,phandle = <201>;
-			linux,boot-cpu;
 		};
 	};
 
-- 
1.4.4
