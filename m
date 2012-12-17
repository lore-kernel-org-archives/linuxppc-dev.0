Return-Path: <ben.c@servergy.com>
Received: from exprod6og105.obsmtp.com (exprod6og105.obsmtp.com [64.18.1.189])
 by ozlabs.org (Postfix) with SMTP id 219CD2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 01:27:04 +1100 (EST)
Received: by mail-pb0-f71.google.com with SMTP id wz17so5908654pbc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2012 06:27:03 -0800 (PST)
From: Ben Collins <ben.c@servergy.com>
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] PPC: Add support for CTS-1000 GPIO controlled system poweroff
Date: Mon, 17 Dec 2012 09:19:28 -0500
Message-Id: <64615521-7AF9-4431-83FA-9ACBBDC8CB98@servergy.com>
To: linuxppc-dev@lists.ozlabs.org
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Cc: Vihar Rai <vihar@servergy.com>, Jack Smith <jack@servergy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CTS-1000 is based on P4080. GPIO 27 is used to signal the FPGA to
switch off power, and also associates IRQ 8 with front-panel button
press (which we use to call orderly_poweroff()).

The relevant device-tree looks like this:

	gpio0: gpio@130000 {
		compatible =3D "fsl,qoriq-gpio";
		reg =3D <0x130000 0x1000>;
		interrupts =3D <55 2 0 0>;
		#gpio-cells =3D <2>;
		gpio-controller;

		/* Allows powering off the system via GPIO signal. */
		gpio-halt@27 {
			compatible =3D "sgy,gpio-halt";
			gpios =3D <&gpio0 27 0>;
			interrupts =3D <8 1 0 0>;
		};
	};

Because the driver cannot match on sgy,gpio-halt (because the node is =
never
processed through of_platform), it matches on fsl,qoriq-gpio and then
checks child nodes for the matching sgy,gpio-halt. This also ensures =
that
the GPIO controller is detected prior to sgy_cts1000's probe callback,
since that node wont match via of_platform until the controller is
registered.

Also, because the GPIO handler for triggering system poweroff might =
sleep,
the IRQ uses a workqueue to call orderly_poweroff().

As a final note, this driver may be expanded for other features specific =
to
the CTS-1000.

Signed-off-by: Ben Collins <ben.c@servergy.com>
Cc: Jack Smith <jack.s@servergy.com>
Cc: Vihar Rai <vihar.r@servergy.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/Kconfig       |    8 ++
 arch/powerpc/platforms/85xx/Makefile      |    1 +
 arch/powerpc/platforms/85xx/sgy_cts1000.c |  176 =
+++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 arch/powerpc/platforms/85xx/sgy_cts1000.c

diff --git a/arch/powerpc/platforms/85xx/Kconfig =
b/arch/powerpc/platforms/85xx/Kconfig
index 02d02a0..651788c 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -245,6 +245,14 @@ config P4080_DS
 	help
 	  This option enables support for the P4080 DS board
=20
+config SGY_CTS1000
+	tristate "Servergy CTS-1000 support"
+	select GPIOLIB
+	select OF_GPIO
+	depends on P4080_DS
+	help
+	  Enable this to support functionality in Servergy's CTS-1000 =
systems.
+
 endif # PPC32
=20
 config P5020_DS
diff --git a/arch/powerpc/platforms/85xx/Makefile =
b/arch/powerpc/platforms/85xx/Makefile
index 76f679c..9db31dc 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_KSI8560)	  +=3D ksi8560.o
 obj-$(CONFIG_XES_MPC85xx) +=3D xes_mpc85xx.o
 obj-$(CONFIG_GE_IMP3A)	  +=3D ge_imp3a.o
 obj-$(CONFIG_PPC_QEMU_E500) +=3D qemu_e500.o
