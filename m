Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 11/16] zImage wrapper for Ebony
In-Reply-To: <20070213060904.GA6214@localhost.localdomain>
Message-Id: <20070213061025.6EB43DDD0C@ozlabs.org>
Date: Tue, 13 Feb 2007 17:10:25 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for building a zImage wrapper suitable for the
Ebony (440GP) evaluation board.  This supports booting both from uboot
(old versions which don't supply a flattened device tree) and IBM
Openbios (aka "treeboot").

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/boot/Makefile |   33 ++++++++++++++++++++++++++++++++-
 arch/powerpc/boot/ebony.c  |   43 +++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/mktree.c |   10 ++++------
 arch/powerpc/boot/wrapper  |   33 +++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 7 deletions(-)

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-02-12 14:22:17.000000000 +1100
+++ working-2.6/arch/powerpc/boot/Makefile	2007-02-12 14:22:17.000000000 +1100
@@ -42,7 +42,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 
 src-wlib := string.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S bss_stack.S $(zlib)
-src-plat := of.c
+src-plat := of.c ebony.c
 src-boot := crt0.S $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -94,6 +94,12 @@ $(patsubst %.S,%.o, $(filter %.S, $(src-
 $(obj)/wrapper.a: $(obj-wlib)
 	$(call cmd,bootar)
 
+quiet_cmd_dtc = DTC     $@
+      cmd_dtc = $(dtc) -O dtb -o $@ -b 0 -V 16 $<
+
+$(obj)/%.dtb: $(srctree)/$(src)/dts/%.dts
+	$(call if_changed,dtc)
+
 hostprogs-y	:= addnote addRamDisk hack-coff mktree
 
 extra-y		:= $(obj)/crt0.o $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
@@ -102,6 +108,8 @@ extra-y		:= $(obj)/crt0.o $(obj)/wrapper
 wrapper		:=$(srctree)/$(src)/wrapper
 wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree)
 
+dtc		:= dtc
+
 #############
 # Bits for building various flavours of zImage
 
@@ -119,6 +127,13 @@ quiet_cmd_wrap_initrd = WRAP    $@
       cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
 				-i $(obj)/ramdisk.image.gz vmlinux
 
+quiet_cmd_wrap_dtb	= WRAP    $@
+      cmd_wrap_dtb	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+				-d $3 vmlinux
+quiet_cmd_wrap_dtb_initrd = WRAP    $@
+      cmd_wrap_dtb_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+				-d $3 -i $(obj)/ramdisk.image.gz vmlinux
+
 $(obj)/zImage.chrp: vmlinux $(wrapperbits)
 	$(call cmd,wrap,chrp)
 
@@ -155,6 +170,21 @@ $(obj)/zImage.ps3: vmlinux
 $(obj)/zImage.initrd.ps3: vmlinux
 	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
 
+$(obj)/zImage.ebony-elf: vmlinux $(wrapperbits) $(obj)/ebony.dtb
+	$(call cmd,wrap_dtb,ebony,$(obj)/ebony.dtb)
+
+$(obj)/zImage.initrd.ebony-elf: vmlinux $(wrapperbits) $(obj)/ebony.dtb $(obj)/ramdisk.image.gz
+	$(call cmd,wrap_dtb_initrd,ebony,$(obj)/ebony.dtb)
+
+$(obj)/zImage.ebony: vmlinux $(wrapperbits) $(obj)/ebony.dtb $(obj)/mktree
+	$(call cmd,wrap_dtb,ebony-tree,$(obj)/ebony.dtb)
+
+$(obj)/zImage.initrd.ebony: vmlinux $(wrapperbits) $(obj)/ebony.dtb $(obj)/mktree
+	$(call cmd,wrap_dtb_initrd,ebony-tree,$(obj)/ebony.dtb)
+
+$(obj)/uImage.ebony: vmlinux $(wrapperbits)  $(obj)/ebony.dtb
+	$(call cmd,wrap_dtb,ebony-uboot,$(obj)/ebony.dtb)
+
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call cmd,wrap,uboot)
 
@@ -166,6 +196,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.ps
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
+image-$(CONFIG_EBONY)			+= zImage.ebony-elf zImage.ebony uImage.ebony
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
 # For 32-bit powermacs, build the COFF and miboot images
Index: working-2.6/arch/powerpc/boot/ebony.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/ebony.c	2007-02-12 14:22:17.000000000 +1100
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "elf.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+
+extern char _start[];
+extern char _end[];
+
+USE_BSS_STACK;
+
+static unsigned long ebony_vmlinux_addr(unsigned long size)
+{
+	if ((unsigned long)_start < size) {
+		printf("Insufficient memory for kernel at address 0! (_start=%lx)\n\r",
+		       _start);
+		exit();
+	}
+	return 0;
+}
+
+int platform_init(void *promptr, char *dt_blob_start, char *dt_blob_end)
+{
+	u32 heapsize = 0x8000000 - (u32)_end; /* 128M */
+
+	simple_alloc_init(_end, heapsize, 32, 64);
+	ft_init(dt_blob_start, 0, 4);
+	serial_console_init();
+	platform_ops.vmlinux_addr = ebony_vmlinux_addr;
+
+	return 0;
+}
Index: working-2.6/arch/powerpc/boot/wrapper
===================================================================
--- working-2.6.orig/arch/powerpc/boot/wrapper	2007-01-24 12:01:17.000000000 +1100
+++ working-2.6/arch/powerpc/boot/wrapper	2007-02-12 14:22:17.000000000 +1100
@@ -137,6 +137,12 @@ miboot|uboot)
     ksection=image
     isection=initrd
     ;;
+*-tree)
+    platformo=$object/"${platform%%-tree}".o
+    ;;
+*-uboot)
+    platformo=$object/"${platform%%-uboot}".o
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
@@ -204,4 +210,31 @@ pmaccoff)
     ${CROSS}objcopy -O aixcoff-rs6000 --set-start 0x500000 "$ofile"
     $object/hack-coff "$ofile"
     ;;
