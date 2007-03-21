Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CED6DDFF9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:03:27 +1100 (EST)
Received: from sullivan.realtime.net (localhost [127.0.0.1])
	by sullivan.realtime.net (8.13.1/8.9.3) with ESMTP id l2LF3NCM008537
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 09:03:23 -0600 (CST)
	(envelope-from miltonm@sullivan.realtime.net)
Received: (from miltonm@localhost)
	by sullivan.realtime.net (8.13.1/8.12.7/Submit) id l2LF3NX7008536
	for linuxppc-dev@ozlabs.org; Wed, 21 Mar 2007 09:03:23 -0600 (CST)
Date: Wed, 21 Mar 2007 09:03:23 -0600 (CST)
Subject: [PATCH 8/8] boot: use a common zImage rule
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-2-08.miltonm@bga.com>
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

Before the plethora of platforms gets any worse, establish a common
rule to invoke the wrapper for any platform.  Add arguments to
the rule for initrd, dts, dtb, etc.   Show example usage with initrd.

Create default rules for zImage, and zImage.initrd.  initrd targets
depend on the ramdisk file.

Don't consider targets for zImage.initrd that are targets for zImage.
This means uImage is no longer considered a target for zImage.initrd.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Rebased after boot-add-FORCE.   Removed the explicit call of the rule,
and fixed the zImage.initrd vs zImage rule selection by making both
rules have the same requirements.

Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-03-21 03:27:37.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-03-21 03:37:32.000000000 -0500
@@ -116,50 +116,10 @@ CROSSWRAP := -C "$(CROSS_COMPILE)"
 endif
 endif
 
+# args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
-      cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) vmlinux
-quiet_cmd_wrap_initrd = WRAP    $@
-      cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
-				-i $(obj)/ramdisk.image.gz vmlinux
-
-$(obj)/zImage.chrp: vmlinux $(wrapperbits)
-	$(call if_changed,wrap,chrp)
-
-$(obj)/zImage.initrd.chrp: vmlinux $(wrapperbits)
-	$(call if_changed,wrap_initrd,chrp)
-
-$(obj)/zImage.pseries:	vmlinux $(wrapperbits)
-	$(call if_changed,wrap,pseries)
-
-$(obj)/zImage.initrd.pseries: vmlinux $(wrapperbits)
-	$(call if_changed,wrap_initrd,pseries)
-
-$(obj)/zImage.pmac: vmlinux $(wrapperbits)
-	$(call if_changed,wrap,pmac)
-
-$(obj)/zImage.initrd.pmac: vmlinux $(wrapperbits)
-	$(call if_changed,wrap_initrd,pmac)
-
-$(obj)/zImage.coff: vmlinux $(wrapperbits)
-	$(call if_changed,wrap,pmaccoff)
-
-$(obj)/zImage.initrd.coff: vmlinux $(wrapperbits)
-	$(call if_changed,wrap_initrd,pmaccoff)
-
-$(obj)/zImage.miboot: vmlinux $(wrapperbits)
-	$(call if_changed,wrap,miboot)
-
-$(obj)/zImage.initrd.miboot: vmlinux $(wrapperbits)
-	$(call if_changed,wrap_initrd,miboot)
-
-$(obj)/zImage.ps3: vmlinux
-	$(STRIP) -s -R .comment $< -o $@
-
-$(obj)/zImage.initrd.ps3: vmlinux
-	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
-
-$(obj)/uImage: vmlinux $(wrapperbits)
-	$(call if_changed,wrap,uboot)
+      cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+      		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) vmlinux
 
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
@@ -179,8 +139,29 @@ endif
 
 initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-))
 initrd-y := $(patsubst zImage%, zImage.initrd%, $(image-y))
+initrd-y := $(filter-out $(image-y), $(initrd-y))
 targets	+= $(image-y) $(initrd-y)
 
+$(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
+
+# Don't put the ramdisk on the pattern rule; when its missing make will try
+# the pattern rule with less dependencies that also matches (even with the
+# hard dependency listed).
+$(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
+
+$(obj)/zImage.%: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,$*)
+
+$(obj)/zImage.ps3: vmlinux
+	$(STRIP) -s -R .comment $< -o $@
+
+$(obj)/zImage.initrd.ps3: vmlinux
+	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
+
+$(obj)/uImage: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,uboot)
+
 $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 	@rm -f $@; ln $< $@
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
