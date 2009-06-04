Return-Path: <byron.bbradley@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by ozlabs.org (Postfix) with ESMTP id 19273DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jun 2009 07:08:21 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id e21so413316fga.16
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Jun 2009 14:08:19 -0700 (PDT)
Date: Thu, 4 Jun 2009 22:00:29 +0100 (BST)
From: Byron Bradley <byron.bbradley@gmail.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH] [POWERPC] 83xx: Support the MCU on the Thecus N1200 board
Message-ID: <alpine.DEB.2.00.0906042159110.7053@gamma>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tim.ellis@mac.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Thecus N1200 has a board control PIC on the I2C bus. This controls
two of the LEDs, the buzzer and allows the board to poweroff.

Signed-off-by: Byron Bradley <byron.bbradley@gmail.com>
---
 arch/powerpc/configs/83xx/thecus_n1200_defconfig |    3 +-
 arch/powerpc/platforms/83xx/Makefile             |    1 +
 arch/powerpc/platforms/83xx/mcu_thecus_n1200.c   |  307 ++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig                   |    9 +
 4 files changed, 319 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/83xx/mcu_thecus_n1200.c

diff --git a/arch/powerpc/configs/83xx/thecus_n1200_defconfig b/arch/powerpc/configs/83xx/thecus_n1200_defconfig
index b0c3a15..a0731e6 100644
--- a/arch/powerpc/configs/83xx/thecus_n1200_defconfig
+++ b/arch/powerpc/configs/83xx/thecus_n1200_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.30-rc6
-# Fri May 22 18:36:51 2009
+# Fri May 22 19:01:15 2009
 #
 # CONFIG_PPC64 is not set
 
@@ -217,6 +217,7 @@ CONFIG_IPIC=y
 CONFIG_MPC8xxx_GPIO=y
 # CONFIG_SIMPLE_GPIO is not set
 # CONFIG_MCU_MPC8349EMITX is not set
+CONFIG_MCU_THECUS_N1200=m
 
 #
 # Kernel options
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index 2f2d522..682797c 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -15,4 +15,5 @@ obj-$(CONFIG_MPC837x_MDS)	+= mpc837x_mds.o
 obj-$(CONFIG_SBC834x)		+= sbc834x.o
 obj-$(CONFIG_MPC837x_RDB)	+= mpc837x_rdb.o
 obj-$(CONFIG_THECUS_N1200)	+= thecus_n1200.o
+obj-$(CONFIG_MCU_THECUS_N1200)	+= mcu_thecus_n1200.o
 obj-$(CONFIG_ASP834x)		+= asp834x.o
