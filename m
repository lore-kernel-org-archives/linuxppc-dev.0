Return-Path: <khali@linux-fr.org>
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by ozlabs.org (Postfix) with ESMTP id A6DDBB7D68
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Feb 2010 01:03:26 +1100 (EST)
Date: Sun, 31 Jan 2010 15:03:23 +0100
From: Jean Delvare <khali@linux-fr.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] hwmon: (ams) Fix device removal sequence
Message-ID: <20100131150323.06e0c876@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christian Kujau <lists@nerdbynature.de>, Stelian Pop <stelian@popies.net>,
	Michael Hanselmann <linux-kernel@hansmi.ch>,
	LM Sensors <lm-sensors@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some code that is in ams_exit() (the module exit code) should instead
be called when the device (not module) is removed. It probably doesn't
make much of a difference in the PMU case, but in the I2C case it does
matter.

I make no guarantee that my fix isn't racy, I'm not familiar enough
with the ams driver code to tell for sure.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Tested-by: Christian Kujau <lists@nerdbynature.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stelian Pop <stelian@popies.net>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: stable@kernel.org
---
Christian tested the I2C variant of the chip, it would be nice if
someone could test the PMU variant too.

 drivers/hwmon/ams/ams-core.c |   11 +++++++----
 drivers/hwmon/ams/ams-i2c.c  |    2 ++
 drivers/hwmon/ams/ams-pmu.c  |    2 ++
 drivers/hwmon/ams/ams.h      |    1 +
 4 files changed, 12 insertions(+), 4 deletions(-)

--- linux-2.6.33-rc3.orig/drivers/hwmon/ams/ams-core.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.33-rc3/drivers/hwmon/ams/ams-core.c	2010-01-07 17:14:25.000000000 +0100
@@ -213,7 +213,7 @@ int __init ams_init(void)
 	return -ENODEV;
 }
 
-void ams_exit(void)
+void ams_sensor_detach(void)
 {
 	/* Remove input device */
 	ams_input_exit();
@@ -221,9 +221,6 @@ void ams_exit(void)
 	/* Remove attributes */
 	device_remove_file(&ams_info.of_dev->dev, &dev_attr_current);
 
-	/* Shut down implementation */
-	ams_info.exit();
-
 	/* Flush interrupt worker
 	 *
 	 * We do this after ams_info.exit(), because an interrupt might
@@ -239,6 +236,12 @@ void ams_exit(void)
 	pmf_unregister_irq_client(&ams_freefall_client);
 }
 
+static void __exit ams_exit(void)
+{
+	/* Shut down implementation */
+	ams_info.exit();
+}
+
 MODULE_AUTHOR("Stelian Pop, Michael Hanselmann");
 MODULE_DESCRIPTION("Apple Motion Sensor driver");
 MODULE_LICENSE("GPL");
--- linux-2.6.33-rc3.orig/drivers/hwmon/ams/ams-i2c.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.33-rc3/drivers/hwmon/ams/ams-i2c.c	2010-01-07 17:12:46.000000000 +0100
@@ -238,6 +238,8 @@ static int ams_i2c_probe(struct i2c_clie
 static int ams_i2c_remove(struct i2c_client *client)
 {
 	if (ams_info.has_device) {
+		ams_sensor_detach();
+
 		/* Disable interrupts */
 		ams_i2c_set_irq(AMS_IRQ_ALL, 0);
 
--- linux-2.6.33-rc3.orig/drivers/hwmon/ams/ams-pmu.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.33-rc3/drivers/hwmon/ams/ams-pmu.c	2010-01-07 17:13:47.000000000 +0100
@@ -133,6 +133,8 @@ static void ams_pmu_get_xyz(s8 *x, s8 *y
 
 static void ams_pmu_exit(void)
 {
+	ams_sensor_detach();
+
 	/* Disable interrupts */
 	ams_pmu_set_irq(AMS_IRQ_ALL, 0);
 
--- linux-2.6.33-rc3.orig/drivers/hwmon/ams/ams.h	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.33-rc3/drivers/hwmon/ams/ams.h	2010-01-07 17:11:43.000000000 +0100
@@ -61,6 +61,7 @@ extern struct ams ams_info;
 
 extern void ams_sensors(s8 *x, s8 *y, s8 *z);
 extern int ams_sensor_attach(void);
+extern void ams_sensor_detach(void);
 
 extern int ams_pmu_init(struct device_node *np);
 extern int ams_i2c_init(struct device_node *np);


-- 
Jean Delvare
