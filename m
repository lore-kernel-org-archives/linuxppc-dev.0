Return-Path: <maz@misterjones.org>
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
	[213.251.177.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75E03B70D4
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2011 02:58:00 +1100 (EST)
From: Marc Zyngier <maz@misterjones.org>
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Make auto-loading of therm_pm72 possible
Date: Mon,  3 Jan 2011 15:57:36 +0000
Message-Id: <1294070256-1085-1-git-send-email-maz@misterjones.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The therm_pm72 driver, used on the PowerMac G5 range, cannot be
auto-loaded, since the driver itself creates both the device node
and the driver instance.

Moving the device node creation to the platform setup code and
adding the necessary MODULE_DEVICE_TABLE() information allows the
driver to be automatically loaded by udev on any semi-modern
distribution.

It "fixes" a major source of problem on G5 machines where the
driver wasn't explicitely loaded by default, and the system
would automatically shutdown under load.

Tested on an Xserve G5.

Signed-off-by: Marc Zyngier <maz@misterjones.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powermac/setup.c |    9 +++++++++
 drivers/macintosh/therm_pm72.c          |   30 +++++-------------------------
 2 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 9deb274..d5aceb7 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -506,6 +506,15 @@ static int __init pmac_declare_of_platform_devices(void)
 		of_platform_device_create(np, "smu", NULL);
 		of_node_put(np);
 	}
+	np = of_find_node_by_type(NULL, "fcu");
+	if (np == NULL) {
+		/* Some machines have strangely broken device-tree */
+		np = of_find_node_by_path("/u3@0,f8000000/i2c@f8001000/fan@15e");
+	}
+	if (np) {
+		of_platform_device_create(np, "temperature", NULL);
+		of_node_put(np);
+	}
 
 	return 0;
 }
diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
index 4454927..2e041fd 100644
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -2213,6 +2213,9 @@ static void fcu_lookup_fans(struct device_node *fcu_node)
 static int fcu_of_probe(struct platform_device* dev, const struct of_device_id *match)
 {
 	state = state_detached;
+	of_dev = dev;
+
+	dev_info(&dev->dev, "PowerMac G5 Thermal control driver %s\n", VERSION);
 
 	/* Lookup the fans in the device tree */
 	fcu_lookup_fans(dev->dev.of_node);
@@ -2235,6 +2238,7 @@ static const struct of_device_id fcu_match[] =
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, fcu_match);
 
 static struct of_platform_driver fcu_of_platform_driver = 
 {
@@ -2252,8 +2256,6 @@ static struct of_platform_driver fcu_of_platform_driver =
  */
 static int __init therm_pm72_init(void)
 {
-	struct device_node *np;
-
 	rackmac = of_machine_is_compatible("RackMac3,1");
 
 	if (!of_machine_is_compatible("PowerMac7,2") &&
@@ -2261,34 +2263,12 @@ static int __init therm_pm72_init(void)
 	    !rackmac)
 	    	return -ENODEV;
 
-	printk(KERN_INFO "PowerMac G5 Thermal control driver %s\n", VERSION);
-
-	np = of_find_node_by_type(NULL, "fcu");
-	if (np == NULL) {
-		/* Some machines have strangely broken device-tree */
-		np = of_find_node_by_path("/u3@0,f8000000/i2c@f8001000/fan@15e");
-		if (np == NULL) {
-			    printk(KERN_ERR "Can't find FCU in device-tree !\n");
-			    return -ENODEV;
-		}
-	}
-	of_dev = of_platform_device_create(np, "temperature", NULL);
-	if (of_dev == NULL) {
-		printk(KERN_ERR "Can't register FCU platform device !\n");
-		return -ENODEV;
-	}
-
-	of_register_platform_driver(&fcu_of_platform_driver);
-	
-	return 0;
+	return of_register_platform_driver(&fcu_of_platform_driver);
 }
 
 static void __exit therm_pm72_exit(void)
 {
 	of_unregister_platform_driver(&fcu_of_platform_driver);
-
-	if (of_dev)
-		of_device_unregister(of_dev);
 }
 
 module_init(therm_pm72_init);
-- 
1.7.2.3
