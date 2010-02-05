Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 74D50B7E45
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 07:50:47 +1100 (EST)
Date: Fri, 5 Feb 2010 23:50:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 3/3] of/gpio: Introduce of_put_gpio(), add ref counting for
	OF GPIO chips
Message-ID: <20100205205045.GC4178@oksana.dev.rtsoft.ru>
References: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
Cc: Michal Simek <monstr@monstr.eu>, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OF GPIO infrastructure is using dynamic GPIO bases, so it is possible
that of_get_gpio()'s returned GPIO number will be no longer valid, or
worse, it may point to an unexpected GPIO controller.

This scenario is possible:

driver A:               driver B:              driver C:
---------               ---------              ---------
                        gpiochip_add()
gpio = of_get_gpio()
                        gpiochip_remove()
                                               gpiochip_add()
gpio_request(gpio);
gpio_set_value(gpio);

That is, driver A assumes that it is working with GPIO from driver B,
but in practice it may disappear and driver C will take its GPIO base
number, so it will provide the same GPIO numbers.

With this patch that situation is no longer possible. Though drivers
will need to learn to put GPIOs back, so that GPIO controllers could
be removed.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/of/gpio.c       |   82 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/of_gpio.h |    5 +++
 2 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
index 9d8df77..e94c5c8 100644
--- a/drivers/of/gpio.c
+++ b/drivers/of/gpio.c
@@ -28,6 +28,8 @@
  * Returns GPIO number to use with Linux generic GPIO API, or one of the errno
  * value on the error condition. If @flags is not NULL the function also fills
  * in flags for the GPIO.
+ *
+ * Remeber to put the GPIO back using of_put_gpio() call.
  */
 int of_get_gpio_flags(struct device_node *np, int index,
 		      enum of_gpio_flags *flags)
@@ -46,6 +48,8 @@ int of_get_gpio_flags(struct device_node *np, int index,
 		goto err0;
 	}
 
+	spin_lock(&gc->data_lock);
+
 	of_gc = gc->data;
 	if (!of_gc) {
 		pr_debug("%s: gpio controller %s isn't registered\n",
@@ -72,15 +76,62 @@ int of_get_gpio_flags(struct device_node *np, int index,
 		goto err1;
 
 	ret += of_gc->chip->base;
+
+	if (!try_module_get(of_gc->chip->owner)) {
+		ret = -EINVAL;
+		goto err1;
+	}
+
+	of_gc->refcnt++;
 err1:
+	spin_unlock(&gc->data_lock);
+
 	of_node_put(gc);
 err0:
 	pr_debug("%s exited with status %d\n", __func__, ret);
+
 	return ret;
 }
 EXPORT_SYMBOL(of_get_gpio_flags);
 
 /**
+ * of_put_gpio - Put a GPIO back to the OF subsystem
+ * @np:		device node of the GPIO owner
+ * @index:	index of the GPIO
+ */
+static inline void of_put_gpio(struct device_node *np, int index)
+{
+	int ret;
+	struct device_node *gc;
+	struct of_gpio_chip *of_gc;
+
+	ret = of_parse_phandles_with_args(np, "gpios", "#gpio-cells", index,
+					  &gc, NULL);
+	if (ret) {
+		pr_debug("%s: can't parse gpios property\n", __func__);
+		return;
+	}
+
+	spin_lock(&gc->data_lock);
+
+	of_gc = gc->data;
+	if (!of_gc) {
+		pr_debug("%s: gpio controller %s isn't registered\n",
+			 np->full_name, gc->full_name);
+		goto err;
+	}
+
+	if (of_gc->refcnt)
+		of_gc->refcnt--;
+	else
+		WARN_ON(1);
+
+	module_put(of_gc->chip->owner);
+err:
+	spin_unlock(&gc->data_lock);
+}
+
+/**
  * of_gpio_count - Count GPIOs for a device
  * @np:		device node to count GPIOs for
  *
@@ -254,11 +305,7 @@ static int of_gpiochip_register_simple(struct gpio_chip *chip,
 				       struct device_node *np)
 {
 	struct of_gpio_chip *of_gc;
-
-	if (np->data) {
-		WARN_ON(1);
-		return -EBUSY;
-	}
+	int ret;
 
 	of_gc = kzalloc(sizeof(*of_gc), GFP_KERNEL);
 	if (!of_gc)
@@ -267,10 +314,12 @@ static int of_gpiochip_register_simple(struct gpio_chip *chip,
 	of_gc->gpio_cells = 2;
 	of_gc->xlate = of_gpio_simple_xlate;
 	of_gc->chip = chip;
-	np->data = of_gc;
-	of_node_get(np);
 
-	return 0;
+	ret = of_node_set_data(np, of_gc);
+	if (ret)
+		kfree(of_gc);
+
+	return ret;
 }
 EXPORT_SYMBOL(of_gpiochip_register_simple);
 
@@ -286,17 +335,26 @@ static int of_gpiochip_unregister(struct gpio_chip *chip,
 				  struct device_node *np)
 {
 	struct of_gpio_chip *of_gc = np->data;
+	int ret = 0;
 
 	if (!of_gc || of_gc->chip != chip) {
 		WARN_ON(1);
 		return -EINVAL;
 	}
 
-	np->data = NULL;
-	kfree(of_gc);
-	of_node_put(np);
+	spin_lock(&np->data_lock);
 
-	return 0;
+	if (of_gc->refcnt)
+		ret = -EBUSY;
+	else
+		of_node_release_data_unlocked(np);
+
+	spin_unlock(&np->data_lock);
+
+	if (!ret)
+		kfree(of_gc);
+
+	return ret;
 }
 
 static int of_gpio_notify(struct notifier_block *nb, unsigned long msg,
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index c74cb37..aca7ab1 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -38,6 +38,7 @@ enum of_gpio_flags {
 struct of_gpio_chip {
 	struct gpio_chip gc; /* legacy, don't use for a new code */
 	struct gpio_chip *chip;
+	unsigned int refcnt;
 	int gpio_cells;
 	int (*xlate)(struct of_gpio_chip *of_gc, struct device_node *np,
 		     const void *gpio_spec, enum of_gpio_flags *flags);
@@ -83,6 +84,8 @@ static inline int of_get_gpio_flags(struct device_node *np, int index,
 	return -ENOSYS;
 }
 
+static inline void of_put_gpio(struct device_node *np, int index) {}
+
 static inline unsigned int of_gpio_count(struct device_node *np)
 {
 	return 0;
@@ -97,6 +100,8 @@ static inline unsigned int of_gpio_count(struct device_node *np)
  *
  * Returns GPIO number to use with Linux generic GPIO API, or one of the errno
  * value on the error condition.
+ *
+ * Remeber to put the GPIO back using of_put_gpio() call.
  */
 static inline int of_get_gpio(struct device_node *np, int index)
 {
-- 
1.6.5.7
