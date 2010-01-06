Return-Path: <bgat@billgatliff.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id DB166B6EF2
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 15:30:16 +1100 (EST)
Received: by iwn11 with SMTP id 11so12662653iwn.17
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Jan 2010 20:30:15 -0800 (PST)
From: Bill Gatliff <bgat@billgatliff.com>
To: linuxppc-dev@ozlabs.org,
	lm-sensors@lm-sensors.org
Subject: [PATCH 1/2] Use struct of_i2c_gpio_chip instead of raw struct
	gpio_chip
Date: Tue,  5 Jan 2010 22:30:35 -0600
Message-Id: <1262752236-1937-3-git-send-email-bgat@billgatliff.com>
In-Reply-To: <1262752236-1937-2-git-send-email-bgat@billgatliff.com>
References: <1262752236-1937-1-git-send-email-bgat@billgatliff.com>
	<1262752236-1937-2-git-send-email-bgat@billgatliff.com>
Cc: Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is the first in a series that improves the pca953x driver's
support for CONFIG_OF_GPIO a.k.a. device trees.  It modifies the driver's
chip structure definition to use a struct gpio_chip contained in a struct
of_i2c_gpio_chip when CONFIG_OF_GPIO is set.  If OF_GPIO is not used,
an ordinary struct gpio_chip is employed.

Signed-off-by: Bill Gatliff <bgat@billgatliff.com>
---
 drivers/gpio/pca953x.c |   50 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index b097043..9c70963 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -56,18 +56,34 @@ struct pca953x_chip {
 	unsigned gpio_start;
 	uint16_t reg_output;
 	uint16_t reg_direction;
+	struct gpio_chip *gpio_chip;
 
 	struct i2c_client *client;
 	struct pca953x_platform_data *dyn_pdata;
-	struct gpio_chip gpio_chip;
 	char **names;
+
+#ifdef CONFIG_OF_GPIO
+	struct of_i2c_gpio_chip i2c_gc;
+#else
+	struct gpio_chip gc;
+#endif
 };
 
+static inline struct pca953x_chip *to_pca953x_chip(struct gpio_chip *gc)
+{
+#ifdef CONFIG_OF_GPIO
+	return container_of(gc, struct pca953x_chip, i2c_gc.of_gc.gc);
+#else
+	return container_of(gc, struct pca953x_chip, gc);
+#endif
+}
+
+
 static int pca953x_write_reg(struct pca953x_chip *chip, int reg, uint16_t val)
 {
 	int ret;
 
-	if (chip->gpio_chip.ngpio <= 8)
+	if (chip->gpio_chip->ngpio <= 8)
 		ret = i2c_smbus_write_byte_data(chip->client, reg, val);
 	else
 		ret = i2c_smbus_write_word_data(chip->client, reg << 1, val);
@@ -84,7 +100,7 @@ static int pca953x_read_reg(struct pca953x_chip *chip, int reg, uint16_t *val)
 {
 	int ret;
 
-	if (chip->gpio_chip.ngpio <= 8)
+	if (chip->gpio_chip->ngpio <= 8)
 		ret = i2c_smbus_read_byte_data(chip->client, reg);
 	else
 		ret = i2c_smbus_read_word_data(chip->client, reg << 1);
@@ -104,7 +120,7 @@ static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
 	uint16_t reg_val;
 	int ret;
 
-	chip = container_of(gc, struct pca953x_chip, gpio_chip);
+	chip = to_pca953x_chip(gc);
 
 	reg_val = chip->reg_direction | (1u << off);
 	ret = pca953x_write_reg(chip, PCA953X_DIRECTION, reg_val);
@@ -122,7 +138,7 @@ static int pca953x_gpio_direction_output(struct gpio_chip *gc,
 	uint16_t reg_val;
 	int ret;
 
-	chip = container_of(gc, struct pca953x_chip, gpio_chip);
+	chip = to_pca953x_chip(gc);
 
 	/* set output level */
 	if (val)
@@ -152,7 +168,7 @@ static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
 	uint16_t reg_val;
 	int ret;
 
-	chip = container_of(gc, struct pca953x_chip, gpio_chip);
+	chip = to_pca953x_chip(gc);
 
 	ret = pca953x_read_reg(chip, PCA953X_INPUT, &reg_val);
 	if (ret < 0) {
@@ -172,7 +188,7 @@ static void pca953x_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
 	uint16_t reg_val;
 	int ret;
 
-	chip = container_of(gc, struct pca953x_chip, gpio_chip);
+	chip = to_pca953x_chip(gc);
 
 	if (val)
 		reg_val = chip->reg_output | (1u << off);
@@ -190,7 +206,7 @@ static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 {
 	struct gpio_chip *gc;
 
-	gc = &chip->gpio_chip;
+	gc = chip->gpio_chip;
 
 	gc->direction_input  = pca953x_gpio_direction_input;
 	gc->direction_output = pca953x_gpio_direction_output;
@@ -265,6 +281,12 @@ static int __devinit pca953x_probe(struct i2c_client *client,
 	if (chip == NULL)
 		return -ENOMEM;
 
+#ifdef CONFIG_OF_GPIO
+	chip->gpio_chip = &chip->i2c_gc.of_gc.gc;
+#else
+	chip->gpio_chip = &chip->gc;
+#endif
+
 	pdata = client->dev.platform_data;
 	if (pdata == NULL) {
 		pdata = pca953x_get_alt_pdata(client);
@@ -306,13 +328,13 @@ static int __devinit pca953x_probe(struct i2c_client *client,
 		goto out_failed;
 
 
-	ret = gpiochip_add(&chip->gpio_chip);
+	ret = gpiochip_add(chip->gpio_chip);
 	if (ret)
 		goto out_failed;
 
 	if (pdata->setup) {
-		ret = pdata->setup(client, chip->gpio_chip.base,
-				chip->gpio_chip.ngpio, pdata->context);
+		ret = pdata->setup(client, chip->gpio_chip->base,
+				chip->gpio_chip->ngpio, pdata->context);
 		if (ret < 0)
 			dev_warn(&client->dev, "setup failed, %d\n", ret);
 	}
@@ -333,8 +355,8 @@ static int pca953x_remove(struct i2c_client *client)
 	int ret = 0;
 
 	if (pdata->teardown) {
-		ret = pdata->teardown(client, chip->gpio_chip.base,
-				chip->gpio_chip.ngpio, pdata->context);
+		ret = pdata->teardown(client, chip->gpio_chip->base,
+				chip->gpio_chip->ngpio, pdata->context);
 		if (ret < 0) {
 			dev_err(&client->dev, "%s failed, %d\n",
 					"teardown", ret);
@@ -342,7 +364,7 @@ static int pca953x_remove(struct i2c_client *client)
 		}
 	}
 
-	ret = gpiochip_remove(&chip->gpio_chip);
+	ret = gpiochip_remove(chip->gpio_chip);
 	if (ret) {
 		dev_err(&client->dev, "%s failed, %d\n",
 				"gpiochip_remove()", ret);
-- 
1.6.5
