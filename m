From: Brian Waite <waite@skycomputers.com>
To: Steven Scholz <steven.scholz@imc-berlin.de>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: BOOT_TARGET pImage & uImage ???
Date: Thu, 18 Sep 2003 09:52:29 -0400
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
References: <3F65917D.1020502@imc-berlin.de> <20030915150935.GB29517@ip68-0-152-218.tc.ph.cox.net> <3F699255.4050000@imc-berlin.de>
In-Reply-To: <3F699255.4050000@imc-berlin.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_diba/9D8fgfYQAp"
Message-Id: <200309180952.29699.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary-00=_diba/9D8fgfYQAp
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here  is the patch I have been using myself. I am embarrassed to say that I=
=20
was the 2nd person to ask and I forgot to post the patch for inclusion. I=20
don;t have a version for 2.5/6 but this works for 2.4 (based on=20
2.4.22-pre10). Tom, I am not sure this is exactly what yoou wanted when we=
=20
initially talked about it so let me know if you would like a better method.


Thanks
Brian
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/abidmxLCz0u+Ko8RApSeAJ9FwwirTLp5lYIeoVwOs3olE11CDACeM7Zs
oiWo6RqxHhkLubrg8YbELqI=3D
=3Ds7cT
=2D----END PGP SIGNATURE-----

--Boundary-00=_diba/9D8fgfYQAp
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uboot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uboot.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1350  -> 1.1351
#	   arch/ppc/Makefile	1.57    -> 1.58
#	arch/ppc/boot/images/Makefile	1.6     -> 1.7
#	arch/ppc/boot/Makefile	1.49    -> 1.50
#	               (new)	        -> 1.1     scripts/mkuboot.sh
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/07	waite@dayton.sky	1.1351
# U
# --------------------------------------------
#
diff -Nru a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile	Thu Sep 18 09:45:53 2003
+++ b/arch/ppc/Makefile	Thu Sep 18 09:45:53 2003
@@ -98,7 +98,7 @@
 checks:
 	@$(MAKE) -C arch/$(ARCH)/kernel checks

-BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd
+BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd uImage

 # All the instructions talk about "make bzImage".
 bzImage: zImage
diff -Nru a/arch/ppc/boot/Makefile b/arch/ppc/boot/Makefile
--- a/arch/ppc/boot/Makefile	Thu Sep 18 09:45:53 2003
+++ b/arch/ppc/boot/Makefile	Thu Sep 18 09:45:53 2003
@@ -17,7 +17,7 @@
 AFLAGS	+= -D__BOOTER__
 OBJCOPY_ARGS = -O elf32-powerpc

-MKIMAGE				:= ./utils/mkimage.wrapper
+MKIMAGE				:= $(TOPDIR)/scripts/mkuboot.sh

 lib/zlib.a: lib/zlib.c
 	$(MAKE) -C lib
@@ -67,12 +67,18 @@
 	gzip $(GZIP_FLAGS) images/vmapus
 endif

+mkuboot: $(MKIMAGE)
+	cp $< $@
+	chmod 755 $@
+
+
 # Make an image for PPCBoot
-pImage: images/vmlinux.gz
-	$(MKIMAGE) -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
+uImage: images/vmlinux.gz mkuboot
+	./mkuboot -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
 	-n 'Linux-$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)' \
-	-d $< images/vmlinux.PPCBoot
-	ln -sf vmlinux.PPCBoot images/pImage
+	-d $< images/vmlinux.UBoot
+	ln -sf vmlinux.UBoot images/uImage
+	rm -f ./mkuboot

 # These are subdirs with files not normally rm'ed. -- Tom
 clean:
diff -Nru a/arch/ppc/boot/images/Makefile b/arch/ppc/boot/images/Makefile
--- a/arch/ppc/boot/images/Makefile	Thu Sep 18 09:45:53 2003
+++ b/arch/ppc/boot/images/Makefile	Thu Sep 18 09:45:53 2003
@@ -9,4 +9,4 @@
 	gzip -vf9 vmlinux

 clean:
-	rm -f sImage vmapus vmlinux* miboot* zImage* zvmlinux*
+	rm -f sImage vmapus vmlinux* miboot* zImage* zvmlinux* uImage
diff -Nru a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
diff -Nru a/scripts/mkuboot.sh b/scripts/mkuboot.sh
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/mkuboot.sh	Thu Sep 18 09:45:53 2003
@@ -0,0 +1,16 @@
+#!/bin/bash
+
+#
+# Build U-Boot image when `mkimage' tool is available.
+#
+
+MKIMAGE=$(type -path mkimage)
+
+if [ -z "${MKIMAGE}" ]; then
+	# Doesn't exist
+	echo '"mkimage" command not found - U-Boot images will not be built' >&2
+	exit 0;
+fi
+
+# Call "mkimage" to create U-Boot image
+${MKIMAGE} "$@"

--Boundary-00=_diba/9D8fgfYQAp--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
