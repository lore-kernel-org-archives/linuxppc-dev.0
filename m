Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 79311DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 09:12:57 +1000 (EST)
Message-Id: <200805142312.m4ENCrIb026259@imap1.linux-foundation.org>
Subject: [patch 2/4] powerpc: add i2c pins to dts and board setup
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Wed, 14 May 2008 16:12:53 -0700
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jochen Friedrich <jochen@scram.de>

Initialize I2C pins on boards with CPM1/CPM2 controllers.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/boot/dts/mpc8272ads.dts         |   10 ++++++++++
 arch/powerpc/boot/dts/mpc866ads.dts          |   10 ++++++++++
 arch/powerpc/boot/dts/mpc885ads.dts          |   10 ++++++++++
 arch/powerpc/platforms/82xx/mpc8272_ads.c    |    4 ++++
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |    4 ++++
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    3 +++
 6 files changed, 41 insertions(+)

diff -puN arch/powerpc/boot/dts/mpc8272ads.dts~powerpc-add-i2c-pins-to-dts-and-board-setup arch/powerpc/boot/dts/mpc8272ads.dts
--- a/arch/powerpc/boot/dts/mpc8272ads.dts~powerpc-add-i2c-pins-to-dts-and-board-setup
+++ a/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -217,6 +217,16 @@
 				linux,network-index = <1>;
 				fsl,cpm-command = <0x16200300>;
 			};
+
+			i2c@11860 {
+				compatible = "fsl,mpc8272-i2c",
+					     "fsl,cpm2-i2c",
+					     "fsl,cpm-i2c";
+				reg = <11860 20 8afc 2>;
+				interrupts = <1 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-command = <29600000>;
+			};
 		};
 
 		PIC: interrupt-controller@10c00 {
diff -puN arch/powerpc/boot/dts/mpc866ads.dts~powerpc-add-i2c-pins-to-dts-and-board-setup arch/powerpc/boot/dts/mpc866ads.dts
--- a/arch/powerpc/boot/dts/mpc866ads.dts~powerpc-add-i2c-pins-to-dts-and-board-setup
+++ a/arch/powerpc/boot/dts/mpc866ads.dts
@@ -171,6 +171,16 @@
 				fsl,cpm-command = <0000>;
 				linux,network-index = <1>;
 			};
+
+			i2c@860 {
+				compatible = "fsl,mpc866-i2c",
+					     "fsl,cpm1-i2c",
+					     "fsl,cpm-i2c";
+				reg = <860 20 3c80 30>;
+				interrupts = <10>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-command = <0010>;
+			};
 		};
 	};
 
diff -puN arch/powerpc/boot/dts/mpc885ads.dts~powerpc-add-i2c-pins-to-dts-and-board-setup arch/powerpc/boot/dts/mpc885ads.dts
--- a/arch/powerpc/boot/dts/mpc885ads.dts~powerpc-add-i2c-pins-to-dts-and-board-setup
+++ a/arch/powerpc/boot/dts/mpc885ads.dts
@@ -215,6 +215,16 @@
 				fsl,cpm-command = <0x80>;
 				linux,network-index = <2>;
 			};
+
+			i2c@860 {
+				compatible = "fsl,mpc885-i2c",
+					     "fsl,cpm1-i2c",
+					     "fsl,cpm-i2c";
+				reg = <860 20 3c80 30>;
+				interrupts = <10>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-command = <0010>;
+			};
 		};
 	};
 
diff -puN arch/powerpc/platforms/82xx/mpc8272_ads.c~powerpc-add-i2c-pins-to-dts-and-board-setup arch/powerpc/platforms/82xx/mpc8272_ads.c
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c~powerpc-add-i2c-pins-to-dts-and-board-setup
+++ a/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -96,6 +96,10 @@ static struct cpm_pin mpc8272_ads_pins[]
 	{1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 	{2, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
 	{2, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* I2C */
+	{3, 14, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
+	{3, 15, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
 };
 
 static void __init init_ioports(void)
diff -puN arch/powerpc/platforms/8xx/mpc86xads_setup.c~powerpc-add-i2c-pins-to-dts-and-board-setup arch/powerpc/platforms/8xx/mpc86xads_setup.c
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c~powerpc-add-i2c-pins-to-dts-and-board-setup
+++ a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -65,6 +65,10 @@ static struct cpm_pin mpc866ads_pins[] =
 	{CPM_PORTD, 13, CPM_PIN_OUTPUT},
 	{CPM_PORTD, 14, CPM_PIN_OUTPUT},
 	{CPM_PORTD, 15, CPM_PIN_OUTPUT},
+
+	/* I2C */
+	{CPM_PORTB, 26, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
+	{CPM_PORTB, 27, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
 };
 
 static void __init init_ioports(void)
diff -puN arch/powerpc/platforms/8xx/mpc885ads_setup.c~powerpc-add-i2c-pins-to-dts-and-board-setup arch/powerpc/platforms/8xx/mpc885ads_setup.c
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c~powerpc-add-i2c-pins-to-dts-and-board-setup
+++ a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -158,6 +158,9 @@ static struct cpm_pin mpc885ads_pins[] =
 	{CPM_PORTE, 28, CPM_PIN_OUTPUT},
 	{CPM_PORTE, 29, CPM_PIN_OUTPUT},
 #endif
+	/* I2C */
+	{CPM_PORTB, 26, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
+	{CPM_PORTB, 27, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
 };
 
 static void __init init_ioports(void)
_
