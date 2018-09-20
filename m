Return-Path: <equinox@diac24.net>
Received: from eidolon.nox.tf (eidolon.nox.tf [IPv6:2a07:2ec0:2185::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GXNp3TpmzF3NN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 09:04:26 +1000 (AEST)
Date: Fri, 21 Sep 2018 01:04:22 +0200
From: David Lamparter <equinox@diac24.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/fsl/dts: add missing P4080DS I2C devices
Message-ID: <20180920230422.GK487685@eidolon.nox.tf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This just adds the zl2006 voltage regulators / power monitors and the
onboard I2C eeproms.  The ICS9FG108 clock chip doesn't seem to have a
driver, so it is left in the DTS as a comment.  And for good measure,
the SPD eeproms are tagged as such.

Signed-off-by: David Lamparter <equinox@diac24.net>
---
I'm not subscribed to linuxppc-dev, please keep me in Cc:.
---
 arch/powerpc/boot/dts/fsl/p4080ds.dts | 43 +++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p4080ds.dts b/arch/powerpc/boot/dts/fsl/p4080ds.dts
index 65e20152e22f..969b32c4f2d5 100644
--- a/arch/powerpc/boot/dts/fsl/p4080ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p4080ds.dts
@@ -125,11 +125,11 @@
 
 		i2c@118100 {
 			eeprom@51 {
-				compatible = "atmel,24c256";
+				compatible = "atmel,spd";
 				reg = <0x51>;
 			};
 			eeprom@52 {
-				compatible = "atmel,24c256";
+				compatible = "atmel,spd";
 				reg = <0x52>;
 			};
 			rtc@68 {
@@ -143,6 +143,45 @@
 			};
 		};
 
+		i2c@118000 {
+			zl2006@21 {
+				compatible = "zl2006";
+				reg = <0x21>;
+			};
+			zl2006@22 {
+				compatible = "zl2006";
+				reg = <0x22>;
+			};
+			zl2006@23 {
+				compatible = "zl2006";
+				reg = <0x23>;
+			};
+			zl2006@24 {
+				compatible = "zl2006";
+				reg = <0x24>;
+			};
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+			eeprom@55 {
+				compatible = "atmel,24c64";
+				reg = <0x55>;
+			};
+			eeprom@56 {
+				compatible = "atmel,24c64";
+				reg = <0x56>;
+			};
+			eeprom@57 {
+				compatible = "atmel,24c02";
+				reg = <0x57>;
+			};
+		};
+
+		i2c@119100 {
+			/* 0x6E: ICS9FG108 */
+		};
+
 		usb0: usb@210000 {
 			phy_type = "ulpi";
 		};
-- 
2.18.0
