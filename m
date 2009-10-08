Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 1BE66B7B6F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 01:04:53 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] misc/at24: add experimental OF support for the generic eeprom
	driver
Date: Thu,  8 Oct 2009 16:04:32 +0200
Message-Id: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
Cc: devicetree-discuss@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Anton introduced archdata support, I wondered if this is a suitable way to
handle the platform_data/devicetree_property-dualism (at least for some
drivers).

If considered suitable, I would document the bindings properly. I really think
that pagesize deserves its own property as it is specific to the hardware and I
have seen devices with equal name and still having different pagesizes. Not too
sure about 'read-only' though, I just copied it from flash-partitions :)

Tested on a phyCORE-MPC5200-IO and build-tested on x86.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/misc/eeprom/at24.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index db39f4a..4e543e6 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -22,6 +22,9 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
+#ifdef CONFIG_OF_I2C
+#include <linux/of.h>
+#endif
 
 /*
  * I2C EEPROMs from most vendors are inexpensive and mostly interchangeable.
@@ -414,6 +417,25 @@ static ssize_t at24_macc_write(struct memory_accessor *macc, const char *buf,
 	return at24_write(at24, buf, offset, count);
 }
 
+#ifdef CONFIG_OF_I2C
+static void at24_get_ofdata(struct i2c_client *client, struct at24_platform_data *chip)
+{
+	const u32 *val;
+	struct device_node *node = dev_archdata_get_node(&client->dev.archdata);
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
+static void at24_get_ofdata(struct i2c_client *client, struct at24_platform_data *chip)
+{ }
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
@@ -444,6 +466,9 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		 */
 		chip.page_size = 1;
 
+		/* update chipdata if OF is present */
+		at24_get_ofdata(client, &chip);
+
 		chip.setup = NULL;
 		chip.context = NULL;
 	}
-- 
1.6.3.3
