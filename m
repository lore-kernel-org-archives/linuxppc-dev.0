Return-Path: <mohan@in.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC159DDEE7
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 18:09:55 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7C89ppE021821
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 04:09:51 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7C89pOj161436
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 02:09:51 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7C89poo004291
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 02:09:51 -0600
Date: Tue, 12 Aug 2008 13:39:44 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/5] Build files needed for relocation
Message-ID: <20080812080944.GB19619@in.ibm.com>
References: <20080811201120.GA25283@in.ibm.com>
	<20080811201413.GB26566@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080811201413.GB26566@in.ibm.com>
Cc: paulus@samba.org, miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Build files needed for relocation

This patch builds vmlinux file with relocation sections and contents so
that relocs user space program can extract the required relocation
offsets. This packs final relocatable vmlinux kernel as following:
earlier part of relocation apply code, vmlinux, rest of relocation apply
code.

TODO:
Relocatable vmlinux image is built in arch/powerpc/boot as vmlinux.reloc.
But it should be built in top level directory of kernel source as vmlinux
instead of vmlinux.reloc

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/Kconfig                |   15 ++++++++++--
 arch/powerpc/Makefile               |    9 ++++++-
 arch/powerpc/boot/Makefile          |   39 ++++++++++++++++++++++++++++++++--
 arch/powerpc/boot/vmlinux.lds.S     |   28 +++++++++++++++++++++++++
 arch/powerpc/boot/vmlinux.reloc.scr |    8 +++++++
 5 files changed, 91 insertions(+), 8 deletions(-)
 create mode 100644 arch/powerpc/boot/vmlinux.lds.S
 create mode 100644 arch/powerpc/boot/vmlinux.reloc.scr

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 63c9caf..b992bc1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -332,6 +332,15 @@ config CRASH_DUMP
 
 	  Don't change this unless you know what you are doing.
 
+config RELOCATABLE_PPC64
+	bool "Build a relocatable kernel (EXPERIMENTAL)"
+	depends on PPC_MULTIPLATFORM && PPC64 && CRASH_DUMP && EXPERIMENTAL
+	help
+	  Build a kernel suitable for use as regular kernel and kdump capture
+	  kernel.
+
+	  Don't change this unless you know what you are doing.
+
 config PHYP_DUMP
 	bool "Hypervisor-assisted dump (EXPERIMENTAL)"
 	depends on PPC_PSERIES && EXPERIMENTAL
@@ -694,7 +703,7 @@ config LOWMEM_SIZE
 	default "0x30000000"
 
 config RELOCATABLE
-	bool "Build a relocatable kernel (EXPERIMENTAL)"
+	bool "Build relocatable kernel (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && FSL_BOOKE
 	help
 	  This builds a kernel image that is capable of running at the
@@ -814,11 +823,11 @@ config PAGE_OFFSET
 	default "0xc000000000000000"
 config KERNEL_START
 	hex
-	default "0xc000000002000000" if CRASH_DUMP
+	default "0xc000000002000000" if CRASH_DUMP && !RELOCATABLE_PPC64
 	default "0xc000000000000000"
 config PHYSICAL_START
 	hex
-	default "0x02000000" if CRASH_DUMP
+	default "0x02000000" if CRASH_DUMP && !RELOCATABLE_PPC64
 	default "0x00000000"
 endif
 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9155c93..1bfdeea 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -63,7 +63,7 @@ override CC	+= -m$(CONFIG_WORD_SIZE)
 override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-powerpc $(AR)
 endif
 
-LDFLAGS_vmlinux	:= -Bstatic
+LDFLAGS_vmlinux	:= --emit-relocs
 
 CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none  -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 -mmultiple
@@ -146,11 +146,16 @@ core-$(CONFIG_KVM) 		+= arch/powerpc/kvm/
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
 # Default to zImage, override when needed
+
+ifneq ($(CONFIG_RELOCATABLE_PPC64),y)
 all: zImage
+else
+all: zImage vmlinux.reloc
+endif
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd uImage zImage% dtbImage% treeImage.% cuImage.% simpleImage.%
+BOOT_TARGETS = zImage vmlinux.reloc zImage.initrd uImage zImage% dtbImage% treeImage.% cuImage.% simpleImage.%
 
 PHONY += $(BOOT_TARGETS)
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 14174aa..a67a701 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -17,7 +17,7 @@
 #	CROSS32_COMPILE is setup as a prefix just like CROSS_COMPILE
 #	in the toplevel makefile.
 
