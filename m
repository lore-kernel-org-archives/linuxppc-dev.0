Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF9E91A0DAC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 20:11:31 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 20:11:30 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 943012BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 20:11:27 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SABJqb38076452
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 20:11:27 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3SAArWY011420
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 20:10:54 +1000
Subject: [PATCH v4 3/3] leds/powernv: Add driver for PowerNV platform
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org
Date: Tue, 28 Apr 2015 15:40:35 +0530
Message-ID: <20150428101008.26912.38735.stgit@localhost.localdomain>
In-Reply-To: <20150428100535.26912.29607.stgit@localhost.localdomain>
References: <20150428100535.26912.29607.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, cooloney@gmail.com,
 rpurdie@rpsys.net, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implements LED driver for PowerNV platform using the existing
generic LED class framework.

PowerNV platform has below type of LEDs:
  - System attention
      Indicates there is a problem with the system that needs attention.
  - Identify
      Helps the user locate/identify a particular FRU or resource in the
      system.
  - Fault
      Indicates there is a problem with the FRU or resource at the
      location with which the indicator is associated.

We register classdev structures for all individual LEDs detected on the
system through LED specific device tree nodes. Device tree nodes specify
what all kind of LEDs present on the same location code. It registers
LED classdev structure for each of them.

All the system LEDs can be found in the same regular path /sys/class/leds/.
We don't use LED colors. We use LED node and led-types property to form
LED classdev. Our LEDs have names in this format.

        <location_code>:<attention|identify|fault>

Any positive brightness value would turn on the LED and a zero value would
turn off the LED. The driver will return LED_FULL (255) for any turned on
LED and LED_OFF (0) for any turned off LED.

As per the LED class framework, the 'brightness_set' function should not
sleep. Hence these functions have been implemented through global work
queue tasks which might sleep on OPAL async call completion.

The platform level implementation of LED get and set state has been achieved
through OPAL calls. These calls are made available for the driver by
exporting from architecture specific codes.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Tested-by: Stewart Smith <stewart@linux.vnet.ibm.com>

---
Changes in v4:
  - s/u64/__be64/g for big endian data we get from firmware
  - Addressed review comments from Jacek. Major once are:
    Removed list in powernv_led_data structure
    s/kzalloc/devm_kzalloc/
    Removed compatible property from documentation
    s/powernv_led_set_queue/powernv_brightness_set/
  - Removed LED specific brightness_set/get function. Instead this version
    uses single function to queue all LED set/get requests. Later we use
    LED name to detect LED type and value.
  - Removed hardcoded LED type used in previous version. Instead we use
    led-types property to form LED classdev.


Changes in v3:
  - Addressed review comments from Jacek. Major once are:
    Replaced spin lock and mutex and removed redundant structures
    Replaced pr_* with dev_*
    Moved OPAL platform sepcific part to separate patch
    Moved repteated code to common function
    Added device tree documentation for LEDs


Changes in v2:
  - Added System Attention indicator support
  - Moved common code to powernv_led_set_queue()


 .../devicetree/bindings/leds/leds-powernv.txt      |   29 +
 drivers/leds/Kconfig                               |   11 
 drivers/leds/Makefile                              |    1 
 drivers/leds/leds-powernv.c                        |  472 ++++++++++++++++++++
 4 files changed, 513 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-powernv.txt
 create mode 100644 drivers/leds/leds-powernv.c

