Return-Path: <dbaryshkov@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by ozlabs.org (Postfix) with ESMTP id 15C8EB7B79
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 02:42:37 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so64704fga.3
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 07:42:35 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 1/5] Rework OpenFirmware GPIO handling
Date: Tue, 17 Nov 2009 18:42:22 +0300
Message-Id: <1258472546-31343-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
References: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch improves OF GPIO bindings so, that most non-OF-specific gpio
controllers don't need to call any of OF binding function:

0) Move of_gpio_chip into main gpio_chip structure.
1) Call of_gpio_init/destroy from gpiochip_add/remove.
2) By default supply reasonable defaults for gpio_cells/xlate

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/gpio/gpiolib.c     |    6 ++++++
 drivers/of/gpio.c          |   42 ++++++++++++++++++++++++++++++++++++------
 include/asm-generic/gpio.h |   19 +++++++++++++++++++
 include/linux/of_gpio.h    |   29 ++++++++++++++++-------------
 4 files changed, 77 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 50de0f5..7c998b3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -10,6 +10,8 @@
 #include <linux/gpio.h>
 #include <linux/idr.h>
 
+#include <linux/of_gpio.h>
+
 
 /* Optional implementation infrastructure for GPIO interfaces.
  *
@@ -963,6 +965,8 @@ unlock:
 	spin_unlock_irqrestore(&gpio_lock, flags);
 	if (status == 0)
 		status = gpiochip_export(chip);
+	if (status == 0)
+		of_gpio_init(chip);
 fail:
 	/* failures here can mean systems won't boot... */
 	if (status)
@@ -994,6 +998,8 @@ int gpiochip_remove(struct gpio_chip *chip)
 		}
 	}
 	if (status == 0) {
+		of_gpio_destroy(chip);
+
 		for (id = chip->base; id < chip->base + chip->ngpio; id++)
 			gpio_desc[id].chip = NULL;
 	}
diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
index 6eea601..903e79f 100644
--- a/drivers/of/gpio.c
+++ b/drivers/of/gpio.c
@@ -70,7 +70,7 @@ int of_get_gpio_flags(struct device_node *np, int index,
 	if (ret < 0)
 		goto err1;
 
-	ret += of_gc->gc.base;
+	ret += to_gpio_chip_of(of_gc)->base;
 err1:
 	of_node_put(gc);
 err0:
@@ -140,7 +140,7 @@ int of_gpio_simple_xlate(struct of_gpio_chip *of_gc, struct device_node *np,
 		return -EINVAL;
 	}
 
-	if (*gpio > of_gc->gc.ngpio)
+	if (*gpio > to_gpio_chip_of(of_gc)->ngpio)
 		return -EINVAL;
 
 	if (flags)
@@ -176,7 +176,7 @@ int of_mm_gpiochip_add(struct device_node *np,
 {
 	int ret = -ENOMEM;
 	struct of_gpio_chip *of_gc = &mm_gc->of_gc;
-	struct gpio_chip *gc = &of_gc->gc;
+	struct gpio_chip *gc = &mm_gc->gc;
 
 	gc->label = kstrdup(np->full_name, GFP_KERNEL);
 	if (!gc->label)
@@ -188,9 +188,6 @@ int of_mm_gpiochip_add(struct device_node *np,
 
 	gc->base = -1;
 
-	if (!of_gc->xlate)
-		of_gc->xlate = of_gpio_simple_xlate;
-
 	if (mm_gc->save_regs)
 		mm_gc->save_regs(mm_gc);
 
@@ -217,3 +214,36 @@ err0:
 	return ret;
 }
 EXPORT_SYMBOL(of_mm_gpiochip_add);
+
+void of_gpio_init(struct gpio_chip *gc)
+{
+	struct of_gpio_chip *of_gc = &gc->of_gc;
+	struct device_node *np = gc->dev ?
+		dev_archdata_get_node(&gc->dev->archdata) :
+		NULL;
+
+	if (!of_gc->xlate) {
+		if (!of_gc->gpio_cells)
+			of_gc->gpio_cells = 2;
+		of_gc->xlate = of_gpio_simple_xlate;
+	}
+
+	if (np) {
+		of_node_get(np);
+		np->data = of_gc;
+	}
+}
+EXPORT_SYMBOL(of_gpio_init);
+
+void of_gpio_destroy(struct gpio_chip *gc)
+{
+	struct device_node *np = gc->dev ?
+		dev_archdata_get_node(&gc->dev->archdata) :
+		NULL;
+
+	if (np) {
+		np->data = NULL;
+		of_node_put(np);
+	}
+}
+EXPORT_SYMBOL(of_gpio_destroy);
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 66d6106..3a70958 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -31,6 +31,21 @@ static inline int gpio_is_valid(int number)
 struct seq_file;
 struct module;
 
+#ifdef CONFIG_OF_GPIO
+struct device_node;
+enum of_gpio_flags;
+
+/*
+ * Generic OF GPIO chip
+ */
+struct of_gpio_chip {
+	int gpio_cells;
+	int (*xlate)(struct of_gpio_chip *of_gc, struct device_node *np,
+		     const void *gpio_spec, enum of_gpio_flags *flags);
+};
+#endif
+
+
 /**
  * struct gpio_chip - abstract a GPIO controller
  * @label: for diagnostics
@@ -76,6 +91,10 @@ struct gpio_chip {
 	struct device		*dev;
 	struct module		*owner;
 
+#ifdef CONFIG_OF_GPIO
+	struct of_gpio_chip	of_gc;
+#endif
+
 	int			(*request)(struct gpio_chip *chip,
 						unsigned offset);
 	void			(*free)(struct gpio_chip *chip,
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index fc2472c..99cf84f 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -32,25 +32,16 @@ enum of_gpio_flags {
 
 #ifdef CONFIG_OF_GPIO
 
-/*
- * Generic OF GPIO chip
- */
-struct of_gpio_chip {
-	struct gpio_chip gc;
-	int gpio_cells;
-	int (*xlate)(struct of_gpio_chip *of_gc, struct device_node *np,
-		     const void *gpio_spec, enum of_gpio_flags *flags);
-};
-
-static inline struct of_gpio_chip *to_of_gpio_chip(struct gpio_chip *gc)
+static inline struct gpio_chip *to_gpio_chip_of(struct of_gpio_chip *of_gc)
 {
-	return container_of(gc, struct of_gpio_chip, gc);
+	return container_of(of_gc, struct gpio_chip, of_gc);
 }
 
 /*
  * OF GPIO chip for memory mapped banks
  */
 struct of_mm_gpio_chip {
+	struct gpio_chip gc;
 	struct of_gpio_chip of_gc;
 	void (*save_regs)(struct of_mm_gpio_chip *mm_gc);
 	void __iomem *regs;
@@ -58,8 +49,11 @@ struct of_mm_gpio_chip {
 
 static inline struct of_mm_gpio_chip *to_of_mm_gpio_chip(struct gpio_chip *gc)
 {
-	struct of_gpio_chip *of_gc = to_of_gpio_chip(gc);
+	return container_of(gc, struct of_mm_gpio_chip, gc);
+}
 
+static inline struct of_mm_gpio_chip *to_of_mm_of_chip(struct of_gpio_chip *of_gc)
+{
 	return container_of(of_gc, struct of_mm_gpio_chip, of_gc);
 }
 
@@ -73,6 +67,9 @@ extern int of_gpio_simple_xlate(struct of_gpio_chip *of_gc,
 				struct device_node *np,
 				const void *gpio_spec,
 				enum of_gpio_flags *flags);
+
+extern void of_gpio_init(struct gpio_chip *gc);
+extern void of_gpio_destroy(struct gpio_chip *gc);
 #else
 
 /* Drivers may not strictly depend on the GPIO support, so let them link. */
@@ -87,6 +84,12 @@ static inline unsigned int of_gpio_count(struct device_node *np)
 	return 0;
 }
 
+static inline void of_gpio_init(struct gpio_chip *gc)
+{
+}
+static inline void of_gpio_destroy(struct gpio_chip *gc)
+{
+}
 #endif /* CONFIG_OF_GPIO */
 
 /**
-- 
1.6.5
