Return-Path: <mohan@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DC4D9DE2A4
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 05:20:19 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6LJKG4H014231
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 15:20:16 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6LJKGpN223928
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 15:20:16 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6LJKF1Y003785
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 15:20:16 -0400
Message-ID: <4884E168.6070404@in.ibm.com>
Date: Tue, 22 Jul 2008 00:50:08 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC v3 PATCH 2/4] Build files needed for relocation
References: <20080717183339.GA25070@in.ibm.com>
	<20080717184055.GB25070@in.ibm.com>
	<1216325187.7740.353.camel@pasglop> <48802AE0.30105@in.ibm.com>
	<d8d07a180aaf59d25936ad03c7287f5a@bga.com>
In-Reply-To: <d8d07a180aaf59d25936ad03c7287f5a@bga.com>
Content-Type: multipart/mixed; boundary="------------020305010203080802050600"
Cc: paulus@samba.org, naren@linux.vnet.ibm.com,
	ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020305010203080802050600
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit



--------------020305010203080802050600
Content-Type: text/x-patch;
 name="0002-Build-files-needed-for-relocation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-Build-files-needed-for-relocation.patch"

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
index f2a0f50..366a622 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -317,6 +317,15 @@ config CRASH_DUMP
 
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
@@ -662,7 +671,7 @@ config LOWMEM_SIZE
 	default "0x30000000"
 
 config RELOCATABLE
-	bool "Build a relocatable kernel (EXPERIMENTAL)"
+	bool "Build relocatable kernel (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && FSL_BOOKE
 	help
 	  This builds a kernel image that is capable of running at the
@@ -782,11 +791,11 @@ config PAGE_OFFSET
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
index 59ae7d9..58ccb7f 100644
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
index 751a6e6..1a62036 100644
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


--------------020305010203080802050600--
