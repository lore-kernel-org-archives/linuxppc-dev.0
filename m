Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C56B4DE008
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 04:10:46 +1100 (EST)
Date: Thu, 27 Mar 2008 20:10:44 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: i2c@lm-sensors.org
Subject: Re: [PATCH 4/5] i2c: MPC837xRDB Power Management and GPIO expander
	driver
Message-ID: <20080327171044.GA1582@localhost.localdomain>
References: <20080326202511.GD1772@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080326202511.GD1772@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 11:25:11PM +0300, Anton Vorontsov wrote:
> On the MPC837xRDB boards there is MC9S08QG8 (MCU) chip with the custom
> firmware pre-programmed. This firmware offers to control some of the MCU
> GPIO pins via I2C (two pins, connected to the LEDs, but also available
> from the J28 and J43 headers, plus another (third) pin is a GPIO as well
> but on this board it is reserved for Power-Off function). MCU have some
> other functions, but these are not implemented yet.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> This patch depends on the not yet applied OF/PowerPC GPIO patches, so
> please consider this for RFC only.
> 
> Thanks.

Since the same chip with the identical firmware also found on the
MPC8349E-mITXE board (thanks to Timur Tabi for noticing) here is an updated
patch. MPC8349E-mITX board predates MPC837X-RDB boards, so I renamed this
driver to mcu_mpc8349emitx.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: i2c: MPC8349E-mITX/MPC837x-RDB Power Management and GPIO expander driver

On the MPC8349E-mITX and MPC837x-RDB boards there is MC9S08QG8 (MCU) chip
with the custom firmware pre-programmed. This firmware offers to control
some of the MCU GPIO pins (used for LEDs and soft power-off) via I2C. MCU
have some other functions, but these are not implemented yet.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/i2c/chips/Kconfig            |   11 ++
 drivers/i2c/chips/Makefile           |    1 +
 drivers/i2c/chips/mcu_mpc8349emitx.c |  189 ++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/chips/mcu_mpc8349emitx.c

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 09d4937..d3e3bfb 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -150,4 +150,15 @@ config OZ99X
 	  This driver can also be built as a module.  If so, the module
 	  will be called oz99x.
 
