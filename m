Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.224])
	by ozlabs.org (Postfix) with ESMTP id C47A7DDF59
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 17:33:15 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d11so224347qbd.39
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 00:33:13 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v3 1/4] of: adapt of_find_i2c_driver() to be usable by SPI also
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org,
	jonsmirl@gmail.com
Date: Fri, 25 Jul 2008 03:33:11 -0400
Message-ID: <20080725073311.8485.16226.stgit@trillian.secretlab.ca>
In-Reply-To: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

SPI has a similar problem as I2C in that it needs to determine an
appropriate modalias value for each device node.  This patch adapts
the of_i2c of_find_i2c_driver() function to be usable by of_spi also.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/of/base.c   |   88 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/of/of_i2c.c |   64 ++-----------------------------------
 include/linux/of.h  |    1 +
 3 files changed, 92 insertions(+), 61 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 23ffb7c..ad8ac1a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -385,3 +385,91 @@ struct device_node *of_find_matching_node(struct device_node *from,
 	return np;
 }
 EXPORT_SYMBOL(of_find_matching_node);
+
+/**
+ * of_modalias_table: Table of explicit compatible ==> modalias mappings
+ *
+ * This table allows particulare compatible property values to be mapped
+ * to modalias strings.  This is useful for busses which do not directly
+ * understand the OF device tree but are populated based on data contained
+ * within the device tree.  SPI and I2C are the two current users of this
+ * table.
+ *
+ * In most cases, devices do not need to be listed in this table because
+ * the modalias value can be derived directly from the compatible table.
+ * However, if for any reason a value cannot be derived, then this table
+ * provides a method to override the implicit derivation.
+ *
+ * At the moment, a single table is used for all bus types because it is
+ * assumed that the data size is small and that the compatible values
+ * should already be distinct enough to differentiate between SPI, I2C
+ * and other devices.
+ */
+struct of_modalias_table {
+	char *of_device;
+	char *modalias;
+};
+static struct of_modalias_table of_modalias_table[] = {
+	/* Empty for now; add entries as needed */
+};
+
+/**
+ * of_modalias_node - Lookup appropriate modalias for a device node
+ * @node:	pointer to a device tree node
+ * @modalias:	Pointer to buffer that modalias value will be copied into
+ * @len:	Length of modalias value
+ *
+ * Based on the value of the compatible property, this routine will determine
+ * an appropriate modalias value for a particular device tree node.  Three
+ * separate methods are used to derive a modalias value.
+ *
+ * First method is to lookup the compatible value in of_modalias_table.
+ * Second is to look for a "linux,<modalias>" entry in the compatible list
+ * and used that for modalias.  Third is to strip off the manufacturer
+ * prefix from the first compatible entry and use the remainder as modalias
+ *
+ * This routine returns 0 on success
+ */
+int of_modalias_node(struct device_node *node, char *modalias, int len)
+{
+	int i, cplen;
+	const char *compatible;
+	const char *p;
+
+	/* 1. search for exception list entry */
+	for (i = 0; i < ARRAY_SIZE(of_modalias_table); i++) {
+		compatible = of_modalias_table[i].of_device;
+		if (!of_device_is_compatible(node, compatible))
+			continue;
+		strlcpy(modalias, of_modalias_table[i].modalias, len);
+		return 0;
+	}
+
+	compatible = of_get_property(node, "compatible", &cplen);
+	if (!compatible)
+		return -ENODEV;
+
+	/* 2. search for linux,<modalias> entry */
+	p = compatible;
+	while (cplen > 0) {
+		if (!strncmp(p, "linux,", 6)) {
+			p += 6;
+			strlcpy(modalias, p, len);
+			return 0;
+		}
+
+		i = strlen(p) + 1;
+		p += i;
+		cplen -= i;
+	}
+
+	/* 3. take first compatible entry and strip manufacturer */
+	p = strchr(compatible, ',');
+	if (!p)
+		return -ENODEV;
+	p++;
+	strlcpy(modalias, p, len);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_modalias_node);
+
diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 344e1b0..6a98dc8 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -16,62 +16,6 @@
 #include <linux/of_i2c.h>
 #include <linux/module.h>
 
-struct i2c_driver_device {
-	char    *of_device;
-	char    *i2c_type;
-};
-
-static struct i2c_driver_device i2c_devices[] = {
-};
-
-static int of_find_i2c_driver(struct device_node *node,
-			      struct i2c_board_info *info)
-{
-	int i, cplen;
-	const char *compatible;
-	const char *p;
-
-	/* 1. search for exception list entry */
-	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
-		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
-			continue;
-		if (strlcpy(info->type, i2c_devices[i].i2c_type,
-			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
-			return -ENOMEM;
-
-		return 0;
-	}
-
-	compatible = of_get_property(node, "compatible", &cplen);
-	if (!compatible)
-		return -ENODEV;
-
-	/* 2. search for linux,<i2c-type> entry */
-	p = compatible;
-	while (cplen > 0) {
-		if (!strncmp(p, "linux,", 6)) {
-			p += 6;
-			if (strlcpy(info->type, p,
-				    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
-				return -ENOMEM;
-			return 0;
-		}
-
-		i = strlen(p) + 1;
-		p += i;
-		cplen -= i;
-	}
-
-	/* 3. take fist compatible entry and strip manufacturer */
-	p = strchr(compatible, ',');
-	if (!p)
-		return -ENODEV;
-	p++;
-	if (strlcpy(info->type, p, I2C_NAME_SIZE) >= I2C_NAME_SIZE)
-		return -ENOMEM;
-	return 0;
-}
-
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node)
 {
@@ -83,6 +27,9 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 		const u32 *addr;
 		int len;
 
+		if (of_modalias_node(node, info.type, sizeof(info.type)) < 0)
+			continue;
+
 		addr = of_get_property(node, "reg", &len);
 		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
 			printk(KERN_ERR
@@ -92,11 +39,6 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 
 		info.irq = irq_of_parse_and_map(node, 0);
 
-		if (of_find_i2c_driver(node, &info) < 0) {
-			irq_dispose_mapping(info.irq);
-			continue;
-		}
-
 		info.addr = *addr;
 
 		request_module(info.type);
diff --git a/include/linux/of.h b/include/linux/of.h
index 59a61bd..79886ad 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -70,5 +70,6 @@ extern int of_n_addr_cells(struct device_node *np);
 extern int of_n_size_cells(struct device_node *np);
 extern const struct of_device_id *of_match_node(
 	const struct of_device_id *matches, const struct device_node *node);
+extern int of_modalias_node(struct device_node *node, char *modalias, int len);
 
 #endif /* _LINUX_OF_H */
