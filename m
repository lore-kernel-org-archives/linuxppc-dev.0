Return-Path: <R1AAHA@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 49AE72C00BD
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Apr 2013 08:02:00 +1000 (EST)
Date: Wed, 10 Apr 2013 16:58:28 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Fix MPC8536DS 36-bit device tree
Message-ID: <20130410165828.ec0378afc7e7f17e8e47850e@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>

The localbus node should be in at 0xfffe05000 not 0xffe05000.  Also
fixed the names of the localbus and pci nodes to reflect the addresses
they are actually at.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
note: this upstream submission extended to fix pci1.

 arch/powerpc/boot/dts/mpc8536ds_36b.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8536ds_36b.dts b/arch/powerpc/boot/dts/mpc8536ds_36b.dts
index f8a3b34..6c723ee 100644
--- a/arch/powerpc/boot/dts/mpc8536ds_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds_36b.dts
@@ -32,7 +32,7 @@
 		reg = <0 0 0 0>;	// Filled by U-Boot
 	};
 
-	lbc: localbus@ffe05000 {
+	lbc: localbus@fffe05000 {
 		reg = <0xf 0xffe05000 0 0x1000>;
 
 		ranges = <0x0 0x0 0xf 0xe8000000 0x08000000
@@ -44,7 +44,7 @@
 		ranges = <0x0 0xf 0xffe00000 0x100000>;
 	};
 
-	pci0: pci@ffe08000 {
+	pci0: pci@fffe08000 {
 		reg = <0xf 0xffe08000 0 0x1000>;
 		ranges = <0x02000000 0 0xf0000000 0xc 0x00000000 0 0x10000000
 			  0x01000000 0 0x00000000 0xf 0xffc00000 0 0x00010000>;
@@ -59,7 +59,7 @@
 			0x8800 0 0 4 &mpic 4 1 0 0>;
 	};
 
-	pci1: pcie@ffe09000 {
+	pci1: pcie@fffe09000 {
 		reg = <0xf 0xffe09000 0 0x1000>;
 		ranges = <0x02000000 0 0xf8000000 0xc 0x18000000 0 0x08000000
 			  0x01000000 0 0x00000000 0xf 0xffc20000 0 0x00010000>;
-- 
1.8.1.5
