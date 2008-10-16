Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5853ADE479
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 04:13:08 +1100 (EST)
Date: Thu, 16 Oct 2008 21:13:06 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] gpio/pca953x: convert to dev_gpiochip_add and make it
	work with the OF
Message-ID: <20081016171306.GF5515@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With OpenFirmware we can't handle platform data for the devices, so let's
not strictly depend on it. That way we can't set polarity invertion for
this controller, but we'll handle this with active-low/high GPIO flags in
the OF tree.

Also switch the driver to dev_gpiochip calls, so that OF subsystem would
know about the newly registered chips.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/gpio/pca953x.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index cc84686..6e51fda 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -188,7 +188,6 @@ static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 	gc->base = chip->gpio_start;
 	gc->ngpio = gpios;
 	gc->label = chip->client->name;
-	gc->dev = &chip->client->dev;
 	gc->owner = THIS_MODULE;
 }
 
@@ -200,8 +199,6 @@ static int __devinit pca953x_probe(struct i2c_client *client,
 	int ret;
 
 	pdata = client->dev.platform_data;
-	if (pdata == NULL)
-		return -ENODEV;
 
 	chip = kzalloc(sizeof(struct pca953x_chip), GFP_KERNEL);
 	if (chip == NULL)
@@ -209,7 +206,10 @@ static int __devinit pca953x_probe(struct i2c_client *client,
 
 	chip->client = client;
 
-	chip->gpio_start = pdata->gpio_base;
+	if (pdata)
+		chip->gpio_start = pdata->gpio_base;
+	else
+		chip->gpio_start = -1;
 
 	/* initialize cached registers from their original values.
 	 * we can't share this chip with another i2c master.
@@ -225,16 +225,18 @@ static int __devinit pca953x_probe(struct i2c_client *client,
 		goto out_failed;
 
 	/* set platform specific polarity inversion */
-	ret = pca953x_write_reg(chip, PCA953X_INVERT, pdata->invert);
-	if (ret)
-		goto out_failed;
+	if (pdata) {
+		ret = pca953x_write_reg(chip, PCA953X_INVERT, pdata->invert);
+		if (ret)
+			goto out_failed;
+	}
 
 
-	ret = gpiochip_add(&chip->gpio_chip);
+	ret = dev_gpiochip_add(&client->dev, &chip->gpio_chip);
 	if (ret)
 		goto out_failed;
 
-	if (pdata->setup) {
+	if (pdata && pdata->setup) {
 		ret = pdata->setup(client, chip->gpio_chip.base,
 				chip->gpio_chip.ngpio, pdata->context);
 		if (ret < 0)
@@ -255,7 +257,7 @@ static int pca953x_remove(struct i2c_client *client)
 	struct pca953x_chip *chip = i2c_get_clientdata(client);
 	int ret = 0;
 
-	if (pdata->teardown) {
+	if (pdata && pdata->teardown) {
 		ret = pdata->teardown(client, chip->gpio_chip.base,
 				chip->gpio_chip.ngpio, pdata->context);
 		if (ret < 0) {
@@ -265,7 +267,7 @@ static int pca953x_remove(struct i2c_client *client)
 		}
 	}
 
-	ret = gpiochip_remove(&chip->gpio_chip);
+	ret = dev_gpiochip_remove(&client->dev, &chip->gpio_chip);
 	if (ret) {
 		dev_err(&client->dev, "%s failed, %d\n",
 				"gpiochip_remove()", ret);
-- 
1.5.6.3
