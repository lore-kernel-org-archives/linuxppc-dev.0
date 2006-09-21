Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17682.28743.743974.786724@cargo.ozlabs.ibm.com>
Date: Thu, 21 Sep 2006 20:58:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH] Create a "wrapper" script and use it in arch/powerpc/boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This puts the knowledge of how to create various sorts of zImage
wrappers into a script called "wrapper" that could be used outside of
the kernel tree.  This also changes arch/powerpc/boot so it first
builds the files that the wrapper script needs, then runs it to create
whatever flavours of zImage are required.

I haven't merged the uImage building stuff into this framework yet -
somebody want to send me a patch to do that?

Also, this probably doesn't do the right thing for maple, cell, etc.

Another point to note is that this renames the images: the one for
pSeries is called zImage.pseries rather than zImage, and the one for
powermacs is now zImage.pmac rather than zImage.vmode.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 01667d1..2bfb7ee 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -20,6 +20,7 @@ CROSS32_COMPILE ?=
 CROSS32CC		:= $(CROSS32_COMPILE)gcc
 CROSS32AS		:= $(CROSS32_COMPILE)as
 CROSS32LD		:= $(CROSS32_COMPILE)ld
+CROSS32AR		:= $(CROSS32_COMPILE)ar
 CROSS32OBJCOPY		:= $(CROSS32_COMPILE)objcopy
 
 ifeq ($(HAS_BIARCH),y)
@@ -28,10 +29,11 @@ CROSS32CC	:= $(CC) -m32
 CROSS32AS	:= $(AS) -a32
 CROSS32LD	:= $(LD) -m elf32ppc
 CROSS32OBJCOPY	:= $(OBJCOPY)
+CROSS32AR	:= $(AR)
 endif
 endif
 
-export CROSS32CC CROSS32AS CROSS32LD CROSS32OBJCOPY
+export CROSS32CC CROSS32AS CROSS32LD CROSS32AR CROSS32OBJCOPY
 
 KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e737741..95b0cdf 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -20,33 +20,34 @@ #	To make it easier to setup a cross com
 #	CROSS32_COMPILE is setup as a prefix just like CROSS_COMPILE
 #	in the toplevel makefile.
 
+all: $(obj)/zImage
 
 HOSTCC		:= gcc
 BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem \
 		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
-OBJCOPYFLAGS    := contents,alloc,load,readonly,data
-OBJCOPY_COFF_ARGS := -O aixcoff-rs6000 --set-start 0x500000
-OBJCOPY_MIB_ARGS  := -O aixcoff-rs6000 -R .stab -R .stabstr -R .comment
+
+ifeq ($(call cc-option-yn, -fstack-protector),y)
+BOOTCFLAGS	+= -fno-stack-protector
+endif
+
+BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
 
 zlib       := inffast.c inflate.c inftrees.c
 zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h
 zliblinuxheader := zlib.h zconf.h zutil.h
 
