Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE9671A2B7E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 18:01:55 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 20 Apr 2015 13:31:53 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 09A54125805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:33:46 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3K81nuC1769866
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:31:49 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3K7cn9B009360
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 13:08:51 +0530
Subject: [PATCH v3 3/3] leds/powernv: Add driver for PowerNV platform
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org
Date: Mon, 20 Apr 2015 13:31:45 +0530
Message-ID: <20150420080124.12371.41528.stgit@localhost.localdomain>
In-Reply-To: <20150420075558.12371.6697.stgit@localhost.localdomain>
References: <20150420075558.12371.6697.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com, rpurdie@rpsys.net,
 j.anaszewski@samsung.com, khandual@linux.vnet.ibm.com
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

We registers classdev structures for all individual LEDs detected on the
system through LED specific device tree nodes. Device tree nodes specify
what  all kind of LEDs present on the same location code. It registers
LED classdev structure for each of them.

All the system LEDs can be found in the same regular path /sys/class/leds/.
We don't use LED colors. Hence our LEDs have names in this format.

        <location_code>:<ATTENTION|IDENT|FAULT>

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

 .../devicetree/bindings/leds/leds-powernv.txt      |   34 +
 drivers/leds/Kconfig                               |   11 
 drivers/leds/Makefile                              |    1 
 drivers/leds/leds-powernv.c                        |  455 ++++++++++++++++++++
 4 files changed, 501 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-powernv.txt
 create mode 100644 drivers/leds/leds-powernv.c

