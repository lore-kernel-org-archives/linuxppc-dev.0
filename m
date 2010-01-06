Return-Path: <bgat@billgatliff.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id DDC04B6EF4
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 15:30:16 +1100 (EST)
Received: by iwn11 with SMTP id 11so12662654iwn.17
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Jan 2010 20:30:15 -0800 (PST)
From: Bill Gatliff <bgat@billgatliff.com>
To: linuxppc-dev@ozlabs.org,
	lm-sensors@lm-sensors.org
Subject: [PATCH 2/2] Reorder initialization to better support device tree data
Date: Tue,  5 Jan 2010 22:30:36 -0600
Message-Id: <1262752236-1937-4-git-send-email-bgat@billgatliff.com>
In-Reply-To: <1262752236-1937-3-git-send-email-bgat@billgatliff.com>
References: <1262752236-1937-1-git-send-email-bgat@billgatliff.com>
	<1262752236-1937-2-git-send-email-bgat@billgatliff.com>
	<1262752236-1937-3-git-send-email-bgat@billgatliff.com>
Cc: Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch changes the initialization sequence implemented in
pca953x_probe(), so as to simplify the retrieval of device tree
data when device trees are used.  Incorporates the new
of_i2c_gpiochip_add() function to register the newly-added GPIOs.

Signed-off-by: Bill Gatliff <bgat@billgatliff.com>
---
 drivers/gpio/pca953x.c |  130 +++++++++++++++++++++--------------------------
 1 files changed, 58 insertions(+), 72 deletions(-)

diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index 9c70963..3a20e2f 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
  *  Copyright (C) 2007 Marvell International Ltd.
+ *  Copyright (C) 2010 Bill Gatliff <bgat@billgatliff.com>
  *
  *  Derived from drivers/i2c/chips/pca9539.c
  *
