Return-Path: <mgreer@mvista.com>
Date: Wed, 25 Apr 2007 16:55:04 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/13] powerpc: Add Makefile rule to wrap dts file in zImage
Message-ID: <20070425235504.GC4046@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070425234630.GA4046@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add 'zImage.dts' and 'zImage.dts_initrd' build rules that automatically
compile and wrap a dts file into the zImage file.  The rules are similar
to the initrd rules.

The dts file is expected to be arch/powerpc/boot/dts/$(CONFIG_DEVICE_TREE)

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 Makefile      |    2 +-
 boot/Makefile |   24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

Index: powerpc/arch/powerpc/boot/Makefile
===================================================================
--- powerpc.orig/arch/powerpc/boot/Makefile
+++ powerpc/arch/powerpc/boot/Makefile
@@ -144,9 +144,27 @@ targets	+= $(image-y) $(initrd-y)
 
 $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
 
+dts-  := $(patsubst zImage%, zImage.dts%, $(image-n) $(image-))
+dts-y := $(patsubst zImage%, zImage.dts%, $(image-y))
+dts-y := $(filter-out $(image-y), $(dts-y))
+targets	+= $(image-y) $(dts-y)
+
+dts_initrd-  := $(patsubst zImage%, zImage.dts_initrd%, $(image-n) $(image-))
+dts_initrd-y := $(patsubst zImage%, zImage.dts_initrd%, $(image-y))
+dts_initrd-y := $(filter-out $(image-y), $(dts_initrd-y))
+targets	+= $(image-y) $(dts_initrd-y)
+
+$(addprefix $(obj)/, $(dts_initrd-y)): $(obj)/ramdisk.image.gz
+
 # Don't put the ramdisk on the pattern rule; when its missing make will try
 # the pattern rule with less dependencies that also matches (even with the
 # hard dependency listed).
+$(obj)/zImage.dts_initrd.%: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,$*,$(dts),,$(obj)/ramdisk.image.gz)
+
+$(obj)/zImage.dts.%: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,$*,$(dts))
+
 $(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
 
@@ -175,13 +193,17 @@ $(obj)/zImage:		$(addprefix $(obj)/, $(i
 	@rm -f $@; ln $< $@
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 	@rm -f $@; ln $< $@
+$(obj)/zImage.dts:	$(addprefix $(obj)/, $(dts-y))
+	@rm -f $@; ln $< $@
+$(obj)/zImage.dts_initrd:	$(addprefix $(obj)/, $(dts_initrd-y))
+	@rm -f $@; ln $< $@
 
 install: $(CONFIGURE) $(image-y)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
 # anything not in $(targets)
 clean-files += $(image-) $(initrd-) zImage zImage.initrd \
-               cuImage.elf cuImage.bin.gz
+               cuImage.elf cuImage.bin.gz zImage.dts zImage.dts_initrd
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin
Index: powerpc/arch/powerpc/Makefile
===================================================================
--- powerpc.orig/arch/powerpc/Makefile
+++ powerpc/arch/powerpc/Makefile
@@ -148,7 +148,7 @@ all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd uImage cuImage
+BOOT_TARGETS = zImage zImage.initrd zImage.dts zImage.dts_initrd uImage cuImage
 
 PHONY += $(BOOT_TARGETS)
 
