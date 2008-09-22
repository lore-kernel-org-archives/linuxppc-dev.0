Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 7831ADDEE4
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 05:44:02 +1000 (EST)
Received: from octopus.labnet.pengutronix.de ([10.1.1.3])
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <wsa@pengutronix.de>) id 1KhrK9-0002zP-OA
	for linuxppc-dev@ozlabs.org; Mon, 22 Sep 2008 21:43:57 +0200
Received: from wsa by octopus.labnet.pengutronix.de with local (Exim 4.69)
	(envelope-from <wsa@pengutronix.de>) id 1KhrK9-0008Mo-DL
	for linuxppc-dev@ozlabs.org; Mon, 22 Sep 2008 21:43:57 +0200
Date: Mon, 22 Sep 2008 21:43:57 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] GPIO-Watchdog in devicetree
Message-ID: <20080922194357.GA32041@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

I understood that the device-tree is for describing hardware and should
not contain driver specific information. I have problems drawing this
line right now. I made a driver for watchdogs which are pinged by
toggling a gpio. Currently the device-tree entry looks like this:

	watchdog@gpio {
		compatible =3D "gpio-watchdog";
		gpios =3D	<&gpio_simple 19 0>;
	};

Then, there are two module parameters. One to define the initial state of
the gpio (0 or 1), one to define the length of the pulse when serving
the watchdog (default 1 us). Now my question is:

Is it plausible to say that the module parameters would also fit to the
device-tree as properties? Recently, I tend to say so as otherwise the
description of the watchdog is incomplete. Then again, one might argue
to develop a specific watchdog driver instead of a generic one, and use
something like compatible =3D "<myvendor>, <mywatchdog>" which would
result in lots of duplicated code per watchdog. So, which way to go? I
am really undecided and would be happy to hear opinions.

For completeness, I'll append the current version of my driver.

All the best,

   Wolfram

=3D=3D=3D

=46rom; Wolfram Sang <w.sang@pengutronix.de>
Subject; of-driver for external gpio-triggered watchdogs

Still needs tests and review before it can go mainline.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/watchdog/Kconfig       |    8 +
 drivers/watchdog/Makefile      |    1=20
 drivers/watchdog/of_gpio_wdt.c |  188 ++++++++++++++++++++++++++++++++++++=
+++++
 3 files changed, 197 insertions(+)

Index: drivers/watchdog/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/watchdog/Kconfig.orig
+++ drivers/watchdog/Kconfig
@@ -55,6 +55,14 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called softdog.
=20
+config OF_GPIO_WDT
+	tristate "OF GPIO watchdog"
+	help
+	  This driver handles external watchdogs which are triggered by a gpio.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called of_gpio_wdt.
+
 # ALPHA Architecture
=20
 # ARM Architecture
Index: drivers/watchdog/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/watchdog/Makefile.orig
+++ drivers/watchdog/Makefile
@@ -124,4 +124,5 @@
 # XTENSA Architecture
=20
 # Architecture Independant