-$(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
-#$(addprefix $(obj)/,main.o): $(addprefix $(obj)/,zlib.h)
+$(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) \
+		$(addprefix $(obj)/,$(zlibheader))
+
+src-wlib := string.S stdio.c main.c div64.S $(zlib)
+src-plat := of.c
+src-boot := crt0.S $(src-wlib) $(src-plat) empty.c
 
-src-boot-$(CONFIG_PPC_MULTIPLATFORM) := of.c
-src-boot := crt0.S string.S stdio.c main.c div64.S $(src-boot-y)
-src-boot += $(zlib)
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
-
-ifeq ($(call cc-option-yn, -fstack-protector),y)
-BOOTCFLAGS	+= -fno-stack-protector
-endif
-
-BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
+obj-wlib := $(addsuffix .o, $(basename $(addprefix $(obj)/, $(src-wlib))))
+obj-plat := $(addsuffix .o, $(basename $(addprefix $(obj)/, $(src-plat))))
 
 quiet_cmd_copy_zlib = COPY    $@
       cmd_copy_zlib = sed "s@__attribute_used__@@;s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
@@ -66,8 +67,14 @@ quiet_cmd_copy_zliblinuxheader = COPY   
 $(addprefix $(obj)/,$(zliblinuxheader)): $(obj)/%: $(srctree)/include/linux/%
 	$(call cmd,copy_zliblinuxheader)
 
-clean-files := $(zlib) $(zlibheader) $(zliblinuxheader)
+$(obj)/empty.c:
+	@touch $@
 
+$(obj)/zImage.lds $(obj)/zImage.coff.lds: $(obj)/%: $(srctree)/$(src)/%.S
+	@cp $< $@
+
+clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
+		$(obj)/empty.c
 
 quiet_cmd_bootcc = BOOTCC  $@
       cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
@@ -75,114 +82,86 @@ quiet_cmd_bootcc = BOOTCC  $@
 quiet_cmd_bootas = BOOTAS  $@
       cmd_bootas = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
 
-quiet_cmd_bootld = BOOTLD  $@
-      cmd_bootld = $(CROSS32LD) -T $(srctree)/$(src)/$(3) -o $@ $(2)
+quiet_cmd_bootar = BOOTAR  $@
+      cmd_bootar = $(CROSS32AR) -cr $@.$$$$ $^; mv $@.$$$$ $@
 
 $(patsubst %.c,%.o, $(filter %.c, $(src-boot))): %.o: %.c
 	$(call if_changed_dep,bootcc)
 $(patsubst %.S,%.o, $(filter %.S, $(src-boot))): %.o: %.S
 	$(call if_changed_dep,bootas)
 
-#-----------------------------------------------------------
-# ELF sections within the zImage bootloader/wrapper
-#-----------------------------------------------------------
-required := vmlinux.strip
-initrd   := initrd
+$(obj)/wrapper.a: $(obj-wlib)
+	$(call cmd,bootar)
 
-obj-sec = $(foreach section, $(1), $(patsubst %,$(obj)/kernel-%.o, $(section)))
-src-sec = $(foreach section, $(1), $(patsubst %,$(obj)/kernel-%.c, $(section)))
-gz-sec  = $(foreach section, $(1), $(patsubst %,$(obj)/kernel-%.gz, $(section)))
+hostprogs-y	:= addnote addRamDisk hack-coff
 
-hostprogs-y		:= addnote addRamDisk hack-coff
+extra-y		:= $(obj)/crt0.o $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
+		   $(obj)/zImage.lds $(obj)/zImage.coff.lds
 
-targets += zImage.vmode zImage.initrd.vmode zImage zImage.initrd \
-	   zImage.coff zImage.initrd.coff miboot.image miboot.initrd.image \
-	   $(patsubst $(obj)/%,%, $(call obj-sec, $(required) $(initrd))) \
-	   $(patsubst $(obj)/%,%, $(call src-sec, $(required) $(initrd))) \
-	   $(patsubst $(obj)/%,%, $(call gz-sec, $(required) $(initrd))) \
-	   vmlinux.initrd dummy.o
-extra-y			:= initrd.o
+wrapper		:=$(srctree)/$(src)/wrapper
+wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff)
 
-quiet_cmd_ramdisk = RAMDISK $@
-      cmd_ramdisk = $(obj)/addRamDisk $(obj)/ramdisk.image.gz $< $@
+#############
+# Bits for building various flavours of zImage
 
-quiet_cmd_stripvm = STRIP   $@
-      cmd_stripvm = $(STRIP) -s -R .comment $< -o $@
+ifneq ($(CROSS32_COMPILE),)
+CROSSWRAP := -C $(CROSS32_COMPILE)
+else
+ifneq ($(CROSS_COMPILE),)
+CROSSWRAP := -C $(CROSS_COMPILE)
+endif
+endif
 
