Date: Fri, 14 Mar 2003 20:44:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linuxppc-dev@linuxppc.org
Subject: ppc: Update to ppc specific makefiles
Message-ID: <20030314194427.GA18790@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Made on top of ppc.bkbits.net/linuxppc-2.5

The ppc specific Makefiles in the kernel are looking mostly OK.
I noticed when building the kernel based on defconfig that the final
steps of the make were redone for each run. I fixed this along with
a few other updates:

1) More compact definition of cflags in arch/ppc/Makefile
2) No more use of TOPDIR (all over the makefiles)
3) Only one rule for offset generation
4) Deleted unused all-tools assignment
5) Deleted rules for find_name
        -> I could not see it referenced anywhere,
           but find_name.c is still present
6) Use EXTRA_TARGETS in boot/openfirmware and boot/prep
        -> Avoids *.o files to be compiled at each run
7) More compact definition used in kernel/Makefile for softemu
8) Deleted export-objs in ocp/xilinx
9) Deleted deprecated usage of export-objs in drivers/misc/Makefile
10) Reference files in include/asm via symlink
11) Got rid of warning resulted from use of export-objs in
    drivers/misc/Makefile
	-> The usage of misc/makefile is ppc specific, in the
	   vanilla kernel it is empty.

The kernel builds and when a rebuild is made no files are compiled again.
arch/ppc/boot/{openfirmware,prep,simple}/Makefile could use more
attention - but wanted to see this applied first.
Please apply,
	Sam

The following files are changed:

 arch/ppc/Makefile                   |   38 ++++++++++++++----------------------
 arch/ppc/boot/Makefile              |    8 ++-----
 arch/ppc/boot/images/Makefile       |   12 ++++++-----
 arch/ppc/boot/openfirmware/Makefile |   15 +++++++++-----
 arch/ppc/boot/prep/Makefile         |    3 +-
 arch/ppc/boot/utils/Makefile        |   14 +++----------
 arch/ppc/kernel/Makefile            |    9 ++------
 arch/ppc/ocp/Makefile               |    7 ------
 arch/ppc/ocp/xilinx/Makefile        |    2 -
 arch/ppc/platforms/Makefile         |   10 ++++-----
 arch/ppc/syslib/Makefile            |    2 -
 drivers/misc/Makefile               |    3 --
 12 files changed, 49 insertions(+), 74 deletions(-)

===== arch/ppc/Makefile 1.57 vs edited =====
--- 1.57/arch/ppc/Makefile	Sat Feb  8 01:31:35 2003
+++ edited/arch/ppc/Makefile	Fri Mar 14 20:38:43 2003
@@ -1,7 +1,5 @@
 # This file is included by the global makefile so that you can add your own
-# architecture-specific flags and dependencies. Remember to do have actions
-# for "archclean" and "archdep" for cleaning up and making dependencies for
-# this architecture
+# architecture-specific flags and dependencies.
 #
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
@@ -17,24 +15,20 @@

 LDFLAGS_BLOB	:= --format binary --oformat elf32-powerpc
 LDFLAGS_vmlinux	= -Ttext $(KERNELLOAD) -Bstatic
-CPPFLAGS	:= $(CPPFLAGS) -I$(TOPDIR)/arch/$(ARCH)
-AFLAGS		:= $(AFLAGS) -I$(TOPDIR)/arch/$(ARCH)
-CFLAGS		:= $(CFLAGS) -I$(TOPDIR)/arch/$(ARCH) -msoft-float -pipe \
+CPPFLAGS	+= -Iarch/$(ARCH)
+AFLAGS		+= -Iarch/$(ARCH)
+cflags-y	+= -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -Wno-uninitialized -mmultiple -mstring
 CPP		= $(CC) -E $(CFLAGS)

-ifdef CONFIG_4xx
-CFLAGS := $(CFLAGS) -Wa,-m405
-endif
+cflags-$(CONFIG_4xx)		+= -Wa,-m405
+cflags-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
+# Use sed to remove the quotes.
+cflags-$(CONFIG_MORE_COMPILE_OPTIONS) += \
+	$(shell echo $(CONFIG_COMPILE_OPTIONS) | sed -e 's/"//g')