+obj-$(CONFIG_OF_GPIO_WDT) +=3D of_gpio_wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) +=3D softdog.o
Index: drivers/watchdog/of_gpio_wdt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ drivers/watchdog/of_gpio_wdt.c
@@ -0,0 +1,188 @@
+/*
+ * of_gpio_wdt.c - driver for gpio-driven watchdogs
+ *
+ * Copyright (C) 2008 Pengutronix e.K.
+ *
+ * Author: Wolfram Sang <w.sang@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of  the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+
+#define DRIVER_NAME "of-gpio-wdt"
+
+
+static int wdt_gpio;
+
+static int wdt_init_state;
+module_param(wdt_init_state, bool, 0);
+MODULE_PARM_DESC(wdt_init_state,
+	"Initial state of the gpio pin (0/1), default =3D 0");
+
+static int wdt_toggle_delay =3D 1;
+module_param(wdt_toggle_delay, int, 0);
+MODULE_PARM_DESC(wdt_toggle_delay,
+	"Delay in us to keep the gpio triggered, default =3D 1");
+
+static void of_gpio_wdt_ping(void)
+{
+	gpio_set_value(wdt_gpio, wdt_init_state ^ 1);
+	udelay(wdt_toggle_delay);
+	gpio_set_value(wdt_gpio, wdt_init_state);
+}
+
+static ssize_t of_gpio_wdt_write(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	if (count)
+		of_gpio_wdt_ping();
+	return count;
+}
+
+static int of_gpio_wdt_open(struct inode *inode, struct file *file)
+{
+	of_gpio_wdt_ping();
+	return nonseekable_open(inode, file);
+}
+
+static int of_gpio_wdt_release(struct inode *inode, struct file *file)
+{
+	printk(KERN_CRIT "Unexpected close on watchdog device. "
+			 "File is closed, but watchdog is still running!\n");
+	return 0;
+}
+
+static int of_gpio_wdt_ioctl(struct inode *inode, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	void __user *argp =3D (void __user *)arg;
+	static struct watchdog_info ident =3D {
+		.options =3D WDIOF_KEEPALIVEPING,
+		.firmware_version =3D 0,
+		.identity =3D DRIVER_NAME,
+	};
+
+	switch (cmd) {
+
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user(argp, &ident, sizeof(ident)))
+			return -EFAULT;
+		break;
+
+	case WDIOC_KEEPALIVE:
+		of_gpio_wdt_ping();
+		break;
+
+	case WDIOC_GETTEMP:
+	case WDIOC_GETTIMEOUT:
+	case WDIOC_SETOPTIONS:
+	case WDIOC_SETTIMEOUT:
+		return -EOPNOTSUPP;
+
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+static const struct file_operations of_gpio_wdt_fops =3D {
+	.owner		=3D THIS_MODULE,
+	.llseek		=3D no_llseek,
+	.write		=3D of_gpio_wdt_write,
+	.ioctl		=3D of_gpio_wdt_ioctl,
+	.open		=3D of_gpio_wdt_open,
+	.release	=3D of_gpio_wdt_release,
+};
+
+static struct miscdevice of_gpio_wdt_miscdev =3D {
+	.minor	=3D WATCHDOG_MINOR,
+	.name	=3D "watchdog",
+	.fops	=3D &of_gpio_wdt_fops,
+};
+
+static int __devinit of_gpio_wdt_probe(struct of_device *op,
+			const struct of_device_id *match)
+{
+	int ret;
+
+	wdt_gpio =3D of_get_gpio(op->node, 0);
+	if (wdt_gpio < 0) {
+		dev_err(&op->dev, "could not determine gpio! (err=3D%d)\n",
+			wdt_gpio);
+		return wdt_gpio;
+	}
+
+	ret =3D gpio_request(wdt_gpio, DRIVER_NAME);
+	if (ret) {
+		dev_err(&op->dev, "could not get gpio! (err=3D%d)\n", ret);
+		return ret;
+	}
+
+	gpio_direction_output(wdt_gpio, wdt_init_state);
+
+	ret =3D misc_register(&of_gpio_wdt_miscdev);
+	if (ret) {
+		dev_err(&op->dev, "cannot register miscdev on minor=3D%d "
+				"(err=3D%d)\n", WATCHDOG_MINOR, ret);
+		gpio_free(wdt_gpio);
+		return -ENODEV;
+	}
+
+	dev_info(&op->dev, "gpio-watchdog driver started using gpio %d.\n",
+		wdt_gpio);
+	return 0;
+}
+
+static int __devexit of_gpio_wdt_remove(struct of_device *op)
+{
+	misc_deregister(&of_gpio_wdt_miscdev);
+	gpio_free(wdt_gpio);
+	return 0;
+}
+
+static struct of_device_id of_gpio_wdt_match[] =3D {
+	{ .compatible =3D "gpio-watchdog", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_gpio_wdt_match);
+
+static struct of_platform_driver of_gpio_wdt_driver =3D {
+	.owner =3D THIS_MODULE,
+	.name =3D DRIVER_NAME,
+	.match_table =3D of_gpio_wdt_match,
+	.probe =3D of_gpio_wdt_probe,
+	.remove =3D __devexit_p(of_gpio_wdt_remove),
+};
+
+static int __init of_gpio_wdt_init(void)
+{
+	return of_register_platform_driver(&of_gpio_wdt_driver);
+}
+
+static void __exit of_gpio_wdt_exit(void)
+{
+	of_unregister_platform_driver(&of_gpio_wdt_driver);
+}
+
+module_init(of_gpio_wdt_init);
+module_exit(of_gpio_wdt_exit);
+
+MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_DESCRIPTION("Driver for gpio-triggered watchdogs");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjX9X0ACgkQD27XaX1/VRvlhACfYEvsbTCwQRKSzK3PZmDYoTvp
HIIAoIDPoKJNjfApGmoFfDQ3Ix9M9Yow
=wgpH
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
