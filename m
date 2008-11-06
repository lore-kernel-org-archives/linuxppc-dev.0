Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-8.online-age.net (Ext-cn0ut-8.online-age.net
	[63.210.253.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 646B4DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 23:04:04 +1100 (EST)
Received: from int-cn0ut-6.online-age.net (int-cn0ut-6.online-age.net
	[3.159.252.75])
	by ext-cn0ut-8.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id mA6C31P0018302
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Nov 2008 07:03:02 -0500
Received: from alpmlip01.e2k.ad.ge.com (int-cn0ut-6.online-age.net
	[3.159.252.75])
	by int-cn0ut-6.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id mA6C3xrK001057
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Nov 2008 07:03:59 -0500
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc: Basic GPIO support for GE Fanuc SBC610
To: linuxppc-dev@ozlabs.org
Date: Thu, 06 Nov 2008 12:03:53 +0000
Message-ID: <20081106120353.8134.54609.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Basic support for the GPIO available on the SBC610 VPX Single Board Computer
from GE Fanuc (PowerPC MPC8641D).

This patch adds basic support for the GPIO in the devices I/O FPGA, the GPIO
functionality is exposed through the AFIX pins on the backplane, unless used
by an AFIX card.

This code currently does not support switching between totem-pole and
open-drain outputs (when used as outputs, GPIOs default to totem-pole).
The interrupt capabilites of the GPIO lines is also not currently supported.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc610.dts   |    6 +
 arch/powerpc/platforms/86xx/Kconfig    |    2 
 arch/powerpc/platforms/86xx/Makefile   |    3 -
 arch/powerpc/platforms/86xx/gef_gpio.c |  185 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/gef_gpio.h |   10 ++
 5 files changed, 205 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index 6ed6083..963dd5b 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -98,6 +98,12 @@
 			interrupt-parent = <&mpic>;
 
 		};
+		gef_gpio: gpio@7,14000 {
+			#gpio-cells = <1>;
+			compatible = "gef,fpga-gpio";
+			reg = <0x7 0x14000 0x24>;
+			gpio-controller;
+		};
 	};
 
 	soc@fef00000 {
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 77dd797..8e56939 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -34,6 +34,8 @@ config MPC8610_HPCD
 config GEF_SBC610
 	bool "GE Fanuc SBC610"
 	select DEFAULT_UIMAGE
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
 	select HAS_RAPIDIO
 	help
 	  This option enables support for GE Fanuc's SBC610.
diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index 4a56ff6..31e540c 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
 obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
 obj-$(CONFIG_SBC8641D)		+= sbc8641d.o
 obj-$(CONFIG_MPC8610_HPCD)	+= mpc8610_hpcd.o
-obj-$(CONFIG_GEF_SBC610)	+= gef_sbc610.o gef_pic.o
+gef-gpio-$(CONFIG_GPIOLIB)	+= gef_gpio.o
+obj-$(CONFIG_GEF_SBC610)	+= gef_sbc610.o gef_pic.o $(gef-gpio-y)
diff --git a/arch/powerpc/platforms/86xx/gef_gpio.c b/arch/powerpc/platforms/86xx/gef_gpio.c
new file mode 100644
index 0000000..2c935b6
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/gef_gpio.c
@@ -0,0 +1,185 @@
+/*
+ * Driver for GE Fanuc's FPGA based GPIO pins
+ *
+ * Author: Martyn Welch <martyn.welch@gefanuc.com>
+ *
+ * 2008 (c) GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/* TODO
+ *
+ * Configuration of output modes (totem-pole/open-drain)
+ * Interrupt configuration - interrupts are always generated the FPGA relies on
+ * 	the I/O interrupt controllers mask to stop them propergating
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+
+#include "gef_gpio.h"
+
+#define DEBUG
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt...) do { printk(KERN_DEBUG "gef_gpio: " fmt); } while (0)
+#else
+#define DBG(fmt...) do { } while (0)
+#endif
+
+#define NUM_GPIO 19
+
+/* Let's create a common inlined function to commonise the code and so we don't
+ * have to resolve the chip structure multiple times.
+ */
+inline void _gef_gpio_set(void __iomem *reg, unsigned int offset, int value)
+{
+	unsigned int data;
+
+	data = ioread32be(reg);
+	/* value: 0=low; 1=high */
+	DBG("Output Set, Pre:0x%8.8x, ", data);
+	if (value & 0x1) {
+		data = data | (0x1 << offset);
+		DBG("OR Mask:0x%8.8x, Post:0x%8.8x\n", (0x1 << offset), data);
+	} else {
+		data = data & ~(0x1 << offset);
+		DBG("AND Mask:0x%8.8x, Post:0x%8.8x\n", ~(0x1 << offset), data);
+	}
+	iowrite32be(data, reg);
+}
+
+
+static int gef_gpio_dir_in(struct gpio_chip *chip, unsigned offset)
+{
+	struct of_mm_gpio_chip *mmchip;
+	unsigned int data;
+
+	/* Find memory mapped gpio chip structure from gpio_chip, this contains
+	 * the mapped location of the GPIO controller */
+	mmchip = to_of_mm_gpio_chip(chip);
+
+	data = ioread32be(mmchip->regs + GEF_GPIO_DIRECT);
+	DBG("Direction In, Pre:0x%8.8x, ", data);
+	data = data | (0x1 << offset);
+	DBG("OR Mask:0x%8.8x, Post:0x%8.8x\n", (0x1 << offset), data);
+	iowrite32be(data, mmchip->regs + GEF_GPIO_DIRECT);
+
+	return 0;
+}
+
+static int gef_gpio_dir_out(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct of_mm_gpio_chip *mmchip;
+	unsigned int data;
+
+	/* Find memory mapped gpio chip structure from gpio_chip, this contains
+	 * the mapped location of the GPIO controller */
+	mmchip = to_of_mm_gpio_chip(chip);
+
+	/* Set direction before switching to input */
+	_gef_gpio_set(mmchip->regs + GEF_GPIO_OUT, offset, value);
+
+	data = ioread32be(mmchip->regs + GEF_GPIO_DIRECT);
+	DBG("Direction Out, Pre:0x%8.8x, ", data);
+	data = data & ~(0x1 << offset);
+	DBG("AND Mask:0x%8.8x, Post:0x%8.8x\n", ~(0x1 << offset), data);
+	iowrite32be(data, mmchip->regs + GEF_GPIO_DIRECT);
+
+	return 0;
+}
+
+static int gef_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct of_mm_gpio_chip *mmchip;
+	unsigned int data;
+	int state = 0;
+
+	/* Find memory mapped gpio chip structure from gpio_chip, this contains
+	 * the mapped location of the GPIO controller */
+	mmchip = to_of_mm_gpio_chip(chip);
+
+	data = ioread32be(mmchip->regs + GEF_GPIO_IN);
+	state = (int)((data >> offset) & 0x1);
+	DBG("Get Input, Data:0x%8.8x\n", data);
+
+	return state;
+}
+
+static void gef_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct of_mm_gpio_chip *mmchip;
+
+	/* Find memory mapped gpio chip structure from gpio_chip, this contains
+	 * the mapped location of the GPIO controller */
+	mmchip = to_of_mm_gpio_chip(chip);
+
+	_gef_gpio_set(mmchip->regs + GEF_GPIO_OUT, offset, value);
+
+}
+
+static int __devinit gef_gpio_probe(struct of_device *dev,
+	const struct of_device_id *match)
+{
+	int retval;
+	struct of_mm_gpio_chip *gef_gpio_chip;
+
+	DBG("gef_gpio_probe() called for %s\n", dev->node->full_name);
+
+	/* Allocate chip structure */
+	gef_gpio_chip = kzalloc(sizeof(*gef_gpio_chip), GFP_KERNEL);
+	if (!gef_gpio_chip) {
+		DBG("Unable to allocate GEF GPIO structure\n");
+		return -ENOMEM;
+	}
+
+	/* Setup pointers to chip functions */
+	gef_gpio_chip->of_gc.gpio_cells			= 1;
+	gef_gpio_chip->of_gc.gc.ngpio			= NUM_GPIO;
+	gef_gpio_chip->of_gc.gc.direction_input		= gef_gpio_dir_in;
+	gef_gpio_chip->of_gc.gc.direction_output	= gef_gpio_dir_out;
+	gef_gpio_chip->of_gc.gc.get			= gef_gpio_get;
+	gef_gpio_chip->of_gc.gc.set			= gef_gpio_set;
+
+	/* This function adds a memory mapped GPIO chip */
+	retval = of_mm_gpiochip_add(dev->node, gef_gpio_chip);
+	if (retval)
+		return retval;
+
+	return 0;
+};
+
+static const struct of_device_id gef_gpio_ids[] = {
+	{
+		.compatible = "gef,fpga-gpio",
+	},
+	{},
+};
+
+static struct of_platform_driver gef_gpio_driver = {
+	.name = "gef-of-gpio",
+	.match_table = gef_gpio_ids,
+	.probe = gef_gpio_probe,
+};
+
+static __init int gef_gpio_init(void)
+{
+	DBG("gef_gpio_init()\n");
+i	return of_register_platform_driver(&gef_gpio_driver);
+}
+subsys_initcall(gef_gpio_init);
+
+MODULE_DESCRIPTION("GE Fanuc I/O FPGA GPIO driver");
+MODULE_AUTHOR("Martyn Welch <martyn.welch@gefanuc.com");
+MODULE_LICENSE("GPL");
+
diff --git a/arch/powerpc/platforms/86xx/gef_gpio.h b/arch/powerpc/platforms/86xx/gef_gpio.h
new file mode 100755
index 0000000..5f76a7c
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/gef_gpio.h
@@ -0,0 +1,10 @@
+#define GEF_GPIO_DIRECT		0x00
+#define GEF_GPIO_IN		0x04
+#define GEF_GPIO_OUT		0x08
+#define GEF_GPIO_TRIG		0x0C
+#define GEF_GPIO_POLAR_A	0x10
+#define GEF_GPIO_POLAR_B	0x14
+#define GEF_GPIO_INT_STAT	0x18
+#define GEF_GPIO_OVERRUN	0x1C
+#define GEF_GPIO_MODE		0x20
+
