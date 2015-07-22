Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4EB31A1A60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 00:53:16 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 22 Jul 2015 20:23:13 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8DA9F1258063
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 20:26:08 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6MEqvoE57082000
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 20:22:57 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6MEqt67023397
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 20:22:55 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linux-leds@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 j.anaszewski@samsung.com
Cc: stewart@linux.vnet.ibm.com, arnd@arndb.de, j.anaszewski81@gmail.com,
 cooloney@gmail.com, rpurdie@rpsys.net, khandual@linux.vnet.ibm.com,
 mpe@ellerman.id.au, benh@kernel.crashing.org,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH v7 3/3] leds/powernv: Add driver for PowerNV platform
Date: Wed, 22 Jul 2015 20:22:47 +0530
Message-Id: <1437576767-28496-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
In-Reply-To: <1437576767-28496-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
References: <1437576767-28496-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
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

The platform level implementation of LED get and set state has been
achieved through OPAL calls. These calls are made available for the
driver by exporting from architecture specific codes.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Tested-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 .../devicetree/bindings/leds/leds-powernv.txt      |  26 ++
 drivers/leds/Kconfig                               |  11 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-powernv.c                        | 342 +++++++++++++++++++++
 4 files changed, 380 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-powernv.txt
 create mode 100644 drivers/leds/leds-powernv.c

diff --git a/Documentation/devicetree/bindings/leds/leds-powernv.txt b/Documentation/devicetree/bindings/leds/leds-powernv.txt
new file mode 100644
index 0000000..6665569
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-powernv.txt
@@ -0,0 +1,26 @@
+Device Tree binding for LEDs on IBM Power Systems
+-------------------------------------------------
+
+Required properties:
+- compatible : Should be "ibm,opal-v3-led".
+- led-mode   : Should be "lightpath" or "guidinglight".
+
+Each location code of FRU/Enclosure must be expressed in the
+form of a sub-node.
+
+Required properties for the sub nodes:
+- led-types : Supported LED types (attention/identify/fault) provided
+              in the form of string array.
+
+Example:
+
+leds {
+	compatible = "ibm,opal-v3-led";
+	led-mode = "lightpath";
+
+	U78C9.001.RST0027-P1-C1 {
+		led-types = "identify", "fault";
+	};
+	...
+	...
+};
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 9ad35f7..f218cc3a 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -560,6 +560,17 @@ config LEDS_BLINKM
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
index 8d6a24a..6a943d1 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
 obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
 obj-$(CONFIG_LEDS_PM8941_WLED)		+= leds-pm8941-wled.o
 obj-$(CONFIG_LEDS_KTD2692)		+= leds-ktd2692.o
+obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
new file mode 100644
index 0000000..9e70291
--- /dev/null
+++ b/drivers/leds/leds-powernv.c
@@ -0,0 +1,342 @@
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
+ * By default unload path resets all the LEDs. But on PowerNV platform
+ * we want to retain LED state across reboot as these are controlled by
+ * firmware. Also service processor can modify the LEDs independent of
+ * OS. Hence avoid resetting LEDs in unload path.
+ */
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
+/* PowerNV LED data */
+struct powernv_led_data {
+	struct led_classdev	cdev;
+	char			*loc_code;	/* LED location code */
+	int			led_type;	/* OPAL_SLOT_LED_TYPE_* */
+	enum led_brightness	value;		/* Brightness value */
+
+	__be64			*max_led_type;	/* Max supported LED type */
+	struct mutex		*lock;		/* glabal lock */
+};
+
+
+/* Returns OPAL_SLOT_LED_TYPE_* for given led type string */
+static int powernv_get_led_type(const char *led_type_desc)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(led_type_map); i++)
+		if (!strcmp(led_type_map[i].desc, led_type_desc))
+			return led_type_map[i].type;
+
+	return -1;
+}
+
+/*
+ * This commits the state change of the requested LED through an OPAL call.
+ * This function is called from work queue task context when ever it gets
+ * scheduled. This function can sleep at opal_async_wait_response call.
+ */
+static void powernv_led_set(struct powernv_led_data *powernv_led)
+{
+	int rc, token;
+	u64 led_mask, led_value = 0;
+	__be64 max_type;
+	struct opal_msg msg;
+	struct device *dev = powernv_led->cdev.dev;
+
+	/* Prepare for the OPAL call */
+	max_type = *(powernv_led->max_led_type);
+	led_mask = OPAL_SLOT_LED_STATE_ON << powernv_led->led_type;
+	if (powernv_led->value)
+		led_value = led_mask;
+
+	/* OPAL async call */
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		if (token != -ERESTARTSYS)
+			dev_err(dev, "%s: Couldn't get OPAL async token\n",
+				__func__);
+		return;
+	}
+
+	rc = opal_leds_set_ind(token, powernv_led->loc_code,
+			       led_mask, led_value, &max_type);
+	if (rc != OPAL_ASYNC_COMPLETION) {
+		dev_err(dev, "%s: OPAL set LED call failed for %s [rc=%d]\n",
+			__func__, powernv_led->loc_code, rc);
+		goto out_token;
+	}
+
+	rc = opal_async_wait_response(token, &msg);
+	if (rc) {
+		dev_err(dev,
+			"%s: Failed to wait for the async response [rc=%d]\n",
+			__func__, rc);
+		goto out_token;
+	}
+
+	rc = be64_to_cpu(msg.params[1]);
+	if (rc != OPAL_SUCCESS)
+		dev_err(dev, "%s : OAPL async call returned failed [rc=%d]\n",
+			__func__, rc);
+
+out_token:
+	opal_async_release_token(token);
+}
+
+/*
+ * This function fetches the LED state for a given LED type for
+ * mentioned LED classdev structure.
+ */
+static enum led_brightness
+powernv_led_get(struct powernv_led_data *powernv_led)
+{
+	int rc;
+	__be64 mask, value, max_type;
+	u64 led_mask, led_value;
+	struct device *dev = powernv_led->cdev.dev;
+
+	/* Fetch all LED status */
+	mask = cpu_to_be64(0);
+	value = cpu_to_be64(0);
+	max_type = *(powernv_led->max_led_type);
+
+	rc = opal_leds_get_ind(powernv_led->loc_code,
+			       &mask, &value, &max_type);
+	if (rc != OPAL_SUCCESS && rc != OPAL_PARTIAL) {
+		dev_err(dev, "%s: OPAL get led call failed [rc=%d]\n",
+			__func__, rc);
+		return LED_OFF;
+	}
+
+	led_mask = be64_to_cpu(mask);
+	led_value = be64_to_cpu(value);
+
+	/* LED status available */
+	if (!((led_mask >> powernv_led->led_type) & OPAL_SLOT_LED_STATE_ON)) {
+		dev_err(dev, "%s: LED status not available for %s\n",
+			__func__, powernv_led->cdev.name);
+		return LED_OFF;
+	}
+
+	/* LED status value */
+	if ((led_value >> powernv_led->led_type) & OPAL_SLOT_LED_STATE_ON)
+		return LED_FULL;
+
+	return LED_OFF;
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
+	 return powernv_led_set(powernv_led);
+}
+
+/* LED classdev 'brightness_get' function */
+static enum led_brightness
+powernv_brightness_get(struct led_classdev *led_cdev)
+{
+	struct powernv_led_data *powernv_led =
+		container_of(led_cdev, struct powernv_led_data, cdev);
+
+	return powernv_led_get(powernv_led);
+}
+
+
+/*
+ * This function registers classdev structure for any given type of LED on
+ * a given child LED device node.
+ */
+static int powernv_led_create(struct device *dev,
+			      struct powernv_led_data *powernv_led,
+			      const char *led_type_desc)
+{
+	int rc;
+
+	/* Make sure LED type is supported */
+	powernv_led->led_type = powernv_get_led_type(led_type_desc);
+	if (powernv_led->led_type == -1) {
+		dev_warn(dev, "%s: No support for led type : %s\n",
+			 __func__, led_type_desc);
+		return -EINVAL;
+	}
+
+	/* Create the name for classdev */
+	powernv_led->cdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s",
+						powernv_led->loc_code,
+						led_type_desc);
+	if (!powernv_led->cdev.name) {
+		dev_err(dev,
+			"%s: Memory allocation failed for classdev name\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	powernv_led->cdev.brightness_set = powernv_brightness_set;
+	powernv_led->cdev.brightness_get = powernv_brightness_get;
+	powernv_led->cdev.brightness = LED_OFF;
+	powernv_led->cdev.max_brightness = LED_FULL;
+
+	/* Register the classdev */
+	rc = devm_led_classdev_register(dev, &powernv_led->cdev);
+	if (rc) {
+		dev_err(dev, "%s: Classdev registration failed for %s\n",
+			__func__, powernv_led->cdev.name);
+	}
+
+	return rc;
+}
+
+/* Go through LED device tree node and register LED classdev structure */
+static int powernv_led_classdev(struct platform_device *pdev,
+				struct device_node *led_node,
+				__be64 *max_led_type, struct mutex *lock)
+{
+	const char *cur = NULL;
+	int rc = -1;
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
+			powernv_led = devm_kzalloc(dev, sizeof(*powernv_led),
+						   GFP_KERNEL);
+			if (!powernv_led)
+				return -ENOMEM;
+
+			powernv_led->loc_code = (char *)np->name;
+			powernv_led->max_led_type = max_led_type;
+			powernv_led->lock = lock;
+
+			rc = powernv_led_create(dev, powernv_led, cur);
+			if (rc)
+				return rc;
+		} /* while end */
+	}
+
+	return rc;
+}
+
+/* Platform driver probe */
+static int powernv_led_probe(struct platform_device *pdev)
+{
+	__be64 *max_led_type;
+	struct mutex *lock;
+	struct device_node *led_node;
+	struct device *dev = &pdev->dev;
+
+	led_node = of_find_node_by_path("/ibm,opal/leds");
+	if (!led_node) {
+		dev_err(dev, "%s: LED parent device node not found\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	lock = devm_kzalloc(dev, sizeof(*lock), GFP_KERNEL);
+	if (!lock)
+		return -ENOMEM;
+
+	max_led_type = devm_kzalloc(dev, sizeof(*max_led_type), GFP_KERNEL);
+	if (!max_led_type)
+		return -ENOMEM;
+
+	mutex_init(lock);
+	*max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
+
+	platform_set_drvdata(pdev, lock);
+
+	return powernv_led_classdev(pdev, led_node, max_led_type, lock);
+}
+
+/* Platform driver remove */
+static int powernv_led_remove(struct platform_device *pdev)
+{
+	struct mutex *lock = platform_get_drvdata(pdev);
+
+	/* Disable LED operation */
+	led_disabled = true;
+
+	mutex_destroy(lock);
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
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("PowerNV LED driver");
+MODULE_AUTHOR("Vasant Hegde <hegdevasant@linux.vnet.ibm.com>");
-- 
2.1.0
