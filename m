Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8DDC0DE2AA
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 04:10:35 +1100 (EST)
Date: Sun, 3 Feb 2008 20:10:24 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/11] [POWERPC] mpc8360erdk: add FHCI USB support
Message-ID: <20080203171024.GJ28024@localhost.localdomain>
References: <20080203170820.GA18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080203170820.GA18520@localhost.localdomain>
Cc: David Brownell <david-b@pacbell.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This consists of: usb node, gtm node and gpio-controllers of the
B and E banks.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc836x_rdk.dts |   42 +++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index cc56338..f770ac1 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -133,6 +133,20 @@
 			reg = <0x700 0x100>;
 		};
 
+		qe_pio_b: gpio-controller@1418 {
+			#gpio-cells = <2>;
+			compatible = "fsl,qe-pario-bank";
+			reg = <0x1418 0x18>;
+			gpio-controller;
+		};
+
+		qe_pio_e: gpio-controller@1460 {
+			#gpio-cells = <2>;
+			compatible = "fsl,qe-pario-bank";
+			reg = <0x1460 0x18>;
+			gpio-controller;
+		};
+
 		qe@100000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -156,6 +170,34 @@
 						     "fsl,cpm-muram-data";
 					reg = <0 0xc000>;
 				};
+
+				usb-pram@8b00 {
+					compatible = "fsl,qe-muram-usb-pram";
+					reg = <0x8b00 0x100>;
+				};
+			};
+
+			gtm@440 {
+				compatible = "fsl,qe-gtm";
+				reg = <0x440 0x40>;
+				interrupts = <12 13 14 15>;
+				interrupt-parent = <&qeic>;
+			};
+
+			usb@6c0 {
+				compatible = "fsl,usb-fhci";
+				reg = <0x6c0 0x40>;
+				interrupts = <11>;
+				interrupt-parent = <&qeic>;
+				fullspeed-clock = "clk21";
+				gpios = <&qe_pio_b  2 0 /* USBOE */
+					 &qe_pio_b  3 0 /* USBTP */
+					 &qe_pio_b  8 0 /* USBTN */
+					 &qe_pio_b  9 0 /* USBRP */
+					 &qe_pio_b 11 0 /* USBRN */
+					 &qe_pio_e 20 0 /* SPEED */
+					 &qe_pio_e 21 0 /* SUSPN */>;
+				mode = "host";
 			};
 
 			spi@4c0 {
-- 
1.5.2.2
