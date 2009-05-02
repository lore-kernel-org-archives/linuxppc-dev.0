Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 6852BDE11D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 12:17:01 +1000 (EST)
Date: Sat, 2 May 2009 06:16:59 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 6/6] powerpc/85xx: Add STMicro M25P40 serial flash support
	for MPC8569E-MDS
Message-ID: <20090502021659.GF18281@oksana.dev.rtsoft.ru>
References: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For serial flash support we need to:

- Add QE Par IO Bank E device tree node, a GPIO from this bank is
  used for SPI chip-select line;
- Add serial-flash node;
- Add proper module alias into of/base.c.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8569mds.dts |   26 +++++++++++++++++++++++---
 drivers/of/base.c                    |    1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index 975f2c5..e06ee92 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -260,10 +260,21 @@
 		};
 
 		par_io@e0100 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			reg = <0xe0100 0x100>;
+			ranges = <0x0 0xe0100 0x100>;
 			device_type = "par_io";
 			num-ports = <7>;
 
+			qe_pio_e: gpio-controller@80 {
+				#gpio-cells = <2>;
+				compatible = "fsl,mpc8569-qe-pario-bank",
+					     "fsl,mpc8323-qe-pario-bank";
+				reg = <0x80 0x18>;
+				gpio-controller;
+			};
+
 			pio1: ucc_pin@01 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
@@ -369,12 +380,21 @@
 		};
 
 		spi@4c0 {
-			cell-index = <0>;
-			compatible = "fsl,spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc8569-qe-spi", "fsl,spi";
 			reg = <0x4c0 0x40>;
+			cell-index = <0>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
-			mode = "cpu";
+			gpios = <&qe_pio_e 30 0>;
+			mode = "cpu-qe";
+
+			serial-flash@0 {
+				compatible = "stm,m25p40";
+				reg = <0>;
+				spi-max-frequency = <25000000>;
+			};
 		};
 
 		spi@500 {
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 41c5dfd..391f91c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -447,6 +447,7 @@ struct of_modalias_table {
 static struct of_modalias_table of_modalias_table[] = {
 	{ "fsl,mcu-mpc8349emitx", "mcu-mpc8349emitx" },
 	{ "mmc-spi-slot", "mmc_spi" },
+	{ "stm,m25p40", "m25p80" },
 };
 
 /**
-- 
1.6.2.2
