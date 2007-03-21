Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4084DDE128
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:03:14 +1100 (EST)
Received: from sullivan.realtime.net (localhost [127.0.0.1])
	by sullivan.realtime.net (8.13.1/8.9.3) with ESMTP id l2LF3A5N008522
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 09:03:10 -0600 (CST)
	(envelope-from miltonm@sullivan.realtime.net)
Received: (from miltonm@localhost)
	by sullivan.realtime.net (8.13.1/8.12.7/Submit) id l2LF3APO008521
	for linuxppc-dev@ozlabs.org; Wed, 21 Mar 2007 09:03:10 -0600 (CST)
Date: Wed, 21 Mar 2007 09:03:10 -0600 (CST)
Subject: [PATCH 7/8] boot: clean rule fixes
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-2-07.miltonm@bga.com>
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

Now that obj-boot is in targets, we can remove (twice) it from clean-files.
zImage.initrd was missing, move zImage nearer where its used, and place
zImage.initrd next to it.  Remove non-ported zImage.sandpoint, and add 
auto-generation of unconfigured zImage.initrd* like image-.

Signed-off-by: Milton Miller <miltonm@bga.com>
--
Testing: did a few builds and cleans

Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-03-21 03:14:53.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-03-21 03:27:37.000000000 -0500
@@ -76,7 +76,7 @@ $(obj)/zImage.lds $(obj)/zImage.coff.lds
 	@cp $< $@
 
 clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
-		empty.c zImage zImage.coff.lds zImage.lds zImage.sandpoint
+		empty.c zImage.coff.lds zImage.lds
 
 quiet_cmd_bootcc = BOOTCC  $@
       cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
@@ -177,6 +177,7 @@ ifeq ($(CONFIG_PPC32),y)
 image-$(CONFIG_PPC_PMAC)	+= zImage.coff zImage.miboot
 endif
 
+initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-))
 initrd-y := $(patsubst zImage%, zImage.initrd%, $(image-y))
 targets	+= $(image-y) $(initrd-y)
 
@@ -188,6 +189,5 @@ $(obj)/zImage.initrd:	$(addprefix $(obj)
 install: $(CONFIGURE) $(image-y)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
-clean-files += $(addprefix $(objtree)/, $(obj-boot) vmlinux.strip.gz)
-clean-files += $(addprefix $(objtree)/, $(obj-boot) vmlinux.bin.gz)
-clean-files += $(image-)
+clean-files += $(addprefix $(objtree)/, vmlinux.strip.gz vmlinux.bin.gz)
+clean-files += $(image-) $(initrd-) zImage zImage.initrd
