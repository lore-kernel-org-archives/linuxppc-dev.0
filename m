Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8F4FDE112
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 09:35:51 +1000 (EST)
Subject: [PATCH] sysdev,mv64x60: initialization of mv64x60 ethernet, serial
	and I2C
From: Remi Machet <rmachet@slac.stanford.edu>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 17 Apr 2008 16:35:55 -0700
Message-Id: <1208475355.5789.30.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch affects only the mv64x60 driver. It fixes 2 problem:

-If one of the devices of the mv64x60 init fails, the remaining 
devices are not initialized => I changed the code to display an
error and continue the initialization.

-I2C parameters freq_m and freq_n are assigned default in the code
but if those properties are not found in the open firmware description 
the init returns an error=> the code now uses the default
values if the properties are not found.

Signed-off-by: Remi Machet (rmachet@slac.stanford.edu)
---

diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index 047b310..ef0fc99 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -338,15 +338,13 @@ static int __init mv64x60_i2c_device_setup(struct device_node *np, int id)
 
 	pdata.freq_m = 8;	/* default */
 	prop = of_get_property(np, "freq_m", NULL);
-	if (!prop)
-		return -ENODEV;
-	pdata.freq_m = *prop;
+	if (prop)
+		pdata.freq_m = *prop;
 
 	pdata.freq_m = 3;	/* default */
 	prop = of_get_property(np, "freq_n", NULL);
-	if (!prop)
-		return -ENODEV;
-	pdata.freq_n = *prop;
+	if (prop)
+		pdata.freq_n = *prop;
 
 	pdata.timeout = 1000;				/* default: 1 second */
 
@@ -433,9 +431,15 @@ static int __init mv64x60_device_setup(void)
 	int err;
 
 	id = 0;
-	for_each_compatible_node(np, "serial", "marvell,mv64360-mpsc")
-		if ((err = mv64x60_mpsc_device_setup(np, id++)))
-			goto error;
+	for_each_compatible_node(np, "serial", "marvell,mv64360-mpsc") {
+		err = mv64x60_mpsc_device_setup(np, id++);
+		if (err) {
+			printk(KERN_ERR "Failed to initialize MV64x60 " \
+					"serial device %s: error %d.\n",
+					np->full_name, err);
+			of_node_put(np);
+		};
+	};
 
 	id = 0;
 	id2 = 0;
@@ -443,38 +447,48 @@ static int __init mv64x60_device_setup(void)
 		pdev = mv64x60_eth_register_shared_pdev(np, id++);
 		if (IS_ERR(pdev)) {
 			err = PTR_ERR(pdev);
-			goto error;
-		}
+			printk(KERN_ERR "Failed to initialize MV64x60 " \
+					"network block %s: error %d.\n",
+					np->full_name, err);
+			of_node_put(np);
+			continue;
+		};
 		for_each_child_of_node(np, np2) {
 			if (!of_device_is_compatible(np2,
 					"marvell,mv64360-eth"))
 				continue;
 			err = mv64x60_eth_device_setup(np2, id2++, pdev);
 			if (err) {
-				of_node_put(np2);
-				goto error;
+				printk(KERN_ERR "Failed to initialize " \
+						"MV64x60 network device %s: " \
+						"error %d.\n",
+						np2->full_name, err);
 			}
 		}
 	}
 
 	id = 0;
-	for_each_compatible_node(np, "i2c", "marvell,mv64360-i2c")
-		if ((err = mv64x60_i2c_device_setup(np, id++)))
-			goto error;
+	for_each_compatible_node(np, "i2c", "marvell,mv64360-i2c") {
+		err = mv64x60_i2c_device_setup(np, id++);
+		if (err) {
+			printk(KERN_ERR "Failed to initialize MV64x60 I2C " \
+					"bus %s: error %d.\n",
+					np->full_name, err);
+			of_node_put(np);
+		};
+	};
 
 	/* support up to one watchdog timer */
 	np = of_find_compatible_node(np, NULL, "marvell,mv64360-wdt");
 	if (np) {
 		if ((err = mv64x60_wdt_device_setup(np, id)))
-			goto error;
+			printk(KERN_ERR "Failed to initialize MV64x60 " \
+					"Watchdog %s: error %d.\n",
+					np->full_name, err);
 		of_node_put(np);
 	}
 
 	return 0;
-
-error:
-	of_node_put(np);
-	return err;
 }
 arch_initcall(mv64x60_device_setup);
 
