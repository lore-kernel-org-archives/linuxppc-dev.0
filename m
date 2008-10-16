Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3E2DCDE32E
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 04:13:01 +1100 (EST)
Date: Thu, 16 Oct 2008 21:12:59 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Message-ID: <20081016171259.GD5515@oksana.dev.rtsoft.ru>
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

Any GPIO controller that have a device associated with it is encouraged to
register/unregister the gpiochips with dev_gpiochip_*() calls.

Platform may redefine these calls to glue the gpiochips with the
architecture-specific code.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 include/asm-generic/gpio.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 0f99ad3..f31c7ae 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -89,6 +89,50 @@ extern int __must_check gpiochip_reserve(int start, int ngpio);
 extern int gpiochip_add(struct gpio_chip *chip);
 extern int __must_check gpiochip_remove(struct gpio_chip *chip);
 
+/*
+ * Platforms can define their own __dev_ versions to glue gpio_chips with the
+ * architecture-specific code.
+ */
+#ifndef __dev_gpiochip_add
+#define __dev_gpiochip_add __dev_gpiochip_add
+static inline int __dev_gpiochip_add(struct device *dev,
+				     struct gpio_chip *chip)
+{
+	chip->dev = dev;
+	return gpiochip_add(chip);
+}
+#endif /* __dev_gpiochip_add */
+
+#ifndef __dev_gpiochip_remove
+#define __dev_gpiochip_remove __dev_gpiochip_remove
+static inline int __dev_gpiochip_remove(struct device *dev,
+					struct gpio_chip *chip)
+{
+	return gpiochip_remove(chip);
+}
+#endif /* __dev_gpiochip_remove */
+
+/**
+ * dev_gpiochip_add - register a gpio_chip for a device
+ * @dev: device to register gpio_chip for
+ * @chip: the chip to register
+ * Context: potentially before irqs or kmalloc will work
+ *
+ * This function takes the extra @dev argument that is used to associate
+ * the chip with a device. Otherwise it behaves the same way as the
+ * gpiochip_add().
+ */
+#define dev_gpiochip_add(dev, chip) __dev_gpiochip_add((dev), (chip))
+
+/**
+ * dev_gpiochip_remove - unregister a gpio_chip
+ * @dev: device to remove the chip from
+ * @chip: the chip to unregister
+ *
+ * Use this function to unregister the chip that was registered using
+ * dev_gpiochip_add().
+ */
+#define dev_gpiochip_remove(dev, chip) __dev_gpiochip_remove((dev), (chip))
 
 /* Always use the library code for GPIO management calls,
  * or when sleeping may be involved.
-- 
1.5.6.3