-ifdef CONFIG_PPC64BRIDGE
-CFLAGS := $(CFLAGS) -Wa,-mppc64bridge
-endif
+CFLAGS += $(cflags-y)

-ifdef CONFIG_MORE_COMPILE_OPTIONS
-# Use sed to remove the quotes.
-  CFLAGS += $(shell echo $(CONFIG_COMPILE_OPTIONS) | sed -e 's/"//g')
-endif

 head-y				:= arch/ppc/kernel/head.o
 head-$(CONFIG_8xx)		:= arch/ppc/kernel/head_8xx.o
@@ -75,16 +69,14 @@
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/ppc/boot

-prepare: include/asm-$(ARCH)/offsets.h checkbin
+prepare: include/asm/offsets.h checkbin

 arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
 				   include/config/MARKER

-include/asm-$(ARCH)/offsets.h.tmp: arch/$(ARCH)/kernel/asm-offsets.s
-	@$(generate-asm-offsets.h) < $< > $@
-
-include/asm-$(ARCH)/offsets.h: include/asm-$(ARCH)/offsets.h.tmp
+include/asm/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
 	@echo -n '  Generating $@'
+	@$(generate-asm-offsets.h) < $< > $@.tmp
 	@$(update-if-changed)

 ifdef CONFIG_6xx
@@ -106,6 +98,6 @@
 	@true
 endif

-CLEAN_FILES +=	include/asm-$(ARCH)/offsets.h.tmp \
-		include/asm-$(ARCH)/offsets.h \
+CLEAN_FILES +=	include/asm/offsets.h.tmp \
+		include/asm/offsets.h \
 		arch/$(ARCH)/kernel/asm-offsets.s
===== arch/ppc/boot/Makefile 1.24 vs edited =====
--- 1.24/arch/ppc/boot/Makefile	Sat Jan  4 11:52:32 2003
+++ edited/arch/ppc/boot/Makefile	Fri Mar 14 20:32:58 2003
@@ -10,8 +10,8 @@
 # modified by Cort (cort@cs.nmt.edu)
 #

-CFLAGS	+= -fno-builtin -D__BOOTER__ -Iarch/$(ARCH)/boot/include
-HOSTCFLAGS += -I$(TOPDIR)/arch/$(ARCH)/boot/include
+CFLAGS	 	+= -fno-builtin -D__BOOTER__ -Iarch/$(ARCH)/boot/include
+HOSTCFLAGS	+= -Iarch/$(ARCH)/boot/include

 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd

@@ -21,7 +21,7 @@
 subdir-$(CONFIG_ALL_PPC)	+= of1275

 # for cleaning
-subdir-				+= simple openfirmware prep
+subdir-				+= simple/ openfirmware/ prep/ utils/

 tools-$(CONFIG_ALL_PPC)		:= addnote mknote hack-coff mkprep
 tools-$(CONFIG_PPLUS)		:= mkbugboot mkprep
@@ -33,8 +33,6 @@
 tools-$(CONFIG_PRPMC750)	:= mkbugboot mkprep
 tools-$(CONFIG_PRPMC800)	:= mkbugboot mkprep
 tools-$(CONFIG_SPRUCE)		:= mktree
-
-all-tools := addnote mknote hack-coff mkprep mkbugboot mktree

 host-progs			:= $(addprefix utils/,$(tools-y))

===== arch/ppc/boot/images/Makefile 1.13 vs edited =====
--- 1.13/arch/ppc/boot/images/Makefile	Wed Mar 12 01:14:09 2003
+++ edited/arch/ppc/boot/images/Makefile	Fri Mar 14 20:40:50 2003
@@ -2,13 +2,15 @@
 # This dir holds all of the images for PPC machines.
 # Tom Rini	January 2001

-EXTRA_TARGETS	:= vmlinux.gz
+EXTRA_TARGETS	:= vmlinux.bin vmlinux.gz

-GZIP_FLAGS = -v9f
+OBJCOPYFLAGS_vmlinux.bin := -O binary
+$(obj)/vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/vmlinux.gz: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,gzip)

-$(obj)/vmlinux.gz: vmlinux
-	$(OBJCOPY) -O binary $< $(@:.gz=)
-	gzip $(GZIP_FLAGS) $(@:.gz=)

 # Files generated that shall be removed upon make clean
 clean-files	:= sImage vmapus vmlinux* miboot* zImage*
