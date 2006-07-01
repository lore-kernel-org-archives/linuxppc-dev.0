Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DE8B67B99
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 09:46:57 +1000 (EST)
Date: Sat, 1 Jul 2006 18:46:53 -0500 (CDT)
Message-Id: <200607012346.k61Nkrw7006766@sullivan.realtime.net>
Sender: Milton Miller <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: [4/5][POWERPC] boot: Makefile and linker scripts for zImage.kexec
References: <kexec-zImage-try2@bga.com>
To: <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Makefile and linker script changes to build zImage.kexec

This patch is based after the if_changed_dep patch.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2006-07-01 01:33:55.937370129 -0500
+++ kernel/arch/powerpc/boot/Makefile	2006-07-01 01:41:52.895398201 -0500
@@ -32,12 +32,22 @@ OBJCOPY_MIB_ARGS  := -O aixcoff-rs6000 -
 zlib       := infblock.c infcodes.c inffast.c inflate.c inftrees.c infutil.c
 zlibheader := infblock.h infcodes.h inffast.h inftrees.h infutil.h
 linuxheader := zlib.h zconf.h zutil.h
+linuxheader += stringify.h
 
-src-boot := crt0.S string.S prom.c stdio.c main.c div64.S
-src-boot += $(zlib)
+src-common := string.S stdio.c main.c div64.S
+src-common += $(zlib)
+
+src-boot := crt0.S prom.c  $(src-common)
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
 
+src-kexec := crt0_kexec.S kexec.c $(src-common)
+src-kexec := $(addprefix $(obj)/, $(src-kexec))
+obj-kexec := $(addsuffix .o, $(basename $(src-kexec)))
+
+src-mult := $(sort $(src-boot) $(src-kexec))
+obj-mult := $(sort $(obj-boot) $(obj-kexec))
+
 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
 
 quiet_cmd_copy_zlib = COPY    $@
