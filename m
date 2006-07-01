Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C54067A5B
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 09:47:03 +1000 (EST)
Date: Sat, 1 Jul 2006 18:47:00 -0500 (CDT)
Message-Id: <200607012347.k61Nl02a006768@sullivan.realtime.net>
Sender: Milton Miller <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: [5/5][POWERPC] boot: generate lds file from lds.S
References: <kexec-zImage-try2@bga.com>
To: <linuxppc-dev@ozlabs.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The zImage.kexec and zImage.kexec64 linker files are almost identical to
the base elf file.   Use the lds.S -> ld rule to share the source.

Tell the linker the fils is in $(obj) not $(srctree)/$(src)
zImage.coff.lds is different, it links the initrd and kernel in .data
rather than as a seperate section and without alignment, keep it seperate
for now.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2006-07-01 01:41:52.895398201 -0500
+++ kernel/arch/powerpc/boot/Makefile	2006-07-01 01:42:18.569198987 -0500
@@ -81,7 +81,7 @@ quiet_cmd_bootas = BOOTAS  $@
       cmd_bootas = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
 
 quiet_cmd_bootld = BOOTLD  $@
-      cmd_bootld = $(CROSS32LD) -T $(srctree)/$(src)/$(3) -o $@ $(2)
+      cmd_bootld = $(CROSS32LD) -T $(obj)/$(3) -o $@ $(2)
 
 $(patsubst %.c,%.o, $(filter %.c, $(src-mult))): %.o: %.c FORCE
 	$(call if_changed_dep,bootcc)
@@ -108,6 +108,7 @@ hostprogs-y		:= addnote addRamDisk hack-
 targets += zImage.vmode zImage.initrd.vmode zImage zImage.initrd \
 	   zImage.coff zImage.initrd.coff miboot.image miboot.initrd.image \
 	   zImage.kexec zImage.kexec.3264 zImage.kexec64 \
+	   zImage.lds zImage.kexec.lds zImage.kexec64.lds zImage.coff.lds \
 	   $(patsubst $(obj)/%,%, $(call obj-sec, $(required) $(initrd))) \
 	   $(patsubst $(obj)/%,%, $(call src-sec, $(required) $(initrd))) \
 	   $(patsubst $(obj)/%,%, $(call gz-sec, $(required) $(initrd))) \
@@ -168,12 +169,26 @@ $(call obj-sec, $(required) $(initrd)): 
 	$(call cmd,bootcc)
 	$(call cmd,addsection)
 
+lds-fl := -P -C -Upowerpc
+CPPFLAGS_zImage.coff.lds	:= $(lds-fl)
+CPPFLAGS_zImage.lds		:= $(lds-fl) -D__ENTRY__=_zimage_start
+CPPFLAGS_zImage.lds			+= -D__BASE__="4*1024*1024"
+CPPFLAGS_zImage.kexec.lds	:= $(lds-fl) -D__ENTRY__=master -D__BASE__=0
+CPPFLAGS_zImage.kexec64.lds	:= $(lds-fl) -D__ENTRY__=_master64 -D__BASE__=0
+
+$(addprefix $(obj)/, zImage.lds zImage.kexec.lds zImage.kexec64.lds): \
+		$(srctree)/$(src)/zImage.lds.S FORCE
+	$(call if_changed_dep,cpp_lds_S)
+
+$(obj)/zImage.coff.lds:  $(srctree)/$(src)/$zImage.coff.lds.S FORCE
+	$(call if_changed_dep,cpp_lds_S)
+
 $(obj)/zImage.vmode $(obj)/zImage.coff: obj-boot += $(call obj-sec, $(required))
-$(obj)/zImage.vmode: $(call obj-sec, $(required)) $(obj-boot) $(srctree)/$(src)/zImage.lds FORCE
+$(obj)/zImage.vmode: $(call obj-sec, $(required)) $(obj-boot) $(obj)/zImage.lds FORCE
 	$(call if_changed,bootld,$(obj-boot),zImage.lds)
 
 $(obj)/zImage.initrd.vmode $(obj)/zImage.initrd.coff: obj-boot += $(call obj-sec, $(required) $(initrd))
-$(obj)/zImage.initrd.vmode: $(call obj-sec, $(required) $(initrd)) $(obj-boot) $(srctree)/$(src)/zImage.lds FORCE
+$(obj)/zImage.initrd.vmode: $(call obj-sec, $(required) $(initrd)) $(obj-boot) $(obj)/zImage.lds FORCE
 	$(call if_changed,bootld,$(obj-boot),zImage.lds)
 
 # For 32-bit powermacs, build the COFF and miboot images
