Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 May 2007 17:14:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: Fix some missing build dependencies in arch/powerpc/boot
Message-ID: <20070504071413.GA8785@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a couple of missing dependencies in
arch/powerpc/boot/Makefile.  First, it ensures that the zlib.h header
is linked in before attempting to build gunzip_util.o, as it is,
building gunzip_util.o usually works, but not always depending on make
order.

Second, it makes the final images which are built using a dts
dependent on that dts, so the image will be correctly rebuilt if the
dts changes.  This in turn requires fixing the definition of the dts
variable.  CONFIG_DEVICE_TREE from Kconfig will have quotes around it,
which don't matter when passing the variable to a shell, but which
need to be removed when incorporating it into a filename for make's
use.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 arch/powerpc/boot/Makefile |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-05-04 17:10:29.000000000 +1000
+++ working-2.6/arch/powerpc/boot/Makefile	2007-05-04 17:10:30.000000000 +1000
@@ -37,8 +37,8 @@ zlib       := inffast.c inflate.c inftre
 zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h
 zliblinuxheader := zlib.h zconf.h zutil.h
 
-$(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) \
-		$(addprefix $(obj)/,$(zlibheader))
+$(addprefix $(obj)/,$(zlib) gunzip_util.o main.o): \
+	$(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
@@ -167,16 +167,17 @@ $(obj)/zImage.initrd.ps3: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
+# CONFIG_DEVICE_TREE will have "" around it, make sure to strip them
 dts = $(if $(shell echo $(CONFIG_DEVICE_TREE) | grep '^/'),\
-       ,$(srctree)/$(src)/dts/)$(CONFIG_DEVICE_TREE)
+	,$(srctree)/$(src)/dts/)$(CONFIG_DEVICE_TREE:"%"=%)
 
-$(obj)/cuImage.%: vmlinux $(wrapperbits)
+$(obj)/cuImage.%: vmlinux $(dts) $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,$(dts))
 
-$(obj)/treeImage.%: vmlinux $(wrapperbits)
+$(obj)/treeImage.%: vmlinux $(dts) $(wrapperbits)
 	$(call if_changed,wrap,treeboot-$*,$(dts))
 
-$(obj)/treeImage.initrd.%: vmlinux $(wrapperbits)
+$(obj)/treeImage.initrd.%: vmlinux $(dts) $(wrapperbits)
 	$(call if_changed,wrap,treeboot-$*,$(dts),,$(obj)/ramdisk.image.gz)
 
 $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
