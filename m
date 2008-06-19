Return-Path: <krafft@de.ibm.com>
Date: Thu, 19 Jun 2008 19:35:34 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: cbe-oss-dev@ozlabs.org
Subject: cell: add support for power button of future IBM cell blades
Message-ID: <20080619193534.54850b36@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5ADivlJOFslAi113E5=WJcd";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_/5ADivlJOFslAi113E5=WJcd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This patch adds support for the power button on future IBM cell blades.
It actually doesn't shut down the machine. Instead it exposes an
input device /dev/input/event0 to userspace which sends KEY_POWER
if power button has been pressed.
haldaemon actually recognizes the button, so a plattform independent acpid
replacement should handle it correctly.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux.git/arch/powerpc/platforms/cell/pervasive.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.git.orig/arch/powerpc/platforms/cell/pervasive.c
+++ linux.git/arch/powerpc/platforms/cell/pervasive.c
@@ -24,8 +24,10 @@
 #undef DEBUG
=20
 #include <linux/interrupt.h>
+#include <linux/input.h>
 #include <linux/irq.h>
 #include <linux/percpu.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/kallsyms.h>
=20
@@ -40,6 +42,9 @@
=20
 static int sysreset_hack;
=20
+static struct input_dev *button_dev;
+static struct platform_device *button_pdev;
+
 static void cbe_power_save(void)
 {
 	unsigned long ctrl, thread_switch_control;
@@ -105,10 +110,21 @@ static int cbe_system_reset_exception(st
 		 */
 		if (sysreset_hack && (cpu =3D smp_processor_id()) =3D=3D 0) {
 			pmd =3D cbe_get_cpu_pmd_regs(cpu);
-			if (in_be64(&pmd->ras_esc_0) & 0xffff) {
+			if (in_be64(&pmd->ras_esc_0) & 0x0000ffff) {
 				out_be64(&pmd->ras_esc_0, 0);
 				return 0;
 			}
+			if (in_be64(&pmd->ras_esc_0) & 0x00010000) {
+				out_be64(&pmd->ras_esc_0, 0);
+				if (!button_dev)
+					return 0;
+
+				input_report_key(button_dev, KEY_POWER, 1);
+				input_sync(button_dev);
+				input_report_key(button_dev, KEY_POWER, 0);
+				input_sync(button_dev);
+				return 1;
+			}
 		}
 		break;
 #ifdef CONFIG_CBE_RAS
@@ -155,3 +171,55 @@ void __init cbe_pervasive_init(void)
 	ppc_md.power_save =3D cbe_power_save;
 	ppc_md.system_reset_exception =3D cbe_system_reset_exception;
 }
+
+static int __init cbe_power_button_init(void)
+{
+	int ret;
+	struct input_dev *dev;
+
+	if (!sysreset_hack)
+		return 0;
+
+	dev =3D input_allocate_device();
+        if (!dev) {
+		ret =3D -ENOMEM;
+                printk(KERN_ERR "%s: Not enough memory\n", __func__);
+                goto out;
+        }
+
+	set_bit(EV_KEY, dev->evbit);
+	set_bit(KEY_POWER, dev->keybit);
+
+	dev->name =3D "Power Button";
+	dev->id.bustype =3D BUS_HOST;
+
+	/* this makes the button look like an acpi power button
+	 * no clue whether anyone relies on that though */
+	dev->id.product =3D 0x02;
+	dev->phys =3D "LNXPWRBN/button/input0";
+
+	button_pdev =3D platform_device_register_simple("power_button", 0, NULL,
0);
+	if (IS_ERR(button_pdev)) {
+		ret =3D PTR_ERR(button_pdev);
+		goto out_free_input;
+	}
+
+	dev->dev.parent =3D &button_pdev->dev;
+
+	ret =3D input_register_device(dev);
+	if (ret) {
+                printk(KERN_ERR "%s: Failed to register device\n", __func_=
_);
+		goto out_free_pdev;
+        }
+
+	button_dev =3D dev;
+	return ret;
+
+out_free_pdev:
+	platform_device_unregister(button_pdev);
+out_free_input:
+	input_free_device(dev);
+out:
+	return ret;
+}
+device_initcall(cbe_power_button_init);


--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294

--Sig_/5ADivlJOFslAi113E5=WJcd
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFIWpju6rqK4qDx+dcRAji2AJ9csYYgKKPTUGv5FnpLsYUcUtP1AQCdFEIu
RNJKI2kWrDbFGMHZZNq406E=
=yeig
-----END PGP SIGNATURE-----

--Sig_/5ADivlJOFslAi113E5=WJcd--
