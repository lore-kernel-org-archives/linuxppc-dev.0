Return-Path: <msm@freescale.com>
Subject: [RFC] New target 'cuImage' - compatibility uImage
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 15:59:06 -0500
Message-Id: <1154552346.5550.51.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

The following is a patch which creates a new target called 'cuImage'. It
is designed to correctly package the kernel along with the
'arch/powerpc/boot' wrapper code into a uImage to be loaded and started
by U-Boot.

The purpose of this target is to allow boards with older versions of
U-Boot to utilize the 'bootm' command within U-Boot to run new powerpc
kernels. The bootwrapper will begin execution and can correctly setup a
flat device tree based on values passed in the bd_t structure, something
old versions of U-Boot are not capable of.

One might ask why not just use the 'bootelf' command in u-boot. Well,
not all boards have that option compiled in, and some other boards might
not even have access to the console. Also, the bd_t structure is not
passed from U-Boot when using the bootelf command so we would have no
method to correctly fill in values in the device tree. This would
theoretically allow an old board to start a new kernel without access to
the console if required.

Currently the zImage looks like this:

---------------------------------
- 	_start			-
-	boot wrapper code	-
- ----------------------------- -
- -	device tree	      - -
- ----------------------------- -
- ----------------------------- -
- - 			      - -
- - 	compressed	      - -
- - 	kernel image	      - -
- -			      - -
- ----------------------------- -
---------------------------------

And the new cuImage will look like this:

-------------------------------------
-	compressed uImage	  - -
- ------------------------------- - -
- - 	_start			- - -
- -	boot wrapper code	- - -
- - ----------------------------- - -
- - -	device tree	      	- - -
- - ----------------------------- - -
- - ----------------------------- - -
- - - 			      	- - -
- - - 	UNcompressed	      	- - -
- - - 	kernel image	      	- - -
- - -			      	- - -
- - ----------------------------- - -
- --------------------------------- -
-------------------------------------

-Matthew

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 13e583f..2d2c39a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -96,11 +96,21 @@ config GENERIC_TBSYNC
 	default n
 
 config DEFAULT_UIMAGE
-	bool
+	bool "Set uImage to be the default build target"
 	help
 	  Used to allow a board to specify it wants a uImage built by default
 	default n
 
+config UIMAGELOADADDR
+	hex "Set the uImage load address"
+	default 400000
+	depends on DEFAULT_UIMAGE 
+
+config UIMAGEENTRY
+	hex "Set the uImage entry address"
+	default 400010
+	depends on DEFAULT_UIMAGE 
+
 menu "Processor support"compatibility 
 choice
 	prompt "Processor Type"
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 01667d1..eefbe16 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -141,12 +141,13 @@ # Default to zImage, override when neede
 defaultimage-y			:= zImage
 defaultimage-$(CONFIG_PPC_ISERIES) := vmlinux
 defaultimage-$(CONFIG_DEFAULT_UIMAGE) := uImage
+defaultimage-$(CONFIG_DEFAULT_UIMAGE) := cuImage
 KBUILD_IMAGE := $(defaultimage-y)
 all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
uImage vmlinux.bin
+BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
uImage vmlinux.bin cuImage
 
 PHONY += $(BOOT_TARGETS)
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index daad857..72e8ad8 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -23,7 +23,8 @@ #	in the toplevel makefile.
 
 HOSTCC		:= gcc
 BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem \
-		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC
+		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC \
+		   -fno-schedule-insns -fno-schedule-insns2 -fno-inline
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 OBJCOPYFLAGS    := contents,alloc,load,readonly,data
 OBJCOPY_COFF_ARGS := -O aixcoff-rs6000 --set-start 0x500000
@@ -198,10 +199,18 @@ cmd_mygzip = gzip -f -9 < $< > $@.$$$$ &
 quiet_cmd_objbin = OBJCOPY $@
       cmd_objbin = $(OBJCOPY) -O binary $< $@
 
+ifndef CONFIG_UIMAGELOADADDR
+CONFIG_UIMAGELOADADDR = 00000000
+endif
+
+ifndef CONFIG_UIMAGEENTRY
+CONFIG_UIMAGEENTRY = 00000000
+endif
+
 quiet_cmd_uimage = UIMAGE $@
       cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A ppc -O linux -T kernel
\
-               -C gzip -a 00000000 -e 00000000 -n
'Linux-$(KERNELRELEASE)' \
-               -d $< $@
+	-C gzip -a $(CONFIG_UIMAGELOADADDR) -e $(CONFIG_UIMAGEENTRY)  \
+	-n 'Linux-$(KERNELRELEASE)' -d $< $@
 
 MKIMAGE		:= $(srctree)/scripts/mkuboot.sh
 targets		+= uImage
@@ -223,3 +232,40 @@ install: $(CONFIGURE) $(BOOTIMAGE)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux
System.map "$(INSTALL_PATH)" "$(BOOTIMAGE)"
 
 clean-files += $(addprefix $(objtree)/, $(obj-boot) vmlinux.strip)
+
+#-----------------------------------------------------------
+# build compatiblity u-boot images
+#-----------------------------------------------------------
+
+targets += cuImage
+
+quiet_cmd_addsection_cuimage = ADDSEC  $@
+      cmd_addsection_cuimage = $(CROSS32OBJCOPY) $@ \
+		--add-section=.kernel:vmlinux.elf=vmlinux \
+		--set-section-flags=.kernel:vmlinux.elf=$(OBJCOPYFLAGS)
+
+$(obj)/kernel-compat.c:
+	@touch $@
+
+$(obj)/kernel-compat.o: $(obj)/kernel-compat.c vmlinux 
+	$(call if_changed_dep,bootcc)
+	$(call cmd,addsection_cuimage)
+
+$(obj)/vmlinux-compat.elf: $(obj-boot) $(obj)/kernel-compat.o
+	$(call cmd,bootld,$(obj-boot) $(obj)/kernel-compat.o,cuImage.lds)
+
+$(obj)/vmlinux-compat.bin: $(obj)/vmlinux-compat.elf
+	$(call if_changed,objbin)
+
+$(obj)/vmlinux-compat.gz: $(obj)/vmlinux-compat.bin
+	$(call if_changed,mygzip)
+
+$(obj)/cuImage: $(obj)/vmlinux-compat.gz $(obj-boot)
+	$(Q)rm -f $@
+	$(call cmd,uimage)
+	@echo -n '  Image: $@ '
+	@if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
+
+clean-files += vmlinux-compat.elf vmlinux-compat.bin vmlinux-compat.gz
cuImage
+
+
