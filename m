Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 899D3DDE47
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 15:17:19 +1100 (EST)
Date: Thu, 3 Jan 2008 15:17:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] therm_adt746x: eliminate some build warnings
Message-Id: <20080103151712.71b7fbba.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We don't care if the device_create_file calls fail, the driver will work
just as well without them, so just issue a runtime warning.

drivers/macintosh/therm_adt746x.c: In function 'thermostat_init':
drivers/macintosh/therm_adt746x.c:615: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:616: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:617: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:618: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:619: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:620: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:621: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:622: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:623: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:625: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/macintosh/therm_adt746x.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 276945d..54f4942 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -553,6 +553,7 @@ thermostat_init(void)
 	struct device_node* np;
 	const u32 *prop;
 	int i = 0, offset = 0;
+	int err;
 	
 	np = of_find_node_by_name(NULL, "fan");
 	if (!np)
@@ -612,17 +613,20 @@ thermostat_init(void)
 		return -ENODEV;
 	}
 	
-	device_create_file(&of_dev->dev, &dev_attr_sensor1_temperature);
-	device_create_file(&of_dev->dev, &dev_attr_sensor2_temperature);
-	device_create_file(&of_dev->dev, &dev_attr_sensor1_limit);
-	device_create_file(&of_dev->dev, &dev_attr_sensor2_limit);
-	device_create_file(&of_dev->dev, &dev_attr_sensor1_location);
-	device_create_file(&of_dev->dev, &dev_attr_sensor2_location);
-	device_create_file(&of_dev->dev, &dev_attr_limit_adjust);
-	device_create_file(&of_dev->dev, &dev_attr_specified_fan_speed);
-	device_create_file(&of_dev->dev, &dev_attr_sensor1_fan_speed);
+	err = device_create_file(&of_dev->dev, &dev_attr_sensor1_temperature);
+	err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_temperature);
+	err |= device_create_file(&of_dev->dev, &dev_attr_sensor1_limit);
+	err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_limit);
+	err |= device_create_file(&of_dev->dev, &dev_attr_sensor1_location);
+	err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_location);
+	err |= device_create_file(&of_dev->dev, &dev_attr_limit_adjust);
+	err |= device_create_file(&of_dev->dev, &dev_attr_specified_fan_speed);
+	err |= device_create_file(&of_dev->dev, &dev_attr_sensor1_fan_speed);
 	if(therm_type == ADT7460)
-		device_create_file(&of_dev->dev, &dev_attr_sensor2_fan_speed);
+		err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_fan_speed);
+	if (err)
+		printk(KERN_WARNING
+			"Failed to create tempertaure attribute file(s).\n");
 
 #ifndef CONFIG_I2C_POWERMAC
 	request_module("i2c-powermac");
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
