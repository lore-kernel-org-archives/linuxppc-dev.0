Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBD19B7082
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 19:04:55 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Thu, 19 Apr 2012 08:18:59 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3J8DB2l2322632
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:13:11 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3J8Jmh2008274
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:49 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/15] i2c/powermac: Register i2c devices from device-tree
Date: Thu, 19 Apr 2012 18:16:42 +1000
Message-Id: <1334823416-9138-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
Cc: khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This causes i2c-powermac to register i2c devices exposed in the
device-tree, enabling new-style probing of devices.

Note that we prefix the IDs with "MAC," in order to prevent the
generic drivers from matching. This is done on purpose as we only
want drivers specifically tested/designed to operate on powermacs
to match.

This removes the special case we had for the AMS driver, and updates
the driver's match table instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powermac/low_i2c.c |    1 +
 drivers/i2c/busses/i2c-powermac.c         |   98 +++++++++++++++++++++--------
 drivers/macintosh/ams/ams-i2c.c           |    2 +-
 3 files changed, 73 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 996c5ff..f991dbb 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1494,6 +1494,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 		if (bus->platform_dev == NULL)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
+		bus->platform_dev->dev.of_node = bus->busnode;
 		platform_device_add(bus->platform_dev);
 	}
 
diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 7b397c6..31c47e1 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -227,6 +227,72 @@ static int __devexit i2c_powermac_remove(struct platform_device *dev)
 	return 0;
 }
 
+static void __devinit i2c_powermac_register_devices(struct i2c_adapter *adap,
+						    struct pmac_i2c_bus *bus)
+{
+	struct i2c_client *newdev;
+	struct device_node *node;
+
+	for_each_child_of_node(adap->dev.of_node, node) {
+		struct i2c_board_info info = {};
+		struct dev_archdata dev_ad = {};
+		const __be32 *reg;
+		char tmp[16];
+		u32 addr;
+		int len;
+
+		/* Get address & channel */
+		reg = of_get_property(node, "reg", &len);
+		if (!reg || (len < sizeof(int))) {
+			dev_err(&adap->dev, "i2c-powermac: invalid reg on %s\n",
+				node->full_name);
+			continue;
+		}
+		addr = be32_to_cpup(reg);
+
+		/* Multibus setup, check channel */
+		if (!pmac_i2c_match_adapter(node, adap))
+			continue;
+
+		dev_dbg(&adap->dev, "i2c-powermac: register %s\n",
+			node->full_name);
+
+		/* Make up a modalias. Note: we to _NOT_ want the standard
+		 * i2c drivers to match with any of our powermac stuff
+		 * unless they have been specifically modified to handle
+		 * it on a case by case basis. For example, for thermal
+		 * control, things like lm75 etc... shall match with their
+		 * corresponding windfarm drivers, _NOT_ the generic ones,
+		 * so we force a prefix of AAPL, onto the modalias to
+		 * make that happen
+		 */
+		if (of_modalias_node(node, tmp, sizeof(tmp)) < 0) {
+			dev_err(&adap->dev, "i2c-powermac: modalias failure"
+				" on %s\n", node->full_name);
+			continue;
+		}
+		snprintf(info.type, sizeof(info.type), "MAC,%s", tmp);
+
+		/* Fill out the rest of the info structure */
+		info.addr = (addr & 0xff) >> 1;
+		info.irq = irq_of_parse_and_map(node, 0);
+		info.of_node = of_node_get(node);
+		info.archdata = &dev_ad;
+
+		newdev = i2c_new_device(adap, &info);
+		if (!newdev) {
+			dev_err(&adap->dev, "i2c-powermac: Failure to register"
+				" %s\n", node->full_name);
+			of_node_put(node);
+			/* We do not dispose of the interrupt mapping on
+			 * purpose. It's not necessary (interrupt cannot be
+			 * re-used) and somebody else might have grabbed it
+			 * via direct DT lookup so let's not bother
+			 */
+			continue;
+		}
+	}
+}
 
 static int __devinit i2c_powermac_probe(struct platform_device *dev)
 {
@@ -272,6 +338,7 @@ static int __devinit i2c_powermac_probe(struct platform_device *dev)
 	adapter->algo = &i2c_powermac_algorithm;
 	i2c_set_adapdata(adapter, bus);
 	adapter->dev.parent = &dev->dev;
+	adapter->dev.of_node = dev->dev.of_node;
 	rc = i2c_add_adapter(adapter);
 	if (rc) {
 		printk(KERN_ERR "i2c-powermac: Adapter %s registration "
@@ -281,33 +348,10 @@ static int __devinit i2c_powermac_probe(struct platform_device *dev)
 
 	printk(KERN_INFO "PowerMac i2c bus %s registered\n", adapter->name);
 
-	if (!strncmp(basename, "uni-n", 5)) {
-		struct device_node *np;
-		const u32 *prop;
-		struct i2c_board_info info;
-
-		/* Instantiate I2C motion sensor if present */
-		np = of_find_node_by_name(NULL, "accelerometer");
-		if (np && of_device_is_compatible(np, "AAPL,accelerometer_1") &&
-		    (prop = of_get_property(np, "reg", NULL))) {
-			int i2c_bus;
-			const char *tmp_bus;
-
-			/* look for bus either using "reg" or by path */
-			tmp_bus = strstr(np->full_name, "/i2c-bus@");
-			if (tmp_bus)
-				i2c_bus = *(tmp_bus + 9) - '0';
-			else
-				i2c_bus = ((*prop) >> 8) & 0x0f;
-
-			if (pmac_i2c_get_channel(bus) == i2c_bus) {
-				memset(&info, 0, sizeof(struct i2c_board_info));
-				info.addr = ((*prop) & 0xff) >> 1;
-				strlcpy(info.type, "ams", I2C_NAME_SIZE);
-				i2c_new_device(adapter, &info);
-			}
-		}
-	}
+	/* Cannot use of_i2c_register_devices() due to Apple device-tree
+	 * funkyness
+	 */
+	i2c_powermac_register_devices(adapter, bus);
 
 	return rc;
 }
diff --git a/drivers/macintosh/ams/ams-i2c.c b/drivers/macintosh/ams/ams-i2c.c
index abeecd2..978eda8 100644
--- a/drivers/macintosh/ams/ams-i2c.c
+++ b/drivers/macintosh/ams/ams-i2c.c
@@ -65,7 +65,7 @@ static int ams_i2c_probe(struct i2c_client *client,
 static int ams_i2c_remove(struct i2c_client *client);
 
 static const struct i2c_device_id ams_id[] = {
-	{ "ams", 0 },
+	{ "MAC,accelerometer_1", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ams_id);
-- 
1.7.9.5
