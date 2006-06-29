Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D69967B6A
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 23:44:59 +1000 (EST)
Date: Thu, 29 Jun 2006 08:26:47 -0500 (CDT)
Message-Id: <200606291326.k5TDQl7X098179@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: [3/5][POWERPC] boot: use more Kbuild rules
To: <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Switch to if_changed_dep for bootcc, cmd for known rebuilds without deps,
and if_changed for other commands.  Add FORCE for all if_changed rule uses.
Make sure targets includes all generated files.

Move clean-files to targets for if_changed files.

Rename OBJCOPYFLAGS to OBJCOPY_SEC_FLAGS so we can use $(objcopy) rule.

Rename zliblinuxheader to linuxheader

Remove explicit dependency of zlib files on zlib headers (if_changed_dep).
Oops, kelace with all sources depend on generated headers, as the
dependancy files don't exist on a clean compile.

Note: the obj-sec .c files are created/touched when the content file changes.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2006-06-29 03:47:01.063847526 -0500
+++ kernel/arch/powerpc/boot/Makefile	2006-06-29 06:01:36.507278027 -0500
@@ -25,16 +25,13 @@ HOSTCC		:= gcc
 BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem \
 		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
-OBJCOPYFLAGS    := contents,alloc,load,readonly,data
+OBJCOPY_SEC_FLAGS := contents,alloc,load,readonly,data
 OBJCOPY_COFF_ARGS := -O aixcoff-rs6000 --set-start 0x500000
 OBJCOPY_MIB_ARGS  := -O aixcoff-rs6000 -R .stab -R .stabstr -R .comment
 
 zlib       := infblock.c infcodes.c inffast.c inflate.c inftrees.c infutil.c
 zlibheader := infblock.h infcodes.h inffast.h inftrees.h infutil.h
