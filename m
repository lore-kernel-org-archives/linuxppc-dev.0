Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EAC4BDDF17
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 07:10:44 +1100 (EST)
Date: Fri, 5 Dec 2008 23:10:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 7/7] powerpc/83xx: Add mmc-spi support via the device tree
	for MPC8323E-RDB
Message-ID: <20081205201043.GG19758@oksana.dev.rtsoft.ru>
References: <20081205200936.GA19137@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081205200936.GA19137@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

- Add gpio-controller node to manage QE GPIO Bank D;
- Add mmc-spi node;
- Modify board file so that it won't use legacy SPI support with the new
  device trees.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc832x_rdb.dts     |   24 ++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    6 ++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index dea3091..4319bd7 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -152,10 +152,21 @@
 		};
 
 		par_io@1400 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			reg = <0x1400 0x100>;
+			ranges = <3 0x1448 0x18>;
+			compatible = "fsl,mpc8323-qe-pario";
 			device_type = "par_io";
 			num-ports = <7>;
 
+			qe_pio_d: gpio-controller@1448 {
+				#gpio-cells = <2>;
+				compatible = "fsl,mpc8323-qe-pario-bank";
+				reg = <3 0x18>;
+				gpio-controller;
+			};
+
 			ucc2pio:ucc_pin@02 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
@@ -225,12 +236,25 @@
 		};
 
 		spi@4c0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl,spi";
 			reg = <0x4c0 0x40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
+			gpios = <&qe_pio_d 13 0>;
 			mode = "cpu-qe";
+
+			mmc-slot@0 {
+				compatible = "fsl,mpc8323rdb-mmc-slot",
+					     "mmc-spi-slot";
+				reg = <0>;
+				gpios = <&qe_pio_d 14 1
+					 &qe_pio_d 15 0>;
+				voltage-ranges = <3300 3300>;
+				spi-max-frequency = <50000000>;
+			};
 		};
 
 		spi@500 {
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 17abbd2..567ded7 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -175,6 +175,12 @@ static int __init mpc832x_spi_init(void)
 	par_io_config_pin(3, 14, 2, 0, 0, 0); /* SD_INSERT, I */
 	par_io_config_pin(3, 15, 2, 0, 0, 0); /* SD_PROTECT,I */
 
+	/*
+	 * Don't bother with legacy stuff when device tree contains
+	 * mmc-spi-slot node.
+	 */
+	if (of_find_compatible_node(NULL, NULL, "mmc-spi-slot"))
+		return 0;
 	return fsl_spi_init(&mpc832x_spi_boardinfo, 1, mpc83xx_spi_cs_control);
 }
 machine_device_initcall(mpc832x_rdb, mpc832x_spi_init);
-- 
1.5.6.5
