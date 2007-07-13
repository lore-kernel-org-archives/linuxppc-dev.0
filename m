Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy01.edpnet.net (lmailproxy01.edpnet.net [212.71.1.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B57D2DDDFE
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 05:40:21 +1000 (EST)
Received: from chiana.homelinux.org (213.219.189.138.adsl.dyn.edpnet.net
	[213.219.189.138])
	by lmailproxy01.edpnet.net (8.13.1/8.13.1) with ESMTP id l6DJi8lT021847
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 21:44:08 +0200
Received: from marc by chiana.homelinux.org with local (Exim 4.63)
	(envelope-from <marc.leeman@gmail.com>) id 1I9Qzu-0004sp-12
	for linuxppc-dev@ozlabs.org; Fri, 13 Jul 2007 21:40:14 +0200
Date: Fri, 13 Jul 2007 21:40:13 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.22 flash boot
Message-ID: <20070713194013.GU2660@chiana.homelinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hIOUAZgQFgkU+/gn"
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--hIOUAZgQFgkU+/gn
Content-Type: multipart/mixed; boundary="uglrMb9l+pHSuG/B"
Content-Disposition: inline


--uglrMb9l+pHSuG/B
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With the release of the 2.6.22, our boards didn't boot anymore. I traced
the change back to 2.6.21-git10/2.6.21-git11.=20

The reason they didn't boot was that the kernel  didn't detect the flash
where the root filesystem is stored on. The boards boot without an
initrd, directly from flash.

A file was removed (rom.c) and mentioned as obsolete in the ChangeLog.

att'd is the patch to restore the file against 2.6.22 since restoring
this file allow the boards to boot again (i.e. detect mtdblocks as
rootfilesystem).

Am I missing something here?

Judging by the dts files, a number of other boards seem to be using a
similar flash configuration as I do.

--=20
  greetz, marc
That's your plan? Wile E. Coyote would come up with a better plan
than that!
	Crichton - Throne for a Loss
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--uglrMb9l+pHSuG/B
Content-Type: text/x-diff; charset=iso-8859-15
Content-Disposition: attachment; filename="fix-boot.diff"
Content-Transfer-Encoding: quoted-printable

---
 arch/powerpc/sysdev/Makefile |    1 +
 arch/powerpc/sysdev/rom.c    |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

Index: linux-2.6.22/arch/powerpc/sysdev/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22.orig/arch/powerpc/sysdev/Makefile
+++ linux-2.6.22/arch/powerpc/sysdev/Makefile
@@ -30,6 +30,7 @@
=20
 # Temporary hack until we have migrated to asm-powerpc
 ifeq ($(ARCH),powerpc)
+obj-$(CONFIG_MTD)		+=3D rom.o
 obj-$(CONFIG_CPM2)		+=3D cpm2_common.o cpm2_pic.o
 obj-$(CONFIG_8xx)		+=3D mpc8xx_pic.o commproc.o
 obj-$(CONFIG_UCODE_PATCH)	+=3D micropatch.o
Index: linux-2.6.22/arch/powerpc/sysdev/rom.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.22/arch/powerpc/sysdev/rom.c
@@ -0,0 +1,32 @@
+/*
+ * ROM device registration
+ *
+ * (C) 2006 MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/kernel.h>
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+
+static int __init powerpc_flash_init(void)
+{
+	struct device_node *node =3D NULL;
+
+	/*
+	 * Register all the devices which type is "rom"
+	 */
+	while ((node =3D of_find_node_by_type(node, "rom")) !=3D NULL) {
+		if (node->name =3D=3D NULL) {
+			printk(KERN_WARNING "powerpc_flash_init: found 'rom' "
+				"device, but with no name, skipping...\n");
+			continue;
+		}
+		of_platform_device_create(node, node->name, NULL);
+	}
+	return 0;
+}
+
+arch_initcall(powerpc_flash_init);

--uglrMb9l+pHSuG/B--

--hIOUAZgQFgkU+/gn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGl9UcUQpj09NWLeERAmXcAKCho5ZCuUpdcDpBaPZtv8wKm90RfgCeJkEF
flWN1h7BqnIC9oVgXuut+9U=
=Re7t
-----END PGP SIGNATURE-----

--hIOUAZgQFgkU+/gn--
