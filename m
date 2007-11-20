Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35E32DDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 16:52:05 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lAK5q0f1017344
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 23:52:01 -0600
Date: Mon, 19 Nov 2007 23:50:44 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fix device tree interrupt map for Freescale ULI1575
	boards
Message-ID: <Pine.LNX.4.64.0711192349390.1217@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The interrupt map for the PCI PHB that had the ULI1575 was not correct
on the boards that have it.

* 8544 DS:
   - Fix interrupt mask
   - Be explicit about use of INTA for on chip peripherals

* 8572 DS/8641 HPCN:
   - Fix interrupt mask
   - Expand interrupt map for PCI slots to cover all functions
   - Be explicit about use of INTA for on chip peripherals

---

intended for 2.6.24 as a bug fix.  Its ugly but I don't think we have a
choice, silly HW.

 arch/powerpc/boot/dts/mpc8544ds.dts    |   20 +++---
 arch/powerpc/boot/dts/mpc8572ds.dts    |  108 ++++++++++++++++++++++++---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |  126 ++++++++++++++++++++++++++-----
 3 files changed, 211 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 3f9d15c..6c608de 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -272,24 +272,24 @@
 		clock-frequency = <1fca055>;
 		interrupt-parent = <&mpic>;
 		interrupts = <1b 2>;
-		interrupt-map-mask = <fb00 0 0 0>;
+		interrupt-map-mask = <ff00 0 0 1>;
 		interrupt-map = <
 			// IDSEL 0x1c  USB
-			e000 0 0 0 &i8259 c 2
-			e100 0 0 0 &i8259 9 2
-			e200 0 0 0 &i8259 a 2
-			e300 0 0 0 &i8259 b 2
+			e000 0 0 1 &i8259 c 2
+			e100 0 0 1 &i8259 9 2
+			e200 0 0 1 &i8259 a 2
+			e300 0 0 1 &i8259 b 2

 			// IDSEL 0x1d  Audio
-			e800 0 0 0 &i8259 6 2
+			e800 0 0 1 &i8259 6 2

 			// IDSEL 0x1e Legacy
-			f000 0 0 0 &i8259 7 2
-			f100 0 0 0 &i8259 7 2
+			f000 0 0 1 &i8259 7 2
+			f100 0 0 1 &i8259 7 2

 			// IDSEL 0x1f IDE/SATA