-all: $(obj)/zImage
+all: $(obj)/zImage $(obj)/vmlinux.reloc
 
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
@@ -122,18 +122,51 @@ $(patsubst %.S,%.o, $(filter %.S, $(src-boot))): %.o: %.S FORCE
 $(obj)/wrapper.a: $(obj-wlib) FORCE
 	$(call if_changed,bootar)
 
-hostprogs-y	:= addnote addRamDisk hack-coff mktree dtc
+hostprogs-y	:= addnote addRamDisk hack-coff mktree dtc relocs
 
 targets		+= $(patsubst $(obj)/%,%,$(obj-boot) wrapper.a)
 extra-y		:= $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
 		   $(obj)/zImage.lds $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds
 
+ifeq ($(CONFIG_RELOCATABLE_PPC64),y)
+extra-y		+= $(obj)/vmlinux.lds
+endif
+
 dtstree		:= $(srctree)/$(src)/dts
 
 wrapper		:=$(srctree)/$(src)/wrapper
-wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree dtc) \
+wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree dtc relocs) \
 			$(wrapper) FORCE
 
+ifeq ($(CONFIG_RELOCATABLE_PPC64),y)
+
+targets +=  vmlinux.offsets vmlinux.bin vmlinux.bin.all vmlinux.reloc.elf vmlinux.reloc reloc_apply.o vmlinux.lds
+
+OBJCOPYFLAGS_vmlinux.bin :=  -O binary -R .note -R .comment -S
+$(obj)/vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
+
+quiet_cmd_relocbin = BUILD   $@
+      cmd_relocbin = cat $(filter-out FORCE,$^) > $@
+
+quiet_cmd_relocs = RELOCS   $@
+    cmd_relocs = $(obj)/relocs $< > $@
+
+$(obj)/vmlinux.offsets: vmlinux $(obj)/relocs FORCE
+	$(call if_changed,relocs)
+
+$(obj)/vmlinux.bin.all: $(obj)/vmlinux.bin $(obj)/vmlinux.offsets FORCE
+	$(call if_changed,relocbin)
+
+LDFLAGS_vmlinux.reloc.elf := -T $(obj)/vmlinux.reloc.scr -r --format binary --oformat elf64-powerpc
+$(obj)/vmlinux.reloc.elf: $(obj)/vmlinux.bin.all FORCE
+	$(call if_changed,ld)
+
+LDFLAGS_vmlinux.reloc := -T $(obj)/vmlinux.lds
+$(obj)/vmlinux.reloc: $(obj)/reloc_apply.o $(obj)/vmlinux.reloc.elf FORCE
+	$(call if_changed,ld)
+endif
+
 #############
 # Bits for building dtc
 # DTC_GENPARSER      := 1    # Uncomment to rebuild flex/bison output
diff --git a/arch/powerpc/boot/vmlinux.lds.S b/arch/powerpc/boot/vmlinux.lds.S
new file mode 100644
index 0000000..245c667
--- /dev/null
+++ b/arch/powerpc/boot/vmlinux.lds.S
@@ -0,0 +1,28 @@
+#include <asm/page.h>
+#include <asm-generic/vmlinux.lds.h>
+
+ENTRY(start_wrap)
+
+OUTPUT_ARCH(powerpc:common64)
+SECTIONS
+{
+	. = KERNELBASE;
+
+/*
+ * Text, read only data and other permanent read-only sections
+ */
+	/* Text and gots */
+	.text : {
+		_head = .;
+		*(.text.head)
+		_ehead = .;
+
+		_text = .;
+		*(.vmlinux)
+		_etext = .;
+
+		_reloc = .;
+		*(.text.reloc)
+		_ereloc = .;
+	}
+}
diff --git a/arch/powerpc/boot/vmlinux.reloc.scr b/arch/powerpc/boot/vmlinux.reloc.scr
new file mode 100644
index 0000000..7240b6b
--- /dev/null
+++ b/arch/powerpc/boot/vmlinux.reloc.scr
@@ -0,0 +1,8 @@
+SECTIONS
+{
+  .vmlinux : {
+	input_len = .;
+	*(.data)
+	output_len = . - 8;
+	}
+}
-- 
1.5.4
