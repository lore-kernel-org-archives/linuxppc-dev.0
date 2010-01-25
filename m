Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 207781007D3
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 05:11:01 +1100 (EST)
Date: Mon, 25 Jan 2010 21:11:00 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 1/4] gpiolib: Introduce chip addition/removal notifier
Message-ID: <20100125181100.GA13805@oksana.dev.rtsoft.ru>
References: <20100125180957.GA5380@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100125180957.GA5380@oksana.dev.rtsoft.ru>
Cc: Bill Gatliff <bgat@billgatliff.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some platforms (e.g. OpenFirmware) want to know when a particular chip
added or removed, so that the platforms could add their specifics for
non-platform devices, like I2C or SPI GPIO chips.

This patch implements the notifier for chip addition and removal events.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/gpio/Kconfig       |    7 +++++++
 drivers/gpio/gpiolib.c     |   28 ++++++++++++++++++++++++++++
 include/asm-generic/gpio.h |    8 ++++++++
 3 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 1f1d88a..511b29f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -63,6 +63,13 @@ config GPIO_SYSFS
 	  Kernel drivers may also request that a particular GPIO be
 	  exported to userspace; this can be useful when debugging.
 
+config GPIOLIB_NOTIFIER
+	bool
+	help
+	  This symbol is selected by subsystems that need to handle GPIO
+	  chips addition and removal. E.g., this is used for the
+	  OpenFirmware bindings.
+
 # put expanders in the right section, in alphabetical order
 
 comment "Memory mapped GPIO expanders:"
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 350842a..9496b78 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -9,6 +9,7 @@
 #include <linux/seq_file.h>
 #include <linux/gpio.h>
 #include <linux/idr.h>
+#include <linux/notifier.h>
 
 
 /* Optional implementation infrastructure for GPIO interfaces.
@@ -82,6 +83,25 @@ static inline void desc_set_label(struct gpio_desc *d, const char *label)
 #endif
 }
 
+#ifdef CONFIG_GPIOLIB_NOTIFIER
+BLOCKING_NOTIFIER_HEAD(gpio_notifier);
+EXPORT_SYMBOL_GPL(gpio_notifier);
+
+static int gpio_call_chain(struct gpio_chip *chip, enum gpio_notify_msg msg)
+{
+	int ret;
+
+	ret = blocking_notifier_call_chain(&gpio_notifier, msg, chip);
+
+	return notifier_to_errno(ret);
+}
+#else
+static int gpio_call_chain(struct gpio_chip *chip, enum gpio_notify_msg msg)
+{
+	return notifier_to_errno(NOTIFY_OK);
+}
+#endif /* CONFIG_GPIOLIB_NOTIFIER */
+
 /* Warn when drivers omit gpio_request() calls -- legal but ill-advised
  * when setting direction, and otherwise illegal.  Until board setup code
  * and drivers use explicit requests everywhere (which won't happen when
@@ -1103,6 +1123,9 @@ fail:
 		pr_err("gpiochip_add: gpios %d..%d (%s) not registered\n",
 			chip->base, chip->base + chip->ngpio - 1,
 			chip->label ? : "generic");
+	else
+		gpio_call_chain(chip, GPIO_NOTIFY_CHIP_ADDED);
+
 	return status;
 }
 EXPORT_SYMBOL_GPL(gpiochip_add);
@@ -1119,6 +1142,11 @@ int gpiochip_remove(struct gpio_chip *chip)
 	int		status = 0;
 	unsigned	id;
 
+	/* Ask external subsystems to release the chip. */
+	status = gpio_call_chain(chip, GPIO_NOTIFY_CHIP_REMOVE);
+	if (status)
+		return status;
+
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	for (id = chip->base; id < chip->base + chip->ngpio; id++) {
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 485eeb6..84faae4 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/notifier.h>
 
 #ifdef CONFIG_GPIOLIB
 
@@ -208,4 +209,11 @@ static inline void gpio_unexport(unsigned gpio)
 }
 #endif	/* CONFIG_GPIO_SYSFS */
 
+enum gpio_notify_msg {
+	GPIO_NOTIFY_CHIP_ADDED = 0,
+	GPIO_NOTIFY_CHIP_REMOVE = 1,
+};
+
+extern struct blocking_notifier_head gpio_notifier;
+
 #endif /* _ASM_GENERIC_GPIO_H */
-- 
1.6.5.7
