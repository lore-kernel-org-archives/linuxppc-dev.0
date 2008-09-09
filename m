Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2BC41DDEE8
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 05:43:49 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc: fix interrupt values for DMA2 in MPC8610 HPCD
	device tree
Date: Tue,  9 Sep 2008 14:43:39 -0500
Message-Id: <1220989419-26861-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For Freescale 8xxx devices that use an MPIC, the interrupt numbers in the
device tree must be 16 greater than the values documented in the reference
manual.  In these chips, the MPIC is wired to use the first 16 numbers for
external interrupts, but the documentation numbers internal interrupts from 0.

In the MPC8610 HPCD device tree, the interrupt properties for the DMA channels
for DMA2 were not the adjusted values.  This patch fixes that.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

I have no idea how this was missed for so long, but this patch is a
must-fix for 2.6.27.

(changes for v2: improve changelog text)

 arch/powerpc/boot/dts/mpc8610_hpcd.dts |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 3b3a106..584a4f1 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -281,7 +281,7 @@
 				cell-index = <0>;
 				reg = <0x0 0x80>;
 				interrupt-parent = <&mpic>;
-				interrupts = <60 2>;
+				interrupts = <76 2>;
 			};
 			dma-channel@1 {
 				compatible = "fsl,mpc8610-dma-channel",
@@ -289,7 +289,7 @@
 				cell-index = <1>;
 				reg = <0x80 0x80>;
 				interrupt-parent = <&mpic>;
-				interrupts = <61 2>;
+				interrupts = <77 2>;
 			};
 			dma-channel@2 {
 				compatible = "fsl,mpc8610-dma-channel",
@@ -297,7 +297,7 @@
 				cell-index = <2>;
 				reg = <0x100 0x80>;
 				interrupt-parent = <&mpic>;
-				interrupts = <62 2>;
+				interrupts = <78 2>;
 			};
 			dma-channel@3 {
 				compatible = "fsl,mpc8610-dma-channel",
@@ -305,7 +305,7 @@
 				cell-index = <3>;
 				reg = <0x180 0x80>;
 				interrupt-parent = <&mpic>;
-				interrupts = <63 2>;
+				interrupts = <79 2>;
 			};
 		};
 
-- 
1.5.5
