Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9F15DDDDFA
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 05:15:56 +1100 (EST)
Date: Fri, 5 Dec 2008 21:15:54 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/3] of/gpio: Implement of_gpio_count()
Message-ID: <20081205181554.GC23666@oksana.dev.rtsoft.ru>
References: <20081205181503.GA9855@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081205181503.GA9855@oksana.dev.rtsoft.ru>
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This function is used to count how many GPIOs are specified for
a device node.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/of/gpio.c       |   34 ++++++++++++++++++++++++++++++++++
 include/linux/of_gpio.h |    6 ++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
index a4ba217..6eea601 100644
--- a/drivers/of/gpio.c
+++ b/drivers/of/gpio.c
@@ -80,6 +80,40 @@ err0:
 EXPORT_SYMBOL(of_get_gpio_flags);
 
 /**
+ * of_gpio_count - Count GPIOs for a device
+ * @np:		device node to count GPIOs for
+ *
+ * The function returns the count of GPIOs specified for a node.
+ *
+ * Note that the empty GPIO specifiers counts too. For example,
+ *
+ * gpios = <0
+ *          &pio1 1 2
+ *          0
+ *          &pio2 3 4>;
+ *
+ * defines four GPIOs (so this function will return 4), two of which
+ * are not specified.
+ */
+unsigned int of_gpio_count(struct device_node *np)
+{
+	unsigned int cnt = 0;
+
+	do {
+		int ret;
+
+		ret = of_parse_phandles_with_args(np, "gpios", "#gpio-cells",
+						  cnt, NULL, NULL);
+		/* A hole in the gpios = <> counts anyway. */
+		if (ret < 0 && ret != -EEXIST)
+			break;
+	} while (++cnt);
+
+	return cnt;
+}
+EXPORT_SYMBOL(of_gpio_count);
+
+/**
  * of_gpio_simple_xlate - translate gpio_spec to the GPIO number and flags
  * @of_gc:	pointer to the of_gpio_chip structure
  * @np:		device node of the GPIO chip
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index e25abf6..fc2472c 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -65,6 +65,7 @@ static inline struct of_mm_gpio_chip *to_of_mm_gpio_chip(struct gpio_chip *gc)
 
 extern int of_get_gpio_flags(struct device_node *np, int index,
 			     enum of_gpio_flags *flags);
+extern unsigned int of_gpio_count(struct device_node *np);
 
 extern int of_mm_gpiochip_add(struct device_node *np,
 			      struct of_mm_gpio_chip *mm_gc);
@@ -81,6 +82,11 @@ static inline int of_get_gpio_flags(struct device_node *np, int index,
 	return -ENOSYS;
 }
 
+static inline unsigned int of_gpio_count(struct device_node *np)
+{
+	return 0;
+}
+
 #endif /* CONFIG_OF_GPIO */
 
 /**
-- 
1.5.6.5
