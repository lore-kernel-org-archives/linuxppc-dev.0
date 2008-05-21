Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1167CDE04C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 02:37:29 +1000 (EST)
Message-ID: <48344FB9.8020903@scram.de>
Date: Wed, 21 May 2008 18:37:13 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCHv2] [POWERPC] Add i2c pins to dts and board setup
Content-Type: text/plain; charset=ISO-8859-15
Cc: Boris Shteinbock <bshtein@yahoo.com>, Wolfram Sang <w.sang@pengutronix.de>,
	"Kernel, Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Linux I2C <i2c@lm-sensors.org>,
	Scott Wood <scottwood@freescale.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Initialize I2C pins on boards with CPM1/CPM2 controllers.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 Documentation/powerpc/booting-without-of.txt |   42 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8272ads.dts         |   11 +++++++
 arch/powerpc/boot/dts/mpc866ads.dts          |   11 +++++++
 arch/powerpc/boot/dts/mpc885ads.dts          |   11 +++++++
 arch/powerpc/platforms/82xx/mpc8272_ads.c    |    4 ++
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |    4 ++
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    3 ++
 7 files changed, 86 insertions(+), 0 deletions(-)

Changes since v1:
- document the fact that linux,i2c-class and linux,i2c-index are deprecated and
  for old style i2c drivers only.
- fix typo nummer -> number
- fix property bus-frequency -> clock-frequency.

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 1d2a772..8ab9d16 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2132,6 +2132,48 @@ platforms are moved over to use the flattened-device-tree model.
 		};
 	};

+   ix) I2C
+
+   The I2C controller is expressed as a bus under the CPM node.
+
+   Properties:
+   - compatible : "fsl,cpm1-i2c", "fsl,cpm2-i2c"
+   - reg : On CPM2 devices, the second resource doesn't specify the I2C
+     Parameter RAM itself, but the I2C_BASE field of the CPM2 Parameter RAM
+     (typically 0x8afc 0x2).
+   - #address-cells : Should be one. The cell is the i2c device address with
+     the r/w bit set to zero.
+   - #size-cells : Should be zero.
+   - clock-frequency : Can be used to set the i2c clock frequency. If
+     unspecified, a default frequency of 60kHz is being used.
+   The following two properties are deprecated. They are only used by old style
+   i2c drivers to find the bus to probe:
+   - linux,i2c-index : Can be used to hard code an i2c bus number. By default,
+     the bus number is dynamically assigned by the i2c core.
+   - linux,i2c-class : Can be used to override the i2c class. The class is used
+     by old style i2c device drivers to find a bus in a specific context like
+     system management, video or sound. By default, I2C_CLASS_HWMON (1) is
+     being used. The definition of the classes can be found in
+     include/i2c/i2c.h
+
+   Example, based on mpc823:
+
+	i2c@860 {
+		compatible = "fsl,mpc823-i2c",
+			     "fsl,cpm1-i2c";
+		reg = <0x860 0x20 0x3c80 0x30>;
+		interrupts = <16>;
+		interrupt-parent = <&CPM_PIC>;
+		fsl,cpm-command = <0x10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtc@68 {
+			compatible = "dallas,ds1307";
+			reg = <0x68>;
+		};
+	};
+
    m) Chipselect/Local Bus

    Properties:
diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 46e2da3..d27f8a7 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -217,6 +217,17 @@
 				linux,network-index = <1>;
 				fsl,cpm-command = <0x16200300>;
 			};
+
+			i2c@11860 {
+				compatible = "fsl,mpc8272-i2c",
+					     "fsl,cpm2-i2c";
+				reg = <0x11860 0x20 0x8afc 0x2>;
+				interrupts = <1 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-command = <0x29600000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};

 		PIC: interrupt-controller@10c00 {
diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index 765e43c..bd70065 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -171,6 +171,17 @@
 				fsl,cpm-command = <0000>;
 				linux,network-index = <1>;
 			};
+
+			i2c@860 {
+				compatible = "fsl,mpc866-i2c",
+					     "fsl,cpm1-i2c";
+				reg = <0x860 0x20 0x3c80 0x30>;
+				interrupts = <16>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-command = <0x10>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 	};

diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index 9895043..b123e9f 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -215,6 +215,17 @@
 				fsl,cpm-command = <0x80>;
 				linux,network-index = <2>;
 			};
+
+			i2c@860 {
+				compatible = "fsl,mpc885-i2c",
+					     "fsl,cpm1-i2c";
+				reg = <0x860 0x20 0x3c80 0x30>;
+				interrupts = <16>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-command = <0x10>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 	};

diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index 7d30187..8054c68 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -96,6 +96,10 @@ static struct cpm_pin mpc8272_ads_pins[] = {
 	{1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 	{2, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
 	{2, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* I2C */
+	{3, 14, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
+	{3, 15, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
 };

 static void __init init_ioports(void)
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index c028a5b..caaec29 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -65,6 +65,10 @@ static struct cpm_pin mpc866ads_pins[] = {
 	{CPM_PORTD, 13, CPM_PIN_OUTPUT},
 	{CPM_PORTD, 14, CPM_PIN_OUTPUT},
 	{CPM_PORTD, 15, CPM_PIN_OUTPUT},
+
+	/* I2C */
+	{CPM_PORTB, 26, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
+	{CPM_PORTB, 27, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
 };

 static void __init init_ioports(void)
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 6e7ded0..45ed6cd 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -158,6 +158,9 @@ static struct cpm_pin mpc885ads_pins[] = {
 	{CPM_PORTE, 28, CPM_PIN_OUTPUT},
 	{CPM_PORTE, 29, CPM_PIN_OUTPUT},
 #endif
+	/* I2C */
+	{CPM_PORTB, 26, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
+	{CPM_PORTB, 27, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
 };

 static void __init init_ioports(void)
-- 
1.5.5.1
