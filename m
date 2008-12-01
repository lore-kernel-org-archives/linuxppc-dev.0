Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E2E8FDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 03:30:06 +1100 (EST)
Date: Mon, 1 Dec 2008 19:30:04 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2] of/gpio: Implement of_get_gpio_flags()
Message-ID: <20081201163004.GA23548@oksana.dev.rtsoft.ru>
References: <20081127204453.GA21901@oksana.dev.rtsoft.ru>
	<Pine.LNX.4.64.0811280107380.5161@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <Pine.LNX.4.64.0811280107380.5161@t2.domain.actdsltmp>
Cc: Trent Piepho <tpiepho@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This function is alike to the simple of_get_gpio(), but accepts new
argument: flags. This new function will be used by the drivers that
need to retrieve additional GPIO information, such as active-low flag.

Also, the patch changes default ("simple") .xlate routine to warn about
bogus (< 2) #gpio-cells usage: the second cell should always be present
for GPIO flags.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

v1 -> v2:
- Commit message mentions .xlate behaviour change;
- enum of_gpio_flags also defined for !CONFIG_OF_GPIO case.

 drivers/of/gpio.c       |   36 +++++++++++++++++++++++++++++-------
 include/linux/of_gpio.h |   38 ++++++++++++++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
index 7cd7301..a4ba217 100644
--- a/drivers/of/gpio.c
+++ b/drivers/of/gpio.c
@@ -19,14 +19,17 @@
 #include <asm/prom.h>
 
 /**
- * of_get_gpio - Get a GPIO number from the device tree to use with GPIO API
+ * of_get_gpio_flags - Get a GPIO number and flags to use with GPIO API
  * @np:		device node to get GPIO from
  * @index:	index of the GPIO
+ * @flags:	a flags pointer to fill in
  *
  * Returns GPIO number to use with Linux generic GPIO API, or one of the errno
- * value on the error condition.
+ * value on the error condition. If @flags is not NULL the function also fills
+ * in flags for the GPIO.
  */
-int of_get_gpio(struct device_node *np, int index)
+int of_get_gpio_flags(struct device_node *np, int index,
+		      enum of_gpio_flags *flags)
 {
 	int ret;
 	struct device_node *gc;
@@ -59,7 +62,11 @@ int of_get_gpio(struct device_node *np, int index)
 		goto err1;
 	}
 
-	ret = of_gc->xlate(of_gc, np, gpio_spec);
+	/* .xlate might decide to not fill in the flags, so clear it. */
+	if (flags)
+		*flags = 0;
+
+	ret = of_gc->xlate(of_gc, np, gpio_spec, flags);
 	if (ret < 0)
 		goto err1;
 
@@ -70,26 +77,41 @@ err0:
 	pr_debug("%s exited with status %d\n", __func__, ret);
 	return ret;
 }
-EXPORT_SYMBOL(of_get_gpio);
+EXPORT_SYMBOL(of_get_gpio_flags);
 
 /**
- * of_gpio_simple_xlate - translate gpio_spec to the GPIO number
+ * of_gpio_simple_xlate - translate gpio_spec to the GPIO number and flags
  * @of_gc:	pointer to the of_gpio_chip structure
  * @np:		device node of the GPIO chip
  * @gpio_spec:	gpio specifier as found in the device tree
+ * @flags:	a flags pointer to fill in
  *
  * This is simple translation function, suitable for the most 1:1 mapped
  * gpio chips. This function performs only one sanity check: whether gpio
  * is less than ngpios (that is specified in the gpio_chip).
  */
 int of_gpio_simple_xlate(struct of_gpio_chip *of_gc, struct device_node *np,
-			 const void *gpio_spec)
+			 const void *gpio_spec, enum of_gpio_flags *flags)
 {
 	const u32 *gpio = gpio_spec;
 
+	/*
+	 * We're discouraging gpio_cells < 2, since that way you'll have to
+	 * write your own xlate function (that will have to retrive the GPIO
+	 * number and the flags from a single gpio cell -- this is possible,
+	 * but not recommended).
+	 */
+	if (of_gc->gpio_cells < 2) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	if (*gpio > of_gc->gc.ngpio)
 		return -EINVAL;
 
+	if (flags)
+		*flags = gpio[1];
+
 	return *gpio;
 }
 EXPORT_SYMBOL(of_gpio_simple_xlate);
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 67db101..e25abf6 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -14,9 +14,22 @@
 #ifndef __LINUX_OF_GPIO_H
 #define __LINUX_OF_GPIO_H
 
+#include <linux/compiler.h>
+#include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/gpio.h>
 
+struct device_node;
+
+/*
+ * This is Linux-specific flags. By default controllers' and Linux' mapping
+ * match, but GPIO controllers are free to translate their own flags to
+ * Linux-specific in their .xlate callback. Though, 1:1 mapping is recommended.
+ */
+enum of_gpio_flags {
+	OF_GPIO_ACTIVE_LOW = 0x1,
+};
+
 #ifdef CONFIG_OF_GPIO
 
 /*
@@ -26,7 +39,7 @@ struct of_gpio_chip {
 	struct gpio_chip gc;
 	int gpio_cells;
 	int (*xlate)(struct of_gpio_chip *of_gc, struct device_node *np,
-		     const void *gpio_spec);
+		     const void *gpio_spec, enum of_gpio_flags *flags);
 };
 
 static inline struct of_gpio_chip *to_of_gpio_chip(struct gpio_chip *gc)
@@ -50,20 +63,37 @@ static inline struct of_mm_gpio_chip *to_of_mm_gpio_chip(struct gpio_chip *gc)
 	return container_of(of_gc, struct of_mm_gpio_chip, of_gc);
 }
 
-extern int of_get_gpio(struct device_node *np, int index);
+extern int of_get_gpio_flags(struct device_node *np, int index,
+			     enum of_gpio_flags *flags);
+
 extern int of_mm_gpiochip_add(struct device_node *np,
 			      struct of_mm_gpio_chip *mm_gc);
 extern int of_gpio_simple_xlate(struct of_gpio_chip *of_gc,
 				struct device_node *np,
-				const void *gpio_spec);
+				const void *gpio_spec,
+				enum of_gpio_flags *flags);
 #else
 
 /* Drivers may not strictly depend on the GPIO support, so let them link. */
-static inline int of_get_gpio(struct device_node *np, int index)
+static inline int of_get_gpio_flags(struct device_node *np, int index,
+				    enum of_gpio_flags *flags)
 {
 	return -ENOSYS;
 }
 
 #endif /* CONFIG_OF_GPIO */
 
+/**
+ * of_get_gpio - Get a GPIO number to use with GPIO API
+ * @np:		device node to get GPIO from
+ * @index:	index of the GPIO
+ *
+ * Returns GPIO number to use with Linux generic GPIO API, or one of the errno
+ * value on the error condition.
+ */
+static inline int of_get_gpio(struct device_node *np, int index)
+{
+	return of_get_gpio_flags(np, index, NULL);
+}
+
 #endif /* __LINUX_OF_GPIO_H */
-- 
1.5.6.5
