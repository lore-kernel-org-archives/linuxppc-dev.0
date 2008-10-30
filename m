Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7A22BDDE08
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 06:56:32 +1100 (EST)
Date: Thu, 30 Oct 2008 22:56:30 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc: Add mmc-spi-slot bindings
Message-ID: <20081030195630.GA13640@oksana.dev.rtsoft.ru>
References: <20081030195546.GA30645@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081030195546.GA30645@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The bindings describes a case where MMC/SD/SDIO slot directly connected
to a SPI bus. Such setups are widely used on embedded PowerPC boards.

The patch also adds the mmc-spi-slot entry to the OpenFirmware modalias
table.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 .../powerpc/dts-bindings/mmc-spi-slot.txt          |   23 ++++++++++++++++++++
 drivers/of/base.c                                  |    1 +
 2 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/mmc-spi-slot.txt

diff --git a/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt b/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt
new file mode 100644
index 0000000..c39ac28
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt
@@ -0,0 +1,23 @@
+MMC/SD/SDIO slot directly connected to a SPI bus
+
+Required properties:
+- compatible : should be "mmc-spi-slot".
+- reg : should specify SPI address (chip-select number).
+- spi-max-frequency : maximum frequency for this device (Hz).
+- voltage-ranges : two cells are required, first cell specifies minimum
+  slot voltage (mV), second cell specifies maximum slot voltage (mV).
+  Several ranges could be specified.
+- gpios : (optional) may specify GPIOs in this order: Card-Detect GPIO,
+  Write-Protect GPIO.
+
+Example:
+
+	mmc-slot@0 {
+		compatible = "fsl,mpc8323rdb-mmc-slot",
+			     "mmc-spi-slot";
+		reg = <0>;
+		gpios = <&qe_pio_d 14 1
+			 &qe_pio_d 15 0>;
+		voltage-ranges = <3300 3300>;
+		spi-max-frequency = <50000000>;
+	};
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7c79e94..c6797ca 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -411,6 +411,7 @@ struct of_modalias_table {
 };
 static struct of_modalias_table of_modalias_table[] = {
 	{ "fsl,mcu-mpc8349emitx", "mcu-mpc8349emitx" },
+	{ "mmc-spi-slot", "mmc_spi" },
 };
 
 /**
-- 
1.5.6.3
