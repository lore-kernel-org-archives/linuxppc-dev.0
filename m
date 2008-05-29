Return-Path: <mohan@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 02F37DE565
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 05:15:28 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4TJFNqr011842
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 15:15:23 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4TJF9IT057378
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 13:15:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4TJF5e0030961
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 13:15:05 -0600
Date: Fri, 30 May 2008 00:45:03 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [RFC PATCH 2/4] Build files needed for relocation support
Message-ID: <20080529191503.GB15762@in.ibm.com>
References: <20080529190809.GA15388@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080529190809.GA15388@in.ibm.com>
Cc: paulus@samba.org
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

File make.reloc is used to build the relocatable kernel "vmlinux.reloc".

TODO:
I have not yet integrated building relocatable kernel with kernel
Makefile. I need help to integrate this into kernel build process.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
Index: linux-2.6.26-rc3/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/Kconfig
+++ linux-2.6.26-rc3/arch/powerpc/Kconfig
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
@@ -656,7 +665,7 @@ config LOWMEM_SIZE
 	default "0x30000000"
 
 config RELOCATABLE
-	bool "Build a relocatable kernel (EXPERIMENTAL)"
+	bool "Build relocatable kernel (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && FSL_BOOKE
 	help
 	  This builds a kernel image that is capable of running at the
@@ -776,11 +785,11 @@ config PAGE_OFFSET
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
 
Index: linux-2.6.26-rc3/arch/powerpc/Makefile
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/Makefile
+++ linux-2.6.26-rc3/arch/powerpc/Makefile
@@ -69,7 +69,7 @@ override CC	+= -m$(CONFIG_WORD_SIZE)
 override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-powerpc $(AR)
 endif
 
-LDFLAGS_vmlinux	:= -Bstatic
+LDFLAGS_vmlinux	:= --emit-relocs
 
 CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none  -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 -mmultiple
Index: linux-2.6.26-rc3/arch/powerpc/vmlinux.reloc.lds.S
===================================================================
--- /dev/null
+++ linux-2.6.26-rc3/arch/powerpc/vmlinux.reloc.lds.S
@@ -0,0 +1,29 @@
+#include <asm/page.h>
+#include <asm-generic/vmlinux.lds.h>
+
+ENTRY(start_wrap)
+
+OUTPUT_ARCH(powerpc:common)
+/* OUTPUT_ARCH(elf64ppc) */
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
Index: linux-2.6.26-rc3/arch/powerpc/vmlinux.reloc.scr
===================================================================
--- /dev/null
+++ linux-2.6.26-rc3/arch/powerpc/vmlinux.reloc.scr
@@ -0,0 +1,8 @@
+SECTIONS
+{
+  .vmlinux : {
+	input_len = .;
+	*(.data)
+	output_len = . - 8;
+	}
+}
Index: linux-2.6.26-rc3/make.reloc
===================================================================
--- /dev/null
+++ linux-2.6.26-rc3/make.reloc
@@ -0,0 +1,35 @@
+#Makefile for building vmlinux with relocatable information and code.
+
+all: vmlinux.reloc
+
+obj 	:= arch/powerpc
+
+AS	= as
+LD	= ld
+CC	= gcc
+CPP	= $(CC) -E
+
+
+$(obj)/relocs : $(obj)/relocs.c
+	$(CC) $(obj)/relocs.c -o $(obj)/relocs
+
+$(obj)/vmlinux.reloc.bin : vmlinux $(obj)/relocs
+	$(obj)/relocs vmlinux > $(obj)/vmlinux.reloc.bin 2>/dev/null
+
+$(obj)/vmlinux.bin: vmlinux
+	objcopy -O binary -R .note -R .comment -S vmlinux $(obj)/vmlinux.bin
+
+$(obj)/vmlinux.bin.all : $(obj)/vmlinux.bin $(obj)/vmlinux.reloc.bin
+	cat $(obj)/vmlinux.bin $(obj)/vmlinux.reloc.bin > $(obj)/vmlinux.bin.all
+
+$(obj)/vmlinux.new : $(obj)/vmlinux.reloc.scr $(obj)/vmlinux.bin.all
+	$(LD) -m elf64ppc -r --format binary --oformat elf64-powerpc -T $(obj)/vmlinux.reloc.scr $(obj)/vmlinux.bin.all -o $(obj)/vmlinux.new
+
+$(obj)/kernel/reloc_apply.o : $(obj)/kernel/reloc_apply.S
+	$(CC) -m64 -Wp,-MD,arch/powerpc/kernel/.reloc_apply.o.d  -nostdinc -isystem /usr/lib/gcc/powerpc64-suse-linux/4.1.2/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h  -D__ASSEMBLY__  -Wa,-maltivec     -c -o arch/powerpc/kernel/reloc_apply.o arch/powerpc/kernel/reloc_apply.S
+
+$(obj)/vmlinux.reloc.lds : $(obj)/vmlinux.reloc.lds.S
+	$(CC) -m64 -E -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Os -msoft-float -pipe -mminimal-toc -mtraceback=none  -mcall-aixdesc -mtune=power4 -mno-altivec -mno-spe -funit-at-a-time -mno-string -Wa,-maltivec -fomit-frame-pointer  -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign -Wp,-MD,arch/powerpc/.vmlinux.reloc.lds.d  -nostdinc -isystem /usr/lib/gcc/powerpc64-suse-linux/4.1.2/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h    -Upowerpc -P -C -Upowerpc -D__ASSEMBLY__ -o arch/powerpc/vmlinux.reloc.lds arch/powerpc/vmlinux.reloc.lds.S
+
+vmlinux.reloc : $(obj)/vmlinux.reloc.lds $(obj)/vmlinux.new $(obj)/kernel/reloc_apply.o
+	$(LD) -m elf64ppc -T $(obj)/vmlinux.reloc.lds $(obj)/vmlinux.new $(obj)/kernel/reloc_apply.o -o vmlinux.reloc