@@ -53,13 +54,13 @@ static const struct i2c_device_id pca953x_id[] = {
 MODULE_DEVICE_TABLE(i2c, pca953x_id);
 
 struct pca953x_chip {
-	unsigned gpio_start;
 	uint16_t reg_output;
 	uint16_t reg_direction;
+	uint16_t reg_invert;
 	struct gpio_chip *gpio_chip;
 
 	struct i2c_client *client;
-	struct pca953x_platform_data *dyn_pdata;
+	struct pca953x_platform_data *pdata;
 	char **names;
 
 #ifdef CONFIG_OF_GPIO
@@ -214,7 +215,6 @@ static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 	gc->set = pca953x_gpio_set_value;
 	gc->can_sleep = 1;
 
-	gc->base = chip->gpio_start;
 	gc->ngpio = gpios;
 	gc->label = chip->client->name;
 	gc->dev = &chip->client->dev;
@@ -222,119 +222,107 @@ static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 	gc->names = chip->names;
 }
 
-/*
- * Handlers for alternative sources of platform_data
- */
 #ifdef CONFIG_OF_GPIO
-/*
- * Translate OpenFirmware node properties into platform_data
- */
-static struct pca953x_platform_data *
-pca953x_get_alt_pdata(struct i2c_client *client)
+static int __devinit pca953x_get_of_pdata(struct pca953x_chip *chip)
 {
-	struct pca953x_platform_data *pdata;
 	struct device_node *node;
 	const uint16_t *val;
 
-	node = dev_archdata_get_node(&client->dev.archdata);
-	if (node == NULL)
-		return NULL;
+	node = dev_archdata_get_node(&chip->client->dev.archdata);
+	if (!node)
+		return -EINVAL;
 
-	pdata = kzalloc(sizeof(struct pca953x_platform_data), GFP_KERNEL);
-	if (pdata == NULL) {
-		dev_err(&client->dev, "Unable to allocate platform_data\n");
-		return NULL;
-	}
-
-	pdata->gpio_base = -1;
-	val = of_get_property(node, "linux,gpio-base", NULL);
-	if (val) {
-		if (*val < 0)
-			dev_warn(&client->dev,
-				 "invalid gpio-base in device tree\n");
-		else
-			pdata->gpio_base = *val;
-	}
+	chip->gpio_chip->base = -1;
+	chip->i2c_gc.of_gc.gpio_cells = 2;
 
 	val = of_get_property(node, "polarity", NULL);
 	if (val)
-		pdata->invert = *val;
+		chip->reg_invert = *val;
 
-	return pdata;
+	return 0;
 }
-#else
-static struct pca953x_platform_data *
-pca953x_get_alt_pdata(struct i2c_client *client)
+
+static int __devinit pca953x_gpiochip_add(struct pca953x_chip *chip)
 {
-	return NULL;
+	struct device_node *node;
+	node = dev_archdata_get_node(&chip->client->dev.archdata);
+	return of_i2c_gpiochip_add(node, &chip->i2c_gc);
 }
 #endif
 
+static int __devinit pca953x_get_pdata(struct pca953x_chip *chip)
+{
+	struct pca953x_platform_data *pdata;
+
+	pdata = dev_get_platdata(&chip->client->dev);
+	if (!pdata)
+		return -EINVAL;
+
+	chip->pdata = pdata;
+	chip->gpio_chip->base = pdata->gpio_base;
+	chip->reg_invert = pdata->invert;
+
+	return 0;
+}
+
 static int __devinit pca953x_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
-	struct pca953x_platform_data *pdata;
 	struct pca953x_chip *chip;
 	int ret;
 
 	chip = kzalloc(sizeof(struct pca953x_chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
+	chip->client = client;
 
 #ifdef CONFIG_OF_GPIO
 	chip->gpio_chip = &chip->i2c_gc.of_gc.gc;
+	if (!dev_get_platdata(&client->dev))
+		pca953x_get_of_pdata(chip);
 #else
 	chip->gpio_chip = &chip->gc;
-#endif
-
-	pdata = client->dev.platform_data;
-	if (pdata == NULL) {
-		pdata = pca953x_get_alt_pdata(client);
-		/*
-		 * Unlike normal platform_data, this is allocated
-		 * dynamically and must be freed in the driver
-		 */
-		chip->dyn_pdata = pdata;
-	}
-
-	if (pdata == NULL) {
-		dev_dbg(&client->dev, "no platform data\n");
+	if (!client->dev.platform_data)
+	{
+		dev_err(&client->dev, "no platform data\n");
 		ret = -EINVAL;
 		goto out_failed;
 	}
+#endif
 
-	chip->client = client;
-
-	chip->gpio_start = pdata->gpio_base;
+	pca953x_setup_gpio(chip, id->driver_data);
 
-	chip->names = pdata->names;
+	if (dev_get_platdata(&client->dev))
+		pca953x_get_pdata(chip);
 
-	/* initialize cached registers from their original values.
-	 * we can't share this chip with another i2c master.
+	/*
+	 * Note: we cache the values of some registers locally; this
+	 * means that other i2c masters, if any, cannot share this
+	 * chip with us!
 	 */
-	pca953x_setup_gpio(chip, id->driver_data);
 
 	ret = pca953x_read_reg(chip, PCA953X_OUTPUT, &chip->reg_output);
 	if (ret)
 		goto out_failed;
-
 	ret = pca953x_read_reg(chip, PCA953X_DIRECTION, &chip->reg_direction);
 	if (ret)
 		goto out_failed;
-
-	/* set platform specific polarity inversion */
-	ret = pca953x_write_reg(chip, PCA953X_INVERT, pdata->invert);
+	ret = pca953x_write_reg(chip, PCA953X_INVERT, chip->reg_invert);
 	if (ret)
 		goto out_failed;
 
-
+#ifdef CONFIG_OF_GPIO
+	ret = pca953x_gpiochip_add(chip);
+#else
 	ret = gpiochip_add(chip->gpio_chip);
+#endif
 	if (ret)
 		goto out_failed;
 
-	if (pdata->setup) {
-		ret = pdata->setup(client, chip->gpio_chip->base,
-				chip->gpio_chip->ngpio, pdata->context);
+	if (chip->pdata && chip->pdata->setup) {
+		ret = chip->pdata->setup(client, chip->gpio_chip->base,
+				chip->gpio_chip->ngpio,
+					 chip->pdata->context);
 		if (ret < 0)
 			dev_warn(&client->dev, "setup failed, %d\n", ret);
 	}
@@ -343,20 +331,19 @@ static int __devinit pca953x_probe(struct i2c_client *client,
 	return 0;
 
 out_failed:
-	kfree(chip->dyn_pdata);
 	kfree(chip);
 	return ret;
 }
 
 static int pca953x_remove(struct i2c_client *client)
 {
-	struct pca953x_platform_data *pdata = client->dev.platform_data;
 	struct pca953x_chip *chip = i2c_get_clientdata(client);
 	int ret = 0;
 
-	if (pdata->teardown) {
-		ret = pdata->teardown(client, chip->gpio_chip->base,
-				chip->gpio_chip->ngpio, pdata->context);
+	if (chip->pdata && chip->pdata->teardown) {
+		ret = chip->pdata->teardown(client, chip->gpio_chip->base,
+					    chip->gpio_chip->ngpio,
+					    chip->pdata->context);
 		if (ret < 0) {
 			dev_err(&client->dev, "%s failed, %d\n",
 					"teardown", ret);
@@ -371,7 +358,6 @@ static int pca953x_remove(struct i2c_client *client)
 		return ret;
 	}
 
-	kfree(chip->dyn_pdata);
 	kfree(chip);
 	return 0;
 }
-- 
1.6.5
