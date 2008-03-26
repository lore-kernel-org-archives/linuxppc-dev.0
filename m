Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4842FDDF17
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 07:24:19 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 3A3228816
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 01:24:37 +0400 (SAMT)
Date: Wed, 26 Mar 2008 23:24:16 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] of/gpio: export of_simple_xlate function
Message-ID: <20080326202416.GA1772@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So we'll able to use it for the non-memory mapped drivers (like
I2C GPIO expanders).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Depends on the previous OF GPIO work.

 drivers/of/gpio.c       |    6 +++---
 include/linux/of_gpio.h |   13 +++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
index a6775ff..03e2fed 100644
--- a/drivers/of/gpio.c
+++ b/drivers/of/gpio.c
@@ -106,9 +106,8 @@ err0:
 }
 EXPORT_SYMBOL(of_get_gpio);
 
-static int of_gpio_simple_xlate(struct of_gpio_chip *of_gc,
-				struct device_node *np,
-				const void *gpio_spec)
+int of_gpio_simple_xlate(struct of_gpio_chip *of_gc, struct device_node *np,
+			 const void *gpio_spec)
 {
 	const u32 *gpio = gpio_spec;
 
@@ -117,6 +116,7 @@ static int of_gpio_simple_xlate(struct of_gpio_chip *of_gc,
 
 	return *gpio;
 }
+EXPORT_SYMBOL(of_gpio_simple_xlate);
 
 int of_mm_gpiochip_add(struct device_node *np,
 		       struct of_mm_gpio_chip *mm_gc)
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index ca313f0..75c209c 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -83,6 +83,19 @@ extern int of_get_gpio(struct device_node *np, int index);
 extern int of_mm_gpiochip_add(struct device_node *np,
 			      struct of_mm_gpio_chip *mm_gc);
 
+/**
+ * of_gpio_simple_xlate - translate gpio_spec to the GPIO number
+ * @of_gc:	pointer to the of_gpio_chip structure
+ * @np:		device node of the GPIO chip
+ * @gpio_spec:	gpio specifier as found in the device tree
+ *
+ * This is simple translation function, suitable for the most 1:1 mapped
+ * gpio chips. This function performs only one sanity check: whether gpio
+ * is less than ngpios (that is specified in the gpio_chip).
+ */
+extern int of_gpio_simple_xlate(struct of_gpio_chip *of_gc,
+				struct device_node *np,
+				const void *gpio_spec);
 #else
 
 /* Drivers may not strictly depend on the GPIO support, so let them link. */
-- 
1.5.2.2
