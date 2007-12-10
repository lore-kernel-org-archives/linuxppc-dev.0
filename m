Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id AA118DEAB2
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 07:45:49 +1100 (EST)
Date: Mon, 10 Dec 2007 23:49:06 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC 4/7] [GPIO] Let drivers link if they support GPIO API as
	an addition
Message-ID: <20071210204906.GD32278@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071210204705.GA31263@localhost.localdomain>
Cc: dbrownell@users.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Hello David,

I'm interested in your opinion about that patch. You're also Cc'ed
to patch that using that feature.

I know, currently that patch will conflict with GPIOLIB patches in -mm,
so this is only RFC.

 include/asm-generic/gpio.h |   47 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 2d0aab1..cf76a69 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -1,6 +1,53 @@
 #ifndef _ASM_GENERIC_GPIO_H
 #define _ASM_GENERIC_GPIO_H
 
+#ifndef CONFIG_GENERIC_GPIO
+
+/*
+ * Drivers could be gpio api aware, and at the same time, some
+ * of them can live without it, or support call-backs approach
+ * in addition. Let them link.
+ */
+static inline int gpio_request(unsigned int gpio, const char *label)
+{
+	return -ENOSYS;
+}
+
+static inline void gpio_free(unsigned int gpio)
+{
+}
+
+static inline int gpio_direction_input(unsigned int gpio)
+{
+	return -ENOSYS;
+}
+
+static inline int gpio_direction_output(unsigned int gpio, int value)
+{
+	return -ENOSYS;
+}
+
+static inline int gpio_get_value(unsigned int gpio)
+{
+	return -ENOSYS;
+}
+
+static inline void gpio_set_value(unsigned int gpio, int value)
+{
+}
+
+static inline int gpio_to_irq(unsigned int gpio)
+{
+	return -ENOSYS;
+}
+
+static inline int irq_to_gpio(unsigned int irq)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_GENERIC_GPIO */
+
 /* platforms that don't directly support access to GPIOs through I2C, SPI,
  * or other blocking infrastructure can use these wrappers.
  */
-- 
1.5.2.2
