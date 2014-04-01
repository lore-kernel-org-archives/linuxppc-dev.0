Return-Path: <qiang.zhao@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 535A91400A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 18:58:24 +1100 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <broonie@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <B07421@freescale.com>
Subject: [PATCH] spi: add "spi-lsb-first" to devicetree
Date: Tue, 1 Apr 2014 15:55:31 +0800
Message-ID: <1396338931-10887-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, baruch@tkos.co.il, R63061@freescale.com,
 wangyuhang2014@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

add optional property devicetree for SPI slave nodes
into devicetree so that LSB mode can be enabled by devicetree.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 4 ++++
 drivers/spi/spi.c                                 | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index e5a4d1b..fdd9f15 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -55,11 +55,15 @@ contain the following properties.
     		chip select active high
 - spi-3wire       - (optional) Empty property indicating device requires
     		    3-wire mode.
+- spi-lsb-first   - (optional) Empty property indicating device requires
+		LSB first mode.
 - spi-tx-bus-width - (optional) The bus width(number of data wires) that
                       used for MOSI. Defaults to 1 if not present.
 - spi-rx-bus-width - (optional) The bus width(number of data wires) that
                       used for MISO. Defaults to 1 if not present.
 
+- spi-rx-bus-width - (optional) The bus width(number of data wires) that
+                      used for MISO. Defaults to 1 if not present.
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in SPI system transfered in 2 wires(DUAL) or 4 wires(QUAD).
 Now the value that spi-tx-bus-width and spi-rx-bus-width can receive is
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 23756b0..0a20a90 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1050,6 +1050,8 @@ static void of_register_spi_devices(struct spi_master *master)
 			spi->mode |= SPI_CS_HIGH;
 		if (of_find_property(nc, "spi-3wire", NULL))
 			spi->mode |= SPI_3WIRE;
+		if (of_find_property(nc, "spi-lsb-first", NULL))
+			spi->mode |= SPI_LSB_FIRST;
 
 		/* Device DUAL/QUAD mode */
 		if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
-- 
1.8.5
