Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 27330DE07C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 11:03:17 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so629166wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jul 2008 18:03:17 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 4/5] spi: Add OF binding support for SPI busses
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Date: Wed, 02 Jul 2008 19:03:13 -0600
Message-ID: <20080703010313.26187.99119.stgit@trillian.secretlab.ca>
In-Reply-To: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
Cc: david-b@pacbell.net, fabrizio.garetto@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch adds support for populating an SPI bus based on data in the
OF device tree.  This is useful for powerpc platforms which use the
device tree instead of discrete code for describing platform layout.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/of/Kconfig     |    6 +++
 drivers/of/Makefile    |    1 +
 drivers/of/of_spi.c    |   88 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_spi.h |   18 ++++++++++
 4 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 3a7a11a..edd6e92 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -13,3 +13,9 @@ config OF_I2C
 	depends on PPC_OF && I2C
 	help
 	  OpenFirmware I2C accessors
+
+config OF_SPI
+	def_tristate SPI
+	depends on OF && PPC_OF && SPI
+	help
+	  OpenFirmware SPI accessors
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 548772e..4c3c6f8 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -2,3 +2,4 @@ obj-y = base.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
 obj-$(CONFIG_OF_GPIO)   += gpio.o
 obj-$(CONFIG_OF_I2C)	+= of_i2c.o
+obj-$(CONFIG_OF_SPI)	+= of_spi.o
diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
new file mode 100644
index 0000000..ed0c807
--- /dev/null
+++ b/drivers/of/of_spi.c
@@ -0,0 +1,88 @@
+/*
+ * SPI OF support routines
+ * Copyright (C) 2008 Secret Lab Technologies Ltd.
+ *
+ * Support routines for deriving SPI device attachments from the device
+ * tree.
+ */
+
+#include <linux/of.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/of_spi.h>
+
+/**
+ * of_register_spi_devices - Register child devices onto the SPI bus
+ * @master:	Pointer to spi_master device
+ * @np:		parent node of SPI device nodes
+ *
+ * Registers an spi_device for each child node of 'np' which has a 'reg'
+ * property.
+ */
+void of_register_spi_devices(struct spi_master *master, struct device_node *np)
+{
+	struct spi_device *spi;
+	struct device_node *nc;
+	const u32 *prop;
+	const char *sprop;
+	int rc;
+	int len;
+
+	for_each_child_of_node(np, nc) {
+		/* Alloc an spi_device */
+		spi = spi_alloc_device(master);
+		if (!spi) {
+			dev_err(&master->dev, "spi_device alloc error for %s\n",
+				nc->full_name);
+			continue;
+		}
+
+		/* Device address */
+		prop = of_get_property(nc, "reg", &len);
+		if (!prop || len < sizeof(*prop)) {
+			dev_err(&master->dev, "%s has no 'reg' property\n",
+				nc->full_name);
+			continue;
+		}
+		spi->chip_select = *prop;
+
+		/* Mode (clock phase/polarity/etc.) */
+		if (of_find_property(nc, "spi,cpha", NULL))
+			spi->mode |= SPI_CPHA;
+		if (of_find_property(nc, "spi,cpol", NULL))
+			spi->mode |= SPI_CPOL;
+
+		/* Device speed */
+		prop = of_get_property(nc, "max-speed", &len);
+		if (!prop || len < sizeof(*prop)) {
+			dev_err(&master->dev, "%s has no 'max-speed' property\n",
+				nc->full_name);
+			continue;
+		}
+		spi->max_speed_hz = *prop;
+
+		/* IRQ */
+		spi->irq = irq_of_parse_and_map(nc, 0);
+
+		/* Select device driver */
+		sprop = of_get_property(nc, "linux,modalias", &len);
+		if (sprop && len > 0)
+			strncpy(spi->modalias, sprop, KOBJ_NAME_LEN);
+		else
+			strncpy(spi->modalias, "spidev", KOBJ_NAME_LEN);
+
+		/* Store a pointer to the node in the device structure */
+		of_node_get(nc);
+		spi->dev.archdata.of_node = nc;
+
+		/* Register the new device */
+		rc = spi_add_device(spi);
+		if (rc) {
+			dev_err(&master->dev, "spi_device register error %s\n",
+				nc->full_name);
+			spi_dev_put(spi);
+		}
+
+	}
+}
+EXPORT_SYMBOL(of_register_spi_devices);
diff --git a/include/linux/of_spi.h b/include/linux/of_spi.h
new file mode 100644
index 0000000..5f71ee8
--- /dev/null
+++ b/include/linux/of_spi.h
@@ -0,0 +1,18 @@
+/*
+ * OpenFirmware SPI support routines
+ * Copyright (C) 2008 Secret Lab Technologies Ltd.
+ *
+ * Support routines for deriving SPI device attachments from the device
+ * tree.
+ */
+
+#ifndef __LINUX_OF_SPI_H
+#define __LINUX_OF_SPI_H
+
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+extern void of_register_spi_devices(struct spi_master *master,
+				    struct device_node *np);
+
+#endif /* __LINUX_OF_SPI */