-			f800 0 0 0 &i8259 e 2
-			f900 0 0 0 &i8259 5 2
+			f800 0 0 1 &i8259 e 2
+			f900 0 0 1 &i8259 5 2
 		>;

 		pcie@0 {
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index d638dee..0eb44fb 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -219,36 +219,120 @@
 		clock-frequency = <1fca055>;
 		interrupt-parent = <&mpic>;
 		interrupts = <18 2>;
-		interrupt-map-mask = <fb00 0 0 0>;
+		interrupt-map-mask = <ff00 0 0 7>;
 		interrupt-map = <
-			/* IDSEL 0x11 - PCI slot 1 */
+			/* IDSEL 0x11 func 0 - PCI slot 1 */
 			8800 0 0 1 &mpic 2 1
 			8800 0 0 2 &mpic 3 1
 			8800 0 0 3 &mpic 4 1
 			8800 0 0 4 &mpic 1 1

-			/* IDSEL 0x12 - PCI slot 2 */
+			/* IDSEL 0x11 func 1 - PCI slot 1 */
+			8900 0 0 1 &mpic 2 1
+			8900 0 0 2 &mpic 3 1
+			8900 0 0 3 &mpic 4 1
+			8900 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 2 - PCI slot 1 */
+			8a00 0 0 1 &mpic 2 1
+			8a00 0 0 2 &mpic 3 1
+			8a00 0 0 3 &mpic 4 1
+			8a00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 3 - PCI slot 1 */
+			8b00 0 0 1 &mpic 2 1
+			8b00 0 0 2 &mpic 3 1
+			8b00 0 0 3 &mpic 4 1
+			8b00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 4 - PCI slot 1 */
+			8c00 0 0 1 &mpic 2 1
+			8c00 0 0 2 &mpic 3 1
+			8c00 0 0 3 &mpic 4 1
+			8c00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 5 - PCI slot 1 */
+			8d00 0 0 1 &mpic 2 1
+			8d00 0 0 2 &mpic 3 1
+			8d00 0 0 3 &mpic 4 1
+			8d00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 6 - PCI slot 1 */
+			8e00 0 0 1 &mpic 2 1
+			8e00 0 0 2 &mpic 3 1
+			8e00 0 0 3 &mpic 4 1
+			8e00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 7 - PCI slot 1 */
+			8f00 0 0 1 &mpic 2 1
+			8f00 0 0 2 &mpic 3 1
+			8f00 0 0 3 &mpic 4 1
+			8f00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x12 func 0 - PCI slot 2 */
 			9000 0 0 1 &mpic 3 1
 			9000 0 0 2 &mpic 4 1
 			9000 0 0 3 &mpic 1 1
 			9000 0 0 4 &mpic 2 1

+			/* IDSEL 0x12 func 1 - PCI slot 2 */
+			9100 0 0 1 &mpic 3 1
+			9100 0 0 2 &mpic 4 1
+			9100 0 0 3 &mpic 1 1
+			9100 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 2 - PCI slot 2 */
+			9200 0 0 1 &mpic 3 1
+			9200 0 0 2 &mpic 4 1
+			9200 0 0 3 &mpic 1 1
+			9200 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 3 - PCI slot 2 */
+			9300 0 0 1 &mpic 3 1
+			9300 0 0 2 &mpic 4 1
+			9300 0 0 3 &mpic 1 1
+			9300 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 4 - PCI slot 2 */
+			9400 0 0 1 &mpic 3 1
+			9400 0 0 2 &mpic 4 1
+			9400 0 0 3 &mpic 1 1
+			9400 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 5 - PCI slot 2 */
+			9500 0 0 1 &mpic 3 1
+			9500 0 0 2 &mpic 4 1
+			9500 0 0 3 &mpic 1 1
+			9500 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 6 - PCI slot 2 */
+			9600 0 0 1 &mpic 3 1
+			9600 0 0 2 &mpic 4 1
+			9600 0 0 3 &mpic 1 1
+			9600 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 7 - PCI slot 2 */
+			9700 0 0 1 &mpic 3 1
+			9700 0 0 2 &mpic 4 1
+			9700 0 0 3 &mpic 1 1
+			9700 0 0 4 &mpic 2 1
+
 			// IDSEL 0x1c  USB
-			e000 0 0 0 &i8259 c 2
-			e100 0 0 0 &i8259 9 2
-			e200 0 0 0 &i8259 a 2
-			e300 0 0 0 &i8259 b 2
+			e000 0 0 1 &i8259 c 2
+			e100 0 0 1 &i8259 9 2
+			e200 0 0 1 &i8259 a 2
+			e300 0 0 1 &i8259 b 2

 			// IDSEL 0x1d  Audio
-			e800 0 0 0 &i8259 6 2
+			e800 0 0 1 &i8259 6 2

 			// IDSEL 0x1e Legacy
-			f000 0 0 0 &i8259 7 2
-			f100 0 0 0 &i8259 7 2
+			f000 0 0 1 &i8259 7 2
+			f100 0 0 1 &i8259 7 2

 			// IDSEL 0x1f IDE/SATA
-			f800 0 0 0 &i8259 e 2
-			f900 0 0 0 &i8259 5 2
+			f800 0 0 1 &i8259 e 2
+			f900 0 0 1 &i8259 5 2

 			>;

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 3677659..abb26dc 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -235,36 +235,120 @@
 		clock-frequency = <1fca055>;
 		interrupt-parent = <&mpic>;
 		interrupts = <18 2>;
-		interrupt-map-mask = <fb00 0 0 0>;
+		interrupt-map-mask = <ff00 0 0 7>;
 		interrupt-map = <
-			/* IDSEL 0x11 */
-			8800 0 0 1 &i8259 9 2
-			8800 0 0 2 &i8259 a 2
-			8800 0 0 3 &i8259 b 2
-			8800 0 0 4 &i8259 c 2
-
-			/* IDSEL 0x12 */
-			9000 0 0 1 &i8259 a 2
-			9000 0 0 2 &i8259 b 2
-			9000 0 0 3 &i8259 c 2
-			9000 0 0 4 &i8259 9 2
+			/* IDSEL 0x11 func 0 - PCI slot 1 */
+			8800 0 0 1 &mpic 2 1
+			8800 0 0 2 &mpic 3 1
+			8800 0 0 3 &mpic 4 1
+			8800 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 1 - PCI slot 1 */
+			8900 0 0 1 &mpic 2 1
+			8900 0 0 2 &mpic 3 1
+			8900 0 0 3 &mpic 4 1
+			8900 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 2 - PCI slot 1 */
+			8a00 0 0 1 &mpic 2 1
+			8a00 0 0 2 &mpic 3 1
+			8a00 0 0 3 &mpic 4 1
+			8a00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 3 - PCI slot 1 */
+			8b00 0 0 1 &mpic 2 1
+			8b00 0 0 2 &mpic 3 1
+			8b00 0 0 3 &mpic 4 1
+			8b00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 4 - PCI slot 1 */
+			8c00 0 0 1 &mpic 2 1
+			8c00 0 0 2 &mpic 3 1
+			8c00 0 0 3 &mpic 4 1
+			8c00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 5 - PCI slot 1 */
+			8d00 0 0 1 &mpic 2 1
+			8d00 0 0 2 &mpic 3 1
+			8d00 0 0 3 &mpic 4 1
+			8d00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 6 - PCI slot 1 */
+			8e00 0 0 1 &mpic 2 1
+			8e00 0 0 2 &mpic 3 1
+			8e00 0 0 3 &mpic 4 1
+			8e00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 7 - PCI slot 1 */
+			8f00 0 0 1 &mpic 2 1
+			8f00 0 0 2 &mpic 3 1
+			8f00 0 0 3 &mpic 4 1
+			8f00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x12 func 0 - PCI slot 2 */
+			9000 0 0 1 &mpic 3 1
+			9000 0 0 2 &mpic 4 1
+			9000 0 0 3 &mpic 1 1
+			9000 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 1 - PCI slot 2 */
+			9100 0 0 1 &mpic 3 1
+			9100 0 0 2 &mpic 4 1
+			9100 0 0 3 &mpic 1 1
+			9100 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 2 - PCI slot 2 */
+			9200 0 0 1 &mpic 3 1
+			9200 0 0 2 &mpic 4 1
+			9200 0 0 3 &mpic 1 1
+			9200 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 3 - PCI slot 2 */
+			9300 0 0 1 &mpic 3 1
+			9300 0 0 2 &mpic 4 1
+			9300 0 0 3 &mpic 1 1
+			9300 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 4 - PCI slot 2 */
+			9400 0 0 1 &mpic 3 1
+			9400 0 0 2 &mpic 4 1
+			9400 0 0 3 &mpic 1 1
+			9400 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 5 - PCI slot 2 */
+			9500 0 0 1 &mpic 3 1
+			9500 0 0 2 &mpic 4 1
+			9500 0 0 3 &mpic 1 1
+			9500 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 6 - PCI slot 2 */
+			9600 0 0 1 &mpic 3 1
+			9600 0 0 2 &mpic 4 1
+			9600 0 0 3 &mpic 1 1
+			9600 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 7 - PCI slot 2 */
+			9700 0 0 1 &mpic 3 1
+			9700 0 0 2 &mpic 4 1
+			9700 0 0 3 &mpic 1 1
+			9700 0 0 4 &mpic 2 1

 			// IDSEL 0x1c  USB
-			e000 0 0 0 &i8259 c 2
-			e100 0 0 0 &i8259 9 2
-			e200 0 0 0 &i8259 a 2
-			e300 0 0 0 &i8259 b 2
+			e000 0 0 1 &i8259 c 2
+			e100 0 0 1 &i8259 9 2
+			e200 0 0 1 &i8259 a 2
+			e300 0 0 1 &i8259 b 2

 			// IDSEL 0x1d  Audio
-			e800 0 0 0 &i8259 6 2
+			e800 0 0 1 &i8259 6 2

 			// IDSEL 0x1e Legacy
-			f000 0 0 0 &i8259 7 2
-			f100 0 0 0 &i8259 7 2
+			f000 0 0 1 &i8259 7 2
+			f100 0 0 1 &i8259 7 2

 			// IDSEL 0x1f IDE/SATA
-			f800 0 0 0 &i8259 e 2
-			f900 0 0 0 &i8259 5 2
+			f800 0 0 1 &i8259 e 2
+			f900 0 0 1 &i8259 5 2
 			>;

 		pcie@0 {
-- 
1.5.3.4