diff --git a/Documentation/devicetree/bindings/leds/leds-powernv.txt b/Documentation/devicetree/bindings/leds/leds-powernv.txt
new file mode 100644
index 0000000..4953fdf
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-powernv.txt
@@ -0,0 +1,34 @@
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
+
+'compatible' property describes LEDs compatibility.
+
+'led-mode' property describes service indicator mode (lightpath/guidinglight).
+
+Each node under 'led' node describes location code of FRU/Enclosure.
+
+The properties under each node:
+
+  led-types : Supported indicators (attention/identify/fault).
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
index 0000000..e3c033d
--- /dev/null
+++ b/drivers/leds/leds-powernv.c
@@ -0,0 +1,455 @@
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
+#define PREFIX		"POWERNV_LED"
+
+#include <linux/leds.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <asm/opal.h>
+
+#define POWERNV_LED_ATTN	":ATTENTION"
+#define POWERNV_LED_IDENT	":IDENT"
+#define POWERNV_LED_FAULT	":FAULT"
+
+/*
+ * By default unload path resets all the LEDs. But on PowerNV platform
+ * we want to retain LED state across reboot as these are controlled by
+ * firmware. Also service processor can modify the LEDs independent of
+ * OS. Hence avoid resetting LEDs in unload path.
+ */
+static bool led_disabled;
+
+/* Converts LED event type into it's description. */
+static const char *led_type_map[OPAL_SLOT_LED_TYPE_MAX] = {
+	"Attention", "Ident", "Fault"
+};
+
+/*
+ * LED set routines have been implemented as work queue tasks scheduled
+ * on the global work queue. Individual task calls OPAL interface to set
+ * the LED state which might sleep for some time.
+ */
+struct powernv_led_data {
+	struct led_classdev	cdev;
+
+	u64			led_type;  /* Attention or Ident or Fault */
+	enum led_brightness	value;     /* Brightness value */
+
+	struct mutex		lock;
+	struct work_struct	work_led; /* LED update workqueue */
+
+	struct list_head	link;
+};
+static LIST_HEAD(powernv_led_list);
+
+
+/* Get LED location code based on LED name */
+static int powernv_get_loc_code(u64 led_type, char *loc_code)
+{
+	switch (led_type) {
+	case OPAL_SLOT_LED_TYPE_ATTN:
+		loc_code[strlen(loc_code) - strlen(POWERNV_LED_ATTN)] = '\0';
+		break;
+	case OPAL_SLOT_LED_TYPE_ID:
+		loc_code[strlen(loc_code) - strlen(POWERNV_LED_IDENT)] = '\0';
+		break;
+	case OPAL_SLOT_LED_TYPE_FAULT:
+		loc_code[strlen(loc_code) - strlen(POWERNV_LED_FAULT)] = '\0';
+		break;
+	default:	/* Unsupported LED type */
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * This commits the state change of the requested LED through an OPAL call.
+ * This function is called from work queue task context when ever it gets
+ * scheduled. This function can sleep at opal_async_wait_response call.
+ */
+static void powernv_led_set(struct led_classdev *led_cdev,
+			    enum led_brightness value, u64 led_type)
+{
+	char *loc_code;
+	int rc, token;
+	u64 led_mask, max_led_type, led_value = 0;
+	struct opal_msg msg;
+
+	/* Location code of the LED */
+	loc_code = kasprintf(GFP_KERNEL, "%s", led_cdev->name);
+	if (!loc_code) {
+		dev_err(led_cdev->dev,
+			"%s: Memory allocation failed\n", __func__);
+		return;
+	}
+
+	if (powernv_get_loc_code(led_type, loc_code) != 0)
+		goto out_loc;
+
+	/* Prepare for the OPAL call */
+	max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
+	led_mask = OPAL_SLOT_LED_STATE_ON << led_type;
+	if (value)
+		led_value = OPAL_SLOT_LED_STATE_ON << led_type;
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
+static enum led_brightness powernv_led_get(struct led_classdev *led_cdev,
+					   u64 led_type)
+{
+	char *loc_code;
+	int rc;
+	u64 led_mask, led_value, max_led_type;
+
+	/* LED location code */
+	loc_code = kasprintf(GFP_KERNEL, "%s", led_cdev->name);
+	if (!loc_code) {
+		dev_err(led_cdev->dev,
+			"%s: Memory allocation failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	if (powernv_get_loc_code(led_type, loc_code) != 0)
+		goto led_fail;
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
+			"%s: %s LED status not available for %s\n",
+			__func__, led_type_map[led_type], loc_code);
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
+/*
+ * This the function which will be executed by any LED work task on the
+ * global work queue.
+ */
+static void powernv_deferred_led_set(struct work_struct *work)
+{
+	struct powernv_led_data *powernv_led =
+		container_of(work, struct powernv_led_data, work_led);
+
+	mutex_lock(&powernv_led->lock);
+	powernv_led_set(&powernv_led->cdev,
+			powernv_led->value, powernv_led->led_type);
+	mutex_unlock(&powernv_led->lock);
+}
+
+/* Schedule work to update LED state */
+static void powernv_led_set_queue(struct led_classdev *led_cdev,
+				  enum led_brightness value, u64 led_type)
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
+	powernv_led->led_type = led_type;
+
+	/* Schedule the new task */
+	schedule_work(&powernv_led->work_led);
+}
+
+
+/* LED classdev 'brightness_set' function for attention LED. */
+static void powernv_led_set_attn(struct led_classdev *led_cdev,
+				  enum led_brightness value)
+{
+	return powernv_led_set_queue(led_cdev, value, OPAL_SLOT_LED_TYPE_ATTN);
+}
+
+/* LED classdev 'brightness_get' function for attention LED.  */
+static enum led_brightness powernv_led_get_attn(struct led_classdev *led_cdev)
+{
+	return powernv_led_get(led_cdev, OPAL_SLOT_LED_TYPE_ATTN);
+}
+
+/* LED classdev 'brightness_set' function for ident LED types. */
+static void powernv_led_set_ident(struct led_classdev *led_cdev,
+				  enum led_brightness value)
+{
+	return powernv_led_set_queue(led_cdev, value, OPAL_SLOT_LED_TYPE_ID);
+}
+
+/* LED classdev 'brightness_get' function for ident LED types. */
+static enum led_brightness powernv_led_get_ident(struct led_classdev *led_cdev)
+{
+	return powernv_led_get(led_cdev, OPAL_SLOT_LED_TYPE_ID);
+}
+
+/* LED classdev 'brightness_set' function for fault LED types. */
+static void powernv_led_set_fault(struct led_classdev *led_cdev,
+				  enum led_brightness value)
+{
+	return powernv_led_set_queue(led_cdev, value, OPAL_SLOT_LED_TYPE_FAULT);
+}
+
+/* LED classdev 'brightness_get' function for fault LED types. */
+static enum led_brightness powernv_led_get_fault(struct led_classdev *led_cdev)
+{
+	return powernv_led_get(led_cdev, OPAL_SLOT_LED_TYPE_FAULT);
+}
+
+
+/*
+ * This function verifies whether the child LED device node supports certain
+ * type of LED or not. This will be used to register LED classdev structures
+ * for that particual type of LED for a given device tree node.
+ */
+static bool has_led_type(struct device_node *node, const char *led_type)
+{
+	bool result = false;
+
+	if (of_property_match_string(node, "led-types", led_type) >= 0)
+		result = true;
+
+	return result;
+}
+
+/*
+ * This function registers classdev structure for any given type of LED on
+ * a given child LED device node.
+ */
+static int power_led_classdev(struct platform_device *pdev,
+			      struct device_node *node, u64 led_type)
+{
+	int rc;
+	struct powernv_led_data *powernv_led;
+
+	powernv_led = kzalloc(sizeof(struct powernv_led_data), GFP_KERNEL);
+	if (!powernv_led) {
+		dev_err(&pdev->dev,
+			"%s: Memory allocation failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	/* Create the name for classdev */
+	switch (led_type) {
+	case OPAL_SLOT_LED_TYPE_ATTN:
+		powernv_led->cdev.name = kasprintf(GFP_KERNEL,
+						   "%s%s", node->name,
+						   POWERNV_LED_ATTN);
+		powernv_led->cdev.brightness_set = powernv_led_set_attn;
+		powernv_led->cdev.brightness_get = powernv_led_get_attn;
+		break;
+	case OPAL_SLOT_LED_TYPE_ID:
+		powernv_led->cdev.name = kasprintf(GFP_KERNEL,
+						   "%s%s", node->name,
+						   POWERNV_LED_IDENT);
+		powernv_led->cdev.brightness_set = powernv_led_set_ident;
+		powernv_led->cdev.brightness_get = powernv_led_get_ident;
+		break;
+	case OPAL_SLOT_LED_TYPE_FAULT:
+		powernv_led->cdev.name = kasprintf(GFP_KERNEL,
+						   "%s%s", node->name,
+						   POWERNV_LED_FAULT);
+		powernv_led->cdev.brightness_set = powernv_led_set_fault;
+		powernv_led->cdev.brightness_get = powernv_led_get_fault;
+		break;
+	default: /* Unsupported LED type */
+		kfree(powernv_led);
+		return -EINVAL;
+	}
+
+	if (!powernv_led->cdev.name) {
+		dev_err(&pdev->dev,
+			"%s: Memory allocation failed for classdev name\n",
+			__func__);
+		kfree(powernv_led);
+		return -ENOMEM;
+	}
+
+	powernv_led->cdev.brightness = LED_OFF;
+	powernv_led->cdev.max_brightness = LED_FULL;
+	powernv_led->cdev.flags = LED_CORE_SUSPENDRESUME;
+
+	mutex_init(&powernv_led->lock);
+	INIT_WORK(&powernv_led->work_led, powernv_deferred_led_set);
+
+	/* Register the classdev */
+	rc = led_classdev_register(&pdev->dev, &powernv_led->cdev);
+	if (rc) {
+		dev_err(&pdev->dev, "%s: Classdev registration failed for %s\n",
+			__func__, powernv_led->cdev.name);
+		kfree(powernv_led->cdev.name);
+		kfree(powernv_led);
+	} else {
+		list_add_tail(&powernv_led->link, &powernv_led_list);
+		dev_dbg(&pdev->dev,
+			"Classdev registration successful for %s\n",
+			powernv_led->cdev.name);
+	}
+	return rc;
+}
+
+/* Platform driver probe */
+static int powernv_led_probe(struct platform_device *pdev)
+{
+	int rc = 0;
+	struct device_node *led_node, *np;
+
+	led_node = of_find_node_by_path("/ibm,opal/led");
+	if (!led_node) {
+		dev_err(&pdev->dev,
+			"%s: LED parent device node not found\n", __func__);
+		return -EINVAL;
+	}
+
+	for_each_child_of_node(led_node, np) {
+		if (has_led_type(np, LED_TYPE_ATTENTION))
+			rc = power_led_classdev(pdev, np,
+						OPAL_SLOT_LED_TYPE_ATTN);
+
+		if (has_led_type(np, LED_TYPE_IDENTIFY))
+			rc = power_led_classdev(pdev, np,
+						OPAL_SLOT_LED_TYPE_ID);
+
+		if (has_led_type(np, LED_TYPE_FAULT))
+			rc = power_led_classdev(pdev, np,
+						OPAL_SLOT_LED_TYPE_FAULT);
+	}
+	return rc;
+}
+
+/* Platform driver remove */
+static int powernv_led_remove(struct platform_device *pdev)
+{
+	struct powernv_led_data *powernv_led;
+
+	/* Disable LED operation */
+	led_disabled = true;
+
+	dev_dbg(&pdev->dev,
+		"%s: Unregister all classdev structures\n", __func__);
+	list_for_each_entry(powernv_led, &powernv_led_list, link)
+		led_classdev_unregister(&powernv_led->cdev);
+
+	dev_dbg(&pdev->dev,
+		"%s: Wait for all work tasks to finish\n", __func__);
+	list_for_each_entry(powernv_led, &powernv_led_list, link)
+		flush_work(&powernv_led->work_led);
+
+	while (!list_empty(&powernv_led_list)) {
+		powernv_led = list_first_entry(&powernv_led_list,
+					       struct powernv_led_data, link);
+		list_del(&powernv_led->link);
+		kfree(powernv_led);
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