@@ -61,7 +71,7 @@ $(addprefix $(obj)/,$(linuxheader)): $(o
 	$(call if_changed,copy_linuxheader)
 
 targets += $(zlib) $(zlibheader) $(linuxheader)
-targets += $(patsubst $(obj)/%,%, $(obj-boot))
+targets += $(patsubst $(obj)/%,%, $(obj-mult))
 
 
 quiet_cmd_bootcc = BOOTCC  $@
@@ -73,10 +83,10 @@ quiet_cmd_bootas = BOOTAS  $@
 quiet_cmd_bootld = BOOTLD  $@
       cmd_bootld = $(CROSS32LD) -T $(srctree)/$(src)/$(3) -o $@ $(2)
 
-$(patsubst %.c,%.o, $(filter %.c, $(src-boot))): %.o: %.c FORCE
+$(patsubst %.c,%.o, $(filter %.c, $(src-mult))): %.o: %.c FORCE
 	$(call if_changed_dep,bootcc)
 
-$(patsubst %.S,%.o, $(filter %.S, $(src-boot))): %.o: %.S FORCE
+$(patsubst %.S,%.o, $(filter %.S, $(src-mult))): %.o: %.S FORCE
 	$(call if_changed_dep,bootas)
 
 $(obj-boot):  COPYHEADERS
@@ -97,6 +107,7 @@ hostprogs-y		:= addnote addRamDisk hack-
 
 targets += zImage.vmode zImage.initrd.vmode zImage zImage.initrd \
 	   zImage.coff zImage.initrd.coff miboot.image miboot.initrd.image \
+	   zImage.kexec zImage.kexec.3264 zImage.kexec64 \
 	   $(patsubst $(obj)/%,%, $(call obj-sec, $(required) $(initrd))) \
 	   $(patsubst $(obj)/%,%, $(call src-sec, $(required) $(initrd))) \
 	   $(patsubst $(obj)/%,%, $(call gz-sec, $(required) $(initrd))) \
@@ -121,7 +132,7 @@ quiet_cmd_addsection = ADDSEC  $@
 		--set-section-flags=.kernel:$(strip $(patsubst $(obj)/kernel-%.o,%, $@))=$(OBJCOPY_SEC_FLAGS)
 
 quiet_cmd_addnote = ADDNOTE $@
-      cmd_addnote = @cp -f $< $@ && \
+      cmd_addnote = cp -f $< $@ && \
 		    $(obj)/addnote $@
 
 quiet_cmd_gen-miboot = GEN     $@
@@ -172,8 +183,35 @@ coffrdimg-$(CONFIG_PPC_PMAC)-$(CONFIG_PP
 mibootimg-$(CONFIG_PPC_PMAC)-$(CONFIG_PPC32) := $(obj)/miboot.image
 mibrdimg-$(CONFIG_PPC_PMAC)-$(CONFIG_PPC32)  := $(obj)/miboot.initrd.image
 
+# The kexec entry point is valid for all kernels.  This zImage should work
+# on all loaders (kexec or firmware) that do not use an openfirmware prom
+# callback, assuming the memory node constraints are met.
+#
+# Build if CONFIG_KEXEC=y or on master make zImage.kexec.
+#
+kexecimg-$(CONFIG_KEXEC)-$(CONFIG_PPC64) += $(obj)/zImage.kexec64
+kexecimg-$(CONFIG_KEXEC)-y               += $(obj)/zImage.kexec
+
+# Build 64 bit and 32 bit package when 64 bit kernel is being built
+$(obj)/zImage.kexec: $(filter-out $(obj)/zImage.kexec, $(kexecimg-y-y))
+
+$(obj)/zImage.kexec: obj-kexec += $(call obj-sec, $(required))
+$(obj)/zImage.kexec: $(obj-kexec) $(srctree)/$(src)/zImage.kexec.lds \
+		$(call obj-sec, $(required)) FORCE
+	$(call if_changed,bootld,$(obj-kexec),zImage.kexec.lds)
+	@true
+
+$(obj)/zImage.kexec.3264: obj-kexec += $(call obj-sec, $(required))
+$(obj)/zImage.kexec.3264: $(obj-kexec) $(srctree)/$(src)/zImage.kexec64.lds \
+		$(call obj-sec, $(required)) FORCE
+	$(call if_changed,bootld,$(obj-kexec),zImage.kexec64.lds)
+
+OBJCOPYFLAGS_zImage.kexec64 := -I elf32-powerpc -O elf64-powerpc
+$(obj)/zImage.kexec64: $(obj)/zImage.kexec.3264 FORCE
+	$(call if_changed,objcopy,$< $@)
+
 $(obj)/zImage: $(obj)/zImage.vmode $(obj)/addnote $(coffimage-y-y) \
-			$(mibootimg-y-y) FORCE
+			$(mibootimg-y-y) $(kexecimg-y-y) FORCE
 	$(call if_changed,addnote)
 	@true
 
@@ -231,4 +269,4 @@ $(obj)/uImage: $(obj)/vmlinux.gz
 install: $(CONFIGURE) $(BOOTIMAGE)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" "$(BOOTIMAGE)"
 
-clean-files += $(addprefix $(objtree)/, $(obj-boot) vmlinux.strip)
+clean-files += $(addprefix $(objtree)/, $(obj-mult) vmlinux.strip)
Index: kernel/arch/powerpc/Makefile
===================================================================
--- kernel.orig/arch/powerpc/Makefile	2006-07-01 01:30:31.108598026 -0500
+++ kernel/arch/powerpc/Makefile	2006-07-01 01:34:26.665172415 -0500
@@ -147,7 +147,7 @@ all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm uImage vmlinux.bin
+BOOT_TARGETS = zImage zImage.initrd zImage.kexec znetboot znetboot.initrd vmlinux.sm uImage vmlinux.bin
 
 PHONY += $(BOOT_TARGETS)
 
Index: kernel/arch/powerpc/boot/zImage.kexec.lds
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/zImage.kexec.lds	2006-07-01 01:40:22.459982024 -0500
@@ -0,0 +1,51 @@
+OUTPUT_ARCH(powerpc:common)
+ENTRY(master)
+SECTIONS
+{
+  . = 0;
+  _start = .;
+  .text      :
+  {
+    *(.text)
+    *(.fixup)
+  }
+  _etext = .;
+  . = ALIGN(4096);
+  .data    :
+  {
+    *(.rodata*)
+    *(.data*)
+    *(.sdata*)
+    __got2_start = .;
+    *(.got2)
+    __got2_end = .;
+  }
+
+  . = ALIGN(4096);
+  _vmlinux_start =  .;
+  .kernel:vmlinux.strip : { *(.kernel:vmlinux.strip) }
+  _vmlinux_end =  .;
+
+  . = ALIGN(4096);
+  _initrd_start =  .;
+  .kernel:initrd : { *(.kernel:initrd) }
+  _initrd_end =  .;
+
+  . = ALIGN(4096);
+  _edata  =  .;
+
+  . = ALIGN(4096);
+  __stack_start =  .;
+  .stack : { *(.stack) }
+  __stack_end =  .;
+
+  . = ALIGN(4096);
+  __bss_start = .;
+  .bss       :
+  {
+   *(.sbss)
+   *(.bss)
+  }
+  . = ALIGN(4096);
+  _end = . ;
+}
Index: kernel/arch/powerpc/boot/zImage.kexec64.lds
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/zImage.kexec64.lds	2006-07-01 01:40:22.487977592 -0500
@@ -0,0 +1,52 @@
+OUTPUT_ARCH(powerpc:common)
+ENTRY(_master64)
+SECTIONS
+{
+  . = 0;
+  _start = .;
+  .text      :
+  {
+    *(.text)
+    *(.fixup)
+  }
+  _etext = .;
+  . = ALIGN(4096);
+  .data    :
+  {
+    *(.rodata*)
+    *(.data*)
+    *(.sdata*)
+    __got2_start = .;
+    *(.got2)
+    __got2_end = .;
+  }
+
+  . = ALIGN(4096);
+  _vmlinux_start =  .;
+  .kernel:vmlinux.strip : { *(.kernel:vmlinux.strip) }
+  _vmlinux_end =  .;
+
+  . = ALIGN(4096);
+  _initrd_start =  .;
+  .kernel:initrd : { *(.kernel:initrd) }
+  _initrd_end =  .;
+
+  . = ALIGN(4096);
+  _edata  =  .;
+
+  . = ALIGN(4096);
+  __stack_start =  .;
+  .stack : { *(.stack) }
+  __stack_end =  .;
+
+  . = ALIGN(4096);
+  __bss_start = .;
+  .bss       :
+  {
+   *(.sbss)
+   *(.bss)
+  }
+  . = ALIGN(4096);
+  _end = . ;
+}
+