-zliblinuxheader := zlib.h zconf.h zutil.h
-
-$(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
-#$(addprefix $(obj)/,main.o): $(addprefix $(obj)/,zlib.h)
+linuxheader := zlib.h zconf.h zutil.h
 
 src-boot := crt0.S string.S prom.c stdio.c main.c div64.S
 src-boot += $(zlib)
@@ -48,21 +45,26 @@ quiet_cmd_copy_zlib = COPY    $@
 
 quiet_cmd_copy_zlibheader = COPY    $@
       cmd_copy_zlibheader = sed "s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
+
 # stddef.h for NULL
-quiet_cmd_copy_zliblinuxheader = COPY    $@
-      cmd_copy_zliblinuxheader = sed "s@<linux/string.h>@\"string.h\"@;s@<linux/kernel.h>@<stddef.h>@;s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
+quiet_cmd_copy_linuxheader = COPY    $@
+      cmd_copy_linuxheader = sed "s@<linux/string.h>@\"string.h\"@;s@<linux/kernel.h>@<stddef.h>@;s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
 
-$(addprefix $(obj)/,$(zlib)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
-	$(call cmd,copy_zlib)
+$(addprefix $(obj)/,$(zlib)): $(obj)/%: $(srctree)/lib/zlib_inflate/% FORCE
+	$(call if_changed,copy_zlib)
 
-$(addprefix $(obj)/,$(zlibheader)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
-	$(call cmd,copy_zlibheader)
+$(addprefix $(obj)/,$(zlibheader)): $(obj)/%: $(srctree)/lib/zlib_inflate/% \
+		FORCE
+	$(call if_changed,copy_zlibheader)
 
-$(addprefix $(obj)/,$(zliblinuxheader)): $(obj)/%: $(srctree)/include/linux/%
-	$(call cmd,copy_zliblinuxheader)
+$(addprefix $(obj)/,$(linuxheader)): $(obj)/%: $(srctree)/include/linux/% FORCE
+	$(call if_changed,copy_linuxheader)
 
-clean-files := $(zlib) $(zlibheader) $(zliblinuxheader)
+targets += $(zlib) $(zlibheader) $(linuxheader)
+targets += $(patsubst $(obj)/%,%, $(obj-boot))
 
+# copy all headers before trying to build objects
+$(obj-boot):  $(addprefix $(obj)/,$(linuxheader) $(zlibheader))
 
 quiet_cmd_bootcc = BOOTCC  $@
       cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
@@ -73,9 +75,10 @@ quiet_cmd_bootas = BOOTAS  $@
 quiet_cmd_bootld = BOOTLD  $@
       cmd_bootld = $(CROSS32LD) -T $(srctree)/$(src)/$(3) -o $@ $(2)
 
-$(patsubst %.c,%.o, $(filter %.c, $(src-boot))): %.o: %.c
+$(patsubst %.c,%.o, $(filter %.c, $(src-boot))): %.o: %.c FORCE
 	$(call if_changed_dep,bootcc)
-$(patsubst %.S,%.o, $(filter %.S, $(src-boot))): %.o: %.S
+
+$(patsubst %.S,%.o, $(filter %.S, $(src-boot))): %.o: %.S FORCE
 	$(call if_changed_dep,bootas)
 
 #-----------------------------------------------------------
@@ -104,15 +107,16 @@ quiet_cmd_ramdisk = RAMDISK $@
 quiet_cmd_stripvm = STRIP   $@
       cmd_stripvm = $(STRIP) -s -R .comment $< -o $@
 
-vmlinux.strip: vmlinux
+vmlinux.strip: vmlinux FORCE
 	$(call if_changed,stripvm)
-$(obj)/vmlinux.initrd: vmlinux.strip $(obj)/addRamDisk $(obj)/ramdisk.image.gz
+$(obj)/vmlinux.initrd: vmlinux.strip $(obj)/addRamDisk \
+		$(obj)/ramdisk.image.gz FORCE
 	$(call if_changed,ramdisk)
 
 quiet_cmd_addsection = ADDSEC  $@
       cmd_addsection = $(CROSS32OBJCOPY) $@ \
 		--add-section=.kernel:$(strip $(patsubst $(obj)/kernel-%.o,%, $@))=$(patsubst %.o,%.gz, $@) \
-		--set-section-flags=.kernel:$(strip $(patsubst $(obj)/kernel-%.o,%, $@))=$(OBJCOPYFLAGS)
+		--set-section-flags=.kernel:$(strip $(patsubst $(obj)/kernel-%.o,%, $@))=$(OBJCOPY_SEC_FLAGS)
 
 quiet_cmd_addnote = ADDNOTE $@
       cmd_addnote = $(obj)/addnote $@
@@ -125,7 +129,13 @@ quiet_cmd_gencoff = COFF    $@
       cmd_gencoff = $(OBJCOPY) $(OBJCOPY_COFF_ARGS) $@ && \
 		    $(obj)/hack-coff $@
 
-$(call gz-sec, $(required)): $(obj)/kernel-%.gz: %
+# $(required) is built in $(objtree) not $(obj) so read cmd files manually
+cmd_files := $(wildcard $(foreach f,$(required),$(dir $(f)).$(notdir $(f)).cmd))
+ifneq ($(cmd_files),)
+  include $(cmd_files)
+endif
+
+$(call gz-sec, $(required)): $(obj)/kernel-%.gz: % FORCE
 	$(call if_changed,gzip)
 
 $(obj)/kernel-initrd.gz: $(obj)/ramdisk.image.gz
@@ -135,7 +145,7 @@ $(call src-sec, $(required) $(initrd)): 
 	@touch $@
 
 $(call obj-sec, $(required) $(initrd)): $(obj)/kernel-%.o: $(obj)/kernel-%.c
-	$(call if_changed_dep,bootcc)
+	$(call cmd,bootcc)
 	$(call cmd,addsection)
 
 $(obj)/zImage.vmode $(obj)/zImage.coff: obj-boot += $(call obj-sec, $(required))
@@ -156,12 +166,12 @@ mibrdimg-$(CONFIG_PPC_PMAC)-$(CONFIG_PPC
 $(obj)/zImage: $(obj)/zImage.vmode $(obj)/addnote $(coffimage-y-y) \
 			$(mibootimg-y-y)
 	@cp -f $< $@
-	$(call if_changed,addnote)
+	$(call cmd,addnote)
 
 $(obj)/zImage.initrd: $(obj)/zImage.initrd.vmode $(obj)/addnote \
 			$(coffrdimg-y-y) $(mibrdimg-y-y)
 	@cp -f $< $@
-	$(call if_changed,addnote)
+	$(call cmd,addnote)
 
 $(obj)/zImage.coff: $(call obj-sec, $(required)) $(obj-boot) \
 			$(srctree)/$(src)/zImage.coff.lds $(obj)/hack-coff
