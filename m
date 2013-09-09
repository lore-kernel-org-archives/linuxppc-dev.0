Return-Path: <B38951@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5BF982C012C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Sep 2013 20:07:16 +1000 (EST)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <B07421@freescale.com>
Subject: [PATCH V3] powerpc: Add I2C bus multiplexer node for B4 and T4240QDS
Date: Mon, 9 Sep 2013 18:03:33 +0800
Message-ID: <1378721013-20113-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: hongtao.jia@freescale.com, Wei.Yang@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In both B4 and T4240QDS platform PCA9547 I2C bus multiplexer is used.
The sub-nodes are also reorganized according to right I2C topology.

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
V3 change log:
* Change "channel" to "i2c" based on i2c-mux binding.
* Update vendor from philips to nxp.

V2 change log:
* Reorganized the sub-nodes under I2C multiplexer to represent right topology.

 arch/powerpc/boot/dts/b4qds.dtsi   | 51 +++++++++++++++++-----------
 arch/powerpc/boot/dts/t4240qds.dts | 69 ++++++++++++++++++++++----------------
 2 files changed, 73 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
index e6d2f8f..8b47edc 100644
--- a/arch/powerpc/boot/dts/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/b4qds.dtsi
@@ -120,25 +120,38 @@
 		};
 
 		i2c@118000 {
-			eeprom@50 {
-				compatible = "at24,24c64";
-				reg = <0x50>;
-			};
-			eeprom@51 {
-				compatible = "at24,24c256";
-				reg = <0x51>;
-			};
-			eeprom@53 {
-				compatible = "at24,24c256";
-				reg = <0x53>;
-			};
-			eeprom@57 {
-				compatible = "at24,24c256";
-				reg = <0x57>;
-			};
-			rtc@68 {
-				compatible = "dallas,ds3232";
-				reg = <0x68>;
+			mux@77 {
+				compatible = "nxp,pca9547";
+				reg = <0x77>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					eeprom@50 {
+						compatible = "at24,24c64";
+						reg = <0x50>;
+					};
+					eeprom@51 {
+						compatible = "at24,24c256";
+						reg = <0x51>;
+					};
+					eeprom@53 {
+						compatible = "at24,24c256";
+						reg = <0x53>;
+					};
+					eeprom@57 {
+						compatible = "at24,24c256";
+						reg = <0x57>;
+					};
+					rtc@68 {
+						compatible = "dallas,ds3232";
+						reg = <0x68>;
+					};
+				};
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/t4240qds.dts
index 0555976..a35508f 100644
--- a/arch/powerpc/boot/dts/t4240qds.dts
+++ b/arch/powerpc/boot/dts/t4240qds.dts
@@ -118,34 +118,47 @@
 		};
 
 		i2c@118000 {
-			eeprom@51 {
-				compatible = "at24,24c256";
-				reg = <0x51>;
-			};
-			eeprom@52 {
-				compatible = "at24,24c256";
-				reg = <0x52>;
-			};
-			eeprom@53 {
-				compatible = "at24,24c256";
-				reg = <0x53>;
-			};
-			eeprom@54 {
-				compatible = "at24,24c256";
-				reg = <0x54>;
-			};
-			eeprom@55 {
-				compatible = "at24,24c256";
-				reg = <0x55>;
-			};
-			eeprom@56 {
-				compatible = "at24,24c256";
-				reg = <0x56>;
-			};
-			rtc@68 {
-				compatible = "dallas,ds3232";
-				reg = <0x68>;
-				interrupts = <0x1 0x1 0 0>;
+			mux@77 {
+				compatible = "nxp,pca9547";
+				reg = <0x77>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					eeprom@51 {
+						compatible = "at24,24c256";
+						reg = <0x51>;
+					};
+					eeprom@52 {
+						compatible = "at24,24c256";
+						reg = <0x52>;
+					};
+					eeprom@53 {
+						compatible = "at24,24c256";
+						reg = <0x53>;
+					};
+					eeprom@54 {
+						compatible = "at24,24c256";
+						reg = <0x54>;
+					};
+					eeprom@55 {
+						compatible = "at24,24c256";
+						reg = <0x55>;
+					};
+					eeprom@56 {
+						compatible = "at24,24c256";
+						reg = <0x56>;
+					};
+					rtc@68 {
+						compatible = "dallas,ds3232";
+						reg = <0x68>;
+						interrupts = <0x1 0x1 0 0>;
+					};
+				};
 			};
 		};
 	};
-- 
1.8.0
