Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0D228DDDF9
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jan 2007 08:19:44 +1100 (EST)
Date: Sat, 6 Jan 2007 22:19:39 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] SMU LED driver
Message-ID: <20070106211939.GB29846@hansmi.ch>
References: <20061224112351.GA27260@hansmi.ch>
	<1167081952.3522.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
In-Reply-To: <1167081952.3522.0.camel@localhost.localdomain>
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


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2006 at 08:25:52AM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2006-12-24 at 12:23 +0100, Michael Hanselmann wrote:
> > This patch adds a driver for the front LED in recent PowerMacs which
> > have an SMU.

> As for the PMU driver, I'm pretty unhappy that it sycnhronously waits
> for the completion. The original code I wrote was fully asynchronous.

Unfortunately, I can't see another way than doing it synchronously when
one shouldn't use kmalloc(). The command (struct smu_simple_cmd) is kept
on the stack. It contains the buffer used for both sending and
retrieving data to/from the SMU. Making it module-global wouldn't work,
because one request could conflict with another. struct smu_cmd can't be
locked, so we can't check or wait for the status like via-pmu-led does.
So, what should I do?

On another note, it seems like the PMU LED driver is already
asynchronous.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---

diff -Nrup --exclude-from linux-exclude-from linux-2.6.19.1.orig/drivers/ma=
cintosh/Kconfig linux-2.6.19.1/drivers/macintosh/Kconfig
--- linux-2.6.19.1.orig/drivers/macintosh/Kconfig	2007-01-06 00:47:14.00000=
0000 +0100
+++ linux-2.6.19.1/drivers/macintosh/Kconfig	2007-01-06 01:06:59.000000000 =
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
--- linux-2.6.19.1.orig/drivers/macintosh/Makefile	2007-01-06 00:47:14.0000=
00000 +0100
+++ linux-2.6.19.1/drivers/macintosh/Makefile	2007-01-06 01:06:59.000000000=
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
+++ linux-2.6.19.1/drivers/macintosh/smu-led.c	2007-01-06 03:23:30.00000000=
0 +0100
@@ -0,0 +1,97 @@
+/*
+ * smu LED class device
+ *
+ * Copyright 2006 Michael Hanselmann <linux-kernel@hansmi.ch>
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
+#include <asm/smu.h>
+
+static void smu_led_set(struct led_classdev *led_cdev,
+		enum led_brightness brightness)
+{
+	DECLARE_COMPLETION_ONSTACK(comp);
+	struct smu_simple_cmd cmd;
+	unsigned int value;
+	int rc;
+
+	/* As of now, this driver can't reset the LED to its default half
+	 * bright status (LED_HALF) because we don't know for sure how to
+	 * switch back into that mode.
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
+		return;
+	}
+
+	rc =3D smu_queue_simple(&cmd, SMU_CMD_MISC_ee_COMMAND, 3,
+		smu_done_complete, &comp,
+		SMU_CMD_MISC_ee_LEDS_CTRL, 0x00, value);
+	if (rc) {
+		printk(KERN_ERR "smu-led: "
+			"Command queueing failed, error %d\n", rc);
+		return;
+	}
+
+	wait_for_completion(&comp);
+
+	if (cmd.cmd.status) {
+		printk(KERN_ERR "smu-led: SMU command failed\n");
+		return;
+	}
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
+	led_classdev_unregister(&smu_led);
+}
+
+module_init(smu_led_init);
+module_exit(smu_led_exit);
+
+MODULE_AUTHOR("Michael Hanselmann <linux-kernel@hansmi.ch>");
+MODULE_DESCRIPTION("Front LED support for SMU based PowerMacs");
+MODULE_LICENSE("GPL");

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFoBJr6J0saEpRu+oRAqByAJ9WD0Zs6U47FOld4b8A4G23fFZ+fgCfRjwy
rsKUsEVBF459mhwZzU06SkQ=
=YZ4D
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
