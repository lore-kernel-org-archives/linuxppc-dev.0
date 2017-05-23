Return-Path: <javier@dowhile0.org>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXGk857FfzDqLf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 23:35:28 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id b84so23630016wmh.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 06:35:28 -0700 (PDT)
From: Javier Martinez Canillas <javier@dowhile0.org>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh@kernel.org>,
 Javier Martinez Canillas <javier@dowhile0.org>, devicetree@vger.kernel.org,
 Florian Larysch <fl@n621.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 17/20] powerpc/fsl: Add generic compatible string for I2C
 EEPROM
Date: Tue, 23 May 2017 15:34:45 +0200
Message-Id: <20170523133448.4794-18-javier@dowhile0.org>
In-Reply-To: <20170523133448.4794-1-javier@dowhile0.org>
References: <20170523133448.4794-1-javier@dowhile0.org>
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

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>

---

Changes in v5:
- Only replace atmel variant but keep other EEPROM vendors (Geert Uytterhoeven).

Changes in v4:
- Only use the atmel manufacturer in the compatible string instead of
  keeping the deprecated ones (Rob Herring).

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
index 3785ef826d07..999efd3bc167 100644
--- a/arch/powerpc/boot/dts/fsl/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4qds.dtsi
@@ -166,19 +166,19 @@
 					reg = <0>;
 
 					eeprom@50 {
-						compatible = "at24,24c64";
+						compatible = "atmel,24c64";
 						reg = <0x50>;
 					};
 					eeprom@51 {
-						compatible = "at24,24c256";
+						compatible = "atmel,24c256";
 						reg = <0x51>;
 					};
 					eeprom@53 {
-						compatible = "at24,24c256";
+						compatible = "atmel,24c256";
 						reg = <0x53>;
 					};
 					eeprom@57 {
-						compatible = "at24,24c256";
+						compatible = "atmel,24c256";
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
index 9716ca64651c..ead928364beb 100644
--- a/arch/powerpc/boot/dts/fsl/p1023rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p1023rdb.dts
@@ -79,7 +79,7 @@
 
 		i2c@3000 {
 			eeprom@53 {
-				compatible = "at24,24c04";
+				compatible = "atmel,24c04";
 				reg = <0x53>;
 			};
 
diff --git a/arch/powerpc/boot/dts/fsl/p2041rdb.dts b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
index e50fea95a853..950816b9d6e1 100644
--- a/arch/powerpc/boot/dts/fsl/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
@@ -127,7 +127,7 @@
 				reg = <0x48>;
 			};
 			eeprom@50 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x50>;
 			};
 			rtc@68 {
@@ -142,7 +142,7 @@
 
 		i2c@118100 {
 			eeprom@50 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x50>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/fsl/p3041ds.dts b/arch/powerpc/boot/dts/fsl/p3041ds.dts
index 40748e415adb..6f5f7283c533 100644
--- a/arch/powerpc/boot/dts/fsl/p3041ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p3041ds.dts
@@ -124,11 +124,11 @@
 
 		i2c@118100 {
 			eeprom@51 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x51>;
 			};
 			eeprom@52 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x52>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/fsl/p4080ds.dts b/arch/powerpc/boot/dts/fsl/p4080ds.dts
index 816b9788d5f6..65e20152e22f 100644
--- a/arch/powerpc/boot/dts/fsl/p4080ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p4080ds.dts
@@ -125,11 +125,11 @@
 
 		i2c@118100 {
 			eeprom@51 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x51>;
 			};
 			eeprom@52 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x52>;
 			};
 			rtc@68 {
diff --git a/arch/powerpc/boot/dts/fsl/p5020ds.dts b/arch/powerpc/boot/dts/fsl/p5020ds.dts
index cd6f37386111..b24adf902d8d 100644
--- a/arch/powerpc/boot/dts/fsl/p5020ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p5020ds.dts
@@ -124,11 +124,11 @@
 
 		i2c@118100 {
 			eeprom@51 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x51>;
 			};
 			eeprom@52 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x52>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/fsl/p5040ds.dts b/arch/powerpc/boot/dts/fsl/p5040ds.dts
index 45084738cf4e..30850b3228e0 100644
--- a/arch/powerpc/boot/dts/fsl/p5040ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p5040ds.dts
@@ -133,11 +133,11 @@
 
 		i2c@118100 {
 			eeprom@51 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x51>;
 			};
 			eeprom@52 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x52>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/fsl/t208xqds.dtsi b/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
index ec080bd01b09..db4139999b28 100644
--- a/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
@@ -147,17 +147,17 @@
 					reg = <0x0>;
 
 					eeprom@50 {
-						compatible = "at24,24c512";
+						compatible = "atmel,24c512";
 						reg = <0x50>;
 					};
 
 					eeprom@51 {
-						compatible = "at24,24c02";
+						compatible = "atmel,24c02";
 						reg = <0x51>;
 					};
 
 					eeprom@57 {
-						compatible = "at24,24c02";
+						compatible = "atmel,24c02";
 						reg = <0x57>;
 					};
 
@@ -174,7 +174,7 @@
 					reg = <0x1>;
 
 					eeprom@55 {
-						compatible = "at24,24c02";
+						compatible = "atmel,24c02";
 						reg = <0x55>;
 					};
 				};
diff --git a/arch/powerpc/boot/dts/fsl/t4240qds.dts b/arch/powerpc/boot/dts/fsl/t4240qds.dts
index 9573ceada07c..c0913ac5aaad 100644
--- a/arch/powerpc/boot/dts/fsl/t4240qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240qds.dts
@@ -377,27 +377,27 @@
 					reg = <0>;
 
 					eeprom@51 {
-						compatible = "at24,24c256";
+						compatible = "atmel,24c256";
 						reg = <0x51>;
 					};
 					eeprom@52 {
-						compatible = "at24,24c256";
+						compatible = "atmel,24c256";
 						reg = <0x52>;
 					};
 					eeprom@53 {
-						compatible = "at24,24c256";
+						compatible = "atmel,24c256";
 						reg = <0x53>;
 					};
 					eeprom@54 {
-						compatible = "at24,24c256";
+						compatible = "atmel,24c256";
 						reg = <0x54>;
 					};
 					eeprom@55 {
-						compatible = "at24,24c256";
+						compatible = "atmel,24c256";
 						reg = <0x55>;
 					};
 					eeprom@56 {
-						compatible = "at24,24c256";
+						compatible = "atmel,24c256";
 						reg = <0x56>;
 					};
 					rtc@68 {
diff --git a/arch/powerpc/boot/dts/fsl/t4240rdb.dts b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
index 8166c660712a..15eb0a3f7290 100644
--- a/arch/powerpc/boot/dts/fsl/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
@@ -130,15 +130,15 @@
 				reg = <0x2f>;
 			};
 			eeprom@52 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x52>;
 			};
 			eeprom@54 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x54>;
 			};
 			eeprom@56 {
-				compatible = "at24,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x56>;
 			};
 			rtc@68 {
-- 
2.9.3