+*-tree)
+    mv "$ofile" "$ofile.elf"
+    entry=`objdump -f "$ofile.elf" | grep '^start address ' | \
+	cut -d' ' -f3`
+    $object/mktree "$ofile.elf" "$ofile" 0x00400000 "$entry"
+    if [ -z "$cacheit" ]; then
+	rm -f "$ofile.elf"
+    fi
+    exit 0
+    ;;
+*-uboot)
+    mv "$ofile" "$ofile.elf"
+    version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
+	cut -d' ' -f3`
+    if [ -n "$version" ]; then
+	version="-n Linux-$version"
+    fi
+    entry=`objdump -f "$ofile.elf" | grep '^start address ' | \
+	cut -d' ' -f3`
+    ${CROSS}objcopy -O binary "$ofile.elf" "$ofile.bin"
+    mkimage -A ppc -O linux -T kernel -C none -a 0x00400000 -e $entry \
+	$version -d "$ofile.bin" "$ofile"
+    if [ -z "$cacheit" ]; then
+	rm -f "$ofile.elf" "$ofile.bin"
+    fi
+    exit 0
+    ;;
 esac
Index: working-2.6/arch/powerpc/boot/mktree.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/mktree.c	2007-01-24 12:01:17.000000000 +1100
+++ working-2.6/arch/powerpc/boot/mktree.c	2007-02-12 14:22:17.000000000 +1100
@@ -46,8 +46,8 @@ int main(int argc, char *argv[])
 	struct	stat	st;
 	boot_block_t	bt;
 
-	if (argc < 3) {
-		fprintf(stderr, "usage: %s <zImage-file> <boot-image> [entry-point]\n",argv[0]);
+	if (argc < 5) {
+		fprintf(stderr, "usage: %s <zImage-file> <boot-image> <load address> <entry point>\n",argv[0]);
 		exit(1);
 	}
 
@@ -61,10 +61,8 @@ int main(int argc, char *argv[])
 	bt.bb_magic = htonl(0x0052504F);
 
 	/* If we have the optional entry point parameter, use it */
-	if (argc == 4)
-		bt.bb_dest = bt.bb_entry_point = htonl(strtoul(argv[3], NULL, 0));
-	else
-		bt.bb_dest = bt.bb_entry_point = htonl(0x500000);
+	bt.bb_dest = htonl(strtoul(argv[3], NULL, 0));
+	bt.bb_entry_point = htonl(strtoul(argv[4], NULL, 0));
 
 	/* We know these from the linker command.
 	 * ...and then move it up into memory a little more so the
