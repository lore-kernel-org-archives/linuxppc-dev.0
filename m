Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E14DBDE037
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 08:06:53 +1100 (EST)
Date: Mon, 19 Mar 2007 14:58:07 -0600 (CST)
Subject: [PATCH 1/7] boot: use a common zImage rule
From: Milton Miller <miltonm@bga.com>
Sender: <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <boot-00.miltonm@bga.com>
Message-Id: <boot-01.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>
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

For now, uImage and zImage*ps3 are special.  Hopefully ps3 will join
the party.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
One reviewer pointed out the explicit exception rule are now seperated
from the generic rule.  While the rule needs to go after the image-
assignment, that code could be moved up.
 Makefile |   46 ++++++++++++----------------------------------
 1 file changed, 12 insertions(+), 34 deletions(-)

Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-03-19 08:23:03.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-03-19 09:14:59.000000000 -0500
@@ -114,41 +114,10 @@ CROSSWRAP := -C "$(CROSS_COMPILE)"
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
-	$(call cmd,wrap,chrp)
-
-$(obj)/zImage.initrd.chrp: vmlinux $(wrapperbits)
-	$(call cmd,wrap_initrd,chrp)
-
-$(obj)/zImage.pseries:	vmlinux $(wrapperbits)
-	$(call cmd,wrap,pseries)
-
-$(obj)/zImage.initrd.pseries: vmlinux $(wrapperbits)
-	$(call cmd,wrap_initrd,pseries)
-
-$(obj)/zImage.pmac: vmlinux $(wrapperbits)
-	$(call cmd,wrap,pmac)
-
-$(obj)/zImage.initrd.pmac: vmlinux $(wrapperbits)
-	$(call cmd,wrap_initrd,pmac)
-
-$(obj)/zImage.coff: vmlinux $(wrapperbits)
-	$(call cmd,wrap,pmaccoff)
-
-$(obj)/zImage.initrd.coff: vmlinux $(wrapperbits)
-	$(call cmd,wrap_initrd,pmaccoff)
-
-$(obj)/zImage.miboot: vmlinux $(wrapperbits)
-	$(call cmd,wrap,miboot)
-
-$(obj)/zImage.initrd.miboot: vmlinux $(wrapperbits)
-	$(call cmd,wrap_initrd,miboot)
+      cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+      		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) vmlinux
 
 $(obj)/zImage.ps3: vmlinux
 	$(STRIP) -s -R .comment $< -o $@
@@ -177,6 +146,15 @@ endif
 
 initrd-y := $(patsubst zImage%, zImage.initrd%, $(image-y))
 
+$(addprefix $(obj)/,$(filter-out uImage zImage.ps3,$(image-y))): \
+		$(obj)/zImage.%: vmlinux $(wrapperbits)
+	$(call cmd,wrap,$(patsubst $(obj)/zImage.%,%,$@))
+
+$(addprefix $(obj)/,$(filter-out uImage zImage.initrd.ps3,$(initrd-y))): \
+		$(obj)/zImage.initrd.%: vmlinux $(wrapperbits) \
+		$(obj)/ramdisk.image.gz
+	$(call cmd,wrap_initrd,$(patsubst $(obj)/zImage.initrd.%,%,$@),,,$(obj)/ramdisk.image.gz)
+
 $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 	@rm -f $@; ln $< $@
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
