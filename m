Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF670B7112
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Nov 2010 04:25:40 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: devicetree-discuss@ozlabs.org
Subject: [PATCH 1/2] misc: at24: parse OF-data, too
Date: Mon, 15 Nov 2010 18:25:15 +0100
Message-Id: <1289841916-3825-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Information about the pagesize and read-only-status may also come from
the devicetree. Parse this data, too, and act accordingly. While we are
here, change the initialization printout a bit. write_max is useful to
know to detect performance bottlenecks, the rest is superfluous.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

Grant: As mentioned at ELCE10, I could pretty much respin this old approach I
tried roughly a year ago (just with archdata then). If the approach and docs
are good, I am fine with the patches entering via one of your trees.

 Documentation/powerpc/dts-bindings/eeprom.txt |   28 ++++++++++++++++++++++
 drivers/misc/eeprom/at24.c                    |   33 ++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/eeprom.txt

diff --git a/Documentation/powerpc/dts-bindings/eeprom.txt b/Documentation/powerpc/dts-bindings/eeprom.txt
new file mode 100644
index 0000000..4342c10
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/eeprom.txt
@@ -0,0 +1,28 @@
+EEPROMs (I2C)
+
+Required properties:
+
+  - compatible : should be "<manufacturer>,<type>"
+		 If there is no specific driver for <manufacturer>, a generic
+		 driver based on <type> is selected. Possible types are:
+		 24c00, 24c01, 24c02, 24c04, 24c08, 24c16, 24c32, 24c64,
+		 24c128, 24c256, 24c512, 24c1024, spd
+
+  - reg : the I2C address of the EEPROM
+
+Optional properties:
+
+  - pagesize : the length of the pagesize for writing. Please consult the
+               manual of your device, that value varies a lot. A wrong value
+	       may result in data loss! If not specified, a safety value of
+	       '1' is used which will be very slow.
+
+  - read-only: this parameterless property disables writes to the eeprom
+
+Example:
+
+eeprom@52 {
+	compatible = "atmel,24c32";
+	reg = <0x52>;
+	pagesize = <32>;
+};
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 559b0b3..aaf16cb 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -20,6 +20,7 @@
 #include <linux/log2.h>
 #include <linux/bitops.h>
 #include <linux/jiffies.h>
+#include <linux/of.h>
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
 
@@ -457,6 +458,27 @@ static ssize_t at24_macc_write(struct memory_accessor *macc, const char *buf,
 
 /*-------------------------------------------------------------------------*/
 
+#ifdef CONFIG_OF
+static void at24_get_ofdata(struct i2c_client *client,
+		struct at24_platform_data *chip)
+{
+	const u32 *val;
+	struct device_node *node = client->dev.of_node;
+
+	if (node) {
+		if (of_get_property(node, "read-only", NULL))
+			chip->flags |= AT24_FLAG_READONLY;
+		val = of_get_property(node, "pagesize", NULL);
+		if (val)
+			chip->page_size = *val;
+	}
+}
+#else
+static void at24_get_ofdata(struct i2c_client *client,
+		struct at24_platform_data *chip)
+{ }
+#endif /* CONFIG_OF */
+
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct at24_platform_data chip;
@@ -485,6 +507,9 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		 */
 		chip.page_size = 1;
 
+		/* update chipdata if OF is present */
+		at24_get_ofdata(client, &chip);
+
 		chip.setup = NULL;
 		chip.context = NULL;
 	}
@@ -597,19 +622,15 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	i2c_set_clientdata(client, at24);
 
-	dev_info(&client->dev, "%zu byte %s EEPROM %s\n",
+	dev_info(&client->dev, "%zu byte %s EEPROM, %s, %u bytes/write\n",
 		at24->bin.size, client->name,
-		writable ? "(writable)" : "(read-only)");
+		writable ? "writable" : "read-only", at24->write_max);
 	if (use_smbus == I2C_SMBUS_WORD_DATA ||
 	    use_smbus == I2C_SMBUS_BYTE_DATA) {
 		dev_notice(&client->dev, "Falling back to %s reads, "
 			   "performance will suffer\n", use_smbus ==
 			   I2C_SMBUS_WORD_DATA ? "word" : "byte");
 	}
-	dev_dbg(&client->dev,
-		"page_size %d, num_addresses %d, write_max %d, use_smbus %d\n",
-		chip.page_size, num_addresses,
-		at24->write_max, use_smbus);
 
 	/* export data to kernel code */
 	if (chip.setup)
-- 
1.7.2.3
