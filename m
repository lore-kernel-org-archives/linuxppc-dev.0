Return-Path: <fl@n621.de>
Received: from nyx.n621.de (nyx.n621.de [176.9.182.227])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKHKr0SHJzDvp7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 21:24:16 +1100 (AEDT)
From: Florian Larysch <fl@n621.de>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 Florian Larysch <fl@n621.de>
Subject: [PATCH v2 1/2] powerpc/dts: add device tree entry for W83793 on
 T4240RDB
Date: Thu, 17 Nov 2016 11:23:23 +0100
Message-Id: <20161117102324.18319-2-fl@n621.de>
In-Reply-To: <20161117102324.18319-1-fl@n621.de>
References: <20161117102324.18319-1-fl@n621.de>
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
index cc0a264..8166c66 100644
--- a/arch/powerpc/boot/dts/fsl/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
@@ -125,6 +125,10 @@
 		};
 
 		i2c@118000 {
+			hwmon@2f {
+				compatible = "winbond,w83793";
+				reg = <0x2f>;
+			};
 			eeprom@52 {
 				compatible = "at24,24c256";
 				reg = <0x52>;
-- 
2.10.2