@@ -196,13 +211,13 @@ kexecimg-$(CONFIG_KEXEC)-y              
 $(obj)/zImage.kexec: $(filter-out $(obj)/zImage.kexec, $(kexecimg-y-y))
 
 $(obj)/zImage.kexec: obj-kexec += $(call obj-sec, $(required))
-$(obj)/zImage.kexec: $(obj-kexec) $(srctree)/$(src)/zImage.kexec.lds \
+$(obj)/zImage.kexec: $(obj-kexec) $(obj)/zImage.kexec.lds \
 		$(call obj-sec, $(required)) FORCE
 	$(call if_changed,bootld,$(obj-kexec),zImage.kexec.lds)
 	@true
 
 $(obj)/zImage.kexec.3264: obj-kexec += $(call obj-sec, $(required))
-$(obj)/zImage.kexec.3264: $(obj-kexec) $(srctree)/$(src)/zImage.kexec64.lds \
+$(obj)/zImage.kexec.3264: $(obj-kexec) $(obj)/zImage.kexec64.lds \
 		$(call obj-sec, $(required)) FORCE
 	$(call if_changed,bootld,$(obj-kexec),zImage.kexec64.lds)
 
@@ -221,12 +236,11 @@ $(obj)/zImage.initrd: $(obj)/zImage.init
 	@true
 
 $(obj)/zImage.coff: $(call obj-sec, $(required)) $(obj-boot) \
-			$(srctree)/$(src)/zImage.coff.lds $(obj)/hack-coff FORCE
+			$(obj)/zImage.coff.lds $(obj)/hack-coff FORCE
 	$(call if_changed_rule,ldcoff,$(obj-boot),zImage.coff.lds)
 
 $(obj)/zImage.initrd.coff: $(call obj-sec, $(required) $(initrd)) $(obj-boot) \
-			   $(srctree)/$(src)/zImage.coff.lds $(obj)/hack-coff \
-			   FORCE
+			   $(obj)/zImage.coff.lds $(obj)/hack-coff FORCE
 	$(call if_changed_rule,ldcoff,$(obj-boot),zImage.coff.lds)
 
 $(obj)/miboot.image: $(obj)/dummy.o $(obj)/vmlinux.gz FORCE
