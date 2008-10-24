Return-Path: <weo@reccoware.de>
Received: from bes.recconet.de (bes.recconet.de [87.106.167.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59A77DDDE0
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 07:09:07 +1100 (EST)
Subject: [PATCH] Added gpios property for SPI slaves
From: Wolfgang Ocker <weo@reccoware.de>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 24 Oct 2008 22:08:59 +0200
Message-Id: <1224878939.4039.22.camel@galileo.recco.de>
Mime-Version: 1.0
Cc: Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

SPI slave devices require the specification of a chip select address.
This patch allows that specification using the gpios property. The reg
property remains supported.

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---

--- linux-2.6.27.3/drivers/of/of_spi.c.of_spi_gpio	2008-10-22 23:38:01.000000000 +0200
+++ linux-2.6.27.3/drivers/of/of_spi.c.of_spi_cshigh	2008-10-24 21:36:39.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/spi/spi.h>
 #include <linux/of_spi.h>
+#include <linux/of_gpio.h>
 
 /**
  * of_register_spi_devices - Register child devices onto the SPI bus
@@ -24,6 +25,7 @@ void of_register_spi_devices(struct spi_
 	struct spi_device *spi;
 	struct device_node *nc;
 	const u32 *prop;
+	int cs_addr;
 	int rc;
 	int len;
 
@@ -48,13 +50,20 @@ void of_register_spi_devices(struct spi_
 
 		/* Device address */
 		prop = of_get_property(nc, "reg", &len);
-		if (!prop || len < sizeof(*prop)) {
-			dev_err(&master->dev, "%s has no 'reg' property\n",
-				nc->full_name);
-			spi_dev_put(spi);
-			continue;
+		if (prop && len >= sizeof(*prop)) {
+			cs_addr = *prop;
+		}
+		else {
+			cs_addr = of_get_gpio(nc, 0);
+			if (cs_addr < 0) {
+				dev_err(&master->dev, 
+					"%s has no 'reg' nor gpios property\n",
+					nc->full_name);
+				spi_dev_put(spi);
+				continue;
+			}
 		}
-		spi->chip_select = *prop;
+		spi->chip_select = cs_addr;
 
 		/* Mode (clock phase/polarity/etc.) */
 		if (of_find_property(nc, "spi-cpha", NULL))
--- linux-2.6.27.3/Documentation/powerpc/booting-without-of.txt.of_spi_gpio	2008-10-22 23:38:01.000000000 +0200
+++ linux-2.6.27.3/Documentation/powerpc/booting-without-of.txt.of_spi_cshigh	2008-10-24 21:57:16.000000000 +0200
@@ -1909,7 +1909,9 @@ platforms are moved over to use the flat
 
     SPI slave nodes must be children of the SPI master node and can
     contain the following properties.
-    - reg             - (required) chip select address of device.
+    - reg             - chip select address of device.
+    - gpios           - chip select address of device (alternatively).
+			one of reg and gpios is required.
     - compatible      - (required) name of SPI device following generic names
 			recommended practice
     - spi-max-frequency - (required) Maximum SPI clocking speed of device in Hz
@@ -1936,7 +1938,7 @@ platforms are moved over to use the flat
 			codec@1 {
 				compatible = "ti,tlv320aic26";
 				spi-max-frequency = <100000>;
-				reg = <1>;
+				gpios = <&GPIO1 3>;
 			};
 		};
 