===== arch/ppc/boot/openfirmware/Makefile 1.22 vs edited =====
--- 1.22/arch/ppc/boot/openfirmware/Makefile	Sat Jan  4 11:52:32 2003
+++ edited/arch/ppc/boot/openfirmware/Makefile	Fri Mar 14 19:16:27 2003
@@ -26,10 +26,15 @@
 CHRP_LD_ARGS = -T $(boot)/ld.script -e _start -Ttext 0x00800000
 NEWWORLD_LD_ARGS = -T $(boot)/ld.script -e _start -Ttext 0x01000000

-COMMONOBJS = $(obj)/start.o $(obj)/misc.o $(obj)/common.o
-COFFOBJS = $(obj)/coffcrt0.o $(COMMONOBJS) $(obj)/coffmain.o
-CHRPOBJS = $(obj)/crt0.o $(COMMONOBJS) $(obj)/chrpmain.o
-NEWWORLDOBJS = $(obj)/crt0.o $(COMMONOBJS) $(obj)/newworldmain.o
+COMMONOBJS	:= start.o misc.o common.o
+COFFOBJS	:= coffcrt0.o $(COMMONOBJS) coffmain.o
+CHRPOBJS	:= crt0.o $(COMMONOBJS) chrpmain.o
+NEWWORLDOBJS	:= crt0.o $(COMMONOBJS) newworldmain.o
+
+EXTRA_TARGETS := $(COFFOBJS) $(CHRPOBJS) $(NEWWORLDOBJS)
+COFFOBJS	:= $(addprefix $(obj)/, $(COFFOBJS))
+CHRPOBJS	:= $(addprefix $(obj)/, $(CHRPOBJS))
+NEWWORLDOBJS	:= $(addprefix $(obj)/, $(NEWWORLDOBJS))

 LIBS = lib/lib.a $(bootlib)/lib.a $(of1275)/lib.a $(common)/lib.a

@@ -55,7 +60,7 @@
 		--set-section-flags=.image=contents,alloc,load,readonly,data
 ifdef CONFIG_XMON
 	$(OBJCOPY) $@ $@ \
-		--add-section=.sysmap=$(TOPDIR)/System.map \
+		--add-section=.sysmap=$(objtree)/System.map \
 		--set-section-flags=.sysmap=contents,alloc,load,readonly,data
 endif

===== arch/ppc/boot/prep/Makefile 1.21 vs edited =====
--- 1.21/arch/ppc/boot/prep/Makefile	Wed Nov 20 12:23:07 2002
+++ edited/arch/ppc/boot/prep/Makefile	Fri Mar 14 19:16:27 2003
@@ -35,7 +35,8 @@
 images := $(boot)/images
 simple := $(boot)/simple

-OBJS	:= $(addprefix $(obj)/,$(boot-y)) $(simple)/legacy.o
+EXTRA_TARGETS	:= $(boot-y) ../simple/legacy.o
+OBJS		:= $(addprefix $(obj)/,$(boot-y)) $(simple)/legacy.o

 # Tools
 MKPREP				:= $(utils)/mkprep
===== arch/ppc/boot/utils/Makefile 1.5 vs edited =====
--- 1.5/arch/ppc/boot/utils/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/ppc/boot/utils/Makefile	Fri Mar 14 19:16:28 2003
@@ -5,16 +5,10 @@
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.

-HOSTCFLAGS += -I$(TOPDIR)/arch/$(ARCH)/boot/include

-all: FORCE
+HOST_EXTRACFLAGS += -Iarch/$(ARCH)/boot/include

-# Simple programs with 1 file and no extra CFLAGS
-UTILS = addnote hack-coff mkprep mknote mkbugboot mktree \
-	addSystemMap addRamdDisk
+host-progs	:=	addnote hack-coff mkprep mknote mkbugboot mktree \
+			addSystemMap addRamdDisk

-$(UTILS):
-	$(HOSTCC) $(HOSTCFLAGS) -o $@ $@.c
-
-clean:
-	rm -f $(UTILS)
+build-targets	:= $(host-progs)
===== arch/ppc/kernel/Makefile 1.46 vs edited =====
--- 1.46/arch/ppc/kernel/Makefile	Sun Mar  2 20:20:15 2003
+++ edited/arch/ppc/kernel/Makefile	Fri Mar 14 19:16:28 2003
@@ -29,11 +29,8 @@
 obj-$(CONFIG_KGDB)		+= ppc-stub.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_TAU)		+= temp.o
-ifeq ($(CONFIG_8xx),y)
-ifneq ($(CONFIG_MATH_EMULATION),n)
-obj-y				+= softemu8xx.o
-endif
+
+ifdef CONFIG_MATH_EMULATION
+obj-$(CONFIG_8xx)		+= softemu8xx.o
 endif

-find_name : find_name.c
-	$(HOSTCC) $(HOSTCFLAGS) -o find_name find_name.c
===== arch/ppc/ocp/Makefile 1.2 vs edited =====
--- 1.2/arch/ppc/ocp/Makefile	Mon Feb  3 23:19:36 2003
+++ edited/arch/ppc/ocp/Makefile	Fri Mar 14 19:44:04 2003
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

 obj-y   	+= ocp.o ocp-driver.o ocp-probe.o

===== arch/ppc/ocp/xilinx/Makefile 1.4 vs edited =====
--- 1.4/arch/ppc/ocp/xilinx/Makefile	Fri Jan 10 06:37:44 2003
+++ edited/arch/ppc/ocp/xilinx/Makefile	Fri Mar 14 19:16:28 2003
@@ -2,8 +2,6 @@
 # Makefile for the Xilinx On Chip Peripheral support code
 #

-export-objs += xilinx_syms.o
-
 obj-$(CONFIG_XILINX_OCP)	+= xilinx_ocp.o

 # The Xilinx OS independent code.
===== arch/ppc/platforms/Makefile 1.21 vs edited =====
--- 1.21/arch/ppc/platforms/Makefile	Sat Feb 15 00:14:40 2003
+++ edited/arch/ppc/platforms/Makefile	Fri Mar 14 19:16:29 2003
@@ -10,11 +10,11 @@
 endif

 # Extra CFLAGS so we don't have to do relative includes
-CFLAGS_pmac_setup.o	+= -I$(TOPDIR)/arch/$(ARCH)/mm
-CFLAGS_spruce_setup.o	+= -I$(TOPDIR)/arch/$(ARCH)/kernel
-CFLAGS_spruce_pci.o	+= -I$(TOPDIR)/arch/$(ARCH)/kernel
-CFLAGS_pal4_setup.o	+= -I$(TOPDIR)/arch/$(ARCH)/kernel
-CFLAGS_pal4_pci.o	+= -I$(TOPDIR)/arch/$(ARCH)/kernel
+CFLAGS_pmac_setup.o	+= -Iarch/$(ARCH)/mm
+CFLAGS_spruce_setup.o	+= -Iarch/$(ARCH)/kernel
+CFLAGS_spruce_pci.o	+= -Iarch/$(ARCH)/kernel
+CFLAGS_pal4_setup.o	+= -Iarch/$(ARCH)/kernel
+CFLAGS_pal4_pci.o	+= -Iarch/$(ARCH)/kernel

 obj-$(CONFIG_APUS)		+= apus_setup.o
 ifeq ($(CONFIG_APUS),y)
===== arch/ppc/syslib/Makefile 1.11 vs edited =====
--- 1.11/arch/ppc/syslib/Makefile	Sat Feb  8 01:31:35 2003
+++ edited/arch/ppc/syslib/Makefile	Fri Mar 14 19:16:29 2003
@@ -72,5 +72,3 @@
 obj-$(CONFIG_40x)		+= xilinx_pic.o
 endif

-find_name : find_name.c
-	$(HOSTCC) $(HOSTCFLAGS) -o find_name find_name.c
===== drivers/misc/Makefile 1.5 vs edited =====
--- 1.5/drivers/misc/Makefile	Mon Dec 16 20:06:06 2002
+++ edited/drivers/misc/Makefile	Fri Mar 14 19:16:30 2003
@@ -1,8 +1,5 @@
 #
 # Makefile for misc devices that really don't fit anywhere else.
 #
-export-objs			:= ibm_ocp_gpio.o

 obj-$(CONFIG_IBM_OCP_GPIO) += ibm_ocp_gpio.o
-
-obj- := misc.o	# Dummy rule to force built-in.o to be made

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
