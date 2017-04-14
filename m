Return-Path: <javier@osg.samsung.com>
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 3w3zy631WszDqFn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 11:06:38 +1000 (AEST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 devicetree@vger.kernel.org, Florian Larysch <fl@n621.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 18/21] powerpc/fsl: Add generic compatible string for I2C
 EEPROM
Date: Thu, 13 Apr 2017 22:04:42 -0300
Message-Id: <20170414010445.21727-19-javier@osg.samsung.com>
In-Reply-To: <20170414010445.21727-1-javier@osg.samsung.com>
References: <20170414010445.21727-1-javier@osg.samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The at24 driver allows to register I2C EEPROM chips using different vendor
and devices, but the I2C subsystem does not take the vendor into account
when matching using the I2C table since it only has device entries.

But when matching using an OF table, both the vendor and device has to be
taken into account so the driver defines only a set of compatible strings
using the "atmel" vendor as a generic fallback for compatible I2C devices.

So add this generic fallback to the device node compatible string to make
the device to match the driver using the OF device ID table.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

Changes in v3: None
Changes in v2: None

 arch/powerpc/boot/dts/fsl/b4qds.dtsi    |  8 ++++----
 arch/powerpc/boot/dts/fsl/c293pcie.dts  |  2 +-
 arch/powerpc/boot/dts/fsl/p1010rdb.dtsi |  2 +-
 arch/powerpc/boot/dts/fsl/p1023rdb.dts  |  2 +-
 arch/powerpc/boot/dts/fsl/p2041rdb.dts  |  4 ++--
 arch/powerpc/boot/dts/fsl/p3041ds.dts   |  4 ++--
 arch/powerpc/boot/dts/fsl/p4080ds.dts   |  4 ++--
 arch/powerpc/boot/dts/fsl/p5020ds.dts   |  4 ++--
 arch/powerpc/boot/dts/fsl/p5040ds.dts   |  4 ++--
 arch/powerpc/boot/dts/fsl/t208xqds.dtsi |  8 ++++----
 arch/powerpc/boot/dts/fsl/t4240qds.dts  | 12 ++++++------
 arch/powerpc/boot/dts/fsl/t4240rdb.dts  |  6 +++---
 12 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4qds.dtsi b/arch/powerpc/boot/dts/fsl/b4qds.dtsi
