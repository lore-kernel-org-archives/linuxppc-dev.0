Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 437CFB7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 04:36:49 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id D0674DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 04:36:48 +1000 (EST)
Date: Thu, 9 Jul 2009 22:36:44 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Add support for I2C EEPROMs on MPC8548CDS boards
Message-ID: <20090709183644.GA1614@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch simply adds four eeprom nodes to MPC8548CDS' device tree.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8548cds.dts |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 475be14..4173af3 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -100,6 +100,21 @@
 			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+
+			eeprom@56 {
+				compatible = "atmel,24c64";
+				reg = <0x56>;
+			};
+
+			eeprom@57 {
+				compatible = "atmel,24c64";
+				reg = <0x57>;
+			};
 		};
 
 		i2c@3100 {
@@ -111,6 +126,11 @@
 			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		dma@21300 {
-- 
1.6.3.3
