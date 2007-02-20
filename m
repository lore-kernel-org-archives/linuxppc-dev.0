Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 8/14] zImage wrapper for Ebony
In-Reply-To: <20070220020837.GF17818@localhost.localdomain>
Message-Id: <20070220021235.406E0DDD09@ozlabs.org>
Date: Tue, 20 Feb 2007 13:12:35 +1100 (EST)
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
 arch/powerpc/boot/ebony.c  |   32 ++++++++++++++++++++++++++++++++
 arch/powerpc/boot/mktree.c |   10 ++++------
 arch/powerpc/boot/wrapper  |   33 +++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 7 deletions(-)

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-02-16 15:12:06.000000000 +1100
+++ working-2.6/arch/powerpc/boot/Makefile	2007-02-16 15:13:40.000000000 +1100
@@ -43,7 +43,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c $(zlib)
-src-plat := of.c
+src-plat := of.c ebony.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -95,6 +95,12 @@ $(patsubst %.S,%.o, $(filter %.S, $(src-
 $(obj)/wrapper.a: $(obj-wlib)
 	$(call cmd,bootar)
 
+quiet_cmd_dtc = DTC     $@
+      cmd_dtc = $(dtc) -O dtb -o $@ -b 0 -V 16 $<
+
+$(obj)/%.dtb: $(srctree)/$(src)/dts/%.dts
+	$(call if_changed,dtc)
+
 hostprogs-y	:= addnote addRamDisk hack-coff mktree
 
 extra-y		:= $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
@@ -103,6 +109,8 @@ extra-y		:= $(obj)/wrapper.a $(obj-plat)
 wrapper		:=$(srctree)/$(src)/wrapper
 wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree)
 
+dtc		:= dtc
+
 #############
 # Bits for building various flavours of zImage
 
@@ -120,6 +128,13 @@ quiet_cmd_wrap_initrd = WRAP    $@
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
 
@@ -156,6 +171,21 @@ $(obj)/zImage.ps3: vmlinux
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
 
@@ -167,6 +197,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.ps
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
+image-$(CONFIG_EBONY)			+= zImage.ebony-elf zImage.ebony uImage.ebony
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
 # For 32-bit powermacs, build the COFF and miboot images
Index: working-2.6/arch/powerpc/boot/ebony.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/ebony.c	2007-02-16 15:13:40.000000000 +1100
@@ -0,0 +1,32 @@
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
+extern char _dtb_start[];
+extern char _dtb_end[];
+
+BSS_STACK(4096);
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
+{
+	u32 heapsize = 0x8000000 - (u32)_end; /* 128M */
+
+	simple_alloc_init(_end, heapsize, 32, 64);
+	ft_init(_dtb_start, 0, 4);
+	serial_console_init();
+}
Index: working-2.6/arch/powerpc/boot/wrapper
===================================================================
--- working-2.6.orig/arch/powerpc/boot/wrapper	2007-02-16 15:13:36.000000000 +1100
+++ working-2.6/arch/powerpc/boot/wrapper	2007-02-16 15:13:40.000000000 +1100
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
@@ -206,4 +212,31 @@ pmaccoff)
     ${CROSS}objcopy -O aixcoff-rs6000 --set-start "$entry" "$ofile"
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
--- working-2.6.orig/arch/powerpc/boot/mktree.c	2007-02-16 15:12:06.000000000 +1100
+++ working-2.6/arch/powerpc/boot/mktree.c	2007-02-16 15:13:40.000000000 +1100
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