+config MCU_MPC8349EMITX
+	tristate "MPC8349E-mITX/MPC837X-RDB MCU driver"
+	depends on I2C && (MPC834x_ITX || MPC837x_RDB)
+	select GENERIC_GPIO
+	select HAVE_GPIO_LIB
+	help
+	  Say Y here to enable soft power-off functionality on the Freescale
+	  MPC8349E-mITX and MPC837X-RDB boards, plus this driver will register
+	  MCU GPIOs as a generic GPIO API chip, so you'll able to use some MCU
+	  pins as a GPIOs and LEDs.
+
 endmenu
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index c69f891..89c92df 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 obj-$(CONFIG_OZ99X)		+= oz99x.o
+obj-$(CONFIG_MCU_MPC8349EMITX)	+= mcu_mpc8349emitx.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/i2c/chips/mcu_mpc8349emitx.c b/drivers/i2c/chips/mcu_mpc8349emitx.c
new file mode 100644
index 0000000..b90dbe9
--- /dev/null
+++ b/drivers/i2c/chips/mcu_mpc8349emitx.c
@@ -0,0 +1,189 @@
+/*
+ * MPC8349E-mITX/MPC837x-RDB Power Management and GPIO expander driver
+ *
+ * On the MPC8349E-mITX and MPC837x-RDB boards there is MC9S08QG8 (MCU) chip
+ * with the custom firmware pre-programmed. This firmware offers to control
+ * some of the MCU GPIO pins (used for LEDs and soft power-off) via I2C. MCU
+ * have some other functions, but these are not implemented yet.
+ *
+ * Copyright (c) 2008  MontaVista Software, Inc.
+ *
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <asm/machdep.h>
+
+/*
+ * I don't have specifications for the MCU firmware that is used on the
+ * MPC8349E-mITX/MPC837XRDB boards, I found this register and bits positions
+ * by the trial&error method.
+ */
+#define MCU_REG_CTRL	0x20
+#define MCU_CTRL_POFF	0x40
+#define MCU_NUM_GPIO	2
+
+struct mcu {
+	spinlock_t lock;
+	struct device_node *np;
+	struct i2c_client *client;
+	struct of_gpio_chip of_gc;
+	u8 reg_ctrl;
+};
+
+static struct mcu *glob_mcu;
+
+static void mcu_power_off(void)
+{
+	struct mcu *mcu = glob_mcu;
+
+	pr_info("Sending power-off request to the MCU...\n");
+	spin_lock(&mcu->lock);
+	i2c_smbus_write_byte_data(glob_mcu->client, MCU_REG_CTRL,
+				  mcu->reg_ctrl | MCU_CTRL_POFF);
+	spin_unlock(&mcu->lock);
+}
+
+static void mcu_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_gpio_chip *of_gc = to_of_gpio_chip(gc);
+	struct mcu *mcu = container_of(of_gc, struct mcu, of_gc);
+	u8 bit = 1 << (4 + gpio);
+
+	spin_lock(&mcu->lock);
+	if (val)
+		mcu->reg_ctrl |= bit;
+	else
+		mcu->reg_ctrl &= ~bit;
+
+	i2c_smbus_write_byte_data(mcu->client, MCU_REG_CTRL, mcu->reg_ctrl);
+	spin_unlock(&mcu->lock);
+}
+
+static int mcu_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	mcu_gpio_set(gc, gpio, val);
+	return 0;
+}
+
+static int mcu_gpiochip_add(struct mcu *mcu)
+{
+	struct device_node *np;
+	struct of_gpio_chip *of_gc = &mcu->of_gc;
+	struct gpio_chip *gc = &of_gc->gc;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mcu-mpc8349emitx");
+	if (!np)
+		return -ENODEV;
+
+	gc->label = np->full_name;
+	gc->can_sleep = 1;
+	gc->ngpio = MCU_NUM_GPIO;
+	gc->base = -1;
+	gc->set = mcu_gpio_set;
+	gc->direction_output = mcu_gpio_dir_out;
+	of_gc->gpio_cells = 1;
+	of_gc->xlate = of_gpio_simple_xlate;
+
+	np->data = of_gc;
+	mcu->np = np;
+
+	/*
+	 * We don't want to lose the node, its ->data and ->full_name...
+	 * So, there is no of_node_put(np); here.
+	 */
+	return gpiochip_add(gc);
+}
+
+static void mcu_gpiochip_remove(struct mcu *mcu)
+{
+	gpiochip_remove(&mcu->of_gc.gc);
+	of_node_put(mcu->np);
+}
+
+static int mcu_probe(struct i2c_client *client)
+{
+	struct mcu *mcu;
+	int ret;
+
+	mcu = kzalloc(sizeof(*mcu), GFP_KERNEL);
+	if (!mcu)
+		return -ENOMEM;
+
+	spin_lock_init(&mcu->lock);
+	mcu->client = client;
+	i2c_set_clientdata(client, mcu);
+
+	ret = i2c_smbus_read_byte_data(mcu->client, MCU_REG_CTRL);
+	if (ret < 0)
+		goto err_iic_read;
+	mcu->reg_ctrl = ret;
+
+	ret = mcu_gpiochip_add(mcu);
+	if (ret)
+		goto err_gpio;
+
+	/* XXX: this is potentionally racy, but there is no ppc_md lock */
+	if (!ppc_md.power_off) {
+		glob_mcu = mcu;
+		ppc_md.power_off = mcu_power_off;
+		dev_info(&client->dev, "will provide power-off service\n");
+	}
+
+	return 0;
+err_gpio:
+	mcu_gpiochip_remove(mcu);
+err_iic_read:
+	kfree(mcu);
+	return ret;
+}
+
+static int mcu_remove(struct i2c_client *client)
+{
+	struct mcu *mcu = i2c_get_clientdata(client);
+
+	if (glob_mcu == mcu) {
+		ppc_md.power_off = NULL;
+		glob_mcu = NULL;
+	}
+
+	i2c_set_clientdata(client, NULL);
+	mcu_gpiochip_remove(mcu);
+	kfree(mcu);
+	return 0;
+}
+
+static struct i2c_driver mcu_driver = {
+	.driver = {
+		.name = "mcu-mpc8349emitx",
+		.owner = THIS_MODULE,
+	},
+	.probe = mcu_probe,
+	.remove	= mcu_remove,
+};
+
+static int __init mcu_init(void)
+{
+	return i2c_add_driver(&mcu_driver);
+}
+module_init(mcu_init);
+
+static void __exit mcu_exit(void)
+{
+	i2c_del_driver(&mcu_driver);
+}
+module_exit(mcu_exit);
+
+MODULE_DESCRIPTION("MPC8349E-mITX/MPC837x-RDB Power Management and GPIO "
+		   "expander driver");
+MODULE_AUTHOR("Anton Vorontsov <avorontsov@ru.mvista.com>");
+MODULE_LICENSE("GPL");
-- 
1.5.2.2
