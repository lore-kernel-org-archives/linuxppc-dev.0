Return-Path: <Mingkai.Hu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 73F94DDF15
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 13:19:17 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mBI2J238001034
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 19:19:13 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id mBI2IvdF018275
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 20:18:58 -0600 (CST)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH v1] Add support for getting device platform data to I2C device
Date: Thu, 18 Dec 2008 10:14:11 +0800
Message-Id: <1229566451-29411-1-git-send-email-Mingkai.hu@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org,
	Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is no standard way of getting device platform data from
dts file to the I2C device when it's probed. This patch adds
a function pointer to the of_modalias_table to get such bindings
properties into device's platform data.

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
Thanks to Scott Wood's suggestions.

 drivers/of/base.c   |    9 ++++++++-
 drivers/of/of_i2c.c |    3 ++-
 drivers/of/of_spi.c |    2 +-
 include/linux/of.h  |    3 ++-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ad8ac1a..38ab2a2 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -408,6 +408,7 @@ EXPORT_SYMBOL(of_find_matching_node);
 struct of_modalias_table {
 	char *of_device;
 	char *modalias;
+	const void *(*binder)(struct device_node *node);
 };
 static struct of_modalias_table of_modalias_table[] = {
 	/* Empty for now; add entries as needed */
@@ -418,6 +419,7 @@ static struct of_modalias_table of_modalias_table[] = {
  * @node:	pointer to a device tree node
  * @modalias:	Pointer to buffer that modalias value will be copied into
  * @len:	Length of modalias value
+ * @platform_data: pointer to device's platform specific data
  *
  * Based on the value of the compatible property, this routine will determine
  * an appropriate modalias value for a particular device tree node.  Three
@@ -430,7 +432,8 @@ static struct of_modalias_table of_modalias_table[] = {
  *
  * This routine returns 0 on success
  */
-int of_modalias_node(struct device_node *node, char *modalias, int len)
+int of_modalias_node(struct device_node *node, char *modalias, int len,
+	const void **platform_data)
 {
 	int i, cplen;
 	const char *compatible;
@@ -442,6 +445,10 @@ int of_modalias_node(struct device_node *node, char *modalias, int len)
 		if (!of_device_is_compatible(node, compatible))
 			continue;
 		strlcpy(modalias, of_modalias_table[i].modalias, len);
+
+		if (platform_data && of_modalias_table[i].binder)
+			*platform_data = of_modalias_table[i].binder(node);
+
 		return 0;
 	}
 
diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 6a98dc8..38d9faf 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -27,7 +27,8 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 		const u32 *addr;
 		int len;
 
-		if (of_modalias_node(node, info.type, sizeof(info.type)) < 0)
+		if (of_modalias_node(node, info.type, sizeof(info.type),
+			(const void **)&info.platform_data) < 0)
 			continue;
 
 		addr = of_get_property(node, "reg", &len);
diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
index b01eec0..0dcd52c 100644
--- a/drivers/of/of_spi.c
+++ b/drivers/of/of_spi.c
@@ -39,7 +39,7 @@ void of_register_spi_devices(struct spi_master *master, struct device_node *np)
 
 		/* Select device driver */
 		if (of_modalias_node(nc, spi->modalias,
-				     sizeof(spi->modalias)) < 0) {
+				     sizeof(spi->modalias), NULL) < 0) {
 			dev_err(&master->dev, "cannot find modalias for %s\n",
 				nc->full_name);
 			spi_dev_put(spi);
diff --git a/include/linux/of.h b/include/linux/of.h
index 79886ad..ed4c269 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -70,6 +70,7 @@ extern int of_n_addr_cells(struct device_node *np);
 extern int of_n_size_cells(struct device_node *np);
 extern const struct of_device_id *of_match_node(
 	const struct of_device_id *matches, const struct device_node *node);
-extern int of_modalias_node(struct device_node *node, char *modalias, int len);
+extern int of_modalias_node(struct device_node *node, char *modalias, int len,
+	const void **platform_data);
 
 #endif /* _LINUX_OF_H */
-- 
1.5.4
