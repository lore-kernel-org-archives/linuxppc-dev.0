Return-Path: <fl@n621.de>
Received: from nyx.n621.de (nyx.n621.de [176.9.182.227])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHVPN6FgDzDw2Q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:36:08 +1100 (AEDT)
From: Florian Larysch <fl@n621.de>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org,
	Florian Larysch <fl@n621.de>
Subject: [PATCH] T4240RBD: add device tree entry for W83793
Date: Mon, 14 Nov 2016 13:28:05 +0100
Message-Id: <20161114122805.11376-1-fl@n621.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The T4240RDB contains a W83793 hardware monitoring chip. Add a device
tree entry to make the driver attach to it, as the i2c-mpc bus driver
dropped support for class-based instantiation of devices a long time
ago.

Signed-off-by: Florian Larysch <fl@n621.de>
---
 arch/powerpc/boot/dts/fsl/t4240rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/t4240rdb.dts b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
index cc0a264..b35eea1 100644
--- a/arch/powerpc/boot/dts/fsl/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
@@ -142,6 +142,10 @@
 				reg = <0x68>;
 				interrupts = <0x1 0x1 0 0>;
 			};
+			hwmon@2f {
+				compatible = "winbond,w83793";
+				reg = <0x2f>;
+			};
 		};
 
 		sdhc@114000 {
-- 
2.10.2