diff --git a/Documentation/devicetree/bindings/leds/leds-powernv.txt b/Documentation/devicetree/bindings/leds/leds-powernv.txt
new file mode 100644
index 0000000..6bb0e7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-powernv.txt
@@ -0,0 +1,29 @@
+Device Tree binding for LEDs on IBM Power Systems
+-------------------------------------------------
+
+The 'led' node under '/ibm,opal' lists service indicators available in the
+system and their capabilities.
+
+led {
+	compatible = "ibm,opal-v3-led";
+	phandle = <0x1000006b>;
+	linux,phandle = <0x1000006b>;
+	led-mode = "lightpath";
+
+	U78C9.001.RST0027-P1-C1 {
+		led-types = "identify", "fault";
+		led-loc = "descendent";
+		phandle = <0x1000006f>;
+		linux,phandle = <0x1000006f>;
+	};
+	...
+	...
+};
+
+Each node under 'led' node describes location code of FRU/Enclosure.
+
+The properties under each node:
+
+  led-types : Supported LED types (attention/identify/fault).
+
+  led-loc   : enclosure/descendent(FRU) location code.
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 25b320d..2ea0849 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -508,6 +508,17 @@ config LEDS_BLINKM
 	  This option enables support for the BlinkM RGB LED connected
 	  through I2C. Say Y to enable support for the BlinkM LED.
 
+config LEDS_POWERNV
+	tristate "LED support for PowerNV Platform"
+	depends on LEDS_CLASS
+	depends on PPC_POWERNV
+	depends on OF
+	help
+	  This option enables support for the system LEDs present on
+	  PowerNV platforms. Say 'y' to enable this support in kernel.
+	  To compile this driver as a module, choose 'm' here: the module
+	  will be called leds-powernv.
+
 config LEDS_SYSCON
 	bool "LED support for LEDs on system controllers"
 	depends on LEDS_CLASS=y
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index cbba921..604ffc9 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
 obj-$(CONFIG_LEDS_SYSCON)		+= leds-syscon.o
 obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
 obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
+obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
new file mode 100644
index 0000000..bea46fd
--- /dev/null
+++ b/drivers/leds/leds-powernv.c
@@ -0,0 +1,472 @@
+/*
+ * PowerNV LED Driver
+ *
+ * Copyright IBM Corp. 2015
+ *
+ * Author: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
+ * Author: Anshuman Khandual <khandual@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <asm/opal.h>
+
+/*
+ * LED support for PowerNV platform:
+ * - Identify and fault LEDs are overloaded (meaning we use single LED to
+ *   represent both state).
+ *   Physical LED state : off = normal, blinking = identify, solid = fault
+ *   Hardware takes care of maintaining/changing LED state. From user point
+ *   of view these are two different LEDs. Hence we use separate led
+ *   classsdev for identify and fault.
+ * - By default unload path resets all the LEDs. But on PowerNV platform
+ *   we want to retain LED state across reboot as these are controlled by
+ *   firmware. Also service processor can modify the LEDs independent of
+ *   OS. Hence avoid resetting LEDs in unload path.
+ */
+
+/* Disable LED support in unload path */
+static bool led_disabled;
+
+/* Map LED type to description. */
+struct led_type_map {
+	const int	type;
+	const char	*desc;
+};
+static const struct led_type_map led_type_map[] = {
+	{OPAL_SLOT_LED_TYPE_ID,		POWERNV_LED_TYPE_IDENTIFY},
+	{OPAL_SLOT_LED_TYPE_FAULT,	POWERNV_LED_TYPE_FAULT},
+	{OPAL_SLOT_LED_TYPE_ATTN,	POWERNV_LED_TYPE_ATTENTION},
+	{-1,				NULL},
+};
+
+/*
+ * LED set routines have been implemented as work queue tasks scheduled
+ * on the global work queue. Individual task calls OPAL interface to set
+ * the LED state which might sleep for some time.
+ */
+struct powernv_led_data {
+	struct led_classdev	cdev;
+	enum led_brightness	value;     /* Brightness value */
+	struct mutex		lock;
+	struct work_struct	work_led; /* LED update workqueue */
+};
+
+struct powernv_leds_priv {
+	int num_leds;
+	struct powernv_led_data powernv_leds[];
+};
+
+
+static inline int sizeof_powernv_leds_priv(int num_leds)
+{
+	return sizeof(struct powernv_leds_priv) +
+		(sizeof(struct powernv_led_data) * num_leds);
+}
+
+/* Returns OPAL_SLOT_LED_TYPE_* for given led type string */
+static int powernv_get_led_type(struct led_classdev *led_cdev)
+{
+	char *desc;
+	int i;
+
+	desc = strstr(led_cdev->name, ":");
+	if (!desc)
+		return -1;
+	desc++;
+	if (!desc)
+		return -1;
+
+	for (i = 0; i < ARRAY_SIZE(led_type_map); i++)
+		if (!strcmp(led_type_map[i].desc, desc))
+			return led_type_map[i].type;
+
+	return -1;
+}
+
+/* This function gets LED location code for given LED classdev */
+static char *powernv_get_location_code(struct led_classdev *led_cdev)
+{
+	char *loc_code;
+	char *colon;
+
+	/* Location code of the LED */
+	loc_code = kasprintf(GFP_KERNEL, "%s", led_cdev->name);
+	if (!loc_code) {
+		dev_err(led_cdev->dev,
+			"%s: Memory allocation failed\n", __func__);
+		return NULL;
+	}
+
+	colon = strstr(loc_code, ":");
+	if (!colon) {
+		kfree(loc_code);
+		return NULL;
+	}
+
+	*colon = '\0';
+	return loc_code;
+}
+
+/*
+ * This commits the state change of the requested LED through an OPAL call.
+ * This function is called from work queue task context when ever it gets
+ * scheduled. This function can sleep at opal_async_wait_response call.
+ */
+static void powernv_led_set(struct led_classdev *led_cdev,
+			    enum led_brightness value)
+{
+	char *loc_code;
+	int rc, token, led_type;
+	u64 led_mask, led_value = 0;
+	__be64 max_led_type;
+	struct opal_msg msg;
+
+	led_type = powernv_get_led_type(led_cdev);
+	if (led_type == -1)
+		return;
+
+	loc_code = powernv_get_location_code(led_cdev);
+	if (!loc_code)
+		return;
+
+	/* Prepare for the OPAL call */
+	max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
+	led_mask = OPAL_SLOT_LED_STATE_ON << led_type;
+	if (value)
+		led_value = led_mask;
+
+	/* OPAL async call */
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		if (token != -ERESTARTSYS)
+			dev_err(led_cdev->dev,
+				"%s: Couldn't get OPAL async token\n",
+				__func__);
+		goto out_loc;
+	}
+
+	rc = opal_leds_set_ind(token, loc_code,
+			       led_mask, led_value, &max_led_type);
+	if (rc != OPAL_ASYNC_COMPLETION) {
+		dev_err(led_cdev->dev,
+			"%s: OPAL set LED call failed for %s [rc=%d]\n",
+			__func__, loc_code, rc);
+		goto out_token;
+	}
+
+	rc = opal_async_wait_response(token, &msg);
+	if (rc) {
+		dev_err(led_cdev->dev,
+			"%s: Failed to wait for the async response [rc=%d]\n",
+			__func__, rc);
+		goto out_token;
+	}
+
+	rc = be64_to_cpu(msg.params[1]);
+	if (rc != OPAL_SUCCESS)
+		dev_err(led_cdev->dev,
+			"%s : OAPL async call returned failed [rc=%d]\n",
+			__func__, rc);
+
+out_token:
+	opal_async_release_token(token);
+
+out_loc:
+	kfree(loc_code);
+}
+
+/*
+ * This function fetches the LED state for a given LED type for
+ * mentioned LED classdev structure.
+ */
+static enum led_brightness powernv_led_get(struct led_classdev *led_cdev)
+{
+	char *loc_code;
+	int rc, led_type;
+	__be64 led_mask, led_value, max_led_type;
+
+	led_type = powernv_get_led_type(led_cdev);
+	if (led_type == -1)
+		return LED_OFF;
+
+	loc_code = powernv_get_location_code(led_cdev);
+	if (!loc_code)
+		return LED_OFF;
+
+	/* Fetch all LED status */
+	led_mask = cpu_to_be64(0);
+	led_value = cpu_to_be64(0);
+	max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
+
+	rc = opal_leds_get_ind(loc_code, &led_mask, &led_value, &max_led_type);
+	if (rc != OPAL_SUCCESS && rc != OPAL_PARTIAL) {
+		dev_err(led_cdev->dev,
+			"%s: OPAL get led call failed [rc=%d]\n",
+			__func__, rc);
+		goto led_fail;
+	}
+
+	led_mask = be64_to_cpu(led_mask);
+	led_value = be64_to_cpu(led_value);
+
+	/* LED status available */
+	if (!((led_mask >> led_type) & OPAL_SLOT_LED_STATE_ON)) {
+		dev_err(led_cdev->dev,
+			"%s: LED status not available for %s\n",
+			__func__, led_cdev->name);
+		goto led_fail;
+	}
+
+	/* LED status value */
+	if ((led_value >> led_type) & OPAL_SLOT_LED_STATE_ON) {
+		kfree(loc_code);
+		return LED_FULL;
+	}
+
+led_fail:
+	kfree(loc_code);
+	return LED_OFF;
+}
+
+/* Execute LED set task for given led classdev */
+static void powernv_deferred_led_set(struct work_struct *work)
+{
+	struct powernv_led_data *powernv_led =
+		container_of(work, struct powernv_led_data, work_led);
+
+	mutex_lock(&powernv_led->lock);
+	powernv_led_set(&powernv_led->cdev, powernv_led->value);
+	mutex_unlock(&powernv_led->lock);
+}
+
+/*
+ * LED classdev 'brightness_get' function. This schedules work
+ * to update LED state.
+ */
+static void powernv_brightness_set(struct led_classdev *led_cdev,
+				   enum led_brightness value)
+{
+	struct powernv_led_data *powernv_led =
+		container_of(led_cdev, struct powernv_led_data, cdev);
+
+	/* Do not modify LED in unload path */
+	if (led_disabled)
+		return;
+
+	/* Prepare the request */
+	powernv_led->value = value;
+
+	/* Schedule the new task */
+	schedule_work(&powernv_led->work_led);
+}
+
+/* LED classdev 'brightness_get' function */
+static enum led_brightness
+powernv_brightness_get(struct led_classdev *led_cdev)
+{
+	return powernv_led_get(led_cdev);
+}
+
+
+/*
+ * This function registers classdev structure for any given type of LED on
+ * a given child LED device node.
+ */
+static int powernv_led_create(struct device *dev,
+			      struct powernv_led_data *powernv_led,
+			      const char *led_name, const char *led_type_desc)
+{
+	int rc;
+
+	/* Create the name for classdev */
+	powernv_led->cdev.name = kasprintf(GFP_KERNEL, "%s:%s",
+					   led_name, led_type_desc);
+	if (!powernv_led->cdev.name) {
+		dev_err(dev,
+			"%s: Memory allocation failed for classdev name\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	/* Make sure LED type is supported */
+	if (powernv_get_led_type(&powernv_led->cdev) == -1) {
+		kfree(powernv_led->cdev.name);
+		return -EINVAL;
+	}
+
+	powernv_led->cdev.brightness_set = powernv_brightness_set;
+	powernv_led->cdev.brightness_get = powernv_brightness_get;
+	powernv_led->cdev.brightness = LED_OFF;
+	powernv_led->cdev.max_brightness = LED_FULL;
+
+	mutex_init(&powernv_led->lock);
+	INIT_WORK(&powernv_led->work_led, powernv_deferred_led_set);
+
+	/* Register the classdev */
+	rc = led_classdev_register(dev, &powernv_led->cdev);
+	if (rc) {
+		dev_err(dev, "%s: Classdev registration failed for %s\n",
+			__func__, powernv_led->cdev.name);
+		kfree(powernv_led->cdev.name);
+	}
+
+	return rc;
+}
+
+/* Unregister classdev structure for any given LED */
+static void powernv_led_delete(struct powernv_led_data *powernv_led)
+{
+	led_classdev_unregister(&powernv_led->cdev);
+}
+
+/* Go through LED device tree node and register LED classdev structure */
+static int powernv_led_classdev(struct platform_device *pdev,
+				struct device_node *led_node,
+				struct powernv_leds_priv *priv, int num_leds)
+{
+	const char *cur = NULL;
+	int i, rc = -1;
+	struct property *p;
+	struct device_node *np;
+	struct powernv_led_data *powernv_led;
+	struct device *dev = &pdev->dev;
+
+	for_each_child_of_node(led_node, np) {
+		p = of_find_property(np, "led-types", NULL);
+		if (!p)
+			continue;
+
+		while ((cur = of_prop_next_string(p, cur)) != NULL) {
+			powernv_led = &priv->powernv_leds[priv->num_leds++];
+			if (priv->num_leds > num_leds) {
+				rc = -ENOMEM;
+				goto classdev_fail;
+			}
+			rc = powernv_led_create(dev,
+						powernv_led, np->name, cur);
+			if (rc)
+				goto classdev_fail;
+		} /* while end */
+	}
+
+	platform_set_drvdata(pdev, priv);
+	return rc;
+
+classdev_fail:
+	for (i = priv->num_leds - 2; i > 0; i--)
+		powernv_led_delete(&priv->powernv_leds[i]);
+
+	return rc;
+}
+
+/*
+ * We want to populate LED device for each LED type. Hence we
+ * have to calculate count explicitly.
+ */
+static int powernv_leds_count(struct device_node *led_node)
+{
+	const char *cur = NULL;
+	int num_leds = 0;
+	struct property *p;
+	struct device_node *np;
+
+	for_each_child_of_node(led_node, np) {
+		p = of_find_property(np, "led-types", NULL);
+		if (!p)
+			continue;
+
+		while ((cur = of_prop_next_string(p, cur)) != NULL)
+			num_leds++;
+	}
+
+	return num_leds;
+}
+
+/* Platform driver probe */
+static int powernv_led_probe(struct platform_device *pdev)
+{
+	int num_leds;
+	struct device_node *led_node;
+	struct powernv_leds_priv *priv;
+
+	led_node = of_find_node_by_path("/ibm,opal/led");
+	if (!led_node) {
+		dev_err(&pdev->dev,
+			"%s: LED parent device node not found\n", __func__);
+		return -EINVAL;
+	}
+
+	num_leds = powernv_leds_count(led_node);
+	if (num_leds <= 0) {
+		dev_err(&pdev->dev,
+			"%s: No location code found under LED node\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	priv = devm_kzalloc(&pdev->dev,
+			    sizeof_powernv_leds_priv(num_leds),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	return powernv_led_classdev(pdev, led_node, priv, num_leds);
+}
+
+/* Platform driver remove */
+static int powernv_led_remove(struct platform_device *pdev)
+{
+	int i;
+	struct powernv_led_data *powernv_led;
+	struct powernv_leds_priv *priv;
+
+	/* Disable LED operation */
+	led_disabled = true;
+
+	priv = platform_get_drvdata(pdev);
+
+	for (i = 0; i < priv->num_leds; i++) {
+		powernv_led = &priv->powernv_leds[i];
+		powernv_led_delete(powernv_led);
+		flush_work(&powernv_led->work_led);
+	}
+
+	dev_info(&pdev->dev, "PowerNV led module unregistered\n");
+	return 0;
+}
+
+/* Platform driver property match */
+static const struct of_device_id powernv_led_match[] = {
+	{
+		.compatible	= "ibm,opal-v3-led",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, powernv_led_match);
+
+static struct platform_driver powernv_led_driver = {
+	.probe	= powernv_led_probe,
+	.remove = powernv_led_remove,
+	.driver = {
+		.name = "powernv-led-driver",
+		.owner = THIS_MODULE,
+		.of_match_table = powernv_led_match,
+	},
+};
+
+module_platform_driver(powernv_led_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PowerNV LED driver");
+MODULE_AUTHOR("Vasant Hegde <hegdevasant@linux.vnet.ibm.com>");