index 3785ef826d07..18053d59be01 100644
--- a/arch/powerpc/boot/dts/fsl/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4qds.dtsi
@@ -166,19 +166,19 @@
 					reg = <0>;
 
 					eeprom@50 {
-						compatible = "at24,24c64";
+						compatible = "at24,24c64", "atmel,24c64";
 						reg = <0x50>;
 					};
 					eeprom@51 {
-						compatible = "at24,24c256";
+						compatible = "at24,24c256", "atmel,24c256";
 						reg = <0x51>;
 					};
 					eeprom@53 {
-						compatible = "at24,24c256";
+						compatible = "at24,24c256", "atmel,24c256";
 						reg = <0x53>;
 					};
 					eeprom@57 {
-						compatible = "at24,24c256";
+						compatible = "at24,24c256", "atmel,24c256";
 						reg = <0x57>;
 					};
 					rtc@68 {
diff --git a/arch/powerpc/boot/dts/fsl/c293pcie.dts b/arch/powerpc/boot/dts/fsl/c293pcie.dts
index 66709788429d..5e905e0857cf 100644
--- a/arch/powerpc/boot/dts/fsl/c293pcie.dts
+++ b/arch/powerpc/boot/dts/fsl/c293pcie.dts
@@ -153,7 +153,7 @@
 &soc {
 	i2c@3000 {
 		eeprom@50 {
-			compatible = "st,24c1024";
+			compatible = "st,24c1024", "atmel,24c1024";
 			reg = <0x50>;
 		};
 
diff --git a/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi b/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi
index a8e4ba070104..2ca9cee2ddeb 100644
--- a/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi
@@ -89,7 +89,7 @@
 &board_soc {
 	i2c@3000 {
 		eeprom@50 {
-			compatible = "st,24c256";
+			compatible = "st,24c256", "atmel,24c256";
 			reg = <0x50>;
 		};
 
diff --git a/arch/powerpc/boot/dts/fsl/p1023rdb.dts b/arch/powerpc/boot/dts/fsl/p1023rdb.dts
index 9716ca64651c..ae38ed66a7a4 100644
--- a/arch/powerpc/boot/dts/fsl/p1023rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p1023rdb.dts
@@ -79,7 +79,7 @@
 
 		i2c@3000 {
 			eeprom@53 {
-				compatible = "at24,24c04";
+				compatible = "at24,24c04", "atmel,24c04";
 				reg = <0x53>;
 			};
 
diff --git a/arch/powerpc/boot/dts/fsl/p2041rdb.dts b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
index e50fea95a853..0c34e8c46961 100644
--- a/arch/powerpc/boot/dts/fsl/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
@@ -127,7 +127,7 @@
 				reg = <0x48>;
 			};
 			eeprom@50 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x50>;
 			};
 			rtc@68 {
@@ -142,7 +142,7 @@
 
 		i2c@118100 {
 			eeprom@50 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x50>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/fsl/p3041ds.dts b/arch/powerpc/boot/dts/fsl/p3041ds.dts
index 40748e415adb..383656b73e61 100644
--- a/arch/powerpc/boot/dts/fsl/p3041ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p3041ds.dts
@@ -124,11 +124,11 @@
 
 		i2c@118100 {
 			eeprom@51 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x51>;
 			};
 			eeprom@52 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x52>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/fsl/p4080ds.dts b/arch/powerpc/boot/dts/fsl/p4080ds.dts
index 816b9788d5f6..9ca8d7cf8d48 100644
--- a/arch/powerpc/boot/dts/fsl/p4080ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p4080ds.dts
@@ -125,11 +125,11 @@
 
 		i2c@118100 {
 			eeprom@51 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x51>;
 			};
 			eeprom@52 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x52>;
 			};
 			rtc@68 {
diff --git a/arch/powerpc/boot/dts/fsl/p5020ds.dts b/arch/powerpc/boot/dts/fsl/p5020ds.dts
index cd6f37386111..4e6eab62f747 100644
--- a/arch/powerpc/boot/dts/fsl/p5020ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p5020ds.dts
@@ -124,11 +124,11 @@
 
 		i2c@118100 {
 			eeprom@51 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x51>;
 			};
 			eeprom@52 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x52>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/fsl/p5040ds.dts b/arch/powerpc/boot/dts/fsl/p5040ds.dts
index 45084738cf4e..d164e731146e 100644
--- a/arch/powerpc/boot/dts/fsl/p5040ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p5040ds.dts
@@ -133,11 +133,11 @@
 
 		i2c@118100 {
 			eeprom@51 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x51>;
 			};
 			eeprom@52 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x52>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/fsl/t208xqds.dtsi b/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
index ec080bd01b09..780103e3eaae 100644
--- a/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
@@ -147,17 +147,17 @@
 					reg = <0x0>;
 
 					eeprom@50 {
-						compatible = "at24,24c512";
+						compatible = "at24,24c512", "atmel,24c512";
 						reg = <0x50>;
 					};
 
 					eeprom@51 {
-						compatible = "at24,24c02";
+						compatible = "at24,24c02", "atmel,24c02";
 						reg = <0x51>;
 					};
 
 					eeprom@57 {
-						compatible = "at24,24c02";
+						compatible = "at24,24c02", "atmel,24c02";
 						reg = <0x57>;
 					};
 
@@ -174,7 +174,7 @@
 					reg = <0x1>;
 
 					eeprom@55 {
-						compatible = "at24,24c02";
+						compatible = "at24,24c02", "atmel,24c02";
 						reg = <0x55>;
 					};
 				};
diff --git a/arch/powerpc/boot/dts/fsl/t4240qds.dts b/arch/powerpc/boot/dts/fsl/t4240qds.dts
index 9573ceada07c..9f01bcfad699 100644
--- a/arch/powerpc/boot/dts/fsl/t4240qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240qds.dts
@@ -377,27 +377,27 @@
 					reg = <0>;
 
 					eeprom@51 {
-						compatible = "at24,24c256";
+						compatible = "at24,24c256", "atmel,24c256";
 						reg = <0x51>;
 					};
 					eeprom@52 {
-						compatible = "at24,24c256";
+						compatible = "at24,24c256", "atmel,24c256";
 						reg = <0x52>;
 					};
 					eeprom@53 {
-						compatible = "at24,24c256";
+						compatible = "at24,24c256", "atmel,24c256";
 						reg = <0x53>;
 					};
 					eeprom@54 {
-						compatible = "at24,24c256";
+						compatible = "at24,24c256", "atmel,24c256";
 						reg = <0x54>;
 					};
 					eeprom@55 {
-						compatible = "at24,24c256";
+						compatible = "at24,24c256", "atmel,24c256";
 						reg = <0x55>;
 					};
 					eeprom@56 {
-						compatible = "at24,24c256";
+						compatible = "at24,24c256", "atmel,24c256";
 						reg = <0x56>;
 					};
 					rtc@68 {
diff --git a/arch/powerpc/boot/dts/fsl/t4240rdb.dts b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
index 8166c660712a..9fb192e36bf0 100644
--- a/arch/powerpc/boot/dts/fsl/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
@@ -130,15 +130,15 @@
 				reg = <0x2f>;
 			};
 			eeprom@52 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x52>;
 			};
 			eeprom@54 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x54>;
 			};
 			eeprom@56 {
-				compatible = "at24,24c256";
+				compatible = "at24,24c256", "atmel,24c256";
 				reg = <0x56>;
 			};
 			rtc@68 {
-- 
2.9.3
