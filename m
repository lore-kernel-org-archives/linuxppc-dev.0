Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 4F1A7DE6DC
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 05:36:21 +1000 (EST)
Received: from pd2mr2so.prod.shaw.ca
	(pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0K0Z003AF7SHRZ50@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 16 May 2008 13:36:17 -0600 (MDT)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
	by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0K0Z008ZB7SE9M20@pd2mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 16 May 2008 13:36:17 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0K0Z00FTL7SD0O30@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 16 May 2008 13:36:13 -0600 (MDT)
Date: Fri, 16 May 2008 13:36:13 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/4] spi: Add OF binding support for SPI busses
In-reply-to: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Message-id: <20080516193613.28030.13950.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
Cc: fabrizio.garetto@gmail.com
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

 Documentation/powerpc/booting-without-of.txt |   61 ++++++++++++++++++
 drivers/spi/Kconfig                          |    4 +
 drivers/spi/Makefile                         |    1 
 drivers/spi/spi_of.c                         |   86 ++++++++++++++++++++++++++
 include/linux/spi/spi_of.h                   |   18 +++++
 5 files changed, 170 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 1d2a772..452c242 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -58,6 +58,7 @@ Table of Contents
       o) Xilinx IP cores
       p) Freescale Synchronous Serial Interface
 	  q) USB EHCI controllers
+      s) SPI busses
 
   VII - Marvell Discovery mv64[345]6x System Controller chips
     1) The /system-controller node
@@ -2870,6 +2871,66 @@ platforms are moved over to use the flattened-device-tree model.
 		reg = <0xe8000000 32>;
 	};
 
+    s) SPI (Serial Peripheral Interface) busses
+
+    SPI busses can be described with a node for the SPI master device
+    and a set of child nodes for each SPI slave on the bus.  For this
+    discussion, it is assumed that the system's SPI controller is in
+    SPI master mode.  This binding does not describe SPI controllers
+    in slave mode.
+
+    The SPI master node requires the following properties:
+    - #address-cells  - number of cells required to define a chip select
+			address on the SPI bus.
+    - #size-cells     - should be zero.
+    - compatible      - name of SPI bus controller following generic names
+			recommended practice.
+    No other properties are required in the spi bus node.  It is assumed
+    that a driver for an SPI bus device will understand that it is an SPI bus.
+    However, the binding does not attempt to define the specific method for
+    assigning chip select numbers.  Since SPI chip select configuration is
+    flexible and non-standardized, it is left out of this binding with the
+    assumption that board specific platform code will be used to manage
+    chip selects.  Individual drivers can define additional properties to
+    support describing the chip select layout.
+
+    SPI slave nodes must be children of the spi master node and can
+    contain the following properties.
+    - reg             - (required) chip select address of device.
+    - compatible      - (required) name of SPI device following generic names
+			recommended practice
+    - max-speed       - (optional) Maximum SPI clocking speed of device in Hz
+    - spi,cpol        - (optional) Device requires inverse clock polarity
+    - spi,cpha        - (optional) Device requires shifted clock phase
+    - linux,modalias  - (optional, Linux specific) Force binding of SPI device
+			to a particular spi_device driver.  Useful for changing
+			driver binding between spidev and a kernel spi driver.
+
+    SPI example for an MPC5200 SPI bus:
+		spi@f00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
+			reg = <0xf00 0x20>;
+			interrupts = <2 13 0 2 14 0>;
+			interrupt-parent = <&mpc5200_pic>;
+
+			ethernet-switch@0 {
+				compatible = "micrel,ks8995m";
+				linux,modalias = "ks8995";
+				max-speed = <1000000>;
+				reg = <0>;
+			};
+
+			codec@1 {
+				compatible = "ti,tlv320aic26";
+				max-speed = <100000>;
+				reg = <1>;
+			};
+		};
+
+
+
 VII - Marvell Discovery mv64[345]6x System Controller chips
 ===========================================================
 
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 66ec5d8..12c35da 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -49,6 +49,10 @@ config SPI_MASTER
 	  controller and the protocol drivers for the SPI slave chips
 	  that are connected.
 
+# OpenFirmware device tree support
+config SPI_MASTER_OF
+	bool
+
 comment "SPI Master Controller Drivers"
 	depends on SPI_MASTER
 
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 7fca043..29c592f 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -9,6 +9,7 @@ endif
 # small core, mostly translating board-specific
 # config declarations into driver model code
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
+obj-$(CONFIG_SPI_MASTER_OF)		+= spi_of.o
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_ATMEL)			+= atmel_spi.o
diff --git a/drivers/spi/spi_of.c b/drivers/spi/spi_of.c
new file mode 100644
index 0000000..b5ae434
--- /dev/null
+++ b/drivers/spi/spi_of.c
@@ -0,0 +1,86 @@
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
+#include <linux/spi/spi_of.h>
+
+/**
+ * spi_of_register_devices - Register child devices onto the SPI bus
+ * @master:	Pointer to spi_master device
+ * @np:		parent node of SPI device nodes
+ *
+ * Registers an spi_device for each child node of 'np' which has a 'reg'
+ * property.
+ */
+void spi_of_register_devices(struct spi_master *master, struct device_node *np)
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
+				np->full_name);
+			continue;
+		}
+
+		/* Device address */
+		prop = of_get_property(nc, "reg", &len);
+		if (!prop || len < sizeof(*prop)) {
+			dev_err(&master->dev, "%s has no 'reg' property\n",
+				np->full_name);
+			continue;
+		}
+		spi->chip_select = *prop;
+
+		/* Mode (clock phase/polarity/etc. */
+		if (of_find_property(nc, "spi,cpha", NULL))
+			spi->mode |= SPI_CPHA;
+		if (of_find_property(nc, "spi,cpol", NULL))
+			spi->mode |= SPI_CPOL;
+
+		/* Device speed */
+		prop = of_get_property(nc, "max-speed", &len);
+		if (prop && len >= sizeof(*prop))
+			spi->max_speed_hz = *prop;
+		else
+			spi->max_speed_hz = 100000;
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
+		rc = spi_register_device(spi);
+		if (rc) {
+			dev_err(&master->dev, "spi_device register error %s\n",
+				np->full_name);
+			spi_device_release(spi);
+		}
+
+	}
+}
+EXPORT_SYMBOL(spi_of_register_devices);
diff --git a/include/linux/spi/spi_of.h b/include/linux/spi/spi_of.h
new file mode 100644
index 0000000..c943f98
--- /dev/null
+++ b/include/linux/spi/spi_of.h
@@ -0,0 +1,18 @@
+/*
+ * SPI OF support routines
+ * Copyright (C) 2008 Secret Lab Technologies Ltd.
+ *
+ * Support routines for deriving SPI device attachments from the device
+ * tree.
+ */
+
+#ifndef __LINUX_SPI_OF_H
+#define __LINUX_SPI_OF_H
+
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+extern void spi_of_register_devices(struct spi_master *master,
+				    struct device_node *np);
+
+#endif /* __LINUX_SPI_OF */
