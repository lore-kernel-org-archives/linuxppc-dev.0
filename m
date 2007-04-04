Return-Path: <mgreer@mvista.com>
Date: Wed, 4 Apr 2007 15:20:52 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: miltonm@bga.com
Subject: [RFC] Add Makefile rule(s) to wrap dts file in zImage
Message-ID: <20070404222052.GA31901@mag.az.mvista.com>
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

[Disclaimer: I'm not a Makefile expert]

Milton,

I'm not exactly sure what you have in mind so I made two different
patches that add support for automatically wrapping a dts in the zImage.
Are either of these close to what you have in mind?

I think I prefer #2.  (I should add a zImage.initrd.dts rule too)

Mark
--

------------- Patch 1 -------------

[PATCH] powerpc: Add Makefile rule to wrap dts file in zImage

Add a rule to arch/powerpc/boot/Makefile that automatically takes a dts
file, compiles it, and wraps it into the zImage.  To use the rule,
you need another rule something like:
	"image-$(CONFIG_PPC_<platform>)	+= zImage.dts.<platform>"
That will produce the zImage file arch/powerpc/boot/zImage.dts.<platform>

The dts file is expected to be in arch/powerpc/boot/dts/$(CONFIG_DEVICE_TREE)

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 Makefile |    3 +++
 1 file changed, 3 insertions(+)
---

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index de80e47..3ffb0ec 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -150,6 +150,9 @@ $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
 $(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
 
+$(obj)/zImage.dts.%: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,$*,$(src)/dts/$(CONFIG_DEVICE_TREE))
+
 $(obj)/zImage.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*)
 
------------- Patch 2 -------------

[PATCH] powerpc: Add Makefile rules to wrap dts file in zImage

Add 'zImage.dts' build rules that automatically take a dts
file, compile it, and wrap it into the zImage.  The rules are
similar to the initrd rules.

The dts file is expected to be in arch/powerpc/boot/dts/$(CONFIG_DEVICE_TREE)

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 Makefile      |    2 +-
 boot/Makefile |   12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)
---

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a00fe72..eecb995 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -148,7 +148,7 @@ all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd uImage
+BOOT_TARGETS = zImage zImage.initrd zImage.dts uImage
 
 PHONY += $(BOOT_TARGETS)
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index de80e47..077ddc6 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -144,12 +144,20 @@ targets	+= $(image-y) $(initrd-y)
 
 $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
 
+dts-  := $(patsubst zImage%, zImage.dts%, $(image-n) $(image-))
+dts-y := $(patsubst zImage%, zImage.dts%, $(image-y))
+dts-y := $(filter-out $(image-y), $(dts-y))
+targets	+= $(image-y) $(dts-y)
+
 # Don't put the ramdisk on the pattern rule; when its missing make will try
 # the pattern rule with less dependencies that also matches (even with the
 # hard dependency listed).
 $(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
 
+$(obj)/zImage.dts.%: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,$*,$(src)/dts/$(CONFIG_DEVICE_TREE))
+
 $(obj)/zImage.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*)
 
@@ -166,9 +174,11 @@ $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 	@rm -f $@; ln $< $@
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 	@rm -f $@; ln $< $@
+$(obj)/zImage.dts:	$(addprefix $(obj)/, $(dts-y))
+	@rm -f $@; ln $< $@
 
 install: $(CONFIGURE) $(image-y)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
 clean-files += $(addprefix $(objtree)/, vmlinux.strip.gz vmlinux.bin.gz)
-clean-files += $(image-) $(initrd-) zImage zImage.initrd
+clean-files += $(image-) $(initrd-) $(dts-) zImage zImage.initrd zImage.dts
