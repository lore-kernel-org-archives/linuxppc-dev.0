Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id ED908B7230
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2011 04:50:08 +1100 (EST)
Received: from mail47-tx2 (localhost.localdomain [127.0.0.1])	by
 mail47-tx2-R.bigfish.com (Postfix) with ESMTP id 83E7C1A100C2	for
 <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 17:49:51 +0000 (UTC)
Received: from TX2EHSMHS047.bigfish.com (unknown [10.9.14.246])	by
 mail47-tx2.bigfish.com (Postfix) with ESMTP id 52387660053	for
 <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 17:49:51 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <scottwood@freescale.com>,
 <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] powerpc/85xx: add pixis indirect mode device tree node
Date: Fri, 18 Nov 2011 11:50:00 -0600
Message-ID: <1321638601-6861-2-git-send-email-timur@freescale.com>
In-Reply-To: <1321638601-6861-1-git-send-email-timur@freescale.com>
References: <1321638601-6861-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Freescale P1022 has a unique pin muxing "feature" where the DIU video
controller's video signals are muxed with 24 of the local bus address signals.
When the DIU is enabled, the bulk of the local bus is disabled, preventing
access to memory-mapped devices like NOR flash and the pixis FPGA.

In this situation, the pixis supports "indirect mode", which allows access
to the pixis itself by reading/writing addresses on specific local bus
chip selects.  CS0 is used to select which pixis register to access, and
CS1 is used to read/write the value.

To support this, we introduce another board-control child node of the
localbus node that contains a 'reg' property for CS0 and CS1.  This will
produce the correct physical addresses for CS0 and CS1.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/p1022ds.dts |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 24a73e9..3e85d8c 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -24,6 +24,20 @@
 			  0x2 0x0 0xf 0xffa00000 0x00040000
 			  0x3 0x0 0xf 0xffdf0000 0x00008000>;
 
+		/*
+		 * This node is used to access the pixis via "indirect" mode,
+		 * which is done by writing the pixis register index to chip
+		 * select 0 and the value to/from chip select 1.  Indirect
+		 * mode is the only way to access the pixis when DIU video
+		 * is enabled.  Note that this assumes that the first column
+		 * of the 'ranges' property above is the chip select number.
+		 */
+		board-control@0,0 {
+			compatible = "fsl,p1022ds-indirect-pixis";
+			reg = <0x0 0x0 1	/* CS0 */
+			       0x1 0x0 1>;	/* CS1 */
+		};
+
 		nor@0,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
1.7.3.4
