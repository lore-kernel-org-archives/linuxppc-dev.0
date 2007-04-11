Return-Path: <mgreer@mvista.com>
Date: Tue, 10 Apr 2007 17:46:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Add Makefile rule to wrap dts file in zImage
Message-ID: <20070411004615.GA4905@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
compile and wrap a dts file from arch/powerpc/boot/dts into the zImage file.
The rules are similar to the initrd rules.

The dts file is expected to be arch/powerpc/boot/dts/$(CONFIG_DEVICE_TREE)

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

[This time its for real]

Paul, I find these rules very useful since I don't have OF or uboot.
I expect others will find them useful too.

 Makefile      |    2 +-
 boot/Makefile |   25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)
---

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a00fe72..9138bc9 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -148,7 +148,7 @@ all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd uImage
+BOOT_TARGETS = zImage zImage.initrd zImage.dts zImage.dts_initrd uImage
 
 PHONY += $(BOOT_TARGETS)
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index de80e47..13c5f6d 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -144,12 +144,30 @@ targets	+= $(image-y) $(initrd-y)
 
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
 $(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
 
+$(obj)/zImage.dts.%: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,$*,$(src)/dts/$(CONFIG_DEVICE_TREE))
+
+$(obj)/zImage.dts_initrd.%: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,$*,$(src)/dts/$(CONFIG_DEVICE_TREE),,$(obj)/ramdisk.image.gz)
+
 $(obj)/zImage.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*)
 
@@ -166,9 +184,14 @@ $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 	@rm -f $@; ln $< $@
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 	@rm -f $@; ln $< $@
+$(obj)/zImage.dts:	$(addprefix $(obj)/, $(dts-y))
+	@rm -f $@; ln $< $@
+$(obj)/zImage.dts_initrd:	$(addprefix $(obj)/, $(dts_initrd-y))
+	@rm -f $@; ln $< $@
 
 install: $(CONFIGURE) $(image-y)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
 clean-files += $(addprefix $(objtree)/, vmlinux.strip.gz vmlinux.bin.gz)
-clean-files += $(image-) $(initrd-) zImage zImage.initrd
+clean-files += $(image-) $(initrd-) $(dts-) $(dts_initrd-) zImage \
+		zImage.initrd zImage.dts zImage.dts_initrd
