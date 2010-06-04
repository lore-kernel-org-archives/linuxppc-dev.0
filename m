Return-Path: <eha@doredevelopment.dk>
Received: from zmta01.irigo.dk (zmta01.cabocomm.dk [193.200.44.52])
	by ozlabs.org (Postfix) with ESMTP id 92B3BB7D7B
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jun 2010 07:32:51 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zmta01.irigo.dk (Postfix) with ESMTP id 23CF214267134
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jun 2010 23:25:38 +0200 (CEST)
Received: from zmta01.irigo.dk ([127.0.0.1])
	by localhost (zmta01.irigo.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TiigzJGCkeYl for <linuxppc-dev@ozlabs.org>;
	Fri,  4 Jun 2010 23:25:32 +0200 (CEST)
Received: from [192.168.1.127] (0x55532124.adsl.cybercity.dk [85.83.33.36])
	by zmta01.irigo.dk (Postfix) with ESMTP id BAE2C14267129
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jun 2010 23:25:31 +0200 (CEST)
Subject: [PATCH 2/2] gpio: pca953x: add powerpc irq support
From: Esben Haabendal <eha@doredevelopment.dk>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
In-Reply-To: <cover.1275686504.git.eha@doredevelopment.dk>
References: <cover.1275686504.git.eha@doredevelopment.dk>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Jun 2010 23:25:31 +0200
Message-ID: <1275686731.2970.14.camel@eha.doredevelopment.dk>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
---
 drivers/gpio/pca953x.c |  347 +++++++++++++++++++++++++++++++++---------------
 1 files changed, 240 insertions(+), 107 deletions(-)

diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index a2b12aa..a47d55f 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
  *  Copyright (C) 2007 Marvell International Ltd.
+ *  Copyright (C) 2010 DoreDevelopment ApS
  *
  *  Derived from drivers/i2c/chips/pca9539.c
  *
@@ -67,8 +68,11 @@ struct pca953x_chip {
 	uint16_t irq_stat;
 	uint16_t irq_trig_raise;
 	uint16_t irq_trig_fall;
-	int	 irq_base;
-#endif
+	int irq_base;
+#ifdef CONFIG_PPC
+	struct irq_host *irq_host;
+#endif /* CONFIG_PPC */
+#endif /* CONFIG_GPIO_PCA953X_IRQ */
 
 	struct i2c_client *client;
 	struct pca953x_platform_data *dyn_pdata;
@@ -120,6 +124,10 @@ static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
 	chip = container_of(gc, struct pca953x_chip, gpio_chip);
 
 	reg_val = chip->reg_direction | (1u << off);
+
+	if (reg_val == chip->reg_direction)
+		return 0;
+
 	ret = pca953x_write_reg(chip, PCA953X_DIRECTION, reg_val);
 	if (ret)
 		return ret;
@@ -220,63 +228,41 @@ static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 }
 
 #ifdef CONFIG_GPIO_PCA953X_IRQ
-static int pca953x_gpio_to_irq(struct gpio_chip *gc, unsigned off)
-{
-	struct pca953x_chip *chip;
 
-	chip = container_of(gc, struct pca953x_chip, gpio_chip);
-	return chip->irq_base + off;
-}
+#ifdef CONFIG_PPC
 
-static void pca953x_irq_mask(unsigned int irq)
-{
-	struct pca953x_chip *chip = get_irq_chip_data(irq);
-
-	chip->irq_mask &= ~(1 << (irq - chip->irq_base));
-}
+#define pca953x_pin_to_virq(chip, pin) \
+	(irq_linear_revmap((chip)->irq_host, pin))
+#define pca953x_virq_to_pin(chip, virq) \
+	(virq_to_hw(virq))
 
-static void pca953x_irq_unmask(unsigned int irq)
+static void pca953x_irq_mask(unsigned int virq)
 {
-	struct pca953x_chip *chip = get_irq_chip_data(irq);
-
-	chip->irq_mask |= 1 << (irq - chip->irq_base);
+	struct pca953x_chip *chip = get_irq_chip_data(virq);
+	int pin = pca953x_virq_to_pin(chip, virq);
+	pr_debug("%s: virq=%d pin=%d\n", __func__, virq, pin);
+	chip->irq_mask &= ~(1 << pin);
 }
 
-static void pca953x_irq_bus_lock(unsigned int irq)
+static void pca953x_irq_unmask(unsigned int virq)
 {
-	struct pca953x_chip *chip = get_irq_chip_data(irq);
-
-	mutex_lock(&chip->irq_lock);
+	struct pca953x_chip *chip = get_irq_chip_data(virq);
+	int pin = pca953x_virq_to_pin(chip, virq);
+	pr_debug("%s: virq=%d hwirq=%d\n", __func__, virq, pin);
+	chip->irq_mask |= 1 << pin;
 }
 
-static void pca953x_irq_bus_sync_unlock(unsigned int irq)
+static int pca953x_irq_set_type(unsigned int virq, unsigned int type)
 {
-	struct pca953x_chip *chip = get_irq_chip_data(irq);
-	uint16_t new_irqs;
-	uint16_t level;
+	struct pca953x_chip *chip = get_irq_chip_data(virq);
+	int pin = pca953x_virq_to_pin(chip, virq);
+	uint16_t mask = 1 << pin;
 
-	/* Look for any newly setup interrupt */
-	new_irqs = chip->irq_trig_fall | chip->irq_trig_raise;
-	new_irqs &= ~chip->reg_direction;
-
-	while (new_irqs) {
-		level = __ffs(new_irqs);
-		pca953x_gpio_direction_input(&chip->gpio_chip, level);
-		new_irqs &= ~(1 << level);
-	}
-
-	mutex_unlock(&chip->irq_lock);
-}
-
-static int pca953x_irq_set_type(unsigned int irq, unsigned int type)
-{
-	struct pca953x_chip *chip = get_irq_chip_data(irq);
-	uint16_t level = irq - chip->irq_base;
-	uint16_t mask = 1 << level;
+	pr_debug("%s: virq=%d pin=%d type=0x%x\n", __func__, virq, pin, type);
 
 	if (!(type & IRQ_TYPE_EDGE_BOTH)) {
-		dev_err(&chip->client->dev, "irq %d: unsupported type %d\n",
-			irq, type);
+		dev_err(&chip->client->dev, "virq %d: unsupported type %d\n",
+			virq, type);
 		return -EINVAL;
 	}
 
@@ -297,11 +283,140 @@ static struct irq_chip pca953x_irq_chip = {
 	.name			= "pca953x",
 	.mask			= pca953x_irq_mask,
 	.unmask			= pca953x_irq_unmask,
+#ifndef CONFIG_PPC
 	.bus_lock		= pca953x_irq_bus_lock,
 	.bus_sync_unlock	= pca953x_irq_bus_sync_unlock,
+#endif /* !CONFIG_PPC */
 	.set_type		= pca953x_irq_set_type,
 };
 
+static int pca953x_irq_host_match(struct irq_host *h, struct device_node *node)
+{
+	pr_debug("%s: node=%s\n", __func__, node->full_name);
+	return h->of_node == NULL || h->of_node == node;
+}
+
+static int pca953x_irq_host_map(struct irq_host *h, unsigned int virq,
+				irq_hw_number_t hwirq)
+{
+	struct pca953x_chip *chip = h->host_data;
+
+	pr_debug("%s: virq=%d hwirq=%ld\n", __func__, virq, hwirq);
+
+	set_irq_chip_data(virq, chip);
+	set_irq_chip_and_handler(virq, &pca953x_irq_chip, handle_edge_irq);
+	set_irq_nested_thread(virq, 1);
+
+	/* On powerpc, we set the direction to input on map(),
+	 * avoiding the use of genirq buslock, and thereby not
+	 * restricting the use of generic interrupt management
+	 * functions. */
+	pca953x_gpio_direction_input(&chip->gpio_chip, hwirq);
+
+	return 0;
+}
+
+static int pca953x_irq_host_xlate(struct irq_host *h, struct device_node *node,
+				  const u32 *intspec, unsigned int intsize,
+				  irq_hw_number_t *hwirq, unsigned int *flags)
+{
+	pr_debug("%s: irq_host=%p node=%s\n", __func__, h, node->full_name);
+	*hwirq = intspec[0];
+	if (intsize > 1)
+		*flags = intspec[1];
+	else
+		*flags = IRQ_TYPE_EDGE_BOTH;
+	pr_debug("%s: hwirq=%ld flags=0x%x\n", __func__, *hwirq, *flags);
+	return 0;
+}
+
+static struct irq_host_ops pca953x_irq_host_ops = {
+	.match	= pca953x_irq_host_match,
+	.map	= pca953x_irq_host_map,
+	.xlate	= pca953x_irq_host_xlate,
+};
+
+#define pca953x_irq_setup_premap(chip) do {} while (0)
+
+static void pca953x_irq_alloc_host(struct pca953x_chip *chip,
+				   struct device_node *node)
+{
+	chip->irq_host = irq_alloc_host(
+		node, IRQ_HOST_MAP_LINEAR, chip->gpio_chip.ngpio,
+		&pca953x_irq_host_ops, -1);
+	chip->irq_host->host_data = chip;
+}
+
+#else /* CONFIG_PPC */
+
+#define pca953x_pin_to_virq(chip, pin) \
+	((chip)->irq_base + pin)
+#define pca953x_virq_to_pin(chip, virq) \
+	(virq - (chip)->irq_base)
+
+/* Use the genirq buslock support on non-powerpc archs for setting
+ * gpio direction on enable_irq, which unfortunately means that some
+ * of the generic interrupt management functions like enable_irq,
+ * disable_irq and so on cannot be used in atomic context on irq's
+ * from this interrupt controller. */
+static void pca953x_irq_bus_lock(unsigned int virq)
+{
+	struct pca953x_chip *chip = get_irq_chip_data(virq);
+	pr_debug("%s: virq=%d\n", __func__, virq);
+	mutex_lock(&chip->irq_lock);
+}
+
+static void pca953x_irq_bus_sync_unlock(unsigned int virq)
+{
+	struct pca953x_chip *chip = get_irq_chip_data(virq);
+	uint16_t new_irqs;
+	uint16_t pin;
+	pr_debug("%s: virq=%d\n", __func__, virq);
+
+	/* Look for any newly setup interrupt */
+	new_irqs = chip->irq_trig_fall | chip->irq_trig_raise;
+	new_irqs &= ~chip->reg_direction;
+
+	while (new_irqs) {
+		pin = __ffs(new_irqs);
+		pca953x_gpio_direction_input(&chip->gpio_chip, pin);
+		new_irqs &= ~(1 << pin);
+	}
+
+	mutex_unlock(&chip->irq_lock);
+}
+
+static void pca953x_irq_setup_premap(struct pca953x_chipo *chip)
+{
+	int pin;
+
+	for (pin = 0; pin < chip->gpio_chip.ngpio; pin++) {
+		int irq = pin + chip->irq_base;
+
+		//irq_to_desc_alloc_node(irq, 0);
+		set_irq_chip_data(irq, chip);
+		set_irq_chip_and_handler(irq, &pca953x_irq_chip,
+					 handle_edge_irq);
+		set_irq_nested_thread(irq, 1);
+#ifdef CONFIG_ARM
+		set_irq_flags(irq, IRQF_VALID);
+#else /* CONFIG_ARM */
+		set_irq_noprobe(irq);
+#endif /* CONFIG_ARM */
+	}
+}
+
+#define pca953x_irq_alloc_host(chip) do {} while (0)
+
+#endif /* CONFIG_PPC */
+
+static int pca953x_gpio_to_irq(struct gpio_chip *gc, unsigned off)
+{
+	struct pca953x_chip *chip;
+	chip = container_of(gc, struct pca953x_chip, gpio_chip);
+	return pca953x_pin_to_virq(chip, off);
+}
+
 static uint16_t pca953x_irq_pending(struct pca953x_chip *chip)
 {
 	uint16_t cur_stat;
@@ -317,14 +432,20 @@ static uint16_t pca953x_irq_pending(struct pca953x_chip *chip)
 	/* Remove output pins from the equation */
 	cur_stat &= chip->reg_direction;
 
+	/* Remember the input */
 	old_stat = chip->irq_stat;
+	chip->irq_stat = cur_stat;
+
+	/* Find changed inputs which are not masked out */
 	trigger = (cur_stat ^ old_stat) & chip->irq_mask;
 
+	pr_debug("%s: irq_mask=0x%04x old_stat=0x%04x cur_stat=0x%04x\n",
+		 __func__, chip->irq_mask, old_stat, cur_stat);
+
 	if (!trigger)
 		return 0;
 
-	chip->irq_stat = cur_stat;
-
+	/* And finally, get the pending irq's */
 	pending = (old_stat & chip->irq_trig_fall) |
 		  (cur_stat & chip->irq_trig_raise);
 	pending &= trigger;
@@ -332,22 +453,26 @@ static uint16_t pca953x_irq_pending(struct pca953x_chip *chip)
 	return pending;
 }
 
-static irqreturn_t pca953x_irq_handler(int irq, void *devid)
+static irqreturn_t pca953x_irq_thread_fn(int irq, void *devid)
 {
 	struct pca953x_chip *chip = devid;
 	uint16_t pending;
-	uint16_t level;
+	uint16_t pin;
 
 	pending = pca953x_irq_pending(chip);
 
+	pr_debug("%s: virq=%d pending=0x%04x\n", __func__, irq, pending);
+
 	if (!pending)
 		return IRQ_HANDLED;
 
 	do {
-		level = __ffs(pending);
-		handle_nested_irq(level + chip->irq_base);
-
-		pending &= ~(1 << level);
+		unsigned int gpio_irq;
+		pin = __ffs(pending);
+		gpio_irq = pca953x_pin_to_virq(chip, pin);
+		pr_debug("%s: pin=%hu gpio_irq=%d\n", __func__, pin, gpio_irq);
+		handle_nested_irq(gpio_irq);
+		pending &= ~(1 << pin);
 	} while (pending);
 
 	return IRQ_HANDLED;
@@ -360,51 +485,39 @@ static int pca953x_irq_setup(struct pca953x_chip *chip,
 	struct pca953x_platform_data *pdata = client->dev.platform_data;
 	int ret;
 
-	if (pdata->irq_base && (id->driver_data & PCA953X_INT)) {
-		int lvl;
+	if (! ((pdata->irq_base || chip->irq_host) &&
+	       (id->driver_data & PCA953X_INT)))
+		return 0;
 
-		ret = pca953x_read_reg(chip, PCA953X_INPUT,
-				       &chip->irq_stat);
-		if (ret)
-			goto out_failed;
+	ret = pca953x_read_reg(chip, PCA953X_INPUT, &chip->irq_stat);
+	if (ret)
+		goto out_failed;
 
-		/*
-		 * There is no way to know which GPIO line generated the
-		 * interrupt.  We have to rely on the previous read for
-		 * this purpose.
-		 */
-		chip->irq_stat &= chip->reg_direction;
-		chip->irq_base = pdata->irq_base;
-		mutex_init(&chip->irq_lock);
+	/*
+	 * There is no way to know which GPIO line generated the
+	 * interrupt.  We have to rely on the previous read for
+	 * this purpose.
+	 */
+	chip->irq_stat &= chip->reg_direction;
+	mutex_init(&chip->irq_lock);
 
-		for (lvl = 0; lvl < chip->gpio_chip.ngpio; lvl++) {
-			int irq = lvl + chip->irq_base;
+	chip->irq_base = pdata->irq_base;
 
-			set_irq_chip_data(irq, chip);
-			set_irq_chip_and_handler(irq, &pca953x_irq_chip,
-						 handle_edge_irq);
-			set_irq_nested_thread(irq, 1);
-#ifdef CONFIG_ARM
-			set_irq_flags(irq, IRQF_VALID);
-#else
-			set_irq_noprobe(irq);
-#endif
-		}
-
-		ret = request_threaded_irq(client->irq,
-					   NULL,
-					   pca953x_irq_handler,
-					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					   dev_name(&client->dev), chip);
-		if (ret) {
-			dev_err(&client->dev, "failed to request irq %d\n",
-				client->irq);
-			goto out_failed;
-		}
+	pca953x_irq_setup_premap(chip);
 
-		chip->gpio_chip.to_irq = pca953x_gpio_to_irq;
+	pr_debug("%s: requesting irq=%d\n", __func__, client->irq);
+	ret = request_threaded_irq(client->irq,
+				   NULL, pca953x_irq_thread_fn,
+				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				   dev_name(&client->dev), chip);
+	if (ret) {
+		dev_err(&client->dev, "failed to request irq %d\n",
+			client->irq);
+		goto out_failed;
 	}
 
+	chip->gpio_chip.to_irq = pca953x_gpio_to_irq;
+
 	return 0;
 
 out_failed:
@@ -414,17 +527,20 @@ out_failed:
 
 static void pca953x_irq_teardown(struct pca953x_chip *chip)
 {
-	if (chip->irq_base)
+	if (chip->irq_host || chip->irq_base)
 		free_irq(chip->client->irq, chip);
 }
+
 #else /* CONFIG_GPIO_PCA953X_IRQ */
+
 static int pca953x_irq_setup(struct pca953x_chip *chip,
 			     const struct i2c_device_id *id)
 {
 	struct i2c_client *client = chip->client;
 	struct pca953x_platform_data *pdata = client->dev.platform_data;
 
-	if (pdata->irq_base && (id->driver_data & PCA953X_INT))
+	if ((chip->irq_host || pdata->irq_base) &&
+	    (id->driver_data & PCA953X_INT))
 		dev_warn(&client->dev, "interrupt support not compiled in\n");
 
 	return 0;
@@ -433,21 +549,21 @@ static int pca953x_irq_setup(struct pca953x_chip *chip,
 static void pca953x_irq_teardown(struct pca953x_chip *chip)
 {
 }
-#endif
 
-/*
- * Handlers for alternative sources of platform_data
- */
+#endif /* CONFIG_GPIO_PCA953X_IRQ */
+
 #ifdef CONFIG_OF_GPIO
+
 /*
  * Translate OpenFirmware node properties into platform_data
  */
 static struct pca953x_platform_data *
-pca953x_get_alt_pdata(struct i2c_client *client)
+pca953x_get_alt_pdata(struct pca953x_chip *chip)
 {
+	struct i2c_client *client = chip->client;
 	struct pca953x_platform_data *pdata;
 	struct device_node *node;
-	const uint16_t *val;
+	const int *val;
 
 	node = client->dev.of_node;
 	if (node == NULL)
@@ -469,19 +585,34 @@ pca953x_get_alt_pdata(struct i2c_client *client)
 			pdata->gpio_base = *val;
 	}
 
+	pdata->irq_base = -1;
+	val = of_get_property(node, "linux,irq-base", NULL);
+	if (val) {
+		if (*val < 0)
+			dev_warn(&client->dev,
+				 "invalid irq-base in device tree\n");
+		else
+			pdata->irq_base = *val;
+	}
+
 	val = of_get_property(node, "polarity", NULL);
 	if (val)
 		pdata->invert = *val;
 
+	pca953x_irq_alloc_host(chip, node);
+
 	return pdata;
 }
-#else
+
+#else /* CONFIG_OF_GPIO */
+
 static struct pca953x_platform_data *
 pca953x_get_alt_pdata(struct i2c_client *client)
 {
 	return NULL;
 }
-#endif
+
+#endif /* CONFIG_OF_GPIO */
 
 static int __devinit pca953x_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
@@ -490,13 +621,18 @@ static int __devinit pca953x_probe(struct i2c_client *client,
 	struct pca953x_chip *chip;
 	int ret;
 
+	pr_debug("%s\n", __func__);
+
 	chip = kzalloc(sizeof(struct pca953x_chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
+	chip->client = client;
+
 	pdata = client->dev.platform_data;
 	if (pdata == NULL) {
-		pdata = pca953x_get_alt_pdata(client);
+		pdata = pca953x_get_alt_pdata(chip);
+		client->dev.platform_data = pdata;
 		/*
 		 * Unlike normal platform_data, this is allocated
 		 * dynamically and must be freed in the driver
@@ -510,10 +646,7 @@ static int __devinit pca953x_probe(struct i2c_client *client,
 		goto out_failed;
 	}
 
-	chip->client = client;
-
 	chip->gpio_start = pdata->gpio_base;
-
 	chip->names = pdata->names;
 
 	/* initialize cached registers from their original values.
-- 
1.7.1
