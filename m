Return-Path: <shc_work@mail.ru>
Received: from fallback5.mail.ru (fallback5.mail.ru [94.100.176.59])
 by ozlabs.org (Postfix) with ESMTP id 73B481400BF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Mar 2014 16:21:44 +1100 (EST)
Received: from smtp40.i.mail.ru (smtp40.i.mail.ru [94.100.177.100])
 by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id 3ADE11122158D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Mar 2014 09:14:26 +0400 (MSK)
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-gpio@vger.kernel.org
Subject: [PATCH] gpio: ge: Convert to platform driver
Date: Sun, 30 Mar 2014 09:14:15 +0400
Message-Id: <1396156455-4225-1-git-send-email-shc_work@mail.ru>
Cc: Alexandre Courbot <gnurou@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Shiyan <shc_work@mail.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch converts GE I/O FPGA GPIO driver to platform driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
Only compile tested.
---
 drivers/gpio/gpio-ge.c | 176 ++++++++++++++++---------------------------------
 1 file changed, 58 insertions(+), 118 deletions(-)

diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index 7b95a4a..93efb29 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -18,15 +18,9 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/compiler.h>
-#include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/of_gpio.h>
-#include <linux/gpio.h>
-#include <linux/slab.h>
 #include <linux/module.h>
 
 #define GEF_GPIO_DIRECT		0x00
@@ -39,28 +33,28 @@
 #define GEF_GPIO_OVERRUN	0x1C
 #define GEF_GPIO_MODE		0x20
 
-static void _gef_gpio_set(void __iomem *reg, unsigned int offset, int value)
+static void gef_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
+	struct of_mm_gpio_chip *mmchip = to_of_mm_gpio_chip(chip);
 	unsigned int data;
 
-	data = ioread32be(reg);
+	data = ioread32be(mmchip->regs + GEF_GPIO_OUT);
 	/* value: 0=low; 1=high */
-	if (value & 0x1)
-		data = data | (0x1 << offset);
+	if (value)
+		data = data | BIT(offset);
 	else
-		data = data & ~(0x1 << offset);
+		data = data & ~BIT(offset);
 
-	iowrite32be(data, reg);
+	iowrite32be(data, mmchip->regs + GEF_GPIO_OUT);
 }
 
-
 static int gef_gpio_dir_in(struct gpio_chip *chip, unsigned offset)
 {
 	unsigned int data;
 	struct of_mm_gpio_chip *mmchip = to_of_mm_gpio_chip(chip);
 
 	data = ioread32be(mmchip->regs + GEF_GPIO_DIRECT);
-	data = data | (0x1 << offset);
+	data = data | BIT(offset);
 	iowrite32be(data, mmchip->regs + GEF_GPIO_DIRECT);
 
 	return 0;
@@ -71,11 +65,11 @@ static int gef_gpio_dir_out(struct gpio_chip *chip, unsigned offset, int value)
 	unsigned int data;
 	struct of_mm_gpio_chip *mmchip = to_of_mm_gpio_chip(chip);
 
-	/* Set direction before switching to input */
-	_gef_gpio_set(mmchip->regs + GEF_GPIO_OUT, offset, value);
+	/* Set value before switching to output */
+	gef_gpio_set(mmchip->regs + GEF_GPIO_OUT, offset, value);
 
 	data = ioread32be(mmchip->regs + GEF_GPIO_DIRECT);
-	data = data & ~(0x1 << offset);
+	data = data & ~BIT(offset);
 	iowrite32be(data, mmchip->regs + GEF_GPIO_DIRECT);
 
 	return 0;
@@ -83,116 +77,62 @@ static int gef_gpio_dir_out(struct gpio_chip *chip, unsigned offset, int value)
 
 static int gef_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	unsigned int data;
-	int state = 0;
 	struct of_mm_gpio_chip *mmchip = to_of_mm_gpio_chip(chip);
 
-	data = ioread32be(mmchip->regs + GEF_GPIO_IN);
-	state = (int)((data >> offset) & 0x1);
-
-	return state;
+	return !!(ioread32be(mmchip->regs + GEF_GPIO_IN) & BIT(offset));
 }
 
