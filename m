Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 60244DE399
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 04:03:58 +1000 (EST)
Date: Fri, 19 Sep 2008 22:03:54 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jean Delvare <khali@linux-fr.org>,
	Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 2/2] i2c: MPC8349E-mITX Power Management and GPIO expander
	driver
Message-ID: <20080919180354.GB13899@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On MPC8349E-mITX, MPC8315E-RDB and MPC837x-RDB boards there is a
Freescale MC9S08QG8 (MCU) chip with the custom firmware
pre-programmed. The chip is used to power-off the board by the
software, and to control some GPIO pins.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/i2c/chips/Kconfig            |   11 ++
 drivers/i2c/chips/Makefile           |    1 +
 drivers/i2c/chips/mcu_mpc8349emitx.c |  213 ++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/chips/mcu_mpc8349emitx.c

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index a95cb94..1735682 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -172,4 +172,15 @@ config MENELAUS
 	  and other features that are often used in portable devices like
 	  cell phones and PDAs.
 
+config MCU_MPC8349EMITX
+	tristate "MPC8349E-mITX MCU driver"
+	depends on I2C && PPC_83xx
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say Y here to enable soft power-off functionality on the Freescale
+	  boards with the MPC8349E-mITX-compatible MCU chips. This driver will
+	  also register MCU GPIOs with the generic GPIO API, so you'll able
+	  to use MCU pins as GPIOs.
+
 endmenu
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 39e3e69..ca520fa 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
+obj-$(CONFIG_MCU_MPC8349EMITX)	+= mcu_mpc8349emitx.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/i2c/chips/mcu_mpc8349emitx.c b/drivers/i2c/chips/mcu_mpc8349emitx.c
new file mode 100644
index 0000000..47b07b8
--- /dev/null
+++ b/drivers/i2c/chips/mcu_mpc8349emitx.c
@@ -0,0 +1,213 @@
+/*
+ * Power Management and GPIO expander driver for MPC8349E-mITX-compatible MCU
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
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+
+/*
+ * I don't have specifications for the MCU firmware, I found this register
+ * and bits positions by the trial&error method.
+ */
+#define MCU_REG_CTRL	0x20
+#define MCU_CTRL_POFF	0x40
+
+#define MCU_NUM_GPIO	2
+
+struct mcu {
+	struct mutex lock;
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
+	mutex_lock(&mcu->lock);
+	i2c_smbus_write_byte_data(glob_mcu->client, MCU_REG_CTRL,
+				  mcu->reg_ctrl | MCU_CTRL_POFF);
+	mutex_unlock(&mcu->lock);
+}
+
+static void mcu_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_gpio_chip *of_gc = to_of_gpio_chip(gc);
+	struct mcu *mcu = container_of(of_gc, struct mcu, of_gc);
+	u8 bit = 1 << (4 + gpio);
+
+	mutex_lock(&mcu->lock);
+	if (val)
+		mcu->reg_ctrl &= ~bit;
+	else
+		mcu->reg_ctrl |= bit;
+
+	i2c_smbus_write_byte_data(mcu->client, MCU_REG_CTRL, mcu->reg_ctrl);
+	mutex_unlock(&mcu->lock);
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
+	int ret;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mcu-mpc8349emitx");
+	if (!np)
+		return -ENODEV;
+
+	gc->owner = THIS_MODULE;
+	gc->label = np->full_name;
+	gc->can_sleep = 1;
+	gc->ngpio = MCU_NUM_GPIO;
+	gc->base = -1;
+	gc->set = mcu_gpio_set;
+	gc->direction_output = mcu_gpio_dir_out;
+	of_gc->gpio_cells = 2;
+	of_gc->xlate = of_gpio_simple_xlate;
+
+	np->data = of_gc;
+	mcu->np = np;
+
+	/*
+	 * We don't want to lose the node, its ->data and ->full_name...
+	 * So, if succeeded, we don't put the node here.
+	 */
+	ret = gpiochip_add(gc);
+	if (ret)
+		of_node_put(np);
+	return ret;
+}
+
+static int mcu_gpiochip_remove(struct mcu *mcu)
+{
+	int ret;
+
+	ret = gpiochip_remove(&mcu->of_gc.gc);
+	if (ret)
+		return ret;
+	of_node_put(mcu->np);
+
+	return 0;
+}
+
+static int __devinit mcu_probe(struct i2c_client *client,
+			       const struct i2c_device_id *id)
+{
+	struct mcu *mcu;
+	int ret;
+
+	mcu = kzalloc(sizeof(*mcu), GFP_KERNEL);
+	if (!mcu)
+		return -ENOMEM;
+
+	mutex_init(&mcu->lock);
+	mcu->client = client;
+	i2c_set_clientdata(client, mcu);
+
+	ret = i2c_smbus_read_byte_data(mcu->client, MCU_REG_CTRL);
+	if (ret < 0)
+		goto err;
+	mcu->reg_ctrl = ret;
+
+	ret = mcu_gpiochip_add(mcu);
+	if (ret)
+		goto err;
+
+	/* XXX: this is potentially racy, but there is no lock for ppc_md */
+	if (!ppc_md.power_off) {
+		glob_mcu = mcu;
+		ppc_md.power_off = mcu_power_off;
+		dev_info(&client->dev, "will provide power-off service\n");
+	}
+
+	return 0;
+err:
+	kfree(mcu);
+	return ret;
+}
+
+static int __devexit mcu_remove(struct i2c_client *client)
+{
+	struct mcu *mcu = i2c_get_clientdata(client);
+	int ret;
+
+	if (glob_mcu == mcu) {
+		ppc_md.power_off = NULL;
+		glob_mcu = NULL;
+	}
+
+	ret = mcu_gpiochip_remove(mcu);
+	if (ret)
+		return ret;
+	i2c_set_clientdata(client, NULL);
+	kfree(mcu);
+	return 0;
+}
+
+static const struct i2c_device_id mcu_ids[] = {
+	{ "mc9s08qg8-mpc8349emitx", },
+	{ "mc9s08qg8-mpc8377rdb", },
+	{ "mc9s08qg8-mpc8378rdb", },
+	{ "mc9s08qg8-mpc8379rdb", },
+	{ "mc9s08qg8-mpc8315rdb", },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, mcu_ids);
+
+static struct i2c_driver mcu_driver = {
+	.driver = {
+		.name = "mcu-mpc8349emitx",
+		.owner = THIS_MODULE,
+	},
+	.probe = mcu_probe,
+	.remove	= __devexit_p(mcu_remove),
+	.id_table = mcu_ids,
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
+MODULE_DESCRIPTION("Power Management and GPIO expander driver for "
+		   "MPC8349E-mITX-compatible MCU");
+MODULE_AUTHOR("Anton Vorontsov <avorontsov@ru.mvista.com>");
+MODULE_LICENSE("GPL");
-- 
1.5.6.3
