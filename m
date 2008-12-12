Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 44F6BDE0D8
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 01:22:05 +1100 (EST)
Message-ID: <4942738A.80609@harris.com>
Date: Fri, 12 Dec 2008 09:22:02 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [RFC] Dummy GPIO driver for use with SPI
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a dummy GPIO driver, which is useful for SPI devices
that do not have a physical chip select.

Signed-off-by: Steven A. Falco <sfalco@harris.com>
---
The SPI subsystem requires a chip-select for each connected slave
device.  I have a custom board with an Atmel "co-processor".  This part
is reprogrammed via SPI, so it needs a chip select to satisfy the SPI
subsystem, but my hardware does not have a physical CS connected.

I could waste a "no-connect" GPIO pin, but I'd rather not.  So, I've
written a dummy GPIO driver, which behaves exactly like a real GPIO
device, but with no underlying hardware.  This could also be useful
as a template for real GPIO drivers.

I use the following dts entry:

	GPIO3: dummy@ef500000 {
		compatible = "linux,dummy-gpio";
		reg = <ef500000 1>;
		gpio-controller;
		#gpio-cells = <2>;
	};

Because the device is registered via of_mm_gpiochip_add, I have to
provide it a resource.  The driver will ioremap this resource, but will
not touch it.  So, I simply chose a reserved address in the 440EPx
address space, to satisfy that requirement.  Any unused, ioremap-able
address can be used for this purpose.

I've put this into the platforms/44x/Kconfig for this example, but it
probably ought to go into sysdev/Kconfig, if it is of general interest.

Comments invited.

	Steve


 arch/powerpc/platforms/44x/Kconfig |    8 +++
 arch/powerpc/sysdev/Makefile       |    1 +
 arch/powerpc/sysdev/dummy_gpio.c   |   98 ++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/dummy_gpio.c

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index eec5cb4..5b52956 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -143,6 +143,14 @@ config XILINX_VIRTEX440_GENERIC_BOARD
 	  Most Virtex 5 designs should use this unless it needs to do some
 	  special configuration at board probe time.
 
+config DUMMY_GPIO
+	bool "Dummy GPIO support"
+	depends on 44x
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_GPIO
+	help
+	  Enable gpiolib support for dummy devices
+
 config PPC4xx_GPIO
 	bool "PPC4xx GPIO support"
 	depends on 44x
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 35d5765..0f76f2a 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -36,6 +36,7 @@ ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
 endif
 obj-$(CONFIG_PPC4xx_GPIO)	+= ppc4xx_gpio.o
+obj-$(CONFIG_DUMMY_GPIO)	+= dummy_gpio.o
 
 # Temporary hack until we have migrated to asm-powerpc
 ifeq ($(ARCH),powerpc)
diff --git a/arch/powerpc/sysdev/dummy_gpio.c b/arch/powerpc/sysdev/dummy_gpio.c
new file mode 100644
index 0000000..22f93d6
--- /dev/null
+++ b/arch/powerpc/sysdev/dummy_gpio.c
@@ -0,0 +1,98 @@
+/*
+ * Dummy gpio driver
+ *
+ * Copyright (c) 2008 Harris Corporation
+ * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
+ * Copyright (c) MontaVista Software, Inc. 2008.
+ *
+ * Author: Steve Falco <sfalco@harris.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+#include <linux/types.h>
+
+struct dummy_gpio_chip {
+	struct of_mm_gpio_chip mm_gc;
+};
+
+static int dummy_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	return 0;
+}
+
+static void
+dummy_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+}
+
+static int dummy_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	return 0;
+}
+
+static int
+dummy_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	return 0;
+}
+
+static int __init dummy_add_gpiochips(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "linux,dummy-gpio") {
+		int ret;
+		struct dummy_gpio_chip *dummy_gc;
+		struct of_mm_gpio_chip *mm_gc;
+		struct of_gpio_chip *of_gc;
+		struct gpio_chip *gc;
+
+		dummy_gc = kzalloc(sizeof(*dummy_gc), GFP_KERNEL);
+		if (!dummy_gc) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		mm_gc = &dummy_gc->mm_gc;
+		of_gc = &mm_gc->of_gc;
+		gc = &of_gc->gc;
+
+		of_gc->gpio_cells = 2;
+		gc->ngpio = 32;
+		gc->direction_input = dummy_gpio_dir_in;
+		gc->direction_output = dummy_gpio_dir_out;
+		gc->get = dummy_gpio_get;
+		gc->set = dummy_gpio_set;
+
+		ret = of_mm_gpiochip_add(np, mm_gc);
+		if (ret)
+			goto err;
+		continue;
+err:
+		pr_err("%s: registration failed with status %d\n",
+		       np->full_name, ret);
+		kfree(dummy_gc);
+		/* try others anyway */
+	}
+	return 0;
+}
+arch_initcall(dummy_add_gpiochips);
-- 
1.6.0.2
