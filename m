Return-Path: <timur@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53458B6F07
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 06:36:58 +1100 (EST)
Received: from mail48-db3 (localhost.localdomain [127.0.0.1])	by
	mail48-db3-R.bigfish.com (Postfix) with ESMTP id A2B821C6064E	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 19:36:51 +0000 (UTC)
Received: from DB3EHSMHS005.bigfish.com (unknown [10.3.81.244])	by
	mail48-db3.bigfish.com (Postfix) with ESMTP id 4FBCE678050	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 19:36:50 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o97Jai1l006783	for <linuxppc-dev@ozlabs.org>;
	Thu, 7 Oct 2010 12:36:46 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <kumar.gala@freescale.com>
Subject: [PATCH 1/2] [v2] powerpc/85xx: add ngPIXIS FPGA device tree node to
	the P1022DS board
Date: Thu, 7 Oct 2010 14:36:42 -0500
Message-ID: <1286480203-28227-1-git-send-email-timur@freescale.com>
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

The device tree for Freescale's P1022DS reference board is missing the node
for the ngPIXIS FPGA.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/p1022ds.dts |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 8bcb10b..2bbecbb 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -148,6 +148,17 @@
 				label = "reserved-nand";
 			};
 		};
+
+		board-control@3,0 {
+			compatible = "fsl,p1022ds-pixis";
+			reg = <3 0 0x30>;
+			interrupt-parent = <&mpic>;
+			/*
+			 * IRQ8 is generated if the "EVENT" switch is pressed
+			 * and PX_CTL[EVESEL] is set to 00.
+			 */
+			interrupts = <8 8>;
+		};
 	};
 
 	soc@fffe00000 {
-- 
1.7.2.3