+obj-$(CONFIG_SGY_CTS1000) +=3D sgy_cts1000.o
diff --git a/arch/powerpc/platforms/85xx/sgy_cts1000.c =
b/arch/powerpc/platforms/85xx/sgy_cts1000.c
new file mode 100644
index 0000000..611e92f
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/sgy_cts1000.c
@@ -0,0 +1,176 @@
+/*
+ * Servergy CTS-1000 Setup
+ *
+ * Maintained by Ben Collins <ben.c@servergy.com>
+ *
+ * Copyright 2012 by Servergy, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or =
modify it
+ * under  the terms of  the GNU General  Public License as published by =
the
+ * Free Software Foundation;  either version 2 of the  License, or (at =
your
+ * option) any later version.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/of_gpio.h>
+#include <linux/workqueue.h>
+#include <linux/reboot.h>
+#include <linux/interrupt.h>
+
+#include <asm/machdep.h>
+
+static struct device_node *halt_node;
+
+static struct of_device_id child_match[] =3D {
+	{
+		.compatible =3D "sgy,gpio-halt",
+	},
+	{},
+};
+
+static void gpio_halt_wfn(struct work_struct *work)
+{
+	/* Likely wont return */
+	orderly_poweroff(true);
+}
+static DECLARE_WORK(gpio_halt_wq, gpio_halt_wfn);
+
+static void gpio_halt_cb(void)
+{
+	enum of_gpio_flags flags;
+	int trigger, gpio;
+
+	if (!halt_node)
+		return;
+
+	gpio =3D of_get_gpio_flags(halt_node, 0, &flags);
+
+	if (!gpio_is_valid(gpio))
+		return;
+
+	trigger =3D (flags =3D=3D OF_GPIO_ACTIVE_LOW);
+
+	printk(KERN_INFO "gpio-halt: triggering GPIO.\n");
+
+	/* Probably wont return */
+	gpio_set_value(gpio, trigger);
+}
+
+/* This IRQ means someone pressed the power button and it is waiting =
for us
+ * to handle the shutdown/poweroff. */
+static irqreturn_t gpio_halt_irq(int irq, void *__data)
+{
+	printk(KERN_INFO "gpio-halt: shutdown due to power button =
IRQ.\n");
+	schedule_work(&gpio_halt_wq);
+
+        return IRQ_HANDLED;
+};
+
+static int __devinit gpio_halt_probe(struct platform_device *pdev)
+{
+	enum of_gpio_flags flags;
+	struct device_node *node =3D pdev->dev.of_node;
+	int gpio, err, irq;
+	int trigger;
+
+	if (!node)
+		return -ENODEV;
+
+	/* If there's no matching child, this isn't really an error */
+	halt_node =3D of_find_matching_node(node, child_match);
+	if (!halt_node)
+		return 0;
+
+	/* Technically we could just read the first one, but punish
+	 * DT writers for invalid form. */
+	if (of_gpio_count(halt_node) !=3D 1)
+		return -EINVAL;
+
+	/* Get the gpio number relative to the dynamic base. */
+	gpio =3D of_get_gpio_flags(halt_node, 0, &flags);
+	if (!gpio_is_valid(gpio))
+		return -EINVAL;
+
+	err =3D gpio_request(gpio, "gpio-halt");
+	if (err) {
+		printk(KERN_ERR "gpio-halt: error requesting GPIO =
%d.\n",
+		       gpio);
+		halt_node =3D NULL;
+		return err;
+	}
+
+	trigger =3D (flags =3D=3D OF_GPIO_ACTIVE_LOW);
+
+	gpio_direction_output(gpio, !trigger);
+
+	/* Now get the IRQ which tells us when the power button is hit =
*/
+	irq =3D irq_of_parse_and_map(halt_node, 0);
+	err =3D request_irq(irq, gpio_halt_irq, IRQF_TRIGGER_RISING |
+			  IRQF_TRIGGER_FALLING, "gpio-halt", halt_node);
+	if (err) {
+		printk(KERN_ERR "gpio-halt: error requesting IRQ %d for =
"
+		       "GPIO %d.\n", irq, gpio);
+		gpio_free(gpio);
+		halt_node =3D NULL;
+		return err;
+	}
+
+	/* Register our halt function */
+	ppc_md.halt =3D gpio_halt_cb;
+	ppc_md.power_off =3D gpio_halt_cb;
+
+	printk(KERN_INFO "gpio-halt: registered GPIO %d (%d trigger, %d"
+	       " irq).\n", gpio, trigger, irq);
+
+	return 0;
+}
+
+static int __devexit gpio_halt_remove(struct platform_device *pdev)
+{
+	if (halt_node) {
+		int gpio =3D of_get_gpio(halt_node, 0);
+		int irq =3D irq_of_parse_and_map(halt_node, 0);
+
+		free_irq(irq, halt_node);
+
+		ppc_md.halt =3D NULL;
+		ppc_md.power_off =3D NULL;
+
+		gpio_free(gpio);
+
+		halt_node =3D NULL;
+	}
+
+	return 0;
+}
+
+static struct of_device_id gpio_halt_match[] =3D {
+	/* We match on the gpio bus itself and scan the children since =
they
+	 * wont be matched against us. We know the bus wont match until =
it
+	 * has been registered too. */
+	{
+		.compatible =3D "fsl,qoriq-gpio",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, gpio_halt_match);
+
+static struct platform_driver gpio_halt_driver =3D {
+	.driver =3D {
+		.name		=3D "gpio-halt",
+		.owner		=3D THIS_MODULE,
+		.of_match_table =3D gpio_halt_match,
+	},
+	.probe		=3D gpio_halt_probe,
+	.remove		=3D __devexit_p(gpio_halt_remove),
+};
+
+module_platform_driver(gpio_halt_driver);
+
+MODULE_DESCRIPTION("Driver to support GPIO triggered system halt for =
Servergy CTS-1000 Systems.");
+MODULE_VERSION("1.0");
+MODULE_AUTHOR("Ben Collins <ben.c@servergy.com>");
+MODULE_LICENSE("GPL");
--=20
1.7.10.4
