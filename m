Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKdkQ2hFnzF0bg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 14:14:37 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Albert Herranz <albert_herranz@yahoo.es>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/6] gpio: Add GPIO driver for Nintendo Wii
Date: Mon, 15 Jan 2018 04:13:58 +0100
Message-Id: <20180115031401.19577-4-j.neuschaefer@gmx.net>
In-Reply-To: <20180115031401.19577-1-j.neuschaefer@gmx.net>
References: <20180115031401.19577-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
that supports a configurable number of pins (up to 32), interrupts, and
some special mechanisms to share the controller between the system's
security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
not supported.

This patch adds a basic driver for this GPIO controller. Interrupt
support will come in a later patch.

This patch is based on code developed by Albert Herranz and the GameCube
Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
has grown quite dissimilar.

To compare this version of the driver against the original code:
$ git fetch https://github.com/DeltaResero/GC-Wii-Linux-Kernels
$ git co FETCH_HEAD -- arch/powerpc/platforms/embedded6xx/hlwd-gpio.c
$ diff -u arch/powerpc/platforms/embedded6xx/hlwd-gpio.c \
          drivers/gpio/gpio-hlwd.c

Cc: Albert Herranz <albert_herranz@yahoo.es>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

---
This driver currently uses __raw_readl and __raw_writel to access the
GPIO controller's MMIO registers. I wonder if readl/writel plus explicit
byte-swapping would be more correct, because it could be independent of
the CPU's endianness. That said, this hardware only exists in two
big-endian machines (Wii and Wii U).
---
 drivers/gpio/Kconfig     |   8 +++
 drivers/gpio/Makefile    |   1 +
 drivers/gpio/gpio-hlwd.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/gpio/gpio-hlwd.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d6a8e851ad13..4f85c2053f7d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -229,6 +229,14 @@ config GPIO_GRGPIO
 	  Select this to support Aeroflex Gaisler GRGPIO cores from the GRLIB
 	  VHDL IP core library.
 
+config GPIO_HLWD
+	tristate "Nintendo Wii (Hollywood) GPIO"
+	depends on OF_GPIO
+	help
+	  Select this to support the GPIO controller of the Nintendo Wii.
+
+	  If unsure, say N.
+
 config GPIO_ICH
 	tristate "Intel ICH GPIO"
 	depends on PCI && X86
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4bc24febb889..492f62d0eb59 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_GPIO_FTGPIO010)	+= gpio-ftgpio010.o
 obj-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
 obj-$(CONFIG_GPIO_GPIO_MM)	+= gpio-gpio-mm.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
+obj-$(CONFIG_GPIO_HLWD)		+= gpio-hlwd.o
 obj-$(CONFIG_HTC_EGPIO)		+= gpio-htc-egpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
 obj-$(CONFIG_GPIO_INGENIC)	+= gpio-ingenic.o
diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
new file mode 100644
index 000000000000..0f8942ea6ed6
--- /dev/null
+++ b/drivers/gpio/gpio-hlwd.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (C) 2008-2009 The GameCube Linux Team
+// Copyright (C) 2008,2009 Albert Herranz
+// Copyright (C) 2017-2018 Jonathan Neuschäfer
+//
+// Nintendo Wii (Hollywood) GPIO driver
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/gpio/driver.h>
+#include <linux/spinlock.h>
+
+/*
+ * Register names and offsets courtesy of WiiBrew:
+ * https://wiibrew.org/wiki/Hardware/Hollywood_GPIOs
+ *
+ * Note that for most registers, there are two versions:
+ * - HW_GPIOB_* Is always accessible by the Broadway PowerPC core, but does
+ *   always give access to all GPIO lines
+ * - HW_GPIO_* Is only accessible by the Broadway PowerPC code if the memory
+ *   firewall (AHBPROT) in the Hollywood chipset has been configured to allow
+ *   such access.
+ *
+ * The ownership of each GPIO line can be configured in the HW_GPIO_OWNER
+ * register: A one bit configures the line for access via the HW_GPIOB_*
+ * registers, a zero bit indicates access via HW_GPIO_*. This driver uses
+ * HW_GPIOB_*.
+ */
+#define HW_GPIOB_OUT		0x00
+#define HW_GPIOB_DIR		0x04
+#define HW_GPIOB_IN		0x08
+#define HW_GPIOB_INTLVL		0x0c
+#define HW_GPIOB_INTFLAG	0x10
+#define HW_GPIOB_INTMASK	0x14
+#define HW_GPIOB_INMIR		0x18
+#define HW_GPIO_ENABLE		0x1c
+#define HW_GPIO_OUT		0x20
+#define HW_GPIO_DIR		0x24
+#define HW_GPIO_IN		0x28
+#define HW_GPIO_INTLVL		0x2c
+#define HW_GPIO_INTFLAG		0x30
+#define HW_GPIO_INTMASK		0x34
+#define HW_GPIO_INMIR		0x38
+#define HW_GPIO_OWNER		0x3c
+
+
+struct hlwd_gpio {
+	struct gpio_chip gpioc;
+	void __iomem *regs;
+	spinlock_t lock;
+};
+
+/*
+ * Update the bit with the given bit offset in the given register to a given
+ * value
+ */
+static void hlwd_gpio_update_bit(struct gpio_chip *gc, unsigned int reg,
+		int offset, int value)
+{
+	struct hlwd_gpio *hlwd = gpiochip_get_data(gc);
+	unsigned long flags;
+	u32 bit = 1UL << offset;
+	u32 tmp;
+
+	spin_lock_irqsave(&hlwd->lock, flags);
+	tmp = __raw_readl(hlwd->regs + reg);
+	if (value)
+		__raw_writel(tmp | bit, hlwd->regs + reg);
+	else
+		__raw_writel(tmp & ~bit, hlwd->regs + reg);
+	spin_unlock_irqrestore(&hlwd->lock, flags);
+}
+
+/* Read the bit with the given bit offset in the given register */
+static int hlwd_gpio_read_bit(struct gpio_chip *gc, unsigned int reg,
+		unsigned int offset)
+{
+	struct hlwd_gpio *hlwd = gpiochip_get_data(gc);
+	unsigned long flags;
+	u32 bit = 1UL << offset;
+	u32 tmp;
+
+	spin_lock_irqsave(&hlwd->lock, flags);
+	tmp = __raw_readl(hlwd->regs + reg);
+	spin_unlock_irqrestore(&hlwd->lock, flags);
+
+	return !!(tmp & bit);
+}
+
+static int hlwd_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	return hlwd_gpio_read_bit(gc, HW_GPIOB_IN, offset);
+}
+
+static void hlwd_gpio_set(struct gpio_chip *gc, unsigned int offset, int val)
+{
+	hlwd_gpio_update_bit(gc, HW_GPIOB_OUT, offset, val);
+}
+
+static int hlwd_gpio_dir_in(struct gpio_chip *gc, unsigned int offset)
+{
+	hlwd_gpio_update_bit(gc, HW_GPIOB_DIR, offset, 0);
+
+	return 0;
+}
+
+static int hlwd_gpio_dir_out(struct gpio_chip *gc,
+		unsigned int offset, int val)
+{
+	/* Set the GPIO value, and then set the direction */
+	hlwd_gpio_set(gc, offset, val);
+	hlwd_gpio_update_bit(gc, HW_GPIOB_DIR, offset, 1);
+
+	return 0;
+}
+
+static int hlwd_gpio_probe(struct platform_device *pdev)
+{
+	struct hlwd_gpio *hlwd;
+	struct resource *regs_resource;
+	u32 ngpios;
+
+	hlwd = devm_kzalloc(&pdev->dev, sizeof(*hlwd), GFP_KERNEL);
+	if (!hlwd)
+		return -ENOMEM;
+
+	regs_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (IS_ERR(regs_resource))
+		return PTR_ERR(regs_resource);
+
+	hlwd->regs = devm_ioremap_resource(&pdev->dev, regs_resource);
+	if (IS_ERR(hlwd->regs))
+		return PTR_ERR(hlwd->regs);
+
+	/*
+	 * Claim all GPIOs using the OWNER register. This will not work on
+	 * systems where the AHBPROT memory firewall hasn't been configured to
+	 * permit PPC access to HW_GPIO_*.
+	 */
+	__raw_writel(0xffffffff, hlwd->regs + HW_GPIO_OWNER);
+
+	spin_lock_init(&hlwd->lock);
+
+	hlwd->gpioc.label = dev_name(&pdev->dev);
+	hlwd->gpioc.parent = &pdev->dev;
+	hlwd->gpioc.owner = THIS_MODULE;
+	hlwd->gpioc.direction_input = hlwd_gpio_dir_in;
+	hlwd->gpioc.direction_output = hlwd_gpio_dir_out;
+	hlwd->gpioc.get = hlwd_gpio_get;
+	hlwd->gpioc.set = hlwd_gpio_set;
+
+	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios))
+		ngpios = 32;
+	hlwd->gpioc.ngpio = ngpios;
+
+	return devm_gpiochip_add_data(&pdev->dev, &hlwd->gpioc, hlwd);
+}
+
+static const struct of_device_id hlwd_gpio_match[] = {
+	{ .compatible = "nintendo,hollywood-gpio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hlwd_gpio_match);
+
+static struct platform_driver hlwd_gpio_driver = {
+	.driver	= {
+		.name		= "hlwd_gpio",
+		.of_match_table	= hlwd_gpio_match,
+	},
+	.probe	= hlwd_gpio_probe,
+};
+module_platform_driver(hlwd_gpio_driver);
+
+MODULE_AUTHOR("Jonathan Neuschäfer <j.neuschaefer@gmx.net>");
+MODULE_DESCRIPTION("Nintendo Wii GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.15.1