-vmlinux.strip: vmlinux
-	$(call if_changed,stripvm)
-$(obj)/vmlinux.initrd: vmlinux.strip $(obj)/addRamDisk $(obj)/ramdisk.image.gz
-	$(call if_changed,ramdisk)
+quiet_cmd_wrap	= WRAP    $@
+      cmd_wrap	=$(wrapper) -c -o $@ -p $2 $(CROSSWRAP) vmlinux
+quiet_cmd_wrap_initrd = WRAP    $@
+      cmd_wrap_initrd =$(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+				-i $(obj)/ramdisk.image.gz vmlinux
 
-quiet_cmd_addsection = ADDSEC  $@
-      cmd_addsection = $(CROSS32OBJCOPY) $@ \
-		--add-section=.kernel:$(strip $(patsubst $(obj)/kernel-%.o,%, $@))=$(patsubst %.o,%.gz, $@) \
-		--set-section-flags=.kernel:$(strip $(patsubst $(obj)/kernel-%.o,%, $@))=$(OBJCOPYFLAGS)
+$(obj)/zImage.chrp: vmlinux $(wrapperbits)
+	$(call cmd,wrap,chrp)
 
-quiet_cmd_addnote = ADDNOTE $@
-      cmd_addnote = $(obj)/addnote $@
+$(obj)/zImage.initrd.chrp: vmlinux $(wrapperbits)
+	$(call cmd,wrap_initrd,chrp)
 
-quiet_cmd_gen-miboot = GEN     $@
-      cmd_gen-miboot = $(OBJCOPY) $(OBJCOPY_MIB_ARGS) \
-		       --add-section=$1=$(word 2, $^) $< $@
+$(obj)/zImage.pseries:	vmlinux $(wrapperbits)
+	$(call cmd,wrap,pseries)
 
-quiet_cmd_gencoff = COFF    $@
-      cmd_gencoff = $(OBJCOPY) $(OBJCOPY_COFF_ARGS) $@ && \
-		    $(obj)/hack-coff $@
+$(obj)/zImage.initrd.pseries: vmlinux $(wrapperbits)
+	$(call cmd,wrap_initrd,pseries)
 
-$(call gz-sec, $(required)): $(obj)/kernel-%.gz: %
-	$(call if_changed,gzip)
+$(obj)/zImage.pmac: vmlinux $(wrapperbits)
+	$(call cmd,wrap,pmac)
 
-$(obj)/kernel-initrd.gz: $(obj)/ramdisk.image.gz
-	cp -f $(obj)/ramdisk.image.gz $@
+$(obj)/zImage.initrd.pmac: vmlinux $(wrapperbits)
+	$(call cmd,wrap_initrd,pmac)
 
-$(call src-sec, $(required) $(initrd)): $(obj)/kernel-%.c: $(obj)/kernel-%.gz
-	@touch $@
+$(obj)/zImage.coff: vmlinux $(wrapperbits)
+	$(call cmd,wrap,pmaccoff)
 
-$(call obj-sec, $(required) $(initrd)): $(obj)/kernel-%.o: $(obj)/kernel-%.c
-	$(call if_changed_dep,bootcc)
-	$(call cmd,addsection)
+$(obj)/zImage.initrd.coff: vmlinux $(wrapperbits)
+	$(call cmd,wrap_initrd,pmaccoff)
 
-$(obj)/zImage.vmode $(obj)/zImage.coff: obj-boot += $(call obj-sec, $(required))
-$(obj)/zImage.vmode: $(call obj-sec, $(required)) $(obj-boot) $(srctree)/$(src)/zImage.lds
-	$(call cmd,bootld,$(obj-boot),zImage.lds)
+$(obj)/zImage.miboot: vmlinux $(wrapperbits)
+	$(call cmd,wrap,miboot)
 
-$(obj)/zImage.initrd.vmode $(obj)/zImage.initrd.coff: obj-boot += $(call obj-sec, $(required) $(initrd))
-$(obj)/zImage.initrd.vmode: $(call obj-sec, $(required) $(initrd)) $(obj-boot) $(srctree)/$(src)/zImage.lds
-	$(call cmd,bootld,$(obj-boot),zImage.lds)
+$(obj)/zImage.initrd.miboot: vmlinux $(wrapperbits)
+	$(call cmd,wrap_initrd,miboot)
+
+image-$(CONFIG_PPC_PSERIES)	+= zImage.pseries
+image-$(CONFIG_PPC_PMAC)	+= zImage.pmac
+image-$(CONFIG_PPC_CHRP)	+= zImage.chrp
 
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
-coffimage-$(CONFIG_PPC_PMAC)-$(CONFIG_PPC32) := $(obj)/zImage.coff
-coffrdimg-$(CONFIG_PPC_PMAC)-$(CONFIG_PPC32) := $(obj)/zImage.initrd.coff
-mibootimg-$(CONFIG_PPC_PMAC)-$(CONFIG_PPC32) := $(obj)/miboot.image
-mibrdimg-$(CONFIG_PPC_PMAC)-$(CONFIG_PPC32)  := $(obj)/miboot.initrd.image
-
-$(obj)/zImage: $(obj)/zImage.vmode $(obj)/addnote $(coffimage-y-y) \
-			$(mibootimg-y-y)
-	@cp -f $< $@
-	$(call if_changed,addnote)
-
-$(obj)/zImage.initrd: $(obj)/zImage.initrd.vmode $(obj)/addnote \
-			$(coffrdimg-y-y) $(mibrdimg-y-y)
-	@cp -f $< $@
-	$(call if_changed,addnote)
-
-$(obj)/zImage.coff: $(call obj-sec, $(required)) $(obj-boot) \
-			$(srctree)/$(src)/zImage.coff.lds $(obj)/hack-coff
-	$(call cmd,bootld,$(obj-boot),zImage.coff.lds)
-	$(call cmd,gencoff)
-
-$(obj)/zImage.initrd.coff: $(call obj-sec, $(required) $(initrd)) $(obj-boot) \
-			   $(srctree)/$(src)/zImage.coff.lds $(obj)/hack-coff
-	$(call cmd,bootld,$(obj-boot),zImage.coff.lds)
-	$(call cmd,gencoff)
+ifeq ($(CONFIG_PPC32),y)
+image-$(CONFIG_PPC_PMAC)	+= zImage.coff zImage.miboot
+endif
 
-$(obj)/miboot.image: $(obj)/dummy.o $(obj)/vmlinux.gz
-	$(call cmd,gen-miboot,image)
+initrd-y := $(patsubst zImage.%, zImage.initrd.%, $(image-y))
 
-$(obj)/miboot.initrd.image: $(obj)/miboot.image $(images)/ramdisk.image.gz
-	$(call cmd,gen-miboot,initrd)
+$(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
+$(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 
 #-----------------------------------------------------------
 # build u-boot images
@@ -217,4 +196,4 @@ extra-y		+= vmlinux.bin vmlinux.gz
 install: $(CONFIGURE) $(BOOTIMAGE)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" "$(BOOTIMAGE)"
 
-clean-files += $(addprefix $(objtree)/, $(obj-boot) vmlinux.strip)
+clean-files += $(addprefix $(objtree)/, $(obj-boot) vmlinux.strip.gz)
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
new file mode 100755
index 0000000..98dc8b0
--- /dev/null
+++ b/arch/powerpc/boot/wrapper
@@ -0,0 +1,191 @@
+#!/bin/sh
+
+# Copyright (C) 2006 Paul Mackerras, IBM Corporation <paulus@samba.org>
+# This program may be used under the terms of version 2 of the GNU
+# General Public License.
+
+# This script takes a kernel binary and optionally an initrd image
+# and/or a device-tree blob, and creates a bootable zImage for a
+# given platform.
+
+# Options:
+# -o zImage	specify output file
+# -p platform	specify platform (links in $platform.o)
+# -i initrd	specify initrd file
+# -d devtree	specify device-tree blob
+# -s tree.dts	specify device-tree source file (needs dtc installed)
+# -c		cache $kernel.strip.gz (use if present & newer, else make)
+# -C prefix	specify command prefix for cross-building tools
+#		(strip, objcopy, ld)
+# -D dir	specify directory containing data files used by script
+#		(default ./arch/powerpc/boot)
+# -W dir	specify working directory for temporary files (default .)
+
+# defaults
+kernel=
+ofile=zImage
+platform=of
+initrd=
+dtb=
+dts=
+cacheit=
+
+# cross-compilation prefix
+CROSS=
+
+# directory for object and other files used by this script
+object=arch/powerpc/boot
+
+# directory for working files
+tmpdir=.
+
+usage() {
+    echo 'Usage: wrapper [-o output] [-p platform] [-i initrd]' >&2
+    echo '       [-d devtree] [-s tree.dts] [-c] [-C cross-prefix]' >&2
+    echo '       [-D datadir] [-W workingdir] [vmlinux]' >&2
+    exit 1
+}
+
+while [ "$#" -gt 0 ]; do
+    case "$1" in
+    -o)
+	shift
+	[ "$#" -gt 0 ] || usage
+	ofile="$1"
+	;;
+    -p)
+	shift
+	[ "$#" -gt 0 ] || usage
+	platform="$1"
+	;;
+    -i)
+	shift
+	[ "$#" -gt 0 ] || usage
+	initrd="$1"
+	;;
+    -d)
+	shift
+	[ "$#" -gt 0 ] || usage
+	dtb="$1"
+	;;
+    -s)
+	shift
+	[ "$#" -gt 0 ] || usage
+	dts="$1"
+	;;
+    -c)
+	cacheit=y
+	;;
+    -C)
+	shift
+	[ "$#" -gt 0 ] || usage
+	CROSS="$1"
+	;;
+    -D)
+	shift
+	[ "$#" -gt 0 ] || usage
+	object="$1"
+	;;
+    -W)
+	shift
+	[ "$#" -gt 0 ] || usage
+	tmpdir="$1"
+	;;
+    -?)
+	usage
+	;;
+    *)
+	[ -z "$kernel" ] || usage
+	kernel="$1"
+	;;
+    esac
+    shift
+done
+
+if [ -n "$dts" ]; then
+    if [ -z "$dtb" ]; then
+	dtb="$platform.dtb"
+    fi
+    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1
+fi
+
+if [ -z "$kernel" ]; then
+    kernel=vmlinux
+fi
+
+platformo=$object/"$platform".o
+lds=$object/zImage.lds
+
+case "$platform" in
+pmac|pseries|chrp)
+    platformo=$object/of.o
+    ;;
+pmaccoff)
+    platformo=$object/of.o
+    lds=$object/zImage.coff.lds
+    ;;
+miboot)
+    # this is quite different...
+    tmpvm=$tmpdir/vmlinux.bin.$$
+    ${CROSS}objcopy -O binary "$kernel" $tmpvm
+    gzip -f -9 $tmpvm
+    tmpir=
+    if [ -n "$initrd" ]; then
+	tmpir=--add-section=initrd="$initrd"
+    fi
+    ${CROSS}objcopy -O aixcoff-rs6000 -R .stab -R .stabstr -R .comment \
+	--add-section=image=$tmpvm.gz $tmpir \
+	$object/empty.o "$ofile"
+    rm $tmpvm.gz
+    exit 0
+esac
+	
+tmp=$tmpdir/zImage.$$.o
+cp $object/empty.o $tmp
+
+addsec() {
+    ${CROSS}objcopy $1 \
+	--add-section=.kernel:$3="$2" \
+	--set-section-flags=.kernel:$3=contents,alloc,load,readonly,data
+}
+
+if [ -n "$cacheit" ]; then
+    vmz="$tmpdir/`basename \"$kernel\"`.strip"
+    if [ ! -f "$vmz.gz" -o "$vmz.gz" -ot "$kernel" ]; then
+	cp "$kernel" "$vmz"
+	${CROSS}strip "$vmz"
+	gzip -f -9 "$vmz"
+    fi
+    addsec $tmp "$vmz.gz" vmlinux.strip
+else
+    tmpvmz=$tmpdir/vmlinux.$$
+    cp "$kernel" $tmpvmz
+    ${CROSS}strip $tmpvmz
+    gzip -f -9 $tmpvmz
+    addsec $tmp $tmpvmz.gz vmlinux.strip
+    rm $tmpvmz.gz
+fi
+
+if [ -n "$initrd" ]; then
+    addsec $tmp "$initrd" initrd
+fi
+
+if [ -n "$dtb" ]; then
+    addsec $tmp "$dtb" dtb
+fi
+
+${CROSS}ld -m elf32ppc -T $lds -o "$ofile" \
+	$object/crt0.o $platformo $tmp $object/wrapper.a
+
+rm $tmp
+
+# post-processing needed for some platforms
+case "$platform" in
+pseries|chrp)
+    $object/addnote "$ofile"
+    ;;
+pmaccoff)
+    ${CROSS}objcopy -O aixcoff-rs6000 --set-start 0x500000 "$ofile"
+    $object/hack-coff "$ofile"
+    ;;
+esac
diff --git a/arch/powerpc/boot/zImage.coff.lds b/arch/powerpc/boot/zImage.coff.lds
deleted file mode 100644
index 6016251..0000000
--- a/arch/powerpc/boot/zImage.coff.lds
+++ /dev/null
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
diff --git a/arch/powerpc/boot/zImage.coff.lds.S b/arch/powerpc/boot/zImage.coff.lds.S
new file mode 100644
index 0000000..6016251
--- /dev/null
+++ b/arch/powerpc/boot/zImage.coff.lds.S
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
diff --git a/arch/powerpc/boot/zImage.lds b/arch/powerpc/boot/zImage.lds
deleted file mode 100644
index 4b6bb3f..0000000
--- a/arch/powerpc/boot/zImage.lds
+++ /dev/null
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
diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
new file mode 100644
index 0000000..4b6bb3f
--- /dev/null
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -0,0 +1,46 @@
+OUTPUT_ARCH(powerpc:common)
+ENTRY(_zimage_start)
+SECTIONS
+{
+  . = (4*1024*1024);
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
+  __bss_start = .;
+  .bss       :
+  {
+   *(.sbss)
+   *(.bss)
+  }
+  . = ALIGN(4096);
+  _end = . ;
+}
