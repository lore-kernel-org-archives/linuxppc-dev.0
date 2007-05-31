Return-Path: <mgreer@mvista.com>
Date: Thu, 31 May 2007 12:54:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] powerpc: Remove 'make zImage.dts' feature
Message-ID: <20070531195439.GA3818@mag.az.mvista.com>
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


Being able to selectively wrap a device tree with the zIimage at build
time has deemed unnecessary so remove Makefile support for that feature.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>

---
 arch/powerpc/Makefile      |    2 +-
 arch/powerpc/boot/Makefile |   26 +-------------------------
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6238b58..24e1217 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -149,7 +149,7 @@ all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd zImage.dts zImage.dts_initrd uImage
+BOOT_TARGETS = zImage zImage.initrd uImage
 
 PHONY += $(BOOT_TARGETS)
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8378898..aef95bd 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -158,27 +158,9 @@ targets	+= $(image-y) $(initrd-y)
 
 $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
 
-dts-  := $(patsubst zImage%, zImage.dts%, $(image-n) $(image-))
-dts-y := $(patsubst zImage%, zImage.dts%, $(image-y))
-dts-y := $(filter-out $(image-y), $(dts-y))
-targets	+= $(image-y) $(dts-y)
-
-dts_initrd-  := $(patsubst zImage%, zImage.dts_initrd%, $(image-n) $(image-))
-dts_initrd-y := $(patsubst zImage%, zImage.dts_initrd%, $(image-y))
-dts_initrd-y := $(filter-out $(image-y), $(dts_initrd-y))
-targets	+= $(image-y) $(dts_initrd-y)
-
-$(addprefix $(obj)/, $(dts_initrd-y)): $(obj)/ramdisk.image.gz
-
 # Don't put the ramdisk on the pattern rule; when its missing make will try
 # the pattern rule with less dependencies that also matches (even with the
 # hard dependency listed).
-$(obj)/zImage.dts_initrd.%: vmlinux $(wrapperbits) $(dts) $(obj)/ramdisk.image.gz
-	$(call if_changed,wrap,$*,$(dts),,$(obj)/ramdisk.image.gz)
-
-$(obj)/zImage.dts.%: vmlinux $(wrapperbits) $(dts)
-	$(call if_changed,wrap,$*,$(dts))
-
 $(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
 
@@ -217,18 +199,12 @@ $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 	@rm -f $@; ln $< $@
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 	@rm -f $@; ln $< $@
-$(obj)/zImage.dts:	$(addprefix $(obj)/, $(dts-y))
-	@rm -f $@; ln $< $@
-$(obj)/zImage.dts_initrd:	$(addprefix $(obj)/, $(dts_initrd-y))
-	@rm -f $@; ln $< $@
-
 
 install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
 # anything not in $(targets)
-clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.* \
-	treeImage.* zImage.dts zImage.dts_initrd
+clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.* treeImage.*
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin
