Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id D6F1DDE69A
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 02:21:43 +1000 (EST)
Message-ID: <48AD9610.8090205@harris.com>
Date: Thu, 21 Aug 2008 12:21:36 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] I2C driver
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch enables building the I2C driver for 4xx chips.
Tested on a Sequoia board.  Comments invited.

Signed-off-by: Steven A. Falco <sfalco@harris.com>
---
 drivers/i2c/busses/Kconfig      |    7 +++++++
 drivers/i2c/busses/i2c-ibm_of.c |    5 ++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index e9f88fe..6444030 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -247,6 +247,13 @@ config I2C_PIIX4
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-piix4.
 
+config I2C_IBM_OF
+	tristate "IBM PPC 4xx open-firmware driver"
+	depends on 4xx
+	help
+	  Say Y here if you want to use the open-firmware driver for
+          IIC peripheral found on embedded IBM PPC 4xx based systems.
+
 config I2C_IBM_IIC
 	tristate "IBM PPC 4xx on-chip I2C interface"
 	depends on 4xx
diff --git a/drivers/i2c/busses/i2c-ibm_of.c b/drivers/i2c/busses/i2c-ibm_of.c
index 08440ab..caa895d 100644
--- a/drivers/i2c/busses/i2c-ibm_of.c
+++ b/drivers/i2c/busses/i2c-ibm_of.c
@@ -699,9 +699,7 @@ static int __init of_find_i2c_driver(struct device_node *node,
 	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
 		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
 			continue;
-		if (strlcpy(info->driver_name, i2c_devices[i].i2c_driver,
-			    KOBJ_NAME_LEN) >= KOBJ_NAME_LEN ||
-		    strlcpy(info->type, i2c_devices[i].i2c_type,
+		if (strlcpy(info->type, i2c_devices[i].i2c_type,
 			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
 			return -ENOMEM;
 		return 0;
@@ -906,6 +904,7 @@ static const struct of_device_id ibm_iic_match[] = {
 	{ .compatible = "ibm,iic-405ex", },
 	{ .compatible = "ibm,iic-405exr", },
 	{ .compatible = "ibm,iic-405gp", },
+	{ .compatible = "ibm,iic-440epx", },
 	{ .compatible = "ibm,iic-440gp", },
 	{ .compatible = "ibm,iic-440gpx", },
 	{ .compatible = "ibm,iic-440grx", },
-- 
1.5.5.1
