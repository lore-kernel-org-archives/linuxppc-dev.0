Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9F5F9DDDD4
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 04:36:48 +1100 (EST)
Date: Thu, 27 Nov 2008 20:36:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/83xx: Fix MCU support merge issue in mpc8349emitx.dts
Message-ID: <20081127173645.GA28796@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just found the merge issue in 442746989d92afc125040e0f29b33602ad94da99
("powerpc/83xx: Add support for MCU microcontroller in .dts files"):
the commit adds the MCU controller node into the DMA node, which is
wrong because the MCU sits on the I2C bus. Fix this by moving the MCU
node into the I2C controller node.

The original patch[1] was OK though. ;-)

[1] http://patchwork.ozlabs.org/patch/4895/

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 2c9d54a..4bdbaf4 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -91,6 +91,14 @@
 				interrupts = <18 0x8>;
 				interrupt-parent = <&ipic>;
 			};
+
+			mcu_pio: mcu@a {
+				#gpio-cells = <2>;
+				compatible = "fsl,mc9s08qg8-mpc8349emitx",
+					     "fsl,mcu-mpc8349emitx";
+				reg = <0x0a>;
+				gpio-controller;
+			};
 		};
 
 		spi@7000 {
@@ -139,14 +147,6 @@
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
-
-			mcu_pio: mcu@a {
-				#gpio-cells = <2>;
-				compatible = "fsl,mc9s08qg8-mpc8349emitx",
-					     "fsl,mcu-mpc8349emitx";
-				reg = <0x0a>;
-				gpio-controller;
-			};
 		};
 
 		usb@22000 {
-- 
1.5.6.5
