Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id CE0A8DE124
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 18:07:58 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: w.sang@pengutronix.de
Date: Wed, 20 May 2009 10:07:45 +0200
Message-Id: <1242806865-2334-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH] powerpc/pcm030.dts: add i2c eeprom and delete cruft
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a node for the i2c eeprom and delete the superflous gpio-example.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/boot/dts/pcm030.dts |   26 ++++----------------------
 1 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm030.dts
index 8958347..33ce488 100644
--- a/arch/powerpc/boot/dts/pcm030.dts
+++ b/arch/powerpc/boot/dts/pcm030.dts
@@ -258,34 +258,16 @@
 				compatible = "nxp,pcf8563";
 				reg = <0x51>;
 			};
-			/* FIXME: EEPROM */
+			eeprom@52 {
+				compatible = "at24,24c32";
+				reg = <0x52>;
+			};
 		};
 
 		sram@8000 {
 			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram";
 			reg = <0x8000 0x4000>;
 		};
-
-		/* This is only an example device to show the usage of gpios. It maps all available
-		 * gpios to the "gpio-provider" device.
-		 */
-		gpio {
-			compatible = "gpio-provider";
-
-						    /* mpc52xx		exp.con		patchfield */
-			gpios = <&gpio_wkup	0 0 /* GPIO_WKUP_7	11d		jp13-3     */
-				 &gpio_wkup	1 0 /* GPIO_WKUP_6	14c			   */
-				 &gpio_wkup	6 0 /* PSC2_4		43c		x5-11	   */
-				 &gpio_simple	2 0 /* IRDA_1		24c		x7-6	set GPS_PORT_CONFIG[IRDA] = 0 */
-				 &gpio_simple	3 0 /* IRDA_0				x8-5	set GPS_PORT_CONFIG[IRDA] = 0 */
-				 &gpt2		0 0 /* timer2		12d		x4-4	   */
-				 &gpt3		0 0 /* timer3		13d		x6-4	   */
-				 &gpt4		0 0 /* timer4		61c		x2-16	   */
-				 &gpt5		0 0 /* timer5		44c		x7-11	   */
-				 &gpt6		0 0 /* timer6		60c		x8-15	   */
-				 &gpt7		0 0 /* timer7		36a		x17-9	   */
-				 >;
-		};
 	};
 
 	pci@f0000d00 {
-- 
1.6.2
