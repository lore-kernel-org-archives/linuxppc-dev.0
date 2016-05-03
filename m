Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qzgWw6qLvzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 22:31:21 +1000 (AEST)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [PATCH v1 1/1] powerpc/86xx: Fix PCI interrupt map definition
Date: Tue,  3 May 2016 14:31:18 +0200
Message-Id: <1462278678-17106-1-git-send-email-alessio.bogani@elettra.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix PCI interrupt map definition from 2 to 4 cells. Move
interrupt-map and interrupt-map-mask and clone interrupts
into the pcie child nodes.

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
This patch requires https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-April/141980.html
to be applied cleanly.

 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
index a76ffda..eeb7c65 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
@@ -102,14 +102,6 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <100000000>;
 	interrupts = <24 2 0 0>;
-	interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-
-	interrupt-map = <
-		0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
-		0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
-		0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
-		0x0000 0x0 0x0 0x4 &mpic 0x3 0x1
-		>;
 
 	pcie@0 {
 		reg = <0 0 0 0 0>;
@@ -117,6 +109,14 @@
 		#size-cells = <2>;
 		#address-cells = <3>;
 		device_type = "pci";
+		interrupts = <24 2 0 0>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1 0x0 0x0
+			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1 0x0 0x0
+			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1 0x0 0x0
+			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1 0x0 0x0
+			>;
 	};
 };
 
@@ -128,14 +128,6 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <100000000>;
 	interrupts = <25 2 0 0>;
-	interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-
-	interrupt-map = <
-		0x0000 0x0 0x0 0x1 &mpic 0x4 0x1
-		0x0000 0x0 0x0 0x2 &mpic 0x5 0x1
-		0x0000 0x0 0x0 0x3 &mpic 0x6 0x1
-		0x0000 0x0 0x0 0x4 &mpic 0x7 0x1
-		>;
 
 	pcie@0 {
 		reg = <0 0 0 0 0>;
@@ -143,5 +135,13 @@
 		#size-cells = <2>;
 		#address-cells = <3>;
 		device_type = "pci";
+		interrupts = <25 2 0 0>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			0x0000 0x0 0x0 0x1 &mpic 0x4 0x1 0x0 0x0
+			0x0000 0x0 0x0 0x2 &mpic 0x5 0x1 0x0 0x0
+			0x0000 0x0 0x0 0x3 &mpic 0x6 0x1 0x0 0x0
+			0x0000 0x0 0x0 0x4 &mpic 0x7 0x1 0x0 0x0
+			>;
 	};
 };
-- 
2.8.2
