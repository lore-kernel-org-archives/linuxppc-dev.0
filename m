Date: Wed, 16 Jun 2004 19:16:52 +0100
From: Martin Habets <errandir_news@mph.eclipse.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Make install target work
Message-ID: <20040616181652.GA7240@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch makes the install target work. After all, it is already
mentioned in the 'make help' output.
The only question is, should it install zImage by default? I always
install vmlinux, so I used that.

Martin

Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>


--- 2.6/arch/ppc/Makefile.orig	2004-06-16 18:29:54.318963064 +0100
+++ 2.6/arch/ppc/Makefile	2004-06-16 18:55:18.157304424 +0100
@@ -46,6 +46,7 @@
 drivers-$(CONFIG_OCP)		+= arch/ppc/ocp/

 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
+BOOT_TARGETS += install

 .PHONY: $(BOOT_TARGETS)

@@ -70,7 +71,7 @@
   @echo '  install         - Install kernel using'
   @echo '                    (your) ~/bin/installkernel or'
   @echo '                    (distribution) /sbin/installkernel or'
-  @echo '                    install to $$(INSTALL_PATH) and run lilo'
+  @echo '                    install to $$(INSTALL_PATH) and run ybin'
   @echo '  *_defconfig     - Select default config from arch/$(ARCH)/ppc/configs'
 endef


--- 2.6/arch/ppc/boot/Makefile.orig	2004-06-16 18:33:06.614729664 +0100
+++ 2.6/arch/ppc/boot/Makefile	2004-06-16 18:36:43.275792176 +0100
@@ -32,3 +32,6 @@
 $(bootdir-y): $(addprefix $(obj)/,$(subdir-y)) \
 		$(addprefix $(obj)/,$(host-progs))
 	$(Q)$(MAKE) $(build)=$(obj)/$@ $(MAKECMDGOALS)
+
+install: vmlinux
+	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"


--- 2.6/arch/ppc/boot/install.sh.orig	2004-06-16 18:53:05.439480600 +0100
+++ 2.6/arch/ppc/boot/install.sh	2004-06-16 18:45:41.206014352 +0100
@@ -0,0 +1,50 @@
+#!/bin/sh
+#
+# arch/ppc/boot/install.sh
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1995 by Linus Torvalds
+#
+# Blatantly stolen from in arch/i386/boot/install.sh by Martin Habets
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
+# Default install
+
+# Figure out if this is a compressed image or not.
+target=vmlinux
+if [ -n "`file $2 | grep -i compressed`" ];
+then
+	target=vmlinuz;
+fi
+
+if [ -f $4/$target ]; then
+	mv $4/$target $4/$target.old
+fi
+
+if [ -f $4/System.map ]; then
+	mv $4/System.map $4/System.old
+fi
+
+cat $2 > $4/$target
+cp $3 $4/System.map
+
+if [ -x /usr/sbin/ybin ];
+then
+	/usr/sbin/ybin -v;
+fi

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
