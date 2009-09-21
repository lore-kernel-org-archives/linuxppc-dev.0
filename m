Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3EFC8B7334
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 13:07:38 +1000 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id n8L0n2XE029046
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Sep 2009 17:49:03 -0700 (PDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] sbc8548: fixup of PCI-e related DTS fields
Date: Sun, 20 Sep 2009 20:49:02 -0400
Message-Id: <1253494142-26821-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PCI-e addressing was originally patterned of the MPC8548CDS
which has PCI1, PCI2, and PCI-e.  Since this board only has
PCI1 and PCI-e, it makes more sense to be similar to the MPC8568MDS
board.  This does that by cutting the PCI/PCI-e I/O sizes from
16MB to 8MB and pulling the PCI-e I/O range back to 0xe280_0000
(the hole where PCI2 I/O would have been).

This also fixes a typo where an extra zero made an 8MB range a 128MB
range, removes the hole left by PCI2 from the aliases, and sets the
clocks to match the oscillators that are actually on the board.

With accompanying u-boot updates, PCI-e has been validated with
both a sky2 card (1148:9e00) and an e1000 card (8086:108b).

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8548.dts |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index 9eefe00..a5bb015 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -26,8 +26,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
-		/* pci1 doesn't have a corresponding physical connector */
-		pci2 = &pci2;
+		pci1 = &pci1;
 	};
 
 	cpus {
@@ -381,7 +380,7 @@
 		bus-range = <0 0>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00800000>;
-		clock-frequency = <66666666>;
+		clock-frequency = <66000000>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
@@ -390,7 +389,7 @@
 		device_type = "pci";
 	};
 
-	pci2: pcie@e000a000 {
+	pci1: pcie@e000a000 {
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 
@@ -403,9 +402,9 @@
 		interrupt-parent = <&mpic>;
 		interrupts = <0x1a 0x2>;
 		bus-range = <0x0 0xff>;
-		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
-			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x08000000>;
-		clock-frequency = <33333333>;
+		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe2800000 0x0 0x08000000>;
+		clock-frequency = <33000000>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
@@ -419,11 +418,11 @@
 			device_type = "pci";
 			ranges = <0x02000000 0x0 0xa0000000
 				  0x02000000 0x0 0xa0000000
-				  0x0 0x20000000
+				  0x0 0x10000000
 
 				  0x01000000 0x0 0x00000000
 				  0x01000000 0x0 0x00000000
-				  0x0 0x08000000>;
+				  0x0 0x0800000>;
 		};
 	};
 };
-- 
1.6.4.1