-static void gef_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static const struct of_device_id gef_gpio_ids[] = {
+	{
+		.compatible	= "gef,sbc610-gpio",
+		.data		= (void *)19,
+	}, {
+		.compatible	= "gef,sbc310-gpio",
+		.data		= (void *)6,
+	}, {
+		.compatible	= "ge,imp3a-gpio",
+		.data		= (void *)16,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gef_gpio_ids);
+
+static int gef_gpio_probe(struct platform_device *pdev)
 {
-	struct of_mm_gpio_chip *mmchip = to_of_mm_gpio_chip(chip);
+	const struct of_device_id *of_id =
+		of_match_device(gef_gpio_ids, &pdev->dev);
+	struct of_mm_gpio_chip *mmchip;
 
-	_gef_gpio_set(mmchip->regs + GEF_GPIO_OUT, offset, value);
-}
+	if (!of_id)
+		return -ENOSYS;
 
-static int __init gef_gpio_init(void)
-{
-	struct device_node *np;
-	int retval;
-	struct of_mm_gpio_chip *gef_gpio_chip;
-
-	for_each_compatible_node(np, NULL, "gef,sbc610-gpio") {
-
-		pr_debug("%s: Initialising GEF GPIO\n", np->full_name);
-
-		/* Allocate chip structure */
-		gef_gpio_chip = kzalloc(sizeof(*gef_gpio_chip), GFP_KERNEL);
-		if (!gef_gpio_chip) {
-			pr_err("%s: Unable to allocate structure\n",
-				np->full_name);
-			continue;
-		}
-
-		/* Setup pointers to chip functions */
-		gef_gpio_chip->gc.of_gpio_n_cells = 2;
-		gef_gpio_chip->gc.ngpio = 19;
-		gef_gpio_chip->gc.direction_input = gef_gpio_dir_in;
-		gef_gpio_chip->gc.direction_output = gef_gpio_dir_out;
-		gef_gpio_chip->gc.get = gef_gpio_get;
-		gef_gpio_chip->gc.set = gef_gpio_set;
-
-		/* This function adds a memory mapped GPIO chip */
-		retval = of_mm_gpiochip_add(np, gef_gpio_chip);
-		if (retval) {
-			kfree(gef_gpio_chip);
-			pr_err("%s: Unable to add GPIO\n", np->full_name);
-		}
-	}
-
-	for_each_compatible_node(np, NULL, "gef,sbc310-gpio") {
-
-		pr_debug("%s: Initialising GEF GPIO\n", np->full_name);
-
-		/* Allocate chip structure */
-		gef_gpio_chip = kzalloc(sizeof(*gef_gpio_chip), GFP_KERNEL);
-		if (!gef_gpio_chip) {
-			pr_err("%s: Unable to allocate structure\n",
-				np->full_name);
-			continue;
-		}
-
-		/* Setup pointers to chip functions */
-		gef_gpio_chip->gc.of_gpio_n_cells = 2;
-		gef_gpio_chip->gc.ngpio = 6;
-		gef_gpio_chip->gc.direction_input = gef_gpio_dir_in;
-		gef_gpio_chip->gc.direction_output = gef_gpio_dir_out;
-		gef_gpio_chip->gc.get = gef_gpio_get;
-		gef_gpio_chip->gc.set = gef_gpio_set;
-
-		/* This function adds a memory mapped GPIO chip */
-		retval = of_mm_gpiochip_add(np, gef_gpio_chip);
-		if (retval) {
-			kfree(gef_gpio_chip);
-			pr_err("%s: Unable to add GPIO\n", np->full_name);
-		}
-	}
-
-	for_each_compatible_node(np, NULL, "ge,imp3a-gpio") {
-
-		pr_debug("%s: Initialising GE GPIO\n", np->full_name);
-
-		/* Allocate chip structure */
-		gef_gpio_chip = kzalloc(sizeof(*gef_gpio_chip), GFP_KERNEL);
-		if (!gef_gpio_chip) {
-			pr_err("%s: Unable to allocate structure\n",
-				np->full_name);
-			continue;
-		}
-
-		/* Setup pointers to chip functions */
-		gef_gpio_chip->gc.of_gpio_n_cells = 2;
-		gef_gpio_chip->gc.ngpio = 16;
-		gef_gpio_chip->gc.direction_input = gef_gpio_dir_in;
-		gef_gpio_chip->gc.direction_output = gef_gpio_dir_out;
-		gef_gpio_chip->gc.get = gef_gpio_get;
-		gef_gpio_chip->gc.set = gef_gpio_set;
-
-		/* This function adds a memory mapped GPIO chip */
-		retval = of_mm_gpiochip_add(np, gef_gpio_chip);
-		if (retval) {
-			kfree(gef_gpio_chip);
-			pr_err("%s: Unable to add GPIO\n", np->full_name);
-		}
-	}
+	mmchip = devm_kzalloc(&pdev->dev, sizeof(*mmchip), GFP_KERNEL);
+	if (!mmchip)
+		return -ENOMEM;
 
-	return 0;
+	/* Setup pointers to chip functions */
+	mmchip->gc.ngpio = (u16)(uintptr_t)of_id->data;
+	mmchip->gc.of_gpio_n_cells = 2;
+	mmchip->gc.direction_input = gef_gpio_dir_in;
+	mmchip->gc.direction_output = gef_gpio_dir_out;
+	mmchip->gc.get = gef_gpio_get;
+	mmchip->gc.set = gef_gpio_set;
+
+	platform_set_drvdata(pdev, mmchip);
+
+	/* This function adds a memory mapped GPIO chip */
+	return of_mm_gpiochip_add(pdev->dev.of_node, mmchip);
+};
+
+static struct platform_driver gef_gpio_driver = {
+	.driver	= {
+		.name		= "gef-gpio",
+		.owner		= THIS_MODULE,
+		.of_match_table	= gef_gpio_ids,
+	},
+	.probe	= gef_gpio_probe,
 };
-arch_initcall(gef_gpio_init);
+module_platform_driver(gef_gpio_driver);
 
 MODULE_DESCRIPTION("GE I/O FPGA GPIO driver");
 MODULE_AUTHOR("Martyn Welch <martyn.welch@ge.com");
-- 
1.8.3.2
