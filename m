Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02425DE6AA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 05:43:01 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m52Jgvbk005392
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jun 2008 14:42:57 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] [POWERPC] 85xx: Add next-level-cache property
Date: Mon,  2 Jun 2008 14:42:55 -0500
Message-Id: <1212435775-11320-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1212435775-11320-1-git-send-email-galak@kernel.crashing.org>
References: <1212435775-11320-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added next-level-cache to the L1 and a reference to the new L2 label.
This is per the ePAPR 0.94 spec.  Since we are't really dependent on this
today we aren't supporting the "legacy" l2-cache phandle that is specified
in the PPC v2.1 OF Binding spec.

---

Updated the commit message to be more explicit about rationale.

(in my powerpc.git powerpc-next branch)

- k

 arch/powerpc/boot/dts/ksi8560.dts      |    3 ++-
 arch/powerpc/boot/dts/mpc8540ads.dts   |    3 ++-
 arch/powerpc/boot/dts/mpc8541cds.dts   |    3 ++-
 arch/powerpc/boot/dts/mpc8544ds.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc8548cds.dts   |    3 ++-
 arch/powerpc/boot/dts/mpc8555cds.dts   |    3 ++-
 arch/powerpc/boot/dts/mpc8560ads.dts   |    2 +-
 arch/powerpc/boot/dts/mpc8568mds.dts   |    3 ++-
 arch/powerpc/boot/dts/mpc8572ds.dts    |    4 +++-
 arch/powerpc/boot/dts/sbc8548.dts      |    3 ++-
 arch/powerpc/boot/dts/sbc8560.dts      |    3 ++-
 arch/powerpc/boot/dts/stx_gp3_8560.dts |    3 ++-
 arch/powerpc/boot/dts/tqm8540.dts      |    3 ++-
 arch/powerpc/boot/dts/tqm8541.dts      |    3 ++-
 arch/powerpc/boot/dts/tqm8555.dts      |    3 ++-
 arch/powerpc/boot/dts/tqm8560.dts      |    3 ++-
 16 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/boot/dts/ksi8560.dts b/arch/powerpc/boot/dts/ksi8560.dts
index f869ce3..6eb7c77 100644
--- a/arch/powerpc/boot/dts/ksi8560.dts
+++ b/arch/powerpc/boot/dts/ksi8560.dts
@@ -40,6 +40,7 @@
 			timebase-frequency = <0>;		/* From U-boot */
 			bus-frequency = <0>;			/* From U-boot */
 			clock-frequency = <0>;			/* From U-boot */
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -62,7 +63,7 @@
 			interrupts = <0x12 0x2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <0x20>;		/* 32 bytes */
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 58e165e..79881a1 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -40,6 +40,7 @@
 			timebase-frequency = <0>;	//  33 MHz, from uboot
 			bus-frequency = <0>;	// 166 MHz
 			clock-frequency = <0>;	// 825 MHz, from uboot
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -63,7 +64,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 21ebe7c..66192aa 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -40,6 +40,7 @@
 			timebase-frequency = <0>;	//  33 MHz, from uboot
 			bus-frequency = <0>;	// 166 MHz
 			clock-frequency = <0>;	// 825 MHz, from uboot
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -63,7 +64,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8541-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 921f9f6..6cf533f 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -41,6 +41,7 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -65,7 +66,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8544-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 213c88e..205598d 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -45,6 +45,7 @@
 			timebase-frequency = <0>;	//  33 MHz, from uboot
 			bus-frequency = <0>;	// 166 MHz
 			clock-frequency = <0>;	// 825 MHz, from uboot
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -68,7 +69,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8548-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 400f6db..7c9d0b1 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -40,6 +40,7 @@
 			timebase-frequency = <0>;	//  33 MHz, from uboot
 			bus-frequency = <0>;	// 166 MHz
 			clock-frequency = <0>;	// 825 MHz, from uboot
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -63,7 +64,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8555-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index f0b1f98..5d9f3c4 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -64,7 +64,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index d9064ee..d7af8db 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -42,6 +42,7 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -70,7 +71,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8568-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 3ca8cae..a444e6a 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -42,6 +42,7 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			next-level-cache = <&L2>;
 		};
 
 		PowerPC,8572@1 {
@@ -54,6 +55,7 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -84,7 +86,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,mpc8572-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index ce496fb..d252e38 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -44,6 +44,7 @@
 			timebase-frequency = <0>;	// From uboot
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -161,7 +162,7 @@
 			interrupts = <0x12 0x2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8548-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <0x20>;	// 32 bytes
diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
index 2663501..e556c5a 100644
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -43,6 +43,7 @@
 			timebase-frequency = <0>;	// From uboot
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -66,7 +67,7 @@
 			interrupts = <0x12 0x2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8560-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <0x20>;	// 32 bytes
diff --git a/arch/powerpc/boot/dts/stx_gp3_8560.dts b/arch/powerpc/boot/dts/stx_gp3_8560.dts
index 096277b..1e61283 100644
--- a/arch/powerpc/boot/dts/stx_gp3_8560.dts
+++ b/arch/powerpc/boot/dts/stx_gp3_8560.dts
@@ -38,6 +38,7 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -62,7 +63,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index 8ee4664..7b653a5 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -40,6 +40,7 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -64,7 +65,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index cadbebf..8fe73ef 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -39,6 +39,7 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -63,7 +64,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index 9d6dc04..0a53bb9 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -39,6 +39,7 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -63,7 +64,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index 358cbd7..a4ee596 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -40,6 +40,7 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -64,7 +65,7 @@
 			interrupts = <18 2>;
 		};
 
-		l2-cache-controller@20000 {
+		L2: l2-cache-controller@20000 {
 			compatible = "fsl,8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;
-- 
1.5.4.5
