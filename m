Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 644DDDE063
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 08:06:55 +1100 (EST)
Date: Mon, 19 Mar 2007 14:58:03 -0600 (CST)
Subject: [PATCH 3/7] boot: use FORCE
From: Milton Miller <miltonm@bga.com>
Sender: <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <boot-00.miltonm@bga.com>
Message-Id: <boot-03.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kbuild if_changed and if_changed_dep require the use of the dummy
FORCE to get the dependencies right.   Also add to targets to get
correct behavior.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Testing: Several repeat runs with V=2 and going up and down this series.
Without this, there were several missed rebuilds.
 Makefile |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-03-19 09:15:06.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-03-19 09:15:19.000000000 -0500
@@ -85,24 +85,25 @@ quiet_cmd_bootas = BOOTAS  $@
       cmd_bootas = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
 
 quiet_cmd_bootar = BOOTAR  $@
-      cmd_bootar = $(CROSS32AR) -cr $@.$$$$ $^; mv $@.$$$$ $@
+      cmd_bootar = $(CROSS32AR) -cr $@.$$$$ $(filter-out FORCE,$^); mv $@.$$$$ $@
 
-$(patsubst %.c,%.o, $(filter %.c, $(src-boot))): %.o: %.c
+$(patsubst %.c,%.o, $(filter %.c, $(src-boot))): %.o: %.c FORCE
 	$(call if_changed_dep,bootcc)
-$(patsubst %.S,%.o, $(filter %.S, $(src-boot))): %.o: %.S
+$(patsubst %.S,%.o, $(filter %.S, $(src-boot))): %.o: %.S FORCE
 	$(call if_changed_dep,bootas)
 
-$(obj)/wrapper.a: $(obj-wlib)
-	$(call cmd,bootar)
+$(obj)/wrapper.a: $(obj-wlib) FORCE
+	$(call if_changed,bootar)
 
 hostprogs-y	:= addnote addRamDisk hack-coff mktree
 
+targets		+= $(patsubst $(obj)/%,%,$(obj-boot) wrapper.a)
 extra-y		:= $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
 		   $(obj)/zImage.lds $(obj)/zImage.coff.lds
 
 wrapper		:=$(srctree)/$(src)/wrapper
 wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree) \
-			$(wrapper)
+			$(wrapper) FORCE
 
 #############
 # Bits for building various flavours of zImage
@@ -127,7 +128,7 @@ $(obj)/zImage.initrd.ps3: vmlinux
 	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
 
 $(obj)/uImage: vmlinux $(wrapperbits)
-	$(call cmd,wrap,uboot)
+	$(call if_changed,wrap,uboot)
 
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
@@ -146,19 +147,20 @@ image-$(CONFIG_PPC_PMAC)	+= zImage.coff 
 endif
 
 initrd-y := $(patsubst zImage%, zImage.initrd%, $(image-y))
+targets	+= $(image-y) $(initrd-y)
 
 $(addprefix $(obj)/,$(filter-out uImage zImage.ps3,$(image-y))): \
 		$(obj)/zImage.%: vmlinux $(wrapperbits)
-	$(call cmd,wrap,$(patsubst $(obj)/zImage.%,%,$@))
+	$(call if_changed,wrap,$(patsubst $(obj)/zImage.%,%,$@))
 
 $(addprefix $(obj)/,$(filter-out uImage zImage.initrd.ps3,$(initrd-y))): \
 		$(obj)/zImage.initrd.%: vmlinux $(wrapperbits) \
 		$(obj)/ramdisk.image.gz
-	$(call cmd,wrap_initrd,$(patsubst $(obj)/zImage.initrd.%,%,$@),,,$(obj)/ramdisk.image.gz)
+	$(call if_changed,wrap,$(patsubst $(obj)/zImage.initrd.%,%,$@),,,$(obj)/ramdisk.image.gz)
 
-$(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
+$(obj)/zImage:		$(addprefix $(obj)/, $(image-y)) FORCE
 	@rm -f $@; ln $< $@
-$(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
+$(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y)) FORCE
 	@rm -f $@; ln $< $@
 
 install: $(CONFIGURE) $(image-y)
