Date: Thu, 20 Mar 2003 23:27:59 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: ppc: Makefile tidy-up round 2
Message-ID: <20030320222759.GA12267@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tom.

First batch of makefile tidy-up got merged by Paul, so here is next.
Made on top of linuxppc-2.5 as of today.

So far only 2 cset's. Openfirmware and simple will show up later.

For prep the output looks nice when trying: "make V=0"
One of the good things is that warnings becomes soo visible:

  AS      arch/ppc/boot/prep/head.o
  CC      arch/ppc/boot/prep/misc.o
  CC      arch/ppc/boot/prep/vreset.o
arch/ppc/boot/prep/vreset.c:694: warning: missing braces around initializer
arch/ppc/boot/prep/vreset.c:694: warning: (near initialization for `PCI_slots[0].regs')
  CC      arch/ppc/boot/prep/kbd.o
  CC      arch/ppc/boot/prep/dummy.o
  OBJCOPY arch/ppc/boot/prep/image.o
  LD      arch/ppc/boot/prep/zImage.bin
  OBJCOPY arch/ppc/boot/prep/zImage
  MKPREP  arch/ppc/boot/images/zImage.prep
  kernel: zImage is ready (arch/ppc/boot/images/zImage.prep)

I have made compiletime tests only - but the changes are straightforward.
See description of the cset's below diffstat.

Attached as patches, but also available for bk pulling:

bk pull bk://linux-sam.bkbits.net/ppc-2.5

	Sam

 arch/ppc/boot/utils/Makefile    |   20 -------
 b/arch/ppc/Makefile             |    4 -
 b/arch/ppc/boot/Makefile        |   19 +-----
 b/arch/ppc/boot/images/Makefile |   12 ++--
 b/arch/ppc/boot/prep/Makefile   |  114 +++++++++++++++++++++------------------- b/arch/ppc/boot/prep/dummy.c    |    4 +
 b/arch/ppc/kernel/Makefile      |   12 +---
 b/arch/ppc/ocp/Makefile         |    9 ---
 b/arch/ppc/ocp/xilinx/Makefile  |    2
 9 files changed, 84 insertions(+), 112 deletions(-)


ChangeSet@1.872, 2003-03-20 23:02:24+01:00, sam@mars.ravnborg.org
  ppc: boot/prep/Makefile

  Cleaned up, and utilise kbuild infrastructure.
  Changes in commandlines are now detected, and recompile is forced.
  Output is nice with "make V=0"

  Compile time tested only.

  To avoid symlinking a copy of dummy.c is located in prep/.
  The file is too simple to require symlinking to share it. (3 lines of code)

ChangeSet@1.871, 2003-03-20 22:46:06+01:00, sam@mars.ravnborg.org
  ppc: Makefile tidy-up round 2

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.870   -> 1.871
#	   arch/ppc/Makefile	1.59    -> 1.60
#	arch/ppc/boot/images/Makefile	1.15    -> 1.16
#	arch/ppc/ocp/Makefile	1.2     -> 1.3
#	arch/ppc/boot/Makefile	1.25    -> 1.26
#	arch/ppc/ocp/xilinx/Makefile	1.4     -> 1.5
#	arch/ppc/boot/utils/Makefile	1.5     ->         (deleted)
#	arch/ppc/kernel/Makefile	1.48    -> 1.49
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/20	sam@mars.ravnborg.org	1.871
# ppc: Makefile tidy-up round 2
# --------------------------------------------
#
diff -Nru a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile	Thu Mar 20 23:15:03 2003
+++ b/arch/ppc/Makefile	Thu Mar 20 23:15:03 2003
@@ -11,10 +11,10 @@
 #

 # This must match PAGE_OFFSET in include/asm-ppc/page.h.
-KERNELLOAD	=$(CONFIG_KERNEL_START)
+KERNELLOAD	:= $(CONFIG_KERNEL_START)

 LDFLAGS_BLOB	:= --format binary --oformat elf32-powerpc
-LDFLAGS_vmlinux	= -Ttext $(KERNELLOAD) -Bstatic
+LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+= -Iarch/$(ARCH)
 AFLAGS		+= -Iarch/$(ARCH)
 cflags-y	+= -Iarch/$(ARCH) -msoft-float -pipe \
diff -Nru a/arch/ppc/boot/Makefile b/arch/ppc/boot/Makefile
--- a/arch/ppc/boot/Makefile	Thu Mar 20 23:15:03 2003
+++ b/arch/ppc/boot/Makefile	Thu Mar 20 23:15:03 2003
@@ -13,28 +13,17 @@
 CFLAGS	 	+= -fno-builtin -D__BOOTER__ -Iarch/$(ARCH)/boot/include
 HOSTCFLAGS	+= -Iarch/$(ARCH)/boot/include

-BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd
+BOOT_TARGETS	= zImage zImage.initrd znetboot znetboot.initrd

 bootdir-y			:= simple
 bootdir-$(CONFIG_ALL_PPC)	:= openfirmware prep
-subdir-y			:= lib common images
-subdir-$(CONFIG_ALL_PPC)	+= of1275
+subdir-y				:= lib/ common/ images/
+subdir-$(CONFIG_ALL_PPC)		+= of1275/

 # for cleaning
 subdir-				+= simple/ openfirmware/ prep/

-tools-$(CONFIG_ALL_PPC)		:= addnote mknote hack-coff mkprep
-tools-$(CONFIG_PPLUS)		:= mkbugboot mkprep
-tools-$(CONFIG_4xx)		:= mktree
-tools-$(CONFIG_LOPEC)		:= mkbugboot mkprep
-tools-$(CONFIG_MCPN765)		:= mkbugboot mkprep
-tools-$(CONFIG_MENF1)		:= mkprep
-tools-$(CONFIG_MVME5100)	:= mkbugboot mkprep
-tools-$(CONFIG_PRPMC750)	:= mkbugboot mkprep
-tools-$(CONFIG_PRPMC800)	:= mkbugboot mkprep
-tools-$(CONFIG_SPRUCE)		:= mktree
-
-host-progs			:= $(addprefix utils/,$(tools-y))
+host-progs := $(addprefix utils/, addnote mknote hack-coff mkprep mkbugboot mktree)

 .PHONY: $(BOOT_TARGETS) $(bootdir-y)

diff -Nru a/arch/ppc/boot/images/Makefile b/arch/ppc/boot/images/Makefile
--- a/arch/ppc/boot/images/Makefile	Thu Mar 20 23:15:03 2003
+++ b/arch/ppc/boot/images/Makefile	Thu Mar 20 23:15:03 2003
@@ -2,12 +2,14 @@
 # This dir holds all of the images for PPC machines.
 # Tom Rini	January 2001

-extra-y		:= vmlinux.gz
-GZIP_FLAGS	:= -v9f
+extra-y		:= vmlinux.bin vmlinux.gz

-$(obj)/vmlinux.gz: vmlinux
-	$(OBJCOPY) -O binary $< $(@:.gz=)
-	gzip $(GZIP_FLAGS) $(@:.gz=)
+OBJCOPYFLAGS_vmlinux.bin := -O binary
+$(obj)/vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/vmlinux.gz: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,gzip)

 # Files generated that shall be removed upon make clean
 clean-files	:= sImage vmapus vmlinux* miboot* zImage*
diff -Nru a/arch/ppc/boot/utils/Makefile b/arch/ppc/boot/utils/Makefile
--- a/arch/ppc/boot/utils/Makefile	Thu Mar 20 23:15:03 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,20 +0,0 @@
-#
-# arch/ppc/boot/utils/Makefile
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-
-HOSTCFLAGS += -I$(TOPDIR)/arch/$(ARCH)/boot/include
-
-all: FORCE
-
-# Simple programs with 1 file and no extra CFLAGS
-UTILS = addnote hack-coff mkprep mknote mkbugboot mktree \
-	addSystemMap addRamdDisk
-
-$(UTILS):
-	$(HOSTCC) $(HOSTCFLAGS) -o $@ $@.c
-
-clean:
-	rm -f $(UTILS)
diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	Thu Mar 20 23:15:03 2003
+++ b/arch/ppc/kernel/Makefile	Thu Mar 20 23:15:03 2003
@@ -10,13 +10,11 @@
 endif

 # Start off with 'head.o', change as needed.
-HEAD-y				:= head.o
-HEAD-$(CONFIG_40x)		:= head_4xx.o
-HEAD-$(CONFIG_440)		:= head_44x.o
-HEAD-$(CONFIG_8xx)		:= head_8xx.o
-HEAD-$(CONFIG_6xx)		+= idle_6xx.o
-
-extra-y	:= $(HEAD-y)
+extra-y				:= head.o
+extra-$(CONFIG_40x)		:= head_4xx.o
+extra-$(CONFIG_440)		:= head_44x.o
+extra-$(CONFIG_8xx)		:= head_8xx.o
+extra-$(CONFIG_6xx)		+= idle_6xx.o

 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
 					process.o signal.o ptrace.o align.o \
diff -Nru a/arch/ppc/ocp/Makefile b/arch/ppc/ocp/Makefile
--- a/arch/ppc/ocp/Makefile	Thu Mar 20 23:15:03 2003
+++ b/arch/ppc/ocp/Makefile	Thu Mar 20 23:15:03 2003
@@ -1,13 +1,6 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
-# Note 2! The CFLAGS definitions are now in the main makefile...
-#
-# NB: cribbed from the drivers/sbus/Makefile -- PMM

-obj-y   	+= ocp.o ocp-driver.o ocp-probe.o
+obj-y   	:= ocp.o ocp-driver.o ocp-probe.o

diff -Nru a/arch/ppc/ocp/xilinx/Makefile b/arch/ppc/ocp/xilinx/Makefile
--- a/arch/ppc/ocp/xilinx/Makefile	Thu Mar 20 23:15:03 2003
+++ b/arch/ppc/ocp/xilinx/Makefile	Thu Mar 20 23:15:03 2003
@@ -2,8 +2,6 @@
 # Makefile for the Xilinx On Chip Peripheral support code
 #

-export-objs += xilinx_syms.o
-
 obj-$(CONFIG_XILINX_OCP)	+= xilinx_ocp.o

 # The Xilinx OS independent code.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.871   -> 1.872
#	arch/ppc/boot/prep/Makefile	1.22    -> 1.23
#	               (new)	        -> 1.1     arch/ppc/boot/prep/dummy.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/20	sam@mars.ravnborg.org	1.872
# ppc: boot/prep/Makefile
#
# Cleaned up, and utilise kbuild infrastructure.
# Changes in commandlines are now detected, and recompile is forced.
# Output is nice with "make V=0"
#
# Compile time tested only.
#
# To avoid symlinking a copy of dummy.c is located in prep/.
# The file is too simple to require symlinking to share it. (3 lines of code)
# --------------------------------------------
#
diff -Nru a/arch/ppc/boot/prep/Makefile b/arch/ppc/boot/prep/Makefile
--- a/arch/ppc/boot/prep/Makefile	Thu Mar 20 23:15:11 2003
+++ b/arch/ppc/boot/prep/Makefile	Thu Mar 20 23:15:11 2003
@@ -13,74 +13,82 @@
 # modified by Cort (cort@cs.nmt.edu)
 #

-boot: zImage
-
-TFTPIMAGE			= /tftpboot/zImage.prep
+TFTPIMAGE		:= /tftpboot/zImage.prep
 ifeq ($(CONFIG_SMP),y)
-TFTPIMAGE			= $(TFTPBOOT).smp
+TFTPIMAGE		:= $(TFTPBOOT).smp
 endif

-LD_ARGS				= -T $(boot)/ld.script -Ttext 0x00800000 -Bstatic
-OBJCOPY_ARGS			= -O elf32-powerpc
-LIBS 				= $(common)/lib.a $(bootlib)/lib.a
-
 boot-y				:= head.o misc.o
 boot-$(CONFIG_VGA_CONSOLE)	+= vreset.o kbd.o

-boot := arch/ppc/boot
-common := $(boot)/common
-utils := $(boot)/utils
-bootlib := $(boot)/lib
-of1275 := $(boot)/of1275
-images := $(boot)/images
-simple := $(boot)/simple
+boot	:= arch/ppc/boot
+common	:= $(boot)/common
+utils	:= $(boot)/utils
+bootlib	:= $(boot)/lib
+images	:= $(boot)/images
+simple	:= $(boot)/simple

-EXTRA_TARGETS	:= $(boot-y) ../simple/legacy.o
-OBJS		:= $(addprefix $(obj)/,$(boot-y)) $(simple)/legacy.o
+OBJCOPYFLAGS	:= -O elf32-powerpc
+LIBS 		:= $(common)/lib.a $(bootlib)/lib.a

-# Tools
-MKPREP				:= $(utils)/mkprep
+targets		:= $(boot-y) dummy.o ../simple/legacy.o
+OBJS		:= $(addprefix $(obj)/,$(boot-y)) $(simple)/legacy.o

 # Extra include search dirs
 CFLAGS_kbd.o			+= -Idrivers/char

+zImage: initrd :=
 zImage: $(images)/zImage.prep
-zImage.initrd: $(images)/zImage.initrd.prep
-
-$(obj)/dummy.o: $(common)/dummy.c
-	$(CC) -c -o $@ $(common)/dummy.c
+	@echo '  kernel: $@ is ready ($<)'

-$(images)/zImage.prep: $(OBJS) $(LIBS) $(boot)/ld.script $(images)/vmlinux.gz \
-		$(obj)/dummy.o $(MKPREP)
-	$(OBJCOPY) $(OBJCOPY_ARGS) -R .comment \
-		--add-section=.image=$(images)/vmlinux.gz \
-		--set-section-flags=.image=contents,alloc,load,readonly,data \
-		$(obj)/dummy.o $(obj)/image.o
-	$(LD) $(LD_ARGS) -o $(obj)/zImage $(OBJS) $(obj)/image.o $(LIBS)
-	$(OBJCOPY) $(OBJCOPY_ARGS) $(obj)/zImage $(obj)/zImage \
-		-R .comment -R .stab -R .stabstr
-	$(MKPREP) -pbp $(obj)/zImage $@
-	rm -f $(obj)/zImage
-
-$(images)/zImage.initrd.prep: $(OBJS) $(LIBS) $(boot)/ld.script \
-		$(images)/vmlinux.gz $(obj)/dummy.o $(MKPREP)
-	$(OBJCOPY) $(OBJCOPY_ARGS) -R .comment \
-		--add-section=.ramdisk=$(images)/ramdisk.image.gz \
-		--set-section-flags=.ramdisk=contents,alloc,load,readonly,data \
-		--add-section=.image=$(images)/vmlinux.gz \
-		--set-section-flags=.image=contents,alloc,load,readonly,data \
-		$(obj)/dummy.o $(obj)/image.o
-	$(LD) $(LD_ARGS) -o $(obj)/zImage.initrd $(OBJS) $(obj)/image.o $(LIBS)
-	$(OBJCOPY) $(OBJCOPY_ARGS) $(obj)/zImage.initrd $(obj)/zImage.initrd \
-		-R .comment -R .stab -R .stabstr
-	$(MKPREP) -pbp $(obj)/zImage.initrd $@
-	rm -f  $(obj)/zImage.initrd
+zImage.initrd: initrd := .initrd
+zImage.initrd: $(images)/zImage.initrd.prep
+	@echo '  kernel: $@ is ready ($<)'

+mages)/ramdisk.image.gz:
+	@echo '  MISSING $@'
+	@echo '          RAM disk image must be provided separatly'
+	@/bin/false
+
+OBJCOPYFLAGS_image.o   := \
+	--add-section=.image=$(images)/vmlinux.gz \
+	--set-section-flags=.image=contents,alloc,load,readonly,data
+targets	+= image.o
+$(obj)/image.o: $(obj)/dummy.o $(images)/vmlinux.gz
+	$(call if_changed,objcopy)
+
+OBJCOPYFLAGS_image.initrd.o    := \
+	--add-section=.ramdisk=$(images)/ramdisk.image.gz \
+	--set-section-flags=.ramdisk=contents,alloc,load,readonly,data \
+	--add-section=.image=$(images)/vmlinux.gz \
+	--set-section-flags=.image=contents,alloc,load,readonly,data
+targets	+= image.initrd.o
+$(obj)/image.initrd.o: $(obj)/dummy.o $(images)/vmlinux.gz $(images)/ramdisk.image.gz
+	$(call if_changed,objcopy)
+
+LDFLAGS_zImage.bin		:= -Ttext 0x00800000 -Bstatic -T
+LDFLAGS_zImage.initrd.bin	:= -Ttext 0x00800000 -Bstatic -T
+targets				+= zImage.bin zImage.initrd.bin
+$(obj)/zImage$(initrd).bin: $(boot)/ld.script $(OBJS) $(obj)/image.o $(LIBS)
+	$(call if_changed,ld)
+
+OBJCOPYFLAGS_zImage		:= -R .comment -R .stab -R .stabstr
+OBJCOPYFLAGS_zImage.initrd	:= -R .comment -R .stab -R .stabstr
+targets				+= zImage zImage.initrd
+$(obj)/zImage$(initrd): %: %.bin FORCE
+	$(call if_changed,objcopy)
+
+quiet_cmd_mkprep = MKPREP  $@
+      cmd_mkprep = $(utils)/mkprep -pbp $< $@
+
+$(images)/zImage$(initrd).prep: $(obj)/zImage$(initrd) $(utils)/mkprep FORCE
+	$(call cmd,mkprep)
+
+#
+# Convinient shorthands for various targets
+#
 floppy: zImage
 	dd if=$(images)/zImage.prep of=/dev/fd0H1440 bs=64b

-znetboot : zImage
-	cp $(images)/zImage.prep $(TFTPIMAGE)
-
-znetboot.initrd : zImage.initrd
-	cp $(images)/zImage.initrd.prep $(TFTPIMAGE)
+znetboot.initrd : zImage$(initrd)
+	cp $(images)/zImage$(initrd).prep $(TFTPIMAGE)
diff -Nru a/arch/ppc/boot/prep/dummy.c b/arch/ppc/boot/prep/dummy.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/boot/prep/dummy.c	Thu Mar 20 23:15:11 2003
@@ -0,0 +1,4 @@
+int main(void)
+{
+	return 0;
+}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
