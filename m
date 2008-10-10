Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id E0D42DE108
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 03:55:06 +1100 (EST)
Date: Fri, 10 Oct 2008 20:55:04 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/83xx: add USB Host support for the
	MPC8360E-RDK boards
Message-ID: <20081010165504.GD4291@oksana.dev.rtsoft.ru>
References: <20081010165410.GA4291@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081010165410.GA4291@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Simply add the usb node to support USB host on the MPC8360E-RDK
boards.

Currently U-Boot doesn't fill the clock-frequency property for
timer nodes, so for now we have to fill it manually.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc836x_rdk.dts |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index 89c9202..b4f3a17 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -214,8 +214,23 @@
 				reg = <0x440 0x40>;
 				interrupts = <12 13 14 15>;
 				interrupt-parent = <&qeic>;
-				/* filled by u-boot */
-				clock-frequency = <0>;
+				clock-frequency = <166666666>;
+			};
+
+			usb@6c0 {
+				compatible = "fsl,mpc8360-qe-usb",
+					     "fsl,mpc8323-qe-usb";
+				reg = <0x6c0 0x40 0x8b00 0x100>;
+				interrupts = <11>;
+				interrupt-parent = <&qeic>;
+				fsl,fullspeed-clock = "clk21";
+				gpios = <&qe_pio_b  2 0 /* USBOE */
+					 &qe_pio_b  3 0 /* USBTP */
+					 &qe_pio_b  8 0 /* USBTN */
+					 &qe_pio_b  9 0 /* USBRP */
+					 &qe_pio_b 11 0 /* USBRN */
+					 &qe_pio_e 20 0 /* SPEED */
+					 &qe_pio_e 21 1 /* POWER */>;
 			};
 
 			spi@4c0 {
-- 
1.5.6.3