Index: kernel/arch/powerpc/boot/zImage.coff.lds
===================================================================
--- kernel.orig/arch/powerpc/boot/zImage.coff.lds	2006-07-01 01:40:22.406990413 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,46 +0,0 @@
-OUTPUT_ARCH(powerpc:common)
-ENTRY(_start)
-SECTIONS
-{
-  . = (5*1024*1024);
-  _start = .;
-  .text      :
-  {
-    *(.text)
-    *(.fixup)
-  }
-  _etext = .;
-  . = ALIGN(4096);
-  .data    :
-  {
-    *(.rodata*)
-    *(.data*)
-    *(.sdata*)
-    __got2_start = .;
-    *(.got2)
-    __got2_end = .;
-
-    _vmlinux_start =  .;
-    *(.kernel:vmlinux.strip)
-    _vmlinux_end =  .;
-
-    _initrd_start =  .;
-    *(.kernel:initrd)
-    _initrd_end =  .;
-  }
-
-  . = ALIGN(4096);
-  _edata  =  .;
-  __bss_start = .;
-  .bss       :
-  {
-   *(.sbss)
-   *(.bss)
-  }
-  _end = . ;
-
-  /DISCARD/ :
-  {
-    *(.comment)
-  }
-}
Index: kernel/arch/powerpc/boot/zImage.coff.lds.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/zImage.coff.lds.S	2006-07-01 01:42:18.572198512 -0500
@@ -0,0 +1,46 @@
+OUTPUT_ARCH(powerpc:common)
+ENTRY(_start)
+SECTIONS
+{
+  . = (5*1024*1024);
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
+
+    _vmlinux_start =  .;
+    *(.kernel:vmlinux.strip)
+    _vmlinux_end =  .;
+
+    _initrd_start =  .;
+    *(.kernel:initrd)
+    _initrd_end =  .;
+  }
+
+  . = ALIGN(4096);
+  _edata  =  .;
+  __bss_start = .;
+  .bss       :
+  {
+   *(.sbss)
+   *(.bss)
+  }
+  _end = . ;
+
+  /DISCARD/ :
+  {
+    *(.comment)
+  }
+}
Index: kernel/arch/powerpc/boot/zImage.kexec.lds
===================================================================
--- kernel.orig/arch/powerpc/boot/zImage.kexec.lds	2006-07-01 01:40:22.459982024 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,51 +0,0 @@
-OUTPUT_ARCH(powerpc:common)
-ENTRY(master)
-SECTIONS
-{
-  . = 0;
-  _start = .;
-  .text      :
-  {
-    *(.text)
-    *(.fixup)
-  }
-  _etext = .;
-  . = ALIGN(4096);
-  .data    :
-  {
-    *(.rodata*)
-    *(.data*)
-    *(.sdata*)
-    __got2_start = .;
-    *(.got2)
-    __got2_end = .;
-  }
-
-  . = ALIGN(4096);
-  _vmlinux_start =  .;
-  .kernel:vmlinux.strip : { *(.kernel:vmlinux.strip) }
-  _vmlinux_end =  .;
-
-  . = ALIGN(4096);
-  _initrd_start =  .;
-  .kernel:initrd : { *(.kernel:initrd) }
-  _initrd_end =  .;
-
-  . = ALIGN(4096);
-  _edata  =  .;
-
-  . = ALIGN(4096);
-  __stack_start =  .;
-  .stack : { *(.stack) }
-  __stack_end =  .;
-
-  . = ALIGN(4096);
-  __bss_start = .;
-  .bss       :
-  {
-   *(.sbss)
-   *(.bss)
-  }
-  . = ALIGN(4096);
-  _end = . ;
-}
Index: kernel/arch/powerpc/boot/zImage.kexec64.lds
===================================================================
--- kernel.orig/arch/powerpc/boot/zImage.kexec64.lds	2006-07-01 01:40:22.487977592 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,52 +0,0 @@
-OUTPUT_ARCH(powerpc:common)
-ENTRY(_master64)
-SECTIONS
-{
-  . = 0;
-  _start = .;
-  .text      :
-  {
-    *(.text)
-    *(.fixup)
-  }
-  _etext = .;
-  . = ALIGN(4096);
-  .data    :
-  {
-    *(.rodata*)
-    *(.data*)
-    *(.sdata*)
-    __got2_start = .;
-    *(.got2)
-    __got2_end = .;
-  }
-
-  . = ALIGN(4096);
-  _vmlinux_start =  .;
-  .kernel:vmlinux.strip : { *(.kernel:vmlinux.strip) }
-  _vmlinux_end =  .;
-
-  . = ALIGN(4096);
-  _initrd_start =  .;
-  .kernel:initrd : { *(.kernel:initrd) }
-  _initrd_end =  .;
-
-  . = ALIGN(4096);
-  _edata  =  .;
-
-  . = ALIGN(4096);
-  __stack_start =  .;
-  .stack : { *(.stack) }
-  __stack_end =  .;
-
-  . = ALIGN(4096);
-  __bss_start = .;
-  .bss       :
-  {
-   *(.sbss)
-   *(.bss)
-  }
-  . = ALIGN(4096);
-  _end = . ;
-}
-
Index: kernel/arch/powerpc/boot/zImage.lds
===================================================================
--- kernel.orig/arch/powerpc/boot/zImage.lds	2006-07-01 01:40:22.516973001 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,46 +0,0 @@
-OUTPUT_ARCH(powerpc:common)
-ENTRY(_zimage_start)
-SECTIONS
-{
-  . = (4*1024*1024);
-  _start = .;
-  .text      :
-  {
-    *(.text)
-    *(.fixup)
-  }
-  _etext = .;
-  . = ALIGN(4096);
-  .data    :
-  {
-    *(.rodata*)
-    *(.data*)
-    *(.sdata*)
-    __got2_start = .;
-    *(.got2)
-    __got2_end = .;
-  }
-
-  . = ALIGN(4096);
-  _vmlinux_start =  .;
-  .kernel:vmlinux.strip : { *(.kernel:vmlinux.strip) }
-  _vmlinux_end =  .;
-
-  . = ALIGN(4096);
-  _initrd_start =  .;
-  .kernel:initrd : { *(.kernel:initrd) }
-  _initrd_end =  .;
-
-  . = ALIGN(4096);
-  _edata  =  .;
-
-  . = ALIGN(4096);
-  __bss_start = .;
-  .bss       :
-  {
-   *(.sbss)
-   *(.bss)
-  }
-  . = ALIGN(4096);
-  _end = . ;
-}
Index: kernel/arch/powerpc/boot/zImage.lds.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/zImage.lds.S	2006-07-01 01:42:18.576197879 -0500
@@ -0,0 +1,51 @@
+OUTPUT_ARCH(powerpc:common)
+ENTRY(__ENTRY__)
+SECTIONS
+{
+  . = __BASE__;
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
