From: Cort Dougan <cort@fsmlabs.com>
Date: Mon, 10 Feb 2003 12:16:00 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] vs. latest linuxppc_2_4_devel fixes walnut build
Message-ID: <20030210191600.GA11296@host109.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This fixes 'make znetboot' for the walnut and ebony.  There are many files
in arch/ppc/boot/images/ and the * in the cp command didn't work.

It also gets rid of extra whitespace on line 245 that some versions of make
don't like.

diff -Nru a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
--- a/arch/ppc/boot/simple/Makefile	Mon Feb 10 12:14:52 2003
+++ b/arch/ppc/boot/simple/Makefile	Mon Feb 10 12:14:52 2003
@@ -64,9 +64,13 @@
 # The rest will be unset.
 ifeq ($(CONFIG_EBONY),y)
 ZIMAGE				:= zImage-EBONY
+ZNETBOOT			:= zImage.treeboot
 ZIMAGEINITRD			:= zImage.initrd-EBONY
 TFTPIMAGE			:= /tftpboot/zImage.ebony
 endif
+ifeq ($(CONFIG_WALNUT),y)
+ZNETBOOT			:= zImage.treeboot
+endif
 ifeq ($(CONFIG_MCPN765)$(CONFIG_MVME5100)$(CONFIG_PRPMC750)$(CONFIG_PRPMC800)$(CONFIG_LOPEC)$(CONFIG_PPLUS),y)
 ZIMAGE				:= zImage-PPLUS
 ZIMAGEINITRD			:= zImage.initrd-PPLUS
@@ -241,7 +245,7 @@

 zImage-PAL4: zvmlinux
 	cp zvmlinux ../images/zImage.pal4
-
+
 zImage.initrd-PAL4: zvmlinux.initrd
 	cp zvmlinux.initrd ../images/zImage.initrd.pal4


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