diff --git a/arch/powerpc/platforms/83xx/mcu_thecus_n1200.c b/arch/powerpc/platforms/83xx/mcu_thecus_n1200.c
new file mode 100644
index 0000000..03384ce
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/mcu_thecus_n1200.c
@@ -0,0 +1,307 @@
+/*
+ * Driver for the MCU on Thecus N1200 boards.
+ *
+ * Copyright (c) 2009 Byron Bradley
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * The Thecus N1200 boards have a board control PIC on the I2C bus. This
+ * provides control over two of the LEDs, buzzer and the power-off function.
+ * The behaviour of the power button changes depending on the power state so we
+ * tell the PIC we have booted when the module loads and tell it when we are
+ * rebooting.
+ */
+
+#include <asm/machdep.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+
+/* N1200 registers */
+#define N1200_REG_PWR_CTRL	0x0
+#define N1200_REG_LED_SATA	0x1
+#define N1200_REG_LED_SYSTEM	0x2
+#define N1200_REG_LED_BUSY	0x3
+#define N1200_REG_BUZZER	0x4
+#define N1200_REG_PWR_STATUS	0x5
+#define N1200_REG_VERSION	0x6
+
+/* for N1200_REG_PWR_CTRL */
+#define N1200_PWR_OFF		0x0
+#define N1200_PWR_RESET		0x1
+
+/* for N1200_REG_PWR_STATUS */
+#define N1200_PWR_OFF		0x0
+#define N1200_PWR_BOOTED	0x2
+
+/* for N1200_REG_LED_* */
+#define N1200_LED_OFF		0x0
+#define N1200_LED_ON		0x1
+#define N1200_LED_BLINK		0x2
+
+/* We need to store a pointer to the i2c_client for use during a poweroff */
+static struct i2c_client *n1200_i2c_client;
+
+struct mcu_n1200 {
+	struct led_classdev		sata_led;
+	struct led_classdev		system_led;
+	struct led_classdev		busy_led;
+	struct input_dev		*input_dev;
+};
+
+static inline int n1200_read(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static inline void n1200_write(struct i2c_client *client, u8 reg, u8 value)
+{
+	i2c_smbus_write_byte_data(client, reg, value);
+}
+
+void n1200_power_off(void)
+{
+	if (n1200_i2c_client == NULL)
+		return;
+
+	n1200_write(n1200_i2c_client, N1200_REG_PWR_CTRL, N1200_PWR_OFF);
+}
+
+static int n1200_reboot_notify(struct notifier_block *nb, unsigned long event,
+			       void *p)
+{
+	if (event != SYS_RESTART || n1200_i2c_client == NULL)
+		return NOTIFY_DONE;
+
+	n1200_write(n1200_i2c_client, N1200_REG_PWR_CTRL, N1200_PWR_RESET);
+
+	return NOTIFY_DONE;
+}
+
+struct notifier_block n1200_notifier = {
+	.notifier_call = n1200_reboot_notify,
+};
+
+#define N1200_NEW_LED(__name, __reg, __blinkable)			\
+static void n1200_##__name##_set(struct led_classdev *led_cdev,		\
+		enum led_brightness value)				\
+{									\
+	if (value == LED_OFF)						\
+		n1200_write(n1200_i2c_client, __reg, N1200_LED_OFF);	\
+	else								\
+		n1200_write(n1200_i2c_client, __reg, N1200_LED_ON);	\
+}									\
+static int n1200_##__name##_blink(struct led_classdev *led_cdev,	\
+		unsigned long *delay_on, unsigned long *delay_off)	\
+{									\
+	if (__blinkable == 1) {						\
+		n1200_write(n1200_i2c_client, __reg, N1200_LED_BLINK);	\
+		return 0;						\
+	} else								\
+		return -EINVAL;						\
+}
+
+N1200_NEW_LED(sata_red, N1200_REG_LED_SATA, 1);
+N1200_NEW_LED(system_red, N1200_REG_LED_SYSTEM, 1);
+N1200_NEW_LED(busy_orange, N1200_REG_LED_BUSY, 1);
+
+static int n1200_spkr_event(struct input_dev *dev, unsigned int type,
+			    unsigned int code, int value)
+{
+	if (type != EV_SND)
+		return -1;
+
+	switch (code) {
+	case SND_BELL:
+		if (value)
+			value = 1000;
+	case SND_TONE:
+		break;
+	default:
+		return -1;
+	}
+
+	if (value > 20 && value < 32767) {
+		n1200_write(n1200_i2c_client, N1200_REG_BUZZER, N1200_LED_ON);
+		msleep(value);
+		n1200_write(n1200_i2c_client, N1200_REG_BUZZER, N1200_LED_OFF);
+	} else {
+		n1200_write(n1200_i2c_client, N1200_REG_BUZZER, N1200_LED_OFF);
+	}
+
+	return 0;
+}
+
+static int n1200_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	int version, err = -ENOMEM;
+	struct mcu_n1200 *mcu;
+	struct i2c_adapter *adapter = client->adapter;
+	extern struct machdep_calls ppc_md;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EIO;
+
+	version = n1200_read(client, N1200_REG_VERSION);
+	if (version < 0)
+		return -ENODEV;
+
+	mcu = kzalloc(sizeof(struct mcu_n1200), GFP_KERNEL);
+	if (!mcu) {
+		dev_err(&client->dev, "failed to allocate driver data\n");
+		return -ENOMEM;
+	}
+	i2c_set_clientdata(client, mcu);
+
+	mcu->input_dev = input_allocate_device();
+	if (!mcu->input_dev)
+		goto err_alloc;
+
+	dev_info(&adapter->dev, "found mcu_thecus_n1200: v%d\n", version);
+
+	/* Store the client as a static, we'll need it for a poweroff */
+	n1200_i2c_client = client;
+
+	mcu->sata_led.name = "n1200:red:sata";
+	mcu->sata_led.brightness = LED_OFF;
+	mcu->sata_led.brightness_set = n1200_sata_red_set;
+	mcu->sata_led.blink_set = n1200_sata_red_blink;
+	err = led_classdev_register(&client->dev, &mcu->sata_led);
+	if (err < 0) {
+		dev_err(&client->dev, "Failed to register LED sata_red");
+		goto err_sata;
+	}
+
+	mcu->system_led.name = "n1200:red:status";
+	mcu->system_led.brightness = LED_OFF;
+	mcu->system_led.brightness_set = n1200_system_red_set;
+	mcu->system_led.blink_set = n1200_system_red_blink;
+	err = led_classdev_register(&client->dev, &mcu->system_led);
+	if (err < 0) {
+		dev_err(&client->dev, "Failed to register LED system_red");
+		goto err_system;
+	}
+
+	mcu->busy_led.name = "n1200:orange:status";
+	mcu->busy_led.brightness = LED_FULL;
+	mcu->busy_led.brightness_set = n1200_busy_orange_set;
+	mcu->busy_led.blink_set = n1200_busy_orange_blink;
+	err = led_classdev_register(&client->dev, &mcu->busy_led);
+	if (err < 0) {
+		dev_err(&client->dev, "Failed to register LED busy_orange");
+		goto err_busy;
+	}
+
+	input_set_drvdata(mcu->input_dev, (void *) mcu);
+	mcu->input_dev->name = "n1200 beeper",
+	mcu->input_dev->phys = "n1200/gpio";
+	mcu->input_dev->id.bustype = BUS_I2C;
+	mcu->input_dev->id.vendor  = 0x0001;
+	mcu->input_dev->id.product = 0x0001;
+	mcu->input_dev->id.version = 0x0100;
+	mcu->input_dev->dev.parent = &client->dev;
+
+	mcu->input_dev->evbit[0] = BIT_MASK(EV_SND);
+	mcu->input_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
+	mcu->input_dev->event = n1200_spkr_event;
+
+	err = input_register_device(mcu->input_dev);
+	if (err) {
+		dev_err(&client->dev, "Failed to register input device");
+		goto err_buzzer;
+	}
+
+	err = register_reboot_notifier(&n1200_notifier);
+	if (err != 0) {
+		dev_err(&client->dev, "Failed to register reboot notifier");
+		goto err_notifier;
+	}
+
+	n1200_write(client, N1200_REG_PWR_STATUS, N1200_PWR_BOOTED);
+
+	ppc_md.power_off = &n1200_power_off;
+
+	return 0;
+
+err_notifier:
+	input_unregister_device(mcu->input_dev);
+	mcu->input_dev = NULL;
+err_buzzer:
+	led_classdev_unregister(&mcu->busy_led);
+err_busy:
+	led_classdev_unregister(&mcu->system_led);
+err_system:
+	led_classdev_unregister(&mcu->sata_led);
+err_sata:
+	input_free_device(mcu->input_dev);
+err_alloc:
+	kfree(mcu);
+	return err;
+}
+
+static int n1200_remove(struct i2c_client *client)
+{
+	int err;
+	extern struct machdep_calls ppc_md;
+	struct mcu_n1200 *mcu = i2c_get_clientdata(client);
+
+	/* Tell the PIC we are going away, needed if we wanted to reload */
+	n1200_write(client, N1200_REG_PWR_STATUS, N1200_PWR_OFF);
+
+	err = unregister_reboot_notifier(&n1200_notifier);
+	ppc_md.power_off = NULL;
+
+	input_unregister_device(mcu->input_dev);
+	mcu->input_dev = NULL;
+
+	led_classdev_unregister(&mcu->sata_led);
+	led_classdev_unregister(&mcu->system_led);
+	led_classdev_unregister(&mcu->busy_led);
+
+	i2c_set_clientdata(client, NULL);
+	kfree(mcu);
+	n1200_i2c_client = NULL;
+
+	return err;
+}
+
+static const struct i2c_device_id n1200_id[] = {
+	{ "mcu_thecus_n1200", 0 },
+	{ }
+};
+
+static struct i2c_driver n1200_driver = {
+	.driver = {
+		.name   = "mcu_thecus_n1200",
+	},
+	.probe          = n1200_probe,
+	.remove         = n1200_remove,
+	.id_table       = n1200_id,
+};
+
+static int __init n1200_init(void)
+{
+	return i2c_add_driver(&n1200_driver);
+}
+
+static void __exit n1200_exit(void)
+{
+	i2c_del_driver(&n1200_driver);
+}
+
+MODULE_AUTHOR("Byron Bradley <byron.bbradley@gmail.com>");
+MODULE_DESCRIPTION("Thecus N1200 Board Controller");
+MODULE_LICENSE("GPL");
+
+module_init(n1200_init);
+module_exit(n1200_exit);
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index e3e8707..699ee83 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -329,4 +329,13 @@ config MCU_MPC8349EMITX
 	  also register MCU GPIOs with the generic GPIO API, so you'll able
 	  to use MCU pins as GPIOs.
 
+config MCU_THECUS_N1200
+	tristate "Thecus N1200 MCU driver"
+	depends on I2C && THECUS_N1200
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say Y here to enable power-off functionality on Thecus N1200 board.
+	  Also provides control over some of the LEDs and the buzzer.
+
 endmenu
-- 
1.6.3
