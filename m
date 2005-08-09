Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.dorchain.net", Issuer "Dorchain Family" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9A7C56800E
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2005 05:17:55 +1000 (EST)
Received: (from joerg@localhost)
	by Redstar.dorchain.net (8.13.4/8.13.4) id j79JBMsW006693
	for linuxppc-dev@ozlabs.org; Tue, 9 Aug 2005 21:11:22 +0200
Date: Tue, 9 Aug 2005 21:11:22 +0200
From: Joerg Dorchain <joerg@dorchain.net>
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Message-ID: <20050809191122.GA6509@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Subject: make install target implementation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed that the install target is mentioned in the help, but not
implemented. I tried an implementation that can be used by distributions
and does not break yaboot for me ;-) Patch enclosed, comments welcome.

Bye,

Joerg

Signed-off-by: Joerg Dorchain <joerg@dorchain.net>
--- arch/ppc/boot/install.sh.orig	2005-08-09 20:54:21.000000000 +0200
+++ arch/ppc/boot/install.sh	2005-08-09 21:07:26.000000000 +0200
@@ -0,0 +1,41 @@
+#!/bin/sh
+#
+# arch/ppc/boot/install.sh
+#
+# This file is subject to the terms and conditions of the GNU General Publ=
ic
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1995 by Linus Torvalds
+#
+# Adapted from code in arch/i386/boot/install.sh by Joerg Dorchain
+#
+# "make install" script for ppc architecture
+#
+# Arguments:
+#   $1 - kernel version
+#   $2 - kernel image file
+#   $3 - kernel map file
+#   $4 - default install path (blank if root directory)
+#
+
+# User may have a custom install script
+
+if [ -x ~/bin/installkernel ]; then exec ~/bin/installkernel "$@"; fi
+if [ -x /sbin/installkernel ]; then exec /sbin/installkernel "$@"; fi
+
+# Default install - same as make zlilo
+
+if [ -f $4/vmlinux ]; then
+	mv $4/vmlinux $4/vmlinux.old
+fi
+
+if [ -f $4/System.map ]; then
+	mv $4/System.map $4/System.old
+fi
+
+cat $2 > $4/vmlinux
+cp $3 $4/System.map
+
+# No lilo here
+#if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
--- arch/ppc/Makefile.orig	2005-08-09 20:44:33.000000000 +0200
+++ arch/ppc/Makefile	2005-08-09 21:08:20.000000000 +0200
@@ -94,7 +94,7 @@
   @echo '  install         - Install kernel using'
   @echo '                    (your) ~/bin/installkernel or'
   @echo '                    (distribution) /sbin/installkernel or'
-  @echo '                    install to $$(INSTALL_PATH) and run lilo'
+  @echo '                    install to $$(INSTALL_PATH)'
   @echo '  *_defconfig     - Select default config from arch/$(ARCH)/ppc/c=
onfigs'
 endef
=20
@@ -137,3 +137,5 @@
 		arch/$(ARCH)/kernel/asm-offsets.s \
 		$(TOUT)
=20
+install: vmlinux
+	sh $(srctree)/$(boot)/install.sh $(KERNELRELEASE) $< System.map "$(INSTAL=
L_PATH)"

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC+P/ajY4+4PdzvOARAvWFAJ9rj6ngw2KUrLAuDB8ZBZW5ucOICQCfRejy
hwv64mjPMTbb22QzpZRLKrE=
=Slgq
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
