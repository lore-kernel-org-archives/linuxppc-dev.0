Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7B02DDF75
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:02:40 +1100 (EST)
Received: from sullivan.realtime.net (localhost [127.0.0.1])
	by sullivan.realtime.net (8.13.1/8.9.3) with ESMTP id l2LF2bKW008491
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 09:02:37 -0600 (CST)
	(envelope-from miltonm@sullivan.realtime.net)
Received: (from miltonm@localhost)
	by sullivan.realtime.net (8.13.1/8.12.7/Submit) id l2LF2bUv008490
	for linuxppc-dev@ozlabs.org; Wed, 21 Mar 2007 09:02:37 -0600 (CST)
Date: Wed, 21 Mar 2007 09:02:37 -0600 (CST)
Subject: [PATCH 6/8] boot: use FORCE
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-2-06.miltonm@bga.com>
In-Reply-To: <boot-2-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, david@gibson.dropbear.id.au
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
Previous Testing: Several repeat runs with V=2 and going up and down a series.
Without this, there were several missed rebuilds, including missing archive
rebulid when adding and dropping a patch adding platform support.

This version: 
- Rebased to before common zImage rule.

- zImage or zImage.initrd not included.  They did not have cmd_ defined.
This means that if you change your config or the Makefile to change the
first listed image, you won't get the new zImage link.

Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-03-21 03:14:04.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-03-21 03:14:17.000000000 -0500
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
@@ -122,34 +123,34 @@ quiet_cmd_wrap_initrd = WRAP    $@
 				-i $(obj)/ramdisk.image.gz vmlinux
 
 $(obj)/zImage.chrp: vmlinux $(wrapperbits)
-	$(call cmd,wrap,chrp)
+	$(call if_changed,wrap,chrp)
 
 $(obj)/zImage.initrd.chrp: vmlinux $(wrapperbits)
-	$(call cmd,wrap_initrd,chrp)
+	$(call if_changed,wrap_initrd,chrp)
 
 $(obj)/zImage.pseries:	vmlinux $(wrapperbits)
-	$(call cmd,wrap,pseries)
+	$(call if_changed,wrap,pseries)
 
 $(obj)/zImage.initrd.pseries: vmlinux $(wrapperbits)
-	$(call cmd,wrap_initrd,pseries)
+	$(call if_changed,wrap_initrd,pseries)
 
 $(obj)/zImage.pmac: vmlinux $(wrapperbits)
-	$(call cmd,wrap,pmac)
+	$(call if_changed,wrap,pmac)
 
 $(obj)/zImage.initrd.pmac: vmlinux $(wrapperbits)
-	$(call cmd,wrap_initrd,pmac)
+	$(call if_changed,wrap_initrd,pmac)
 
 $(obj)/zImage.coff: vmlinux $(wrapperbits)
-	$(call cmd,wrap,pmaccoff)
+	$(call if_changed,wrap,pmaccoff)
 
 $(obj)/zImage.initrd.coff: vmlinux $(wrapperbits)
-	$(call cmd,wrap_initrd,pmaccoff)
+	$(call if_changed,wrap_initrd,pmaccoff)
 
 $(obj)/zImage.miboot: vmlinux $(wrapperbits)
-	$(call cmd,wrap,miboot)
+	$(call if_changed,wrap,miboot)
 
 $(obj)/zImage.initrd.miboot: vmlinux $(wrapperbits)
-	$(call cmd,wrap_initrd,miboot)
+	$(call if_changed,wrap_initrd,miboot)
 
 $(obj)/zImage.ps3: vmlinux
 	$(STRIP) -s -R .comment $< -o $@
@@ -158,7 +159,7 @@ $(obj)/zImage.initrd.ps3: vmlinux
 	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
 
 $(obj)/uImage: vmlinux $(wrapperbits)
-	$(call cmd,wrap,uboot)
+	$(call if_changed,wrap,uboot)
 
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
@@ -177,6 +178,7 @@ image-$(CONFIG_PPC_PMAC)	+= zImage.coff 
 endif
 
 initrd-y := $(patsubst zImage%, zImage.initrd%, $(image-y))
+targets	+= $(image-y) $(initrd-y)
 
 $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 	@rm -f $@; ln $< $@
