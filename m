Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 48EBCDDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 00:04:50 +1000 (EST)
Message-ID: <4666C084.2060909@ru.mvista.com>
Date: Wed, 06 Jun 2007 18:11:16 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Enable SPI controller support for Xilinx ML300 board
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-------- Original Message --------
> Subject: [PATCH] Simple driver for Xilinx SPI controler.
> Date: Wed, 06 Jun 2007 18:05:59 +0400
> From: Andrei Konovalov <akonovalov@ru.mvista.com>
> To: spi-devel-general@lists.sourceforge.net
> CC: linuxppc-embedded@ozlabs.org

<snip>

> The patch to enable SPI for Xilinx ML300 board (EDK reference design)
> will be sent to linuxppc-embedded list shortly.

Here it goes.

EDK 8.2 doesn't create a "Canonical Constant Name" for the
number of slave selects, so the definition of XPAR_SPI_0_NUM_SS_BITS
has been added to xparameters_ml300.h by hand.

Thanks,
Andrei

Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>
---
  arch/ppc/platforms/4xx/xilinx_ml300.c |   31 +++++++++++++++++++++++++
  arch/ppc/syslib/virtex_devices.c      |   40 +++++++++++++++++++++++++++++++++
  2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.c b/arch/ppc/platforms/4xx/xilinx_ml300.c
index 623aa92..e065c1b 100644
--- a/arch/ppc/platforms/4xx/xilinx_ml300.c
+++ b/arch/ppc/platforms/4xx/xilinx_ml300.c
@@ -16,6 +16,8 @@
  #include <linux/serial_core.h>
  #include <linux/serial_8250.h>
  #include <linux/serialP.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/eeprom.h>
  #include <asm/io.h>
  #include <asm/machdep.h>

@@ -122,6 +124,27 @@ static struct xilinxfb_platform_data xilinxfb_ml300_pdata = {
  	.screen_width_mm = 132,
  };

+#ifdef CONFIG_SPI_XILINX
+
+static struct spi_eeprom ml300_eeprom = {
+	.byte_len	= 2048,
+	.name		= "25LC160",
+	.page_size	= 16,
+	.flags		= EE_ADDR2,
+};
+
+static struct spi_board_info ml300_spi_board_info[] = {
+	{
+		.modalias	= "at25",
+		.platform_data  = &ml300_eeprom,	
+		.max_speed_hz	= 2 * 1000 * 1000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+	},
+};
+
+#endif /* CONFIG_SPI_XILINX */
+
  int __init virtex_device_fixup(struct platform_device *dev)
  {
  	if (strcmp(dev->name, "xilinxfb") == 0) {
@@ -130,6 +153,14 @@ int __init virtex_device_fixup(struct platform_device *dev)
  		dev->dev.platform_data = &xilinxfb_ml300_pdata;
  		return 0;
  	}
+#ifdef CONFIG_SPI_XILINX
+	if (strcmp(dev->name, "xspi") == 0) {
+		if (dev->id != 0) /* paranoic */
+			return 1;
+		spi_register_board_info(ml300_spi_board_info,
+					ARRAY_SIZE(ml300_spi_board_info));
+	}
  	return 0;
+#endif /* CONFIG_SPI_XILINX */
  }

diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
index 56cbdd6..4a2d106 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -161,6 +161,41 @@ DEFINE_XPAR_TEMAC_PDATA(1);
  	}, \
  }

+/*
+ * SPI platform data
+ */
+#define DEFINE_XPAR_SPI_PDATA(num) \
+static struct xspi_platform_data xspi_##num##_pdata = { \
+	.bus_num = XPAR_SPI_##num##_DEVICE_ID, \
+	.num_chipselect = XPAR_SPI_##num##_NUM_SS_BITS, \
+}
+
+#ifdef XPAR_SPI_0_BASEADDR
+DEFINE_XPAR_SPI_PDATA(0);
+#endif /* XPAR_SPI_0_BASEADDR */
+
+/*
+ * SPI: shortcut macro for single instance
+ */
+#define XPAR_SPI(num) { \
+	.name = "xspi", \
+	.id = XPAR_SPI_##num##_DEVICE_ID, \
+	.dev.platform_data = &xspi_##num##_pdata, \
+	.num_resources = 2, \
+	.resource = (struct resource[]) { \
+		{ \
+			.start = XPAR_SPI_##num##_BASEADDR, \
+			.end = XPAR_SPI_##num##_HIGHADDR, \
+			.flags = IORESOURCE_MEM, \
+		}, \
+		{ \
+			.start = XPAR_INTC_0_SPI_##num##_VEC_ID, \
+			.end = XPAR_INTC_0_SPI_##num##_VEC_ID, \
+			.flags = IORESOURCE_IRQ, \
+		}, \
+	}, \
+}
+
  struct platform_device virtex_platform_devices[] = {
  	/* UARTLITE instances */
  #if defined(XPAR_UARTLITE_0_BASEADDR)
@@ -220,6 +255,11 @@ struct platform_device virtex_platform_devices[] = {
  #ifdef XPAR_TEMAC_1_BASEADDR
  	XPAR_TEMAC(1),
  #endif
+
+	/* SPI instances */
+#ifdef XPAR_SPI_0_BASEADDR
+	XPAR_SPI(0),
+#endif /* XPAR_SPI_0_BASEADDR */
  };

  /* Early serial support functions */
-- 
1.5.1.1
