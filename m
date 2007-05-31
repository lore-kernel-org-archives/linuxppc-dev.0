Return-Path: <mgreer@mvista.com>
Date: Thu, 31 May 2007 12:55:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] powerpc: When appropriate, wrap device tree with zImage
Message-ID: <20070531195535.GB3818@mag.az.mvista.com>
References: <20070531195136.GA3699@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070531195136.GA3699@mag.az.mvista.com>
Cc: David Gibson <dgibson@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


There are 2 config options that indicate whether the platform being built
has a device tree source file associated with it.  Namely,
CONFIG_WANT_DEVICE_TREE and CONFIG_DEVICE_TREE.  When CONFIG_WANT_DEVICE_TREE
is 'y' and CONFIG_DEVICE_TREE isn't an empty string, automatically wrap
the specified device tree with the zImage being built.

To achieve this, the 'dts' variable will only be set when the conditions
above are true.  The changes to the zImage.initrd.% and zImage.% rules
cause the device tree to be wrapped when 'dts' is set; otherwise, they
will work as they previosly did (i.e., build a zImage with no device tree).

Signed-off-by: Mark A. Greer <mgreer@mvista.com>

---
 arch/powerpc/boot/Makefile |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index aef95bd..c6f8a0c 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -158,14 +158,24 @@ targets	+= $(image-y) $(initrd-y)
 
 $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
 
+# If CONFIG_WANT_DEVICE_TREE is set and CONFIG_DEVICE_TREE isn't an
+# empty string, define 'dts' to be path to the dts
+# CONFIG_DEVICE_TREE will have "" around it, make sure to strip them
+ifeq ($(CONFIG_WANT_DEVICE_TREE),y)
+ifneq ($(CONFIG_DEVICE_TREE),"")
+dts = $(if $(shell echo $(CONFIG_DEVICE_TREE) | grep '^/'),\
+	,$(srctree)/$(src)/dts/)$(CONFIG_DEVICE_TREE:"%"=%)
+endif
+endif
+
 # Don't put the ramdisk on the pattern rule; when its missing make will try
 # the pattern rule with less dependencies that also matches (even with the
 # hard dependency listed).
-$(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
-	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
+$(obj)/zImage.initrd.%: vmlinux $(wrapperbits) $(dts)
+	$(call if_changed,wrap,$*,$(dts),,$(obj)/ramdisk.image.gz)
 
-$(obj)/zImage.%: vmlinux $(wrapperbits)
-	$(call if_changed,wrap,$*)
+$(obj)/zImage.%: vmlinux $(wrapperbits) $(dts)
+	$(call if_changed,wrap,$*,$(dts))
 
 $(obj)/zImage.ps3: vmlinux
 	$(STRIP) -s -R .comment $< -o $@
@@ -182,10 +192,6 @@ $(obj)/zImage.initrd.holly-elf: vmlinux $(wrapperbits) $(obj)/ramdisk.image.gz
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
-# CONFIG_DEVICE_TREE will have "" around it, make sure to strip them
-dts = $(if $(shell echo $(CONFIG_DEVICE_TREE) | grep '^/'),\
-	,$(srctree)/$(src)/dts/)$(CONFIG_DEVICE_TREE:"%"=%)
-
 $(obj)/cuImage.%: vmlinux $(dts) $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,$(dts))
 
