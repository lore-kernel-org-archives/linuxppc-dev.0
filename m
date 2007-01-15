Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 171F1DDE2B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 11:26:21 +1100 (EST)
Date: Mon, 15 Jan 2007 01:26:17 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] SMU LED driver
Message-ID: <20070115002617.GA29698@hansmi.ch>
References: <20061224112351.GA27260@hansmi.ch>
	<1167081952.3522.0.camel@localhost.localdomain>
	<20070106211939.GB29846@hansmi.ch>
	<1168218165.22458.100.camel@localhost.localdomain>
	<20070114133119.GA22354@hansmi.ch>
	<1168811339.4803.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
In-Reply-To: <1168811339.4803.23.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2007 at 08:48:59AM +1100, Benjamin Herrenschmidt wrote:
> No, you have to deal with it in the unload. You can for example wait for
> the SMU request to complete after setting wanted to -1, that sort of
> thing.

Done in the patch below.

> Also, use spin_lock_irqsave/restore or you'll deadlock if the SMU
> completion interrupt happens to interrupt your request function.

Okay, didn't notice the done function is called in interrupt context.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.19.1.orig/drivers/ma=
cintosh/Kconfig linux-2.6.19.1/drivers/macintosh/Kconfig
--- linux-2.6.19.1.orig/drivers/macintosh/Kconfig	2007-01-14 12:58:25.00000=
0000 +0100
+++ linux-2.6.19.1/drivers/macintosh/Kconfig	2007-01-15 00:57:16.000000000 =
+0100
@@ -107,6 +107,15 @@ config PMAC_SMU
 	  on the "SMU" system control chip which replaces the old PMU.
 	  If you don't know, say Y.
=20
+config PMAC_SMU_LED
+	tristate "Support for the PowerMac front LED"
+	depends on PMAC_SMU
+	select NEW_LEDS
+	select LEDS_CLASS
+	help
+	  Support the front LED on PowerMacs as a generic LED that can be
+	  triggered by any of the supported triggers.
+
 config PMAC_APM_EMU
 	tristate "APM emulation"
 	depends on PPC_PMAC && PPC32 && PM && ADB_PMU
diff -Nrup --exclude-from linux-exclude-from linux-2.6.19.1.orig/drivers/ma=
cintosh/Makefile linux-2.6.19.1/drivers/macintosh/Makefile
--- linux-2.6.19.1.orig/drivers/macintosh/Makefile	2007-01-14 12:58:25.0000=
00000 +0100
+++ linux-2.6.19.1/drivers/macintosh/Makefile	2007-01-15 00:57:16.000000000=
 +0100
@@ -17,6 +17,7 @@ obj-$(CONFIG_PMAC_BACKLIGHT)	+=3D via-pmu-
 obj-$(CONFIG_ADB_CUDA)		+=3D via-cuda.o
 obj-$(CONFIG_PMAC_APM_EMU)	+=3D apm_emu.o
 obj-$(CONFIG_PMAC_SMU)		+=3D smu.o
+obj-$(CONFIG_PMAC_SMU_LED)	+=3D smu-led.o
=20
 obj-$(CONFIG_ADB)		+=3D adb.o
 obj-$(CONFIG_ADB_MACII)		+=3D via-macii.o
diff -Nrup --exclude-from linux-exclude-from linux-2.6.19.1.orig/drivers/ma=
cintosh/smu-led.c linux-2.6.19.1/drivers/macintosh/smu-led.c
--- linux-2.6.19.1.orig/drivers/macintosh/smu-led.c	1970-01-01 01:00:00.000=
000000 +0100
+++ linux-2.6.19.1/drivers/macintosh/smu-led.c	2007-01-15 01:19:11.00000000=
0 +0100
@@ -0,0 +1,147 @@
+/*
+ * smu LED class device
+ *
+ * Copyright 2006, 2007 Michael Hanselmann <linux-kernel@hansmi.ch>
+ *
+ * This code is based upon via-pmu-led, written by Johannes Berg, and a sa=
mple
+ * program written by Benjamin Herrenschmidt.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 U=
SA
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/leds.h>
+#include <linux/spinlock.h>
+#include <asm/smu.h>
+
+static DEFINE_SPINLOCK(lock);
+static struct smu_simple_cmd cmd;
+static unsigned char cmd_value;
+static int wanted =3D -1;
+
+static void __smu_led_set(struct led_classdev*, unsigned char);
+
+static void smu_led_done(struct smu_cmd *cmd, void *misc)
+{
+	struct led_classdev *led_cdev =3D misc;
+	unsigned long flags;
+
+	if (cmd->status) {
+		printk(KERN_ERR "smu-led: SMU command failed\n");
+	}
+
+	spin_lock_irqsave(&lock, flags);
+
+	if (wanted !=3D -1) {
+		if (cmd_value =3D=3D wanted)
+			wanted =3D -1;
+		else
+			__smu_led_set(led_cdev, wanted);
+	}
+
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+/* Call with lock held */
+static void __smu_led_set(struct led_classdev *led_cdev,
+		unsigned char value)
+{
+	int rc;
+
+	cmd_value =3D value;
+	rc =3D smu_queue_simple(&cmd, SMU_CMD_MISC_ee_COMMAND, 3,
+		smu_led_done, led_cdev,
+		SMU_CMD_MISC_ee_LEDS_CTRL, 0x00, value);
+	if (rc) {
+		printk(KERN_ERR "smu-led: "
+			"Command queueing failed, error %d\n", rc);
+	}
+}
+
+static void smu_led_set(struct led_classdev *led_cdev,
+		enum led_brightness brightness)
+{
+	unsigned long flags;
+	unsigned char value;
+
+	/* Setting the LED to its default half bright status isn't possible
+	 * yet. Reason is that we don't know for sure how to do it.
+	 */
+
+	switch (brightness) {
+	case LED_OFF:
+		value =3D 0x00;
+		break;
+
+	case LED_FULL:
+		value =3D 0x01;
+		break;
+
+	default:
+		/* Unknown brightness, do nothing */
+		return;
+	}
+
+	spin_lock_irqsave(&lock, flags);
+
+	if (wanted =3D=3D -1) {
+		wanted =3D value;
+		__smu_led_set(led_cdev, value);
+	} else
+		wanted =3D value;
+
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+static struct led_classdev smu_led =3D {
+	.name =3D "smu-front-led",
+	.brightness_set =3D smu_led_set,
+};
+
+static int __init smu_led_init(void)
+{
+	if (!smu_present())
+		return -ENODEV;
+
+	return led_classdev_register(NULL, &smu_led);
+}
+
+static void __exit smu_led_exit(void)
+{
+	unsigned long flags;
+
+	led_classdev_unregister(&smu_led);
+
+	spin_lock_irqsave(&lock, flags);
+	while (wanted !=3D -1) {
+		spin_unlock_irqrestore(&lock, flags);
+
+		/* Wait for pending request */
+		smu_spinwait_cmd(&cmd.cmd);
+
+		spin_lock_irqsave(&lock, flags);
+	}
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+module_init(smu_led_init);
+module_exit(smu_led_exit);
+
+MODULE_AUTHOR("Michael Hanselmann <linux-kernel@hansmi.ch>");
+MODULE_DESCRIPTION("Front LED support for SMU based PowerMacs");
+MODULE_LICENSE("GPL");

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFqsop6J0saEpRu+oRApAeAJ9L1RY/ULUoovMkYNb7gQmeHIfJLgCgiErm
LO2cJwE8UOAqlPHt8T3hem8=
=oZBH
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
